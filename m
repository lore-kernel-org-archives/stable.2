Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2C3054EF
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 03:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785553856; cv=none; b=Oc0ydeeLfPHh3+KbNP0ou1oZGUeqv8Bm0pf/DeBlhYg6DyqucmWNV7Ji38iVqBNyvC7z0YTDEDr0MoZr2ZMhVk/EbgXuvDHxVUWvJmV1cMADXyBigYYcI2H+8y7xTeroKjTTUXxQXmZvqEoP9yEWKH/yjOWpJpyR8uT004HfmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785553856; c=relaxed/simple;
	bh=QOQHuYnAH4iiWH5O0L3ZcBXFfRUsADiHr6O5namjkOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDtwiFDhBQsyi8Z4ko0GQyMG7wu26LUhYnzs6S8hXuPx+D9mJvtMTZ5nVMTyHp19Q8hmM3dbGNg9h9GJfQbmiZIvRB35bM6wt6+TFpJEmGZGMVhCszvRdP2kxkJvIgCwAeMA/IDqoF/JDan91KAOsAlfpF5mEsbd56/V6WyGy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Luy+KDvS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Luy+KDvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A571F00ADB;
	Sat,  1 Aug 2026 03:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785553855;
	bh=XFVEpyNOnXZ6Snrwv36Ld6vABqYGynFomowaiSXaAI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Luy+KDvSYX4fScy7wLB/jaBEcSsH7xwzNE4rF590qZpH8K9zNJTaPmSAZsUqshX9V
	 1PUX8Tdch3Dwwt1XSbnEzX25Sn6I/FJ2W/t2PIt3+pnI7H6F1FB1U3CcmYDTA9q5/1
	 uL5RxhxPxGGWT29ckxGbKyyY26mTdrtTDmXB9ohP5cUEXt7rPFlJ8Q6HuuOE7zdvLX
	 NiSSm5JRU9p5ITYgP/s+BPOQe4Qw1KTWG0NFkIE/zGKhYjAynlWnnCpOGYPAMjV11A
	 b+2xYcgfAT79Tg/IJXZ1bQgJKXv/Ou8TockN76jGRzz4zpvmW/hW3F0RPeZuPaQT2d
	 DVDT2EmzEZceA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/8] drm/xe/ptl: Apply Wa_14023061436
Date: Fri, 31 Jul 2026 23:10:45 -0400
Message-ID: <20260801031050.987390-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801031050.987390-1-sashal@kernel.org>
References: <2026072902-purity-frenzy-fc0b@gregkh>
 <20260801031050.987390-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nirmoy Das <nirmoy.das@intel.com>

[ Upstream commit 92029e0baa5313ba208103f90086f59070bbf93b ]

Enable WMTP for the BTD kernel to address Wa14023061436 by setting the
proper TDL Chicken Bit.

v2: Apply it on engine_was[] as this register is not part of LRC(Matt)
    Apply it for first_render_or_compute in case this gets extended to
    compute only platforms(Matt).

Cc: Gustavo Sousa <gustavo.sousa@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250108141323.311601-1-nirmoy.das@intel.com
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Stable-dep-of: e70086a3a06d ("drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/regs/xe_gt_regs.h | 3 +++
 drivers/gpu/drm/xe/xe_wa.c           | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index c160b015d178..312fc2404d9c 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -491,6 +491,9 @@
 #define   LSC_L1_FLUSH_CTL_3D_DATAPORT_FLUSH_EVENTS_MASK	REG_GENMASK(13, 11)
 #define   DIS_ATOMIC_CHAINING_TYPED_WRITES	REG_BIT(3)
 
+#define TDL_CHICKEN				XE_REG_MCR(0xe5f4, XE_REG_OPTION_MASKED)
+#define   QID_WAIT_FOR_THREAD_NOT_RUN_DISABLE	REG_BIT(12)
+
 #define LSC_CHICKEN_BIT_0			XE_REG_MCR(0xe7c8)
 #define   DISABLE_D8_D16_COASLESCE		REG_BIT(30)
 #define   WR_REQ_CHAINING_DIS			REG_BIT(26)
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index a2af1a44b0e0..c2df7705c019 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -595,6 +595,11 @@ static const struct xe_rtp_entry_sr engine_was[] = {
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3001), FUNC(xe_rtp_match_first_render_or_compute)),
 	  XE_RTP_ACTIONS(SET(HALF_SLICE_CHICKEN7, CLEAR_OPTIMIZATION_DISABLE))
 	},
+	{ XE_RTP_NAME("14023061436"),
+	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3001),
+		       FUNC(xe_rtp_match_first_render_or_compute)),
+	  XE_RTP_ACTIONS(SET(TDL_CHICKEN, QID_WAIT_FOR_THREAD_NOT_RUN_DISABLE))
+	},
 
 	{}
 };
-- 
2.53.0

