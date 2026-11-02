Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657693;
	b=yUr3zCkPhIlCZGRj9L7ZnfFAEQmQxERUzHtbXThbv4i4RD5MAx+c9/l1VDC30inc1rg0
	 FP32Ssy1zPDnaqY0hj9Qwl8DdNJwDqa35Nr5V3L2swWRETD5FvmtlrcCIHYB6gDH3yuaX
	 JsQ7y9jEFA9zfP3hnyByZTXDJGqm0IeHehcnZz1WGLandm+QO3ol2xRvaV8Vv0EVKCa6j
	 SEyvOTUdzmiuVR2xCW5yAkDOoVjZ4kmCippyyxlEKJYJo8Xni2xtyFv39GpIDYMf1GDDR
	 2PhY6KiWbd2e4CEpHRtEbbCxMSWxgcJaHYMVkClyLbBjYi+JxNhVrQHQb8/qrJhl0Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657693;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HBH7W9GD0BPyieTV+2SaHv3ZD3JpuqnWsNA5ceSlnXI=;
	b=5B80Ta+WjqXDQr2wZxotbRpQwO+sQv81HkEQApDH3OkD6YbrOTPvx72b3SM7MNYULl2L
	 2Ar29GQHynGoaMI0tHoCJ77TpF9h49YWKNpdYZx1Yi8du878SYOjXtcAs2231HmSe/ay2
	 xWMLjDEHlbrFzyiYnpAxBOX1PIkKOq4CLC9kmGktFbQmD1fyvVOB/hpUqBTqWK+xtjrP2
	 0uGRmYXhDX0WG0V8XrNEZ0F8iR4IoHRpxN8nR1oGunbazkc9ElP06Y/zt18JEXbMxLYQY
	 tl+rQL+Naer4TF8xJAwi6JO+Y8WPC+n61Y+NoXiHPzkYxe+ssHfU7OQiEVTEZZSs26A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPGmL+YD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F5606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPGmL+YD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE71A1F00A1A;
	Mon,  2 Nov 2026 22:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657692;
	bh=HBH7W9GD0BPyieTV+2SaHv3ZD3JpuqnWsNA5ceSlnXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RPGmL+YD9D4D/I/JM2QwJXCIJJeUnjZJhrzVvynMGo4yHf28HcMKVn4F9WE44IFNq
	 FWBGeyBVY9IJmgH6RQfSvVOCtgS4kdz5t9mlyEN9HULVC1YDCFvth2Gje4vxtNEfP2
	 gwaPivyLK6hcHy1ljmfPK5Wze+G0N8+6yCQ1PG5uMK+c5V6XrxqF+msgfkKqI/RjUo
	 DpxBDgDVR81i/NTwuCZhF03cPYxZWYlz+oO7IG8lHZ6yXouKNE2g2TtEm9Zvs6l4Vt
	 X7hgsGkyyMicORknan4wSiPS5qEFNVZHIv4YrLnxZ5IFHP9yHpELrOEvT9yGakllEH
	 kSVjWdbojZHzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aleksandr Nogikh <nogikh@google.com>,
	syzbot+37a57a84893052ab6071@syzkaller.appspotmail.com,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] media: usbtv: fix null-pointer dereference on disconnect
Date: Mon,  2 Nov 2026 17:14:49 -0500
Message-ID: <20261102221431.1933091-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102221431.1933091-1-sashal@kernel.org>
References: <2026110226-immunize-simile-9c23@gregkh>
 <20261102221431.1933091-1-sashal@kernel.org>
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

From: Aleksandr Nogikh <nogikh@google.com>

[ Upstream commit cb705f75d03e946a4514488beb9e3bac9bcdb2e6 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/usbtv/usbtv-core.c  | 2 --
 drivers/media/usb/usbtv/usbtv-video.c | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-core.c b/drivers/media/usb/usbtv/usbtv-core.c
index 4925113af9603..a444ef56b4668 100644
--- a/drivers/media/usb/usbtv/usbtv-core.c
+++ b/drivers/media/usb/usbtv/usbtv-core.c
@@ -136,8 +136,6 @@ static void usbtv_disconnect(struct usb_interface *intf)
 	usbtv_audio_free(usbtv);
 	usbtv_video_free(usbtv);
 
-	usbtv->udev = NULL;
-
 	/* the usbtv structure will be deallocated when v4l2 will be
 	   done using it */
 	v4l2_device_put(&usbtv->v4l2_dev);
diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index de0328100a60d..ef066df712469 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -968,5 +968,9 @@ void usbtv_video_free(struct usbtv *usbtv)
 	vb2_video_unregister_device(&usbtv->vdev);
 	v4l2_device_disconnect(&usbtv->v4l2_dev);
 
+	mutex_lock(&usbtv->v4l2_lock);
+	usbtv->udev = NULL;
+	mutex_unlock(&usbtv->v4l2_lock);
+
 	v4l2_device_put(&usbtv->v4l2_dev);
 }
-- 
2.53.0

