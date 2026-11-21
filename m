Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795304903;
	b=1wM7dX7ds+lDSs3Gl8JBHwYxcCfjmmLy6hq90F24PYHRD6RP3xqU/dyi4Vk4OlAEmSCR
	 BxMye7UJG3s4IX8wE7SOr6prJjBW8Zh0t1v7mn1zSJdV+lk97dTV+nJEOLh2wqB9SXp5o
	 C3ZY+Fw5nxNgC8300U8DbVd2rCrl4WpX5t/6tMBIVehxLiv0IZeuWhF38xqkctehCZ+wa
	 pGBk5UHGHiGgQCKdQI0Mf8l3CmUO+VSk3rWWL1P0R70rS81B73LkQ8HbIbUVZ86zi2fiR
	 UtGDT6wNsD7QxN933E/4w5MYA34AwwAqF2iNopmhTeHkoPSLTcqjLBxuakWj82zEjaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795304903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:Message-ID:Subject:
	 From:To:Cc:Content-Type;
	bh=RDuG/oqCdue4gGnPB/YmguD4LRbIPVedWxys3SblwxU=;
	b=r1cRh0r0nMMA+V1qkDsDcFXMm1TfuREt/XbNq7tWNxY6pb86Rjg48bfPjJpnN11y1kkr
	 HihWSM9M57udZgrNY3YvXpON0Uxz6bH8kAw4makVAM9B3TmFEGQ8uFCSBZXqiQilLBWY4
	 BYzZarws86B3GnAwoZA7fCNZf9sddChTXwBZwLatqEJN9ixgZgcRjG34YtwVH/N8d7bsU
	 T1u4BSdXNG4ZJRdEo+/EL+MohXGAhNIUrb5T81h8ib16B1pRMfNRF77kBg5AbkeuWRujV
	 9lpWAyStZW3cc8OpEnzCF4Rejzye8HdIBZ3lS2FWtsK+z3yi5Nh2suY8Ahib/8IGcgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--bcochrane.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AaKtuOBf;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E2606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 23:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D42E2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bcochrane.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AaKtuOBf
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f04580de55so11534125ad.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 15:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795304902; x=1795909702; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:date:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RDuG/oqCdue4gGnPB/YmguD4LRbIPVedWxys3SblwxU=;
        b=AaKtuOBfhsiB4ty7mir7taOY4iyI4ezUWWycMl8H3hRfB/STYON1UYG30tfhRpYVgo
         HdQ2an9O0dfe/MzSB064WQuXcn2SF8/UjIXG+s2OQkS10Ey2XI5XmjqvPBYoldWONkKA
         tbqDuCLchi6QJZJx+57znS2Z5Sg2otZ/hK44G27REyrU336+yA41DsGv4clzqaT53FBE
         /5QX11bQZiQDaQIdcrTmifCr0w4PgjxEmOqGSoei6DJ0+2HLgHAPHMhhnBegXt6nx2QT
         MbesRM7rCw1qxiOGrVYzICiep9MbaJ+6Ws58Jmqb+pYS7hI9nqVSSsmhTngO6S2Kbwcm
         x92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795304902; x=1795909702;
        h=content-type:cc:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDuG/oqCdue4gGnPB/YmguD4LRbIPVedWxys3SblwxU=;
        b=zr9xQlWcMwsCUBK6pqCIAO73nKkaLPd9V7KPi7QD+4qNT5XQaEyxEbT9LHANjlWARE
         U4JOfyGhNOiu8KueDE2yMpPRV9r2Ven725JqAN9yDA+hRQfC8Pq93EFI2Vf3j20urGZi
         4gPLbVPJT1/WmKx+lJa245RXD9UhiTrHRAqquxzEO/OhTI8tNtJ1EQOfC0kc9ri7N1YR
         UAEMoJFOClly4B0XgU3KgcyvRNAzNWNomNprALKOA04qvQxiVm53+nwbfu4EUpwwAVxx
         m2ZSYcvs2mqRNOlxz4zlpINMqLDiUkLwvCk1bDskKzgKZeVdFSPFn0n54C+F6XhzZnFA
         dNUA==
X-Gm-Message-State: APuU4Z9M3ys38d/zyOaaPNPf2pUW+RqislfznwStsMZ91Nxj9xFgGgWa
	nuguX6cNC5f6DHTaf8F6S6v1IvGsHvBwTKRumASf3M1kTwNe8PeTbeLdESRAvebo5nS9EKx9YLX
	SMiNfl2KQQVPXsEZd7BvlC/PxTJeud+Jb5bPAWotnEfU+jQxhTnXtlFgRf2twqtorMpP+VDv9kV
	Pzo5ibvR9UbI6BxcC0Td2Ztd6igQdnqF1Uzw5BLNIgvTV9eDteft4O
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: from plnr4.prod.google.com ([2002:a17:903:1904:b0:2ef:db3e:d66])
 (user=bcochrane job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:298c:b0:2ef:d952:4a65 with SMTP id d9443c01a7336-2f03f1babeamr71244315ad.43.1795304901940;
 Sat, 21 Nov 2026 15:48:21 -0800 (PST)
Date: Sat, 21 Nov 2026 15:48:04 -0800
Message-ID: <18ea344bdf5a5efb.3137322e31392e3133312e3730.20002c.0000sendgmr@google.com>
Subject: [PATCH 6.18] bnxt_en: Take RTNL before netif_close() when aborting FW reset
From: Bryan Cochrane <bcochrane@google.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bryan Cochrane <bcochrane@google.com>
Content-Type: text/plain; charset="UTF-8"

commit bf83b257423bb557b970df3d7ece32fbd85f3bd4 upstream.

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

In bnxt_fw_reset(), only a PF can reach the bnxt_get_registered_vfs()
error path that calls netif_close(), so take RTNL up front via
bnxt_rtnl_lock_sp() when BNXT_PF(bp) is true and keep bnxt_lock_sp() on
VFs. That avoids dropping the instance lock mid-reset (which would
expose a transient BNXT_STATE_IN_FW_RESET and let a concurrent devlink
health recover set BNXT_STATE_IN_SP_TASK), avoids racing with
bnxt_sriov_configure() updating active_vfs outside RTNL, and keeps VFs
from contending on RTNL during recovery while PFs already run on the
single-threaded bnxt_pf_wq.

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
Link: https://patch.msgid.link/20261110044235.204386-1-bcochrane@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ bcochrane: backport to 6.18.y: 6.18 lacks bnxt_lock_sp() and
  bnxt_unlock_sp(), so keep the existing inline BNXT_STATE_IN_SP_TASK +
  netdev_lock()/netdev_unlock() on the VF branch of bnxt_fw_reset()
  while using the existing bnxt_rtnl_lock_sp() / bnxt_rtnl_unlock_sp()
  on PFs. ]
Signed-off-by: Bryan Cochrane <bcochrane@google.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8ef1d9d2f..49e9470e1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14538,8 +14538,12 @@ static int bnxt_get_registered_vfs(struct bnxt *bp)
 void bnxt_fw_reset(struct bnxt *bp)
 {
 	bnxt_ulp_stop(bp);
-	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
-	netdev_lock(bp->dev);
+	if (BNXT_PF(bp)) {
+		bnxt_rtnl_lock_sp(bp);
+	} else {
+		clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+		netdev_lock(bp->dev);
+	}
 	if (test_bit(BNXT_STATE_OPEN, &bp->state) &&
 	    !test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
 		struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
@@ -14585,8 +14589,12 @@ void bnxt_fw_reset(struct bnxt *bp)
 		bnxt_queue_fw_reset_work(bp, tmo);
 	}
 fw_reset_exit:
-	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
-	netdev_unlock(bp->dev);
+	if (BNXT_PF(bp)) {
+		bnxt_rtnl_unlock_sp(bp);
+	} else {
+		set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+		netdev_unlock(bp->dev);
+	}
 }
 
 static void bnxt_chk_missed_irq(struct bnxt *bp)
@@ -15239,9 +15247,8 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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
@@ -15374,9 +15381,11 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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
-- 
2.56.1.750.gf70dc682cf-goog

