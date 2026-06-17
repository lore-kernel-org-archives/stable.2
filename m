Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80EF19DF55
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781660851; cv=none; b=djnNoXxfxQQVDxsfHFpAtZ86Bf2Qz+NlZ4n6Sl4jJ1+O6qTWHbqdYsmS/26NVbUdtq3PVh4q8vXB/RFmWobcgIvar+W8GPtyEEmaC1h/PYDXaz7FaBPvd6DKHgS1SIqDT4+serPQi3eGdBI6QobG/8Jx9aSmuViRKwZEl8yl1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781660851; c=relaxed/simple;
	bh=XD7cEDcM5we7dZR78Zix01AKee7FlCBm0YGnCJhkXlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6MZewZsXEnxI2Rqe1RUAq/JEuRJFw3bzqacooG3K41KLU5Az8u3pgJqO18WGZVkGWATKbijagnoZjNJ9Hsv3h1xejrrlWGt5/pkNEbeKBImfvdzE3FuJnVb4RSqCeB9ziwEKDSzeRARznRZ3+3b7wDWb4d378iPfyiRAHTGWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj/8m1N8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj/8m1N8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314261F00A3A;
	Wed, 17 Jun 2026 01:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781660850;
	bh=IE9+cUREoxCMXUZuj9O87F2VoodBXFVQDbzlZWZ8ywY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uj/8m1N8FAF1YwkC1U9QKBP3VULYPG7saJRtVYKrFWWwe483ygAPLWPgYS/Gk/H4C
	 FB1NbU7NtVicYXywoOKhTe0owdZc2rp8x8/1yfuZtZ3ttarBN7YJKcGCdPqDtHRjX6
	 PUMHEmD8Ajs7CiR00vP10K1KA58aKUTE274FjniynuDYEwyL4k78CY1mZNJqC/fIlY
	 JcIIq8a6NpgjyNPD9jXbNA0BOk//e2DymIOKcyyM2pyekFY3K3REs8LS9JKHKZCVJw
	 dnu8l6bo7tQrItFMFQeuve0Cef7SH/82OzdFGTj3IikHxaULQ7kxUuWDU/fp4uHlwp
	 +hCN5p+3smfeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/4] firmware: exynos-acpm: Count acpm_xfer buffers with __counted_by_ptr
Date: Tue, 16 Jun 2026 21:47:25 -0400
Message-ID: <20260617014727.3671804-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617014727.3671804-1-sashal@kernel.org>
References: <2026061533-risk-glorifier-616c@gregkh>
 <20260617014727.3671804-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

[ Upstream commit 951b8eee0581bbf39e7b0464d679eee8cb9da3e0 ]

Use __counted_by_ptr() attribute on the acpm_xfer buffers so UBSAN will
validate runtime that we do not pass over the buffer size, thus making
code safer.

Usage of __counted_by_ptr() (or actually __counted_by()) requires that
counter is initialized before counted array.

Tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260219-firmare-acpm-counted-v2-3-e1f7389237d3@oss.qualcomm.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Stable-dep-of: c889b1464788 ("firmware: samsung: acpm: Fix false timeouts and Use-After-Free in polling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/samsung/exynos-acpm-dvfs.c | 4 ++--
 drivers/firmware/samsung/exynos-acpm.h      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.c b/drivers/firmware/samsung/exynos-acpm-dvfs.c
index 352a6e64d79ddc..06bdf62dea1f30 100644
--- a/drivers/firmware/samsung/exynos-acpm-dvfs.c
+++ b/drivers/firmware/samsung/exynos-acpm-dvfs.c
@@ -25,12 +25,12 @@ static void acpm_dvfs_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
 			       unsigned int acpm_chan_id, bool response)
 {
 	xfer->acpm_chan_id = acpm_chan_id;
-	xfer->txd = cmd;
 	xfer->txcnt = cmdlen;
+	xfer->txd = cmd;
 
 	if (response) {
-		xfer->rxd = cmd;
 		xfer->rxcnt = cmdlen;
+		xfer->rxd = cmd;
 	}
 }
 
diff --git a/drivers/firmware/samsung/exynos-acpm.h b/drivers/firmware/samsung/exynos-acpm.h
index ac634ef9c6780e..5df8354dc96ce6 100644
--- a/drivers/firmware/samsung/exynos-acpm.h
+++ b/drivers/firmware/samsung/exynos-acpm.h
@@ -8,8 +8,8 @@
 #define __EXYNOS_ACPM_H__
 
 struct acpm_xfer {
-	const u32 *txd;
-	u32 *rxd;
+	const u32 *txd __counted_by_ptr(txcnt);
+	u32 *rxd __counted_by_ptr(rxcnt);
 	size_t txcnt;
 	size_t rxcnt;
 	unsigned int acpm_chan_id;
-- 
2.53.0

