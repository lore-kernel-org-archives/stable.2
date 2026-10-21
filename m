Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594334;
	b=OTfCweh7EX3fwy7NpTG6HU10tMROrkcotfL0nCdW8pDaTjNXS8OZw2ZOqXQNHTHglBO1
	 VVlPOGEUBLiG9jRv5SfatD0lyzfaT9iyAtYHb+9ftsgdCPq69h6sEtYSMSeGlh9JUuNNp
	 aeT57AN2di/JXwsp5u0vlVL3tCw1DZ6HgjGWPV2e/2BH5QuXhaU5l5ag2b8z8PNCVCiea
	 5oC4onSU8cDYh/1b3utD7RnwDKzfXXlJY3/IRZc3s4CS3OwLkNZvQqQGad+nfefar4bvU
	 bC+YYHlHW+sjxgZJANmw3sSDwkvMUhtFT+ECCgVmc3nsYfagPaQPBatWKndT8J7mK1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594334;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=d3tShKGOI/LZcPg1MFnzww4mAQ6zIziry3a98OhxP2E=;
	b=ZtY9a2zcjroIkhp86DMGXf0f68qI63lLdWMo8JWebyxSAHpHtevHCDgCo5jMf8OuVbFA
	 ZMXTXOCzoGwsiESYbaPLqwudTqPWf3KENSDOSQUt/Gj5zdkE6kjwEOnoEWY0pAq6N6azH
	 NOt82YUY7SxAR+XN8/twVtd+QlNVC9rW4AL3butH7KLdfiDfuWUnty1bDhLYkzJZjeOS0
	 vv60l/9XsMRI+RD/NPYC/6GBDMgeZS6c4v62KmNuRBdaLg3+gwHHcK6fYyQegjzxrJo3P
	 DZUCGeo+fPuELM3KrAkI9VFLQvUgxbQmz+/B9jtxs1RuoOlamJQiGD8xBemeXl6aF5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sV8tofuw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B3606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sV8tofuw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122471F000C1;
	Wed, 21 Oct 2026 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594333;
	bh=d3tShKGOI/LZcPg1MFnzww4mAQ6zIziry3a98OhxP2E=;
	h=Subject:To:Cc:From:Date;
	b=sV8tofuwMIAI+nN3kE/aTJNubWQS9WOdXGZUiNaNG27RIo7uC9l0YGHGPjNLPcsWG
	 XF/ZpDUj2pWNbPESilWATOaJG2/XhXF0e6LsFTc+i0ESqVUAFocakIiDPov7rCJEcN
	 FWZyezNOHbIAjPmyVk15lQx5xBdRcKlWUrYg3lpQ=
Subject: FAILED: patch "[PATCH] drm/virtio: Reset device before deleting virtqueues on freeze" failed to apply to 7.2-stable tree
To: oss.patchbox@gmail.com,dmitry.osipenko@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:47:22 +0200
Message-ID: <2026102122-pounce-posted-bd6e@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 8907eb42c08b8eebe0f81fee256b34b5675d0e5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102122-pounce-posted-bd6e@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8907eb42c08b8eebe0f81fee256b34b5675d0e5a Mon Sep 17 00:00:00 2001
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Sat, 26 Sep 2026 16:20:27 -0400
Subject: [PATCH] drm/virtio: Reset device before deleting virtqueues on freeze

virtgpu_freeze() waits for the control and cursor queues to drain and
then deletes the virtqueues, but nothing tells the device to stop first.
del_vqs() frees the vring backing, but does not provide a generic device
quiesce operation. In particular, modern virtio-pci keeps enabled queues
active until the device is reset, so the device is left DRIVER_OK with
its queues pointing at memory that has been freed and may be reused while
the guest is suspended. virtio_device_restore() only resets the device
later, on resume.

Reset the device before deleting the virtqueues, the way
virtio_gpu_deinit() already does on removal.

Fixes: cad6a879a7fb ("drm/virtio: Freeze and restore hooks to support suspend and resume")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patch.msgid.link/20260926202040.1313385-1-oss.patchbox@gmail.com

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 2aaa7cb08085..52c174f9bff7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -225,6 +225,7 @@ static int virtgpu_freeze(struct virtio_device *vdev)
 		goto err_resume;
 	}
 
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 
 	return 0;

