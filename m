Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745515;
	b=KEIZIgOI6VNNh2EXYODNvUzmDtoXGxyH2nMTU7JrO1IzhqgjSu+w8Zqmj5wXC7QR0YzG
	 WQbVWbSMx+sSMkT7g0PX8cZWf+ALi/mmlNVXQKa4KWntn4Hl9A+fNL6kgUYRi80q1RQER
	 wSA/tumYnSICZKEkLKeKY3yDatpNQN0X59dN8n7YqAdo/PpHlR4oRTZ6EYrYp2ev3mlAx
	 ADWkbxZTjM6yRRcuMAObJ9iCjI8jZAe4jOlvN4S8CzWtnYBLX2Jbt5LoSqoK3ZRvy06g4
	 z4BK+9aLjDLHoZilKWzUodXjV+pB6dmxcD6lRwtIkVudIh2NbZA2H7GP1IKksyC5yow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A7XXBCX30Xg3KVcU/Qg7WxIOkAveBqd5SEDNjAUB0Uk=;
	b=I1cPuiZhNUDZX5uB5lpxBJnmwLne05gdQilJiHTP6tHJYW36Yjqd9t/vWIIWusoYDhNl
	 fDElWbqe5Cdg2HUuPnDlSohW/QedOgJDl3Z/YCVT1Ay+FUW9WPC4FQTrQMvsqL0LCpU5c
	 vgUymhjaHSOFErE63cayjqxDQ+k7itltnR1rRj3eTq23A6hjc8Pvf40uom0+4PmZmqCBD
	 iLREL3bpcSjNWpT0t1MBhVPRPMlse8gq+RRNpfsP8/2obiBrUph1LiiYaSmUvTgD8KEaB
	 p4P27tC8dzuOUPLTCri6/P1hIjhRYyzBPjZLQZVTrIhJrUvVXmCAuU1Ml+d+F0f7G8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fF3RbS9E;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26A606D815
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE26A606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fF3RbS9E
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so130375a91.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1793745514; x=1794350314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A7XXBCX30Xg3KVcU/Qg7WxIOkAveBqd5SEDNjAUB0Uk=;
        b=fF3RbS9Ep6qmrVOnUoPxn/Yxr5j7JbRTNIKbWPTNQEPGNpnjZ7xOC1wQZbceJtp02x
         RKdZVZNjJGTEvxRkBhygNmM0YQXjBQuqfPlBr+72WaEYjf/DDUrfr05ENUwH7vMDo3mk
         CEmzl7xnREWEvlG9hxLvkjT0UJUUa+/GmJMfAA5mTRw/NhsP2iFIuQuw14Ph9m5vvEAR
         gm75nY1450I0uIaTtglSh3AEh1/QjqRk+yIVx7R+eYasMlpnXFNsri6s0krIwkl/GobT
         lmxp/lakUZycBYzot0U5nb8qSz3NRAK0CceQcIsSBvSo9vLGTLPc1/hHEJ0b5mzreOlm
         FOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745514; x=1794350314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A7XXBCX30Xg3KVcU/Qg7WxIOkAveBqd5SEDNjAUB0Uk=;
        b=x0XiRhll9ygH9BYP5crZRLYzpm1NbJt20/xcB5Dt5GLjufFYt7hCF3uFXTwL82VGZe
         qUBHBIovybhSFwb2GsuQ6JmAE04e5ikVHoNbUqHNG3dKNX4zf+SC7l255g7NTPmOrhHJ
         /7iokSEVBQJF5wTUe2XIU5tKXrKt+PtQZS01k2LweFi+mvn30vexvvTi7eMvrjI2t4yF
         ZM7PPYfkor995SZ8DgoKJ8YSpI5u7FP7tCTtfBPQC/rCTbIlzNOKgP3NjDPt8MmV3+Ui
         Of5KqYFvUjLWRGUMXvjRvKBJ7Zbem6On+iyipwqNs1Bw4IB6kwWRPZsRCQmnEDnJLuKX
         LILA==
X-Forwarded-Encrypted: i=1; AKwUvBxl6z+2J3y1CHgiLJX1cIXH9wgDkKoNUxzQZg9y/yRiSPI6DCEr3a0TiV/REHy0Df55hbgfWz4=@vger.kernel.org
X-Gm-Message-State: APuU4Z80WTx2Ynu9wSeyoWXlMYKSuSL0Hhui39r9/5qpXZjkKN5t5N1y
	32oU8ppOgFdYA/EgYMys1z7mlRJhFbAfncTACJDaC0zcejxMZKpeCwUHMJWSnGJqSYs=
X-Gm-Gg: AYBFou1pC+12yr/jHAK7Kdu1O/BDQrOzQOmDgoi0i0ah54KtYFSiT0VXHDeKrOm6H0P
	k02v5P93UyrzV1V1+CT/hguFioSsnzeeeuia0P4W/JYuw/qQOELA9CE5hCHpG6qGhPVQyLtpD0h
	KSMa3B5v357OoZFobfdFlkXDVwFMiSNkDwNpPV0wIMvW4uCwzL2oblz7F+iAmJlCYKDED6XnD63
	mAIuFjG6ax2o6tx3PUERqEWhavKddwU0oTPSiLGhKI+C9c/yQqvKt45VQepSGh48G47sSIoWAWI
	wrN+F2Qay3lb4rablmbPB53KQbj/uU+dnXa6UvL0RvYWDKj7ro0RdWh4rXNeJth40HM3bPnUehh
	7D3VjesKlQsV6/2WdJnp4zklCjKZiaorH12jd+f14Qz85uBVJ5/AMAbmmdaWKje64DuACl/IHT0
	Fle+b5FcytPFmKwgVCMwaid4GX510IeCBRERwFbmEyKxWC4nk5uR5C3n1fDV9i9je3AnrwoHloz
	+k9/hOrSz/cQDJaY3rk8bdL74wKPKuioOZEdeO+5kE/ooVxWoR4W3w3VLouY3JFmG+pGHGmZED3
	o5OGsN8OQ50uNEREXYLjf3MP+IU287DoqDu3pXcHR/Y+sxRxTnGUkIamCiGAjszmBl56GWP/QGH
	5lcAC0TR3w7TmFz5/q9SZ93mV7+gx0yqp4njQ/DncXcqAcbX+MlSrJLSCjg==
X-Received: by 2002:a17:90a:c2d0:b0:3ad:eb34:4c6c with SMTP id 98e67ed59e1d1-3ae897c886amr12337321a91.13.1793745514170;
        Tue, 03 Nov 2026 14:38:34 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:744:cf40:a7b2:e78f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b096b6116bsm223711a91.4.2026.11.03.14.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:38:33 -0800 (PST)
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
Subject: [PATCH v6 6/6] IB/isert: only reinstate a connection that reached full feature phase
Date: Wed,  4 Nov 2026 07:38:02 +0900
Message-ID: <20261103223802.1697607-7-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103223802.1697607-1-yhlee@isslab.korea.ac.kr>
References: <20261103223802.1697607-1-yhlee@isslab.korea.ac.kr>
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
index 2057bb35af4cac..2564c9f5ea9a41 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -682,14 +682,14 @@ static void
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
@@ -701,7 +701,9 @@ isert_teardown_conn(struct isert_conn *isert_conn)
 		terminated = isert_conn_terminate(isert_conn);
 	} else if (bound) {
 		isert_conn_terminate(isert_conn);
-		iscsit_cause_connection_reinstatement(isert_conn->conn, 0);
+		if (full_feature)
+			iscsit_cause_connection_reinstatement(isert_conn->conn,
+							      0);
 	}
 	mutex_unlock(&isert_conn->mutex);
 
@@ -732,12 +734,13 @@ isert_connect_error(struct rdma_cm_id *cma_id)
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
@@ -749,7 +752,9 @@ isert_connect_error(struct rdma_cm_id *cma_id)
 		isert_conn->cm_id = NULL;
 	} else if (bound) {
 		isert_conn_terminate(isert_conn);
-		iscsit_cause_connection_reinstatement(isert_conn->conn, 0);
+		if (full_feature)
+			iscsit_cause_connection_reinstatement(isert_conn->conn,
+							      0);
 	}
 	mutex_unlock(&isert_conn->mutex);
 
-- 
2.43.0

