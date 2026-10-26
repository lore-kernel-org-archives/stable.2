Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973269;
	b=rUyTXI6pnyDqAqzl8jXvaV6j2zevk34ErESc/+Lx9WymEJCELmdI4cl+LgDk3CF3T/ff
	 0H+J/G/YThW2EIhpSu8VOoZHVFlHgaK82DCtj3WH/J0lJTMAdn6o8iMF1o5TyuSnQrDn5
	 BrL0j/Ed3dpkd4GPwqBEcD53ozS8J440ZXD76qrIh3rvJn6XKQy9QKGFAqTXj7i8kVohb
	 hbuXllGaA93r+qMWQOcjWg5hM7QprpoXeW8dxtD6i0mufwa/O6dqmg1JYkgxSXOdbDKl4
	 6zNQ73RfxYIJ4TQJ3C6R6gySpGJFIM34wjCQxXqLlAKv0sDJPiAsXcoOXnmr9CGAKIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VdkT2RHYcWV7GvnLz4TIAWoUXNhRorpoV7gVhnHjlPM=;
	b=QACvBtclTgx6GqNvnUI58Dn5vq6CLNxvMnw0ISgeMnNe+6z8fsm8wr7IG4uAD9E5rFUS
	 2WXUVp3OEwMrK2u8nQKqaOXAWx1RFBjXOVqlhjufTWmUMvEtYAY+HkVOOrNOdinJFpD/x
	 4IOdSb9LE/HbqsICxbQ4D1BKHklpk5PAABVTCdxRQYVdQnIaQds44mmV9FCI9ReNWVAI+
	 TKbW/NLspscKZIquOxX1dfEOTP8+hFh9TZwyPqzwbX8jEOjGu14w+K1phmPdpJQXvm2bp
	 RCD6+5fJ5Wkk8m9C5adszwPqMqpYBH+x1hRXCF/uyB5ybkJviNnZnyRdG3v0+MWPU/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=lj3sD4Am;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0B606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 00:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8F0B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=lj3sD4Am
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1697382a91.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 17:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792973267; x=1793578067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VdkT2RHYcWV7GvnLz4TIAWoUXNhRorpoV7gVhnHjlPM=;
        b=lj3sD4Am/aiIHN7NCAcRfN8n2iip+RovV4pk3Sly44YZsCSGUEBj0DgCgvVeVkFXdQ
         9TlJQ9zIP1xpPhhThjHi7/fEoyCZRadpXMA1mFN0dhmRKlBS+4Yt6sMuPKdAuYTKmidm
         wgYwnYUCIvkmHVBO2/TiZnuiRiDbFG4dm4oWEGSBwkyrgtcU7j0RrzOCZblUVFiuZDap
         KcKh1TNZmjBRoqMHVb+CyrBPd08FR3LSOSHmDKWpeihRtLAhNA+D9/GvJ5NZFCt47jbV
         p2c18tE05jCBwMtNuFxU8O+gxvcJdUzcIBhe5NRpVL1PFgtC7pzBztio7v/bKGy0ffTm
         KMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792973267; x=1793578067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VdkT2RHYcWV7GvnLz4TIAWoUXNhRorpoV7gVhnHjlPM=;
        b=yjh+hiA6a+lVNWclQOs1IZqhlNc451S325EjjL/tDQS1ogbPodOGE1lJ9s8cwbDl4j
         wfHd7tOQCG+AieTZBZMggyDJR5AgmdnWZ6fXu9dEnTmMgWGmvSUIHJDf/fXylsrSS56z
         2St8XmK21icRuPgKBxrIU4szJBjBCGB5c2kkt1fgVipJAup4tKFUc6Nl1Zcq4OSnOT0M
         mxc6lkwznQuRfQKaZVYtDFuLEmZenxkwyhQ84FYsXUD31dvQD2Xxi/uqYuI4xl9yWNpp
         KPEfuB9BywBgRbyXgabHnWS3O3+OQpLy9f7rQ1SfpLH9SPsOV+zKBwdsKOoBlf1R96b7
         GR+A==
X-Forwarded-Encrypted: i=1; AKwUvBw4KefmcCtgp3RxFCzUOY0Q+Zl+gbXsjMQb94BvkkiMOvOE0OannQbMnpSqofDyC0M60E6miD8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaN9vkULn+WW3We2+L3i7t+61PWWkKYCUpPSBFgbQilpVhrKXh
	jg7yVqaEaoQMWjb5xJK3OT2/ZLu82FXp9vwBJwsPJcbZ8tsnxPkPtVC6ROJv/QlY/GE=
X-Gm-Gg: AYBFou07ee6+D3USlWAor/lJ7kzEp9NVf3YFv2EG1VxMllPVSAgqJxqaUZzq/TgSeb4
	RDkFq7nTYl/FPMJ19E3C1pXVHLVKGOG9QZAHRxfDxLe2EZaF0cV3Qcv2uEGsRb9/vxZyw1xwyTt
	QgrpKFpcjuqI09va6Iyhx4FT4FTs+/nyCPvtUDLG9o4EjtOgLIu0N4+s18VcqBqTmKlE5Sz0TnO
	nyFi2ny0JFzuH+8EcNt9tXw9p2hWVX54v1fuw+LOWgwMqjK3nH15kKnccT+0boqPTwJT5qRAdA2
	nHUhWei4DYaeTcyzCMceyCSbWGeBc3l0fGxGSkMr3dLx4eAouE15WO3zpL8K0Qt/vC41iESkOJ/
	M2UkGqAG+mrresEKj/TiI823rDlnUJDJEGAF4sGRnwMDAdHSqcP5Inkv3AsvWn99vZ9uwJcGnO9
	lrtCecF1Ej3nxQAmqOitW2X7cnRFrJ/GmYea0uDA9o3aR4m2xbhkBEihD6kScfKgg+C9odsPja5
	6QwS+OOkkTFs0pwidjda5WtrV6kuSfRSngi4F49VcjvkvHo74N+JBgXNeLtVtkNVfkywKlyMsNZ
	84sw3hftpZWYM543SOzSaWTFU5+2CSLrr7E1ZgkDW90jXVmOchksAjQzW9X0aXWrFyXtUw==
X-Received: by 2002:a17:90a:e7ca:b0:3a8:59d3:5317 with SMTP id 98e67ed59e1d1-3adeaf98405mr4816886a91.32.1792973266605;
        Sun, 25 Oct 2026 17:07:46 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb819729sm5942331a91.0.2026.10.25.17.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 17:07:46 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Mike Christie <michael.christie@oracle.com>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] IB/isert: set ISER_CONN_DOWN only after the connection has been released
Date: Mon, 26 Oct 2026 09:07:33 +0900
Message-ID: <20261026000733.4178856-1-yhlee@isslab.korea.ac.kr>
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

Removing an RDMA device (rdma link delete, module unload, hot-unplug -
a local administrative action) while an iSER connection is in
ISER_CONN_UP, i.e. the CM handshake has completed but iscsi has not
yet accepted it through isert_accept_np(), lets the
RDMA_CM_EVENT_DEVICE_REMOVAL handler free the isert_conn while
isert_connect_release() is still tearing it down.  A remote initiator
alone cannot trigger this; it can only supply the ISER_CONN_UP
connections that the local device removal then races against.

isert_cma_handler() waits for the connection to reach ISER_CONN_DOWN and
then frees it:

	wait_event_interruptible(isert_conn->rem_wait,
				 isert_conn->state == ISER_CONN_DOWN);
	kfree(isert_conn);

but isert_release_work() published ISER_CONN_DOWN before dropping the
last reference, so the condition becomes true at the start of the
teardown instead of at its end.  The wake-up at the end of
isert_connect_release() is in the right place; the condition was not.
The handler could return and free isert_conn while
isert_connect_release() was still dereferencing it.

That ordering requirement is not incidental.  Sagi Grimberg spelled it
out when this handling was introduced (2014-10-28,
<544FC5B2.70104@dev.mellanox.co.il>): "cma_remove_one sequence ...
requires the cmd is owner to finish cleanup before the end of the
callback because in the end of it, it will allow the device to remove."

Publish ISER_CONN_DOWN from isert_connect_release() instead, immediately
before the wake-up, so the condition and the signal refer to the same
point.  It has exactly one store and one load in the tree, so nothing
else is affected.  The store no longer takes isert_conn->mutex: the last
reference has been dropped, the only legitimate accessor left is the
rem_wait waiter, and wake_up_interruptible() provides the ordering.
isert_conn->state is already accessed without that mutex in
isert_accept_np() and in the wait condition itself.

One visible side effect: the connection now stays in
ISER_CONN_TERMINATING until isert_connect_release() runs, so a second CM
event in that window takes the ISER_CONN_TERMINATING case instead of
default:, and the "conn %p terminating in state %d" warning is no longer
logged.

Reproduced with soft-RoCE (rdma_rxe) under KASAN, preempt=full, an
initiator opening 32 CM-only connections (no login PDU) concurrently, so
that they queue up in ISER_CONN_UP, followed by "rdma link delete".  The
window is sub-microsecond, so the rate is low.  The splat below
reproduces on an unmodified kernel and does not with this patch applied
(36 of 60 runs unpatched, 0 of 60 patched).

  BUG: KASAN: slab-use-after-free in isert_connect_release+0x5cb/0x620
  Read of size 4 at addr ffff88810ca1d158 by task kworker/u16:1/43

  CPU: 0 UID: 0 PID: 43 Comm: kworker/u16:1 Not tainted 7.3.0-CTL2-13247-g330517c63aa9 #1 PREEMPT(full)
  Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  Workqueue: isert_release_wq isert_release_work
  Call Trace:
   <TASK>
   dump_stack_lvl+0x53/0x70
   print_report+0xd0/0x630
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   ? kfree+0x121/0x390
   ? isert_connect_release+0x5cb/0x620
   kasan_report+0xce/0x100
   ? isert_connect_release+0x5cb/0x620
   isert_connect_release+0x5cb/0x620
   process_one_work+0x697/0x1060
   ? __pfx___schedule+0x10/0x10
   ? __pfx_process_one_work+0x10/0x10
   ? _raw_spin_lock_irq+0x81/0xe0
   ? __pfx_isert_release_work+0x10/0x10
   ? assign_work+0x11d/0x370
   worker_thread+0x45b/0xd10
   ? __pfx_worker_thread+0x10/0x10
   kthread+0x2c8/0x3b0
   ? recalc_sigpending+0x15c/0x1e0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x36e/0x5a0
   ? __pfx_ret_from_fork+0x10/0x10
   ? __switch_to+0x572/0xdc0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  Allocated by task 24:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x8f/0xa0
   __kmalloc_cache_noprof+0x148/0x360
   isert_cma_handler+0x1e3/0x2840
   cma_cm_event_handler+0x3e/0x240
   cma_ib_req_handler+0x17d9/0x4480
   cm_process_work+0x41/0x330
   cm_work_handler+0x5727/0xc160
   process_one_work+0x697/0x1060
   worker_thread+0x45b/0xd10
   kthread+0x2c8/0x3b0
   ret_from_fork+0x36e/0x5a0
   ret_from_fork_asm+0x1a/0x30

  Freed by task 218:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   kasan_save_free_info+0x3b/0x60
   __kasan_slab_free+0x43/0x70
   kfree+0x121/0x390
   isert_cma_handler+0x10ff/0x2840
   cma_cm_event_handler+0x3e/0x240
   cma_process_remove+0xff/0x5a0
   cma_remove_one+0xcc/0x250
   remove_client_context+0xa4/0xf0
   disable_device+0x128/0x240
   __ib_unregister_device+0x226/0x3f0
   ib_unregister_device_and_put+0x50/0x70
   nldev_dellink+0x28e/0x3d0
   rdma_nl_rcv_msg+0x29c/0x4e0
   rdma_nl_rcv_skb.constprop.0.isra.0+0x21d/0x370
   netlink_unicast+0x68f/0x940
   netlink_sendmsg+0x810/0xf20
   __sys_sendto+0x337/0x390
   __x64_sys_sendto+0xdb/0x1b0
   do_syscall_64+0xdd/0x4a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Not fixed here: a connection still in ISER_CONN_INIT when the device is
removed is never cleaned up - isert_disconnected_handler() only warns -
so nothing makes the wait condition true and the removal blocks.  That
pre-existing case is why the wait is left interruptible rather than
converted to wait_event().

Fixes: 63b268d232b8 ("IB/isert: Properly release resources on DEVICE_REMOVAL")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index efa8d7b7844c9..cd0ca3cf131cb 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -506,10 +506,18 @@ isert_connect_release(struct isert_conn *isert_conn)
 
 	isert_device_put(device);
 
-	if (isert_conn->dev_removed)
+	if (isert_conn->dev_removed) {
+		/*
+		 * Publish ISER_CONN_DOWN only now.  The
+		 * RDMA_CM_EVENT_DEVICE_REMOVAL handler waits for it and then
+		 * frees isert_conn, so it must not become visible before the
+		 * teardown above has finished using the connection.
+		 */
+		isert_conn->state = ISER_CONN_DOWN;
 		wake_up_interruptible(&isert_conn->rem_wait);
-	else
+	} else {
 		kfree(isert_conn);
+	}
 }
 
 static void
@@ -2537,10 +2545,6 @@ static void isert_release_work(struct work_struct *work)
 
 	isert_info("Starting release conn %p\n", isert_conn);
 
-	mutex_lock(&isert_conn->mutex);
-	isert_conn->state = ISER_CONN_DOWN;
-	mutex_unlock(&isert_conn->mutex);
-
 	isert_info("Destroying conn %p\n", isert_conn);
 	isert_put_conn(isert_conn);
 }
