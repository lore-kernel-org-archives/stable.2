Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273768;
	b=zsMQybQ/gLhVUKEkJTRxQSB5BgI8jPFGme2lPXuokPFenhHjGfkI8TDvyTrZQcesqNiS
	 +ocuaPegJe4WsJ3M1faThzE/R18bc/oL/ckfX7uQenpXaNAF63+gzEzQi3DpCMveG/vTV
	 iU8de/KxmQT9xGhQ0za4ffEv4Conoc67AEE7Leh8MYsH6+WF9PNSHLLLLpTAaaiffdmeW
	 Cr0fI2hjULdX7U9+o+EoSvjil7+Mt+fIBkqbKMrD0qvdgsMrnCjw+HZC3ifNWoYeSrWjA
	 cYHROuTg4HLb1iNnPmcDVwLBaQdHLmGozIv6EELlL/noVOsnIJd84/psAqtR8pEPIgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273768;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZOqavrM09P//gdreE5dvfGk4z/SJxEqpSI/c5Dht9fI=;
	b=lUOYjl37eUWG7Ey+VGbokayLhuR9L8DCp0XryLr7XSArTv0yaAJ7V6k7eIixbouOrVXa
	 doe3jWD6pC10EzVdvMJzQVwp4SEjO4gk5uUGAKroIcDYrFcFTwcwdi2wlYb225xwl3Kan
	 N/iLmmM+P76cIY7sMSAWoo1XYvCy7BTp5QSoQbARWVlQvkNLlI7rCaz7fXgsOVxEvARD9
	 aRq82M5iFJjSB//0qhCNL/oflIpg0O6GaHdUj6xab/hs/jbYRYp48vZ/Ffg7iDI3+FRUd
	 xrs0CRyDVgit+kjfdg4QeLEzNLV945RgaUv0HrKufIMOVoBBlQTiqnUCPIn/gKrqhWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7+DmFyV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED9606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7+DmFyV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1921F0089F;
	Tue, 10 Nov 2026 01:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273767;
	bh=ZOqavrM09P//gdreE5dvfGk4z/SJxEqpSI/c5Dht9fI=;
	h=From:To:Cc:Subject:Date;
	b=I7+DmFyV3zD6dzsYJPDMq84AXhxrCRvhQ4DumRRLkbkqQR64PySuDiS17MWBAC0x5
	 E2FO0JUBplRApwWfkJ4WYeu2nlHA7MnAP8ulTwZmfPnEs+DmBmOnzVPeOGiFXEdln8
	 eujoksxcfu3Ekh9b89pcbgkkKEvq1qocti7ERQ0kJozJOJdQR6uhpmE+LhUJwU/P+w
	 qa8zNT4sJqHMQbjunMwkj7icrvyebL1aPPQuR0CoQ/ApaVDRtGN0bisbGMKIbILoiZ
	 3bnCau0f3DeFtE3mTL4eFsJLJvsW2doAnmAAXgkU5EFlV3vWBeifRPdB3cl4OZOZ5t
	 y2zlp/iiVD7XA==
From: Sasha Levin <sashal@kernel.org>
To: longpareto@gmail.com,
	xieyongji@bytedance.com,
	mst@redhat.com,
	noreply@anthropic.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] vduse: fix VA/PA confusion in the coherent page fault path" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:22:45 -0500
Message-ID: <20261109202245-failed-5.15-bb2e6f166547@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bb2e6f166547838fd7c320b01c90918b736f76e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202245-failed-5.15-bb2e6f166547@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bb2e6f166547838fd7c320b01c90918b736f76e2 Mon Sep 17 00:00:00 2001
From: "chenglong.ma" <longpareto@gmail.com>
Date: Mon, 2 Nov 2026 12:08:55 -0500
Subject: [PATCH] vduse: fix VA/PA confusion in the coherent page fault path

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
---
 drivers/vdpa/vdpa_user/iova_domain.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index b6c958224b7ce..28a977248a0d3 100644
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
@@ -226,6 +230,7 @@ vduse_domain_get_coherent_page(struct vduse_iova_domain *domain, u64 iova)
 {
 	u64 start = iova & PAGE_MASK;
 	u64 last = start + PAGE_SIZE - 1;
+	struct vdpa_map_file *map_file;
 	struct vhost_iotlb_map *map;
 	struct page *page = NULL;
 
@@ -234,6 +239,10 @@ vduse_domain_get_coherent_page(struct vduse_iova_domain *domain, u64 iova)
 	if (!map)
 		goto out;
 
+	map_file = (struct vdpa_map_file *)map->opaque;
+	if (!map_file || map_file->file != domain->file)
+		goto out;
+
 	page = pfn_to_page((map->addr + iova - map->start) >> PAGE_SHIFT);
 	get_page(page);
 out:
@@ -579,7 +588,7 @@ static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct vduse_iova_domain *domain = file->private_data;
 
-	vm_flags_set(vma, VM_DONTDUMP | VM_DONTEXPAND);
+	vm_flags_set(vma, VM_IO | VM_DONTDUMP | VM_DONTEXPAND);
 	vma->vm_private_data = domain;
 	vma->vm_ops = &vduse_domain_mmap_ops;
 
-- 
2.53.0




