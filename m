Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048194;
	b=28XWvJYsPwycsnajDkjR9FVoD3MJWVEYf2WMXlxmx8klUHESkeCjQMxR3fGqnlQvjDfM
	 q2wllKPBuZB7KME6AZxVTzSj8crc27cFJNnK5kZKRfEgN7lwg545m3iBH31F3N9gGgHXZ
	 WqbjEKZFpjV2ggfPpNe7iGnYiLPSAC2brfTnuzKCCxniER1ZjcAtvCgd16xOwQ6zrCZgX
	 EcbVX5RJ6mm+TAoFfuGm+UFnwbdWwV6uGRdPSaqsxYtmzOCrOBqCw6KAcAQHhrb1kobH9
	 WQhLW/h7+4C6FVcHXJRpjJhWqptGFDivCGJy8sp4OlIVpPECbaoBxskJ2QkgJNEAQeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048194;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cTjCzvI3Sw+Yh238Jcr/9qJT3Bc/1XrBj4NiDRtfRM0=;
	b=zwHQ9cVfZR5YjkjOgGXu4ZsRgQsGtILga0gWTuKbYIaOjcWj/ZUngp2IeW97Fye4K5E1
	 2/79UI8HY/JN4f3Z5hoC/z+BWvvTDOi5OM+ORU+Ud7yY6Fnz3HzPhEQjwrCBEOmdpSHpA
	 4pUrqBzj0WU3Xv2p8Dn+D5X5F5RLT7OS0xNGkh+g7vLKiuFKeO9gmPePybb3txt9vABbS
	 /XcbsmSNFVRQl3S9C2k2Yq3R/JpXVIF3sup61ndHwdxlfm/D8G6r8uRXOPx2XanWlcksF
	 Y101q3+jV77ZBlpQQ2n2cY42478WiO40hiFRexR31yPiI2Bi+oQRBPCzYw7cvGp1v8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBCsV0DN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB5606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBCsV0DN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4800D1F0089F;
	Sat,  7 Nov 2026 10:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048193;
	bh=cTjCzvI3Sw+Yh238Jcr/9qJT3Bc/1XrBj4NiDRtfRM0=;
	h=From:To:Cc:Subject:Date;
	b=VBCsV0DNeOrkHbxlZ6cYvwSCbG+VXPxU4zkrUQ91t5JHRN/qpnf28BdxNlFZlCRrd
	 aIojWz6i6Ay6/mruqXtO21HmtdPGxHCrau4K/AnCZpwA4yT4wNPUZIhBxAW8l9Ndlp
	 5QTllEdBCuo10NxN/XgBE/z340II5TjGcJPOVqm/lkhladcTpwObxIBX/+P79EUXfW
	 HN5clPO4N/PaaeMMB68GGH7A1XFqucQnBAsBMStQ9fbwCGFV7u6R7Al8NBkQ0uLV7l
	 np6WeNN+GVBouAMqJjAOYIPOmx68IfU0ZCcp3E6KnCmVMGFD3fxr3vkUF0Gj0RHGjw
	 xLPhJ2H1hpd9Q==
From: Sasha Levin <sashal@kernel.org>
To: zoone.rupert@gmail.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: pressure: dps310: fix CFG_REG bit definitions" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:12 -0500
Message-ID: <20261107054312-failed-6.1-4334dc4092c2@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4334dc4092c271e6cd010c2ee70b7f4415c4c199
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054312-failed-6.1-4334dc4092c2@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4334dc4092c271e6cd010c2ee70b7f4415c4c199 Mon Sep 17 00:00:00 2001
From: Rupesh Majhi <zoone.rupert@gmail.com>
Date: Mon, 21 Sep 2026 21:31:23 +0300
Subject: [PATCH] iio: pressure: dps310: fix CFG_REG bit definitions

Driver defines them as BIT(4), BIT(5) and BIT(6). Per datasheet P_SHIFT
is bit 2, FIFO_EN is bit 1 and SPI_MODE is bit 0.

Only P_SHIFT has a user. dps310_set_pres_precision() sets it at
oversampling 16 or above, so with wrong bit the result register is never
shifted and stops matching the scale factor compensation divides by.
in_pressure_input returns -ERANGE at oversampling 16, 32 and 64.

FIFO_EN needed by FIFO support later in this series.

Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/pressure/dps310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 45bdb8c7670f0..35260b3993903 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -50,9 +50,9 @@
 #define DPS310_CFG_REG		0x09
 #define  DPS310_INT_HL		BIT(7)
 #define  DPS310_TMP_SHIFT_EN	BIT(3)
-#define  DPS310_PRS_SHIFT_EN	BIT(4)
-#define  DPS310_FIFO_EN		BIT(5)
-#define  DPS310_SPI_EN		BIT(6)
+#define  DPS310_PRS_SHIFT_EN	BIT(2)
+#define  DPS310_FIFO_EN		BIT(1)
+#define  DPS310_SPI_EN		BIT(0)
 #define DPS310_RESET		0x0c
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
-- 
2.53.0




