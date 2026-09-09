Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429D51A73E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950073; cv=none; b=TOZFncBQW8dxEaCaifIVUd8mDOfa/L2HcEoWc7SM0PTMezgG+4qs1nvVO7nWBFzKT7LZ6UO8ABh3tE0YnLNbvlru3TYmaeOCoR6EwNQiKFizDfKoZid/3UmjyYbDvVoaTDVhyTETYu0YxsdKDFa6gNoMPxuCVbSQLfZSaQMLAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950073; c=relaxed/simple;
	bh=BBsyBCbuFikMhgMelhK7bBZdPI66lCZxx1TpnMhewiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMgVdNpImdLZFE2HQh67usMdEywZh9OYp3cpwLOyA52vGH2DAb/ZZslvp1RSC6h5PaHOfWtkEqIRXnFwpB1dSfyztykcS8h/knivemm3zYvi/xLFsapsnD51e6QkQAA+35d26azdQYZzXvWeSi274PRCuZlSfh6+QjuALyWpmgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gak4+l7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gak4+l7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB3D1F00A3D;
	Wed,  9 Sep 2026 10:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950072;
	bh=rTM9g0Zm1BvvOdVRpxRrSfbjjJVumUOXL0wrllU7ki4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gak4+l7m8fcEwAakny8ZfOXggPzBnhE3MVSH+1EyieP1ZRCC72l454J/obcVTBaeD
	 MUOmq3leBck7avPu5+GAqrN2b4vNk9T9UlaWmRchZK8Ey5tsVLrAOEiauF5M4Igqab
	 Qcio6P52XpPJmV3F/9rScB6ZH2ODTme5dwpGYhap9KdYRlPo+gteYCRNRYYkqTjiN8
	 OsfWLbf3fGANuvlo5/JYT2tcPBRCVudGrJ3XfjqeGxeGU3Ti9QHi5M4bMcv/1wosFX
	 fWRKjyoODsmKpz3SKOM9jtp1V6B+t/rUe1YvZizggCYK24fCC/9Ta8IiNpwP1PnLEC
	 26RJhXxKyiOsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ASoC: codecs: aw88261: only check PLL and clock state at power-up
Date: Wed,  9 Sep 2026 06:34:29 -0400
Message-ID: <20260909103429.1544487-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909103429.1544487-1-sashal@kernel.org>
References: <2026090348-garment-snowdrift-7618@gregkh>
 <20260909103429.1544487-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>

[ Upstream commit 06b6f1245567a4be862c3e1cc74577922ceb05fb ]

The SYSST check performed during device start requires SWS (amplifier
switching, bit 8) and BSTS (boost finished, bit 9) on top of PLL lock
and clock stability. Those bits cannot be asserted at this point in the
sequence: the check runs after amppd release but before the
hmute/ULS-hmute release, and the amplifier neither switches nor
finishes ramping its boost converter while it is still muted. With the
Fairphone (Gen. 6) firmware profile, aw88261_dev_start() therefore
always fails with

  check sysst fail, reg_val=0x0011, check:0x311

and playback aborts, even though the amplifier is fine and PLL lock
and stable clocks are present.

Check only PLL lock and clock stability, for which a definition
already exists; this still re-validates the clocks after amppd release
(aw88261_dev_check_syspll() checked them before it). This matches the
vendor aw882xx driver, which only validates PLL lock and clock
stability at this stage, and the in-tree aw88399 driver, which skips
the SWS check whenever the amplifier may legitimately not be switching
(AW88399_BIT_SYSST_NOSWS_CHECK).

Fixes: 028a2ae25691 ("ASoC: codecs: Add aw88261 amplifier driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Link: https://patch.msgid.link/20260704192857.88366-1-jorijnvdgraaf@catcrafts.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/aw88261.c | 6 +++---
 sound/soc/codecs/aw88261.h | 6 ------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index 9019a12cd0f03..7fe486b707b2b 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -254,10 +254,10 @@ static int aw88261_dev_check_sysst(struct aw_device *aw_dev)
 			return ret;
 
 		check_val = reg_val & (~AW88261_BIT_SYSST_CHECK_MASK)
-							& AW88261_BIT_SYSST_CHECK;
-		if (check_val != AW88261_BIT_SYSST_CHECK) {
+							& AW88261_BIT_PLL_CHECK;
+		if (check_val != AW88261_BIT_PLL_CHECK) {
 			dev_dbg(aw_dev->dev, "check sysst fail, reg_val=0x%04x, check:0x%x",
-				reg_val, AW88261_BIT_SYSST_CHECK);
+				reg_val, AW88261_BIT_PLL_CHECK);
 			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
 		} else {
 			return 0;
diff --git a/sound/soc/codecs/aw88261.h b/sound/soc/codecs/aw88261.h
index 4f3dbf438510d..79ce52f602838 100644
--- a/sound/soc/codecs/aw88261.h
+++ b/sound/soc/codecs/aw88261.h
@@ -181,12 +181,6 @@
 		AW88261_OTHS_OT_VALUE | \
 		AW88261_PLLS_LOCKED_VALUE))
 
-#define AW88261_BIT_SYSST_CHECK \
-		(AW88261_BSTS_FINISHED_VALUE | \
-		AW88261_SWS_SWITCHING_VALUE | \
-		AW88261_CLKS_STABLE_VALUE | \
-		AW88261_PLLS_LOCKED_VALUE)
-
 #define AW88261_ULS_HMUTE_START_BIT	(14)
 #define AW88261_ULS_HMUTE_BITS_LEN	(1)
 #define AW88261_ULS_HMUTE_MASK		\
-- 
2.53.0

