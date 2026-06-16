Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA33E5A0B
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649580; cv=none; b=VoATLntjJvPfiGCiE8nR9zVfrJoe3cuV2ZGmVew1zqTY5D+Oud4LZSx491CFwuONZZxYKPausLGbv9CJ+tJRtidYXi98MXzSp0ZbjriMpfK1x7dO8QSnY6bhMKjY78vZX2U5ISrGjfy/jX3wK1dinHnAaLDL6XHCRR/a701p6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649580; c=relaxed/simple;
	bh=/MxLn7SV7yoC6BEhkcclWFZg5jgk2yBkZnR6vzVVgnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiNNszl/djFJH5QAgwSAchtLCtkOJldPNFcgZI+TSZPym22tdHXUYnmLO5TmDlR48IxvPmLgBMDvHSB4tBRAaoFbvRaW4wyASf9lq5EJTeOoVvNptewL+kvIdgpCk9pGsceaqXD1QBwiVL9Sac+JGBDwnsFZVcnp9kpoPICqwVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuWTa8hG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuWTa8hG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34A01F00A3A;
	Tue, 16 Jun 2026 22:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781649579;
	bh=/L/4z8eYRbBlPSr4SQYNVYGryVs0ypyqL7fGkoNFdKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cuWTa8hGjk07VKqR3Xru618hg8dfb1fQahZCD1lZCi/tFtMw8TcDou4SCkYh1V5eD
	 mz/dGyFKgGbv0kwM4kTpqiDfgO7ohKq+y53lCpvqeWfxZii5uula0LRw/HiCNmPxwq
	 mur8YgHToxH+LgzdIS6yNXZLyp11bzRBFFavL6KQ6TLTMktHpk2USFaL9DLOkJPkNZ
	 knwnKtE69QHvtXkz/nr1/1C+moOj05mZ8dvtsOU9vzhj+tGBT925hNlmX3FZ2Rl+DR
	 ulMnzdqd1mBK2UX2PrWafVLdhmecep2uaE0ymqye8J5FJOVi284bxs/JNSNyrVkMEP
	 Pnpi7g9MIX4bA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/3] firmware: exynos-acpm: Count acpm_xfer buffers with __counted_by_ptr
Date: Tue, 16 Jun 2026 18:39:35 -0400
Message-ID: <20260616223936.3557131-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616223936.3557131-1-sashal@kernel.org>
References: <2026061524-schematic-trapeze-18dc@gregkh>
 <20260616223936.3557131-1-sashal@kernel.org>
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
Stable-dep-of: f133bd4b5daf ("firmware: samsung: acpm: Fix cross-thread RX length corruption")
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

