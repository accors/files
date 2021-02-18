#!/bin/bash
#0.删除旧的1.sh
rm /root/1.sh
rm /root/jd/scripts/jd_entertainment.js
rm /root/jd/scripts/jd_walmart.js
rm /root/jd/scripts/jd_xmf.js
# 1.拉取diy脚本和第三方活动,并重命名
wget -c https://raw.githubusercontent.com/accors/files/main/diy.sh -O /root/1.sh
wget -c https://raw.githubusercontent.com/i-chenzhe/qx/main/jd_entertainment.js -O /root/jd/scripts/jd_entertainment.js
wget -c https://raw.githubusercontent.com/i-chenzhe/qx/main/jd_walmart.js -O /root/jd/scripts/jd_walmart.js
wget -c https://raw.githubusercontent.com/i-chenzhe/qx/master/jd_xmf.js -O /root/jd/scripts/jd_xmf.js
# 2.更改diy脚本中的scripts路径，以与本地的路径相匹配
sed -i 's,${JD_DIR}/scripts/,/root/jd/scripts/,g' /root/1.sh
sed -i 's,helpAuthor = true,helpAuthor = false,g' /root/jd/scripts/*.js
# 3.删除含if/fi的行
#sed -i '/if\|fi/d' 1.sh
chmod +x /root/1.sh
exec /root/1.sh
# 没了，结束。
