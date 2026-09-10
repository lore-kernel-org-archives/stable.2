Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B9B47A891
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042705; cv=none; b=kX2Yn/JV4clbYZ65DPQCH5CmatVp4+14Gp5dsKmWrPeTKXc+U5TlVNTEsR5gR2JSUseHUV7GLIT+69Lk7s9BBpGIrUaEByW1iov1V6MbtI8GLTeMFqvb2BFKlvUaiEmpQMsYMp/3MthDuOnvdMCkrURLsQLVEo8PoWD4++YFzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042705; c=relaxed/simple;
	bh=7oQZaiLJIk8SsIzKL/EoDlk1Jdh47a/FrlW6GP9QkaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GcNSWnG9m41K1NU+4EVkDedauz2hNiFvspgYEEyCoVvwoCw4hRP+P+Fq6L6YTf+8/M1qZwPcNvwoSKLLtlnEuTTeJHX+CmUbUjC0bWVUewEdIlVxQ99pzmhEMoINb9J828j4hB3tWh685PF1Zye+kdWAzNNsHRSp0mvWBgWpH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0ifCIga; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0ifCIga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789042704; x=1820578704;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7oQZaiLJIk8SsIzKL/EoDlk1Jdh47a/FrlW6GP9QkaM=;
  b=l0ifCIgaEQ17DozVp7K3uu25mzOrq+a2D6RXxMMn0fDt0m1t6qt/YhFs
   5s1P4EojKI1zUhWaVYCYRStq8M/Dzj25VHd5A7AjDWT2em8O03k5iU7P/
   3rR8MKReodALdwX9GX1NfWFh+tDNQDkL9wecxslP9eSAP0ttPP2EUd51i
   KdMezlSPwQISL67DiGqnb+V/9/AjmomIK5NTLuNX+G2k399pfBPvY9Sro
   06iANb+pgSJlzEW5v7fsKH+wx3vVUXCOkP0ZuseLCwNupcP5cllcBfrQv
   Pko1GMR/tM7DD6c2BeC5qu1+2vUk0mYSofVPePSXN6cloiY40s0reUVvG
   g==;
X-CSE-ConnectionGUID: p4NquXOvQ06vf+1V0jM5aQ==
X-CSE-MsgGUID: pyxyEa3NRvSRONkAVSv9NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93355539"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="93355539"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 05:18:23 -0700
X-CSE-ConnectionGUID: LfG2TgkCQFKUG2yTQatThg==
X-CSE-MsgGUID: P/goq5bTQvW8aXp4qRdGYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="270264504"
Received: from dev-274.igk.intel.com ([10.211.136.198])
  by orviesa010.jf.intel.com with ESMTP; 10 Sep 2026 05:18:21 -0700
From: Jakub Legowski <jakub.legowski@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	maciej.patelczyk@intel.com,
	Jakub Legowski <jakub.legowski@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/1] drm/xe/guc: Fix wake_up race in handle_sched_done
Date: Thu, 10 Sep 2026 14:17:59 +0200
Message-ID: <20260910121759.1835037-1-jakub.legowski@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Move wake_up_all() after clear_exec_queue_pending_disable()

When a SCHED_DONE G2H arrives for a banned exec queue,
handle_sched_done() calls wake_up_all() before
clear_exec_queue_pending_disable(). This creates a race with the
wait_event_timeout() in guc_exec_queue_timedout_job() that waits
for pending_disable to be cleared:

    smp_rmb();
    ret = wait_event_timeout(guc->ct.wq,
                 ...
                 ...);

This was observed as:
[drm:guc_exec_queue_timedout_job [xe]] Tile0: GT0: Check job
 timeout: seqno=4294967169, lrc_seqno=4294967169,
 guc_id=4, running_time_ms=0, timeout_ms=5000, diff=0x00000001

Moving the wake_up_all() (along with its smp_wmb())
after all paths that clear pending_disable, ensuring that waiters
always observe the updated state when woken.

Same as for runnable_state == 1 in the beginning of
handle_sched_done().

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
Signed-off-by: Jakub Legowski <jakub.legowski@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 99d8c807ff05..a181b5042293 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -3239,25 +3239,27 @@ static void handle_sched_done(struct xe_guc *guc, struct xe_exec_queue *q,
 			clear_exec_queue_pending_disable(q);
 			suspend_fence_signal(q);
 		} else {
+			bool destroyed = exec_queue_destroyed(q);
+
+			/*
+			 * Make sure to clear the pending_disable only
+			 * after sampling the destroyed state. We want
+			 * to ensure we don't trigger the unregister too
+			 * early with something intending to only
+			 * disable scheduling. The caller doing the
+			 * destroy must wait for an ongoing
+			 * pending_disable before marking as destroyed.
+			 */
+			clear_exec_queue_pending_disable(q);
+
 			if (exec_queue_banned(q)) {
+				/* Pairs with smp_rmb in guc_exec_queue_timedout_job */
 				smp_wmb();
 				wake_up_all(&guc->ct.wq);
 			}
-			if (exec_queue_destroyed(q)) {
-				/*
-				 * Make sure to clear the pending_disable only
-				 * after sampling the destroyed state. We want
-				 * to ensure we don't trigger the unregister too
-				 * early with something intending to only
-				 * disable scheduling. The caller doing the
-				 * destroy must wait for an ongoing
-				 * pending_disable before marking as destroyed.
-				 */
-				clear_exec_queue_pending_disable(q);
+
+			if (destroyed)
 				deregister_exec_queue(guc, q);
-			} else {
-				clear_exec_queue_pending_disable(q);
-			}
 		}
 	}
 }
-- 
2.48.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

