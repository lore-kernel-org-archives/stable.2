Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660465;
	b=01d8RmEv4VxbqQ+SjllpFqYmUxstPz8Y23JHAFn9WgjIK7eD8SXihbhMbrNMntBZ0QtR
	 /LMztMjrLXVZzWJ+4LSI7AmNc+IOf0sW4mPnFa1IceCJKN9ULcu5dpwEQtzWxOzFwFhfc
	 JMWieyRIPGcwgVkQlecSviXsswK470oa2Y9RPiq3hU5+eNKwyA6//usUOs/FVcZvwCtzW
	 gE9eEP/G5VKBzeTQGzpFaKBAhXCXjzgheZJ5S7YxyLjq913w5JToX96KaVKUDdyi28OtG
	 XxMLwJeXUEhik69rLDs3oaHcIOz8B6dcnC6vg6VNzjim0GGLeTzNi5fVaF3wtkV/VmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660465;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nIGeSlGbltWu63u4xhU73nscapidk/GXgKX9hQ0zNZg=;
	b=FewbUH6Qs5v4OtsU9Z+oxwM56kJsfBz5MHV2cdwjNk8YlkuzBTnpYY0Ddo2MYUhzBvb3
	 683XqkZYRqxKgGrHIC/NQCmgI88N8JuJNAFsOv4CsPYOmVtWv2YIqaQ7RlZEW9BWLcI4i
	 VPwGO6VY6vFj0T0yuqDYL2Vltl4lUeG12jBVunMaYystUEmbnTT4L+bxv1UEk8FPsHHLA
	 uhyu9ISVoPDlZAtKnMDUWm89T/Wesd4KDRUjCKgce0RYjjmvaT7K/WeIhbYgzRZSSlzeW
	 P74aYPQ2PJm+Ja5HCvGvXdmUz09mdXBX5RYtinFn08DiOOeBDUK8+wHokLwVYt3XAKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7PCUrB4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A4A606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7PCUrB4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755E81F00A1A;
	Mon,  2 Nov 2026 23:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793660465;
	bh=nIGeSlGbltWu63u4xhU73nscapidk/GXgKX9hQ0zNZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B7PCUrB47CQGQWTbd12OL2HFToutTLXIw3Rp9RIu7NF/nceH5Q+jPAMqiEM5s7KJx
	 npLCx9ML7lwKoiO0Fpdmx6X+2DVM4zBB3LgDqpIyOVdV4eTZ7o0ehRn/78VbfXgRGe
	 waaU9EMGw+4852R+XsGRtkv/sOh09yyRbMXmuh2FhO8YkXIvylg1i7H52JoC9tj9NN
	 tewbhPwbpbjnRX1/tJWtw2nf+UeB6pB72NDrTW5SnMWOtFrs5DhCKoWK9WKi9IqZUv
	 ltzxpQOJuKsCWGHaKeH+rLHZ0HgoySpLUTD17y2uUNwywnC1dIM7KSU4GvVQ5PIjP8
	 cSEv7c/mymmWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aleksandr Nogikh <nogikh@google.com>,
	syzbot+37a57a84893052ab6071@syzkaller.appspotmail.com,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] media: usbtv: fix null-pointer dereference on disconnect
Date: Mon,  2 Nov 2026 18:01:02 -0500
Message-ID: <20261102230043.2412225-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102230043.2412225-1-sashal@kernel.org>
References: <2026110228-skimmed-freefall-ac5b@gregkh>
 <20261102230043.2412225-1-sashal@kernel.org>
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
index f3633448e8b96..8c9f09b56bfbd 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -969,5 +969,9 @@ void usbtv_video_free(struct usbtv *usbtv)
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

