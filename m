Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761635;
	b=fRSx4V1NPgsUoBVY0dKdEorfMclqaQR8cose+Ew/B2cSFn91gPNt+YAshu6BehpOHUiD
	 2kRHCagDvpEdN17mCdRNw2MAtPDYnVjyy8v4qAUoE7c6DqJITmfYX4YdjAi0M73STPlWo
	 6iX1Ilbs4GRutO+DtFe5E9KbzVQphpRqD3DCP13YaWtoKetPHyRX2BzgfGnYsdILGGh3u
	 6ihJhjSyT7SQjXr9C/ZXCKudY30aUoTalBjoBa4HNcHeQUoPWGW8L3HWNAIucjWNl9M0h
	 YYyoQ8dLHB5V81t4CL3UvQP8dAciiVpmbxkc2W/02rYcG66WgZhwgNw3wKBylaDkE4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761635;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j3izDy+wlx7B4MatbnUDUZaqK8p7FJvpC5JJ5DPcwX4=;
	b=Vn0b2Rq+zrpQg1FTP9YH8WwpIq4c8x2DGCNrz5TIrXp/r0unIdqD4T8FdYVr0KxJkApI
	 V4IxQYVMTHK8XEyQRfxO7+G1F8BsRm2JpyP0D8rupVzZJjD7hIpMcNGnrTjDwc2KjPX/z
	 Lj7KDB6ie2DU5iC6fHU7TL6nxyOLCFxhQmpdiPxNTCuERfa8lP074zcjlegljxSRrhVQv
	 i8vR2faojf6UgROjTUrh4Bgif+H6cnu7cp28dWvXzHajgcBXTGgXQM2X5AUEKXhy+Tbdy
	 cSLD+M6TYZ94z+jKq/G10yP3RMoB8zOfc+wC+vClPk7nUcK3WItg4WCPJ991yv5ibCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=nK1HxMMr;
	arc=none smtp.remote-ip=115.124.28.173
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB64D606A32C;
	Wed,  4 Nov 2026 03:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB64D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=nK1HxMMr
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793761630; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=j3izDy+wlx7B4MatbnUDUZaqK8p7FJvpC5JJ5DPcwX4=;
	b=nK1HxMMrwghqZaog48ZG/CdDGZTWlM/q+nAZ78cCpNAq0z2JM4McXkM9yreVe/QCzZHxx8/5crGP2X13DSQ9Won4/HWyHRRNPmbMlW8fOSz8tm/oSZ4iSvP20cCFH3BWZzTWZyoFQ6Wtgxhpi/91ySu1s31YSA8SwLwfE9YCouk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09883974|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00112347-0.000455029-0.998421;FP=17804760286958916722|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jwITYAQ_1793761629;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jwITYAQ_1793761629 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 11:07:10 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH v2] Input: lpc32xx-keys - reject matrices bigger than the hardware has
Date: Wed,  4 Nov 2026 11:07:09 +0800
Message-ID: <20261104030709.791761-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <auos7TgVNv7EWnbj@google.com>
References: <auos7TgVNv7EWnbj@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scanner state array holds the last state of eight matrix
columns, and the interrupt handler walks the matrix size that the
device tree declared:

	u8 lastkeystates[8];
	...
	for (i = 0; i < kscandat->matrix_sz; i++)
		lpc32xx_mod_states(kscandat, i);

The probe path only checks that rows and columns match; the
hardware supports square matrices from 1x1 up to 8x8, but nothing
stops a device tree from declaring more, which makes the state
array index run past the field into the rest of the driver data -
including the keymap pointer the same code dereferences.

Reject matrices larger than the hardware supports.

Fixes: 69690bec400e ("Input: add support for key scan interface of the LPC32xx SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v2: use LPC32XX_MAX_MATRIX_SIZE for the state array and the new
    check instead of a literal 8, per review.

 drivers/input/keyboard/lpc32xx-keys.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index 2392e7e..429a3eb 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -65,7 +65,7 @@ struct lpc32xx_kscan_drv {
 	unsigned int row_shift;
 	unsigned short *keymap;	/* Pointer to key map for the scan matrix */
 
-	u8 lastkeystates[8];
+	u8 lastkeystates[LPC32XX_MAX_MATRIX_SIZE];
 };
 
 static void lpc32xx_mod_states(struct lpc32xx_kscan_drv *kscandat, int col)
@@ -141,6 +141,12 @@ static int lpc32xx_parse_dt(struct device *dev,
 		dev_err(dev, "rows and columns must be equal!\n");
 		return -EINVAL;
 	}
+	if (rows > LPC32XX_MAX_MATRIX_SIZE) {
+		dev_err(dev, "rows and columns must be at most %d!\n",
+			LPC32XX_MAX_MATRIX_SIZE);
+		return -EINVAL;
+	}
+
 
 	kscandat->matrix_sz = rows;
 	kscandat->row_shift = get_count_order(columns);
-- 
2.43.0

