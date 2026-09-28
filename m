Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A0F3CFF51;
	Mon, 28 Sep 2026 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629560; cv=none; b=hb0X7SESd11jsHl0dFQis4Eu84X2x3byuVTU18HjjPhh/zZlfGa0GmlsWsmQUbE2+EiOZQ6yBrJ+Bm2EAgkmlJ0GXh27s3QFpkyUbkYa2RYOVyZicU/9x1HRgYM0m5+wfz87cNW0tHzWJz74X+TZb12j74cNkVxAzOnbCgWfhz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629560; c=relaxed/simple;
	bh=wuUohBGbBXVSwT1F9oeyOYlWlZvZjHrxx80qx8HHdKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9eUGwDaMT8i6NJH41b5JkwXiJRwy7lGGOxtaMPsZ83JwNMtwal7XlGtX+p/1GJ0bbDHHxiDCE1Qh3kgabWZ9/Ear1bHS1QdrBXFykxDwREwlXvKUYNskzkcrr7lR7F2+OsGsY9mYmIpOHlkcZ0Sw84qwBGcAsOE+eivu1uNLkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ky1E9bM5; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ky1E9bM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790629558; x=1822165558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tNvKZbvCsCLtftmndSEfAYbnBNeVdMmjscu91WBu6mY=;
  b=ky1E9bM5d17K+Xmau6PkP8Ti5VJDP5xatiR+mAVj+DW/J2hpcL2SeAw0
   QI2xyImbNllu5DZAPedwIbU1U0OO11VIhMTZVcL5btycrqGRXi0IZeunf
   ObWRYFLCB0A2D1nys92S3UMqQHahyZS28k7i+ctodjmhHiJ7rAnwUPi4K
   /deicXgMn3lh0nTAEEgWHAo7A+nJrWAWnde5x7GC6qXfh77txfvkfax/d
   oPpLwv4/0lyAq/VFNt5nZiKKwirZqxfVx87KXKxYQUMyCul2gQq5K0RvE
   SRdYP+4P/G7Sb8Pbe+euKwSUJd6V0HbqedYaOXmD31hfOX4k8XpfJvEjc
   Q==;
X-CSE-ConnectionGUID: 5pmLN4V2R+G43Ca+EuE9Fw==
X-CSE-MsgGUID: qj+ylq7qRTGk3cBUw90ouQ==
X-IronPort-AV: E=Sophos;i="6.27,129,1787011200"; 
   d="scan'208";a="29899893"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 21:05:58 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:10223]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.18:2525] with esmtp (Farcaster)
 id 106b90de-cb53-4848-b400-37e7ebe7ecb4; Mon, 28 Sep 2026 21:05:57 +0000 (UTC)
X-Farcaster-Flow-ID: 106b90de-cb53-4848-b400-37e7ebe7ecb4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 21:05:57 +0000
Received: from dev-dsk-hagan-1f-c6b5e25f.us-east-1.amazon.com (172.19.159.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 21:05:56 +0000
From: "Craig I. Hagan" <hagan@amazon.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Fabio Sabai
	<sabfabio@amazon.com>, Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-net v3] e1000e: restore jumbo config after DMoff exit
Date: Mon, 28 Sep 2026 21:05:52 +0000
Message-ID: <20260928210552.13266-1-hagan@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b6db5335-cb5c-4a91-b823-1a114fce75a1@gmail.com>
References: <b6db5335-cb5c-4a91-b823-1a114fce75a1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
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

Fixes: def4ec6dce39 ("e1000e: PCIm function state support")
Cc: stable@vger.kernel.org
Reported-by: Fabio Sabai <sabfabio@amazon.com>
Closes: https://github.com/systemd/systemd/issues/25925
Suggested-by: Matt Vollrath <tactii@gmail.com>
Reviewed-by: Matt Vollrath <tactii@gmail.com>
Tested-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: LLM
Signed-off-by: Craig I. Hagan <hagan@amazon.com>
---
v3: Correct the Fixes: tag to def4ec6dce39 ("e1000e: PCIm function
    state support"), which introduced the DMoff-exit bare PHY reset;
    2e7256f12cdb only added a pre-condition. This lets stable reach
    the affected trees (v5.3+, including 5.4/5.10). Add Reviewed-by/
    Tested-by from Matt Vollrath.
v2: Rework per review: request a full reset on DMoff exit so the
    jumbo-frame workaround is re-applied (root cause identified by
    Matt Vollrath); drop the diagnostic e_info. v1:
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

