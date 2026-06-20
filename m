Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1431A268;
	Sat, 20 Jun 2026 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781946667; cv=none; b=U+6lOnpcO+1OAQDfB0y0+LxMPP0We5kj8WCX9dz7BY57omBl6zzIQ/8yqQyRTWrC+dErBeF0RmkH5KXZ3q0nOQBC3fgFL4OOKRdnslfgxfS+oID7jeDAtchL6oMjhlBBddT3XutNOaPQ1wSpiPNlzKEK2ugFMjyxTDwD2ZUv1GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781946667; c=relaxed/simple;
	bh=tHv9uXgs8Y2ZcpWUi5IFXv5XMWxzogokL2cxQdnBhIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sT0XZSkw7M2MPBrOKZuCZo4ppnsPLKivfknP3cVvMaMTkKdNWDjwNw8Hokj+BSLExYK5zU28h+N4cvMy3XFXST+QJxxFquhfsDPMv2ysvmfB2tfUxgb2ajWDi5UjJby1AsY/YdVTnGeM0rqS+ii8HMLA34ODHFboJJy7tCF8sz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=cdIbTquB; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="cdIbTquB"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43192ac9f;
	Sat, 20 Jun 2026 17:05:42 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	netdev@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	linux-kernel@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: st-nci: use unaligned accessors for frame length
Date: Sat, 20 Jun 2026 17:05:36 +0800
Message-Id: <20260620090536.1701282-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ee4475c3d03a1kunm0d8c5fb9f19e0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTE4dVhlDQk5KSkpKGR4aT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=cdIbTquBfendraRqFe4krLhMJYVJydU+r1Kd566vsPhd/DQNK1Za+RYsaFrpDdr9n8J1J/IEJBniLeXFz93QPxDw/4tEZYWiOsjMW6/AgBW8YKnKyiKzrnXoT9uoh1SWL64gA/PlIPA7Q8T/2kF7aJqN8USgCWYB2x0jXUyjQRs=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=sOZTNnYn6KwP5i+b2wq9J349cElhRcEW7KAkjje6FuU=;
	h=date:mime-version:subject:message-id:from;

The ST NCI I2C and SPI transports parse a frame length from bytes
received from the controller. Both paths first read the frame header into
a local u8 buffer and then cast buf + 2 to __be16 * before converting it
from big endian.

These are transport byte buffers, not __be16 objects. Use
get_unaligned_be16() for the NCI frame length field in both the I2C and
SPI transports.

This issue was detected by our static analysis tool and confirmed by
manual audit. A focused UBSAN alignment validation kept the original
access shape, be16_to_cpu(*(__be16 *)(buf + 2)), and ran it on an NCI
frame byte buffer with buf + 2 at an odd address. UBSAN reported a
misaligned-access load of type '__be16', and the trace contained
st_nci_i2c_read().

The driver has the same source-level issue: the transport helpers fill
u8 buffers, and the length checks only prove that the bytes are present.
They do not establish a __be16 object at buf + 2 or a 2-byte alignment
guarantee before the typed load.

Fixes: ed06aeefdac3 ("nfc: st-nci: Rename st21nfcb to st-nci")
Fixes: 2bc4d4f8c8f3 ("nfc: st-nci: Add spi phy support for st21nfcb")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nfc/st-nci/i2c.c | 3 ++-
 drivers/nfc/st-nci/spi.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
index 9ae839a6f5cc..29fdb4ae56e0 100644
--- a/drivers/nfc/st-nci/i2c.c
+++ b/drivers/nfc/st-nci/i2c.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/nfc.h>
 #include <linux/of.h>
+#include <linux/unaligned.h>
 
 #include "st-nci.h"
 
@@ -120,7 +121,7 @@ static int st_nci_i2c_read(struct st_nci_i2c_phy *phy,
 	if (r != ST_NCI_I2C_MIN_SIZE)
 		return -EREMOTEIO;
 
-	len = be16_to_cpu(*(__be16 *) (buf + 2));
+	len = get_unaligned_be16(buf + 2);
 	if (len > ST_NCI_I2C_MAX_SIZE) {
 		nfc_err(&client->dev, "invalid frame len\n");
 		return -EBADMSG;
diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
index 169eacc0a32a..1326c20e43fc 100644
--- a/drivers/nfc/st-nci/spi.c
+++ b/drivers/nfc/st-nci/spi.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/nfc.h>
 #include <linux/of.h>
+#include <linux/unaligned.h>
 #include <net/nfc/nci.h>
 
 #include "st-nci.h"
@@ -130,7 +131,7 @@ static int st_nci_spi_read(struct st_nci_spi_phy *phy,
 	if (r < 0)
 		return -EREMOTEIO;
 
-	len = be16_to_cpu(*(__be16 *) (buf + 2));
+	len = get_unaligned_be16(buf + 2);
 	if (len > ST_NCI_SPI_MAX_SIZE) {
 		nfc_err(&dev->dev, "invalid frame len\n");
 		phy->ndlc->hard_fault = 1;
-- 
2.34.1

