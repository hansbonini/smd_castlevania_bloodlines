echo "[+] Expanding ROM...DONE!"
python ./tools/expand/main.py castlevania.md castlevania_expanded.md
mv castlevania.md castlevania_original.md
mv castlevania_expanded.md castlevania.md

bass patch.asm

echo "[+] Fixing Checksum..."
python ./tools/checksum/main.py castlevania_br.md castlevania_br_checksum.md
mv castlevania_br_checksum.md castlevania_br.md
mv castlevania_original.md castlevania.md
echo "[+] FINISH!"