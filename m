Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676624;
	b=SbAzPkna6HjgbR1JBxNb/83dFLuQCsaO31L9vgoKjLCxxaEMiRCecpEtSkT3byi9xINX
	 J29kmgHRBmkpaenmNipmvXuqIeJOk2etSPVzjQo1IjH+OA+L1VVruIP+2QsmPXC4T1dz+
	 jpzeZe8ciwchSeAceJb5D1dg/7Js7A20P0SZmNfUwBbQGdMttOGLcnQVWUAbrmENEdx91
	 BreEvxhqzQa4UVxdeSVTfJ84CNDBCFfAVLk6GI+2dJxyHhXy7LKzyP+Nbp8ThmFi4UpZj
	 h252KAAiDfVALll8aPxfKR1P3Y16T2GqlBwgm8TpeILvK2nM/hit4ACbKSn14pN0yqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=woBsy6WyNMNqBnrLDg7YPE9Mm9vF3A1xMmsrZxgL9qc=;
	b=WsA3YjTIsQd5bq32HtORvSR2SWi46R2tAH7dqlp8QVs+AOcUB0cKEQvqI0h4RssZY79N
	 gGRbieaqUGKqZa7P6VonKf4+WHk4OCOYQGyQw8PTp4OaVjJMQ7hjeE7bLuRahTxMAJ/w2
	 qxwpnfYqev3iMgxO9j6/iDZsAJPsZe8761sfWAte5Rb+OhsWAnhBVpLETOlIrCPCKuGIY
	 +tHND1rjoVjogRzn0jQG5+Vuf6YeZ13rcFRn68sqvxFQfoiVBLdJRShfT2sHZ2xi6rgJ3
	 +tYMAYsAt6FYoPlPUNkxfztTf3VxB3xU6nB8YScVcLX8jJrOQaVT1NEiNR5Uxfasibw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bifgFw7d;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD84606A327
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 03:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BD84606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bifgFw7d
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-369f33df08eso7235509eec.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 19:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1793676623; x=1794281423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=woBsy6WyNMNqBnrLDg7YPE9Mm9vF3A1xMmsrZxgL9qc=;
        b=bifgFw7d94Db1I8LE8V6u+A/lNk2yczZuJPxzoMdJv+KlXmTuKzxyN5BL19q/nn4si
         znPGn1yR8nYemxGZOBNVDhzlNGeHQhVhdH6F7reuvkI/PsYOha3+JFk2c+rl3YPcf0PG
         OAP5umMnmwZEBENWTHVmF+wWzuW9jYxREXxy/KLKRiKkzKc1a14J8NbPTWLSTD4iRje7
         xFtVVqi3PneFlA/+rbnMLG1kexkuQP5bpig8BfEGplOo+Ac4ZADBt4dAj/M5d0hyDNI0
         RDgxdIfaW5UWHXPgBD0mxOYXN8PmPz5BxGjT4NY1eLB0rnkxav0rJWbsi6i7mfRShZj0
         aBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793676623; x=1794281423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=woBsy6WyNMNqBnrLDg7YPE9Mm9vF3A1xMmsrZxgL9qc=;
        b=DSI8dtA68d3pUMuTc54a2J1lAm9O2WDCXkOsDccVqZe8b/vkMCj7qhoVWtT6BVJCL8
         i78xNXo7ZpfGmDXMSJjMzwJ2MBWJcZAIZfpjgXJqypHj3w0pnmvZb/uw3l2GdYHaCgh/
         by27xPUwCQuOdDT6aXyeU8oh+zRnR2/zaDyIotJ/gqSIiobzok17mOJsTqzRIrjyDXjg
         pKB8iFrcOUwQhMhrQTte8OOyOl7zTCcDyT33zdcy0UPTazzJ3syWij9GE+QHrdDvlCuz
         nRS1Epo/l9JJgEl9iMV3BN+fnxkIKLr8K3oAymQA47qQ/FrRD1IPXmi4VnCFqIer5bfU
         Uj5A==
X-Forwarded-Encrypted: i=1; AKwUvBw65hNFOCRD+ddT/LYl+QMrVxRlNVd2rOFwJdXm8TFs4ZP6OGzwqf4VlcFX9uQiN+bJXUYbkWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mKSl2usw4dwkAyqsc5dwdLnlUQIxGiYJBEFEr4nyoaFe1axtl
	Za//gHTRt5fb9LCqbHxHgCCbWOvUflE9XivAEgBORLR3XcBeeBb0yXdtSEODl3lyp5A=
X-Gm-Gg: AYBFou0wp1W4qQosP2BuHY71xJTt71cvh1tTeD904Lj8P3SGV6eADUIC7AXKAaFiCkY
	3hzEgg7b5SZVxqtrppcHxoFed6xLakdA3Li0i8eRKJH73snO+FuHtQwiiBXthVaoEPvLHSwyFmw
	I/FWTGaPu/CCiS5LYFeqQA50xy7XFfN3xaXbO/tg7uOE5q74ysKSzAHgD23ci5myIsX4C4nRjpx
	WYRlyJkdICQ+1WtLJhMKFYMua0wDBOUDbkQ9lSFKbUeqyddv8QVJQW6lz2i55mwkflnX/lSkMu2
	DrYu7db8cobY69rsaFgdPNa8/UsAykbNsLjYCt6KYnYciEV4NlZIKaZGhQMKCdjvbriMcedmeiS
	cEZkQc6Yh6b7JfncOezBevZPeijzAn+iM534jsO5DoMgXJjLPHKglDx7nfhCdRWqK/RwnZo4pNq
	ROvByjxweitXaACC1BRIgjI2oGeGPdygKfuGEyrOrg8Nwco6eNmz8L9Y5QH/nh2oTGMLfjghdy9
	x6d3cs3BLV96THv4DOMHK2fVDO4eeiL/rtIywMZlSlVndgPOeOeWc2Old6Nl+gEssZEBREMLLaa
	z7DIcO4YUyU/BT2EzDD/w+FLw+1pAXrtyMTFtW6XqHD3KQj6yUJL1zU1XPE1T6nkdK+2oOVsA+D
	k1narrNn2b5HMeEJY7oxyqApUUXIJU84owKKpVQ==
X-Received: by 2002:a05:693c:4153:20b0:358:8f02:e0ca with SMTP id 5a478bee46e88-36a4236903fmr18750601eec.9.1793676623128;
        Mon, 02 Nov 2026 19:30:23 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:2da3:4696:4c5e:89c1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af91bsm41498577eec.8.2026.11.02.19.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 19:30:22 -0800 (PST)
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
Subject: [PATCH v4 1/3] IB/isert: do not publish connections being released on a second list
Date: Tue,  3 Nov 2026 12:29:22 +0900
Message-ID: <20261103032924.1073138-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103032924.1073138-1-yhlee@isslab.korea.ac.kr>
References: <20261103032924.1073138-1-yhlee@isslab.korea.ac.kr>
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

isert_free_np() moves the connections left on isert_np->pending and
isert_np->accepted onto a stack-local list and releases them from there,
so isert_conn->node is not empty once isert_np->mutex is dropped.  That
emptiness is how the CM handlers decide whether a connection is still
theirs, so isert_handle_unbound_conn() and isert_connect_error() unlink
it from a list they do not own and release it a second time, and
isert_connected_handler() moves it back onto isert_np->pending.

Take the connections off isert_np one at a time, so that the node is
empty once the mutex is dropped, and release them by dropping references
instead of calling isert_connect_release() directly.  The two CM handlers
test the node under isert_np->mutex and stand back when it is empty;
connect_error also returns zero there, so free_np's rdma_destroy_id()
destroys the cm_id rather than cma destroying it as well.  Whoever
empties the node owns the release, which still runs with no mutex held,
as commit 691b0480933f ("IB/isert: Fix dead lock in ib_isert") needs.

Reproduced with a test-only delay in isert_free_np()'s release loop: 36
reports in each of three unpatched runs, none in three patched runs.

  BUG: KASAN: slab-use-after-free in isert_free_np+0x6a4/0xab0
  Read of size 8 at addr ffff888109249040 by task rmdir/193

  CPU: 1 UID: 0 PID: 193 Comm: rmdir Not tainted 7.3.0-BASET-13248-g103b309e2033 #15 PREEMPT(full)
  Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x53/0x70
   print_report+0xd0/0x630
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   ? isert_free_np+0x6a4/0xab0
   kasan_report+0xce/0x100
   ? isert_free_np+0x6a4/0xab0
   isert_free_np+0x6a4/0xab0
   ? __pfx_isert_free_np+0x10/0x10
   iscsit_del_np+0x163/0x340
   iscsit_tpg_del_network_portal+0x3c3/0x530
   ? mutex_unlock+0x7b/0xd0
   lio_target_call_delnpfromtpg+0x40/0x60
   config_item_cleanup+0x115/0x190
   configfs_rmdir+0x7c7/0x9f0
   ? __pfx_configfs_rmdir+0x10/0x10
   vfs_rmdir+0x291/0x770
   ? lookup_one_qstr_excl+0x1a/0x1d0
   filename_rmdir+0x35d/0x4f0
   ? __pfx_filename_rmdir+0x10/0x10
   ? kasan_save_track+0x14/0x30
   ? __kasan_slab_alloc+0x6e/0x70
   ? strncpy_from_user+0x2b/0x1c0
   __x64_sys_rmdir+0x41/0x60
   do_syscall_64+0xdd/0x4a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  Allocated by task 10:
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

  Freed by task 43:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   kasan_save_free_info+0x3b/0x60
   __kasan_slab_free+0x43/0x70
   kfree+0x121/0x390
   process_one_work+0x697/0x1060
   worker_thread+0x45b/0xd10
   kthread+0x2c8/0x3b0
   ret_from_fork+0x36e/0x5a0
   ret_from_fork_asm+0x1a/0x30

  Last potentially related work creation:
   kasan_save_stack+0x33/0x60
   kasan_record_aux_stack+0x8c/0xa0
   __queue_work+0x7a1/0x15e0
   queue_work_on+0x5d/0x70
   isert_disconnected_handler.isra.0+0x20b/0x380
   isert_cma_handler+0xd71/0x2840
   cma_cm_event_handler+0x3e/0x240
   cma_ib_handler+0x190/0x750
   cm_process_work+0x41/0x330
   cm_work_handler+0x582b/0xc160
   process_one_work+0x697/0x1060
   worker_thread+0x45b/0xd10
   kthread+0x2c8/0x3b0
   ret_from_fork+0x36e/0x5a0
   ret_from_fork_asm+0x1a/0x30

  The buggy address belongs to the object at ffff888109248000
   which belongs to the cache kmalloc-8k of size 8192
  The buggy address is located 4160 bytes inside of
   freed 8192-byte region [ffff888109248000, ffff88810924a000)

Fixes: 691b0480933f ("IB/isert: Fix dead lock in ib_isert")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 84 ++++++++++++++++---------
 1 file changed, 55 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index efa8d7b7844c97..8255208e30c7d6 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -521,13 +521,18 @@ isert_connected_handler(struct rdma_cm_id *cma_id)
 	isert_info("conn %p\n", isert_conn);
 
 	mutex_lock(&isert_conn->mutex);
+	mutex_lock(&isert_np->mutex);
+	if (list_empty(&isert_conn->node)) {
+		mutex_unlock(&isert_np->mutex);
+		mutex_unlock(&isert_conn->mutex);
+		isert_info("conn %p is being released already\n", isert_conn);
+		return;
+	}
 	isert_conn->state = ISER_CONN_UP;
 	kref_get(&isert_conn->kref);
-	mutex_unlock(&isert_conn->mutex);
-
-	mutex_lock(&isert_np->mutex);
 	list_move_tail(&isert_conn->node, &isert_np->pending);
 	mutex_unlock(&isert_np->mutex);
+	mutex_unlock(&isert_conn->mutex);
 
 	isert_info("np %p: Allow accept_np to continue\n", isert_np);
 	up(&isert_np->sem);
@@ -658,12 +663,19 @@ isert_connect_error(struct rdma_cm_id *cma_id)
 {
 	struct isert_conn *isert_conn = cma_id->qp->qp_context;
 	struct isert_np *isert_np = cma_id->context;
-
-	ib_drain_qp(isert_conn->qp);
+	bool owned;
 
 	mutex_lock(&isert_np->mutex);
+	owned = !list_empty(&isert_conn->node);
 	list_del_init(&isert_conn->node);
 	mutex_unlock(&isert_np->mutex);
+
+	if (!owned) {
+		isert_info("conn %p is being released already\n", isert_conn);
+		return 0;
+	}
+
+	ib_drain_qp(isert_conn->qp);
 	isert_conn->cm_id = NULL;
 	isert_put_conn(isert_conn);
 
@@ -2479,12 +2491,33 @@ isert_accept_np(struct iscsi_np *np, struct iscsit_conn *conn)
 	return 0;
 }
 
+static struct isert_conn *
+isert_np_take_conn(struct isert_np *isert_np, bool *promoted)
+{
+	struct isert_conn *isert_conn;
+
+	lockdep_assert_held(&isert_np->mutex);
+
+	*promoted = true;
+	isert_conn = list_first_entry_or_null(&isert_np->pending,
+					      struct isert_conn, node);
+	if (!isert_conn) {
+		*promoted = false;
+		isert_conn = list_first_entry_or_null(&isert_np->accepted,
+						      struct isert_conn, node);
+	}
+	if (isert_conn)
+		list_del_init(&isert_conn->node);
+
+	return isert_conn;
+}
+
 static void
 isert_free_np(struct iscsi_np *np)
 {
 	struct isert_np *isert_np = np->np_context;
-	struct isert_conn *isert_conn, *n;
-	LIST_HEAD(drop_conn_list);
+	struct isert_conn *isert_conn;
+	bool promoted;
 
 	if (isert_np->cm_id)
 		rdma_destroy_id(isert_np->cm_id);
@@ -2497,32 +2530,25 @@ isert_free_np(struct iscsi_np *np)
 	 * up in accepted and pending lists.
 	 */
 	mutex_lock(&isert_np->mutex);
-	if (!list_empty(&isert_np->pending)) {
+	if (!list_empty(&isert_np->pending))
 		isert_info("Still have isert pending connections\n");
-		list_for_each_entry_safe(isert_conn, n,
-					 &isert_np->pending,
-					 node) {
-			isert_info("cleaning isert_conn %p state (%d)\n",
-				   isert_conn, isert_conn->state);
-			list_move_tail(&isert_conn->node, &drop_conn_list);
-		}
-	}
-
-	if (!list_empty(&isert_np->accepted)) {
+	if (!list_empty(&isert_np->accepted))
 		isert_info("Still have isert accepted connections\n");
-		list_for_each_entry_safe(isert_conn, n,
-					 &isert_np->accepted,
-					 node) {
-			isert_info("cleaning isert_conn %p state (%d)\n",
-				   isert_conn, isert_conn->state);
-			list_move_tail(&isert_conn->node, &drop_conn_list);
-		}
-	}
 	mutex_unlock(&isert_np->mutex);
 
-	list_for_each_entry_safe(isert_conn, n, &drop_conn_list, node) {
-		list_del_init(&isert_conn->node);
-		isert_connect_release(isert_conn);
+	for (;;) {
+		mutex_lock(&isert_np->mutex);
+		isert_conn = isert_np_take_conn(isert_np, &promoted);
+		mutex_unlock(&isert_np->mutex);
+
+		if (!isert_conn)
+			break;
+
+		isert_info("cleaning isert_conn %p state (%d)\n",
+			   isert_conn, isert_conn->state);
+		if (promoted)
+			isert_put_conn(isert_conn);
+		isert_put_conn(isert_conn);
 	}
 
 	np->np_context = NULL;
-- 
2.43.0

