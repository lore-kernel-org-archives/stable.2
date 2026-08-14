Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2420E702
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 05:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786686450; cv=none; b=JvC0XvMgC+y4og84Y9NgbYbJLz+JcGYPOOR6+Y9Ajnd1GZszc/hGa4Nc2GrYfoJozLeRbQIcS5lm95HUofuXBKNx+ndHOPZ9rf0uNgFDOuH9qNuJMl1I/d7voJ44cwZYKxP35WxYuirk2Ar6B9Lsa1PXsWJaJFLgjHU+aWUf4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786686450; c=relaxed/simple;
	bh=oMvs78DErDbcdftFBIhOblhbAVEsE/qBH/eS4efVx9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTw9fCTXrYTBqbII9FB+rn0h8dtdpNsNyqBfigQbQNSUvTFfFPerCOo3z3jId7J+YTnLGJ+2Rb7pDi4Y78OSvbmHAT9k5SgKJwTPNQmm97GkWSvgrluixbP2sO0T9ENSFNrcP5KJkJvAHa+xHQldKZyAPGCyR78aA2L8ioAW2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=txD5Hjnj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="txD5Hjnj"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dcbade417so647008a91.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 22:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1786686445; x=1787291245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sPTsh4UeNHKaUWQM56inzbGAY/LT8YwQEwZG5RKZmbE=;
        b=txD5HjnjvaI3hpcQQSWBYtB2p/WjO84njB197EaxCbyporYzqTRBJFaiLK9vdeBrfU
         K4xyl9HWvTn/BVHNJQT/p4AROdeeJz8Rgp0ltV34z6soqU4UZlKTKazEoKk+fGv67Yor
         fmdeg08JjVQVLTKGU7eHJByt3nc6nN28fqmzn4FLckZRag/yMNMR2+2UQ57MpSYX7FsI
         Sn1gfGZI0am72dRsjoU7Cr3O4WoQYT7KofHYbVeAzyo81rD52xRH1wzgGM5WTbDjwrlI
         led2hTwmOVTe65lb/K/ttUw07Fq6YalkF4fHDwoTTC75E0PmPyL4tiXZwvw9zsaHYPTv
         JThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786686445; x=1787291245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPTsh4UeNHKaUWQM56inzbGAY/LT8YwQEwZG5RKZmbE=;
        b=JbN6NMZfmQEY/n8pgKGbVM9+WHxgvRIUplvLwo86HGy0rnLQIAax7OZY3Cih11/ai6
         95T2OuJ40RhRRNJsU/lq2BDsXvrbOZ0w7V2+OkBUSy/fjDCUnWETAYt1h17hEg+gUmws
         XfMawk4XImMkJcLnxLrZsQM0Vy/5TiS9/BWYB5vNSt+/KZ2TML7/umSq5jsAQdD04/Hy
         Yik5D7SCASSVLOJ8BQ+qYn09PCiYUtt5N1Dn7G20AUT1ZlEN4rdIv/6OlaDVsstF/Ngk
         Jtd4V1+MfgOpKtE1jCvK5FSfdBFbQ6QcHRAcFb+1EFQybGcX/NcIX+fyXx5F6+x3vZ6s
         he1Q==
X-Forwarded-Encrypted: i=1; AHgh+RpSx7oLIvP1ednmUt/GUjtmdsl9LI4AwpzPwwUdsny/b/HnjBvc5Qc4mXZ5sAGqS0L69OXsdbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIqeoaSz4yv5PoG7buMlC1iS1oEQZcYUspEJboiTXz54R92xr
	zNLHSOKieVedaaeVWLCt63a1GwzXOQxEb1ydslXv2a+v4R6iomUr+gBgz93QGc9SHdY=
X-Gm-Gg: AR+sD11IpYEAy39qZqj2x834MjHi3ugx4EzrnzwRShyAs/IiwuKIuXiF9L7KD/ZdtIS
	/orAEHx9DtY0QiqewwOcjWjqHPg5F99x38Wp2kTc/sY41ubUSG8GzcWXegfYM2IV2BotioHYtp/
	KZvJF1Gpy0umjssOg3x+6bC8e9+gB7GrVJewh4gGBaShR5RgYQy6T4CI7PZt67DIhs63zf45mI3
	2AupBbD7MXKIqZ61lqe6TIelQWqdMe/Y0qDATAuY/Z21n5sEbzrUGmJd0f7x7bmjBivsR5KJxOD
	RSahaStXGxoQR2LmmyrMe2o1RDmHgNbNTP16U/05Cfpa+G0A40ElAVhv7z1Dob5eV0oZWWCoxgc
	5K+W9d1CR9YiEPEtOs0+Ud1dgfNAStWjOoDSrHMXavnnBGwR6IW8Kf1gjS4g0SH2cAL32YBaQip
	O+nLtfqRKsiRK6kECqJgSGFUqUVlJ/0ltLoDLSgPKtVv/FqAp/m56YDCX7b+k+NYnJ7lby
X-Received: by 2002:a17:90b:384b:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-3933baab759mr2900541a91.16.1786686445536;
        Thu, 13 Aug 2026 22:47:25 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebbcc34csm1040229a91.15.2026.08.13.22.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 22:47:25 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: sagi@grimberg.me
Cc: mgurtovoy@nvidia.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dledford@redhat.com,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] IB/iser: skip an unregistered direction on remote invalidation
Date: Fri, 14 Aug 2026 14:47:12 +0900
Message-ID: <20260814054712.260495-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A write command whose data is sent entirely as immediate data is not
registered.  iser_reg_mem_fastreg() takes the DMA key path and leaves
rdma_reg[ISER_DIR_OUT].desc at NULL, while iser_dma_map_task_data() has
already set dir[ISER_DIR_OUT].

iser_check_remote_inv() looks at dir[] alone and hands the descriptor to
iser_inv_desc(), which reads desc->sig_protected.  A target that answers
such a command with IB_WR_SEND_WITH_INV faults the initiator.

Leaving those commands unregistered is deliberate.  What is missing is a
check that the target does not invalidate one anyway.

Skip a direction that was not registered.  Returning an error instead
would break a bidirectional command whose read half was registered and
whose write half was immediate, which a conforming target may invalidate.

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
  CPU: 0 UID: 0 PID: 40 Comm: kworker/u8:2 Not tainted 7.2.0-rc5-ISERHOST-gf5098b6bae76-dirty #3 PREEMPT(lazy)
  Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  Workqueue: rxe_wq do_work
  RIP: 0010:iser_task_rsp+0x6d6/0xec0
  Code: 48 c1 ea 03 80 3c 02 00 0f 85 ba 06 00 00 48 8b 9b 78 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 20 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 76 06 00 00 80 7b 20 00 0f 84 3d 04
  RSP: 0018:ffff88811b008db8 EFLAGS: 00010202
  RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000001848
  RDX: 0000000000000004 RSI: 1ffff11021587b12 RDI: 0000000000000020
  RBP: ffff88810adc1ae4 R08: ffff888109b7f860 R09: ffffffff90a922c0
  R10: ffff88810adc1a1c R11: 000000000000003c R12: ffff888109b7f800
  R13: ffff88810adc1acc R14: ffff888109b7f820 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff88818a676000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000000005afe2b CR3: 000000010af23005 CR4: 0000000000770ef0
  PKRU: 55555554
  Call Trace:
   <IRQ>
   __ib_process_cq+0xe1/0x390
   ib_poll_handler+0x6e/0x200
   irq_poll_softirq+0x1df/0x480
   ? clockevents_program_event+0x2ba/0x860
   ? __pfx_irq_poll_softirq+0x10/0x10
   handle_softirqs+0x18e/0x590
   ? __pfx_handle_softirqs+0x10/0x10
   ? __hrtimer_rearm_deferred+0x156/0x450
   do_softirq+0x3b/0x60
   </IRQ>
   <TASK>
   __local_bh_enable_ip+0x61/0x70
   __alloc_skb+0x732/0x890
   ? _raw_spin_lock_irqsave+0x85/0xe0
   ? __pfx___alloc_skb+0x10/0x10
   ? _raw_read_unlock_irqrestore+0x16/0x50
   rxe_init_packet+0x16b/0x4f0
   prepare_ack_packet+0xb8/0x830
   rxe_receiver+0x499/0x9980
   ? __pfx_rxe_receiver+0x10/0x10
   ? rxe_completer+0x29e5/0x38c0
   ? hrtimer_start_range_ns_common+0x75f/0x1730
   ? hrtimer_start_range_ns+0xa6/0x2c0
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   ? __pfx_rxe_receiver+0x10/0x10
   do_work+0x144/0x470
   process_one_work+0x633/0x1030
   ? assign_work+0x11d/0x370
   worker_thread+0x45b/0xd10
   ? __pfx_worker_thread+0x10/0x10
   kthread+0x2c6/0x3b0
   ? recalc_sigpending+0x15c/0x1e0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x36e/0x5a0
   ? __pfx_ret_from_fork+0x10/0x10
   ? __switch_to+0x572/0xdd0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  Modules linked in:
  ---[ end trace 0000000000000000 ]---

Fixes: 59caaed7a72a ("IB/iser: Support the remote invalidation exception")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Measured over rxe with KASAN, with an isert target modified to answer a
command with SEND_WITH_INV carrying an rkey the initiator had registered
for a different command: of the runs that reached the device, 3 of 3
faulted without this patch and 0 of 5 with it, on 7.2-rc5 with no other
change.  A counter on the new branch fired 20 times per run against that
target and not once in three runs against an unmodified one, which
completed 2000 immediate-data writes each.
 drivers/infiniband/ulp/iser/iser_initiator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 12a2d12fef070..25875c6805abf 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -611,13 +611,13 @@ static int iser_check_remote_inv(struct iser_conn *iser_conn, struct ib_wc *wc,
 
 			if (iser_task->dir[ISER_DIR_IN]) {
 				desc = iser_task->rdma_reg[ISER_DIR_IN].desc;
-				if (unlikely(iser_inv_desc(desc, rkey)))
+				if (desc && unlikely(iser_inv_desc(desc, rkey)))
 					return -EINVAL;
 			}
 
 			if (iser_task->dir[ISER_DIR_OUT]) {
 				desc = iser_task->rdma_reg[ISER_DIR_OUT].desc;
-				if (unlikely(iser_inv_desc(desc, rkey)))
+				if (desc && unlikely(iser_inv_desc(desc, rkey)))
 					return -EINVAL;
 			}
 		} else {
-- 
2.43.0

