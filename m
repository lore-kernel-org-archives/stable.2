Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793244520;
	b=oChqI78kpH44RRNKfkJcPvOVvRz+FIqW94BxDGSATkY6c5Kdj+28XKmm8TpzEJ8Jv4hK
	 QSmEIg1bm11by9UpjQjKWnJStHP0C/6iF+3KzI1a77t4je+RubTvQ18Fw1Khomg2rXZgb
	 4eyE0p+0lx1mN2LMg/oNL2kjwOgjF+33DLkZ2BbcEvRGgnXZHlFDaUWNzywzHPL2gprFK
	 EA0vzX+GzryYzgICQeshYmoiHNg+2nrXZ4xXF6MLqC6nny0Byo9+c4adHeCH9l8ZpN8Vb
	 OHMtqhZ+Zz7sSoJR5QAF6NjUYFEXgUIQfCAcRZ9RFzFn1LRJdMnn8H9ONgx9p9dGhsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793244520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=i4njzMDCwe0EBzmqxjvfeIpG9o+lOwEDSvxV46zSd2o=;
	b=p+L+pfV+i/gqhpPE/hqcu/cv0r2fbbl0ilqBWVp15QjPQuufpfzyTanAFSW0kfxC83EK
	 NgXb+0a/P4A0xmS2pF1WzOPbt6ugSVaxzivSnHNDdKD+RfwsdqeGBYNbMVtVlRpzKAAPN
	 moJKiocI/YazN9HqACGahZXfDUzmbmMhapD3ZQRUkvjvwj9jFAfhW78W2uBcjxOu7Rv78
	 TBiycRcbJP+7cbx4Vil6WZ/49lwCtMGIyCzrDonLYqxem8rbbVtckkfNiGgS6foQSeG2V
	 GdiKlM3lVifYCTNFqigQLE5KtTan0xUo5Hj6oAc5x6OvhcJljoxcBla0TQnPkN+8bLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--bcochrane.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OWZNVzVW;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635B606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E635B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bcochrane.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OWZNVzVW
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso3039906eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793244519; x=1793849319; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i4njzMDCwe0EBzmqxjvfeIpG9o+lOwEDSvxV46zSd2o=;
        b=OWZNVzVWG0OTdPxuQdpZXaCECPLqYjHA2Nw+gJ9UvDWnGTU3KVkiads99jx/4MVvOz
         FjcOOBgefpAaiGW6RDkhG1UEO06jy8FdkRSr7imRET9H0T8YMN6OxUmAce37PqHLlI49
         ZSCa5I75cJZXoeS9lNl6uRv0kvMzOL/WU9AZ1x6We1Y32aufTO/Mk0e0HgOC7BevMWQ7
         vtwzR/ScxF2jaqxSybXa3dA/bqRgxj4neGx99Q+2aVEM7fUll4XtYk5a6HN7o85lYAN8
         517p+oY8P5g3cpEzjllg7u0PNgIUV/4bKzH8iDEfuTsZ+O1L/wfBUwz/m2PD8unJLJtW
         dICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793244519; x=1793849319;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i4njzMDCwe0EBzmqxjvfeIpG9o+lOwEDSvxV46zSd2o=;
        b=uOU4ZSqu+0mZ6kG3Rrt+6cpQirk2puoz2/6VjtGERl4Fbg0FmrhGRu9+ifNSV/3bhN
         m3pyf/z/BOjUBXtX7P64/gh/d5sjZ0kMkrtlKjXqm/r5+W8inXeLpkiW6wq10tiL6ZYZ
         g+hfH09rcXLyBV5t5TdVSzW2opbvvxjf50UrJF6sdicltE2/ne1k5y2AiukFlE/gPSYE
         KsJ3yCPDjaTMaERkYAt6ObFyjicz+IItwIhZGpst/gtVTou7TfBoGIbrPVLGqmGhX6mI
         7wgdFGG5MRaU7nbBEhXJo+WXhpPuurvK+CD6OmYOQcbhttg1mkPGWDb03/jKl0UUv7WN
         pLfQ==
X-Forwarded-Encrypted: i=1; AKwUvBzd9JoAI2fWVfewtHD5p/UFmlMLRh9yE+vvvQ5O4XYsFuURDDwdXX1LWRRnlkxIN+kKYlKEHzg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4V2hWeqWRLz12zAgmi/ws2eugNMt06vnO6LMp/OYVuBwZUj+U
	+RJ10Ks1fzKluGopo0h403ZPW//exrtb+bB2xsXR89b9zvgT1/RQrG4tc87rdXc8XNrQnTOWcCm
	ty5jyeWob5s51P/jAZg==
X-Received: from dlbvv9.prod.google.com ([2002:a05:7022:5f09:b0:195:23bc:a608])
 (user=bcochrane job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:4396:b0:15c:20b8:796e with SMTP id a92af1059eb24-1a6ce208ad1mr7404810c88.22.1793244518347;
 Wed, 28 Oct 2026 20:28:38 -0700 (PDT)
Date: Wed, 28 Oct 2026 20:28:32 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261029032832.1511180-1-bcochrane@google.com>
Subject: [PATCH net] bnxt_en: Take RTNL before netif_close() when aborting FW reset
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
path. In bnxt_fw_reset() go back to bnxt_rtnl_lock_sp() so that its
netif_close() error path is covered as well; bnxt_reset() and
bnxt_rx_ring_reset() already take RTNL from bnxt_sp_task() the same
way.

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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0682060b048c..0f37639b70ba 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14798,7 +14798,7 @@ static int bnxt_get_registered_vfs(struct bnxt *bp)
 void bnxt_fw_reset(struct bnxt *bp)
 {
 	bnxt_ulp_stop(bp);
-	bnxt_lock_sp(bp);
+	bnxt_rtnl_lock_sp(bp);
 	if (test_bit(BNXT_STATE_OPEN, &bp->state) &&
 	    !test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
 		struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
@@ -14844,7 +14844,7 @@ void bnxt_fw_reset(struct bnxt *bp)
 		bnxt_queue_fw_reset_work(bp, tmo);
 	}
 fw_reset_exit:
-	bnxt_unlock_sp(bp);
+	bnxt_rtnl_unlock_sp(bp);
 }
 
 static void bnxt_chk_missed_irq(struct bnxt *bp)
@@ -15495,9 +15495,8 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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
@@ -15630,9 +15629,11 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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

base-commit: fcc00b15cb21a6de76826e5012b2c758505f5e65
-- 
2.56.0.313.g2479322e68-goog

