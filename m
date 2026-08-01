Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7F83909A7
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 03:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785553856; cv=none; b=Zr5jncCk9tKg60f94YUAUNyrlknNlEBJZpELBCuyIpLWv7KVINUZfjoJkh7KsOmkrirHkRik5G5LECPbkHCtOqdjMQItl4KAtgIHihXZQx1y6WkmVsBuLzKayKTqIxfAc7W1tlJcQ3H44chzxe5D8GT2YZMpM46x+0sSL2h8IHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785553856; c=relaxed/simple;
	bh=v8zHDiZ08e6NLApVSP34pT0LEiiXA6329haqF5c6/48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XX1Kwq9GAMSQikNK23ZW0/gkQ3dxxyxQNjqRgE3h79BWt8iGBHpUE/34U1Er1Gs8YCa/51rBciJU19XhS3rignhUIdWFpGdiD0GVz0g5Iv0rsnc1bSpsyUhd7VjFA24/klDuqyOV2oQzQXkZLh+xNu5/tJzFBtdnvL+rpJYuvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k290ljJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k290ljJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1441F00ACF;
	Sat,  1 Aug 2026 03:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785553855;
	bh=4seYn3/fVNDYeKHLVdYXmMrqei0gNJQVlE155zDqhQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k290ljJzYjkQ1OiiOTnap9CHClAR2jQbdFcudvbeu/Kn1K/bK2/no37sicQcIxNh8
	 uct2WbI+W+JyZzeOyELimF4kt8F+Vzil4a33DE6KcdiKcppGyeKadNdLEFmkO2lKoA
	 eEsIitXx4jgxkJ9lSbsPgs/y/iQje0en5LsncWMAYFCbSWxxomy8aw5Ox6H+sDP1GX
	 7wa8RiXhTFyXpDYAoOa5IOZlvsuU6/h+bfNstKWlAdhO64HMa1byhQ/IFWw8RZHxRf
	 3UmGDHQqyAMWJOXoEhl8sssOVBw3sGZbQWJnVIM82ihcb7l8qsLcLq1a90RUEHjz0F
	 avWGWdi+h2ANw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/8] drm/xe/xe3lpg: Add Wa_13012615864
Date: Fri, 31 Jul 2026 23:10:46 -0400
Message-ID: <20260801031050.987390-4-sashal@kernel.org>
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

From: Tejas Upadhyay <tejas.upadhyay@intel.com>

[ Upstream commit 2399bcc07c01189737858e0a88ac4ffdd1d4b03d ]

Wa_13012615864 applies to  xe3lpg

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250221112200.388612-1-tejas.upadhyay@intel.com
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Stable-dep-of: e70086a3a06d ("drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/regs/xe_gt_regs.h | 1 +
 drivers/gpu/drm/xe/xe_wa.c           | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index 312fc2404d9c..24b9e67aa250 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -466,6 +466,7 @@
 #define TDL_TSL_CHICKEN				XE_REG_MCR(0xe4c4, XE_REG_OPTION_MASKED)
 #define   STK_ID_RESTRICT			REG_BIT(12)
 #define   SLM_WMTP_RESTORE			REG_BIT(11)
+#define   RES_CHK_SPR_DIS			REG_BIT(6)
 
 #define ROW_CHICKEN				XE_REG_MCR(0xe4f0, XE_REG_OPTION_MASKED)
 #define   UGM_BACKUP_MODE			REG_BIT(13)
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index c2df7705c019..6fd8a41aefac 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -600,6 +600,11 @@ static const struct xe_rtp_entry_sr engine_was[] = {
 		       FUNC(xe_rtp_match_first_render_or_compute)),
 	  XE_RTP_ACTIONS(SET(TDL_CHICKEN, QID_WAIT_FOR_THREAD_NOT_RUN_DISABLE))
 	},
+	{ XE_RTP_NAME("13012615864"),
+	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3001),
+		       FUNC(xe_rtp_match_first_render_or_compute)),
+	  XE_RTP_ACTIONS(SET(TDL_TSL_CHICKEN, RES_CHK_SPR_DIS))
+	},
 
 	{}
 };
-- 
2.53.0

