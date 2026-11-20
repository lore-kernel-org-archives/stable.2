Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208516;
	b=jlKQS5iyl9J6ahSqWX1CjUmOz8pQc3BEbHIQdWaP58BW/IEHFnrdEFIcIKqW+6HU5Qep
	 LPlola/zLsNXx93NQ33T2Y36V3RrBm1FP+nNkfhWSOikwb+rdqEekD5ONTvIJOAFoMQjm
	 +Uv33pp6tJ26PEhFsiH2heiNimpAVsWuzE1yny/4a/uE9EcKmfw4+jo2rSOeos2sXZ3Ig
	 hBlWh15DPdRzWZYxirbcIYd6uOpQSptuC8Gimxgiu8m4qhyUyXh/5nd6L2X0uaw4CstWw
	 Bs52XwDvKmAWInkxPMy54uOj/cmuOXf7NmZh/Hol3YNRcD6gk/KfDKI+TqSEQax/OLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208516;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=HO1q0aoPA0BF8pQw7wMOKKak9460g+JZjnsIKYiHnDo=;
	b=K6ZVnfzf9bje+QspdRdjMvDm441JoRPgSLM9iZjaTh2unZol3c9ydG6U2l6nAvkre54s
	 nwOVl3qPJKh3HZsos3ewXuNLp++FkuA/r6FmgZTks4EU9AdH2pOHKIdpYuFLapTeB7mz4
	 7y+MfertVmjSQlkh0lNMo54zhfeOPVGhlPoiNb+aH8OLPYYrZkfcsgxOM7Js+AHk0D+gk
	 8jO7rx6rpy4F/9T35Bap26eaBeo9oo7YlrxBpzZ2Vj84OzdwPWBoxqpHimZTwfIHXCTn/
	 9185FIYBzBVOo3XKI1Liq2rKchaF6dv2rlzwfjchkbkXwRa05ey/YrMvru1ehFmqTdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=mW9VZGZU;
	arc=none smtp.remote-ip=195.10.208.55
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B0606A335;
	Fri, 20 Nov 2026 21:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 103B0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=mW9VZGZU
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jWSSP1txrzNkLK;
	Fri, 20 Nov 2026 22:01:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795208501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HO1q0aoPA0BF8pQw7wMOKKak9460g+JZjnsIKYiHnDo=;
	b=mW9VZGZUlNpE5JV2oo6PSgKn8hmkcP+pK7BBRAHAP0PPXmE1i61imrwz2YpiBFP+UlCIG9
	QCwhtBzJJt8osLbIptUzaQw5l8DGqaFZWfTQrU0SiaYwZNIkyThl/jfFpDpDo6wpMSdSZn
	rtCR/Z7RuLbu9bkeVNWeAXzubralMWRKU6iva9DAn3XdIgFvY/cwz2LwQntRmiB1q0wyEN
	kq5Eurrkd+0nXHIHjSEUseZrGAgU6o4OiF5ewrK8jJ1PY+fsmdP7Bb+dBSUDzgxWDodQOe
	pIlmtn8KEsCFFibJR77UdE9hmBL5e3pjRbma6S5OEJbJLXXXrefWsL5cUrnqAQ==
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
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/4] igb: don't touch rings that don't exist when disabling an XSK pool
Date: Fri, 20 Nov 2026 22:01:29 +0100
Message-ID: <20261120210134.133238-2-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120210134.133238-1-antonio@mandelbit.com>
References: <20261120210134.133238-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jWSSP1txrzNkLK

xsk_get_pool_from_qid() checks the queue id against the stack's real
queue counts, which can be higher than the number of rings the device
has: on 82576, enabling VFs leaves a single Tx queue while keeping two
Rx queues, and igb can fall back from MSI-X to MSI with a single queue
on resume. Disabling the pool of such a queue, e.g. one bound to queue 1
before enabling VFs, then passes a NULL Tx ring to
igb_txrx_ring_disable().

Only disable and re-enable the rings the device has: skip the queue if
it has no Rx ring, and only the Tx part if it has no Tx ring, so that
an Rx ring using the pool still stops using it.

Tested with the 82576 emulated by QEMU and a zero-copy AF_XDP socket on
queue 1: closing it after enabling a VF no longer oopses and the Rx ring
no longer references the pool afterwards (checked with a debug print, as
QEMU doesn't spread traffic over the PF queues with VFs), and without
VFs queue 1 keeps receiving after the close. Not run under KASAN.

Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
Cc: stable@vger.kernel.org # 6.14+
Link: https://lore.kernel.org/netdev/20261116153041.3002666-2-antonio@mandelbit.com/
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v4: also handle queues with an Rx but no Tx ring, as with VFs (Sashiko):
tear down the Rx ring and skip only the Tx part; tested with a
zero-copy AF_XDP socket; subject was "don't disable rings that don't exist
..."
v3: new patch.

 drivers/net/ethernet/intel/igb/igb_xsk.c | 37 +++++++++++++++++-------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index ce4a7b5..3b4212a 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -31,15 +31,22 @@ static int igb_realloc_rx_buffer_info(struct igb_ring *ring, bool pool_present)
 	return 0;
 }
 
+/* With VFs, the device has a single Tx queue but can have more Rx queues */
+static struct igb_ring *igb_xsk_tx_ring(struct igb_adapter *adapter, u16 qid)
+{
+	return qid < adapter->num_tx_queues ? adapter->tx_ring[qid] : NULL;
+}
+
 static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
 {
-	struct igb_ring *tx_ring = adapter->tx_ring[qid];
+	struct igb_ring *tx_ring = igb_xsk_tx_ring(adapter, qid);
 	struct igb_ring *rx_ring = adapter->rx_ring[qid];
 	struct e1000_hw *hw = &adapter->hw;
 
-	set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
-
-	wr32(E1000_TXDCTL(tx_ring->reg_idx), 0);
+	if (tx_ring) {
+		set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
+		wr32(E1000_TXDCTL(tx_ring->reg_idx), 0);
+	}
 	wr32(E1000_RXDCTL(rx_ring->reg_idx), 0);
 
 	synchronize_net();
@@ -47,24 +54,27 @@ static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
 	/* Rx/Tx share the same napi context. */
 	napi_disable(&rx_ring->q_vector->napi);
 
-	igb_clean_tx_ring(tx_ring);
+	if (tx_ring) {
+		igb_clean_tx_ring(tx_ring);
+		memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
+	}
 	igb_clean_rx_ring(rx_ring);
-
 	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
-	memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
 }
 
 static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
 {
-	struct igb_ring *tx_ring = adapter->tx_ring[qid];
+	struct igb_ring *tx_ring = igb_xsk_tx_ring(adapter, qid);
 	struct igb_ring *rx_ring = adapter->rx_ring[qid];
 
-	igb_configure_tx_ring(adapter, tx_ring);
+	if (tx_ring)
+		igb_configure_tx_ring(adapter, tx_ring);
 	igb_configure_rx_ring(adapter, rx_ring);
 
 	synchronize_net();
 
-	clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
+	if (tx_ring)
+		clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
 
 	/* call igb_desc_unused which always leaves
 	 * at least 1 descriptor unused to make sure
@@ -148,7 +158,12 @@ static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
 		return -EINVAL;
 
 	rx_ring = adapter->rx_ring[qid];
-	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
+	/* The stack can know more queues than the device has, e.g. after a
+	 * fallback to fewer queues on resume: skip the rings it doesn't have.
+	 */
+	if_running = netif_running(adapter->netdev) &&
+		     igb_xdp_is_enabled(adapter) &&
+		     qid < adapter->num_rx_queues;
 	if (if_running)
 		igb_txrx_ring_disable(adapter, qid);
 
-- 
2.56.1

