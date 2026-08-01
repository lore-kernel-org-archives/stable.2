Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229D73B2FFD
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785553859; cv=none; b=F1RzU/QwF7ISWxPgO6E3Z0KuCYAp4pN0UI2NRm6UKC0A45ZMk2tHuJlywfacey9AAEI1O7XbNFupdJu20Ht8EP2Q7uhaHIxiYQUfhAlikMZxN2rtJFuT8BAGAPHg9Uqm7ZHy9CG7HkfpH8UxxjLWSkP87w5NyaiL8cUYukip/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785553859; c=relaxed/simple;
	bh=meIcEu/prdgTOtqPgklb0igNUS0kxNutrWLrBwDwzN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNe08xEx8YDLWj+kepR0NhYkY9OMzHxvgnSnz50K820jJ2LXnFV7HqSJJ88C9SQYZzMYuT8yOln74XF6zjjnDjh76F9/9IXem+a8gnIGXj7OswaMyJx4OnwU8asxXxi64ti7eBFQrS1L7Gvay/6bknUX9hbQeSyrGHwJ86a1iqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cywgPzUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cywgPzUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D3E1F00ADF;
	Sat,  1 Aug 2026 03:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785553858;
	bh=wt9d891Q8WGO4nxh3EuAD7MbP54imC/v/w/wPBGO6sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cywgPzUho3jT8ObMT4+DG6/9UyhCnluedyjZ2dJXSE4Bbc9SW9/hvGcQrKSGEY/qR
	 L3DEd9IkEmhiP4lz5qBOJEZS0PVteUeGArYF/mZwoRrurh5wb7vyYXFaB7P1Hpb7J7
	 qjySuYk0wxWedbRkB0IlAw9j5+fRFo5Ho9CBFxb/oZEAasOof16sBYAOp6vlJ620j/
	 TnGtza6doIGdyacVeGsRyzklg8wyruFBTjhBPwt/nZjHQfpfzf+N/Z+gEPeg1KxnSy
	 M5ZQd8IXfFMmQ1qgUrzVfxq9XfRnMt/19/bkIz2+JKGKYI3y77ZCRtCnXoMjsxGXuM
	 14g3l8XvfNrKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 7/8] drm/xe/rtp: Refactor OAG MMIO trigger register whitelisting
Date: Fri, 31 Jul 2026 23:10:49 -0400
Message-ID: <20260801031050.987390-7-sashal@kernel.org>
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
index b568686973a8..5914ae2f88f0 100644
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

