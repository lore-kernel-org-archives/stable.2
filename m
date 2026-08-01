Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6B2379C58
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785553420; cv=none; b=q7isTBEBcXSGmfPctH+jwFX7k40ZLjId2hzwDM6MXsvwynxXr0UY2ZWNgVDn4AL5b0lAARYsXxcMDOBYrHvfgAhNTKbvnXTKys+H5bR1K7dgAbaiX6KfczbGBJhyBOqKYUezmi3V4LoR+xTACWrOj6+Dy4797ux8dt2nTxj1DpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785553420; c=relaxed/simple;
	bh=1oeRnpU7S3qNJCqL4zrR2BX5AI1q6qv47UMh+kAGLH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRG1q9ngUmHtMDuIc4QrC2Nq53hFQWWE23osezerIcU+IqTUqi3MvXxRrZB/RrfC0BZbFz4Z1Rxy2QTlFKzVg12oWudPUC0+XclOacVV13md410lnBJov3JvaeozFny7yaAIAUWqzIX2NrCSNb+wuOvDVRdJzlK9RvHl6fM1QIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBh62+aC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBh62+aC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A431F00ADB;
	Sat,  1 Aug 2026 03:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785553419;
	bh=H8IemfZvC6Fxv5IV8qAfH3capKs1/0ZkUwker+63S2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EBh62+aCwtx6M9n7r2CrW+2tJavBxj6aheZkd5r9h/IHDwbNRncINvXNjAfgXg8cH
	 Qoba0D4eYbGa60mI1RRUdvXGwrXU6v2jwoyYGpg0tZH31wgH1CkVG0eocCgE7T2lzt
	 ZIqQxdkHXdIEqU+mu6GORUv9RGIYG3kkLf35AleBByfsyJy6g1WQ8Let5RBMH3OR2f
	 8KmXDkjz5jTPgYceb/vTZVB3ZvPHyqZdQEL5X4TUnlm9DZljGjZfeSqYahhx52AEdg
	 IfzQNbfq+e4sVfeioXHzscue37c4UJXC1JPXkvY1QxhHIvUG5pPvodfZvJMyPmr2Dq
	 tSe6brknJa3gA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 6/6] drm/xe/rtp: Maintain OA whitelists separately
Date: Fri, 31 Jul 2026 23:03:30 -0400
Message-ID: <20260801030332.859236-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801030332.859236-1-sashal@kernel.org>
References: <2026072913-snap-snuff-32d6@gregkh>
 <20260801030332.859236-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_debugfs.c      | 4 +++-
 drivers/gpu/drm/xe/xe_hw_engine.c       | 2 ++
 drivers/gpu/drm/xe/xe_hw_engine_types.h | 8 ++++++++
 drivers/gpu/drm/xe/xe_reg_whitelist.c   | 5 +++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_debugfs.c b/drivers/gpu/drm/xe/xe_gt_debugfs.c
index f253e2df4907..1a4d8d4f44b4 100644
--- a/drivers/gpu/drm/xe/xe_gt_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_debugfs.c
@@ -174,8 +174,10 @@ static int register_save_restore(struct xe_gt *gt, struct drm_printer *p)
 	drm_printf(p, "\n");
 
 	drm_printf(p, "Whitelist\n");
-	for_each_hw_engine(hwe, gt, id)
+	for_each_hw_engine(hwe, gt, id) {
 		xe_reg_whitelist_dump(&hwe->reg_whitelist, p);
+		xe_reg_whitelist_dump(&hwe->oa_whitelist, p);
+	}
 
 	xe_pm_runtime_put(gt_to_xe(gt));
 
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index e5241bf3024c..f097b5555f4e 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -565,6 +565,8 @@ static void hw_engine_init_early(struct xe_gt *gt, struct xe_hw_engine *hwe,
 	hw_engine_setup_default_state(hwe);
 
 	xe_reg_sr_init(&hwe->reg_whitelist, hwe->name, gt_to_xe(gt));
+	xe_reg_sr_init(&hwe->oa_whitelist, hwe->name, gt_to_xe(gt));
+	xe_reg_sr_init(&hwe->oa_sr, hwe->name, gt_to_xe(gt));
 	xe_reg_whitelist_process_engine(hwe);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_types.h b/drivers/gpu/drm/xe/xe_hw_engine_types.h
index e4191a7a2c31..04ca7545d22c 100644
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
index 7c37d20b0970..66503a53410b 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -66,6 +66,9 @@ static const struct xe_rtp_table_sr register_whitelist = XE_RTP_TABLE_SR(
 		       ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(WHITELIST(CSBE_DEBUG_STATUS(RENDER_RING_BASE), 0))
 	},
+);
+
+static const struct xe_rtp_table_sr oa_whitelist = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("oa_reg_render"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, XE_RTP_END_VERSION_UNDEFINED),
 		       ENGINE_CLASS(RENDER)),
@@ -138,6 +141,8 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_to_sr(&ctx, &register_whitelist, &hwe->reg_whitelist, false);
 	whitelist_apply_to_hwe(hwe);
+
+	xe_rtp_process_to_sr(&ctx, &oa_whitelist, &hwe->oa_whitelist, false);
 }
 
 /**
-- 
2.53.0

