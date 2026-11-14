Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669597;
	b=ucV76o1M2JT4HNqgx671wgPZRsuBwKxwFo1FEwS4lRQ6WPTr9b2QibgSar+w+m6pgoLx
	 7wT5Sukp2uFqBcexbFuFOxi9udnvtZqICeZNDtu2fOxVgyb/5ryUNaUUWdfM+uWPk0JIn
	 WHs/EYJeee7jaa5iQXX0T4YoYE7rw2+cze8xtHER9VhvtecyL3DBNDV5bOAIkS2GjzAEY
	 kaWEoxUMzro6i2VH3U69i9jpz8CizdZ17nU9djk1JEPTXRNAD9iS5Dlcf+DRyoAOy1DqN
	 AX+KCA7PUQuI24bbJb//G38xW/qXCIhtjIp3xacjXZ8yFZ+X9MyRjV6Nl2O8VSettRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669597;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O43KhNj/rILGfD9+jbPiKhcv5yPxjs1K9MtO2LtKnH4=;
	b=JmkAWDIV1f2MUg2yB1Dhj6Txtu+zfH4zYVgkIi2rEbbu9OqeJ6vBnFjg6wF63PdNvLzp
	 lK4O984TF7CP5l9bbZDQkHBNKwMy0dWSrVwZ6ZQJOnuznNpsByo3k5gFufH8KK939aEAq
	 rzifyPFEzl4/oOps1yFuSGJtuFQStSbASNHqwqgmn4Hor4mvJJZlcpaFO8VNAKLo/DN8S
	 zjHyTeKbjksY003IFZjKe1VJMWrVZdm6vmIyy3iX838UNydu5UrXu/tHSEcBPR7U3bskd
	 Fla4gWRQqd+hTCApdpBy4qvoVcakoc/K1i0rDnIlsrvS+U+Cu352l6kk+McpdEFfAVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLwLtsG9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBB606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLwLtsG9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804101F000C4;
	Sat, 14 Nov 2026 15:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669597;
	bh=O43KhNj/rILGfD9+jbPiKhcv5yPxjs1K9MtO2LtKnH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gLwLtsG99BXbv7jyRbVk4JWF3e0tXa7YT5HhWVqO+IeHAZWzkYKZKwnFoGo7Zcvy8
	 Buq1o2hIDeD4aEEQXsa+lNM8hW+xo8muWi7qqTEmR4vbF7M+Cob7PSPSvycTQ+pShp
	 Sm7LHS+QCEHLe5zZHoN1DeTlPBcuuZKIq8KngNWcLpHCuByfwj7TZcWJxkK02VMuP7
	 RzKcgmulcl0KJlvSmVI0DE/KpvjKpRQF6sC1aFSkUvB/brE8ieK3+N5GIPdzsCAvPb
	 jde/hWHqwmDF/nZdK5pQJq40ej7Nhd4KfyQoSuM+5ZtF3UobvvjuE3DjpO+PBHygsN
	 0hxHTQhubGm0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "chenglong.ma" <longpareto@gmail.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Claude Code <noreply@anthropic.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] vduse: fix VA/PA confusion in the coherent page fault path
Date: Sat, 14 Nov 2026 10:19:55 -0500
Message-ID: <20261114151931.3517070-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201745-failed-6.1-bb2e6f166547@kernel.org>
References: <20261109201745-failed-6.1-bb2e6f166547@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "chenglong.ma" <longpareto@gmail.com>

[ Upstream commit bb2e6f166547838fd7c320b01c90918b736f76e2 ]

vduse_domain_get_coherent_page() assumes that iotlb entries above
bounce_size were installed by vduse_domain_alloc_coherent(), so it
treats map->addr as a physical address. But vduse registers with
use_va = true, and when the device is bound to vhost_vdpa,
vhost_vdpa_va_map() stores a userspace virtual address in map->addr,
which vduse_domain_set_map() then copies into the same iotlb. A
process holding the domain file descriptor across a rebind can
therefore fault in an arbitrary physical page with read/write
access, ignoring the entry permissions.

Additionally, since the domain file mmap lacks VM_IO, the domain
file itself can be mapped and passed to vhost_vdpa_va_map(),
producing self-referential entries that bypass the coherent path
check.

To fix, only translate entries whose backing file is the domain
file itself in vduse_domain_get_coherent_page(), reject such
entries in vduse_domain_set_map() since only external mappings
should be imported, and set VM_IO on the domain file mmap so
vhost_vdpa_va_map() refuses to map it in the first place.

Fixes: 8c773d53fb7b ("vduse: Implement an MMU-based software IOTLB")
Cc: Xie Yongji <xieyongji@bytedance.com>
Cc: stable@vger.kernel.org
Reported-by: chenglong.ma <longpareto@gmail.com>
Signed-off-by: chenglong.ma <longpareto@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Co-Authored-By: Claude Code <noreply@anthropic.com>
[ sashal: replaced vm_flags_set() with a direct vma->vm_flags |= update because the helper is unavailable ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index e60a2b4065af9..a0c6835019a63 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -76,6 +76,10 @@ int vduse_domain_set_map(struct vduse_iova_domain *domain,
 	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
 	     map = vhost_iotlb_itree_next(map, start, last)) {
 		map_file = (struct vdpa_map_file *)map->opaque;
+		if (!map_file || map_file->file == domain->file) {
+			ret = -EINVAL;
+			goto err;
+		}
 		ret = vduse_iotlb_add_range(domain, map->start, map->last,
 					    map->addr, map->perm,
 					    map_file->file,
@@ -222,6 +226,7 @@ vduse_domain_get_coherent_page(struct vduse_iova_domain *domain, u64 iova)
 {
 	u64 start = iova & PAGE_MASK;
 	u64 last = start + PAGE_SIZE - 1;
+	struct vdpa_map_file *map_file;
 	struct vhost_iotlb_map *map;
 	struct page *page = NULL;
 
@@ -230,6 +235,10 @@ vduse_domain_get_coherent_page(struct vduse_iova_domain *domain, u64 iova)
 	if (!map)
 		goto out;
 
+	map_file = (struct vdpa_map_file *)map->opaque;
+	if (!map_file || map_file->file != domain->file)
+		goto out;
+
 	page = pfn_to_page((map->addr + iova - map->start) >> PAGE_SHIFT);
 	get_page(page);
 out:
@@ -565,7 +574,7 @@ static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct vduse_iova_domain *domain = file->private_data;
 
-	vma->vm_flags |= VM_DONTDUMP | VM_DONTEXPAND;
+	vma->vm_flags |= VM_IO | VM_DONTDUMP | VM_DONTEXPAND;
 	vma->vm_private_data = domain;
 	vma->vm_ops = &vduse_domain_mmap_ops;
 
-- 
2.53.0

