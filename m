Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC5386C1C
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784382301; cv=none; b=QQ0BcKDxGengryABujk+EiK+PyaB5E2VULHV03FnRajqn3CEqMzYDTuFtZoDy14Vg17xEo1OCTfTMFipvys/ghSmzzX/9MLalgTQaWiXEaBJcLg8RCNQbsr0HTDqMBBiIBKQbjbqLUNebPRweTw/0kdyzZeMaaLPiLCYfSYOl8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784382301; c=relaxed/simple;
	bh=9DNVN5sDl31TcECDPJROnl+aqG/A3QecsePVGTPCZkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gabm1yHLO3JBDefGuR5IZWMEp8ESo1uGl8Wwb1spyG8IDJxEdsMMqCQTTD9LILzpWCEaCGIdqUybbBSoPt/2wOcHhLIf2uo/rEoBXNKmezqoS/bbZTK5GLtlV1YxxLp/PYXaGXlmlcNtoJ9kq3BpEPVNDO1g+rlLAV3gMeyXLjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gkVLuiv3; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gkVLuiv3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=SW3hvwCBFuGporqUH2M0uUvV99W+zsDDU5ZwiMFJ6t4=; b=gkVLuiv3k4cEQPrk8LP0naKShA
	3w5wuU9SVNp4vJsqrtTbeqoLnE+zj0NMU7ZguVdaJ8AoBf0Hl9rb5m36jz5iiqQk8lTHCAY8CeLtj
	+bo2Cdhw18fuE2dfN1HGQaJYEQZ0BZqkA41wvGE4dnWp48i7Nj6fzIvw2qosn52bOzz2x4fXXi+MM
	DDszhS0HVwXt7LSEYdq4piRc03g3ct1Uprp+GtndCz2M6h2xB35FLFav9S0TvWFdXsZYdk1ktTTti
	V8N3o8knOHRswYxXMf7iVXCYP2ZsPE9buRWBb9yyNgX/g5mXWf0J9nY0wQIkvQvM95MaiEoZXCx49
	t/YiJrZQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wl5LS-00HSXW-3C; Sat, 18 Jul 2026 15:44:46 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 18 Jul 2026 10:44:36 -0300
Subject: [PATCH 1/2] drm/v3d: Reach the GMP through the hub registers on
 V3D 7.x
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260718-v3d-pm-axi-transactions-v1-1-4ecd7729ed70@igalia.com>
References: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
In-Reply-To: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1573; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=9DNVN5sDl31TcECDPJROnl+aqG/A3QecsePVGTPCZkQ=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqW4NIxhB7eaAjwUVxbcoVehNmT4AJ23xTltvBY
 lJB2ricAeOJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaluDSAAKCRA/8w6Kdoj6
 qkuTB/94sQpx88SQYnuxdhxdI18ktcmhh2e6TLIU64ArFWMcnA4CPZ2+uBo6PJj1suMJ4j24CDy
 B1R9kX5rDNFBDIYrpJmZQsy/GK4K5K0J9sNLsJ6RhlBPpXk4cnTVowCqb7zwjJWJYWFTQl/sFc9
 ZdbuwtQi70byE6s9PZw43t9JdjdG72uwA+nscJaaSl0mn+AwnzryNblvualnG1iKgtU2k1JekOl
 t4EBAKuh1fx7bgX4Ch1p2ejXvbMzgBdMiytvTBppORcO1i2SiWFPLyzy6XAoUcbQ0kd/e+14VHx
 Gk0lpjVfUAIGaYzS86JR/sd8wpIrm+Pzmbyx28jgiTX+6vEo
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

v3d_idle_axi() drains the GPU's memory interface for a safe powerdown by
using the V3D_GMP_CFG register. It reached both registers with the macros
V3D_CORE_READ and V3D_CORE_WRITE.

On V3D 7.x the GMP is no longer a per-core block; it lives in the hub
register region. Reaching it through the per-core register block addresses
the wrong region.

Select the hub accessors (V3D_{READ,WRITE}) for the GMP on V3D 7.x and
keep the per-core path for earlier generations.

Cc: stable@vger.kernel.org
Fixes: 0ad5bc1ce463 ("drm/v3d: fix up register addresses for V3D 7.x")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 18c941f15e2e..41dc3617fb44 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -39,6 +39,18 @@ v3d_init_core(struct v3d_dev *v3d, int core)
 static void
 v3d_idle_axi(struct v3d_dev *v3d, int core)
 {
+	if (v3d->ver >= V3D_GEN_71) {
+		V3D_WRITE(V3D_GMP_CFG(v3d->ver), V3D_GMP_CFG_STOP_REQ);
+
+		if (wait_for((V3D_READ(V3D_GMP_STATUS(v3d->ver)) &
+			      (V3D_GMP_STATUS_RD_COUNT_MASK |
+			       V3D_GMP_STATUS_WR_COUNT_MASK |
+			       V3D_GMP_STATUS_CFG_BUSY)) == 0, 100)) {
+			drm_err(&v3d->drm, "Failed to wait for safe GMP shutdown\n");
+		}
+		return;
+	}
+
 	V3D_CORE_WRITE(core, V3D_GMP_CFG(v3d->ver), V3D_GMP_CFG_STOP_REQ);
 
 	if (wait_for((V3D_CORE_READ(core, V3D_GMP_STATUS(v3d->ver)) &

-- 
2.55.0

