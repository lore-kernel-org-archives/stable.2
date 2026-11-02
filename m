Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659143;
	b=a/xeHbTr62GY/Bp8i2uytN+rqewtEz5/ZdMFr1ugJeHdNAhbbmZK39OJx33x6kAqKoCs
	 I1srL/qU/ODD3OM4Rcq3AsP09dwiDn8FVUAkGR7N/140jKwJouh2/jyRtf3/kw0oh2poQ
	 +V9FKlqLIauuLFbBN1dc3bI/KgomlK+xE0bTMPmCtolgTOJO4Rad9v5KyguCe6fZjZpLC
	 Rmg/mR9LlEZXXlpLDMTRbEy8NNPbqRFN1fLYQzHq7c45awrSkA6wHA08XWDAL9XD2gR46
	 ++rnOprEQ6LPQbe3Dq51tcWgZJE0v5Xn2iReSxK+rh2B02MDi5ymv0NMdq/8uEzNgQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659143;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ydpjMgcSq23mRE6wAvHTHhR6fGGLeIauONtzgKMrEdo=;
	b=UUBGN5iik0+vF8z/h/vYPNXngVAIq+u/Um8h1ogZTE/f9n/PUYUrIibhXMHvhWoY7YBX
	 n2zk8cJLK8Se8KG+Nbsqh0nGMP4cYAgtoN/ZJt4XqY3+dDXWyzyYzQfJnl8MydI4CaD5z
	 +oBbWgWivQI8Y32QTM/T/suz2UpuAAILqewppwLTaZKdAlftjkNaE+YHbZk+sOlAEuBXp
	 O8Wc2aQaLpsAO+m8CtTaTVJa1ASHnFDS9foFICC5PvPvGmMwk7M+Gz8igxs9da5hVnKAX
	 acE9B4/xQzNiJ7Q5flKnmi6h9c4FgaJa/0GJVFk+8cWWSZ446sOVSACnzpshofVspPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBRVJhCm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095B606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBRVJhCm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C623E1F00A1B;
	Mon,  2 Nov 2026 22:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793659143;
	bh=ydpjMgcSq23mRE6wAvHTHhR6fGGLeIauONtzgKMrEdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PBRVJhCmsvPy+dmoFq4SRh7pY03TQhDjHkBMiHT/Srtcwb0YM+AV186a1TPO4fMBG
	 1xHvQcp/ZPWkcuAz8i8JiJkqRdBT+K8LUCOiHTq53ahoTXN++cgWGQr+pajLekbEaZ
	 p6RN7n0xDyCSC3Jv/4X8uGwbSp2nw4riy52JzhoI/IcZ5jZVaGq6ZWRrK64AQAbeSW
	 apUqk5L4p2iOp0e7Yir/Ih5IjOgVPzkZxjkSi8Lf6gBP5Ez7/AjPe5ocSRrSG2tc+K
	 DXHXa0VKBUlTbBrjqW73KvdCgr2V5YieZL+OiXqmwWq9Wd2TPDbNwtND2dDiwV00Ov
	 Vgmf3Ika2R19w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aleksandr Nogikh <nogikh@google.com>,
	syzbot+37a57a84893052ab6071@syzkaller.appspotmail.com,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] media: usbtv: fix null-pointer dereference on disconnect
Date: Mon,  2 Nov 2026 17:39:00 -0500
Message-ID: <20261102223800.2122371-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102223800.2122371-1-sashal@kernel.org>
References: <2026110227-ravine-cider-7c49@gregkh>
 <20261102223800.2122371-1-sashal@kernel.org>
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
index 9dc882c1a7809..79118570f1738 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -970,5 +970,9 @@ void usbtv_video_free(struct usbtv *usbtv)
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

