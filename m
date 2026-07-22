Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB02388E4B
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736455; cv=none; b=uL909WJpq52Eft4JLMNX8Q1aSq9LE9C7m4oT6nGXIwkA6Q877uohhqzzcBopTRRJTkrabI8XEavBmz5N5foYsCnXVfReLE47PHxojugLLoZ2gOZ7+vUfekqEsws9ms4OHDo4ajV5NyZ3kapEYMhcxlTaTdxb93khA5pUlLYEcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736455; c=relaxed/simple;
	bh=gunL6rRjsxCwptOKvVifk3SjSd+b28eQ7CfZC+E/Y2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEeKBHpO3HKMPTIdPRCIp7SaJJZnVuJt6yNDaLmJc8CTUlpJpze+ZxD07rvrtpGmD6i2U1UIdm7u7h4APvBca1Te3uU+qIgYli7BzUuOm0/618gs0DkdWLMoFetECF9vKYxK70h1tx2D2iVUJiK++DKmeWzC6KzMVvgpcuRrgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqGgEm4Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqGgEm4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410BF1F00A3D;
	Wed, 22 Jul 2026 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736454;
	bh=ebYeL7BqpPgPI68EWYBa+yQkHZFBTZvRVWco5yIxSXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dqGgEm4Z+7fG9Xm2rGcxesOFtoNKEzyTjwkRzjlr1vf/9/VlWtqRXq7KYFqa0lbnv
	 ayp+EJcf+IZQouav8YovAhOX5qjVPytwzrcWGtF1IebZG6jF22rQWbMDKcanJuQSkw
	 l8EjJK2Ia0kngxodTdBAdYIUcIQPrmVBs/VF64YLFFagTU/hkNC75ESo0r7yk2g6Sp
	 dmBDQLB/8fUVP9AoETWhIqfqLNrio/IJEXmcIrQpeL7vWaIzsedPgrq0fjbkYq/Uhz
	 nWDED1XgFJmm7dtIjsiJ1TV7QUXo1xlJpvo6S/pdz76o82EYTkon7Wnu4rOmDc5Z9r
	 GOV885nEG7Yww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] vduse: remove unused vaddr parameter of vduse_domain_free_coherent
Date: Wed, 22 Jul 2026 12:07:29 -0400
Message-ID: <20260722160731.1739521-2-sashal@kernel.org>
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

From: Eugenio Pérez <eperezma@redhat.com>

[ Upstream commit 766e1749c0ef6a09651be9b8a8283d508c322b58 ]

We will modify the function in next patches so let's clean it first.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260119143306.1818855-9-eperezma@redhat.com>
Stable-dep-of: 9c1523803445 ("VDUSE: avoid leaking information to userspace")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 3 +--
 drivers/vdpa/vdpa_user/iova_domain.h | 3 +--
 drivers/vdpa/vdpa_user/vduse_dev.c   | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 58a94f81175fd6..aab730e8a31671 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -521,8 +521,7 @@ dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 }
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
-				void *vaddr, dma_addr_t dma_addr,
-				unsigned long attrs)
+				dma_addr_t dma_addr, unsigned long attrs)
 {
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	struct vhost_iotlb_map *map;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 153b8c24c47769..ead5ab477079b6 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -71,8 +71,7 @@ dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 				       size_t size, void *orig);
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
-				void *vaddr, dma_addr_t dma_addr,
-				unsigned long attrs);
+				dma_addr_t dma_addr, unsigned long attrs);
 
 void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
 
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 530e5f988dc7c3..a549396fffb9de 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -937,7 +937,7 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 	vdev = token.group->dev;
 	domain = vdev->domain;
 
-	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
+	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
 }
 
 static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
-- 
2.53.0

