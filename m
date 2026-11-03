Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676629;
	b=5ZWhg/xPC4LC+u7KuP3oKnXaCVUMHWIi3sFIHLcpvw7oFXT5m0b5hFf++BWezVmXGlSv
	 PGC6IBWBm2I2rAbpxHTzU0ZOTYb2yk3MH7hY3rLvZxjLtytyQT2axnuiYjIi1ycnXaE0G
	 9cw7S7dy8ESwWz3nC1m5P7izCdhMz7MjH9t++3Mu+fXtu0JZc5qIp9fwWIRZbG/FzgKHW
	 HvjauO3NSIx9u8Vc+Ra9qpr9lXqZ15g/G6ePm+/ns4Zp57MCRju72km/MZ4ZSl/bmLQLl
	 bTqS0x5wDEF8G0zIu96Y5LLyDR9artyFmTOwtwd7Swuuy15T9ipDYFP/sr39m1nhA/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HG7Is05GGnx6Xp1q3Juz1SqD92hs/Rh27uihZYQ1aPY=;
	b=BQGp1kmjxlbEi3D6gqT3L0mi6TuX8fSv2ykBBtUrJ1sHWlPwkgstyR+le2Ig5ARrGtgl
	 7mRaD7wyWqs1LpyK4D35NaOwYg2zlb6q2zT+VBRvnrVNs95nBrifNFwZZMz3wQcYPpm5A
	 ON64xcIYCctk9N8XOMlzTvHywID9jKgI8vn7NJl/HYQyS+C42/sUxba8qhzRDBsc8KLzc
	 cHAjB39fhwlJAM9mn6HGJhPWYlsldrswOEFvH/m8ygm6ZXfsSMhosF7InqVuup89780S1
	 j4lcBn7Gy4kL1oqkoCvbEQ+COlW0grbSuKwFQ9CRN56YDmF2mQa0N5hpZaGpUzu3vDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DUd4qy6D;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EAA606A335
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 03:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03EAA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DUd4qy6D
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so7026515eec.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 19:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1793676628; x=1794281428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HG7Is05GGnx6Xp1q3Juz1SqD92hs/Rh27uihZYQ1aPY=;
        b=DUd4qy6DZN+6NgN4TKPkfhh3T+8GtYq4L5nVU1Lk+2iIZojVWAmkwsr4ii177FedAX
         tjY3SSZAq3HzYrKPm7UXQ6Hj7M7I7xlKxowSi7QImGHI/KCnKj4nAWrAJMGQpPCtZeIl
         U37geBGl1ps8GSi/6rn6xeexWcBwo7RE0HGkoNuifppnd4o8Jmfc6m2k4gsJn7+Dj//N
         4joxmyqh5XdfaI7psody1Z0VukugXIp/B0IoTkXt9FSVfH40AyaYy4jRwazuwBiJK4Jw
         97PsmMr2rbMoTFhB4mV6u7xekj1FBKbL0v3ZQ1TcK+X3Q37EEnwwq4lgcBy5BUoAIB+1
         T1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793676628; x=1794281428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HG7Is05GGnx6Xp1q3Juz1SqD92hs/Rh27uihZYQ1aPY=;
        b=0nYJyRCSh0cHZi/IdiJ/Ne03fsOMVgjwfn8N5rQXdH4s+Vq27jLlz3Pjw5YD1/krvx
         PE9guIznTF694dodH/yHQWfuJCuGJMbA4jVupWkafTnuOe+bSONN5QnwfwdZCYf0xQWh
         jDV2ZyQfGa5Eq63G+6y7aOGGo0avuCJdC06OB1obJxs0LrRI/t7qGBcuCP/M74FOGQ4N
         Rn/9NN/2/uhazdkGH6wDC5N6NAgJUTFoNG999Y+4/ke8iV6ksIKq8YOICiA0P2VUgnLs
         aJIMYjLOK0yrn7xDEvUwagiWzCGy0upeja8aj8Jn43gfEZrdK6P4t/8tE9yZB4mhjH5G
         5MtA==
X-Forwarded-Encrypted: i=1; AKwUvByLsfHa/ikseBigbnJkm/292XK1GvHJ05SfOv8YBo9vFm+kXA0Vk2Yqcn/uTJnJgKXMKzMMogY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ettjK1WmdfOEyUmFSO6UnyIsYV1YSj45ypYPU/ETyUhO/eryp
	KYsr/fHgO293kTe9wnSDxoCrOMGfw5ddAJszv2nc0Xop3bGdKVdHCv8NYMqx+Zm4F5g=
X-Gm-Gg: AYBFou0mqE0IvkRIHsUv8BY83EXmZtm+WVVsBm4ooNQPfutBrxoeHwRc5p7Uyc/xAWe
	DiRBIXxM77b+FY5bNAwYqfDPVw6j6rm5W8s/RkQlzJuECxgHuU0QXAL0BKEA3My3Z3f9ve7JlQ4
	drdit+tI7UNkmY53pyWNr6apoFWcUfz2+HTHCTwmhSK8kjNzRV4XbTecRccAlgRjAvK+Z7/AssX
	Zrb9qTuBP1T5fKnTSAhBydHv8CVC3G2PyR6j0PbXbwIHPEgp3Nv1lMsKoKEpUeWTErtMx6d5Yt3
	zK4a95SV4k+W+yd7zgcUzFk0JSzPBMZ+hmpb6GZzRD6hD7buAbRs78j+kcjFT4+MpFfXypYiV1B
	My10mM+Qo7+JD57HaA5QKEgyfQitquFw2cHE+NMdwh2GzG+e1q8LtNTjhGDrqC+DhUSJtUu0Tz5
	MaLB6sDoHlFsB3euXmxnVYqwIj2Q0Q6JPC2j4zsO7km7+IsWurjKieb5n3bajcjiceJOUjoCEjK
	7DAiqwkj4bdQaXhRpD+RsQ26IKocpK2JM5HiObemkj8+1pW9BvGBEVFOgzDhS0kxoPFnCOvJLPH
	6/zjG3hipIRHjWhCOEgJidTududnGdityHsrowKycnERQoj6+V8wW5dptK/Tt7abk6pZyn5PMTJ
	OlV0KdDQd8FskH6gnHOZWtPL6Is4KZeai8Fu1p5I=
X-Received: by 2002:a05:7300:c00f:20b0:36a:4ea9:19ad with SMTP id 5a478bee46e88-36a4ea91fd1mr15426433eec.9.1793676627433;
        Mon, 02 Nov 2026 19:30:27 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:2da3:4696:4c5e:89c1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af91bsm41498577eec.8.2026.11.02.19.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 19:30:26 -0800 (PST)
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
Subject: [PATCH v4 2/3] IB/isert: drain the QP without holding isert_conn->mutex
Date: Tue,  3 Nov 2026 12:29:23 +0900
Message-ID: <20261103032924.1073138-3-yhlee@isslab.korea.ac.kr>
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

isert_disconnected_handler() drains the QP with isert_conn->mutex held.
The drain waits for the flush completions of the send and receive
queues, and those are reaped by ib_cq_poll_work() on ib-comp-wq, where
isert_login_recv_done() takes isert_conn->mutex before it looks at the
connection state.  If a login receive completes while the handler holds
the mutex, the completion handler blocks on the mutex and the drain
blocks on the completion that handler would have reaped.

Return from isert_conn_terminate() whether this caller moved the
connection to ISER_CONN_TERMINATING, and do the drain and the unbound
connection release after dropping isert_conn->mutex.  Only one caller
sees true for a given connection, so the drain still runs once.

Two test-only delay knobs open the window, one in
isert_login_recv_done() and one before the drain; it does not open on
its own in this setup.  With them, three runs of 7.4-rc1 plus patch 1 of
this series produced ten hung task warnings each, six, six and seven of
them waiting in ib_drain_qp() and four, four and three in
isert_login_recv_done().  Three runs with this patch produced none.

  INFO: task kworker/0:1:10 blocked for more than 10 seconds.
        Not tainted 7.4.0-rc1-B13-00002-g093ce9c311ad #47
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:kworker/0:1     state:D stack:27392 pid:10    tgid:10    ppid:2      task_flags:0x4208060 flags:0x00080000
  Workqueue: ib_cm cm_work_handler
  Call Trace:
   <TASK>
   __schedule+0x180f/0x4bb0
   ? _raw_spin_lock_irq+0x1/0xe0
   ? __pfx___schedule+0x10/0x10
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
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
   isert_cma_handler+0xd74/0x27f0
   ? ip6_finish_output2+0xc09/0x1bd0
   ? __pfx_isert_cma_handler+0x10/0x10
   ? __pfx_ip6_finish_output2+0x10/0x10
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
  INFO: task kworker/0:0H:11 blocked for more than 10 seconds.
        Not tainted 7.4.0-rc1-B13-00002-g093ce9c311ad #47
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:kworker/0:0H    state:D stack:29592 pid:11    tgid:11    ppid:2      task_flags:0x4208060 flags:0x00080000
  Workqueue: ib-comp-wq ib_cq_poll_work
  Call Trace:
   <TASK>
   __schedule+0x180f/0x4bb0
   ? _raw_spin_lock_irq+0x1/0xe0
   ? __pfx___schedule+0x10/0x10
   ? _raw_spin_lock+0x80/0xe0
   schedule+0x70/0x1f0
   schedule_preempt_disabled+0x11/0x20
   __mutex_lock.constprop.0+0xc2f/0x1910
   ? __pfx___mutex_lock.constprop.0+0x10/0x10
   ? _printk+0xba/0xf0
   mutex_lock+0xc2/0xd0
   ? __pfx_mutex_lock+0x10/0x10
   ? _raw_spin_lock_irqsave+0x86/0xe0
   isert_login_recv_done+0x2b9/0x590
   __ib_process_cq+0xe1/0x390
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   ib_cq_poll_work+0x46/0x150
   process_one_work+0x697/0x1060
   ? __pfx_process_one_work+0x10/0x10
   ? _raw_spin_lock_irq+0x81/0xe0
   ? __pfx_ib_cq_poll_work+0x10/0x10
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
  INFO: task kworker/0:0H:11 is blocked on a mutex likely owned by task kworker/3:0:34.

Fixes: 6d1fba0c2cc7 ("iser-target: Rework connection termination")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 26 +++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 8255208e30c7d6..c6f417bb206901 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -578,21 +578,17 @@ isert_handle_unbound_conn(struct isert_conn *isert_conn)
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
+ * Returns true if this caller moved the connection to ISER_CONN_TERMINATING.
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
@@ -601,6 +597,8 @@ isert_conn_terminate(struct isert_conn *isert_conn)
 	if (err)
 		isert_warn("Failed rdma_disconnect isert_conn %p\n",
 			   isert_conn);
+
+	return true;
 }
 
 static int
@@ -635,15 +633,14 @@ isert_disconnected_handler(struct rdma_cm_id *cma_id,
 			   enum rdma_cm_event_type event)
 {
 	struct isert_conn *isert_conn = cma_id->qp->qp_context;
+	bool terminated = false;
 
 	mutex_lock(&isert_conn->mutex);
 	switch (isert_conn->state) {
 	case ISER_CONN_TERMINATING:
 		break;
 	case ISER_CONN_UP:
-		isert_conn_terminate(isert_conn);
-		ib_drain_qp(isert_conn->qp);
-		isert_handle_unbound_conn(isert_conn);
+		terminated = isert_conn_terminate(isert_conn);
 		break;
 	case ISER_CONN_BOUND:
 	case ISER_CONN_FULL_FEATURE: /* FALLTHRU */
@@ -655,6 +652,11 @@ isert_disconnected_handler(struct rdma_cm_id *cma_id,
 	}
 	mutex_unlock(&isert_conn->mutex);
 
+	if (terminated) {
+		ib_drain_qp(isert_conn->qp);
+		isert_handle_unbound_conn(isert_conn);
+	}
+
 	return 0;
 }
 
-- 
2.43.0

