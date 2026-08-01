Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB473148B4
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545146; cv=none; b=JugNPaCBmxBxO1S3MLhRV2tLNpXbYdbjqQSpvUOJtWcnSFN+wsK4sMBAfgDV4cQBWYIsHQQ/YFfkDMpfWN6IcCuF21pb1tjENfUHl/EE2ufG74bTzfZCoAHAKvCKr1szVXzC5Grs03sMA5pOo4oqOQQC4k04836Z4FJMj+4nECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545146; c=relaxed/simple;
	bh=sEf36E+MsFa4XJ/QPjZc2WIfErouWbFMxd8wAAnaAsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4+K8UkQt0lvjaAdyFysXlGQzMGCwU/IdflWpnS7Fhj4WGUkH7cR692/4lKIVSwt2SmLEtWARGJ1cgJI3FOn2H3wyrMS6ryHchc0pVI5Rl1/RNqqfphzD7PAkWBau3dKcXKq30KLgTleGoWVdS9W6HrQFozNLM8yeR4OuQyuIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c//argDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c//argDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CB81F00ADE;
	Sat,  1 Aug 2026 00:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785545136;
	bh=6wLANJQR5n+RcUBvqxwswU3lZH6OpwmQT0M25b+vaIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c//argDBYpad17XgSpAMkBWAaURAOwQA9c3LiGQRlv5UZYI3U3+56aXTat0vliBY3
	 S5BzoZWPsERrcOpcYOfGc1RDs9WVtQl+v/+06coRtDJ4/93gVcBUOCxf2/5FKvGCUS
	 hPq/O8dHlXIDxv3eQK2/sCY2Q8W0+htrezd6emVVPyTXtcLHAg+uC5pFkoy0EuaXc5
	 GDgr/VTcoOpA6/q/i7lbpLVhRYIv07+x/axStSDhSMs7RO/qyHegDCN/8Vj0xZTe+M
	 ZGKQaGTk0KASVxCiCPFMyWlV6YYO/xTE8p1gEwM9P+UWFCBiKYlKruteASPp1OsXjm
	 DhIXAzZRFRxbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] drm/xe/rtp: Refactor OAG MMIO trigger register whitelisting
Date: Fri, 31 Jul 2026 20:45:32 -0400
Message-ID: <20260801004533.3663723-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801004533.3663723-1-sashal@kernel.org>
References: <2026072902-gorgeous-negligee-5e08@gregkh>
 <20260801004533.3663723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ashutosh Dixit <ashutosh.dixit@intel.com>

[ Upstream commit ed455775c5a68b75e5f6ad6c8e0e3e9c98fd3f64 ]

Minor refactor of OAG MMIO trigger register whitelisting for code reuse
with OAM MMIO trigger register whitelisting.

Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20251202025115.373546-5-ashutosh.dixit@intel.com
Stable-dep-of: e70086a3a06d ("drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 41 +++++++++++++--------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 9f4b56808a27..b9ddbad12a58 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -66,28 +66,6 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 		       ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(WHITELIST(CSBE_DEBUG_STATUS(RENDER_RING_BASE), 0))
 	},
-	{ XE_RTP_NAME("oa_reg_render"),
-	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, XE_RTP_END_VERSION_UNDEFINED),
-		       ENGINE_CLASS(RENDER)),
-	  XE_RTP_ACTIONS(WHITELIST(OAG_MMIOTRIGGER,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RW),
-			 WHITELIST(OAG_OASTATUS,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RD),
-			 WHITELIST(OAG_OAHEADPTR,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RD |
-				   RING_FORCE_TO_NONPRIV_RANGE_4))
-	},
-	{ XE_RTP_NAME("oa_reg_compute"),
-	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, XE_RTP_END_VERSION_UNDEFINED),
-		       ENGINE_CLASS(COMPUTE)),
-	  XE_RTP_ACTIONS(WHITELIST(OAG_MMIOTRIGGER,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RW),
-			 WHITELIST(OAG_OASTATUS,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RD),
-			 WHITELIST(OAG_OAHEADPTR,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RD |
-				   RING_FORCE_TO_NONPRIV_RANGE_4))
-	},
 	{ XE_RTP_NAME("14024997852"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3005), ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(WHITELIST(FF_MODE,
@@ -95,6 +73,25 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 			 WHITELIST(VFLSKPD,
 				   RING_FORCE_TO_NONPRIV_ACCESS_RW))
 	},
+
+#define WHITELIST_OA_MMIO_TRG(trg, status, head) \
+	WHITELIST(trg, RING_FORCE_TO_NONPRIV_ACCESS_RW), \
+	WHITELIST(status, RING_FORCE_TO_NONPRIV_ACCESS_RD), \
+	WHITELIST(head, RING_FORCE_TO_NONPRIV_ACCESS_RD | RING_FORCE_TO_NONPRIV_RANGE_4)
+
+#define WHITELIST_OAG_MMIO_TRG \
+	WHITELIST_OA_MMIO_TRG(OAG_MMIOTRIGGER, OAG_OASTATUS, OAG_OAHEADPTR)
+
+	{ XE_RTP_NAME("oag_mmio_trg_rcs"),
+	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, XE_RTP_END_VERSION_UNDEFINED),
+		       ENGINE_CLASS(RENDER)),
+	  XE_RTP_ACTIONS(WHITELIST_OAG_MMIO_TRG)
+	},
+	{ XE_RTP_NAME("oag_mmio_trg_ccs"),
+	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, XE_RTP_END_VERSION_UNDEFINED),
+		       ENGINE_CLASS(COMPUTE)),
+	  XE_RTP_ACTIONS(WHITELIST_OAG_MMIO_TRG)
+	},
 };
 
 static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
-- 
2.53.0

