Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794670159;
	b=UF3E+7UEcA6gGO5vqdyOF0eUuMGSNELp+hJKPjKV9Gsez6J74jRImXn8wi0WMJ6JTaJ2
	 mLUY8I6AoHu2Gn1JWd1d2tordVmpSee2QRodRYhM32BSb6PrYzM5/WS0cwjvVV3cFgaV4
	 qgrDXj0eyJARFDBY8AqH4JuJTFu+l9RUBSzhG6PANk6oKdbyxRZtgwgMKJ+ho3gvYOPiu
	 4MP6q7HIx3j4OpOakgL+qerXz6LOZtZl0UMZEWFbA8jXNgX3hZVClXIUl4cZPpL/W4UTM
	 7rSxonSJCX+hVy816ag0gYcjoNuPIWo4i/EWdO5r3cdmfCYicSzsByS7kTAWgSG6dXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670159;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oo9FGZn+kAY7RMU2L5lNed4g7wmfWYiHWyec1Xpn9Zs=;
	b=HX0jFTaxZUQtRyikytPnJjaLBIdBLgzE1OZ6KSK+TBGBN3rqzpSgQODooIploZBmNsff
	 WwXAyEET+QGT+MRi5X3vDMLOaTSCnqqFCodA4GfvU6iWDI5dpZS+OElIaO0sa8J/lAhXs
	 JfSNG+798ohLVu1KCq3jRGi2Z7jPGgl04DUf5RHvY5PSMT7FLyRO7gIl3zrSazpj68Mq2
	 FFTMnoF0uXMUexLgTnJk/Ud5+n0jq52iZ111FIqTo7pxNUiJ8SQCTWklnCDS33vbnRIOE
	 d0sQGe1q/oZHskMtDVaTlc/3zk5lweSIDmTKwhbzjnntOx7vXm/Rjk6OHxJ78aWDMnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DD5axy0W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C1606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DD5axy0W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BF41F000C4;
	Sat, 14 Nov 2026 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794670158;
	bh=oo9FGZn+kAY7RMU2L5lNed4g7wmfWYiHWyec1Xpn9Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DD5axy0We36CFC+UHD3exKULuMBzd9LYsMSKQ5ROD2lzSLRe3IqFGYuKUnAb/OSM0
	 cTWkf8aIRsNEdSxNSUC4AGYDMQU3YJQ2/VGEkuopYNiJJNR/olMqmIefwoNZ/tvN/B
	 xTpCMdwek6W60OgcBQoGOhVTrX8UFvOuta6CMPBS0pG5T2ts7zhXONwr5y3D12PWMj
	 L5iVy6ZcOwGla7HkrL4QKV4YRj3i6nQ6LObHZnrqka0261nTxaTuPlKSHC/+6O027i
	 0NvNCnLEoKSTvNKaLW36cMgpsPk4wnqmrvkg/uxxH6i17Lp6hPzt92YAikBFln9XNN
	 K6rvB/r3rbg8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "chenglong.ma" <longpareto@gmail.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Claude Code <noreply@anthropic.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] vduse: fix VA/PA confusion in the coherent page fault path
Date: Sat, 14 Nov 2026 10:29:16 -0500
Message-ID: <20261114152858.3620628-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202245-failed-5.15-bb2e6f166547@kernel.org>
References: <20261109202245-failed-5.15-bb2e6f166547@kernel.org>
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
[ sashal: Replaced vm_flags_set() with a direct vma->vm_flags |= update because the helper is unavailable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 783319f160761..e7f1ed339b206 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -70,6 +70,10 @@ int vduse_domain_set_map(struct vduse_iova_domain *domain,
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
@@ -216,6 +220,7 @@ vduse_domain_get_coherent_page(struct vduse_iova_domain *domain, u64 iova)
 {
 	u64 start = iova & PAGE_MASK;
 	u64 last = start + PAGE_SIZE - 1;
+	struct vdpa_map_file *map_file;
 	struct vhost_iotlb_map *map;
 	struct page *page = NULL;
 
@@ -224,6 +229,10 @@ vduse_domain_get_coherent_page(struct vduse_iova_domain *domain, u64 iova)
 	if (!map)
 		goto out;
 
+	map_file = (struct vdpa_map_file *)map->opaque;
+	if (!map_file || map_file->file != domain->file)
+		goto out;
+
 	page = pfn_to_page((map->addr + iova - map->start) >> PAGE_SHIFT);
 	get_page(page);
 out:
@@ -461,7 +470,7 @@ static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct vduse_iova_domain *domain = file->private_data;
 
-	vma->vm_flags |= VM_DONTDUMP | VM_DONTEXPAND;
+	vma->vm_flags |= VM_IO | VM_DONTDUMP | VM_DONTEXPAND;
 	vma->vm_private_data = domain;
 	vma->vm_ops = &vduse_domain_mmap_ops;
 
-- 
2.53.0

