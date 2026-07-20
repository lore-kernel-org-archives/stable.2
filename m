Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2534364941
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549640; cv=none; b=R35pHd7iDd01DofKwPkfmHooI7uGsXsjhOpUCVDrWhMFqTuh+Jb0uFUp6iho7K9+IF+sL/yR6OYLpcwfiaCnMgLDpSO3BTmF3X7ELc1CHRiI+D+Rxf6Kzk+PujQAej/iLN7QRcTNpI6GB+maUtObbFW4pSgavwlAL1is0MU1Mg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549640; c=relaxed/simple;
	bh=fTTy0tfvfrQkKMDpQ2Gsp2EHLjy1//jc/ZuOq5d88pA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DmmSHCsxA7rQVQ1UmqXrXVFGWk0gAohFsa39eQp3q+7HnWqLlBmPhnDwdMN38SYkntpBYCzvQVV9UiW4Ec3pe0EugO0xNWC2x+gl9sUcJ5i2GbXn9EtFCaZoGoYPEEPadhUr9SGJanvyj1LjXGQLnZyhx5nDRuMpAg931QGbo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XNmLI3zv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XNmLI3zv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116C31F000E9;
	Mon, 20 Jul 2026 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784549638;
	bh=vkzmFnKoUEGeTTqtdBTc5YFDI9wGoT9rFvdQZ7Mvdzg=;
	h=Subject:To:Cc:From:Date;
	b=XNmLI3zvialOUSypJylzx5E8wZqAaAW1ES2ozYr38BUtciMxL8aXFQv9rRzqgYydV
	 Gn69E5Pccq6uIjYjxR2Q0TAik3uiUJf+AEawZyKjL2hctsSIZkARU2L+o9SEzNKkDw
	 P40ovM1cO4hxPtNfqSyCxAsSut7fQxyIICBmn+Ac=
Subject: FAILED: patch "[PATCH] VDUSE: avoid leaking information to userspace" failed to apply to 6.12-stable tree
To: jasowangio@gmail.com,eperezma@redhat.com,jasowang@redhat.com,mst@redhat.com,xieyongji@bytedance.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:13:41 +0200
Message-ID: <2026072041-theft-grievous-be50@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9c1523803445ee0348f62b77793266dd981596e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072041-theft-grievous-be50@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9c1523803445ee0348f62b77793266dd981596e0 Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowangio@gmail.com>
Date: Fri, 30 Jan 2026 13:07:50 +0800
Subject: [PATCH] VDUSE: avoid leaking information to userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 806cec32c4bc..4dc76c0d0d13 100644
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
index 81409a5bb09b..9ebbe6541157 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -999,7 +999,7 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 	if (!token.group)
 		return NULL;
 
-	addr = alloc_pages_exact(size, flag);
+	addr = alloc_pages_exact(size, flag | __GFP_ZERO);
 	if (!addr)
 		return NULL;
 

