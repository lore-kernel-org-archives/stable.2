Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679739;
	b=C63EQLM5Kz4S9I/10RcHehHVYd9kWMLvhEh2r5VRP38pzxoCJkcoK1rxTcuUmjvGZbJO
	 Wvs9tG0RbxLwtGyjLaFWjP9UgLqsU5pGxQDlhAZCHOQV9ObxFIr/9x3b4k2AVl4dY19yk
	 4RQjDhlaPMtXRG5KZ26ZnJyjLWzXYT/euip92LiG3p0ru2HnoPhM1PC2Mn3IxNBH3DUpY
	 ClrYsgYOzIBoowbyrZlqm2QcM06a5Ab5lL/VKn8ztMLxuFSDEwhHzqCQFfxXNC9HGTQWp
	 wb9MXf+y9CwtahIVjOxG1Pk+2mpEatd+6Q7Pa10PDpYzSJ/PIbbptZ7tnkRq+/tfplw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=KiEC/iwKsFjuGJG7+7hGX+X7vp7j70ILn+fEpr7GfzY=;
	b=0V2u1RbQe0RnlJbkJp59ZDzDCkFq7nJWCEtcCezpEA5qg2PBLOTxsE5XYm1rAbqXDEQW
	 hVH9Mj4Vd+mHlOVv9tOichOcApTvcYcdmdCOK9y/VSoGQ17grtZ9KKUfm24RGTIAHehb5
	 oxtFuDGJugkqQLNdMYoym9kBgAQpBJ4HjD8jSOlHZdlJcXFm7zpEkVWDioSkdm0t2EcAj
	 lkTiWgvcl/X95CGHVjK1e34QExfmK9iNDB5DR+RXL65fDbzQ1RDXjQqvm/HqI93xBfusu
	 VGQkO3G2BgtAWJNjTMGP0/mAmRzLlbebksicChOZIrFUIuy9stHVhp/j6Qk24QRopSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--bcochrane.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c2W0yadR;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57159606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 04:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57159606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bcochrane.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c2W0yadR
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so8508732eec.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 20:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793679738; x=1794284538; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KiEC/iwKsFjuGJG7+7hGX+X7vp7j70ILn+fEpr7GfzY=;
        b=c2W0yadRBxevsRR27jIMh/vfrXSK5Xm1RZJvDDQGEZg84pBwzWpwXSSfLanDtMIhs0
         IWXGJecTvskm0P8fyZ2sSTCDMrtWamzGyRuX2Sw2g3zkjjWGMi1pgMSXFOLDz7Tvm6Zp
         QeQLYfSN79OiLx4afw9dUdQ71rIJjOOYXgdJugoSD5jicyVP5iwN+0/KfL70fqEJl5aV
         tgkOQ72ohe8kiQeJBC9sHD2on5yypqkSpls+8GqGQwvqyFiWwZeou4oWgIXBWbiEff7m
         Ff3GeOXglMDUGCuWjJhA37CQhua76+BQZW6Z6WonDhUdsD4yuYc/tMnrvLI02qwkMBa/
         oOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793679738; x=1794284538;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KiEC/iwKsFjuGJG7+7hGX+X7vp7j70ILn+fEpr7GfzY=;
        b=FgYcQ3SE5N6t/QYuJ8/xLGlorZatq0dbZy7JUmaX5FCYBDpAzJqeKRCVWR2tIY7+/K
         mJZKdHc4ZQUtMr4swbKNz7dCbE4zieWowiOECELZMZKxOEe96xOou2YoMBi+00B5Ur/Z
         10doy08255hCuiTNj7pKfjEoBuhx2Ks37CpvBRjXr0vQ4NhDw6dCnATLqMbO3ABooBmQ
         v3OsVQ5ZyE4gMjZzeIZiy9x/EIFrUb7tFZT8jcw10riFmAS67Y3/BJ1ykrngGbGdiMWR
         3v9pqY7rfB64OV3Kub87ZR67OnFEGEbRIUnAd7BYBa9kJwEo1oIYV1f0yhifoFrkqjNo
         aEXg==
X-Forwarded-Encrypted: i=1; AKwUvBxpFQhlPm9CsQigCqDyU+BAHlDF1LX+K2LywPkyMEanvUqv5cGTNim+JDJGbmm01Os9xE2P4t4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Jsf+SX76tRYTPo+4ILBxqHM88BayYQJFQD0RprYmJi+qpBsig
	QGLgiYDFvfYcnlq+wYbfXSB6iXBqS7XUBuYELUXd198CoELhJcHKE/b70+vtMrJruob/SvzKTgF
	knd6i1niJrid27ILhyQ==
X-Received: from dycaa8.prod.google.com ([2002:a05:7301:5408:b0:353:58ae:4c3c])
 (user=bcochrane job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:69cd:b0:34d:96cb:d75e with SMTP id 5a478bee46e88-36a423bed39mr19071534eec.27.1793679738088;
 Mon, 02 Nov 2026 20:22:18 -0800 (PST)
Date: Mon,  2 Nov 2026 20:22:09 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103042210.2984373-1-bcochrane@google.com>
Subject: [PATCH net v2] bnxt_en: Take RTNL before netif_close() when aborting
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

In bnxt_fw_reset() only the error path that closes the device after
bnxt_get_registered_vfs() fails needs RTNL: drop the instance lock,
take RTNL and the instance lock, then clear BNXT_STATE_IN_FW_RESET and
close. The normal reset flow, which may run on many VFs at the same
time, keeps running without RTNL. BNXT_STATE_IN_FW_RESET stays set
across the lock switch, so a concurrent close marks the reset aborted
as it does today and a concurrent recovery request backs off.

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
v2:
 - Keep bnxt_lock_sp() in bnxt_fw_reset() and take RTNL only on the
   bnxt_get_registered_vfs() error path, so that the normal FW reset
   flow does not add RTNL contention when many VFs recover at the same
   time (Michael Chan).
 - Dropped Stanislav's Acked-by because of the change above.
v1: https://lore.kernel.org/netdev/20261029032832.1511180-1-bcochrane@google.com/
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 33c4cacc8ffe..1ea1e8266eab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14860,9 +14860,16 @@ void bnxt_fw_reset(struct bnxt *bp)
 		if (n < 0) {
 			netdev_err(bp->dev, "Firmware reset aborted, rc = %d\n",
 				   n);
+			/* netif_close() requires RTNL, which must be taken
+			 * before the netdev instance lock.
+			 */
+			netdev_unlock(bp->dev);
+			rtnl_lock();
+			netdev_lock(bp->dev);
 			clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 			netif_close(bp->dev);
-			goto fw_reset_exit;
+			bnxt_rtnl_unlock_sp(bp);
+			return;
 		} else if (n > 0) {
 			u16 vf_tmo_dsecs = n * 10;
 
@@ -15547,9 +15554,8 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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
@@ -15682,9 +15688,11 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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

base-commit: c3e67bd82b9b9b1a5118f09a429ccefe2aab0741
-- 
2.56.0.385.gac671c819a-goog

