import { promises as fs } from "fs";
import path from "path";

export async function getCompiledCode(filename: string) {
  const sierraFilePath = path.join(
    __dirname,
    `../target/dev/${filename}.contract_class.json`
  );
  const casmFilePath = path.join(
    __dirname,
    `../target/dev/${filename}.compiled_contract_class.json`
  );

  const code = [sierraFilePath, casmFilePath].map(async (filePath) => {
    const file = await fs.readFile(filePath);
    return JSON.parse(file.toString("ascii"));
  });

  const [sierraCode, casmCode] = await Promise.all(code);

  return {
    sierraCode,
    casmCode,
  };
}
