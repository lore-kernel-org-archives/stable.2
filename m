Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168190;
	b=3qCA7TiPMRfbOU9p5qE003MutAb62QHMiJx1J7qp4aZwCOG5jenIJh3tmgIVlaLACqKz
	 sCWGfEmw5lYbsvs2ZWPqsbXCsiPV5caS8SNyHVjjRZEGdXD/WmjQ/XwwF9/o3ZytJHH/5
	 IX4T941E9uYcMtzR8bnT3TurJW0x09Xm36enAZlbg7/Kb388mhyEGxJGK/AsFvZ9emLIU
	 swglmeYi7iZLfboagcdG1WHe1zfOtdPt+Ahs/J3ixkrTVoJBIx7izQoWQeldWBPBlKDUD
	 aeC8KOVYxz7sNM6of5cdr2qPls5urVWch7lOw+ujLR7i17RWib+CfuRU1cS0d+Zuvvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=48Arpm4aQecLWUtwmuWETCjP2M1iaIleyADfOwH26RA=;
	b=eeUS7m/81ZowVxw+cmpOzS3Uqj0X5k84eXg0LSQLOHnjW7WVPwtm4ydBUirm/sDKuyxv
	 Vfnszku8ggEidDj7CyZVf6PbMaUFQlroUnIc4GpJLfT+jdTIyPO9kiZXwo6zWj/WtBdc6
	 ue3fbYcrs6UEzo4uIGifC5c5n3QWfgi40xS9RT3HHzxwStEV/JN7+N5DzFl9yDgFdFSwt
	 BhwBHx+nJ5auCkEu5hhjhDMBuZ65wkLG/7B+8xs3safJUpC7imHbW/yFowDB/GP+38h8Q
	 M0Jci9rLTwL0nMzn6ocrs5+KU/SlCQhYccUQOy0DESUwLwhb5xCW0N8/22a5KD4RHhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=muovcvMP;
	arc=none smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDAB606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CDAB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=muovcvMP
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c14f3dab66so635394e87.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795168188; x=1795772988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=48Arpm4aQecLWUtwmuWETCjP2M1iaIleyADfOwH26RA=;
        b=muovcvMPAMFyxAxOwbcTvnS6QXM7XkHr9hOcL6+Ik313nZOvImzqaOMQhgDY6JAGWE
         BbZbSTP6mg/eusHXaCqgvWjflR/AjJ7eNbO3YTUV8mpTeW8V+KsNs3Ng5xf0t8DlkR8X
         O+q00tCsK53jZidYxIFE8iEyXr5U17Ta9TwS9gB1im1bZl3fG7f0taYuQZ1qa7wHFvZJ
         XFqN6UhZsHlcrO8fGH6tpv6caTaPZDpFiyV0+CqIek+WNNx4rAQ/9H5gBUz/IzHbI+Uw
         biOVhEpm+mClttrZ5FHzcX7cwp+bg7xLvVM5+uQoKOzpbaLs6ObhQbbxcQ9uc/9VGGru
         tHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168188; x=1795772988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48Arpm4aQecLWUtwmuWETCjP2M1iaIleyADfOwH26RA=;
        b=mVi6fBhZDigC9zZbl4LqlmRyVZ5fsyzuP/YCJx+YYxjkLFlD4l51ZFkz2rrYu2uZpB
         pV3Co6Xt6NCT+cXK00wGhJINVjlro5nF+wmJsjY49KSVczbkZG/BBseODAl91OLylRaC
         /6+tGZuCU/tU7RI0XKYQDGoohCcV+mABId2O6CfY1tDwQW5kmjz6fExClPLtlJXsE9c1
         WsYYBv5BVFWnI7Tf72Z8HPWldXOFUCBtT5kOE7PaH+INBIjhjLwEaMQbpaGpTfoSFKBs
         KlcwNvG5LAMzkaX7em1orSxL28fFDyt3iNEpYyHdC9OvQ83dcS6p+oCrrYe1PuWNib6+
         KFfQ==
X-Gm-Message-State: APuU4Z/NHdfnl5Ub05MHxDU+sajvhQXRqMsdqLB/q6RO1a5uD0peYo2F
	OCmUGE5/yxG3uINUjGHFFw3wGwFkQsNeiiTCpNS9wE6X/DMg+rRK1WzWoeOyopgFdf7TKfja
X-Gm-Gg: AZFdTZf0ypBOFyPRJDLTg9xzoeCjT6V+DZJVT4HiPARq2R5T9MhIT/1magb31mKZiIB
	2hYHE9Q6sCj/0ewV1lvBFidAEgWuSAU0hM3w0n7pVCZaKxQK8yOXeMZzpFeb7IAeFK9jutmriGY
	YiKUPNl+CFcpafiDtKRMeOG4wzMZwbb0C8Q7jYrbrN+XgsU5tYq7D2fBTdEWKD1KMeVOifldfOR
	3kN8s8/LTExRFgC1m/lwc9ljESsduh5BVeLIDIC8dg7gdMfbPkgwlKVoQMPhk7VRQA5s8mrYsZr
	D3d2HEjaj2X8QCh+ZIM0SDy9HtRgwNsUXBUTa18KdDio6iLyQon+Q8oh8m4sNpgRzwg/LgvRbk8
	HOKCY5kjRm5pvFZi6r/1QjcB7AKomD7nkbn3CwFYJBhKeYS91WHD43M5D7WTVmvkW2CIPFFHlLV
	OzOppudIoa+v5415rB3YKo/7kT3ES38TdCPU73Rtguy5nOUw92lGFuRzXrzHxe+azlXYPgVTDgH
	glkRc5v4K44cel/qtzzsBRel0cxTChxrAkCEgJpsmE+m+LcY4SSIWFybiTvXEdvTRyF2hUFBJ7g
	MaCgApV1y7sN31hZ6BiOg3BKNVDzk+ZxSNH6sLCYtfLhxq3ukgyz8nf/aM0IOlxjZiItqmh1spo
	eZrwjHpBY/yWFMLmHjPrb07tuomg=
X-Received: by 2002:a05:6512:3d20:b0:5c1:56f6:2e78 with SMTP id 2adb3069b0e04-5c1bc8e9986mr628534e87.24.1795168187926;
        Fri, 20 Nov 2026 01:49:47 -0800 (PST)
Received: from DESKTOP-DIIS71I ([5.18.141.223])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd043420sm443696e87.57.2026.11.20.01.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:49:47 -0800 (PST)
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
Subject: [PATCH 6.12.y] drm/msm/dp: Avoid division by zero in msm_dp_ctrl_config_msa()
Date: Fri, 20 Nov 2026 12:49:22 +0300
Message-ID: <20261120094922.1617-1-rand.sec96@gmail.com>
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
index 6e55cbf69..126ae604b 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -472,7 +472,7 @@ void dp_catalog_ctrl_config_msa(struct dp_catalog *dp_catalog,
 					bool is_ycbcr_420)
 {
 	u32 pixel_m, pixel_n;
-	u32 mvid, nvid, pixel_div = 0, dispcc_input_rate;
+	u32 mvid, nvid, pixel_div, dispcc_input_rate;
 	u32 const nvid_fixed = DP_LINK_CONSTANT_N_VALUE;
 	u32 const link_rate_hbr2 = 540000;
 	u32 const link_rate_hbr3 = 810000;
@@ -481,14 +481,26 @@ void dp_catalog_ctrl_config_msa(struct dp_catalog *dp_catalog,
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
 

base-commit: b869a5313cbfe7102873d3de318ddb68675146d0
-- 
2.39.5

