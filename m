Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633311;
	b=vzarPJgEdkBIPDjje9KTh/lGQSn5N699SYOJkV/U98ajl2K1XpmAqucEd6NfjnXXsCzP
	 zS8nPgwVEx4BxYsjCroYoJQIpyl7YgSOOZIF0ES+gBCHjuL5Jj7Qxy7gj8J1LvMKOmSzo
	 jBZys09uESTMrrUF/B8MbVj1GwaDmMM96/dxevLAwO1VvxbbNK3c6ujRPRcqD+4KpLoXF
	 p9G/tZa+kn32C1JBKygJSQx6Ov3W/v0c3oXfUPkHBtfkZgaOju/CLWHw5RtxW00tYLMGM
	 k0q1M/d72ieodqwUYYSYC8k1n5KuQFoQj8lgU2R8c2ALFCHXaxqjIhkaAyyeGklbujA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633311;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XA0gLzbn7f2AjvwhezWlVJXDT1t5FEzHWTu1c5zyhoE=;
	b=zrT4Nxywi7YGimNCq2zfMbOm+X21wU94EFztBUfy01h2a89WOih9eyWnQH25+xgdQ/6a
	 WapFSjcrmqXbeMjimJ0ftG9ytI3nKmEKLywXJvUTDv4mM+crOWaKbgzGXJTlxo4I4Q/hw
	 LYlWvT1pUt4f8j+LMcIUElSLL2nmjeA4m/KS+ddvm+wXDbim07508lMUrnN2BUUIa2cpW
	 W44ROjsm0zc3gx1SGNORPsDCfwXgtE+mCEBkejLsUHmD81B4LminblFFP9HnsaxBBhXpD
	 EcXHk1As6XvVX0ImOD2UysWLa9fjUME9FHue43wFtD/kqIyizSzdn6KEZU9VWEe9exw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=117SOyHi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072760716C2
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=117SOyHi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8151F00A1A;
	Mon,  2 Nov 2026 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793633310;
	bh=XA0gLzbn7f2AjvwhezWlVJXDT1t5FEzHWTu1c5zyhoE=;
	h=Subject:To:Cc:From:Date;
	b=117SOyHi9Votq7kx5tfeS9pvzg0SjAAnmBj7WLxwN8OFGMXUEHYvvDDhUaIEFn/+Q
	 J4ULt26ZYBA5dzBL/6exFUyRmggL8dPZfpmfB3ZnEvztZ/X/zbE0qaP4FRHTJLo8m5
	 +VPVx+ucMAWOmcwLTunCAVB2SWLrH+rafG23twLI=
Subject: FAILED: patch "[PATCH] media: usbtv: fix null-pointer dereference on disconnect" failed to apply to 6.12-stable tree
To: nogikh@google.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Nov 2026 16:28:27 +0100
Message-ID: <2026110227-ravine-cider-7c49@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cb705f75d03e946a4514488beb9e3bac9bcdb2e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110227-ravine-cider-7c49@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb705f75d03e946a4514488beb9e3bac9bcdb2e6 Mon Sep 17 00:00:00 2001
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 17 Aug 2026 14:09:49 +0000
Subject: [PATCH] media: usbtv: fix null-pointer dereference on disconnect

A null-pointer dereference can occur in usb_make_path() when called from
usbtv_querycap() (and other ioctl handlers) during device disconnection.

Oops: general protection fault, probably for non-canonical address
0xdffffc000000000a: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
RIP: 0010:usb_make_path include/linux/usb.h:985 [inline]
RIP: 0010:usbtv_querycap+0x9c/0x100
drivers/media/usb/usbtv/usbtv-video.c:612
...
Call Trace:
 <TASK>
 v4l_querycap+0x236/0x470 drivers/media/v4l2-core/v4l2-ioctl.c:1106
 __video_do_ioctl+0x8af/0xc70 drivers/media/v4l2-core/v4l2-ioctl.c:3133
 video_usercopy+0x860/0x1430 drivers/media/v4l2-core/v4l2-ioctl.c:3475
 v4l2_ioctl+0x18d/0x1e0 drivers/media/v4l2-core/v4l2-dev.c:366
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94

This happens due to a race condition between the USB device disconnect
routine (usbtv_disconnect()) and V4L2 ioctls. When the device is
disconnected, usbtv_disconnect() sets usbtv->udev = NULL without holding
the usbtv->v4l2_lock mutex. Concurrently, an ioctl handler like
usbtv_querycap() can be executing under the v4l2_lock and attempt to use
usbtv->udev, leading to a crash.

To fix this, move the usbtv->udev = NULL assignment into usbtv_video_free()
and protect it with mutex_lock(&usbtv->v4l2_lock). This ensures that no
non-queue ioctl handler can run concurrently with the pointer being
nullified. If an ioctl is already running, the mutex will block the
disconnect path until the ioctl finishes. If an ioctl is blocked waiting
for the lock, it will acquire it after the disconnect routine releases it,
but will then check video_is_registered() (which was cleared by
vb2_video_unregister_device()) and safely return -ENODEV.

Acquiring v4l2_lock after vb2_video_unregister_device() avoids
reintroducing a historical deadlock issue, and usbtv_audio_free() remains
safe as it is called before usbtv_video_free().

Fixes: 65e6a2773d65 ("media: usbtv: Remove useless locks in usbtv_video_free()")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.6-flash Gemini:gemini-3.1-pro-preview syzbot
Reported-by: syzbot+37a57a84893052ab6071@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=37a57a84893052ab6071
Link: https://syzkaller.appspot.com/ai_job?id=5abbe65a-5853-4bc2-9135-5c75f88d51ed
Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/usb/usbtv/usbtv-core.c b/drivers/media/usb/usbtv/usbtv-core.c
index 4f10f6613bc4..89c3424e7685 100644
--- a/drivers/media/usb/usbtv/usbtv-core.c
+++ b/drivers/media/usb/usbtv/usbtv-core.c
@@ -139,8 +139,6 @@ static void usbtv_disconnect(struct usb_interface *intf)
 	usbtv_audio_free(usbtv);
 	usbtv_video_free(usbtv);
 
-	usbtv->udev = NULL;
-
 	/* the usbtv structure will be deallocated when v4l2 will be
 	   done using it */
 	v4l2_device_put(&usbtv->v4l2_dev);
diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index 92bc7a2509c3..2a91af8d1e30 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -966,5 +966,9 @@ void usbtv_video_free(struct usbtv *usbtv)
 	vb2_video_unregister_device(&usbtv->vdev);
 	v4l2_device_disconnect(&usbtv->v4l2_dev);
 
+	mutex_lock(&usbtv->v4l2_lock);
+	usbtv->udev = NULL;
+	mutex_unlock(&usbtv->v4l2_lock);
+
 	v4l2_device_put(&usbtv->v4l2_dev);
 }

