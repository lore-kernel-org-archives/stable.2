Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A741B8C4
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065509; cv=none; b=kWhgyfPkBsKLpivR4uGfu8Ec1u/Q/8GY4qzGUGX1RXccA0pPXRg9TPhnBcY2ldyPEjnpDtrk17l+l56i1NQqDTrMvq+CHZa1KUp83g5l4WwAji82wBkFrDvwnMmoRVg42KPPpc/EyndWrVK6oNtwy4aXXorG7lL7XyWy3ZutzSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065509; c=relaxed/simple;
	bh=0WxEMcsnQLN7s/Vnbs71u3fzX01QsdZo26KFYv/Af4E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H12HEe1o64u8cjLljqtM89CJl7JQDNKMrDJ+qPJg7mAXqcvPh8aABqmEtQAEcHf3dZ4NoRy5E3Pm8SKFu1wz9ix9oT9Pb3kGQ/Aa1uGTYi8+YNqEOMtnb6CHK+LaeMuX+lwPpPhm9prk5036/rbVKj62wa0diglFSv7pAoUEQzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rA65WH30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rA65WH30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CE91F00893;
	Tue, 22 Sep 2026 08:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790065508;
	bh=qNMDK2svWMaIyK4ANyDtZAxmxjVQYGKQW4OnZRBvGPE=;
	h=Subject:To:Cc:From:Date;
	b=rA65WH3052IwwjGC2M8PzkcUAEh8iHe0RcDecr+ZaNnoreFmUMkxNBgJdUu9DpKZz
	 Jfh9Fd4WeXq/cbnXij9789IzD6dryazMpL6loYEnsEXynbLiqR8vqN6GX/BjzHXoeH
	 nOcKvISaMYuSN1DxtFzS8EeSrHk0HkWr2xuT6QGI=
Subject: FAILED: patch "[PATCH] ALSA: virtio: reset device before deleting virtqueues" failed to apply to 5.15-stable tree
To: oss.patchbox@gmail.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 10:25:04 +0200
Message-ID: <2026092204-startup-jelly-4cfd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6c05d00af307560e6a9f1631d6270d3df5aa2272
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092204-startup-jelly-4cfd@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6c05d00af307560e6a9f1631d6270d3df5aa2272 Mon Sep 17 00:00:00 2001
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Thu, 10 Sep 2026 23:11:21 -0400
Subject: [PATCH] ALSA: virtio: reset device before deleting virtqueues

virtsnd_remove() and virtsnd_freeze() delete the virtqueues before
resetting the device. del_vqs() frees the vring backing, but does not
provide a generic device quiesce operation. In particular, modern
virtio-pci keeps enabled queues active until the device is reset.

Reset the device before deleting the virtqueues so it can no longer
access the vring memory when that memory is released. This also covers
probe failures after DRIVER_OK, which unwind through virtsnd_remove().

Fixes: de3a9980d8c3 ("ALSA: virtio: add virtio sound driver")
Fixes: 575483e90a32 ("ALSA: virtio: introduce device suspend/resume support")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
Link: https://patch.msgid.link/20260911031121.1542502-1-oss.patchbox@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 647190f4d5af..6f35276416fe 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -354,8 +354,8 @@ static void virtsnd_remove(struct virtio_device *vdev)
 	if (snd->card)
 		snd_card_free(snd->card);
 
-	vdev->config->del_vqs(vdev);
 	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
 
 	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
@@ -383,8 +383,8 @@ static int virtsnd_freeze(struct virtio_device *vdev)
 	virtsnd_disable_event_vq(snd);
 	virtsnd_ctl_msg_cancel_all(snd);
 
-	vdev->config->del_vqs(vdev);
 	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
 
 	for (i = 0; i < snd->nsubstreams; ++i)
 		cancel_work_sync(&snd->substreams[i].elapsed_period);

