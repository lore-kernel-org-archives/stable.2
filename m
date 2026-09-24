Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7DC4B7172
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278222; cv=none; b=HR4EMqdK5DQqD1Y88ljOuRpI/jMrDs2CQ6jONhSRVN1B1Kq0VsgpEDYNfeSSCE7IUcd4krAc3NP6i0uZXFDCXypTutJla11rj6jH3Jx5LC7peruOihA9AHXP9UPyvhrTgRMgA5sVErkJ/e3PwsrJe8+z0vKvZFlKKnV4uiJvxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278222; c=relaxed/simple;
	bh=OzqluZqRVfMingGFZl8Ew6dmAbmJFB15xftTLwFF31c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQRDtRmHUtC10yBKSlAd31Gavdji4ckGUE8Dac1UKxvUPp/8TNe9c9jcdLf3pNlVW+8kgnBr7vJ7lz0+vcEZkHPpMwcVfFfMEnr6fi6vCUZ5u+2OOCR6ms0BrYCAmsKo1EWAUkYXP6dq6h7uheV2TBJSpmPtHowKrQtyEvVVsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnzXOLy6; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnzXOLy6"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso635765ad.2
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790278220; x=1790883020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FULwkoFMwVo8tcQ8iB8waPMOVXDiej94ubxh80J+bpE=;
        b=OnzXOLy6YY0Xmqhh7G0VUhv6KGZLGOILJ+860EnHj+qZySYsY8wgCDnRnupL7udqaD
         ntHlDjzr5yVEF+o4J9OSA9Tg/WymXzrnCbq9M9RTIUCb4fSK/yTgSOuDQXmf4y5NRkLK
         wsMZH2Iou6/Xd7OVNmEWYLDd8JF39RhWyvXF3JiZeXZyZw9j98/P8RXW4qb4TVp6hXuB
         zeNxjuPQtZ8TRdqGrRxCzulT2WPpKFjFw6U31U6sksn+EbqxW7pK05tkbC63qCJOCvR+
         GtYwRANf38Nlbq57JfAPLVgchmmQMjUhOj0kSrSHKPAma+5MPvUwleAMofFAS5ipgKFt
         7u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790278220; x=1790883020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FULwkoFMwVo8tcQ8iB8waPMOVXDiej94ubxh80J+bpE=;
        b=P9uduevdI935inh+7QuS9Q807j3iwIXpH+z2MmM6OpYDm4vis750XvTmR5Hz0Zb5l3
         f3qTbXYXN6EOYbRa3Z2XyqfdWO/VxqVzSMW5aS428cSazjEz1Pq+MBIbo1lqqwZF1UMc
         wvnus7eaEgPGkCo1HXxSP1HNF7rHki3V05TKr3sU9qDH2xpGsJHDX4BNutQp5MXUGabw
         K7KMVRhkfLUwNRMEBv9L1j31SCfX84spTcXfajjzjdMamX7LfsWY91yobwl8i+RpRjTv
         nOuba3AKU5GlF9TRqcFJYcSSZAgomIBeZfT++BAa/9hO+2/WB7p1uBH0twGtPdBcCcWW
         mRzg==
X-Forwarded-Encrypted: i=1; AKwUvByxW+a8xtJPITKIFQUWJSTQHreL7SRPZ/uXzmE2vz3xQXvtc1phixGFhR5Xd3Gp+n/wgv3/xWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mit/vQvXqVUmRgpNqvOCl3qG1EkmM44Pl3fo0FJy0VnDmIo9Mz
	2vRECjfxBOADDerH+fUtcvSUX/qbnho+wQfGjNuJkkjzak12BqhMaxYy
X-Gm-Gg: AYBFou0Rpl7uE72Rhj/ZeMtUJpjcIrQ0AvJ5mWnucSwbLoIhpB4H7kmoKV/wRanPNfw
	11q7bfeaMlaxgHn9JXdWMMlUFrbiWFKwmw6tuGJufTvHQhkgJlyFWA1dVz3koyrSlFnNeYTr9pO
	VmbmitTabMEvha67H9xY2NgyHYK7lQFhlR3D+lF6Vhqc1p3DaZ/JJhfY6KivKJwTW45HLQK+/eb
	juTJnRRGmt6++iuHUdYGzk0H82k5Ez2Pbg8DcshCMbmmNnqxM6MP3/tiZszFwGya6TSFbfq7cQa
	5M6961rKvPU6T2K8cdg1yAymOL9gJC7w3u6Hy0g/4QD8AUC9YCb3K3VLYriXXLcxZ2L9o6i6lOh
	1qWD9nqpNKChSSu9QLiSf7T8old2GwaFUXQstD4xjbvlaDHJWnY8ZqhOaFMyb1HdOG1TEaz6/O4
	vOuegS1n27SFd7lEHhkcSVEIYUjy7/Nv2FOxzceFhSezhejCcQhs9yoaCD7ldQl0C8KlzEs6DtA
	U14tUV/DGB5bANzbaJk+8TH
X-Received: by 2002:a17:903:240b:b0:2dd:c053:ec70 with SMTP id d9443c01a7336-2df7e119fc5mr34820385ad.35.1790278219488;
        Thu, 24 Sep 2026 12:30:19 -0700 (PDT)
Received: from localhost.localdomain ([103.77.186.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9140545bsm858585ad.39.2026.09.24.12.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:30:17 -0700 (PDT)
From: Raj Ojha <rajojha047@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Raj Ojha <rajojha047@gmail.com>,
	syzbot+ccffdf05833ebdaeae70@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] memstick: core: wait for request completion before freeing card
Date: Fri, 25 Sep 2026 00:59:55 +0530
Message-ID: <20260924192955.1941-1-rajojha047@gmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In memstick_alloc_card() and memstick_set_rw_addr(),
wait_for_completion_timeout() is used to wait for device identification
and address configuration requests to complete.

The memstick subsystem does not provide an abort or cancellation
callback in struct memstick_host for in-flight requests. If
wait_for_completion_timeout() expires (for instance, when a USB transfer
or command retry is delayed), memstick_alloc_card() returns an error and
frees the memstick_dev structure via kfree(card).

However, the host controller driver (such as rtsx_usb_ms) is still
running the request asynchronously in worker context. When the transfer
eventually finishes, the driver writes into host->req->data, which
points to memory inside the already freed card structure. This leads to
a KASAN slab-use-after-free write:

  BUG: KASAN: slab-use-after-free in ms_read_bytes+0x8fe/0x990
  Write of size 1 at addr ffff88813c188079 by task kworker/1:5/5239
  Workqueue: events rtsx_usb_ms_handle_req
  Call Trace:
   ms_read_bytes+0x8fe/0x990 drivers/memstick/host/rtsx_usb_ms.c:450
   rtsx_usb_ms_issue_cmd drivers/memstick/host/rtsx_usb_ms.c:477 [inline]
   rtsx_usb_ms_handle_req+0x557/0x1a00 drivers/memstick/host/rtsx_usb_ms.c:531
   process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
   worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
   kthread+0x373/0x450 kernel/kthread.c:436

  Allocated by task 1662:
   memstick_alloc_card drivers/memstick/core/memstick.c:383 [inline]
   memstick_check+0x2c1/0x10d0 drivers/memstick/core/memstick.c:452
   process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396

  Freed by task 1662:
   kfree+0x20c/0x650 mm/slub.c:6792
   memstick_alloc_card drivers/memstick/core/memstick.c:420 [inline]
   memstick_check+0x72b/0x10d0 drivers/memstick/core/memstick.c:452
   process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396

Host controller drivers (rtsx_usb_ms, jmb38x_ms, tifm_ms, r592) already
implement their own hardware and bus timeouts, and callers in
mspro_block and ms_block already rely on wait_for_completion()
unconditionally.

Replace wait_for_completion_timeout() with wait_for_completion() in
memstick_set_rw_addr() and memstick_alloc_card() so that the card
structure is never freed while an asynchronous request is in flight.

Fixes: baf8532a147d ("memstick: initial commit for Sony MemoryStick support")
Reported-by: syzbot+ccffdf05833ebdaeae70@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ccffdf05833ebdaeae70
Cc: stable@vger.kernel.org
Signed-off-by: Raj Ojha <rajojha047@gmail.com>
---
 drivers/memstick/core/memstick.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 7f3f47db4c98..1a2b3c4d5e6f 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -378,9 +378,7 @@ int memstick_set_rw_addr(struct memstick_dev *card)
 {
 	card->next_request = h_memstick_set_rw_addr;
 	memstick_new_req(card->host);
-	if (!wait_for_completion_timeout(&card->mrq_complete,
-			msecs_to_jiffies(500)))
-		card->current_mrq.error = -ETIMEDOUT;
+	wait_for_completion(&card->mrq_complete);
 
 	return card->current_mrq.error;
 }
@@ -413,9 +411,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
 			goto err_out;
 
 		card->next_request = h_memstick_read_dev_id;
 		memstick_new_req(host);
-		if (!wait_for_completion_timeout(&card->mrq_complete,
-				msecs_to_jiffies(500)))
-			card->current_mrq.error = -ETIMEDOUT;
+		wait_for_completion(&card->mrq_complete);
 
 		if (card->current_mrq.error)
 			goto err_out;
-- 
2.47.0.windows.1
