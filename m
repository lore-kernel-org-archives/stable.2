Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F539734B
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679709; cv=none; b=PvSEFpFBGRK97NdFv5gvvV0xkST6A2I8XVULuFYXV1zINWcVxXOENt+HVvBhKpPFRKo1S1Udzf6fsa1FZ16HjztBxwyv6+5ZpD2YNJz6lFGHiDoVjeZfD9StZC9QTjSiRG41JZfjyC/TMNjDE6Wd5BIaHaLyy7iVcFediJQ+9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679709; c=relaxed/simple;
	bh=BCSuNzV3i9qzPuO7vsAh/bgMmla4PBIRMAML7L/yF8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEhAd8CKJ5QmRf56RoNEW+Mvtw+pJ9p08QGaNJvErKz26Xu6FW7zjYmJwXvLERhjzoNsThRmS2Kh28CBL61wppLrApP2N+GeXburAK+D+eTwXFuouhcAYMydEnvVyLp+ZGl6xNjwhGWkhQx8u7VOEunoiM33/hgOKDqMnuUcns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvEAm0SO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvEAm0SO"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso2482888e87.1
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780679702; x=1781284502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om5VQEYS3XqaZggLn2efdbYdtVOE3N0WLO34GJA5ZZU=;
        b=PvEAm0SOP7wNFoVqEWC1b8ouRC3DLVbWCD86nRzOYCbdYGMqRK3IttBpbUpncfcyEO
         PtH8GIXPmdeUrVU5hiizfkFfTDbPgi5Wgv0fwHq/PfoBvG3c8+V/rqqlhf460Obv0VsE
         oooYARQzzgih/S+fifBcHkX/qFtlBETObJ0SCVEpvDP9bibP+jm5NZqlUqcN0Qo1isu8
         1CYTFJ7kVRhpvXWGhVRGQZ4UUyEWeoHHEem2hKU6kUBWwnr7Dt4sf4uqckB0C13eEH4o
         3Dtn6XVPaZxc5lZBAY1lbkVZXBTyQN1ncBe3ApMeOCTCn7z7XfoaDlavsQqRbeLHM8i2
         h/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679702; x=1781284502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=om5VQEYS3XqaZggLn2efdbYdtVOE3N0WLO34GJA5ZZU=;
        b=CIp3w1yUpZthVLfpCgOkJPJM+Gn6hl8u6d9+ECIVDVMSp4MCUNMxkUYpMFj6Su6D0F
         2o2IQKq16Y3H2TMROn6CD04A2b/wd97Mviq064Y4UvIOeG6nH59WRwRfVHxi1QKahGDS
         Q9Q4hG7xevkeXUawBBy/LudhwaPV2BeXblu3rwywUSKT5pxLphV31yKQmU6i9w2gbznT
         keDWBTf+C03mCL3+YGNgBxgqkJyp1cwyAR4GlRw+xn4W/EbmyARqB406ZIppiP3xQUN3
         sa2RckPFEaJ/rN1Vo0Pz76AR8KiXI7mPU8YqvYBjBZhj6vNM40ryUh8xzXc+JNA/aFhl
         tTag==
X-Gm-Message-State: AOJu0YzmqnDWaH/sTov9RoDvwbfhRXVL/z6gAMhhk1Js6Y3CNiNGunXd
	r8sEAI5JHM1DLXBmqAA4VBhsEv+Ai4MTcWiBh8/hXUSdIWZv21oB0n0zbpujk9MdrSs=
X-Gm-Gg: Acq92OE+Wixb+dgKcprdCD7z2A8wBpP9wDpav9J6SLOBOGT5xS9nTLYRnN8dZjUhA4K
	o4dAELe4zJ/NQbRaruIZvccNV3vV/bC5YK0iRven9Vw1jBjXIpkQO65jOhdMWkl+IgSj/qDcyMW
	hGrxpk97GtGQNUdYAB+dm61/3JV3TFS6R3LsEjQjZDNXHA/Yr2qfVVDTF8F6auE4PP7kHY7y1jP
	roR7Jy/+OLFVKX9Pg84AcSlHyEuh2h76ba91lsfMFPyCJ4qWlF17eAj0y7Gpz5rlsa3yql7iHDY
	NbIFd6ZEFGm/nBsifq/n9WpMJv1N7TkcuDG5kob9k//hBSDhGJcHYGGBnggXMzNiKtBydPZayIW
	3CcfYSx4E3WPH3dT1MZzvrLPuaQNHG/aDPce5KEhocfSE+5S6zqNpYBiIT76iA3M/nvHsdDaxwc
	7XodsO0cc6Cjlp6HDc9lCQxKBtEKbB+BeKUFGVZW3CPWVA+cVXkueVWqyWLi8VxMnvz3gb
X-Received: by 2002:a05:6512:1243:b0:5aa:6332:fdad with SMTP id 2adb3069b0e04-5aa87bc900cmr1323591e87.32.1780679702051;
        Fri, 05 Jun 2026 10:15:02 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b991b4bsm1991133e87.73.2026.06.05.10.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:15:01 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Kamal Heib <kamalh@mellanox.com>,
	Amir Vadai <amirv@mellanox.com>,
	Moni Shoua <monis@mellanox.com>,
	Yonatan Cohen <yonatanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Yanjun <yanjunz@nvidia.com>,
	lvc-project@linuxtesting.org,
	syzbot+4edb496c3cad6e953a31@syzkaller.appspotmail.com,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH v3 5.10/5.15 2/2] RDMA/rxe: Fix "trying to register non-static key in rxe_qp_do_cleanup" bug
Date: Fri,  5 Jun 2026 20:14:43 +0300
Message-ID: <20260605171449.1760-3-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605171449.1760-1-vlad102nikolaev@gmail.com>
References: <20260605171449.1760-1-vlad102nikolaev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Yanjun <yanjun.zhu@linux.dev>

commit 1c7eec4d5f3b39cdea2153abaebf1b7229a47072 upstream.

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 assign_lock_key kernel/locking/lockdep.c:986 [inline]
 register_lock_class+0x4a3/0x4c0 kernel/locking/lockdep.c:1300
 __lock_acquire+0x99/0x1ba0 kernel/locking/lockdep.c:5110
 lock_acquire kernel/locking/lockdep.c:5866 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
 __timer_delete_sync+0x152/0x1b0 kernel/time/timer.c:1644
 rxe_qp_do_cleanup+0x5c3/0x7e0 drivers/infiniband/sw/rxe/rxe_qp.c:815
 execute_in_process_context+0x3a/0x160 kernel/workqueue.c:4596
 __rxe_cleanup+0x267/0x3c0 drivers/infiniband/sw/rxe/rxe_pool.c:232
 rxe_create_qp+0x3f7/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:604
 create_qp+0x62d/0xa80 drivers/infiniband/core/verbs.c:1250
 ib_create_qp_kernel+0x9f/0x310 drivers/infiniband/core/verbs.c:1361
 ib_create_qp include/rdma/ib_verbs.h:3803 [inline]
 rdma_create_qp+0x10c/0x340 drivers/infiniband/core/cma.c:1144
 rds_ib_setup_qp+0xc86/0x19a0 net/rds/ib_cm.c:600
 rds_ib_cm_initiate_connect+0x1e8/0x3d0 net/rds/ib_cm.c:944
 rds_rdma_cm_event_handler_cmn+0x61f/0x8c0 net/rds/rdma_transport.c:109
 cma_cm_event_handler+0x94/0x300 drivers/infiniband/core/cma.c:2184
 cma_work_handler+0x15b/0x230 drivers/infiniband/core/cma.c:3042
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The root cause is as below:

In the function rxe_create_qp, the function rxe_qp_from_init is called
to create qp, if this function rxe_qp_from_init fails, rxe_cleanup will
be called to handle all the allocated resources, including the timers:
retrans_timer and rnr_nak_timer.

The function rxe_qp_from_init calls the function rxe_qp_init_req to
initialize the timers: retrans_timer and rnr_nak_timer.

But these timers are initialized in the end of rxe_qp_init_req.
If some errors occur before the initialization of these timers, this
problem will occur.

The solution is to check whether these timers are initialized or not.
If these timers are not initialized, ignore these timers.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Reported-by: syzbot+4edb496c3cad6e953a31@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4edb496c3cad6e953a31
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Link: https://patch.msgid.link/20250419080741.1515231-1-yanjun.zhu@linux.dev
Signed-off-by: Leon Romanovsky <leon@kernel.org>
[ Vladislav: apply the timer initialization guard in rxe_qp_destroy(),
where linux-5.10.y deletes retrans_timer and rnr_nak_timer. Keep
del_timer_sync() because this branch has not renamed it to
timer_delete_sync() yet. ]
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 0532c446760d..f7afb3da1f92 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -761,7 +761,12 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 	qp->valid = 0;
 	qp->qp_timeout_jiffies = 0;
 
-	if (qp_type(qp) == IB_QPT_RC) {
+	/* In the function timer_setup, .function is initialized. If .function
+	 * is NULL, it indicates the function timer_setup is not called, the
+	 * timer is not initialized. Or else, the timer is initialized.
+	 */
+	if (qp_type(qp) == IB_QPT_RC && qp->retrans_timer.function &&
+		qp->rnr_nak_timer.function) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
-- 
2.39.5

