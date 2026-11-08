Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794176992;
	b=hjBGK+MH4YH6Nl0NgRrlCpS5vz6n/yXiB9Fo9akX0TTXJhO5ieW2HJawyqswzD4y9HTY
	 lRvJAPhRC7BgcXNktjW9QGdokUEZZjsLqoM1k9gFHfarlOGqaWT7YCY54oSLgaSkNriPl
	 3qfEj0fhE54sLyuGkRc76bnf6h65x9tu+mTxwGSjWMyogXa8sKfRXz9Hob2EfM7ObcM8w
	 V4LEqMqW/wCXRucDiCZWoP3CC+dyXYkNX2UQjsyAGcj1n3UVxURhNIxVJ2Zp5VLhAikP9
	 b81pvu7H4YOWyli4HCVw7dQ6exyq7JSRgQdn6SJ4hV8BVpNIMUtDcRGW4hmE1rDQQUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794176992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=s8BbK2IqWwoRejKoPp8MQhqTOQlps2N83qEGGaCE+Ow=;
	b=HbS8A1c18gqkNE/ZSw57qwXDKrKHt6BsqZ2NBAGUGtDW3iGLIDcExkrBzlxHkln93W6/
	 F0SVeC5aMrGm7L2qbnwXoTQpMi5+FjKv2phEz/ZLcbB3Ep6lVgqJpHSoVf572UVYDRaiY
	 qJfF7uRekzT88OERw/zDkobX7rmMS5icqEVEXUYH3d65VW1zMKmzPwzb83wM1iPpOz69o
	 RlBvKujMTZZ0sBJei6M+KVaF6e0pxROZq5SQ47tRscCfDpeYsFlkFvj4GJ4faZR1ZN+VH
	 OMLUdv+1he8ZNv16SKEt9V0pTA5fELhrnnm60JYmvmaIDXNB+WkVviLiBkmpoDnRWnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--bcochrane.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k3eQvj2x;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99429606A32A
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99429606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bcochrane.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k3eQvj2x
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36d69ab3c2bso457574eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794176991; x=1794781791; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s8BbK2IqWwoRejKoPp8MQhqTOQlps2N83qEGGaCE+Ow=;
        b=k3eQvj2x+t5skfzGZz5GyhPzMfETyB1pjsBDgldrz41P6bij1l4h+dyR0LpzW+Z1Gz
         FHC4SqrM+DvuiHdbW8MG8Sqyxm/LTR8Pp1Zz8rhjVlOtO+QobGW5HCIDeNdZvk4Ae7nx
         rMSGfR0ErQpX4PczfQ9B+sX1XMhFzOb79qL/F7kzfsoCkIeUGhygrJgOJnXCmCAVTf/9
         P5pTdXauu4I7TTS5jKim94sDvriL2kh1fom4M91Il+PJ0MTBzyDt4aU4wguLoBG8QDvJ
         F7yfZ18kxoDDH53jAKAuLZlg9MefNyQodaK88XLig4O+ustzI9at/Ejat7DKRxDxQR04
         wZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794176991; x=1794781791;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s8BbK2IqWwoRejKoPp8MQhqTOQlps2N83qEGGaCE+Ow=;
        b=gAEPm5ujqEBH0ZGdz0YU0B5giyiE9cPMBAW2t9MCX0NFjsGlYYI40kv7m9Oq356d8w
         hQazMS5SOnR2LryeUhPZiXKod6cl1Sk4OuiSXnGqBVzdKPUjKQl8vVuFGQPBr3WWzcjh
         6Qa3ajaPgWaqPZyDIZ3eXd1PV/nRmTrtX8dV3jOEvVp3WoQCY2VbmIa1yCBA51h9FwNy
         QZXfByHU7w7Ea+X6hFAdVo39bzY1heD07Z8JrM/FPV9zpz+m/ygLnS3VyYmfdcecT04m
         Pq+NJYouqs/0cWQyVzO74TW1/5IKNaBsEHIT8ML3rvbnjyAuZrSmqVgeXM6vlezVfZNq
         0JaQ==
X-Forwarded-Encrypted: i=1; AL+hErHjYqJOp/MifbIRoLHodMZUhDQvxf5/hyqIZnFkJksFwWL7deRQhnatuZbBRPvhelCBIiQoN04=@vger.kernel.org
X-Gm-Message-State: APuU4Z+p9tN5L67m6FAc3v94NGksaPKBh1N8kcyyZdWRRbwyu9SFH/I/
	0QDovlLztG9nmLwGzgfqbsDP52270j8uu1CBvp5wcWw3OYWsrYvl+Hjk5lHXJEuBEEE3msMFErp
	9pPNsHS1QKAuqh5Jb+A==
X-Received: from dybtt4.prod.google.com ([2002:a05:7300:f404:b0:36d:c15d:8d80])
 (user=bcochrane job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:6199:10b0:36f:29bf:4326 with SMTP id 5a478bee46e88-37250fdd781mr5143821eec.0.1794176990371;
 Sun, 08 Nov 2026 14:29:50 -0800 (PST)
Date: Sun,  8 Nov 2026 14:29:42 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261108222942.1233295-1-bcochrane@google.com>
Subject: [PATCH net v4] bnxt_en: Take RTNL before netif_close() when aborting
 FW reset
From: Bryan Cochrane <bcochrane@google.com>
To: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <joe@dama.to>, linux-kernel@vger.kernel.org, 
	Bryan Cochrane <bcochrane@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

netif_close() must be called with RTNL held in addition to the netdev
instance lock: __dev_close_many() asserts it, and the NETDEV_GOING_DOWN
and NETDEV_DOWN notifier chains it runs rely on it for serialization.

Commit 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
replaced rtnl_lock() with netdev_lock() in bnxt_fw_reset_task() and
bnxt_fw_reset(). That is sufficient for the paths that only tear the
NIC down internally with __bnxt_close_nic(), but the abort paths close
the netdev via bnxt_fw_reset_abort() -> netif_close(), and the error
path in bnxt_fw_reset() calls netif_close() directly. Those now run
without RTNL and trigger a WARN_ONCE() cascade when a firmware reset is
aborted:

  RTNL: assertion failed at net/core/dev.c (1740)
  WARNING: net/core/dev.c:1740 at __dev_close_many+0x1be/0x1f0
  Workqueue: bnxt_pf_wq bnxt_fw_reset_task [bnxt_en]
  Call Trace:
   netif_close_many+0xb5/0x190
   netif_close+0xa2/0xd0
   bnxt_fw_reset_task.cold+0x8d/0x213 [bnxt_en]
   process_one_work+0x19d/0x3a0
   worker_thread+0x1af/0x320
   kthread+0xe3/0x120

followed by the same assertion from call_netdevice_notifiers_info(),
fib_rules_event(), inetdev_event(), rtnl_fill_ifinfo(),
devlink_compat_phys_port_name_get() and ip_mc_down().

This was observed on a machine in real use with a BCM57504 (4 PFs,
FW 236.1.153.0) running v7.1.6: the firmware crashed, announced a
"Fatal firmware reset event" and then failed to come back within the
advertised max wait, so bnxt_fw_reset_task() aborted the reset on all
ports:

  bnxt_en 0000:c1:00.1 eno16905np1: Firmware reset aborted
  bnxt_en 0000:c1:00.1 eno16905np1: fw_health_status 0x448100

Take RTNL (before the netdev instance lock, matching the OPENING state
which already uses rtnl_trylock()) in the fw_reset_abort path of
bnxt_fw_reset_task() and route the POLL_VF abort through that same
path.

In bnxt_fw_reset(), only the bnxt_get_registered_vfs() error path needs
RTNL: drop the instance lock, reacquire RTNL and the instance lock via
bnxt_rtnl_lock_sp(), then clear BNXT_STATE_IN_FW_RESET and close the
device synchronously. The normal reset flow, which may run on many VFs
at the same time, keeps running without RTNL.

Because bnxt_fw_reset() and bnxt_fw_exception() can also be entered
from devlink process context via bnxt_fw_recover(), guard the
BNXT_STATE_IN_SP_TASK bit manipulation in bnxt_[rtnl_]lock_sp() and
bnxt_[rtnl_]unlock_sp() with current_work() == &bp->sp_task. Otherwise
a concurrent devlink health recover backing off during the unlock
window would set BNXT_STATE_IN_SP_TASK with no sp_task running to clear
it, causing the subsequent __bnxt_close_nic() busy-wait to hang.

The bug was found by inspecting the kernel log of the affected machine
and the driver source; the fix was prepared with the help of an AI
coding assistant (Gemini based) and reviewed by the submitter. It is
build tested (allmodconfig with W=1, plus the same change on top of
v7.1.6 built as a module for the affected BCM57504 host). The aborted
reset path itself only runs when the firmware fails to return from a
reset, which could not be reproduced on demand.

Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan Cochrane <bcochrane@google.com>
---
v4:
 - Return to the synchronous close in bnxt_fw_reset() from v2, using
   netdev_unlock() + bnxt_rtnl_lock_sp() as suggested by Michael Chan,
   and guard BNXT_STATE_IN_SP_TASK in bnxt_[rtnl_]lock_sp() and
   bnxt_[rtnl_]unlock_sp() with current_work() == &bp->sp_task. Deferring
   the close to bnxt_fw_reset_task() in v3 still hung when entered via
   bnxt_fw_recover(), raced with bnxt_hwrm_if_change() clearing
   fw_reset_state, and marked the reporter SEVERITY_FATAL (reported by
   the netdev Sashiko review).
 - Omitted Michael's Reviewed-by and Stanislav's Acked-by from v2 due to
   the new bnxt_in_sp_task() check.
v3: https://lore.kernel.org/netdev/20261104045534.79783-1-bcochrane@google.com/
 - Do not drop and retake the locks in bnxt_fw_reset(). Route the
   bnxt_get_registered_vfs() failure through the bnxt_fw_reset_task()
   abort path instead; this also restarts the ULP after that abort. The
   v2 unlock/relock window let a concurrent devlink health recover set
   BNXT_STATE_IN_SP_TASK via bnxt_unlock_sp() and hang the close
   (reported by the netdev Sashiko review).
v2: https://lore.kernel.org/netdev/20261103042210.2984373-1-bcochrane@google.com/
 - Keep bnxt_lock_sp() in bnxt_fw_reset() and take RTNL only on the
   bnxt_get_registered_vfs() error path, to avoid RTNL contention when
   many VFs recover at the same time (Michael Chan).
 - Dropped Stanislav's Acked-by because of the change above.
v1: https://lore.kernel.org/netdev/20261029032832.1511180-1-bcochrane@google.com/
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 31 ++++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 33c4cacc8ffe..7a2b96f56464 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14575,35 +14575,44 @@ static void bnxt_timer(struct timer_list *t)
 	mod_timer(&bp->timer, jiffies + bp->current_interval);
 }
 
+static bool bnxt_in_sp_task(struct bnxt *bp)
+{
+	return current_work() == &bp->sp_task;
+}
+
 static void bnxt_lock_sp(struct bnxt *bp)
 {
-	/* We are called from bnxt_sp_task which has BNXT_STATE_IN_SP_TASK
-	 * set.  If the device is being closed, bnxt_close() may be holding
+	/* If we are called from bnxt_sp_task, BNXT_STATE_IN_SP_TASK is set.
+	 * If the device is being closed, bnxt_close() may be holding
 	 * netdev instance lock and waiting for BNXT_STATE_IN_SP_TASK to clear.
 	 * So we must clear BNXT_STATE_IN_SP_TASK before holding netdev
 	 * instance lock.
 	 */
-	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	if (bnxt_in_sp_task(bp))
+		clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 	netdev_lock(bp->dev);
 }
 
 static void bnxt_unlock_sp(struct bnxt *bp)
 {
-	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	if (bnxt_in_sp_task(bp))
+		set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 	netdev_unlock(bp->dev);
 }
 
 /* Same as bnxt_lock_sp() with additional rtnl_lock */
 static void bnxt_rtnl_lock_sp(struct bnxt *bp)
 {
-	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	if (bnxt_in_sp_task(bp))
+		clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 	rtnl_lock();
 	netdev_lock(bp->dev);
 }
 
 static void bnxt_rtnl_unlock_sp(struct bnxt *bp)
 {
-	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	if (bnxt_in_sp_task(bp))
+		set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 	netdev_unlock(bp->dev);
 	rtnl_unlock();
 }
@@ -14860,9 +14869,12 @@ void bnxt_fw_reset(struct bnxt *bp)
 		if (n < 0) {
 			netdev_err(bp->dev, "Firmware reset aborted, rc = %d\n",
 				   n);
+			netdev_unlock(bp->dev);
+			bnxt_rtnl_lock_sp(bp);
 			clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 			netif_close(bp->dev);
-			goto fw_reset_exit;
+			bnxt_rtnl_unlock_sp(bp);
+			return;
 		} else if (n > 0) {
 			u16 vf_tmo_dsecs = n * 10;
 
@@ -15547,9 +15559,8 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		bp->fw_reset_timestamp = jiffies;
 		netdev_lock(bp->dev);
 		if (test_bit(BNXT_STATE_ABORT_ERR, &bp->state)) {
-			bnxt_fw_reset_abort(bp, rc);
 			netdev_unlock(bp->dev);
-			goto ulp_start;
+			goto fw_reset_abort;
 		}
 		bnxt_fw_reset_close(bp);
 		if (bp->fw_cap & BNXT_FW_CAP_ERR_RECOVER_RELOAD) {
@@ -15682,9 +15693,11 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		netdev_err(bp->dev, "fw_health_status 0x%x\n", sts);
 	}
 fw_reset_abort:
+	rtnl_lock();
 	netdev_lock(bp->dev);
 	bnxt_fw_reset_abort(bp, rc);
 	netdev_unlock(bp->dev);
+	rtnl_unlock();
 ulp_start:
 	if (!rc)
 		bnxt_ulp_start(bp);

base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
-- 
2.56.0.542.g3ef89b7020-goog

