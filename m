Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050251;
	b=h9EqtESQg7JE4tpV8lXa0o+uaXj5tOi0z+YKHyWZodWyvBh+/8g/ZeTh8Mvpje6/uMzR
	 WQvx8quQDXitmLGMcFTdpZTiTn/PKp+gaXCWJcbzCBZi0RpNVgivGbuAkNraaJ070ChYX
	 0ZU/Ra3pIqpego4PnhsWQPSgQAQkI9v0ZlFuZM+Ejtfcbf28bWSbB7hfkdxH6Gq4jVxXs
	 75JIP9jp5AMRNK8m8dQMPDo31wAVi4pwuFZYIjeDQeMeSSUDrhsGA5EbObQSdCF9AFeG3
	 cn8ge0EjB+P1YMlzRGvyhTALHoLsg92/b2YiviDgHg3kCJKLNT/O033J8QQkKCAsjQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050251;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aYuN9IWltrsTibOmVnqcfT2OVtF1hCxct1aK+aTcbSw=;
	b=pZLQSGn8lehyxz9j6XL33yO6No1ZKYRRECz3JLFO86rbRtuFKuTnz+LZcQMasimu2HB1
	 MIVEnAobBSGkLvKRmf2TL3+PgnO3B9sgufUKwzE9BxPcgXirwW1wc5sBDrlajhXOv2OBn
	 b5pBw2/dI2q9TKHON4S57vl8L0hWxBTtuBkFLhaDvYTQiAQrghpadAKT9zavZsQCJn2gd
	 eLjuZhsxr6GRbnckFjoFjgBikblCFt58gEkp8o5WxaZnj2sUMM0/erJD5Z6uxFmO1PRlu
	 DwhFLVuusj/Sug+pEZRfpxDzahBeycj+YB1TmkgvOy/r+KXKl5ohqUrwWpj/EU41qGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dc/uS7IO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEAE606A33F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dc/uS7IO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABF91F008A1;
	Sat,  7 Nov 2026 11:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050250;
	bh=aYuN9IWltrsTibOmVnqcfT2OVtF1hCxct1aK+aTcbSw=;
	h=From:To:Cc:Subject:Date;
	b=dc/uS7IOjHlDI5Jt+arPIonXHLI5jSvMSZkkywXcUqQV8SMEuoqZUDLKLlf53REdq
	 2L7TbxSdZbk2wi5M6bZA9NDVjVcIqvQi/ctKV3BXP2AyqP7mO9HYlrlhAbth70850X
	 pBjoR+RI4kKH+LhdT7KyExD5qaiYyxFtGCWQHIiLFRO3o5XE80iZ58MXPwrtE0OGEU
	 OQ2uhkEoc7RUD/pS1SV+l1h0Wp3M8sAubef58OTzaW0XNFDkfeW0hhncl18+qkvwKm
	 C4+WFTItlmjwO3YzLVeROcXn2EFZ4o2lqUwZW1MHCue8qkA2PB5aFwNPR0sI9TfQ7w
	 uSuAiL2J37KPw==
From: Sasha Levin <sashal@kernel.org>
To: zoone.rupert@gmail.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: pressure: dps310: fix CFG_REG bit definitions" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:28 -0500
Message-ID: <20261107061728-failed-5.10-4334dc4092c2@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4334dc4092c271e6cd010c2ee70b7f4415c4c199
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061728-failed-5.10-4334dc4092c2@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




