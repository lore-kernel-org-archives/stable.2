Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564665;
	b=l212qbc7wxEHVc1wBIZiV7sTcasugLj6/CIURyVVJwe58e2j0qPowKvFH7BpoADF6p79
	 yYH30WZxOzwGyXSeNbkI3IEk3SzniULTaTYTLeF9QxTS8TTQ4F8snSN2R0LxHG+4Vnk7N
	 PrHpXUK/PjJTgvGehp/m047olTgqxNsGwirkR7It42NGS8fdLOmxiecV8uIh+XcP8zlli
	 SWCM1ip+m8qMFYS3ssHBYObhpQr0k6Tq/pUJ2LRYcNPWwmrgZYQW+tWxdwr1PGhXTXzhG
	 uZPFDcTEanXkDx37Uo6taS/ac/KNtcarw37r8cNE7pATshT5m/f1nwH0KbB8RrEYgkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564665;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=wCMeyeId4pxu+z1tczoA9noYx9DObdHNjkQk8bnS1Eg=;
	b=L1EdqZVT0RJIMND14RHkCbqAr0FnGPXNIFCk+FMCrHod4xFzCqeCWifApgCltMjz4pL+
	 /LzR5hrFwoGBOItGRCEAoTRtRn3liOu3uCMRy7D8h+5GEm/3MjHYepTiYlQZQ7UEG3CmQ
	 YnCmHlYIq5UJ4YpSprPCn5E67JYBgatefG2VIZOMDVALqtVikzaje/r+uRRh3wW2uupjb
	 pOkokH/2F2bPVx/+eHkBgHEyjOFHcymqYFv60XPafNd6sc3xIJeLy9rbkfdEW95TrHvSS
	 3kfKB5r+LMTRQYf7ShcMFeNp2igEIHbJMXTHmootlFMr9Xj+5eBINoX4gixVDZ8RumQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=10OFZmT3;
	arc=none smtp.remote-ip=195.10.208.42
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B4606A68C;
	Tue, 24 Nov 2026 23:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 789B4606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=10OFZmT3
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jZ09V74Tqz5xNV;
	Wed, 25 Nov 2026 00:57:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795564655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCMeyeId4pxu+z1tczoA9noYx9DObdHNjkQk8bnS1Eg=;
	b=10OFZmT3XE/7yACnOfiGMRZhZ02DEO0NYxtRJQ9LbqaLAIWdwTVZVqyGMztKoT0tj3yIP/
	Rp1MfArwwIACswYdC6y3ncJbVaFMw2c46YaEadmwwVdNxX1u+gZ7HZzf1fsJM4ZAeM1Sao
	cjsMdYWr32Wk0e9kyPNSW8Rg+elD2mwqV6RRSkOMEz94lZeDN8LaeDs+oAKURt//7lrGfb
	81a4zIVjdXysGZ/5Ro6XZBHDORWj5BrtTjC+7ig7PTJSirsCcoWN6JM3/Qt+TCcpwANYOB
	tckUCsDAS5BJHT2wyXEbPwMnMjRA5WRIficCNbFpkTdl9wea4fxveqVbGxQDrA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
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
	Janis Edvarts Lacis <janislacis06@gmail.com>,
	Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5 3/6] igb: keep the stack's Rx queues that still have an XSK pool
Date: Wed, 25 Nov 2026 00:57:18 +0100
Message-ID: <20261124235723.1135808-4-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124235723.1135808-1-antonio@mandelbit.com>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jZ09V74Tqz5xNV

When igb lowers its queue counts by itself, after a fallback from MSI-X
to MSI on resume or when enabling VFs, xsk_get_pool_from_qid() doesn't
find the pool of a socket bound to a removed queue anymore. Disabling
it then fails ("Failed to disable zero-copy!") and the pool's DMA
mappings are never unmapped.

ethtool refuses to remove a queue that still has an XSK pool, but igb
can't refuse a VF enable or a resume fallback. Keep the real Rx queue
count up to the highest queue that still has an XSK pool instead, so
that the pool can still be disabled, and lower it at the next open. The
Tx count follows the device: an XSK pool is always bound to both an Rx
and a Tx queue, and the lookup finds it through the Rx one.

Tested with the 82576 emulated by QEMU and a zero-copy AF_XDP socket,
bound to queue 2 when enabling a VF, and to queue 1 across a runtime
resume forced to use MSI with a single queue (with a test hook): closing
it warned and leaked before, not anymore.

Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
Cc: stable@vger.kernel.org # 6.14+
Reported-by: Janis Edvarts Lacis <janislacis06@gmail.com>
Closes: https://lore.kernel.org/netdev/xupy6jbpnziq2qji54zjbvm7neggrwkxg3sfrhlolmrd6ysifl@zptk6ynkbu5f/
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v5: new patch (Janis)

 drivers/net/ethernet/intel/igb/igb_main.c | 27 ++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2f51edc..6961646 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4126,6 +4126,26 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	return 0;
 }
 
+/* ethtool refuses to remove a queue that still has an XSK pool. igb can't
+ * refuse when it lowers its queue counts by itself, so keep the stack's Rx
+ * queue instead, or the pool couldn't be disabled anymore: lower the count
+ * once it's gone, at the next open.
+ */
+static int igb_set_real_num_queues(struct igb_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	unsigned int rxq = adapter->num_rx_queues;
+	unsigned int i;
+
+	for (i = netdev->real_num_rx_queues; i > rxq; i--)
+		if (xsk_get_pool_from_qid(netdev, i - 1)) {
+			rxq = i;
+			break;
+		}
+
+	return netif_set_real_num_queues(netdev, adapter->num_tx_queues, rxq);
+}
+
 /* Some settings need RTNL, which isn't held when resuming from runtime
  * suspend: apply them from here instead, if the device is still up.
  */
@@ -4137,9 +4157,7 @@ static void igb_rtnl_resume_task(struct work_struct *work)
 	rtnl_lock();
 	if (!test_bit(__IGB_DOWN, &adapter->state) &&
 	    netif_running(adapter->netdev)) {
-		if (netif_set_real_num_queues(adapter->netdev,
-					      adapter->num_tx_queues,
-					      adapter->num_rx_queues))
+		if (igb_set_real_num_queues(adapter))
 			netdev_err(adapter->netdev,
 				   "error setting real queue count\n");
 	}
@@ -4208,8 +4226,7 @@ static int __igb_open(struct net_device *netdev, bool resuming,
 	 * runtime resume igb_rtnl_resume_task() does it.
 	 */
 	if (rtnl_held) {
-		err = netif_set_real_num_queues(netdev, adapter->num_tx_queues,
-						adapter->num_rx_queues);
+		err = igb_set_real_num_queues(adapter);
 		if (err)
 			goto err_set_queues;
 	}
-- 
2.56.1

