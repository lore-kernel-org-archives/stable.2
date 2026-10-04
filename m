Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204B71A6803
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791093452; cv=none; b=dtWPDkfas+LAwsk2cVMY8wpGuzWPBE0QgjvuZ9OrKM7ePJucwVd916NEEEyvlNss0U9478cJGbSpvHIBzRTt5sAO5l/lc6hVuF9F/efKKM+4WbBQ5M7BLo4w1ydX1bzbwC8INSRn0eo6hCaoC66g5MMCyYkfiN6iPjMJF3tnEEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791093452; c=relaxed/simple;
	bh=nsjlZHqNgA3qVPWv0QbhOCTWAKaUPTF7KW8tGj7QnEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGmgVQ6hGZEu9BZKNyc/1l32KGmEo6yT4wmGw6+JwJm15GqcZ2drnFzYJFAPKNmiHNsjijBu/c3ZTpRULXGQ/YhXFFqDvz55dUd1UwFMtUBxTWmW+aKnoESyZW/Q64EvMotq/rXptE6M6xNNTpduM/CZ++wRstdfCpxYCXJjycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPk+RTfm; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPk+RTfm"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-35118a5991dso389773eec.3
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 22:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791093449; x=1791698249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7DDS1Y4W2OZ7ywZrWFoVomdpg44Qk/IzddvKZYbeg2M=;
        b=RPk+RTfmG/EAE5q8xnidnCmW7wtGz1hgCrZofDm+wFAXOCQKSGM0YFzPNDQdyyfHgI
         t+LQxq6YZqZY5XsHN9tFyfWbS7PSjRy6opW8g7kPKrri6U10XMijscXuQOLMNyoGSapD
         kTImyFLZun66SjWTiL/+b54wnimTqzvkzbgqoUjoQ9zbA5ZuCKD78vi8HZadHFCj+LMm
         k5NKZaJ4Zjey/ici44ljB9bopnwLIWVPH4HCeJx34SxLlSM+NpQZQ1ku5LmZh1WruYJT
         dkD02C5HY4fX3sK0c2oPwn9t2zTzf6+hLFB3ivV5u4bfApJvwy5KDPuV6+hRvMs1+F9M
         bEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791093449; x=1791698249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7DDS1Y4W2OZ7ywZrWFoVomdpg44Qk/IzddvKZYbeg2M=;
        b=2IbBL3x4TJeOnzxORZ/VFpS0/gYJfDMzIIUQuqNyxTAqA1G+/tv/emtTavfts3R5it
         9Zp0h7R1QrepWWZGWRVY1cNhWpJ3itcM0XLd6Bc2ikbYAi/WK5shq+4TNMH22Q29QSIC
         fEw0AP8wICtZs3igDcAuIIdNlgZ+PDFGPlY2JNqgQCncF2d+B+41LEdq+vsC72RkNmnB
         s7GFrapqx4gRvJ1epBHfyu7SVSPDMo/Cj6bTqPbvuc0wv8EMbaBeY+mMUmsxl/wBPk+T
         Jb0gB+19ntUxv+DyoIKq1lORg4X/h7cnU/qkNWNYyzAprxa9j6lEt/TugnWY27Lwbp1v
         huKg==
X-Forwarded-Encrypted: i=1; AKwUvBw//gW2eBXbo67jPN092hpEAaYgmrX2ta++LN5B0KUGX70NWYX3LnxPuQVudtcDVclMuIxgbBc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRqpBdIGGSYSD++0+TF5WzEgmoAcZ+kMFzWXwqeMzpRukCOXAR
	mwKFmimWZIyM8uGmwPw2QMXdiwehBd8bW0YKGB5Y42n/VtajfRaam6HR
X-Gm-Gg: AYBFou2BsDos26gNmii+LMlSC/GwrWAhWKgVbcHwm84sORmk5XTyeTK4MzIjTZKMA12
	RxUlSoKyWoux+3OFnED2XVtSExpunz8DgZaN9qYf+2wxM4p9IWU8+2HSnfCA5Lf2p+bYwosWXqM
	V6jH2gV+shINSfbGXg4bcK9H/u74ubIQvJuns6GeDLn5lBNcZkdmsyy65ZQ89SLGQYdAr9Br2R/
	a35rt9pHnalaj7xUShVwPQK+9ESvrfgY+sb6ccrRZ2w+aZao038XfwSSmhYNWQOo7rocz/FoytI
	26YE/awYj3nJ/kvJ20I2Q8voGVM779En+/1jAwjljweXc04svGgjC80e2+u/Fy5+e5WIc20kW66
	AkEBcHI/SbFLgaA6X4cr/4qe4ZS0VbwqMorhPJRHCbzYWcJhCSqKPGhm42YahGBWq4et7ZAs32W
	bPyT3EDiFONcL/XNZD29wmtTohDgMZmBg8BnelzsoSi793WhGyDSOgUYxv+mi5WuSlKtSHn0WjD
	kNeM0hfnLS8Jf+YjjgFWaE=
X-Received: by 2002:a05:7301:782:b0:351:1e72:735d with SMTP id 5a478bee46e88-3511e7277b6mr2796196eec.19.1791093449042;
        Sat, 03 Oct 2026 22:57:29 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.132.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35129de5740sm757234eec.18.2026.10.03.22.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 22:57:28 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	syzbot+95eeb4ada2349a2170ea@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] md: don't hand out the array before md_alloc() has added mddev->kobj
Date: Sun,  4 Oct 2026 11:27:12 +0530
Message-ID: <20261004055712.1293-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

md_alloc() publishes the gendisk before it is done setting the mddev up:

	disk->private_data = mddev;
	...
	error = add_disk(disk);
	if (error)
		goto out_put_disk;

	kobject_init(&mddev->kobj, &md_ktype);
	error = kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s", "md");

add_disk() makes /dev/mdN openable, and md_open() only refuses the open
when MD_CLOSING is set.  mddev comes from mddev_alloc() and is zeroed,
so anything that gets in between add_disk() and kobject_add() sees an
mddev->kobj that has never been through kobject_init() - no ktype, no
kref, state_initialized clear.

syzbot opens the array in that window and issues ADD_NEW_DISK:

  kobject: '(null)' (ffff8880120640f0): is not initialized, yet kobject_get() is being called.
  WARNING: lib/kobject.c:642 at kobject_add_internal+0xea/0xcd0 lib/kobject.c:225
   kobject_add_varg lib/kobject.c:374 [inline]
   kobject_add+0x163/0x240 lib/kobject.c:426
   bind_rdev_to_array+0x80c/0xdd0 drivers/md/md.c:2621
   md_add_new_disk+0xe3b/0x1850 drivers/md/md.c:7684
   md_ioctl+0x200a/0x2610 drivers/md/md.c:8499

bind_rdev_to_array() is not the only way in.  md_run() calls
sysfs_create_group(&mddev->kobj, &md_redundancy_group), and
internal_create_group() has its own WARN_ON(!kobj->sd), so RUN_ARRAY in
the same window warns too.  Guarding the individual callers would mean
finding all of them; the window itself is what should not be reachable.

Refuse the open until md_alloc() has added the kobject.  mddev->kobj.sd
is NULL until kobject_add() creates the directory, and stays set for the
rest of the mddev's life: commit ca39f7502425 ("md: fix mddev->kobj
lifetime") dropped the explicit kobject_del() and lets the final put do
the removal.  md.c already tests mddev->kobj.sd for "is this array
published yet" in mddev_unlock() and md_run().

This cannot deadlock against add_disk() itself: device_add_disk() only
opens the disk to scan partitions when get_capacity(disk) is non-zero,
and md_alloc() does not set the capacity - md_run() does, long after.

Fixes: ca39f7502425 ("md: fix mddev->kobj lifetime")
Reported-by: syzbot+95eeb4ada2349a2170ea@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=95eeb4ada2349a2170ea
Cc: stable@vger.kernel.org
Assisted-by: LLM
---
 drivers/md/md.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 680b34a63cb3..e3326b78aef7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8610,6 +8610,15 @@ static int md_open(struct gendisk *disk, blk_mode_t mode)
 	if (test_bit(MD_CLOSING, &mddev->flags))
 		goto out_unlock;
 
+	/*
+	 * md_alloc() publishes the gendisk with add_disk() before it has
+	 * initialised and added mddev->kobj, so an array opened in that window
+	 * would let ioctls reach a kobject that is still all zeroes.  Wait for
+	 * md_alloc() to finish rather than handing out the device early.
+	 */
+	if (!mddev->kobj.sd)
+		goto out_unlock;
+
 	atomic_inc(&mddev->openers);
 	mutex_unlock(&mddev->open_mutex);
 
-- 
2.55.0.windows.5

