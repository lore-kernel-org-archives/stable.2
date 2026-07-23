Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968218CBE1
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769414; cv=none; b=OpNJETeBByb5xvp6kRMHjVFWEFa0kIoQetH8yA8DQrhxicOe8DnaOksZK6ch7SdsUN1AUPgFxdYCliKWcQg3Gq8kM5a6whgXhIH/B6c9KOE6l8WR73rLnpzhlNDumsrOZP05sKyDc4hMhwWViL99b105JQ1+uLCtKuvUj2jYYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769414; c=relaxed/simple;
	bh=Yv23/DmJdLKJy7ixEb2vxMmU3zI6/cOScSXMxlmk948=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URBWrW8rS73wHRmPXI+uHdVLJMuZNntnTs/AhHAwXx7Ewb10xC0LmhCo2GiFVSWge4qfKHxDYt6Sjo3e7d1vlyWoRpWx/uVJv02wpCWKOiOOuzztpOUfyCE0c9v+iWbEqjymwlVT8N2YuW4q7sX/mal198icwEX7NcxaO9fYh5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlCD9SZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlCD9SZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADD11F000E9;
	Thu, 23 Jul 2026 01:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784769412;
	bh=ammtBjEFsCZCQhkxWVl73/AyI4pW1wFhaqtm9YDzVfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DlCD9SZMiDjius5YdT4e1lBTS4n2e4FhFbaUN869rKppRXhGjHhnDXL2/2ewpp2zi
	 PGUn3kl8HS0IBw11afThC2ZlYG5xPjkXv6UuDAPa8og5kHTloLSvooIrDguaIT0l9w
	 aC9OYcyYb/R2mTJGCxO5ZeTnm++f6jUYpenP/+uPwggoVj4r+Lkifpo+z9sPV9OeEn
	 jsYJelzxsu3UUoyEDA2ayCEWvaNWlydG1tiHwUbflPbVR8YEPN9vxhvpOy2vmri9D1
	 iJ7sqaTwhIgugmhyJRQSqB1HuIbpvouZRH7z+uO0OvyqismdeVEsWZHvwSfNkTJw6b
	 SGSowid0vx9NQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] VDUSE: avoid leaking information to userspace
Date: Wed, 22 Jul 2026 21:16:48 -0400
Message-ID: <20260723011648.2779203-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723011648.2779203-1-sashal@kernel.org>
References: <2026072042-challenge-grimacing-a682@gregkh>
 <20260723011648.2779203-1-sashal@kernel.org>
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
index 26f3fb5e0b0677..783319f1607619 100644
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
index 8f05d1bfdb1076..ce84b0fb8428d3 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -776,7 +776,7 @@ static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
 
 	*dma_addr = DMA_MAPPING_ERROR;
 
-	addr = alloc_pages_exact(size, flag);
+	addr = alloc_pages_exact(size, flag | __GFP_ZERO);
 	if (!addr)
 		return NULL;
 
-- 
2.53.0

