Received: from mail-pz2-f24.google.com (mail-pz2-f24.google.com [74.125.228.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653A41D22A
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789904407; cv=none; b=Znqs6fNcE2iVz9rZxV9lR2S3s0iBr14SKSXCo6ecX9bsBVH+o+rPtbJ8EyTqbNYv9P7fuPMY4mMxjkzjmBxLV+hr7UZocUY8/L47PeWv6VO3SyKctCvslZ3C6QjsSfnjkSNyvigpwpErDjb9xxWfvm6zenwxr8D46JKAIw2jXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789904407; c=relaxed/simple;
	bh=7B2LFEnl9mbenlcEhpsibESNW5OLpwmL7Ks/s1Yxw+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeVQdz9wrsWtC0uiO64f27L0630+2gu84Lkovawu9bZyFEWhPsfxK5AYwy3tL4p8FEVq0W/pfHr7zES72ifNFz7efaZ8YOCQUKJE3eJGy+4e4BIT0gfEviftm4HQUaebgnZTKZUNXc8CQD+4DiQr++TKIUXy/UVk3BZczGaVcfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdyTxujG; arc=none smtp.client-ip=74.125.228.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdyTxujG"
Received: by mail-pz2-f24.google.com with SMTP id 41be03b00d2f7-cc4ab4fe290so616478a12.1
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789904402; x=1790509202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VB/v9xMNCgaG9X/tex87TcBN9TifdEbvdxv9dgsPxiQ=;
        b=VdyTxujGlA+AjI3BWVel1LrY52Xdm4SW/wdERhEN4pLcALfjVHOH5W3Ho2aCZJvRHH
         vgTzkWQLjX4IyVVCGoVkju1G0CSgY05ZQq6nVxqPK09qCBMlii5YMvPtOENW2D0RdjtL
         0XjeWOWUYdJqe45wCbIET58RkzCMVJpZZGzaOAgEHxxeM1JTXP5/AZf3Z+RhPlX1KMFO
         1W52n8RcRVOSycjb9pCnVN263LDQneJOWmrYrMp3TjuoG/5ZbSFi9CEnYBU1vq9Whv3Z
         zV+ilF/egsJUMeF2/U11D7mBrGl1Ya0MukgJVTwYiwkhnco1LmJbAJlWjvNWGRG9OOIE
         dJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789904402; x=1790509202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VB/v9xMNCgaG9X/tex87TcBN9TifdEbvdxv9dgsPxiQ=;
        b=H3V1QSMUECdxb2gz+1+j63nBVl/ZbCctXxNzhm34zXYrcYMzG3UocJbqcraTZ5s5VJ
         XOxrCOxwEJ8W2Ji/zxr+sb9fgyfdt63NchkgDe/zlxgWkpAKoEHmf4OjIw+VuoGsVziy
         uM0oJPmnq+IZSw+99cBnj7/OERUgxLhzhPEPOEfmY9e6ncRP+S1OnrKptwGfOo2sxdwd
         3q9v+Yd9myc/6TlE4fp0a64AGOB3rR7vaoS1VEYRmFy3b3FzjyUp1W2rRfUp8g2s5NoI
         EtaQKdc98ADzFBEioOD7aqCF1zGktzt8cwiJRdjxo0cYn/B6MtyXrqceWWrYmpxN14AU
         1wuQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3LsBm9aY4dbWR5TDko74+rmD8VW1Aon8Yg14Rf1Cd4ZiUthaz1XsmR+iPu53xMsvWrPzff7U=@vger.kernel.org
X-Gm-Message-State: AFuF++mhbRkxoxzsO/EOkv41BEyjQaJkXMKHJJrZA/toXMZrAMxuXUQK
	tv6eB1NbHENKy3ZzYYr1QYi6sup35qBd3IAKxuMXHnzdETO3Ce7vYLq8
X-Gm-Gg: AYBFou1wEGgdNEdGqRLcAcbo8yrriKzKWWqb25fBxQSBjmtlKGgNf6uNXSG09HxqwC6
	KE5DfIJGnNDOn9Ay5dPZ+ioxhFRAOjGveKPvo97iOUuRTLI6Buhg+mPaFdsT+ZH4ISNrqhlFDlo
	96cIewkSfnbXg7IhyguueOelgKLyL2umcCdmP25UseLKrXf11lgKEEDt+RrqaYq3bIPoboN1+/h
	yobHwpy/jYBhgd+9vfquANPPUdOYwJ8pOm033XEImLvQdfp1OABve0ukv7GzQIk64vtHPrOwofb
	+yDqcXQrN1LXsbUz8VACbLKDU5p8L+MGV5En98ZzLBTM5SWIXGQRNTRGzgyXuxKR+aTR+SA5waM
	615xwInKl3JbsjIXPf5zZWZsNmBxIKHlUanEat2uMtpkyU7P4X2K510AWmXaHh3X3+o4BsWyqNx
	ta6Bbagyz0ABt0iOr+cu+R2lJUM2xW/UYijUAxH12epvyBJg5m4OGYNVh9dxdJmhjtlknLJER4L
	54WGVi0fIQx/uU=
X-Received: by 2002:a17:90b:2b8e:b0:39e:4c7e:bc5 with SMTP id 98e67ed59e1d1-39e5572d5a2mr7798744a91.19.1789904401672;
        Sun, 20 Sep 2026 04:40:01 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:2022:c2a9:de8:d005])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm8490548a91.0.2026.09.20.04.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 04:40:01 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: floe@butterbrot.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+eb4706daf505f9c4b547@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] Input: sur40 - keep device state alive until the video node is released
Date: Sun, 20 Sep 2026 18:39:49 +0700
Message-ID: <20260920113949.12726-3-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920113949.12726-1-ngocthang2710.1999@gmail.com>
References: <20260920113949.12726-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sur40_disconnect() frees the sur40_state, which embeds the video_device,
the v4l2_device and the vb2_queue, while a video node may still be open.
Closing that file afterwards touches freed memory:

  BUG: KASAN: slab-use-after-free in vb2_core_queue_release+0x12d/0x150
  Read of size 4 at addr ffff888066fa8aa8 by task v4l_id/28733
   vb2_core_queue_release+0x12d/0x150
   vb2_fop_release+0x16e/0x200
   v4l2_release+0x22c/0x350
   __fput+0x418/0xa50
  Freed by task 16811:
   kfree+0x1c5/0x650
   sur40_disconnect+0xaf/0x140

Give the v4l2_device a release callback that frees the bulk buffer and
the state, and drop the disconnect path's own reference with
v4l2_device_put(). The last closer of the node then does the freeing.
The probe error paths never open the node and keep freeing directly.

Reported-by: syzbot+eb4706daf505f9c4b547@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=eb4706daf505f9c4b547
Fixes: e831cd251fb9 ("[media] add raw video stream support for Samsung SUR40")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/input/touchscreen/sur40.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 7020bcf9b81a..efd4fe557cef 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -648,6 +648,15 @@ static int sur40_input_setup_events(struct input_dev *input_dev)
 }
 
 /* Check candidate USB interface. */
+/* Runs once the last video node reference is gone. */
+static void sur40_release(struct v4l2_device *v4l2)
+{
+	struct sur40_state *sur40 = container_of(v4l2, struct sur40_state, v4l2);
+
+	kfree(sur40->bulk_in_buffer);
+	kfree(sur40);
+}
+
 static int sur40_probe(struct usb_interface *interface,
 		       const struct usb_device_id *id)
 {
@@ -733,6 +742,7 @@ static int sur40_probe(struct usb_interface *interface,
 			"Unable to register video master device.");
 		goto err_free_buffer;
 	}
+	sur40->v4l2.release = sur40_release;
 
 	/* initialize the lock and subdevice */
 	sur40->queue = sur40_queue;
@@ -831,11 +841,10 @@ static void sur40_disconnect(struct usb_interface *interface)
 	video_unregister_device(&sur40->vdev);
 	v4l2_device_unregister(&sur40->v4l2);
 
-	kfree(sur40->bulk_in_buffer);
-	kfree(sur40);
-
 	usb_set_intfdata(interface, NULL);
 	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);
+
+	v4l2_device_put(&sur40->v4l2);
 }
 
 /*
-- 
2.43.0

