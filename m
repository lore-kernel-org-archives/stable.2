Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793765028;
	b=qy5vkPXMI4sv+sz3GTcnCU7NpRr2ZN8//iMAX5bQtunY/V5cvgx9KjjqVrs+oct/Znbg
	 Fn2MfwAFPzHD4kPCDna6PFkd/sMOedFdeC8uL0LhfTfpe1pU0wVvFm40Z9rEv2Dq+hTc4
	 09qPSEjPDK5CxRBhfbIhEH7cREq43o+egqmZ4GIdbEvVlmKUbzflLZsH1Tencc9i8Pk+s
	 Gapn4/IQKNulgzc44FNtKaOtcI+aVb2Okl1jxwG+2iBJBRk1RGyBMe9nfBuhvVpfCWAUY
	 U0I3yiPLdzKiI8R5O72o/KpsKonBxSgxkc1CnkaHGPFG1YgtsVTfmPH0u4zE10SqroA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793765028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7r7ntsGL0qhXgajGalx/+IeSzGK/9oHP89GVUm5LmrY=;
	b=c1Wp811Lp1TI4F+6qB4ChcDa3leV8+i7yT8BdhTSCzeoQqmiYYwgpJFrYi+FsoOt+e92
	 Aucm9kYep28Gnl82EjcZwl8cA33glFG/ibc8cEBR9bdPZsadK7kU7hgkvdw3YjuSqN8mD
	 65bIP+Qf9Zw5fHsvwne/ioT2iU30b3ACksfy34twFBn6BW7rk/zScmEAv/mZDrk0l7Vbs
	 iAaRC52N+kXGshKYqswg5VmCs9Es/w66oH8a6XqdsCS6IBnzadDiQg8zM/kEKeeM1Moua
	 SELJ+1HE7cC80dE6vL0TBbiko24P8UM9A8apBb63d5LS6m9Fq8HJI+5JC3s5ls4oWXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UfImakkD;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC81606D805
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 04:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBC81606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UfImakkD
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso875803a91.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 20:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1793765027; x=1794369827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7r7ntsGL0qhXgajGalx/+IeSzGK/9oHP89GVUm5LmrY=;
        b=UfImakkD7cyq3KfkTy0HyX2ms2YCEgVubjsRneTJQhxPKoKl03EO6Eko4RLjppItPs
         8WIR+/JA4JtuuXqdAqsar7hNxX3EG6DM2mfZ+HIUbZjqvw3Cw1jAcPYOOEOXCPntsgYS
         uOgtBKz65lmOyy4Ln2zDd3YIilC6MZOyavWzoDotpkq9qDpDvg/iOaxyJGDLrKggvOyH
         MoxB3K9PyHIEm/Up6bBm4+IDF1bURisM5YhC6qL51MDBuz1cQ0u8lTX53XUsNYPnIYi+
         2IDnOk2b5sFNBaoRl+ot9l0UEuqc+PYP/HgkwNZnkSoLSmZTE00ETtuxlwydKohUsc91
         RYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793765027; x=1794369827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7r7ntsGL0qhXgajGalx/+IeSzGK/9oHP89GVUm5LmrY=;
        b=DcsyoR4H7Kupm6wq6JxWlWwvkH/+3vtyuLOWdh5exutB5I1G5YOOamcv57SwK/L4sd
         VrKq6FxTGPvjq4sE169w0tds8i7gohy7d6TYAvP1OcGX27F3BO2uKCJqnWpNn4B/xfXS
         /VIUc+JeLovFL/ZL1y4XBGqeYk14YwruynkygKUF7m/l4kLFs8vSPq6/HdhCzGsuLpm9
         NNRzMulCiRSL1Hq5oosLK3s3ZfYxQTuYqP4V7S30DAp6LwCjnXwmPe/zuRSOYEIOqVvl
         n2MJJSNYtSsl0m0+T5yNPrzvMEIC7fm0jkRsO+poKqclC5h7UzQSJbH88ZEoVQlMKLRS
         +Q1A==
X-Forwarded-Encrypted: i=1; AKwUvByJJXN9u/9NH2sTaFRfzcL/C5tT54dCT9F5YTMBT1w11LUQgtmewriY1CU4tWnsuN5+NwQpqL4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nX+UsavCurQGJjjN1ft4gvqmCUMBK/q+Y5X9Q6mnU+0c0yjTF
	pMC5JasNv6T55fa3ttj9drvQqTb1To2apQCrKq3SqhwWq46qzdaa933aEEg3UV89K/0=
X-Gm-Gg: AYBFou0N7fFxhGJ10Ii3o1Ngnx9jKqWM35L7r2Dq3V36Nm1cNUbn164OLi2EgjY3eKd
	mZw7fC/pxpDDc7Q2zzWW5xFC9uHU6wc5Ah6M6/fSb0CLTVmAGtEWNf91WNG5pMmUyws2LstcwZe
	d1iAuAZEery/Wi4xasa8c8Tfh/FOR5d3QW0y+6caZbAKhRbXFuXnF0Vabg7KSvgK5Hghz82Z7Ye
	mxbXO1se4B65zIj7fHrjqMgRip2IEYjYoTrmMpT3qW2eOlxtf5NQiSXwa+cpIOnr1PQmD47nUl8
	h7czo1fHjZeK9PXTS2OyYjOws/AmJnoxXalrWiCFZSxuvkif/WjvD1D7iT5F5q9GvaTRzqVU4x/
	KSjP7W9B8sIeu9kCg7Zs9KSZiNueIPtPNWcap2on+YMDsliZ7Njy0gtGclk5D0jGD3yrIz0AZYN
	bljYzJma2iHr9RS+n4FXvcyrTLP57fylZcuTsIurfiLc+VM9F5el13Rx+MTfaNn8zB1tduH7o3v
	ydEFphfv9Eexc5v1gGZ6DLYNd3f/vDYbIa34p2XSUGftpDKGpc2/mp/B5D9k1OOegKfQLhJa2dt
	L/syyE5AwJIr/3tpsozIDgrKsalixcBOo5MFafpofX8Mx2mb7nCCQMtS3Zqqw90fXkI4piPcEh+
	WZ3TeovvQ4dwfdFp5P4rgfl0P3x8lCpvJ/oBn
X-Received: by 2002:a17:90b:2b47:b0:3ac:860e:1af9 with SMTP id 98e67ed59e1d1-3ae897cfe6dmr8834316a91.41.1793765027150;
        Tue, 03 Nov 2026 20:03:47 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:744:cf40:a7b2:e78f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b093d481a3sm1817053a91.1.2026.11.03.20.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 20:03:46 -0800 (PST)
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
Subject: [PATCH v8 6/6] IB/isert: only reinstate a connection that reached full feature phase
Date: Wed,  4 Nov 2026 13:03:17 +0900
Message-ID: <20261104040318.1844865-7-yhlee@isslab.korea.ac.kr>
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

isert_teardown_conn() and isert_connect_error() ask iscsi to reinstate the
connection whenever it is bound, ISER_CONN_BOUND included.  A connection
stays BOUND from isert_accept_np() until isert_get_rx_pdu(); during the
final login response the rx thread is already running but still waits for
its login completion.  iscsit_cause_connection_reinstatement() sends it
SIGINT, that wait fails, and iscsi_target_rx_thread() returns without the
connection exit path, so isert_remove_one() waits for ever.

Ask for reinstatement only from ISER_CONN_FULL_FEATURE, read under
isert_conn->mutex.  There the rx thread is inside isert_get_rx_pdu() and
returns to the exit path, so the signal still helps.  In BOUND terminating
is enough: if the login completes, isert_get_rx_pdu() sees
ISER_CONN_TERMINATING and returns; if it fails,
iscsi_target_login_sess_out() calls isert_wait_conn() and
isert_free_conn().

A test-only delay in that gap, with the device deleted inside it,
reproduced this on all three runs of patches 1 to 5: the rx thread was
signalled and the delete did not return within 240 seconds.  Three runs
with this patch signalled nothing and the delete returned in 8 seconds.

  INFO: task rdma:194 blocked for more than 10 seconds.
        Not tainted 7.4.0-rc1-V7L5-00006-g4f59be58f97a #141
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:rdma            state:D stack:26328 pid:194   tgid:194   ppid:1      task_flags:0x400100 flags:0x00080800
  Call Trace:
   <TASK>
   __schedule+0x180f/0x4bb0
   ? __pfx___schedule+0x10/0x10
   ? __pfx_complete_signal+0x10/0x10
   ? irq_work_queue+0x1c/0xb0
   schedule+0x70/0x1f0
   schedule_timeout+0x1cd/0x200
   ? __pfx_schedule_timeout+0x10/0x10
   ? vprintk_emit+0x200/0x2f0
   ? __pfx__raw_spin_lock_irq+0x10/0x10
   __wait_for_common+0x29e/0x420
   ? __pfx_schedule_timeout+0x10/0x10
   ? __pfx___wait_for_common+0x10/0x10
   ? mutex_lock+0x79/0xd0
   ? mutex_unlock+0x7b/0xd0
   ? __pfx_mutex_unlock+0x10/0x10
   isert_remove_one+0x554/0x740
   ? xas_load+0x1a/0x250
   ? __pfx_isert_remove_one+0x10/0x10
   ? xa_load+0xbf/0x120
   ? __pfx_xa_load+0x10/0x10
   ? __pfx_up_read+0x10/0x10
   remove_client_context+0xa4/0xf0
   disable_device+0x128/0x240
   ? __pfx_disable_device+0x10/0x10
   ? __pfx_mutex_lock+0x10/0x10
   __ib_unregister_device+0x226/0x3f0
   ? __pfx_mutex_unlock+0x10/0x10
   ib_unregister_device_and_put+0x50/0x70
   nldev_dellink+0x28e/0x3d0
   ? kernel_text_address+0xa7/0x130
   ? __pfx_nldev_dellink+0x10/0x10
   ? __pfx_down_read+0x10/0x10
   rdma_nl_rcv_msg+0x29c/0x4e0
   ? __pfx_rdma_nl_rcv_msg+0x10/0x10
   rdma_nl_rcv_skb.constprop.0.isra.0+0x21d/0x370
   ? __pfx_rdma_nl_rcv_skb.constprop.0.isra.0+0x10/0x10
   netlink_unicast+0x68f/0x940
   ? __pfx_selinux_socket_getpeersec_dgram+0x10/0x10
   ? __pfx_netlink_unicast+0x10/0x10
   netlink_sendmsg+0x810/0xf20
   ? __pfx_netlink_sendmsg+0x10/0x10
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   ? selinux_socket_sendmsg+0x8c/0x270
   ? __sys_sendto+0x337/0x390
   __sys_sendto+0x337/0x390
   ? __pfx___sys_sendto+0x10/0x10
   ? fdget+0x53/0x3b0
   __x64_sys_sendto+0xdb/0x1b0
   ? fpregs_assert_state_consistent+0x56/0xe0
   do_syscall_64+0xdd/0x4a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f1de13200d7
  RSP: 002b:00007fff7f1dd9d8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
  RAX: ffffffffffffffda RBX: 0000563429332390 RCX: 00007f1de13200d7
  RDX: 0000000000000018 RSI: 00005634293312a0 RDI: 0000000000000004
  RBP: 00007fff7f1dda10 R08: 00007f1de1417200 R09: 000000000000000c
  R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff7f1ddc00
  R13: 00007fff7f1dd9e4 R14: 00007fff7f1ddc20 R15: 00007fff7f1ddc00
   </TASK>

Fixes: 6d1fba0c2cc7 ("iser-target: Rework connection termination")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index a9bd2cc786cebb..8989485001fc94 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -681,14 +681,14 @@ static void
 isert_teardown_conn(struct isert_conn *isert_conn)
 {
 	struct isert_np *isert_np = isert_conn->np;
-	bool owned = false, bound = false;
+	bool owned = false, bound = false, full_feature = false;
 	bool promoted = false, terminated = false;
 
 	mutex_lock(&isert_conn->mutex);
 	mutex_lock(&isert_np->mutex);
 	if (list_empty(&isert_conn->node)) {
-		bound = isert_conn->state == ISER_CONN_BOUND ||
-			isert_conn->state == ISER_CONN_FULL_FEATURE;
+		full_feature = isert_conn->state == ISER_CONN_FULL_FEATURE;
+		bound = full_feature || isert_conn->state == ISER_CONN_BOUND;
 	} else {
 		owned = true;
 		promoted = isert_conn->promoted;
@@ -700,7 +700,9 @@ isert_teardown_conn(struct isert_conn *isert_conn)
 		terminated = isert_conn_terminate(isert_conn);
 	} else if (bound) {
 		isert_conn_terminate(isert_conn);
-		iscsit_cause_connection_reinstatement(isert_conn->conn, 0);
+		if (full_feature)
+			iscsit_cause_connection_reinstatement(isert_conn->conn,
+							      0);
 	}
 	mutex_unlock(&isert_conn->mutex);
 
@@ -731,12 +733,13 @@ isert_connect_error(struct rdma_cm_id *cma_id)
 	struct isert_conn *isert_conn = cma_id->qp->qp_context;
 	struct isert_np *isert_np = cma_id->context;
 	bool owned = false, bound = false, promoted = false;
+	bool full_feature = false;
 
 	mutex_lock(&isert_conn->mutex);
 	mutex_lock(&isert_np->mutex);
 	if (list_empty(&isert_conn->node)) {
-		bound = isert_conn->state == ISER_CONN_BOUND ||
-			isert_conn->state == ISER_CONN_FULL_FEATURE;
+		full_feature = isert_conn->state == ISER_CONN_FULL_FEATURE;
+		bound = full_feature || isert_conn->state == ISER_CONN_BOUND;
 	} else {
 		owned = true;
 		promoted = isert_conn->promoted;
@@ -746,7 +749,9 @@ isert_connect_error(struct rdma_cm_id *cma_id)
 
 	if (bound) {
 		isert_conn_terminate(isert_conn);
-		iscsit_cause_connection_reinstatement(isert_conn->conn, 0);
+		if (full_feature)
+			iscsit_cause_connection_reinstatement(isert_conn->conn,
+							      0);
 	}
 	mutex_unlock(&isert_conn->mutex);
 
-- 
2.43.0

