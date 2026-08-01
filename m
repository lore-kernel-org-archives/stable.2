Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AC0359A6C
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785586045; cv=none; b=ZRFZ0MDo4HCu3npqpAIUwBpey1IYFXUxkE1M07VrcN0ZaovnhdYKICKQySjD3M0QiQthT17F9jbdToNfeA5cvA9fK4v+YA/0l+cr/5bzx2UAHf7WJ9kKaV4NZRpNUx60lNeubRr76sRsAzMh0I0ghVtTsTp5twkUx6mykIPcVxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785586045; c=relaxed/simple;
	bh=DeAxto0SLWCGljNXYJgWd76bkdtThUkwosL6hScorqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdR1oceSdzoSAMTXlPOvZ+6pl9XvjaQx+y2dNdA7ZvbZWBeiPq0H/btF3881lSucxw+tJ6hMI9BaxUROM0ffOBd6wsGzv4MQs6nrhBZTnDb2cpJBcCFAB16Pho5otun0AXc5wCfXkLIl12D8ucx/mEzT/K49V9i/fAObay6Tp/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdGZ/rII; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdGZ/rII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF751F00ACA;
	Sat,  1 Aug 2026 12:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785586044;
	bh=yQfyVNf0Jeg5OJekYf7cflLC6tPhmw4tFK9BP+A8ST4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LdGZ/rIIRqR3k5mK/F0JOKm8GJlQqROYzAb/x5JzwxetlrOn/484D+IZUuupwiPc0
	 DrsMPf2o0Pl8suqXnGCf+D37YvSqltEnp2KTe9VZSkVpm5ij+qKQadFGdvQNMT1PZk
	 pkh7X0DR28z0fqOzOgihQZktpGBZ/VxrkZbjjcuwrUjfQR8wtEv+CJtMd29I7cAKEp
	 fmQGQqvw9LAxDIKC5dSkrXq2+sHfAocYzb2afIy9TAAOWUmWEnpRmM7uYw3aPXlwOg
	 PSnqxByrKPMRCxd5WKjfeoVkGE7DXmPxTQoocHpXOR5dcDjBCHVLjoXK5Y41P2OWyM
	 FGFeo4/Id/y4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] drm/xe/rtp: Maintain OA whitelists separately
Date: Sat,  1 Aug 2026 08:07:18 -0400
Message-ID: <20260801120719.2790871-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801120719.2790871-1-sashal@kernel.org>
References: <2026072931-mammogram-purposely-1224@gregkh>
 <20260801120719.2790871-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ashutosh Dixit <ashutosh.dixit@intel.com>

[ Upstream commit 31e2437561621b4867c08efc890bf629d017df03 ]

OA registers are dynamically whitelisted (and again dewhitelisted) on OA
stream open/close. Maintaining OA whitelists separately from non-OA
register whitlists simplifies this management of OA register
whitelisting/dewhitelisting.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-3-ashutosh.dixit@intel.com
(cherry picked from commit c478244a9e2d14b3f1f92e8bd293919e554622a5)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Stable-dep-of: 60d49ea28bb1 ("drm/xe/rtp: Keep track of non-OA nonpriv slots")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_debugfs.c      | 4 +++-
 drivers/gpu/drm/xe/xe_hw_engine.c       | 2 ++
 drivers/gpu/drm/xe/xe_hw_engine_types.h | 8 ++++++++
 drivers/gpu/drm/xe/xe_reg_whitelist.c   | 5 +++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_debugfs.c b/drivers/gpu/drm/xe/xe_gt_debugfs.c
index 8f95d3a5949b..15ff52dfe461 100644
--- a/drivers/gpu/drm/xe/xe_gt_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_debugfs.c
@@ -191,8 +191,10 @@ static int register_save_restore(struct xe_gt *gt, struct drm_printer *p)
 	drm_printf(p, "\n");
 
 	drm_printf(p, "Whitelist\n");
-	for_each_hw_engine(hwe, gt, id)
+	for_each_hw_engine(hwe, gt, id) {
 		xe_reg_whitelist_dump(&hwe->reg_whitelist, p);
+		xe_reg_whitelist_dump(&hwe->oa_whitelist, p);
+	}
 
 	xe_pm_runtime_put(gt_to_xe(gt));
 
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index 6b37b12f5a71..068e664527e1 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -530,6 +530,8 @@ static void hw_engine_init_early(struct xe_gt *gt, struct xe_hw_engine *hwe,
 	hw_engine_setup_default_state(hwe);
 
 	xe_reg_sr_init(&hwe->reg_whitelist, hwe->name, gt_to_xe(gt));
+	xe_reg_sr_init(&hwe->oa_whitelist, hwe->name, gt_to_xe(gt));
+	xe_reg_sr_init(&hwe->oa_sr, hwe->name, gt_to_xe(gt));
 	xe_reg_whitelist_process_engine(hwe);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_types.h b/drivers/gpu/drm/xe/xe_hw_engine_types.h
index 8be6d420ece4..ac876a8c3eec 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_types.h
+++ b/drivers/gpu/drm/xe/xe_hw_engine_types.h
@@ -128,6 +128,14 @@ struct xe_hw_engine {
 	 * @reg_whitelist: table with registers to be whitelisted
 	 */
 	struct xe_reg_sr reg_whitelist;
+	/**
+	 * @oa_whitelist: oa registers to be whitelisted
+	 */
+	struct xe_reg_sr oa_whitelist;
+	/**
+	 * @oa_sr: oa nonpriv whitelist registers, changed on oa stream open/close
+	 */
+	struct xe_reg_sr oa_sr;
 	/**
 	 * @reg_lrc: LRC workaround registers
 	 */
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 4c442f643e68..4b96b89d8d48 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -64,6 +64,9 @@ static const struct xe_rtp_table_sr register_whitelist = XE_RTP_TABLE_SR(
 		       ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(WHITELIST(CSBE_DEBUG_STATUS(RENDER_RING_BASE), 0))
 	},
+);
+
+static const struct xe_rtp_table_sr oa_whitelist = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("oa_reg_render"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, XE_RTP_END_VERSION_UNDEFINED),
 		       ENGINE_CLASS(RENDER)),
@@ -101,6 +104,8 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
 	xe_rtp_process_to_sr(&ctx, &register_whitelist, &hwe->reg_whitelist);
+
+	xe_rtp_process_to_sr(&ctx, &oa_whitelist, &hwe->oa_whitelist);
 }
 
 /**
-- 
2.53.0

