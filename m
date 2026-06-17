Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6AF175A8F
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706463; cv=none; b=nSum31y3LJUCbf/gCbIaKusUBXI/+VwbmNXJaRz1rodYSSnxv25rLijFLavxaTG1b7HWEXfb/r0A0bu2SfUHpmz6/vOQwprUbZEGN+i9oEsp8qCSO9CFJMzNPvFY1iossJnC/c3vL7vQ1cZ9e6Q9tLfewV4VOnGLzVP/vYT5Jw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706463; c=relaxed/simple;
	bh=sYajp3OVdNZZsnGl3NaDrZaoPtc1aNf67ROsYzYrewo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyUFACog11P+WhYB7J8CLaltCP5u/Hkc1xWgoUZi7L93JDN+ZobCYJE38498jwSOgk+mAX1Y9TqFgPr1BxCh5xh1/PRqfLoLfhbLySp12TWkUeHIfYhjPIVP1aRudeNGFzRIk3SOZQdoFL9WQ0N+Jz0GQQy6uCGnoWDekb3hrn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckv51UJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckv51UJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D5F1F00A3D;
	Wed, 17 Jun 2026 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781706462;
	bh=aqAlZFn+J/5HIgHOLmXmUme7OFOIVIQ4qWCb1WRrtos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ckv51UJKJk2sgLcFrM3s6iooqLWMUgX3m4uYeVVhqs2e+NASD5WWKZ/LnSGKdYF50
	 Q+gKUHxx4N8iAKYPqgRIkWfOlOdgMn4W8gV/rqchWXzK9u7nStjNs/MNgLrOMxAq8Y
	 R3ZOy+lWTkjPFsDGbeNS+06YtOnYZq4iY6DDocS/kyTTdy6kfkHYRRK6VBRgB6KEif
	 ARm1OvZr+RtwQDNLcwUE4Dr3Q/frh2flhOMqNhDbeZFZZ4Nl4sp9Xp0kvYKqklOlZf
	 0ZNWct4FORAXeYS3IsKCBSy+Qa+TngGRLRxdHdyIcLoZRxV1xvpVWf6HKKS9Itoxh+
	 2kqum4OjamYwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/5] firmware: exynos-acpm: Count acpm_xfer buffers with __counted_by_ptr
Date: Wed, 17 Jun 2026 10:27:36 -0400
Message-ID: <20260617142739.3938338-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617142739.3938338-1-sashal@kernel.org>
References: <2026061551-lung-clutter-0849@gregkh>
 <20260617142739.3938338-1-sashal@kernel.org>
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
Stable-dep-of: bf296f83a3dd ("firmware: samsung: acpm: Fix missing LKMM barriers in sequence allocator")
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

