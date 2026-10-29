Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291067;
	b=lNnp8UPltRx1ex75MnZo3CYYmBnyIMOorTJk3PfJ+C45T59mzlyPfV+v1k1Fn7mnO944
	 3wCkOXdFuOCm/ML5QXpEX4Su2n5uxV2n1oLzNlRgK7UQce65UF9lJVB8a2im9OEz050mn
	 VPuh0cda7mnuM8Kn2Z8nog3D+XCrrOeRyzE8wxQ/DfGywWvyb+u7WX0lCzpbvfjbFqtRI
	 qI8BoAqcNF51LO1+lYR16kVYYkUE2ERwVkpLh0N2feFql4OWCrFMCDcfZhJtn3oHkTs0y
	 s1/9Kwz6+C0ZqKFmH/G9zgHpgrW/O1/E8KkOwMFc2GN8bVYdQ+ES9/Q+wCG5C+GKZtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oNt+k5hd6gK3JHgbJpiRSUaj/zK/QDMMxaVigJ+IVv8=;
	b=hKDSsytbsh3nUrOrHULV28jqhV7uOw9eafb4DNOndhmJKD2gv02Ve54ivJAeFKRI7LFu
	 zbQHgtc57dTp6dL42Sa4+qPHcTLQhbfM98r12Kybr8Es2vUZJfrto8Kpia+vIFXODkpei
	 BgynNOEklM2iO6+tIUGKCzIT0OVCNqO3M3X3TUwUa06bN7AruOQngaUrMvye59phKLdR/
	 4UcSrK0CsMzh06OFEsuh8K09BQW2JClfGtz1tpdfrkc+xLwtgB+03uCV+QkExayGcZhIZ
	 a95duaDPUf23I4rV+fKrlVEo8MJkPZD5rIqMDRPBYUPmfu2Cyu7FMWUJ1q8skdplfGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EGgcrtXQ;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A9606A31F
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A5A9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EGgcrtXQ
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c5358fc28so1911396f8f.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793291064; x=1793895864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oNt+k5hd6gK3JHgbJpiRSUaj/zK/QDMMxaVigJ+IVv8=;
        b=EGgcrtXQdOXQe8Wg0+y8mCFeBHdwKIWFWLS/tzXhFxzxnqxJrzHwwWiZtPoBhrGyJ5
         MJMiCdAOXmfo0PFLF8Gw6XXBHnFLiZx1RPVgWgOIayKgr5ex+ji6RJACXHIRA2UMfkUp
         K94IctlgigFoTiFGSgNvWkZJwURBoPJ8ZOAXPv7ziW7TPFNd0rY8zBP8/sFl6i6HaLu9
         TGAUU8LJZhRX+gcJnKV2J+GUnwrH/f8+XehiIAOGPRgYE/VmO2/uvWCsMyyDFz5kHlf/
         kwp16+H7ZDGxYyLza2o5TJWPDlOpw3LGog5MqLTr0MGnczBNMJQ1jAlV2E+vyAkVSNmj
         avbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291064; x=1793895864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oNt+k5hd6gK3JHgbJpiRSUaj/zK/QDMMxaVigJ+IVv8=;
        b=gZZO7CQdQNnTZE9nlPse+r7H3MK9ELGSKRMuMpsSlWgXxgECcqX8b/OOxyvhNr9Gwy
         NFLFD0iCPIWBCwweyqogpXx3cSF7uCVxG+c+6dFWM+2BzodrR258CGmRft/D5EKtdeUi
         kx5ZRqhv9XfRbTjfuPP+Nlx9iw5UvYDl+2rrK/fHA2RoNavCpQhBoU395OGQtM/HXf8c
         AFJfUcHb27Zn9rramKGIznAztGAMJCWxE7h40pinZYeYWHmlwAK9q8oMVpO1LHssX7Vt
         73UoGgPV6MIBWrYh1vuRIgEHWjhl7AVCkLGOPjY5Eluj6MX4mWcN/PIEmxBtDf5ArWpD
         tTkA==
X-Forwarded-Encrypted: i=1; AKwUvBwQ5XJcwXv0GQe18a2979GbnMai0KMCAYjcTNkf+JWH7OeWd8bb/Rq9gtOwKljg8Oy7FRdIYAw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcoeYbUVvz5xPGzzJta0i0hLRT9iFZj5nye8Z2QVbrh/ZUFC9w
	SxGexspV0frRbT859XyE0h7S/Tj5mwslfDr6CU4OKDaHlGBmnr4gJBw=
X-Gm-Gg: AYBFou0MWp6j88a1UhptxZ9iuDw+HqneE6PqmHrKA1iWR1nC+omVUWaa3a0QLP06eUh
	L7SKK9CxWq9t4f7YDuK1bZnjjuMaVmRiMFEqID5drxoLgkr4EU2YpuiBd52/CClyA0lq6KvltVa
	8vidG4lAOhbggM4fPYrk4dFqKy+/GamqN+kgUAp8aNggfXHUPOt+9GfkCh15rJ39NJLDPReSvO5
	c6NM/TPtcXGUcC33Vyg2Qpkpd+s9Oc0U9OEmZuSAtxXaUkpqilcbl3fjAmbfNym7voqhOSBf6M8
	RnAGaimjXoWNfiGnREccnSp5sLM4cVOq4V2K75k5Ms5FTQPfkp0eXNGxOv/gcdSZALaiz+jyLCm
	mekiTM5x5zpUGO9y9E6xwNE5DUdpK5SUoyHyDd9/tXGVRStZUOcJG99u6BuGfsWDFbhNZgGrQKt
	6BLJNNtYAkp16YSiEm37m9ZQe9gL906JsnCX7WoT7rpfOWSgfpnPghCxUseGJNagT49RPRmDKlh
	2FAsuETv+hQ9fZ/9VATBTrtWJMW+fYfT8uzRP+Td8buyL2D6V1lKApNLPKl5SrWl6PlseJ5/Q==
X-Received: by 2002:a05:6000:603:b0:48e:389:d2d5 with SMTP id ffacd0b85a97d-48e5d5b4a5emr14665720f8f.51.1793291064450;
        Thu, 29 Oct 2026 09:24:24 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6dfaa4ccsm135494f8f.39.2026.10.29.09.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:24:21 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	"John W . Linville" <linville@tuxdriver.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 net] nfc: llcp: use disable_work_sync and timer_shutdown_sync in local_cleanup
Date: Thu, 29 Oct 2026 16:24:19 +0000
Message-ID: <20261029162419.2420980-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

local_cleanup() tears down timers and work items before
local_release_work() frees the nfc_llcp_local structure.  The current
code has two ordering problems:

1) timer_delete_sync() does not prevent timer callbacks from re-arming
   the timer via mod_timer().  nfc_llcp_tx_work() unconditionally
   re-arms link_timer, and nfc_llcp_sdreq_timeout_work() conditionally
   re-arms sdreq_timer.  A work callback that runs during
   cancel_work_sync() and calls mod_timer() causes the timer to fire
   after the structure is freed.

2) cancel_work_sync() does not prevent work items from being
   re-queued.  nfc_llcp_rx_work() queues tx_work via
   schedule_work(), and the timer callbacks queue their associated
   work items.  Since tx_work is cancelled before rx_work, a
   running rx_work instance can re-queue tx_work after its
   cancel_work_sync() has returned.  The re-queued tx_work then
   runs on the freed structure.

Switch the timers to timer_shutdown_sync() which rejects subsequent
mod_timer() calls.  Switch the work items to disable_work_sync()
which rejects subsequent schedule_work() calls.

Reorder the teardown sequence so that both timers are shut down
first (their callbacks queue work items), rx_work is disabled
before tx_work (rx_work queues tx_work), and data structures are
freed only after all asynchronous callbacks are quiesced.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v2:
  - Switch work items from cancel_work_sync() to disable_work_sync()
    to prevent re-queuing after cancellation, as identified by the
    automated review and confirmed by Simon Horman
  - Reorder teardown: shut down both timers first (their callbacks
    queue work items), then disable rx_work before tx_work (rx_work
    queues tx_work), then disable remaining work items
  - Move data structure cleanup (skb_queue_purge, kfree_skb) after
    all asynchronous callbacks are quiesced
 net/nfc/llcp_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf817007cf2..984e7088288f0 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -173,15 +173,15 @@ static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 static void local_cleanup(struct nfc_llcp_local *local)
 {
 	nfc_llcp_socket_release(local, false, ENXIO);
-	timer_delete_sync(&local->link_timer);
+	timer_shutdown_sync(&local->link_timer);
+	timer_shutdown_sync(&local->sdreq_timer);
+	disable_work_sync(&local->rx_work);
+	disable_work_sync(&local->tx_work);
+	disable_work_sync(&local->timeout_work);
+	disable_work_sync(&local->sdreq_timeout_work);
 	skb_queue_purge(&local->tx_queue);
-	cancel_work_sync(&local->tx_work);
-	cancel_work_sync(&local->rx_work);
-	cancel_work_sync(&local->timeout_work);
 	kfree_skb(local->rx_pending);
 	local->rx_pending = NULL;
-	timer_delete_sync(&local->sdreq_timer);
-	cancel_work_sync(&local->sdreq_timeout_work);
 	nfc_llcp_free_sdp_tlv_list(&local->pending_sdreqs);
 }
 
-- 
2.47.3

