Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011334;
	b=kP8Y5VOK2QtX5AXmmthhRURHTrE79eHyn1P1n5Dohoi0kRwGE6Y6HMSGMw9wbHi0LATB
	 xzxrQn3th93ZmaJXqWK9Xj1rxSIL37GnEV9kAXYneCVqnFcxJ4BN2/Q13XrJ/ZbygW+VR
	 aWWTQmRIEmPyXqixh9NLWY3PivAHcErYnZUfQLAqQg++BYXtwlivhkd9sc7YD+kHva5NR
	 i+S67JroLDyi/TsCnfkhh0BRgysO21mOiTItO8fTan6sRFGXaYIQnSmzPBgB7S+c4iCWX
	 tWuYIrZeys7lQFALFObQDhmFLoZMy9uIt8CqpbngeWjtosU7BIImkoNfi5ve2u2nExw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011334;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=12YV6/V7BYzKRbyPF82dcu8rx/sOSfpIw5BrRnj5HIQ=;
	b=gdG8KG/udN5T/gbRqBBV/rspuhg019Zylpgj6WsBMCYFGSzPs5VzkXir7qDZmiXa0RO2
	 QJlQt33uIiaf0b5nILB7f2hBOyZfpnBoWRSIRrCT97kjoRmhE4HFfB2xOTIhD/qWmYm5N
	 sEDz7T8Sl+X6olVg+7ewECZnSoxL+J7C8qzA/K/wtip1ouy34eHgi6WWVetR7L60PjUDW
	 43p5RKm2AYE1CSgoLOtKFiu4xGliXg9EQCYY0ZBWCI8Ft/3impkn/jcjFQdJwyeE+pAFt
	 f1oGg5uLqNLbm5dMNXDfg4MVMFRpGfHUIEN552bxuFO2ntCKXd660zGL0yvcsMkSddg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=SmyYMa2e;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F49606A334;
	Wed, 18 Nov 2026 14:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04F49606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=SmyYMa2e
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5526d7883;
	Wed, 18 Nov 2026 22:15:27 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/kmb: Fix potential invalid free of plane objects
Date: Wed, 18 Nov 2026 22:15:26 +0800
Message-ID: <20261118-324f82bd41-drm-kmb-0@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1ef03375c03a1kunmf02206921a0da2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGkkeVhoeHUhDSEJNSx5PSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=SmyYMa2eaOOKt127Z8E+MLPCx/gtttlYtf0pf1yUTPtnkCyFu5MLnw5UhDsKWQ7BJP8RKhlvfIKXJu+toF2+8zgwo5zo77f2NoP2up4CWuDEjriNJ0J+Ov969V0qc7LGEnXwMz72xjgrxTS5Rc49BpK0ap8bMcAkfa9kHg3m+3A=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=12YV6/V7BYzKRbyPF82dcu8rx/sOSfpIw5BrRnj5HIQ=;
	h=date:mime-version:subject:message-id:from;

Plane objects use drmm_kzalloc() but their destroy callback frees them
with kfree(). The managed allocation can also be released before mode
configuration cleanup accesses the embedded plane.

Use ordinary allocations, matching the existing plane destroy callback.

This issue was found by our static analysis tool under development.

Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/gpu/drm/kmb/kmb_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_plane.c
index 1742c2c6dfd8..7c908ca23e5b 100644
--- a/drivers/gpu/drm/kmb/kmb_plane.c
+++ b/drivers/gpu/drm/kmb/kmb_plane.c
@@ -581,7 +581,7 @@ struct kmb_plane *kmb_plane_init(struct drm_device *drm)
 				  BIT(DRM_MODE_BLEND_COVERAGE);
 
 	for (i = 0; i < KMB_MAX_PLANES; i++) {
-		plane = drmm_kzalloc(drm, sizeof(*plane), GFP_KERNEL);
+		plane = kzalloc_obj(*plane);
 
 		if (!plane) {
 			drm_err(drm, "Failed to allocate plane\n");
@@ -636,6 +636,6 @@ struct kmb_plane *kmb_plane_init(struct drm_device *drm)
 
 	return primary;
 cleanup:
-	drmm_kfree(drm, plane);
+	kfree(plane);
 	return ERR_PTR(ret);
 }
-- 
2.43.0

