Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5A2BCF4C;
	Wed,  1 Jul 2026 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919677; cv=none; b=bDM5ctf4NSVLaUHDj6ScyqlsG3QOap1ZTr7ZTojWmVsBus2JUWRWZ03lvQlBoUoy/rCiUnDUW1z9Mqd1ydpnQbfoVKo0pOOuW6xAlbGf7DqlCdsd99DSYZJjxTObt+nLWNsF4ECv3zVwDE4caftojjO8jlrgPeEJCm8Sh4BP9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919677; c=relaxed/simple;
	bh=BIks32NyeNYiR1vXtphC6SFmZlzo8SAFZrDa4IRWaPY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MRoAYMlksrzeUqE+M7WKiA+zwjibRPmWqPVYFT6UQvFx02oA+//zRSIbYHK9HAY/fpZEDAJM1PKJwgrL7Fjh3lAN6R6U+/pEg2oDlMRN7jx1AYcZIn/SI3Tks3WtmGmPg6NJi7MPMvREbDYhbkLqWPH30/p/zy1IJiTZZuRjAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=QP2XmeYD; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="QP2XmeYD"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 44856e38e;
	Wed, 1 Jul 2026 23:22:41 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: David Heidelberg <david@ixit.cz>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH net v2] nfc: st-nci: align frame buffers for typed length load
Date: Wed,  1 Jul 2026 23:22:32 +0800
Message-Id: <20260701152232.1472647-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f1e46732803a1kunm8b5db53e1a2a64
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSRkYVkIYSx5KTxhITxkfS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QP2XmeYDJgnWgqBzc5kCO7Xl4AovQf+/9bNLy/bD/rdZNb4KmkNGegZQIw/LbgSSv87hlgMdzBrCr+oYqsMXHu2A647YNe7z8HE2tOh73I3JYzmrCdXgQY/8cU8MmeWCVpX5S8lcGXONHafTT9dbUXcq9SBaHv4+bwcmZuqoRts=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=kgAf2jenqnAj58cSiKRQgakUcXefBmNh1nduDmw/HZQ=;
	h=date:mime-version:subject:message-id:from;

The ST NCI I2C and SPI transports parse a frame length from bytes
received from the controller. Both paths read the frame header into a
local u8 buffer and then cast buf + 2 to __be16 * before converting it
from big endian.

Align the local frame buffers to 2 bytes so that buf + 2 is also
2-byte aligned before the __be16 load. This keeps the existing parser
logic while making the alignment requirement explicit for the typed
length access.

This issue was detected by our static analysis tool and confirmed by
manual audit. UBSAN alignment validation of the same access shape,
be16_to_cpu(*(__be16 *)(buf + 2)), reports a misaligned-access load of
type '__be16' when the byte buffer does not provide that alignment.

Fixes: 35630df68d60 ("NFC: st21nfcb: Add driver for STMicroelectronics ST21NFCB NFC chip")
Fixes: 2bc4d4f8c8f3 ("nfc: st-nci: Add spi phy support for st21nfcb")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Changes in v2:
- Follow David's feedback and align the local I2C/SPI frame buffers
  instead of switching the length load to get_unaligned_be16().
- Use the original st21nfcb I2C driver commit in the I2C Fixes tag.

 drivers/nfc/st-nci/i2c.c | 2 +-
 drivers/nfc/st-nci/spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
index 9ae839a6f5cc..b7e208dd5a18 100644
--- a/drivers/nfc/st-nci/i2c.c
+++ b/drivers/nfc/st-nci/i2c.c
@@ -108,7 +108,7 @@ static int st_nci_i2c_read(struct st_nci_i2c_phy *phy,
 {
 	int r;
 	u8 len;
-	u8 buf[ST_NCI_I2C_MAX_SIZE];
+	u8 buf[ST_NCI_I2C_MAX_SIZE] __aligned(2);
 	struct i2c_client *client = phy->i2c_dev;
 
 	r = i2c_master_recv(client, buf, ST_NCI_I2C_MIN_SIZE);
diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
index 169eacc0a32a..74b4ac39f65b 100644
--- a/drivers/nfc/st-nci/spi.c
+++ b/drivers/nfc/st-nci/spi.c
@@ -119,7 +119,7 @@ static int st_nci_spi_read(struct st_nci_spi_phy *phy,
 {
 	int r;
 	u8 len;
-	u8 buf[ST_NCI_SPI_MAX_SIZE];
+	u8 buf[ST_NCI_SPI_MAX_SIZE] __aligned(2);
 	struct spi_device *dev = phy->spi_dev;
 	struct spi_transfer spi_xfer = {
 		.rx_buf = buf,
-- 
2.34.1

