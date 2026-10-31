Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793479648;
	b=f179LlHH/RTTNPnIv/TKsJuuCQhcoys8pVFC6D9W8yD0lmviw5N5fzWSUj99RfOHXDqi
	 B/BypdyvanoCit+xHbtTgkIj3W19fey7h2FON1D4kKKre8F8NMMej0vTCwdvVYMTIMePy
	 if3XDjiz2EuUAmp0YJh8hqJY1qqnnpBL0brDcjbeErOfDycxWXxgRJO+oF0G49R1uruja
	 a9Z09C+LzvXoVnvyxl6i3PEeCnlPOPgRatybxMa/79zfBygcW6AsxFVoW7DZBiV1gQw4d
	 qUZ3wBUaDaVnIcwj0DapnNpTpSZST7P4BMFrWSbJ1KE/4E8s2WIeP6nBLEyDNdzjeIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793479648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6pRrbeo6zVDPi8G+cRc3tH7FP8XtYrfaTkuc/zmCEVs=;
	b=KLvZT2S2t0HfMipxf9taEmqprSeE2jSTT9Jo/IVg3WBo5NKk62ovmzfJ+2CEf1aJRs6+
	 AQ7ls7FixkhI5Ta9AYB+Hshvol6f6n6Sjsaj0E8GyEWP0ufpHDn5W6NEImZIn2NKgtsP5
	 Qe5AIEDgNHvKJEJChwatwxaL0j5WgjhAaRr9UBhJRzG0c4RM5rdGnIoYoXrG3S7RRuoPT
	 6qsle/wu1j38wiJdSmvoCc65JlpoT49lnpUpf4SS2JouoNT4W4Bj//nbfZDi/5NMB+kWg
	 ERfmaie11OuVeWsEB4V9qzlp3rSK9XewunFrh5u+AKRyJbrfIP4Z0gC0Y03BtS7lhVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UC+LJti3;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19444606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 20:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19444606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UC+LJti3
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso21474285e9.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793479646; x=1794084446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6pRrbeo6zVDPi8G+cRc3tH7FP8XtYrfaTkuc/zmCEVs=;
        b=UC+LJti3Yv47rlpsQtHWSUfnCSQ7T09uTWdO9TVT1rB2t2tdyw0SWFQ3j2d+ZVrwve
         4r0z4s9Fx0oXKO6rVnZgEcoywRiNHsuirCmGjU+qyd/vGbHa5WR+WbjGLiOm2+cLJ9/l
         gZUhrUw1iE+VasqZ8qabyUDE3xLwiEyw4CNY38lU/K2KhtgI/l+ZS98pDDWarhGLSCPz
         Y1p+u+oQuA2T5Uwv3+1rXrvhvV5ZDVAO1j+VB1NgIYFSIaSa2fOTqh+Up5yNdCTb6vGr
         fu1dIeM9gZ2PQ2cZiLI/FAg2xDaJ78VNKPK/a5kTx7smUBYQgZLGeMDPCXzSktEaq9Lc
         hANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793479646; x=1794084446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6pRrbeo6zVDPi8G+cRc3tH7FP8XtYrfaTkuc/zmCEVs=;
        b=1CuQkSuz0nmQp4UqVgDgo4kUNPtk6e/fQ2gtQrblhmfO45kOX0eHDP00cGtwyusuhe
         Whht9xC0KhmBcP09JpjQpUR+7IOGa+lq3dkKlxCcaE28n+5ozC4Mpf3HTXjcV/kAA3VJ
         8B3csrwJRBwYF01ar5Cj4w7I/2Th3BTOmYbgLQL0mUM9Dx74uR82gN7FFtY4/IpjMZKG
         vNb6wR9jqjOfBtSrxOmc0W6TdYip5B7JqKfQwcaFhT1af1aXrNuCfIY26IiMqoWJUTzu
         3xeFfUpnldCVJ0To3q0IQ6fl+O2p53RiryE9WxHgjpu+cdDnLoOtNOrr//jKOePU/xUe
         NAcQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4TZZT19seyGYGbir7vHMyRgMzef3gERk8Mn+wK3qt1WkqrhIJghwGRrEjP/nqQdQwPkrE7Hc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpqoSi2NeJyAWqzxqH45f8xePUEkmjNEkhue7rLSTd/xxTkYuV
	OH3BrEAXCrrNjckhLQHKj27s3/2eu/1qM5daoxt3j6zvSUlf8cceRKRdtm5RZw==
X-Gm-Gg: AYBFou0g2YsjJtQWSVzMzrlfvvNiMnwVRuoPC4gNP/RSgLZY8YDsOAjFS7KKxX5mroc
	leS8SYsuDg4gpJx8gpdi1lzAJDf13GWFLE5gLRE/CMAxfVPEAbBXMXMxd4YNtT3tZe+wAAhRPXQ
	6qxOiJ9RvQ1tx1uiCrQvveM1n9mGqC59Zag21a9sLxdIGgi0di5dj/eDCnzcZacPl7MMLCDQv27
	Alo1siCLAMDOTqNjS+K8su51FkoJSqDFBBs2g7iu/X9AvSmrbX/RB7NyW8jFYihpM1pMdK0plE9
	uofOBfbNFFZK5ATCvdbEZgXMawwvpGLU5IcF8hUqNwMJkarZTCtO6cKd52J4ecku6kEPa78LoN6
	pD3lI7Y7BejfAIggtTf/xgU7pOxbEsXmKYjqeLExf56fmqman3TlkW9evC7hKxgb5dyhahu6F7u
	JU8PUHdJQ5idA8vTVrSrR6abO4ztHVDkJukqwdnwfOsQmkaznBZcvhtWmo/B9ScnURiup+gQTkG
	cKrohzan7ryenpNGvV1BVhETF9VCTTOpEh9yXAD5TKdZlBlVdnUSS6IZiSACWJbNYAy9m369fJK
	7BnO2rgx/PnWzdltI5U60Rs2g1xtxkcyukLR4ELXfwiSsE1kHHa0ilLoKwFrIb1K2oQ8M5EdLWq
	TXPo=
X-Received: by 2002:a05:600c:628d:b0:4a1:e01e:1927 with SMTP id 5b1f17b1804b1-4ac17d16a1bmr137026755e9.5.1793479646321;
        Sat, 31 Oct 2026 13:47:26 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([105.98.98.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e77409821sm6564471f8f.0.2026.10.31.13.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:47:25 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: mchehab@kernel.org,
	hverkuil+cisco@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	syzbot+1e71765881a6fc43185f@syzkaller.appspotmail.com,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: em28xx: fix v4l2 use-after-free after failed init
Date: Sat, 31 Oct 2026 21:47:23 +0100
Message-ID: <20261031204723.1415-1-drifabdelmalekmohamedsaid@gmail.com>
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
 drivers/media/usb/em28xx/em28xx-video.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 84424284d486..572e6835b851 100644
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
@@ -2426,13 +2426,15 @@ static int em28xx_v4l2_fini(struct em28xx *dev)
 		return 0;
 	}
 
-	if (!v4l2)
-		return 0;
-
 	dev_info(&dev->intf->dev, "Closing video extension\n");
 
 	mutex_lock(&dev->lock);
 
+	/* matches em28xx_v4l2_init error paths */
+	v4l2 = dev->v4l2;
+	if (!v4l2)
+		return 0;
+
 	v4l2_device_disconnect(&v4l2->v4l2_dev);
 
 	em28xx_uninit_usb_xfer(dev, EM28XX_ANALOG_MODE);
@@ -3129,6 +3131,9 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 		vb2_video_unregister_device(&v4l2->vdev);
 	}
 
+	/* matches check in em28xx_v4l2_fini (under the same lock) */
+	dev->v4l2 = NULL;
+
 	mutex_unlock(&dev->lock);
 
 	/*
-- 
2.43.0

