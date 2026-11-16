Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843060;
	b=PqrwYdPNtGNbV8RtjWRf6hoa5mzysbX88Ni3O67P08+2XWf7XwnsEVc9WnQjCdY/+9rL
	 /uP2iTxC0bYjvSuhuqjnrSd4xwnOMKnnvzY9HiOggIn/dtdFKkCyciO49nZjjdoPwW2jN
	 6ef7iqC7gXtO7huaE2j7lEmu3n1PF1ilIKJc7PAVMPBv7PYa7wYe6WlBCcQUMXss9gziR
	 qMd7UEPB15OPeu8uDi6Vl/segD1EFpbRcJX/FsjyZQaD8FzkfXot+9NofRT6n3gtkJws6
	 uxyWJG3Rji1+AY7HgM4MO/bhvGn4rGC1csziOs0//M23cQiqxjxenyX89X99YB59QAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843060;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=/KvAfHc/QLMwdWXcJBMsR4GboKbodePkCw59oer/jOY=;
	b=wUpEFDDuD8+fnAk0RX3gG7CLD3IF6sugT7neVuGqAGhp94DKxywwhbLM1I5WVjN1RC1q
	 b8oZyN2dQIv+32VQpJo1Ca3qou2yeQuIwEhOEuIYwLkut/b/8RL5RE/d28nNAWqOoJTMP
	 VY0/Wu0vNjtDMMwoCBxiQm17mubYLLoflRgp0U3dvs9QFbayRCHzYLzyyJfaMluC8AixJ
	 yKz8UefoUViWZIvT/lyLMYiBFsr72/XPHHBQab2a5tKzL0B1DB0kIrshqNULnu2LE+d0+
	 NknWx9qY7i3u6rFBFCUg3HnWwa7lE1im52BzClGOENw5PhJ6D93X2/DYYLn7ZEILing==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b="X8DIOU/s";
	arc=none smtp.remote-ip=195.10.208.55
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3BD606A33F;
	Mon, 16 Nov 2026 15:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E3BD606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=X8DIOU/s
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jSsJT6Wm7zNlbp;
	Mon, 16 Nov 2026 16:30:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794843049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/KvAfHc/QLMwdWXcJBMsR4GboKbodePkCw59oer/jOY=;
	b=X8DIOU/sKPJhcdO2Bxc1cYL7LCCupLRpR8BlauYVB/oPs+8MllRzMcVaxUVRD4I+nf0Aqw
	YmL5Hn/jEWEtHcAws8uCwJz0hYtLV3z/yRRDgRclmrxzE3FY/Rtp35Ka+r2pmt1XbWLxZF
	eeVo4Vx0X8QvtU9vOKguDtqyaOQD7/o8RKO9jAHhWINfo14OMf8QjBWYsLJFrf5PKik/El
	mxTTrjq3NbfP6wLv8Ji4Nd0q6BNJ2A1+OCt5KOUFlSl+pphf7n95YH4nsITDk7y3z62O0w
	OS121uyroT4qHPF5gza/ivPOUfRLAvWxfXD2qq7w4so7ghcMiefOObjGsyBLkA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/3] igb: fix RTNL assertion when resuming from runtime suspend
Date: Mon, 16 Nov 2026 16:30:37 +0100
Message-ID: <20261116153041.3002666-2-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116153041.3002666-1-antonio@mandelbit.com>
References: <20261116153041.3002666-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jSsJT6Wm7zNlbp

Since commit ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in
RPM resume path") __igb_resume() doesn't take RTNL for runtime resume,
but __igb_open() still calls netif_set_real_num_{tx,rx}_queues(), which
require it. An asynchronous runtime resume (e.g. after the link comes
back) then triggers "RTNL: assertion failed".

Skip them when resuming. The counts are set again on every regular open,
which happens under RTNL; the only case left out is a fallback from
MSI-X to MSI during a resume, which leaves the stack with more queues
than the device uses until the next open.

Tested with the 82576 emulated by QEMU.

Fixes: ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in RPM resume path")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v2:
- keep setting the queue counts in __igb_open() after igb_request_irq(),
  only skipping them on runtime resume: setting them in igb_open()
  before the device was resumed broke the MSI-X to MSI fallback and XDP
  setup on a runtime suspended device (Sashiko)
- drop the reference to igc, which has the same ordering problem

Note: igc sets the queue counts in igc_open() before igc_request_irq(),
which can fall back to MSI, since 6f31d6b643a3 ("igc: Refactor runtime
power management flow"). We didn't have igc hardware to test a fix with,
so no igc patch is sent for now.

 drivers/net/ethernet/intel/igb/igb_main.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 78f0786..4447546 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4178,16 +4178,20 @@ static int __igb_open(struct net_device *netdev, bool resuming)
 	if (err)
 		goto err_req_irq;
 
-	/* Notify the stack of the actual queue counts. */
-	err = netif_set_real_num_tx_queues(adapter->netdev,
-					   adapter->num_tx_queues);
-	if (err)
-		goto err_set_queues;
+	/* Notify the stack of the actual queue counts. This needs RTNL,
+	 * which isn't held when resuming from runtime suspend.
+	 */
+	if (!resuming) {
+		err = netif_set_real_num_tx_queues(adapter->netdev,
+						   adapter->num_tx_queues);
+		if (err)
+			goto err_set_queues;
 
-	err = netif_set_real_num_rx_queues(adapter->netdev,
-					   adapter->num_rx_queues);
-	if (err)
-		goto err_set_queues;
+		err = netif_set_real_num_rx_queues(adapter->netdev,
+						   adapter->num_rx_queues);
+		if (err)
+			goto err_set_queues;
+	}
 
 	/* From here on the code is the same as igb_up() */
 	clear_bit(__IGB_DOWN, &adapter->state);
-- 
2.56.0

