Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF954E36FD;
	Mon, 28 Sep 2026 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614962; cv=none; b=ijdhkgP5IklM6WlxXhUZWrvLlhSr+cUvy1WqYFIbQTFpioSpB7RXOkQkBy+YMK8WgBMYkHDXCKs6hrwJsMl940RHmKgKbFIMpCbCIx+wXyxrHinhvocQoitkZKt4yjlM8Kuj14xnF2iVujVS3FkpS1uS53TKdRP9AXMgeOX4giw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614962; c=relaxed/simple;
	bh=v8zhVjeYjrvS3PNw5JFe2GMaSJWmHxoKwtZe7MJciO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orIBpr/N576dmYbVJds3n1qF5GmCwkEuMep/YA6dGGsdTAvwuwrKyQCz8rd4sEiqPxouqona4EWBaqpUsepalBD4xftSLU4Pk9ANNIgdJPxyhGoxOx3oMqBvlpa97U/ioa5HEJFpQJBKLG8SNABU7QElDR4APTwqbceOLmqUF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fRg2Y7aI; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fRg2Y7aI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790614961; x=1822150961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A6WK9Y80CiMB/rsYyBjNtDkyFYNfAIuXEKudJHh0z+A=;
  b=fRg2Y7aIsfzr/w/I/2Msxl9UGFPKHdm87efAikJi6ondNodSYG8Z7C90
   Iv6E/sGNGu3poIMprf20Mu3yh1ixf3PfcJm1BZK11dcI4wx9rv0+3WUcD
   lO1h7eJkvncSIcmez5c/toteXy+vCBvjsHlCp2TuPgyv2CN661M3Q4K9L
   iN2h8H8awW5UN/G5ghRWAzL7SJxEbrPo32sIqDBOswAtrOGyivqgJJ8D+
   Anh9V2LDWhkVyGCWG2eolrWG8DAMuuRAe8qHC2YTCGVxKr/Yl2ia+/H2I
   Y69cbu5qIWYtIJRMd6h8if+NPVitaUwDvJgcl8I8/rvt4PUOboy/wjPGC
   w==;
X-CSE-ConnectionGUID: +/9tSSI3QKyOYNOTI/JyPw==
X-CSE-MsgGUID: PdNkOt0MSl6yREab6LDRPQ==
X-IronPort-AV: E=Sophos;i="6.27,128,1787011200"; 
   d="scan'208";a="29851915"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 17:02:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:5642]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.187:2525] with esmtp (Farcaster)
 id 719bb9c4-0476-426a-b2aa-bdff1f3c6d8f; Mon, 28 Sep 2026 17:02:40 +0000 (UTC)
X-Farcaster-Flow-ID: 719bb9c4-0476-426a-b2aa-bdff1f3c6d8f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 17:02:40 +0000
Received: from dev-dsk-hagan-1f-c6b5e25f.us-east-1.amazon.com (172.19.159.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 17:02:39 +0000
From: "Craig I. Hagan" <hagan@amazon.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Fabio Sabai
	<sabfabio@amazon.com>, Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-net v2] e1000e: restore jumbo config after DMoff exit
Date: Mon, 28 Sep 2026 17:02:34 +0000
Message-ID: <20260928170234.21877-1-hagan@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923235832.473-1-hagan@amazon.com>
References: <20260923235832.473-1-hagan@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On an I219 (pch_spt+) at jumbo MTU, after a link partner reset (e.g. a
switch reboot) the interface can come back up unable to pass traffic until
it is manually reset. Observed on I219-LM (8086:15b7) at MTU 9000.

When the MAC exits the DMoff state on link-up, the watchdog resets only
the PHY. A bare PHY reset does not re-run the jumbo-frame workaround
(e1000_lv_jumbo_workaround_ich8lan), so the jumbo configuration is left
unapplied and traffic stalls. This was seen with NIC runtime PM disabled;
if runtime PM were enabled, the device should go through a full reset on
resume, avoiding this issue.

Request a full reset (FLAG_RESTART_NOW) instead of the bare PHY reset when
the MAC exits DMoff, so the normal reset path re-applies the jumbo-frame
configuration.

Fixes: 2e7256f12cdb ("e1000e: Check the PCIm state")
Cc: stable@vger.kernel.org
Reported-by: Fabio Sabai <sabfabio@amazon.com>
Closes: https://github.com/systemd/systemd/issues/25925
Suggested-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: LLM
Signed-off-by: Craig I. Hagan <hagan@amazon.com>
---
v2: Rework per review. Instead of the fc-latch autoneg-restart
    approach, request a full reset on DMoff exit so the jumbo-frame
    workaround is re-applied (root cause identified by Matt Vollrath).
    Drop the diagnostic e_info. v1:
    https://lore.kernel.org/netdev/20260923235832.473-1-hagan@amazon.com/

 drivers/net/ethernet/intel/e1000e/netdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab3..df7da86a8 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5264,9 +5264,11 @@ static void e1000_watchdog_task(struct work_struct *work)
 					usleep_range(10000, 20000);
 					pcim_state = er32(STATUS);
 
-					/* Checking if MAC exited DMoff state */
-					if (!(pcim_state & E1000_STATUS_PCIM_STATE))
-						e1000_phy_hw_reset(&adapter->hw);
+					/* MAC exited DMoff; do a full reset. */
+					if (!(pcim_state & E1000_STATUS_PCIM_STATE)) {
+						adapter->flags |= FLAG_RESTART_NOW;
+						goto link_up;
+					}
 				}
 			}
 
-- 
2.47.3

