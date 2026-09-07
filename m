Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1FA4A484F
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785490; cv=none; b=Ld81nLkCNj5jtYnGuzexD3Zln3lKCgo9JtYoqZmb4/toCTTAUvy+hy8VML4zGUG5rZdVfttBcGa2vbQBAwQEU2ZawA8m3xt4lpjIHOozVlwjIITPE1Mvr+w4nnPCJ1Pol0oJOOnNVnXuPatUF0drXm9zcdnKKDF2DWFCJPf8988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785490; c=relaxed/simple;
	bh=aW7hatZn2PpeeX0Omd59RaxwaKSASjvjLcGck38fRFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftbFN6W69DjDw6d5sQjUcFzj9p8LB1VXI1p3T/Hr9UvYx97sDpERGrcuw42NeNaNQiKjAA2iA6Q7zyD7Nkr76GeRCG+/PE9+xDk9ai3DKwMOTMZxn1PoHJs7mGTw7dw2dtPqQS3WM/ozlHdNvTS+E1Lfk5aa4Xi33hi/ltPOJys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T43XwUo9; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T43XwUo9"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4b381337e1fso3241504b6e.1
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788785488; x=1789390288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3dYzFdAjB0JuhffEuOLEkAByLAlefLT6/4p7ylBlrTw=;
        b=T43XwUo9SMgAMCk3se3Zl+wazaWtd3TwE1bO6Y5udLxq1Uid7p2zii6larAEXVJ342
         JU6sUUatbNWx18RNA182IMysOHuXYol6Rq2eSh4418bg/1jXCKSWvD+Dbh0iwkpDe6J7
         UfBGbJdMLizW/dZXrUtBDl5fhscG9j+sRHm+APSCqPEH9yNhYOXoce66Y0lbc42Kbky9
         d/WxEXGn786Xy1voXTBJdX6K+qCfYsl1rqXaYh0y3BLtFuSoT00yt9CPS34BhInYZgUr
         xCOFHFUjpV6AjlLNSHfgEghBSx4TLFl7oN91oo8U2pFcvqPvKIBKhHrmIqNqKfKObZXV
         UjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788785488; x=1789390288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3dYzFdAjB0JuhffEuOLEkAByLAlefLT6/4p7ylBlrTw=;
        b=ThOjfedNw9/+eylREdx9xCC/Ke/zoXmi6xyN8g6kRu/azYfCJhNgGOfr93Yz4oJDgM
         IsAQEPXu2PVuoegJQtjRhexFKnPGHrzufiYRteAdikodIROKjujy5BLBnEHSYGTCW/qy
         P1cJWIxVj3LyaDTkWylGz5qPYaIMUx5ufQdbn5hN3GDnhyGPqJPBXLePPaG5+ohwLfXE
         4svKim3yUrSadYpyQm57GgJbp7DEBaM7w0FmLOdq/53L/1J3x+4/ET9YKn/EzmRJ60Ce
         RxiPYjJpKOYTDraOJaFZMN4VC50NXwlkOkE1ReI2wBJgojiUpgzk8U8j5i+u9Zgv/kay
         L0hw==
X-Forwarded-Encrypted: i=1; AKwUvBwfboYRYtiTNw2w6RAdUYTf1Allm6Lf5r94Fw7F/yEDlrlAn4MsTeXjDKUUxo5Fl+ZUIpotmhg=@vger.kernel.org
X-Gm-Message-State: AFuF++l7+HM4/TaGmsVCgyFAX/+7AvBUma/CBxHVAjvosXLRecyNWQE8
	73pXV4TN0eaMR5x6va+XrTMoEQM8yyqmrOWY0b217TE3YkEmIh0Onqg2
X-Gm-Gg: AYBFou2zN0NvPwYwFztCpSk21X0w0byNLeTe7eU8Nz8GETBYqCG/Izso6EMi3pNaFeF
	WVcFzEracPC4dZgWgeLUjfnPdK1l6Rdbk0mEEqpcyXJT95tvZGPZoHPhVLRnxH0P8zKysGczVIP
	b98wHHuAh0e/s8Az6i+/bF5sF3KbJLTgS0nhX/t2DFngZte6QbUXov6UnmB2/lp8fVQH+/Q8uxh
	kkAyn2y1aQVK2fJLk3HB1uFY8eBUT0pKXTtDc95va5S1oKtr8dyPTd9G0OC5ZVf17Awo6rM09rb
	5/QztEWeUpC1eSHtygr/qoVAfFp6ZapNh/NFa3ei5smLMbvK8oN0At7Cj8fb5A2PIKHjRdMsQJV
	pttHyvWOe4uFZkg/mmGY2O565ge1688YIsd8jC83RLY1tSK8pSfW9flcUQZkW2R2M0lUVcno+cx
	uMZUzDPZAxF1qafWaTy6NJK03TXUjAAsn0g9SjYjs5r4qUuJwZVARXfteec/k=
X-Received: by 2002:a05:6808:d4c:b0:4ab:230c:5faa with SMTP id 5614622812f47-4b9645205bdmr14048174b6e.18.1788785487692;
        Mon, 07 Sep 2026 05:51:27 -0700 (PDT)
Received: from localhost.localdomain ([107.173.101.132])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4bb838f7c50sm6110477b6e.10.2026.09.07.05.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:51:26 -0700 (PDT)
From: "Ziyou Wang (Lenovo)" <ziyou.dev@gmail.com>
To: bottlecodes@gmail.com
Cc: "Ziyou Wang (Lenovo)" <ziyou.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Fix use-after-free in idxd_remove
Date: Mon,  7 Sep 2026 20:51:21 +0800
Message-ID: <20260907125121.5928-1-ziyou.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When unbinding the idxd driver, a use-after-free bug occurs:

idxd_unregister_devices() calls device_unregister(wq), which triggers
the wq release callback and frees wq memory via kfree(). However,
idxd->wqs[] array still holds the freed pointer. Later, when
device_unregister(idxd) calls idxd_device_drv_remove(), it accesses
wq->state through idxd->wqs[], resulting in use-after-free.

KASAN report:

  BUG: KASAN: slab-use-after-free in idxd_device_drv_remove+0xc1/0x100 [idxd]
  Read of size 4 at addr ff1100038d296414 by task python3/3354

  CPU: 20 UID: 0 PID: 3354 Comm: python3 Tainted: G E 7.2.0-rc5-debug+
  Hardware name: Lenovo WenTian WR5220 G5, BIOS speb50m-2.54

  Call Trace:
    <TASK>
    dump_stack_lvl+0x5b/0x80
    print_report+0x153/0x4b5
    kasan_report+0xbc/0xf0
    idxd_device_drv_remove+0xc1/0x100 [idxd]
    device_release_driver_internal+0x244/0x2e0
    bus_remove_device+0x195/0x2b0
    device_del+0x24b/0x540
    device_unregister+0x17/0x80
    idxd_remove+0x3f/0x120 [idxd]
    pci_device_remove+0x6d/0xf0
    device_release_driver_internal+0x244/0x2e0
    unbind_store+0xae/0xb0
    kernfs_fop_write_iter+0x205/0x2d0
    vfs_write+0x3a9/0x6b0
    ksys_write+0xc7/0x160
    do_syscall_64+0x9c/0x620
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
    </TASK>

  Allocated by task 1219:
    kasan_save_stack+0x20/0x40
    kasan_save_track+0x14/0x30
    __kasan_kmalloc+0x9a/0xb0
    __kmalloc_cache_node_noprof+0x1c6/0x470
    idxd_pci_probe_alloc+0x103f/0x2430 [idxd]
    local_pci_probe+0x71/0xd0
    local_pci_probe_callback+0x20/0x40
    process_one_work+0x389/0x6a0
    worker_thread+0x321/0x590
    kthread+0x1b4/0x200
    ret_from_fork+0x3bd/0x4d0
    ret_from_fork_asm+0x1a/0x30

  Freed by task 3354:
    kasan_save_stack+0x20/0x40
    kasan_save_track+0x14/0x30
    kasan_save_free_info+0x3b/0x70
    __kasan_slab_free+0x6b/0x90
    kfree+0x1d4/0x520
    device_release+0x77/0x120
    kobject_put+0xdb/0x2a0
    idxd_unregister_devices+0x5b/0x130 [idxd]
    idxd_remove+0x2f/0x120 [idxd]
    pci_device_remove+0x6d/0xf0
    device_release_driver_internal+0x244/0x2e0
    unbind_store+0xae/0xb0
    kernfs_fop_write_iter+0x205/0x2d0
    vfs_write+0x3a9/0x6b0
    ksys_write+0xc7/0x160
    do_syscall_64+0x9c/0x620
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix by changing idxd_unregister_devices() to use device_del() instead
of device_unregister(). This removes sysfs entries but keeps memory
valid. Then explicitly call put_device(wq) after drv_remove completes
to properly free wq memory.

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Cc: stable@vger.kernel.org
Signed-off-by: Ziyou Wang (Lenovo) <ziyou.dev@gmail.com>
---
 drivers/dma/idxd/init.c  | 7 +++++++
 drivers/dma/idxd/sysfs.c | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 4b827a329756..1d47918f7ca9 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1266,6 +1266,7 @@ static void idxd_shutdown(struct pci_dev *pdev)
 static void idxd_remove(struct pci_dev *pdev)
 {
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
+	int i;
 
 	idxd_unregister_devices(idxd);
 	/*
@@ -1284,6 +1285,12 @@ static void idxd_remove(struct pci_dev *pdev)
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
 	pci_iounmap(pdev, idxd->reg_base);
+	for (i = 0; i < idxd->max_wqs; i++)
+		put_device(wq_confdev(idxd->wqs[i]));
+	for (i = 0; i < idxd->max_engines; i++)
+		put_device(engine_confdev(idxd->engines[i]));
+	for (i = 0; i < idxd->max_groups; i++)
+		put_device(group_confdev(idxd->groups[i]));
 	put_device(idxd_confdev(idxd));
 	pci_disable_device(pdev);
 }
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 6d251095c350..da0699b64db4 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1991,18 +1991,18 @@ void idxd_unregister_devices(struct idxd_device *idxd)
 	for (i = 0; i < idxd->max_wqs; i++) {
 		struct idxd_wq *wq = idxd->wqs[i];
 
-		device_unregister(wq_confdev(wq));
+		device_del(wq_confdev(wq));
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
 		struct idxd_engine *engine = idxd->engines[i];
 
-		device_unregister(engine_confdev(engine));
+		device_del(engine_confdev(engine));
 	}
 
 	for (i = 0; i < idxd->max_groups; i++) {
 		struct idxd_group *group = idxd->groups[i];
 
-		device_unregister(group_confdev(group));
+		device_del(group_confdev(group));
 	}
 }
-- 
2.53.0

