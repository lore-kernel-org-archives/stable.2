Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F064C9008
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645390; cv=none; b=L80y0t8C3KjVKSvWyYS75WWrGEDzAYaQlFSNem+F//Tm3+kW7TUMewSG/Gs4+Xf+Z8ltGx3aFxZ41ghd67cWgXfP5zFZX0MuzZxfh2Dhh6/6l04i8BRtzFn6+NmsetV928PjfFlzzz16DW6IPJq5qSIy8jZMyBrHBmKHZUof9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645390; c=relaxed/simple;
	bh=ejVIVHiKWAm4KjhOlRkvsk468TKMv0i44TuRTdbuM1s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n3b6xwTKpnB2K5OoCH/k+hmGPCEV5aBajwwQYz7pGjCjw2GF8p4Hy/fn4uCq+IJ6e56V79pt325/l4FQgShx28sNw9o0SUxH0w4RMTc4zWZvEb4PDM+3v/PDatcuTS01yG3li8uC5eiL+KDZXRdDvEoH6O1skgib1gturMd57dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xXZlBrSS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xXZlBrSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDD11F000E9;
	Tue, 21 Jul 2026 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784645387;
	bh=dQXzTghlkET3FQihrX8S9+mpn3EgiNSmliYa+JUyLW4=;
	h=Subject:To:Cc:From:Date;
	b=xXZlBrSSRuyBUBW7gLH9fIORtSui8usPt+MXsV3/mRh5SFHd05ndKkwNO5yDRjBe+
	 erWQ0Tr79gDXMGTmwJ59Bw4PraKrknH0jhHFWp+kbq0Qjwa2kXEygZn4l7aERcTu6D
	 iInZviPy+cq0xPxLU6Lpdkdshx5x7/BkrY4xzRFY=
Subject: FAILED: patch "[PATCH] virtio_net: Allocate rss_hdr with devres" failed to apply to 6.6-stable tree
To: akihiko.odaki@daynix.com,jasowang@redhat.com,kuba@kernel.org,leiyang@redhat.com,mst@redhat.com,xuanzhuo@linux.alibaba.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 16:49:38 +0200
Message-ID: <2026072137-exposure-untamed-fcfc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4944be2f5ad8c74b93e4e272f3a0f1a136bbc438
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072137-exposure-untamed-fcfc@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4944be2f5ad8c74b93e4e272f3a0f1a136bbc438 Mon Sep 17 00:00:00 2001
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 21 Mar 2025 15:48:35 +0900
Subject: [PATCH] virtio_net: Allocate rss_hdr with devres

virtnet_probe() lacks the code to free rss_hdr in its error path.
Allocate rss_hdr with devres so that it will be automatically freed.

Fixes: 86a48a00efdf ("virtio_net: Support dynamic rss indirection table size")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Link: https://patch.msgid.link/20250321-virtio-v2-4-33afb8f4640b@daynix.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e46241c6fdab..aac5a5184ba9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3642,7 +3642,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
 		old_rss_hdr = vi->rss_hdr;
 		old_rss_trailer = vi->rss_trailer;
-		vi->rss_hdr = kzalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+		vi->rss_hdr = devm_kzalloc(&dev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
 		if (!vi->rss_hdr) {
 			vi->rss_hdr = old_rss_hdr;
 			return -ENOMEM;
@@ -3653,7 +3653,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 
 		if (!virtnet_commit_rss_command(vi)) {
 			/* restore ctrl_rss if commit_rss_command failed */
-			kfree(vi->rss_hdr);
+			devm_kfree(&dev->dev, vi->rss_hdr);
 			vi->rss_hdr = old_rss_hdr;
 			vi->rss_trailer = old_rss_trailer;
 
@@ -3661,7 +3661,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 				 queue_pairs);
 			return -EINVAL;
 		}
-		kfree(old_rss_hdr);
+		devm_kfree(&dev->dev, old_rss_hdr);
 		goto succ;
 	}
 
@@ -6768,7 +6768,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
 	}
-	vi->rss_hdr = kzalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+	vi->rss_hdr = devm_kzalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
 	if (!vi->rss_hdr) {
 		err = -ENOMEM;
 		goto free;
@@ -7051,8 +7051,6 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	remove_vq_common(vi);
 
-	kfree(vi->rss_hdr);
-
 	free_netdev(vi->dev);
 }
 

