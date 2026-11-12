Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449131;
	b=1v3dDzX5Z1u+33hTD8EKpuJnha4izLmFZsHW6ZWLJNTI45wOmFBrMN6iNpIepX9/jMQj
	 Q8VvVnI4gSLJB0n6hIS+ghHxecR626vcZCFhBnk0ylfgC+xImSigCg07BTvpfQbQhx24L
	 gBGsFQa0ybsBFeStbpPZHysSWdg4FeNR7qZCLV/ZLqBevIG8+NJ76d3QDa4WfbF668qya
	 QHLWGRRPgVxlwPU1TUfL9uBanBDUsGfdkPKu2bWxJL5BN7i1rSoamBHqTK/txMQ7WWa/g
	 HnsYPOEA2eOoloKjqO909W23YXEnoljTEAR98ydeqefLF9vwdQxZYlMsAKtCHYDiqTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449131;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-FangMail-Miltered:X-FangMail-Envelope:
	 X-FangMail-Bounce-Flag:X-FangMail-Outinfo:X-CLEAN:Message-Id:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=JzkSGwbdyiLHOrmQm9+6tKzAl0MQ2E6RYQLy1MabwoM=;
	b=V+/n+y9Xs1FaK9/rgFOgmjSziIXH69vwspYdWMgOXjfwrOSGG8izqxQA2Anc+dGzJDW/
	 aJEhEfB5TiF/bgzRSC901b1Nu51vinAOzCHfhpnuh+LoRG+c7hNra/e1LfjfK+AfIW5+K
	 zJptmDRIDfHfkDr0EmbEMldstwWsPtHBEsoUh6/7rzsBfs7VT+6pzup75Y1uB7libMgSd
	 PPqIWwU1CD+Keped3q2jUgpY7MybqD2xo8D4+XDbHpIA/jGt3BOBuGbMPBA6Z041C9ItS
	 EsFkw/JGQt6zJR8xPfoFOCZ3QW8g8IRFhLQfJAXgNIIkLCTQQF8xoKs9qDgHUrhfRxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7FC606A330;
	Thu, 12 Nov 2026 02:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF7FC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jQ3d11KKZz4S5H;
	Thu, 12 Nov 2026 10:05:25 +0800 (CST)
From: zhangdaolong <dlzhangak@isoftstone.com>
To: Antti Palosaari <crope@iki.fi>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Valery Borovsky <vebohr@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+930e6201080a31e9d0c8@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	zhangdaolong <dlzhangak@isoftstone.com>
Subject: [PATCH v2] media: msi2500: remove !dev->udev check in msi2500_buf_queue()
Date: Thu, 12 Nov 2026 10:05:24 +0800
X-Mailer: git-send-email 2.48.1
In-Reply-To: <1794400162.6AF45FA1.000.4jPjWQ0vwVz4SJ0Ls@fangwg02>
References: <1794400162.6AF45FA1.000.4jPjWQ0vwVz4SJ0Ls@fangwg02>
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
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Thu, 12 Nov 2026 10:05:25 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AF51EE5.000 by FangMail milter!
X-FangMail-Envelope: 1794449125/4jQ3d11KKZz4S5H/6AF51EE5.000/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1794449125.6AF51EE5.000
X-FangMail-Outinfo: 1794449125/6AF51EE5.000/4jQ3d11KKZz4S5H/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1794449127.6AF51EE5.000.4jQ3d11KKZz4S5H@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF51EE5.000/4jQ3d11KKZz4S5H

When vb2_start_streaming() is invoked, it first passes all pre-queued
buffers on q->queued_list to the driver via buf_queue() before setting
q->start_streaming_called and invoking start_streaming(). If
start_streaming() subsequently returns an error, videobuf2 requires all
buffers passed to the driver to be returned with VB2_BUF_STATE_QUEUED
and warns via WARN_ON(!list_empty(&q->done_list)) if any buffer was
completed with VB2_BUF_STATE_ERROR or VB2_BUF_STATE_DONE.

If the USB device disconnects before vb2_start_streaming() runs (for
example when v4l2_read() races with msi2500_disconnect()), dev->udev is
already NULL when vb2_start_streaming() enters. msi2500_buf_queue() sees
!dev->udev and immediately completes each pre-queued buffer with
VB2_BUF_STATE_ERROR (moving it onto q->done_list) instead of adding it
to dev->queued_bufs. Right after that, msi2500_start_streaming() also
sees !dev->udev and returns -ENODEV, triggering
WARN_ON(!list_empty(&q->done_list)) in vb2_start_streaming().

The !dev->udev check in msi2500_buf_queue() is unnecessary: ioctls check
video_is_registered() under vb_queue_lock while msi2500_disconnect()
clears dev->udev and unregisters the video device under the same lock,
and if v4l2_read() races with disconnect before acquiring vb_queue_lock,
msi2500_start_streaming() immediately catches !dev->udev and returns all
buffers on dev->queued_bufs with VB2_BUF_STATE_QUEUED. Remove the check
from msi2500_buf_queue().

Reported-by: syzbot+930e6201080a31e9d0c8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=930e6201080a31e9d0c8
Fixes: 977e444f59ad ("[media] Mirics MSi3101 SDR Dongle driver")
Cc: stable@vger.kernel.org
Suggested-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
---
v2:
- Remove the !dev->udev check in msi2500_buf_queue() completely instead
  of checking vb2_start_streaming_called() (Hans Verkuil).

 drivers/media/usb/msi2500/msi2500.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
index 282256ab812a..3382bb62541f 100644
--- a/drivers/media/usb/msi2500/msi2500.c
+++ b/drivers/media/usb/msi2500/msi2500.c
@@ -623,12 +623,6 @@ static void msi2500_buf_queue(struct vb2_buffer *vb)
 						     vb);
 	unsigned long flags;
 
-	/* Check the device has not disconnected between prep and queuing */
-	if (unlikely(!dev->udev)) {
-		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-		return;
-	}
-
 	spin_lock_irqsave(&dev->queued_bufs_lock, flags);
 	list_add_tail(&buf->list, &dev->queued_bufs);
 	spin_unlock_irqrestore(&dev->queued_bufs_lock, flags);
-- 
2.48.1

