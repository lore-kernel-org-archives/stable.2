Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793480967;
	b=OelLI7a6+2qsY+w/Kvs3EbxYaec2k//YT8HEHhG/um184c+/YOgIg0O/Suia7H2wfMWX
	 eeImZJ4kz5lRT/guzcWqCdA6ZZc+Q1UCifAhUWKIwkvicS58VSFDiH039IxkmwITkueOv
	 EoSqb57U/2FNHgFKE0i3jfOA1TV87NlsY1xQukP8f8TB5ZXNfmDNgnaCTKxTQBKi4jfsv
	 5TWe0Y5FUonNuWoWXwATAr8qna2cLmRFkRVRrukataZxN94gvpTn6OpPuBAXRVddEmbYr
	 nK5rlK/y62uXqVMFHYilvxPICgioJb2L2KCf973Vx5jxK73SbWDWFqVHlsZappK34Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793480967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=w/8hoYbs4XtN+m/HSlOA+igEXqiDy3aZFHqgsjMNcQk=;
	b=XFL6O5tWI6Dk8NobMZVoceLgnDwdC52tsP2cMLWPCEOfelIFG5KL8BdjeHdvfvnNA7dC
	 ewj+fbpqfHDDPsfPsQf+SFHn4PxKCPerXGv/kUowlZoGTQxG1a2bgVW/UwwhDWHEvhUPq
	 11+j+Kh55+zYOfwgVweFIL0r382lXsUiPdWlO31OLucXD6gQwkrEp1mV6WSfmc+fUQCMQ
	 XhDGJdT/6I9GiZstVFQlMJv1Gr/u40EMdmDW3Jdf2Qy+MwqChw4GplWlPos9G1Tex/hFv
	 7ygihq5QAS4xGZII3l0lGUWb68D/A8XKmQOeLMH/wl4uBYDuO1249PiWf0OL/whJesQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uqYbYdvg;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85B606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 21:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D85B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uqYbYdvg
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so1658761f8f.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793480966; x=1794085766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w/8hoYbs4XtN+m/HSlOA+igEXqiDy3aZFHqgsjMNcQk=;
        b=uqYbYdvguytgoD7FHJG5tY6rU8OIQiX6tqmAZwTE61SMy0wE28EnrcSxS59sQ2fW2q
         0ZdszXd8P9zhRcp/q2O+3QYWesl+NJbOte+HC5NowJThc+/fBZooJUc7tBKiVXZ70LJx
         DMky81QW7YSd2TXrzRj3WaSGT7meRbPZaqv9IwKBGzelACshDnTZXIACQJjcyXhEa0i8
         7RzjcauZfQmGGELTG3wiw01jfXR+tvLsEr3UTDe4Gh3y7dl4L+B0gduv/5tevT/YiSLC
         aRJT3gPWCVB643970/gcfVh9bH/uiCSUGXyDRFF0BFK3WOk9HZEr7HnTPm28IU2DST19
         oTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793480966; x=1794085766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w/8hoYbs4XtN+m/HSlOA+igEXqiDy3aZFHqgsjMNcQk=;
        b=JDAgLYn/N57NNuFTh81BEQtNOuSeSdm6dp0n/3VmM/jWqq3yUplG8rgVkMdwBKEiVW
         T5LOJpTqMzBMf0NoKrZMbhtiUABfFKObgn/9AUDINqMNPouqd5kyMFGZwaUXpMwSr1Zm
         vTvxKfAskytMKGBEnaDM8/qUlQVFKehILeB9bHBOsbscXekTji+KSm3Yg2/5jEGH4PzX
         FsmNi5KaxK81hNsFKJREGfl+Jy3CESZfuRwBLqfrO5L2Rn4RqUpRigqNqBbBwJA78HtS
         iMNjazB4ef86q6OFmtfsj51FjQJo73PmbnvL526XfBvJ2YgsshCcLN4JQiwWqpXvLfZZ
         RUQg==
X-Forwarded-Encrypted: i=1; AKwUvBwAQViy0mUNuYJbrRs5wYy4OnlHMhG2E6LeOMBRfm13LhOMidQttyWRY01R230EIc5HQyaM0UM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZcbqTjdN/aIyM3dpzzKvCdLtQy8KRUL8b07DxYsbpi9xavEZu
	Zu1eguZyW0S4usBk4ZYpOn1m4FrsMLy7LZJj8b7/+xzNz4n7bQrV4XwM
X-Gm-Gg: AYBFou3aiaCObcm2Zgs9N/QsTN22YiIoWwaKobxb0oP6IVzm83Bj8t6JGOT/7yjFzV7
	J/Oulu07JrCm1cYPc9DQwsvbxNuLZ55Uq6bO4L0uqrXu3ib2n4ICCboSMmlynBWd75GHOyS2RfY
	2yC1/WSaQZHF58J0ljZZbnneQb8tTrSqpYAiU2BUsvYsCDUwfdRqm95cbU+HCBr0jZTsZGzvPUv
	JIJCUbe5DmZu5wq3syzPqK4cResCa0BVhXM+fNo2c9JJgVMQjP7K83o/TnVpuyVD1X5N3Led0g0
	+C48t0+/iAd7jydj2iPyMxRzCx7xa2vx0PxEb/q7r6SPR4T185MNqH3eqUL9filek3cg93p4V23
	Gws6VjczKbR24PZPqsevTRqWkpAbspEE6H6GEJEKNv6Xl7Z5gI3bYN6WdnVDt+x80AnYx6ElUag
	7ZlEIXjh2l0f68YBE1XNolx2qoA859O9M1a1UKVEWGsQHgH31YzLt6N4iN5G4mT7ew2G2xTp++8
	PZXG0bX+Je8AHT6F7kfLswjuIdproy5rKBhYw+/f9DsCoxOd4C18ZINvmWs5GpHYI5leEktIPCI
	l6TPuGMtGWX0bQUnqX2pwpIiKx8WLIEJ3WSsDU3nEWjcrHjNg+jj3xqjzaCoyHOAx9dsUryZWf7
	PxbvtXFBwIA1A727sGMtPyupG
X-Received: by 2002:a5d:64c9:0:b0:48c:585b:8825 with SMTP id ffacd0b85a97d-48e6e2db4a1mr16251497f8f.18.1793480965675;
        Sat, 31 Oct 2026 14:09:25 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([105.98.98.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba24f6sm10793317f8f.51.2026.10.31.14.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:09:25 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: mchehab@kernel.org,
	hverkuil+cisco@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	syzbot+1e71765881a6fc43185f@syzkaller.appspotmail.com,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: em28xx: fix v4l2 use-after-free after failed init
Date: Sat, 31 Oct 2026 22:09:21 +0100
Message-ID: <20261031210922.323-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
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

em28xx_v4l2_init() publishes the new object in dev->v4l2 before the
video device is registered. If a later initialization step fails -past
v4l2_device_register-,  the error path unregisters the device nodes and
drops the initial v4l2_device reference, but previously left dev->v4l2
pointing at the freed object.

syzbot reported:

BUG: KASAN: slab-use-after-free in v4l2_device_disconnect+0xa4/0xc0
		drivers/media/v4l2-core/v4l2-device.c:78

em28xx_v4l2_fini() is called later from USB disconnect. It reads
dev->v4l2 before taking dev->lock, and on the failed-init path it owns
no reference. The last close of the video node can therefore drop the
final v4l2_device reference and free the object between that read and
its use in v4l2_device_disconnect(), causing a use-after-free.

Fixing this by clearing dev->v4l2 under dev->lock in the init error path
before dropping the initial reference, and read it under dev->lock in fini.
This makes fini see NULL after a failed init, while the successful path
continues to hold the initial reference until fini is done.

Fixes: 288254383674 ("media: em28xx: use v4l2_device release callback")
Reported-by: syzbot+1e71765881a6fc43185f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1e71765881a6fc43185f
Cc: stable@vger.kernel.org
Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
v2: added unlock in early return in em28xx_v4l2_fini
v1:https://lore.kernel.org/all/20261031204723.1415-1-drifabdelmalekmohamedsaid@gmail.com/T/
 drivers/media/usb/em28xx/em28xx-video.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 84424284d486..924a3f7977c9 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -2414,7 +2414,7 @@ static int em28xx_v4l2_open(struct file *filp)
  */
 static int em28xx_v4l2_fini(struct em28xx *dev)
 {
-	struct em28xx_v4l2 *v4l2 = dev->v4l2;
+	struct em28xx_v4l2 *v4l2;
 
 	if (dev->is_audio_only) {
 		/* Shouldn't initialize IR for this interface */
@@ -2426,13 +2426,17 @@ static int em28xx_v4l2_fini(struct em28xx *dev)
 		return 0;
 	}
 
-	if (!v4l2)
-		return 0;
-
 	dev_info(&dev->intf->dev, "Closing video extension\n");
 
 	mutex_lock(&dev->lock);
 
+	/* matches em28xx_v4l2_init error paths */
+	v4l2 = dev->v4l2;
+	if (!v4l2){
+		mutex_unlock(&dev->lock);
+		return 0;
+	}
+
 	v4l2_device_disconnect(&v4l2->v4l2_dev);
 
 	em28xx_uninit_usb_xfer(dev, EM28XX_ANALOG_MODE);
@@ -3129,6 +3133,9 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 		vb2_video_unregister_device(&v4l2->vdev);
 	}
 
+	/* matches check in em28xx_v4l2_fini (under the same lock) */
+	dev->v4l2 = NULL;
+
 	mutex_unlock(&dev->lock);
 
 	/*
-- 
2.43.0

