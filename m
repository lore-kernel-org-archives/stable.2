Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1523E716F
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736457; cv=none; b=htY3geQtHdxuevxieyTuGO4u8Q0SkEdED4nex32KO7lHPNGdv+VsIZJg4hL6Mlj7mlQAqL7e3GYf376D7iFz+HbyjMmCdAOuv+hbbMOrf8oxwbePb9IxM47siB9EZHPF37LQ3CxskCKEzrzOZ/zmR432Yk7c3lnL1rNgyltX26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736457; c=relaxed/simple;
	bh=zFckpAxCmMHU41Qhc/8NInRnFUk4SAhYkeSuy+oj0C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5QtXGelOwNfpwCLgVVTuQ7R0pvQwQyY4iXEgo2lDujNHfFsLqokIqiDN0FcNf2a3bPmQD8IpmLzrRAK0u8MqFxqhJ+w7tTP8eLKaKnklPmgG+kKPB5IX1fq087i816ipuV8MYSj/KWCh34fHh26AR+reGMj1r3Q0ESmxb2FoQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onqPFnf9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onqPFnf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B5C1F00A3F;
	Wed, 22 Jul 2026 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736456;
	bh=FR/bEwzd1bk0oO98pguiKP46w4DhVyUBAMPc2E/lrYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=onqPFnf96g9jexTLjVpoqCkPWv4nKsDULf/SA9w6IYAj8ZRqidRwdGad4NYrJYTbe
	 BHHThPQ13mKMini14ZVmLnNzWuoE9ckIs7AJfgNBMc8b0IqmKTGmtZH7hAJrYtzbei
	 A+60WW/QUC+/hi+5YySje7WdRoMr015Rtls4+ke4t3EYslK94jskAQ3zgZbJjmGvBC
	 rqKEqrmiHkZ0LUE8cAPosAvMHqjm0N2YlOTIoSuEuWu4Rb0ssVi9neQHWe0f4ZhGbh
	 a13w52csVq9v/zxpVAsv9HwpdlpxAoUbPjj9IAeUQDkOiD+hB+ParoSLLFGbQ6YFiB
	 zTZ8VlrelyTWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] VDUSE: avoid leaking information to userspace
Date: Wed, 22 Jul 2026 12:07:31 -0400
Message-ID: <20260722160731.1739521-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160731.1739521-1-sashal@kernel.org>
References: <2026072041-connected-dole-9dc1@gregkh>
 <20260722160731.1739521-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 9c1523803445ee0348f62b77793266dd981596e0 ]

The bounceing is not necessarily page aligned, so current VDUSE can
leak kernel information through mapping bounce pages to
userspace. Allocate bounce pages with __GFP_ZERO to avoid leaking
information to userspace.

Fixes: 8c773d53fb7b ("vduse: Implement an MMU-based software IOTLB")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260130050750.4050-1-jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 0a9f668467a8df..ec743bed361c17 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -124,7 +124,7 @@ static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
 		if (!map->bounce_page) {
 			head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_MAP_SHIFT];
 			if (!head_map->bounce_page) {
-				tmp_page = alloc_page(GFP_ATOMIC);
+				tmp_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
 				if (!tmp_page)
 					return -ENOMEM;
 				if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 717e132ba5c64b..2ee786b7607d15 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -907,7 +907,7 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 	if (!token.group)
 		return NULL;
 
-	addr = alloc_pages_exact(size, flag);
+	addr = alloc_pages_exact(size, flag | __GFP_ZERO);
 	if (!addr)
 		return NULL;
 
-- 
2.53.0

