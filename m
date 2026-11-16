Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812440;
	b=yZkpF6e0dPucHnRQ/PxS/UO2K6RuPpNpNcUINwiZnY0xg2B2m5Bvro96Qtd1lBM3BrGN
	 INOd0iwG9xesw1Uc01C0BrBsJaRLPG19NZOoxaazfCMBOXiHk7F7LH/vtiMx43LZH1FjQ
	 8C9RV+GBX5ClnKqdnX1oQRU1GyT6cuAeguCGHJ9QQGJgIcRT2urPkXccLz04bmENW1/A6
	 UG3UQSbY9lYk39N6g3wf5sqHKwD7Fj7zj/nG1Jael6nlvfnHKLiAXejB2TgWoIicbiduh
	 y+S7wg7k+L/TNjaLLGAPuuzuoMBylfhW45VtO/IMloh4bwjLmJIe9gQQ/pyZM4wNsKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812440;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=xB+BFyiBhg43vKmSg8qYqtNW6BXxNZFsoZ8jrkcXKtI=;
	b=gBgium7XVFYTBKjRbzVT29VkAr526eYJThCj+PkRWClHJ7PGUuTqa/RtU1g+MVoixvC5
	 RdArw1XhLev3CDOS6eCWEHrJw7pTc9VlDI5D/2D2VAboiVnj66XrUaWMZkxFMtWrB8KN6
	 1Lg7fRDZXBjS3sDzg0Hh51oDvDCMeViKxjT39EjcCDL3Exab9sBQAAWd5tITqPGu90bhr
	 V8NRrwR9PGVOFw0ia66zb7EiLHGGhd6EZs7z4qg/CoJUl3TuF5Cvcfo3hKV3DhXY2nB2l
	 qgzwY0yUPGWFDhHuChPlX1qFiG+4C/KJr/mUIoxIKOo5g0b+I0rb61eEg+ZgoZ/BuTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=URK1A+aN;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F70606A323;
	Mon, 16 Nov 2026 07:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30F70606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=URK1A+aN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794812399;
	bh=xB+BFyiBhg43vKmSg8qYqtNW6BXxNZFsoZ8jrkcXKtI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=URK1A+aNbgmqzkfebTJo/cSldfDMGgGTXjXKBe0NseRqgSu8UhEL+eiAy/X+tALX9
	 oGPiRdmGou/miOqacsumQ7H0w9o17QYJRNujBv7rHvvqkMV7L5/ntUb6Epsjy8FBVc
	 gH6vsa5RiWxbRZ3XzXjPTPyGVIn6aqU4MWLQfYYo=
X-QQ-mid: esmtpgz13t1794812381t4041da20
X-QQ-Originating-IP: n004XmxgKogGDXiilDcoOCabJnUIn8l5kAG3eSkS40M=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Nov 2026 14:59:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13267101832186099259
EX-QQ-RecipientCnt: 10
From: raoxu <raoxu@uniontech.com>
To: mchehab@kernel.org
Cc: luiz.von.dentz@intel.com,
	pengpeng@iscas.ac.cn,
	pmenzel@molgen.mpg.de,
	brgl@kernel.org,
	raoxu@uniontech.com,
	sakari.ailus@maxwell.research.nokia.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: v4l2-event: Unblock DQEVENT after device unregister
Date: Mon, 16 Nov 2026 14:59:38 +0800
Message-ID: <C882A5D3FC331B7A+20261116065938.2035746-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NPwdxSKNG61XtVeQFjBCp05K8CqgXIRWlm6XVis33V7IWi6PKn5OYXNR
	QQKEC84XfmYMLshtdEtbHzGKtTPMyutZXz5zaUBGaZvOgtTumOSc6M0JjKJJpGwk8+I4I2C
	d5YamO9RM8ptrk2NR6u0KfcO5zz3KOJ/tGDgjmGIzfTQa28jbpZ9FRqgXpdlMCZ0+QewdHk
	B0sZeD3kLw/3J8IKzmq5YzKgKSu8a+XFsJcgUWal8cNco+oY9zokd2fjvDScJJjfWoF+wlO
	hBF1FAJmd2K8IqYLV02dKyOBBR1AjPVQAIoBMEKpXLfcDkaYD6uJNEgS5i8BIWMRjA2hzXZ
	FY6Y/xhf66DXv3aHo+ubSaT1qxZM53EOjiAB/r20VpuEJYyM0nNNbv1Q86gZm1lLGwTgmfe
	QtZaBE/cND9q4S/JR2nWQH1/AKDmFo7+EKgXsk+oSBFff9q4lb3HRXpefGHbZViGNbt61lm
	NMfj7cWB8+QKPdJsAWHzkZbKR00ClWKg2NBNUwYQDVPaYskr9aF81NK22tceCb2poUk0fOQ
	2Pi2UaViDyLwfroxpGZwCoFsGBHpMpF1bHo+1ALlAxXYwLsqH14/XctWnPpg84uUAzwjHT6
	hGOqrBpB/qjeJEqpULYBF9fet4ZKZuQeZjWwM3u5YltxUSZiI1LTHbJeQm3hAnj+bRzCTrN
	pnRD2FKkGq3bPjr3vShzvcblQLu4MBxROODTFT69Qi+dRkPAEa2ygUBu9S3BY6P+/Vw5bsL
	IuXeXiN7tL09/w3QJiIvQIw95xTMlnXESLitKMPTv45p177PPNJYJ4UZ+VVYf9A+R7v+R66
	F3i5FNT3NmDZrZR4mIGa/4+kw7BZMlPiFot/yNoie/K9KgvlX7hiMhuVtOOhI7EvC0nJdqz
	XdRN2wOs7HzwYNtkz9LvHxV5T4NwHJ6vvZsX/rlCVVT/yvWp60n3H0vOyVKXdgB23upmFkC
	BEaQJUZfoe0xfp3LW9bWvjkeJVKL+gkZGsDqgpmo7Pxd2SIKYBblDnV0QP6V8W1k0F8i7Ky
	bjH5WbRJOIjxlbQuflvm4TSa2EA2wApY6O4w6ovw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

A blocking VIDIOC_DQEVENT can remain asleep after its video device is
unregistered. video_unregister_device() clears V4L2_FL_REGISTERED and
wakes event waiters, but v4l2_event_dequeue() only waits for a nonempty
event queue. A removal wakeup with no queued event therefore sends the
caller back to sleep, potentially indefinitely in the absence of a
subsequent event or signal.

Reproduce this by opening an event-capable node, subscribing to an event,
draining pending events, clearing O_NONBLOCK and entering DQEVENT. Once
the task is asleep in v4l2_event_dequeue(), unregister the node from
another process. The ioctl must already be in progress: a new ioctl
after unregister is normally rejected by the outer V4L2 file operations.
Losing an input signal alone is insufficient if the node stays registered.

This is reachable during legitimate use by an application with a thread
blocked waiting for device events when the device is hot-unplugged or
its driver is unbound. It does not require malformed input. Applications
using nonblocking dequeue do not sleep at this wait point, and an event
or signal can mask the problem. The frequency in real applications has
not been measured; the runtime test below uses driver unbind rather than
physical unplug.

This was reproduced with an ov9734 UVC camera (0408:1040).
Subscribe to V4L2_EVENT_CTRL for
V4L2_CID_BRIGHTNESS on /dev/video0, then unbind the camera's uvcvideo
interface. Both video nodes disappear, but the blocked ioctl does not
return. A representative trace, collected from the test program and
/proc/256634/{status,wchan,stack}, is shown below (timestamps omitted):

  DRAIN_EMPTY errno=2 type=3 id=0x980900
  UNBIND_COMPLETE nodes=[]
  # About three seconds after unbind:
  Name: dqevent_test
  State: S (sleeping)
  wchan: v4l2_event_dequeue
  [<0>] v4l2_event_dequeue+0xbc/0x140 [videodev]
  [<0>] v4l_dqevent+0x20/0x30 [videodev]
  [<0>] __video_do_ioctl+0x1cc/0x4b0 [videodev]
  [<0>] video_usercopy+0x15d/0x700 [videodev]
  [<0>] video_ioctl2+0x15/0x20 [videodev]
  [<0>] v4l2_ioctl+0x50/0x60 [videodev]
  # Only after the test sends SIGUSR1:
  ret=-1 errno=4(Interrupted system call) signal=10

All three original-handler trials needed the test signal to finish.
There was no Oops or hung-task report: this is an interruptible wait.
With the changed dequeue handler temporarily installed using livepatch,
the same unregister test returned without a signal in all three trials:

  UNBIND_COMPLETE nodes=[]
  ret=-1 errno=19(No such device) signal=0

Disabling and unloading the livepatch restored the original behavior.
This comparison used the running test kernel, not a newly
booted mainline kernel.

Include the registration state in the wait condition. Attempt to dequeue
an event after waking and return -ENODEV if the queue is empty and the
device is unregistered. This also handles another waiter consuming the
last event first. An in-flight call can still return a pending event;
nonblocking calls, signal handling and mutex reacquisition are unchanged.

Fixes: c3b5b0241f62 ("V4L/DVB: V4L: Events: Add backend")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/media/v4l2-core/v4l2-event.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core/v4l2-event.c
index 9dd2aaa95a67..17d3c53c0d93 100644
--- a/drivers/media/v4l2-core/v4l2-event.c
+++ b/drivers/media/v4l2-core/v4l2-event.c
@@ -70,11 +70,14 @@ int v4l2_event_dequeue(struct v4l2_fh *fh, struct v4l2_event *event,

 	do {
 		ret = wait_event_interruptible(fh->wait,
-					       fh->navailable != 0);
+					       fh->navailable != 0 ||
+					       !video_is_registered(fh->vdev));
 		if (ret < 0)
 			break;

 		ret = __v4l2_event_dequeue(fh, event);
+		if (ret == -ENOENT && !video_is_registered(fh->vdev))
+			ret = -ENODEV;
 	} while (ret == -ENOENT);

 	if (fh->vdev->lock)
--
2.50.1

