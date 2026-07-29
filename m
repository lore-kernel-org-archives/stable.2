Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD068486B8D
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330132; cv=none; b=kB7Lkscibr1piC0piSKSnWPswu8HUArgyjLyyv5kWxn+e15jZ2/gZbmEU1tQecwqzHX0xiKy0kM6pMmtqSuMOW2+AeBCCOCPIKyBjLfCiSIjVHqiF71Ry4y2JeCGBuDZt2i9u4ZB/Nbq/4/lW3yqjU3gRc5h5JAJVCy+DAyj63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330132; c=relaxed/simple;
	bh=yzvV2a7C0MsxtNK8jUV98Uy9ztFvG00vYWVtaAVTc7U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DX19hZfNQmPG82YsUnpwk8AN+C5PMNXMK0H00uSFqlvP7hmYu1SojkBkO22WUrpAxUcMzgUgdeJZafHcn1XWqljKfE989+WEYhcm5bmIAk+hNKQLZlTYsbexgT1B2mvtP1IzL123W4Ez6fJkSHmfIuiQ3kaELHtKE8NMyYlkJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=guypAcyG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="guypAcyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673451F00A3D;
	Wed, 29 Jul 2026 13:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330127;
	bh=RznGgYEo7T7paiCxvbUXtjR3RBfZEseVCVElWJFCh00=;
	h=Subject:To:Cc:From:Date;
	b=guypAcyGlHHlgOPVyEO5Ea/0AE8dLRVGke9iF3wz0g/GrzXX4OZFS+wmA4wrYjRyW
	 9kuOX2IgpWZ5LBuNi8Z7NKK0vWzaaw3usMnM46OlNr95bZiHbS5YpQM2+0K02bW1ge
	 xpyVgxeJKBfnayay7cQ+sDUo+yVB9MKAVSYci91I=
Subject: FAILED: patch "[PATCH] media: stm32: dcmi: unregister notifier on probe failure" failed to apply to 5.10-stable tree
To: mhun512@gmail.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:01:02 +0200
Message-ID: <2026072901-lance-unhealthy-1823@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 084973ebd67b28f0945c5d45408f86c58b540110
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072901-lance-unhealthy-1823@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 084973ebd67b28f0945c5d45408f86c58b540110 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sun, 26 Apr 2026 21:43:49 +0900
Subject: [PATCH] media: stm32: dcmi: unregister notifier on probe failure

dcmi_graph_init() registers the async notifier before dcmi_probe() toggles
the reset line. If reset_control_assert() or reset_control_deassert()
fails afterwards, probe returns through err_cleanup and the driver core
will not call dcmi_remove().

Unregister the notifier before cleaning it up on that error path,
matching the successful remove path and the V4L2 async notifier lifetime
rules.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Fixes: d079f94c9046 ("media: platform: Switch to v4l2_async_notifier_add_subdev")
Cc: stable@vger.kernel.org
[hverkuil: added Fixes tag]

diff --git a/drivers/media/platform/st/stm32/stm32-dcmi.c b/drivers/media/platform/st/stm32/stm32-dcmi.c
index e5663fbe6422..eeb0199864dd 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmi.c
@@ -2195,6 +2195,7 @@ static int dcmi_probe(struct platform_device *pdev)
 	return 0;
 
 err_cleanup:
+	v4l2_async_nf_unregister(&dcmi->notifier);
 	v4l2_async_nf_cleanup(&dcmi->notifier);
 err_media_entity_cleanup:
 	media_entity_cleanup(&dcmi->vdev->entity);

