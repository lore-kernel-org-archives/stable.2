Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C03EA963
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341291; cv=none; b=WNUCQS3hJC9AxGdyDsoYIqEDGHC/8tpltmPkRibNi+l7TIO2VEBJ9r1XE3v9YrgFaL2XWoaEq/1we+4XZzOiVRwcQDR0LDor0H+H16SuR3i+CQVzzgpBN1ZCY2o8q9ygaNno1j206tGteQzLjuNJPQ+/DycfzCKjvvJJxrLvzmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341291; c=relaxed/simple;
	bh=KsvbhHmrpPYdQnremxgLvolRQzFzNASHFLr8Ynq5MnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mbRQuHDxfXPmvox31rT9NFQtJQzBhrKaMss7yeS7/KP5GYEZGoQGEmMM7l3FxFCPi1h3kdVkSWJJP4FCoT3nyDRegE+hNWYnx+7ad7AABZyCwTSdcjkcriVjw5Ir995x1yh63fTgN6r9oN6KNQutuxi82xJ6M+MDdPFIs1DofII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9WCeA0Y; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9WCeA0Y"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-15ea896ddc8so1562588c88.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792341282; x=1792946082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YpKPKplGyC1zv9vCrQd5tlK3JvlHI8Pmz+ZUDoFfyg0=;
        b=T9WCeA0YI514ZO3//AEJhYYo5OYAvjOweaDNxsLm5t5AahQey15DMAnKQIKHLfTW/C
         s6h4FzPx2AwAQyA9xxIdeiF8jWphwBUY+4W1SpmwW2sVzFAsGxDz7qi2T7Xq8I8KpXAN
         a4IbjiwnB8lU9R/cU7rFbqnArwyUQujJ4QVWthHLTUk+3bg6DsXusZMwH3s4lQPWcUxT
         T8BMI0pURZ1AXYaryr83ppZW7UNc0+KRP7Qm0AGS3br6lrDb+boUznKPqGREp/Urt4p6
         QQ6Y/4RoiO0HnuB1WglEnaVajDtjGXodyZrjFpvFdEjmiD4F19PREaaciXFbpInPSRAy
         rbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792341282; x=1792946082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YpKPKplGyC1zv9vCrQd5tlK3JvlHI8Pmz+ZUDoFfyg0=;
        b=jKWSWYQsIevHKl0LL/7YML5MJ73INfdJ88WQ3v/9w4+bT4G9ATHEwxjEyv7qiUlOSJ
         YtopvZn3aOvHjO/h0S5TXaXOGY0UL1MUT+J8C1VWEVPhIwy4GvldWBW3u3xo0bklT4Oh
         9sDRo/8/y/pIo5KQCd1nigwXObh4YVz0UqBESDjyl/BM3NUbY2TgNB2zH5nX7dwiFFBA
         8BezuDN3eneI8Zx/w29h1gmBDGHHeId/m/nrCABDsB+Q7oaB37FP4xknwi94xzX6BQvu
         yoX1qznPRYWX6WGXqKJP9GB+JXqp0C0CmhDKb9n4iclwV5n/8Y/ZC42a+vEhgO8p/kiW
         oAsw==
X-Forwarded-Encrypted: i=1; AKwUvBxW5IlHzbQRIo+5LPw5SM0lvPLNykMBOsV1CVzNaA94X+EPisNFQ+7YAoC/4CsTaiN6S23hM7I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5FUrv2GEZcDjSMRW33OeKdCcfaiEZeh4CWV8m5BB9iNZnPv1I
	778wCr9xK3iqEAwYBlVXmm9diABWI0BMe1P6nKtH8JobtFCNhz0EmPrB
X-Gm-Gg: AYBFou0GLahxEa0pmWzouo/mPAxg9tchW3fCG6Jn2l5HiKKa1Lg55DI2o+lYjFgeXAX
	SgQNntvC+YhXb2LVbwAn/ZFRRGi83C6zx0Ydz2/ppob4SCT+tu4XDajMcZzCbeFBXdsasJWPqkB
	x0m3vf43Hmahc5/q3vwrGR0ZuPQ/aWamoCdrzi5UmgJzNV+bzeHA3xJFolVibPnYgYl8r1AK04e
	h6h5A5kYpt3HFdsjXjk/jytt+zT7JfnlhvesFlpnVZ5j0Jv3iV2/Vyr7mFXUO1F/5frV2nlOFEI
	zL09mSZMevr/rbJIlfAFPTGECy9uEUdtiprE1hWCeTw62HSvaJiTmfVds8pEJA1rI8qPpowpsj3
	uyJIMzufcrNtzCtecWejOXP1npfTm03v/qGckIceB0Y4Y+WzA87HeBJFwI1kV/t2Qp9jyey8vaG
	8AoyfjHMp8h+vDzxvu7ZUCHX/uDeP9Nev+E2OUKtfEHrALltSaJ9t6oQ4Y5zifQkyOQOXVHX8PA
	MVIxN9tiDGe8UvQ9U3dkovpOkrr2z2uDj12Eer/JcKO4ZiHtSocMleyv5LH+we9hdnmwyZH2PeM
	zemhFw==
X-Received: by 2002:a05:7300:dd45:b0:358:5bc0:4f08 with SMTP id 5a478bee46e88-361a2b3a5cdmr7150254eec.37.1792341281979;
        Sun, 18 Oct 2026 09:34:41 -0700 (PDT)
Received: from codespaces-393231.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm26303667eec.7.2026.10.18.09.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:34:41 -0700 (PDT)
From: Eklavya Singh <eklavyasingh2106@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eklavya Singh <eklavyasingh2106@gmail.com>,
	syzbot+1459655b2bf1e798f9d0@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadgetfs: fix use-after-free after a failed bind
Date: Sun, 18 Oct 2026 16:34:34 +0000
Message-ID: <20261018163434.129569-1-eklavyasingh2106@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gadgetfs_bind() takes its reference on dev_data only right before it
returns success, but its error path calls gadgetfs_unbind(), which
always calls put_dev(). So when bind fails it drops a reference it
never took.

With ep0 open the count is 2, one for the superblock and one for the
open file. A failed bind takes it to 1, closing ep0 frees dev_data,
and the superblock still points at it. The next open of ep0 then takes
dev->lock on freed memory:

  BUG: KASAN: slab-use-after-free in _raw_spin_lock_irq+0x3d/0x50
   gadget_dev_open+0x4b/0x1b0 drivers/usb/gadget/legacy/inode.c:1919

syzbot gets there by making an allocation in bind fail, which is the
"failed to start USB Gadget filesystem: -12" message right before the
report.

Take the reference before anything in bind can fail, so that
gadgetfs_unbind() always has one to drop.

I tested this on dummy_hcd by writing a config to ep0 with fail-nth
set and then closing and reopening ep0, for every fail-nth value the
write goes through. Without the patch KASAN reports the use-after-free
right after the first failed bind. With it, 122 failed binds give no
reports and the last bind works.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+1459655b2bf1e798f9d0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1459655b2bf1e798f9d0
Cc: stable@vger.kernel.org
Signed-off-by: Eklavya Singh <eklavyasingh2106@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 67c6ffaf4..f5b97dcd4 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1688,6 +1688,7 @@ static int gadgetfs_bind(struct usb_gadget *gadget,
 		return -ENODEV;
 	}
 
+	get_dev(dev);
 	set_gadget_data (gadget, dev);
 	dev->gadget = gadget;
 	gadget->ep0->driver_data = dev;
@@ -1706,7 +1707,6 @@ static int gadgetfs_bind(struct usb_gadget *gadget,
 	spin_lock_irq(&dev->lock);
 	dev->state = STATE_DEV_UNCONNECTED;
 	spin_unlock_irq(&dev->lock);
-	get_dev (dev);
 	return 0;
 
 enomem:
-- 
2.55.0

