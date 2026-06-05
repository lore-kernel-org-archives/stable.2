Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A32EDD6B
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678572; cv=none; b=uSPMeQ1l2CMMlDGzSxo6IdIqfsdAwJO9f2uBt5psqEVgpgTvdPThPIS8f0YPyRytey/O2uJvlb4ZGtxAo1dpIf7Oq2ZbXLTQ3m5cz9ZzepSUFnBpdLMEJRGO4/MROu4H0HesUtwJPd7Dg7SroViZbvr6Kko7I5Oucry8DYkTU1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678572; c=relaxed/simple;
	bh=MRc9L3MHzlchKaFDuer7Ea7EidrnpjxvWHC5t70vnTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eY44MU3corr91fwqgCKe9hnj/oT0mzRPkAgvXRVin9B1+yJvsCdBZQySjzT5PTvCJgQE+WQG1ZuViD9NwDXL+pI6lhGDzX0YnJBxxyNGNg3pbU8Z/8MikkTm1ZvlORNdVvFy5MewH3U2OI3sEFLzZddciiITU+dJF5u9MfqvlQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GskFwMue; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GskFwMue"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-396669329fbso30027031fa.0
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780678568; x=1781283368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LcbsUqc+MsiNTTOsX/CXMoiJ4+9c20C5vZh5SOHsMVs=;
        b=GskFwMueDfHh8PRalw+nPzv5TvNtVq9dL8TWVeoLhIwKACSzWohgULG2iUcLYtlKqs
         DXLMiSQkWGgaMtCj8xw6XpsVKuYdrAczbi0wzaKOYsBfCTSE8UXbcLFeSWZRq2YnEj42
         WzOlT2sKHrBcd7hXlmTS9bqif0acm7Dvw8QQyaQxd9kqlaSwVUPe94l34jSTPDRM1Ibb
         3Wde8ojT5wvSo+XSvxeLRZXb4o9DBby6lmtXGRq63CREw57ws+zFOfOCQMK9mGoM5vDV
         0AsOPZMyvr4sG5X6OOnVQgQA71lPGOOyfd0lj9E2/UziF9Q9veVpQ4ezbSFIVFyoXpj2
         oiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780678568; x=1781283368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcbsUqc+MsiNTTOsX/CXMoiJ4+9c20C5vZh5SOHsMVs=;
        b=FAVtPAyLk84WMHBi6gCcnjInxoNGcuOrTg2/LhefNG7W0drEE0DZ2Iqhc58VtPw1Z5
         jawP32s47ZT5YORHN5GY7IQE4MSyd7Uo1Y3mPrpzNdpJipnJF02IIHZOjFnhm6qfwIzu
         vsecA+Gm885G6Dp5oFLLoTmBcEBYxGTro2PPj3wWewmzX/EqbXgqMYxZJnpFJaCYm2ly
         bZoz0uULLJlHEyOqWbHKI4IPfa7PEZcaI8XN9dcWbv5xPELtF/mJYYqdBuGvYSMWbD6x
         84aTmQqB+EKp7pXZoJ4d0/pkEbOGkQ2pzgtDJXfujigL+rvlRWQ5Y9SgyWGcLeLwhU2w
         eFyg==
X-Gm-Message-State: AOJu0YxqZjHj6YtGcrdZL4o7XuxElDZq851Gc4e/nil0gKxyRrNg8by8
	EudKXqgzeLScctlw9cabR1xhzLC0qeGUQEiWLHCsTY9BWXgaIBvBcYwN5OowoP33v0I=
X-Gm-Gg: Acq92OH6IHAjhsDhHgRqhVKXjhAz8QdQFV8Rv/HxNRFLIZMp0iRb9lK8PEEyFophNTh
	Putq60JxwqmtL9ATlV3Hrv7drdQpVt0JJtDT8DLxr5PKy2Tb0yrBdZDeDBePHfN4G31keRzWbJa
	GZNIOuV1fBksLnArDlbLYdOHbBKNSmCHCHI5XFAS/ggtk0o3Oq5ROZEmRkUwh3UrAXPH72LOOGP
	2p+PHHByC8U3Y5yfQOlGdN5LCpmdlDphFZ6NunP1pxmTR2tmoEJ549iEGDm6dQ5O1Y8lSoQc5se
	d4+ALvZ8rzSFbMkzKxtSFXVL5gYryXHHPBiPqAO38mYmIXDtCM/fhQseNoMMvrYRAHxMg1gvofj
	b1kCsX3i4N5QBrZ44nICMQ0m79GFeK2yaT5Xkz+FA9NqqaOLSchtFV5nMg3Per+0yBYA6xGnuLG
	Pi/9ZRCMUnvXVORySRvxOUVrulRxqI/1bbKmnW3ccF6FO8GZ0D+C4+0kstgrfBIELGUN8/CfFt2
	fxqtsw=
X-Received: by 2002:a05:6512:1416:b0:5a8:89d6:93cf with SMTP id 2adb3069b0e04-5aa886c9d81mr901654e87.17.1780678567732;
        Fri, 05 Jun 2026 09:56:07 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b98fdcesm1929946e87.62.2026.06.05.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:56:06 -0700 (PDT)
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
Subject: [PATCH 6.6] RDMA/rxe: Fix "trying to register non-static key in rxe_qp_do_cleanup" bug
Date: Fri,  5 Jun 2026 19:55:44 +0300
Message-ID: <20260605165556.1082-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
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
[ Vladislav: keep del_timer_sync() because linux-6.6.y has not renamed it
  to timer_delete_sync() yet. The actual fix is unchanged: check the timer
  .function fields before deleting the timers. ]
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
Backport of upstream commit 1c7eec4d5f3b to linux-6.6.y.
 drivers/infiniband/sw/rxe/rxe_qp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 287fc8b8f5ba..8426c261c263 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -817,7 +817,12 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	spin_unlock_irqrestore(&qp->state_lock, flags);
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

