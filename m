Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1436997A
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679083; cv=none; b=agF6/n7xYOm89m4p/wPLvQhFxhaH3nwB7bvqRNSyKi1MXJgUnr7hQH+t27kEAMBT9eqWept1nYwjGKDn/q0bPd9NzpRO1f6D1lLnNltR/zdbnFRuLkQNPAlHL5QIX2jYmlUKe0HxBAQ08IRaFe+2bgcctAiKBP6NEviOHw7Fka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679083; c=relaxed/simple;
	bh=S7SzpnqAm+mTqvd5IQ/Epq+Wa3ov0P4LXqBXb7TQeL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvOTLQ+hc4nLU49zRKgHbnmNWMeyWde1LlJ+QziPM4oMm4p8YrtdeXIfEO0d1E03uBg7guIVMyzBsIGAN8CCoHSLvsehYz05Zhlc2dM04vNLVbpwnbrcovRNv3ZLqlYHO0Y7X4jLWWnW0ViYwEGbvXChFzkStOlLvcxj5Y4UneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OclVuCmS; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OclVuCmS"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39676ff4674so20134811fa.0
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780679080; x=1781283880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31VTJLcsi1UWnRchazyAHO/664C8JXW9dEs1B2pTJB8=;
        b=OclVuCmS1paE5dDRqf9JHTYtF1xPDZrcN/P3IFXiaOl8UbEx9bYH5WzJaev5eA46eG
         G4FRKKC+YlXZtXvFUkBMphFJ0NN6L0AwhHjZTDSQ996qsyZxbPAdVXvJITxQT649x9gl
         Csx0nCo8wxVCPyt8RZMLv7ChKUY90xR5vvW4C+UxfgCajYWg2CU2CmEHzAen59veEkDi
         ibs0BalpewIkKYG/Rlvma/C9nUsTGsv9231AlcqO61s1BLgHOa1dw2QxSB8f/CqbwB6z
         iEe9n4N+xxiYp0MkmSkH6yuvfh8Js1T0OyF+emFCDvw2uJZ6AXw3dLEitx8sIhVPFP5n
         EOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679080; x=1781283880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=31VTJLcsi1UWnRchazyAHO/664C8JXW9dEs1B2pTJB8=;
        b=AeV8i6k+ZqEuFYeOCjOx5ogJIJ4v2swk2Q/NcJ7hzf1s4M4RRtcci4AkPfKdneUCH2
         X8oEG1fzc0OmA1lyzPsPPS/9bxJUKun7dg75bl3QHku3rj7lcGFCDF+184OkT5/kOmrf
         bDN3eryvByI8CKUNGvbJGysiMPbZGMcjqIWmhc7KTb9hw40nh7pRJFAqTJgsCylePAkr
         otMgXMq6sD56RuLCzPMKMwSbG/D6cDC72R22QY6eGAP3m9USm9kk0ZxOg4XLLlrJ/d6g
         5Xe/HoF+xffjfosabJ4e8NuSa+YQdy1ogpfTegK6OG80pOVjc0R4120e2h5Zc9xdWHSf
         /KUg==
X-Gm-Message-State: AOJu0YzmZgFYl5pzdZZ4k6QXeX4SwfIaDQqsxNw8hQrl26TBiwgkxsZI
	w53xyUVJnAQSCIlxfVKhT30yYDYXIdfJUmtHRpywiVlwPj47sBgVp5pN0J/GW/1cooU=
X-Gm-Gg: Acq92OGVp21fBtcM+eG27968jP9Yy1g1LdOBvJTUaLZHDX9JJmluvse6HUzkGTlkyNy
	YG9/n9QDJnjlo6zqf++2PqrbsB+F+7S3UND0W9RFfWJrnmRuHJzeXbu8qOBrP7RV4MKmOid+Hj1
	GB6SV4WFyoQ7YQx719vgr1BwVS832mFTr8TSOT4asZ/7GGQF18+NeBv9PH0UO3tIFyxGSaljGl9
	6witsInWokJxVkYC5OcnStIleuOlAEpU8qmtdv4UmXi5/J2SamNhn0nPM7fZzyFR9VVFiaR/Ie/
	QmtHhLhNcA+HfTweHC0f193xxOJqf9HofFI7svk2lE74WgrgKnzntS2RtCCEmiDaqnN752TQrze
	VkjedYR1i8TxyuqZd2G1LHzMfNox4O/QCpgygZfrNqmIfdvY8ycntK7ZCkoX7UN3oK2U614JyDO
	m3vBbHaRyOs8Ab/GF5A6vatIeaS66X91/2dfr58vvt8wAMrzTMrd5sKDFXOYmlgp/bIXyYeyPsT
	0MgpmA=
X-Received: by 2002:a2e:be0a:0:b0:396:8c15:a4c5 with SMTP id 38308e7fff4ca-396d07f0a57mr12861801fa.1.1780679080033;
        Fri, 05 Jun 2026 10:04:40 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac07b66asm26931161fa.11.2026.06.05.10.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:04:38 -0700 (PDT)
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
Subject: [PATCH 6.1 3/3] RDMA/rxe: Fix "trying to register non-static key in rxe_qp_do_cleanup" bug
Date: Fri,  5 Jun 2026 20:03:29 +0300
Message-ID: <20260605170349.1524-4-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605170349.1524-1-vlad102nikolaev@gmail.com>
References: <20260605170349.1524-1-vlad102nikolaev@gmail.com>
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
[ Vladislav: keep del_timer_sync() because linux-6.1.y has not renamed it
  to timer_delete_sync() yet. ]
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 171c0f4dcbec..899fee5f145a 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -782,7 +782,12 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
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
2.43.0

