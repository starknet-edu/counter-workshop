import { promises as fs } from "fs";
import path from "path";

export async function getCompiledCode(filename: string) {
  const sierraFilePath = path.join(__dirname, `../workshop/target/dev/${filename}.contract_class.json`);
  const casmFilePath = path.join(__dirname, `../workshop/target/dev/${filename}.compiled_contract_class.json`);

  console.log("Sierra File Path:", sierraFilePath);
  console.log("CASM File Path:", casmFilePath);

  try {
    const [sierraCode, casmCode] = await Promise.all(
      [sierraFilePath, casmFilePath].map(async (filePath) => {
        const file = await fs.readFile(filePath, "utf8");
        return JSON.parse(file);
      })
    );
    
    return { sierraCode, casmCode };
  } catch (error) {
    console.error("Error reading contract files:", error);
    throw new Error(`Failed to read compiled contract files for ${filename}`);
  }
}
