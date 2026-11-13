Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567529;
	b=w2qQNmb46gn06K5rjHgBTV/zcIUSCtAJOfYXjgnAprkJ5rR2UeAxjtn/sCbsQTpFQDg7
	 lSmB/iAvFE5o98TocRL0i95RAY240jii2c7WiJhFs/YpIrlKh6z1q0pd35Y1MrkbnMw1Q
	 htAv23Eq9M3Be3aWwL8fK6ofHQxa5adh7zfSWzlntk48Wwi465H/tMkZj3hNOWZDnKKeX
	 mjkcUNfShQrWRlXF+8zuwEW4gvdJyiofmVtN4CaJ/4MHPb6oC3PN29qPgQVaAWs/3i0MF
	 Lit+ueOom2vcANn0vhFJnkprDVJUu/la5UerWvv1NTs4XH4B/ZsPMu4auIV26Pfamcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567529;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=r1yDilK6qB0Us3n3DQsotlXwYJQ4+ehyKDqtQf7/FDs=;
	b=HPEZSmD9Yg6Yx7I1unVc1PsxmapaiNSFFaWFr2Re7aK6rbFvI2brzxK7w3ELoHeesR07
	 hmci46Au/s0YftUmnZGtir+Ra5DfIenFn/mSC6j2RHCGxHghFAULIL8B4PlfP5XiyM3SU
	 zjspIZIo6sgJyJm12NFmI625qbrGuUOtre4g8LpSOXU1iLiVD+OGgQbQFT6rm8X1jWYe9
	 BGaxtYXZS2coSzbdAwP6nUf7ps1lF6T1jjbB9DQtTaVVu3NimguMVxnLaEYv3c/pWTZW3
	 oQS1KrTaSGRWWFXDH6qezeRotGg/JzXEKTm9PG8ooP4Jzi4PRmPSAopjlHBgLvCMOkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=FN5n39gl;
	arc=none smtp.remote-ip=195.10.208.42
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B2606B27C;
	Fri, 13 Nov 2026 10:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 230B2606B27C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=FN5n39gl
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jQvPv6lYNz5xyN;
	Fri, 13 Nov 2026 11:58:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794567523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r1yDilK6qB0Us3n3DQsotlXwYJQ4+ehyKDqtQf7/FDs=;
	b=FN5n39glsRmZ8Hy5vSXpC/z7hej2XvnC2OeRTXF5nEmyUua2UvrYARCFnReM+8HUF/z0N0
	xjH+mKwM+gXu1p4Z7urvEKcVqaTVo9647PWYnQ1P1c5rrG9nTily5lv70iC1Dl82TWNpvs
	XGftQsx8ydB4PhEaQkomqkIz5oACDg4CywU2tVGkakI3uDZqmhQbo0c1mIwJtHL+WokW+L
	ca1x/XtLlKvp+Az3Ud01FldzqcY8SyppSZ86TnGNtDrvyKwQCaXFzsTJ3bvSAFdXM0pEkc
	h86wDZxZBmVB1qHxEK1M/iypiRkizsQ6kLDQN/+uKapD0U5Q+tVfxw+FAkSvyA==
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
Subject: [PATCH net 1/3] igb: fix RTNL assertion when resuming from runtime suspend
Date: Fri, 13 Nov 2026 11:58:31 +0100
Message-ID: <20261113105835.3821433-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
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
X-Rspamd-Queue-Id: 4jQvPv6lYNz5xyN

Since commit ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in
RPM resume path") __igb_resume() doesn't take RTNL for runtime resume,
but __igb_open() still calls netif_set_real_num_{tx,rx}_queues(), which
require it. An asynchronous runtime resume (e.g. after the link comes
back) then triggers "RTNL: assertion failed".

The queue counts only change on paths that re-open the device under
RTNL (ethtool -L, SR-IOV reconfiguration): set them in igb_open() only,
as igc does since commit 6f31d6b643a3 ("igc: Refactor runtime power
management flow").

Fixes: ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in RPM resume path")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 24 +++++++++++------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 78f0786..bd1185d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4178,17 +4178,6 @@ static int __igb_open(struct net_device *netdev, bool resuming)
 	if (err)
 		goto err_req_irq;
 
-	/* Notify the stack of the actual queue counts. */
-	err = netif_set_real_num_tx_queues(adapter->netdev,
-					   adapter->num_tx_queues);
-	if (err)
-		goto err_set_queues;
-
-	err = netif_set_real_num_rx_queues(adapter->netdev,
-					   adapter->num_rx_queues);
-	if (err)
-		goto err_set_queues;
-
 	/* From here on the code is the same as igb_up() */
 	clear_bit(__IGB_DOWN, &adapter->state);
 
@@ -4223,8 +4212,6 @@ static int __igb_open(struct net_device *netdev, bool resuming)
 
 	return 0;
 
-err_set_queues:
-	igb_free_irq(adapter);
 err_req_irq:
 	igb_release_hw_control(adapter);
 	igb_power_down_link(adapter);
@@ -4241,6 +4228,17 @@ err_setup_tx:
 
 int igb_open(struct net_device *netdev)
 {
+	struct igb_adapter *adapter = netdev_priv(netdev);
+	int err;
+
+	/* Notify the stack of the actual queue counts. */
+	err = netif_set_real_num_queues(netdev, adapter->num_tx_queues,
+					adapter->num_rx_queues);
+	if (err) {
+		netdev_err(netdev, "error setting real queue count\n");
+		return err;
+	}
+
 	return __igb_open(netdev, false);
 }
 
-- 
2.56.0

