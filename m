Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793765016;
	b=j/U5V32otg2bOP+hq+0lUvyuzjXvb+ifdDg7kQ023ziySwF6/Cb5NktNp3WUswQ+vHdo
	 SIxEbxMGv5RDEiI1WWTR28KqkV95a3sTC0ix3gxeIv4frpo4Kkkxd+nV8gCK+eA+656sn
	 Lvlx/qtEfQ6VlFB/QmAUi64qgolo+a+MTvIVVwPAIF/goH9l9w4PGR8QxUjt9SEvNqZxk
	 i+lJINTVdnW64rq74mQ8bCrG8cOxo4yNscMx70ObFIF4f4qvqScgOz+F6cm1yIxA+Q7Ma
	 jWZ8LTl9dBcHSMqImLNj+xVtIpy+FSLyhJnGOmjoru7nfOOYKKIsnTv6dpxrTwBVJvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793765016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oVa6CCAH519bjAZCKZQVejZVAzQohLPWeK+tg1l7Elc=;
	b=YMXnegVJbKWZzThnW32jUe/5k6Xui6PMdMqUPOhKeFN/QequgX+IDCBIywZ4ZWuzvAXB
	 yge6mTWb17MHBPVZ9gaJ42eAsMztBOnE6UNneIDAS4f1HR7dPJnyRUszQBcYd+ZjcBH7B
	 09MrFdBogfmhbl6cFBgKTO+IiLtZqZLc/T206fab7x5T855YCnn4nVc0/0UNUfBOVxU6m
	 TYAz3LW21o7wpR7LzVkIC1FD2iVxNHiIdxLVzAGtZZfCuozI3J2zVR6q25/36K+hROEFq
	 oES8xA0nrhv/n7SjDY1r56QMZ7xRb9dJGbWr1AGXUHqC6/uBPIJ3ATfRLzEgwf9TL9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MERz27Iz;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE5A606A333
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 04:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE5A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MERz27Iz
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso229579a91.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 20:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1793765014; x=1794369814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oVa6CCAH519bjAZCKZQVejZVAzQohLPWeK+tg1l7Elc=;
        b=MERz27IzX+cyAEO5f7M7AI+Agfhb6pOP5uavhmGmnNMxNVUG41wDXBUgbHw4bLXNmu
         VqD858h/zhWh1znZwytYyJuv+4JSXJJqsiqts9sh0oa+/M5lzl0hSBajBTaEsexdwwLq
         FKnBxVeJD9ta8PwUFMvFQljYmL5ZefFdINfdpnxEKGwzaJzNpl1yn8nZy1kLwpdVGxHW
         T0RoWaGi9HEGFZ5qb3jc2ONUSYlEb0FRNAXi9lCx7s7EyOekag4iyQfWWILum2s6tyG6
         id6MyY/2RA0L8O9eOzHjzs0ritGgH0rHuFQ8KwfIfHW7LZH11qLVTxiH7r/LawO/bnrP
         Zy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793765014; x=1794369814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oVa6CCAH519bjAZCKZQVejZVAzQohLPWeK+tg1l7Elc=;
        b=gYauTy6kEMjDG4p3yDi8xAIpORxy5ylLp6E+j2hS9aPv/fFFePHD4L52Ps0MjN96HM
         XzALLYz2g4KitNJCqMRPnJQ6YcIz2OF80NlshHgsV9PaL6LTB4t5istVALzQvcuBvxuz
         rulMyt1lLTjaasOR12nRkNEkFbEtvx7Ov5umeGkGYkFKkZXiZ5RgOPOOrmEfO8QmhT2F
         8EfqWDTRR78jt5u/bjP+9xeFVYnva4SHzpHtaYSTUYl6L5XPavePjIjqk5OJsanTUWy5
         leo402skNfusfxAcoQm8VmqUHi3EVEZ7f3yCDlNghnjNQNOzNg/ovF1KxrJRjUV+jb2E
         7Mwg==
X-Forwarded-Encrypted: i=1; AKwUvBwsrEIBziRTpZHvefdrEx/poMCyUE4Dt9ttko3AUioMoTtomXw0AcfwO93t6fCgvvXLtCPEtXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/N9uSd8Kxb18RKVtkndbwnzNI19Fb0eZAW3qtR6YJHFvKrQdvV
	eNYuVxORYhfLwMVgAfb7W9D+PukS+VLa7tS+ZSZv+SQIVbgdt+ErveGHgBaQZLp5ZdQ=
X-Gm-Gg: AYBFou2dcVFtIq/P0f+jLuxN1RT2BY5QaqEWJHT+hdO8cLAt5NGQCefJyjUBh4pRSK7
	ehh4f/EPraZY8kRkqJBoeIxTMfaVL9mbfia3BjsajU065r/uOu0EC/0/dYpzum9tnMaf0gnKPJL
	Dqk6lIDJ+0I5tN6AE9hyEwhDhj8e79E0wa4wo6ws9dlIANjZxjR/xVZbFeMaP3nZ5MPP17HUr0o
	PXjDASJoiv/MDH7bUzV+SrwXP8YtRdTGAg3CcTYlL3tN4E+vkNOUYUoqp22RmlL2Ny95H5lWLTD
	bf6+cnAie3CsAEh9MAHSY4yR7LYhZlkKBiNtykYJm1pO3+ncKDJ9zT0Udi+tNA+2RBk2cjDwV+j
	N5HzjoqZkJBlPr2bX8iM4Ua0jKa0TzrZ59xSeOV3EQulwr3aYgciM6UOXnWgZMnipx/VGkzXYwp
	aqLs+si7rGVsgGKEu9jkljz4Nijm9wVLeuMeQISXRtA2reVvK+ffHIXL//EzBTjNgnDuwRKlQ2T
	1rWYPPgBsX7ULrdwQGLtJ/+PIIgBdguNFG8On4sOMvH17K1H+Q4l4r30ggZIn+35CX9y0aTPGXV
	EAMb41BrIkwOS6MkHV7zFAjmc/k3iqH6JMmjgKdftkRq6fHKU+SE27Od2KrHJJ40IWfsqFJhg4D
	q8Nn+fhyUvT6sBoK+/z2xMOMldRB4OY+6zD9Q
X-Received: by 2002:a17:90a:c2d0:b0:3ae:533e:7e3c with SMTP id 98e67ed59e1d1-3ae8981bf57mr11461672a91.35.1793765013727;
        Tue, 03 Nov 2026 20:03:33 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:744:cf40:a7b2:e78f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b093d481a3sm1817053a91.1.2026.11.03.20.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 20:03:33 -0800 (PST)
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
Subject: [PATCH v8 2/6] IB/isert: drain the QP without holding isert_conn->mutex
Date: Wed,  4 Nov 2026 13:03:13 +0900
Message-ID: <20261104040318.1844865-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104040318.1844865-1-yhlee@isslab.korea.ac.kr>
References: <20261104040318.1844865-1-yhlee@isslab.korea.ac.kr>
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

isert_disconnected_handler() drains the QP with isert_conn->mutex held.
The drain waits for the flush completions of the send and receive queues,
and those are reaped by ib_cq_poll_work() on ib-comp-wq, where
isert_login_recv_done() takes isert_conn->mutex before it looks at the
connection state.  If a login receive completes while the handler holds
the mutex, the completion handler blocks on the mutex and the drain blocks
on the completion that handler would have reaped.

Return from isert_conn_terminate() whether this caller moved the
connection to ISER_CONN_TERMINATING, and drain after dropping
isert_conn->mutex.  Only the owner of isert_conn->node drains, so two
callers cannot drain the same QP; the send and receive queues reserve room
for one drain each, and a second concurrent drain hits the WARN_ONCE in
__ib_drain_sq() and returns without draining.

Two test-only delays open the window, one in isert_login_recv_done() and
one before the drain.  Three runs of 7.4-rc1 plus patch 1 of this series
printed ten hung task warnings each, eight, five and five of them waiting
in ib_drain_qp().  Three runs with this patch printed none, and
PROVE_LOCKING reported no splat in two runs a side.

  INFO: task kworker/0:1:10 blocked for more than 10 seconds.
        Not tainted 7.4.0-rc1-NS1-00002-g7b7ecb49489e #121
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:kworker/0:1     state:D stack:26248 pid:10    tgid:10    ppid:2      task_flags:0x4208060 flags:0x00080000
  Workqueue: ib_cm cm_work_handler
  Call Trace:
   <TASK>
   __schedule+0x180f/0x4bb0
   ? _raw_spin_lock_irq+0x1/0xe0
   ? __pfx___schedule+0x10/0x10
   schedule+0x70/0x1f0
   schedule_timeout+0x1cd/0x200
   ? __pfx_schedule_timeout+0x10/0x10
   ? rxe_qp_from_attr+0x1497/0x18c0
   ? __pfx__raw_spin_lock_irq+0x10/0x10
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   ? _raw_spin_lock_irqsave+0x86/0xe0
   __wait_for_common+0x29e/0x420
   ? __pfx_schedule_timeout+0x10/0x10
   ? __pfx___wait_for_common+0x10/0x10
   __ib_drain_sq+0x251/0x340
   ? __pfx___ib_drain_sq+0x10/0x10
   ? __pfx_ib_drain_qp_done+0x10/0x10
   ? irq_work_queue+0x1c/0xb0
   ? __pfx__printk+0x10/0x10
   ? __pfx_process_timeout+0x10/0x10
   ib_drain_sq+0x146/0x1a0
   ib_drain_qp+0xd/0x50
   isert_disconnected_handler.isra.0+0xc4/0x3f0
   isert_cma_handler+0xd74/0x27d0
   ? kasan_save_stack+0x42/0x60
   ? kasan_save_stack+0x33/0x60
   ? kasan_save_track+0x14/0x30
   ? kasan_save_free_info+0x3b/0x60
   ? __kasan_slab_free+0x43/0x70
   ? kfree+0x121/0x390
   ? cm_process_work+0x8b/0x330
   ? __pfx_isert_cma_handler+0x10/0x10
   ? kthread+0x2c8/0x3b0
   ? ret_from_fork+0x36e/0x5a0
   ? ret_from_fork_asm+0x1a/0x30
   ? _raw_spin_lock_irqsave+0x86/0xe0
   cma_cm_event_handler+0x3e/0x240
   cma_ib_handler+0x190/0x750
   ? __pfx_cma_ib_handler+0x10/0x10
   cm_process_work+0x41/0x330
   cm_work_handler+0x582b/0xc160
   ? _raw_spin_lock_irqsave+0x86/0xe0
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   ? hrtimer_start_range_ns+0xa6/0x2c0
   ? __pfx_cm_work_handler+0x10/0x10
   ? finish_task_switch.isra.0+0x1d9/0xa70
   process_one_work+0x697/0x1060
   ? __pfx___schedule+0x10/0x10
   ? __pfx_process_one_work+0x10/0x10
   ? _raw_spin_lock_irq+0x81/0xe0
   ? __pfx_cm_work_handler+0x10/0x10
   ? assign_work+0x11d/0x370
   worker_thread+0x45b/0xd10
   ? __pfx_worker_thread+0x10/0x10
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

Fixes: 6d1fba0c2cc7 ("iser-target: Rework connection termination")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 75 ++++++++++++-------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index ef2edaa3218fee..61b214012a70b0 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -556,43 +556,21 @@ isert_put_conn(struct isert_conn *isert_conn)
 	kref_put(&isert_conn->kref, isert_release_kref);
 }
 
-static void
-isert_handle_unbound_conn(struct isert_conn *isert_conn)
-{
-	struct isert_np *isert_np = isert_conn->cm_id->context;
-
-	mutex_lock(&isert_np->mutex);
-	if (!list_empty(&isert_conn->node)) {
-		/*
-		 * This means iscsi doesn't know this connection
-		 * so schedule a cleanup ourselves
-		 */
-		list_del_init(&isert_conn->node);
-		isert_put_conn(isert_conn);
-		queue_work(isert_release_wq, &isert_conn->release_work);
-	}
-	mutex_unlock(&isert_np->mutex);
-}
-
 /**
  * isert_conn_terminate() - Initiate connection termination
  * @isert_conn: isert connection struct
  *
- * Notes:
- * In case the connection state is BOUND, move state
- * to TEMINATING and start teardown sequence (rdma_disconnect).
- * In case the connection state is UP, complete flush as well.
- *
- * This routine must be called with mutex held. Thus it is
- * safe to call multiple times.
+ * Return: true if this caller moved the connection to ISER_CONN_TERMINATING.
  */
-static void
+static bool
 isert_conn_terminate(struct isert_conn *isert_conn)
 {
 	int err;
 
+	lockdep_assert_held(&isert_conn->mutex);
+
 	if (isert_conn->state >= ISER_CONN_TERMINATING)
-		return;
+		return false;
 
 	isert_info("Terminating conn %p state %d\n",
 		   isert_conn, isert_conn->state);
@@ -601,6 +579,8 @@ isert_conn_terminate(struct isert_conn *isert_conn)
 	if (err)
 		isert_warn("Failed rdma_disconnect isert_conn %p\n",
 			   isert_conn);
+
+	return true;
 }
 
 static int
@@ -635,26 +615,44 @@ isert_disconnected_handler(struct rdma_cm_id *cma_id,
 			   enum rdma_cm_event_type event)
 {
 	struct isert_conn *isert_conn = cma_id->qp->qp_context;
+	struct isert_np *isert_np = cma_id->context;
+	bool owned = false, bound = false, terminated = false;
 
 	mutex_lock(&isert_conn->mutex);
 	switch (isert_conn->state) {
-	case ISER_CONN_TERMINATING:
-		break;
 	case ISER_CONN_UP:
-		isert_conn_terminate(isert_conn);
-		ib_drain_qp(isert_conn->qp);
-		isert_handle_unbound_conn(isert_conn);
+		mutex_lock(&isert_np->mutex);
+		if (list_empty(&isert_conn->node)) {
+			bound = isert_conn->state == ISER_CONN_BOUND ||
+				isert_conn->state == ISER_CONN_FULL_FEATURE;
+		} else {
+			owned = true;
+			list_del_init(&isert_conn->node);
+		}
+		mutex_unlock(&isert_np->mutex);
 		break;
 	case ISER_CONN_BOUND:
 	case ISER_CONN_FULL_FEATURE: /* FALLTHRU */
-		iscsit_cause_connection_reinstatement(isert_conn->conn, 0);
+		bound = true;
 		break;
 	default:
-		isert_warn("conn %p terminating in state %d\n",
-			   isert_conn, isert_conn->state);
+		break;
 	}
+
+	if (owned)
+		terminated = isert_conn_terminate(isert_conn);
+	else if (bound)
+		iscsit_cause_connection_reinstatement(isert_conn->conn, 0);
 	mutex_unlock(&isert_conn->mutex);
 
+	if (!owned)
+		return 0;
+
+	if (terminated)
+		ib_drain_qp(isert_conn->qp);
+	isert_put_conn(isert_conn);
+	queue_work(isert_release_wq, &isert_conn->release_work);
+
 	return 0;
 }
 
@@ -665,8 +663,6 @@ isert_connect_error(struct rdma_cm_id *cma_id)
 	struct isert_np *isert_np = cma_id->context;
 	bool owned;
 
-	ib_drain_qp(isert_conn->qp);
-
 	mutex_lock(&isert_np->mutex);
 	owned = !list_empty(&isert_conn->node);
 	list_del_init(&isert_conn->node);
@@ -677,6 +673,7 @@ isert_connect_error(struct rdma_cm_id *cma_id)
 		return 0;
 	}
 
+	ib_drain_qp(isert_conn->qp);
 	isert_conn->cm_id = NULL;
 	isert_put_conn(isert_conn);
 
@@ -2479,11 +2476,10 @@ isert_accept_np(struct iscsi_np *np, struct iscsit_conn *conn)
 	isert_conn = list_first_entry(&isert_np->pending,
 			struct isert_conn, node);
 	list_del_init(&isert_conn->node);
-	mutex_unlock(&isert_np->mutex);
-
 	conn->context = isert_conn;
 	isert_conn->conn = conn;
 	isert_conn->state = ISER_CONN_BOUND;
+	mutex_unlock(&isert_np->mutex);
 
 	isert_set_conn_info(np, conn, isert_conn);
 
@@ -2547,6 +2543,7 @@ isert_free_np(struct iscsi_np *np)
 
 		isert_info("cleaning isert_conn %p state (%d)\n",
 			   isert_conn, isert_conn->state);
+		ib_drain_qp(isert_conn->qp);
 		if (promoted)
 			isert_put_conn(isert_conn);
 		isert_put_conn(isert_conn);
-- 
2.43.0

