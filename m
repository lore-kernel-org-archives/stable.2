Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273467;
	b=1dFC8QTQc5wsitjsvhuARoFShyzJC3OI7SUGWa7CFAFkEyF/TQ3NQ517BlMlc6ksoyWZ
	 AI9OyCbvaAo3UktVu5vrK+RyD4FHKYj+p6l2VvI49kEm7v+JNGLKaejvo0dT/uRWe/Ll/
	 dBVbFBCI9WLcDoaGRN0NkkrIeP4HAeAtWNxqT/Rfvi5LvsgYdrAP9mvh8KhkN/QIdn1RW
	 0So/Nqxln2pSkBDI3TyeKxRBHPRtLh47hQ9EBs6AK+T/naRlbOnZsTiLy24YvvL6wZnBJ
	 4Dt+iU8w9KdiyZOspzRiBKyrlnpF9UBfRYBT0dvHhid+VJWmrJgVTFmn2oySI7T0ZUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273467;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vLMNXgVM/xmOhCHJO087VpliLE4VfK/BcIYeASI+cUc=;
	b=ytYTm2Fub79wTHmWqw3z0eaLMvIVD4D3Rhq1suq5MH2fL0t+SoogsWIccglmHeSbgahZ
	 JVdpSksQpNA+Fw668YC2OSQCXaN2OkS7QjbRv7WoxBLzd0Fwa+8Vp6gTFtLscwwc7PMFQ
	 966Ih/UuuxYmg3DpoMQilTK/Sws2MKPuiKRXD6bSKXm+sZfjlfkYyBI2YP4Lj7o23f91g
	 0GAV2JcctEUa7JjzP+9/3t+pcjs7uyo0LKdGNhTLR8nnT8sOGZoq1/nV63agKpGIBaczL
	 0hqDtzQHa1qtuyDIwX9gGE14n4hACeE+kJfvngvdTAQYg4d1dyg5ZjupV0ffvM1z5CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gY8sObGE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B021606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gY8sObGE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C426C1F0089F;
	Tue, 10 Nov 2026 01:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273467;
	bh=vLMNXgVM/xmOhCHJO087VpliLE4VfK/BcIYeASI+cUc=;
	h=From:To:Cc:Subject:Date;
	b=gY8sObGE0syxeogKrHkuqgVxY4ijrVhI+n11/e/xgf4v79yo9IHYw72j/m/bhQJ2J
	 soYG5BEU+ouFLzecKy41hl0LtqlX3/ugI8r1DGr+komtReJou2EiG9Qb3m5E3fY/p8
	 QRxQR53qnvV+Dl3LdffAX7hWIAjq32uI+A3m+TxpOjRJbghq2y6xeLwzn61nzeRay9
	 dNxXnBHO76kv4BJm73lP//BaIOpif/SISyMgtMuCLMGr/FE8/GhR2Rpj6/VX0fHFIS
	 5MliKttpoJOFB1ud/BlxnckQj8Ui29eGnrnHJtkrzBlsLd28pGjO/LG1OQF4ubqRva
	 V8GISaGc/JEYg==
From: Sasha Levin <sashal@kernel.org>
To: longpareto@gmail.com,
	xieyongji@bytedance.com,
	mst@redhat.com,
	noreply@anthropic.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] vduse: fix VA/PA confusion in the coherent page fault path" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:17:45 -0500
Message-ID: <20261109201745-failed-6.1-bb2e6f166547@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bb2e6f166547838fd7c320b01c90918b736f76e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201745-failed-6.1-bb2e6f166547@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




