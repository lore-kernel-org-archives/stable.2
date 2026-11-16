Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794797188;
	b=xgBx2QuUdIj0teAN+a9I5QnqFeZTYqTl+bqv1nGMMjy+G0pjhsExXqqmc+kRM2ZW9zGJ
	 Gmaf6xWrq0ow+3NUpWkyv14hq7CTOyXBnyPPt7LNIRyFMlONHq0jqbgqxSasq7pyDzfZw
	 UWmy7z59ZCcvW8edYsdJpKIsQX9gMleFfv00G5k55A3Gd7qe/nja6BfsSp5KQZmNxC0cR
	 mvHry/34zrbgCHOUUgFuP7Ud0xPDhT3oWQnnOrvL8Opo5qkGQFc9nl3izroGanM1ibwAd
	 DFV7jCrvv0fCj+Eq6dsVahW6R2LQwpQ9tgM8vauEIdRrziULJSzFvGCmXczrG22NsQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794797188;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/fqBO00/DFAzvxk5Mf9LNLQgbnCrN5lDLWiAWKz28NM=;
	b=NPYVCgACyN8LYQHjXBRtirllXrKpFdKc/I9KbLWfgKv0a6yAkE68gLI+W+rGlGFchBK2
	 7WSQ3xzfnur245GL35nR03iIMxfX2bmLDOXQd+pKvAoUup2lYKiImME2TGSkvYewmASsJ
	 0OAhzMIQbaomdX2dU12k9jWMxuIjtgIji5sPfWJCToKC6CHHqNo4YxaVu6ITF1301sWR/
	 ZTVFHge4t3XUDXu4re/HybyyM2IoA3MDTCe3vgDUD1quNzMvAmpsg5jSUUU1bCwSrahvK
	 +F6UONmN3KBpJavwtdbEyxEOvdGgedmQ82LohPiw5QlweecElkRVqfjctv+Eoy3IXPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcQB5I9u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE21606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcQB5I9u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123FC1F000C4;
	Mon, 16 Nov 2026 02:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794797187;
	bh=/fqBO00/DFAzvxk5Mf9LNLQgbnCrN5lDLWiAWKz28NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OcQB5I9uDCpkCveFxAZ1zLLpkdUMurL83vwYgkp/EckUcihT6MR2EQ2clqMRvTlj7
	 jlJJ7OPFGv2Y48zxgE4UYQ4zb8qPh2hVP189Tu3W0jcKwaXUQowHYeX3Q444VAt8D+
	 eBmZzlmzhavNJnT9AzuqKZ5lT7zh+uxx7/OVqMNBHfRpK26NlPw/R/i56HM/lPOn2y
	 iDDvhFBJaxiYLFRHDdoiI45W5pF2Ti+ed4HfYQF/XoC/UcZ95vXhfHakSq+f6FwIzm
	 /DeUMhoyIHD1cL6Rag9tY4aEcLfIO7ON3bQwA2IgNimB9gG/jWMO4V54aJC4Yn2Y5b
	 O6fA1h2FtKm9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xie Yongji <xieyongji@bytedance.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] vdpa: factor out vhost_vdpa_pa_map() and vhost_vdpa_pa_unmap()
Date: Sun, 15 Nov 2026 21:46:23 -0500
Message-ID: <20261116024616.2408867-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202626-failed-5.10-fd1462c96baf@kernel.org>
References: <20261109202626-failed-5.10-fd1462c96baf@kernel.org>
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

From: Xie Yongji <xieyongji@bytedance.com>

[ Upstream commit 22af48cf91aae5f2fd32fe811d9be1c52d7a801b ]

The upcoming patch is going to support VA mapping/unmapping.
So let's factor out the logic of PA mapping/unmapping firstly
to make the code more readable.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Link: https://lore.kernel.org/r/20210831103634.33-10-xieyongji@bytedance.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Stable-dep-of: fd1462c96baf ("vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vdpa.c | 55 ++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index db488b98cc9f9..43e7528b8fa03 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -517,7 +517,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	return r;
 }
 
-static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v, u64 start, u64 last)
+static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v, u64 start, u64 last)
 {
 	struct vhost_dev *dev = &v->vdev;
 	struct vhost_iotlb *iotlb = dev->iotlb;
@@ -539,6 +539,11 @@ static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v, u64 start, u64 last)
 	}
 }
 
+static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v, u64 start, u64 last)
+{
+	return vhost_vdpa_pa_unmap(v, start, last);
+}
+
 static void vhost_vdpa_iotlb_free(struct vhost_vdpa *v)
 {
 	struct vhost_dev *dev = &v->vdev;
@@ -619,38 +624,28 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
 	}
 }
 
-static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
-					   struct vhost_iotlb_msg *msg)
+static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
+			     u64 iova, u64 size, u64 uaddr, u32 perm)
 {
 	struct vhost_dev *dev = &v->vdev;
-	struct vhost_iotlb *iotlb = dev->iotlb;
 	struct page **page_list;
 	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
 	unsigned long lock_limit, sz2pin, nchunks, i;
-	u64 iova = msg->iova;
+	u64 start = iova;
 	long pinned;
 	int ret = 0;
 
-	if (msg->iova < v->range.first || !msg->size ||
-	    msg->iova > U64_MAX - msg->size + 1 ||
-	    msg->iova + msg->size - 1 > v->range.last)
-		return -EINVAL;
-
-	if (vhost_iotlb_itree_first(iotlb, msg->iova,
-				    msg->iova + msg->size - 1))
-		return -EEXIST;
-
 	/* Limit the use of memory for bookkeeping */
 	page_list = (struct page **) __get_free_page(GFP_KERNEL);
 	if (!page_list)
 		return -ENOMEM;
 
-	if (msg->perm & VHOST_ACCESS_WO)
+	if (perm & VHOST_ACCESS_WO)
 		gup_flags |= FOLL_WRITE;
 
-	npages = PFN_UP(msg->size + (iova & ~PAGE_MASK));
+	npages = PFN_UP(size + (iova & ~PAGE_MASK));
 	if (!npages) {
 		ret = -EINVAL;
 		goto free;
@@ -664,7 +659,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 		goto unlock;
 	}
 
-	cur_base = msg->uaddr & PAGE_MASK;
+	cur_base = uaddr & PAGE_MASK;
 	iova &= PAGE_MASK;
 	nchunks = 0;
 
@@ -695,7 +690,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 				csize = PFN_PHYS(last_pfn - map_pfn + 1);
 				ret = vhost_vdpa_map(v, iova, csize,
 						     PFN_PHYS(map_pfn),
-						     msg->perm);
+						     perm);
 				if (ret) {
 					/*
 					 * Unpin the pages that are left unmapped
@@ -724,7 +719,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 
 	/* Pin the rest chunk */
 	ret = vhost_vdpa_map(v, iova, PFN_PHYS(last_pfn - map_pfn + 1),
-			     PFN_PHYS(map_pfn), msg->perm);
+			     PFN_PHYS(map_pfn), perm);
 out:
 	if (ret) {
 		if (nchunks) {
@@ -743,13 +738,33 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
 				unpin_user_page(pfn_to_page(pfn));
 		}
-		vhost_vdpa_unmap(v, msg->iova, msg->size);
+		vhost_vdpa_unmap(v, start, size);
 	}
 unlock:
 	mmap_read_unlock(dev->mm);
 free:
 	free_page((unsigned long)page_list);
 	return ret;
+
+}
+
+static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
+					   struct vhost_iotlb_msg *msg)
+{
+	struct vhost_dev *dev = &v->vdev;
+	struct vhost_iotlb *iotlb = dev->iotlb;
+
+	if (msg->iova < v->range.first || !msg->size ||
+	    msg->iova > U64_MAX - msg->size + 1 ||
+	    msg->iova + msg->size - 1 > v->range.last)
+		return -EINVAL;
+
+	if (vhost_iotlb_itree_first(iotlb, msg->iova,
+				    msg->iova + msg->size - 1))
+		return -EEXIST;
+
+	return vhost_vdpa_pa_map(v, msg->iova, msg->size, msg->uaddr,
+				 msg->perm);
 }
 
 static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
-- 
2.53.0

