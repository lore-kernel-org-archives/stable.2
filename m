Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168267;
	b=IIYoSNhVp6KDADmxoWMCNsLuzanhLgqk9kBov6Eb5Aewz/yGbSITenuSC2lHjzGbU6nJ
	 911HmgO2Ih5iLDEA4UQeL76Xiu0AH2amdVzirku/Yepb4g3DjhTpfPbNzDLYCXP6QDwTx
	 oYFLJu4g9Xw2yz3XnOJCy+aAQhfX3OMLQQliuSAAfYe2l6Igbsfgi2bxKXow7SF/6T7j3
	 znBp0wm0Z75gfjSwL/BlCxm4L207jV35jjwnZQrBuQu9NoVqWIk8AOe5REKFD+6cZx1n/
	 4bMgbDDjlD5/kZ8gDa9bVkSUpj0Q64L/4YhLQrBqqwh4mnVlzEja5mBkgoHStNLy3Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=K03yq8PnwQSMBaH5zxyg7DRRtPfTfIojAW5cpA8gJ20=;
	b=qZkOoCcbx03xTqhOFYfjf70mqNGUfZ8gO2LfvgaAgwWx3pb9YLQL/dxvXpGYCZge8sv0
	 OWDKHpSCEs9e+r9WowMMx2lNxqpOX7tsmurGlQOQLWcRLkJZr0PMMuxGsj7nz4GDRutkG
	 NYy7ChoRKMA/mJ/gUG5kTo+4WYkhg448XxdmT92C0hSIuDw8SPDz8zX4xYxHfdj+3WYRR
	 9jrPAnAkV21SAgi/uMzsK+pWC74buVkdAzrmSnum18TlwQvkCefrq1cyYr2KoaEJapW5/
	 8JksLh7/3RyNf18zJu7oHxFMIP1BUQ1kEP9Oj5IMaNZBFbZGPGiO4X9XTn+jDUdOxPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TWDT1Kas;
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089660A2606
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F089660A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TWDT1Kas
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c14a204305so468910e87.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795168265; x=1795773065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K03yq8PnwQSMBaH5zxyg7DRRtPfTfIojAW5cpA8gJ20=;
        b=TWDT1Kas+J5ibC1Cbhv09e7SbB/nIkqDbkXB//9bJv+YfGvlWiAr4/jLSQhSUJz4zI
         tBjPNUmUqicfYiTYMtU88oiFkANAiUtHvulUAuUu2hvI08P0V++tsueFfDky1r/dR2v4
         1qoVmy9eUFx3zU9+m3zyvGSRxbFmqP7qOlz+UhRWiPJ+S1ijNKtMRQl2P115IZ4yYskM
         uhUuzQUaQ/NWYxC3Zq+TDoDv5/DxP1wZQnQwSPon26LxQS0HPRqrVLjAKjfDKrVKcIec
         kYprZXFVCsjOGRaVBwYPttaHUkUkffIFCzYJVvwz4IE83taSQBxUezk/NfPqbrEBCbJ4
         j60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168265; x=1795773065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K03yq8PnwQSMBaH5zxyg7DRRtPfTfIojAW5cpA8gJ20=;
        b=FocUf8hnTAVQHDySn/hfLn8vjN3PcEBZ6tpqQp8ClbgU+vHr9Rlm5gHtyeJmxDtfJ7
         w6xOBhtk16VKZj3daYySIdReRYzh/w3FmNocNy2Tr8rmKUwjIjQLrrEMC5SPScRgD1Gh
         5IoslEBV6hqlYjawwV0Zh0oPJR2VQUKOZAWdJQ5zmqSdFdxrs/7oPeG2nTtMwu1/JRDi
         Ci/+y/BltKphxSUTkAMDm8Xz965l2s9QC3Yqw6E7rfpIg9O820sETyvg1X8/nEkGt5l5
         m1gW1+DU+Y283+x/kNxSvircfH9/NUsGkFBIG1u2/GNxHdXKbHDyypEOADvjhzBc/ynD
         X3yQ==
X-Gm-Message-State: APuU4Z9ibKFuS6Pt9FRN7+fscjwQJPEg9IVQ1L5480FBr4eDTEwlVrLf
	rm5E4vueeviZv8IWVlTfk946pZUETYcwr5DpcsOQQLRnNq1dWG1+GET3yI88nPGr8gwwYMwp
X-Gm-Gg: AZFdTZcFcp5SKoFouR589sQnHHW7CxmPTYE4mYDZoFoUB+n/SO488dmZ1JrChKhf905
	ZYYOSUZ0Tnj9y8rR3vD9seqs17c58YQbZSokS7hvUOuMyYcYVGlw+xCPK2SriXfDUgxr/M6Nm4q
	E6SPmSA46bAROEhv9JyCQEggtjzCOf6/vVmyUGJ9YPYl+mRn9eMP6KnWI03B2rIrgYgi1rl2kKo
	BMEy0TOxPaXUJELZIK7GrbR5YMbIA3NRObI+h2JwVtiYHUrN9BPFwWEtFcqQq4CkrXrhk57qURX
	sK3nT6e1mFjcoRPrypyow9ji0p5VQh9qEUQAxR2lmF0pmGC9ivVMRgozxvmsSYRZI8IRkAvDeT/
	cSQ9N6M2hjPbzFHtgD6oXOQ5Sa5M3ILPs05OabHBe8LT+P4tq/hhPNIws+ariPQQ+2iI+1F7a/y
	e/GCTwOYzVDcAuILDHPbXqhzdfKTU4ZxQGhNPnH6c+Gs1JjoIl4bojkKo9RNxHqa80lVghtjjMY
	hMe38Ak+Nb9SX8XxGo830tjvz9lLUrLp1dbXFIVMLxIVzbgqsBy6Q77D1xRzDFyr9mh+4mbSHJX
	7LuvksAZ6/xeV+MhkCAjgs95l1jHj0j+/Bj427A3pF3M8oCfKcvpZbj4tAMLyuB95xqIQJfZa9h
	S4m8q7apqI9t6yYBoejFn9Y6kfzZc
X-Received: by 2002:a05:6512:2398:b0:5c1:ae7f:2ea6 with SMTP id 2adb3069b0e04-5c1bc7b5e0amr722469e87.19.1795168264851;
        Fri, 20 Nov 2026 01:51:04 -0800 (PST)
Received: from DESKTOP-DIIS71I ([5.18.141.223])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bcf3338fsm461561e87.3.2026.11.20.01.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:51:04 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	lvc-project@linuxtesting.org,
	deeb.rand@confident.ru,
	shda@confident.ru,
	kernel test robot <lkp@intel.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH 6.1.y] drm/msm/dp: Avoid division by zero in msm_dp_ctrl_config_msa()
Date: Fri, 20 Nov 2026 12:51:01 +0300
Message-ID: <20261120095101.76-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit f185076da44c774241a16a82a7773ece3c1c607b ]

An (admittedly problematic) optimization change in LLVM 20 [1] turns
known division by zero into the equivalent of __builtin_unreachable(),
which invokes undefined behavior if it is encountered in a control flow
graph, destroying code generation. When compile testing for x86_64,
objtool flags an instance of this optimization triggering in
msm_dp_ctrl_config_msa(), inlined into msm_dp_ctrl_on_stream():

  drivers/gpu/drm/msm/msm.o: warning: objtool: msm_dp_ctrl_on_stream(): unexpected end of section .text.msm_dp_ctrl_on_stream

The zero division happens if the else branch in the first if statement
in msm_dp_ctrl_config_msa() is taken because pixel_div is initialized to
zero and it is not possible for LLVM to eliminate the else branch since
rate is still not known after inlining into msm_dp_ctrl_on_stream().

Transform the if statements into a switch statement with a default case
with the existing error print and an early return to avoid the invalid
division. Add a comment to note this helps the compiler, even though the
case is known to be unreachable. With this, pixel_dev's default zero
initialization can be dropped, as it is dead with this change.

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Link: https://github.com/llvm/llvm-project/commit/37932643abab699e8bb1def08b7eb4eae7ff1448 [1]
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601081959.9UVJEOfP-lkp@intel.com/
Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/698355/
Link: https://lore.kernel.org/r/20260113-drm-msm-dp_ctrl-avoid-zero-div-v2-1-f1aa67bf6e8e@kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
[ The function is still dp_catalog_ctrl_config_msa() in dp_catalog.c in
  this tree; same change applied there. ]
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 421391755..61f9cb018 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -420,7 +420,7 @@ void dp_catalog_ctrl_config_msa(struct dp_catalog *dp_catalog,
 					bool fixed_nvid)
 {
 	u32 pixel_m, pixel_n;
-	u32 mvid, nvid, pixel_div = 0, dispcc_input_rate;
+	u32 mvid, nvid, pixel_div, dispcc_input_rate;
 	u32 const nvid_fixed = DP_LINK_CONSTANT_N_VALUE;
 	u32 const link_rate_hbr2 = 540000;
 	u32 const link_rate_hbr3 = 810000;
@@ -429,14 +429,26 @@ void dp_catalog_ctrl_config_msa(struct dp_catalog *dp_catalog,
 	struct dp_catalog_private *catalog = container_of(dp_catalog,
 				struct dp_catalog_private, dp_catalog);
 
-	if (rate == link_rate_hbr3)
+	switch (rate) {
+	case link_rate_hbr3:
 		pixel_div = 6;
-	else if (rate == 162000 || rate == 270000)
-		pixel_div = 2;
-	else if (rate == link_rate_hbr2)
+		break;
+	case link_rate_hbr2:
 		pixel_div = 4;
-	else
+		break;
+	case 162000:
+	case 270000:
+		pixel_div = 2;
+		break;
+	default:
+		/*
+		 * This cannot be reached but the compiler is not able to know
+		 * that statically so return early to avoid a possibly invalid
+		 * division.
+		 */
 		DRM_ERROR("Invalid pixel mux divider\n");
+		return;
+	}
 
 	dispcc_input_rate = (rate * 10) / pixel_div;
 

base-commit: c75b0cf0982c00cddfd88d1acf3872f79b40980c
-- 
2.39.5

