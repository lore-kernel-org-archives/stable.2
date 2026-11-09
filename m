Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208844;
	b=l4WDGa80SKZyEDsZx6FdRx19dT+ix6eEmWj4LNdd+Do1bfSnAJUFWBnkzjMxq0kEGZ5X
	 gctA82035SB5rl393ITZjFRWXGQthr7ATJV3voq6lvfLLcGdIaP/wbIDCwjX09T3nHjlk
	 kU08a7PL7putTvYkGZ5NHJfZXD+/EyFV05ebRgOxUmnLWtQ+4N9eTjeimjyX2PpXLdyk5
	 MRT8B5SZmIwPshC6coE7Fx69fqxVyBtVWy9D4kfvhMJNqZjoBns6M3cNLowP4n7+nql1Z
	 IbNK9B9mgFA1ttPIhmJM5eYoj+ZqxrhWxUoHGdmzgoeOAGcVLa9Lsir3GXepXgmrfww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208844;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=GVwWSKal3iXbzblN+Hu1mhM+A6wl9rFOvr8YQ74etMQ=;
	b=Mo4ymnu/yOIhCHqPxIuYNo7lyFeZiD3Fd/e5mBlNsqzHXG4RO1zx5RXCrK/8DVYwFMfz
	 Jwn+8LIH/5AlGqGMwyFibPiWQ72p4wHlQ+7NSOUgcFshMllt2f0z2GymuuwFcRAs1xuAI
	 dMj+5SuXXnM01im4IICrHHY7Zwwg6G/qpvJAcJa9hnCmdW22PaMrNNmp9rj+R4q+49mnS
	 Ss1HnDdmd9Z4Pexdo1lm2spNhnDeXGVkVJ4ubt1ayJhC4Q7O6y9b8Hb7D/lyslq3b/ujU
	 g/ial+SOBP5FYNh2lz30QfG5Ly+WVDDctQYCRBy83nPFbJYCyI1VicIbd4WM1irTLsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ugreen.com;
	spf=pass smtp.mailfrom=ugreen.com;
	dkim=pass header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=TR01lEjD;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F4606A31C;
	Mon,  9 Nov 2026 07:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B91F4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ugreen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=TR01lEjD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1794208788;
	bh=GVwWSKal3iXbzblN+Hu1mhM+A6wl9rFOvr8YQ74etMQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TR01lEjDD4CLanbbnLZ7COjyRE39i/n+4a/26DIxX/Z7B/0oscRuUuhRbs992Zc/h
	 dzc4Af6FLJ+CMY2GrCOirmhf1Hudsos7O7c7HVDoBFi5dt47MUr7kZKR/cTT1Ay1Nz
	 wXRTpwjWv1aOEwY7yOj90ez+OrZp1n85un4HeUSM=
X-QQ-mid: zesmtpsz9t1794208782tb4ebf74b
X-QQ-Originating-IP: p4cAuPFKI55tTzMJVZck0LbArBgePwNZFHd73RgI7yg=
Received: from exmail.qq.com ( [183.16.164.172])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Nov 2026 15:19:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10623556745565743260
From: Hanson Wang <hanson.wang@ugreen.com>
To: netdev@vger.kernel.org
Cc: Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: atlantic: stop TX again before freeing rings
Date: Mon,  9 Nov 2026 15:19:35 +0800
Message-Id: <20261109071935.2945421-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OU1KiBGGGpgtnj5SbHJeE7WV1/c6yZNf2IP20KtJRU6zE5Q9q/k6Ubx2
	e69JJMdt07/bm6jso+Jugxk3DOfFVsh0q2RDFO0p4EhklvANewpZJ1bW+UL8UriJpAFjbk2
	5nOfQRch/QPUog2tyBv64Jd6hH9kbc/4j3aOUBOhX07v4GpRd73DBreGuttWEIiZBHeDM8N
	wLr/DDPZIKlehOASGXV1Kw74mVJfpcEHU1WpPwpb80XjFTzwP09LE9VshNHIxBnOFvTDKtE
	/Mcx8FNsYmua6AoghjGj2VcER79mZ551edw8Vw7DqDfPVE9KHmQ9AAdXe20eZRtYSMdZUbm
	bvaTwIjaxzXt/ke5HO1DNEBeNQe6DRicLUZ2w9xc0PTUU1hgIFgF3cRhROISxY1ds7wVWad
	iEThMVF9iJNJngK8//qNnexMJZwDI0XvsdeUzE4aR/bnluLsQay+9UdbiDs/jdh4Eygfa74
	m99U0B7PZWqFKdSWDTXGIAgzfkSjFRNw3fwGrCx2E8NYzRKbf5SBWCKztsATX9b1vHq4Yx3
	uWW8OCp+9v5mrPIKngZ53x3DRf0xo8LBIgE0+N19OfCa84uIWlRW3X4JGnMEfoDXQutQgBl
	Vj4HcUXKbps5iCWw/g5JLqRix8g7+yUhjOopufdju5tJ8wfeSqfo/dwkVCiYz6OrmKPPGYA
	7sPnIX5aLmJD4X1yjP2twe7z8FOzKwouuIh0OUDVbS+IQkjMl1v3IUynQZAW7CF9bZl12to
	Iwr81PMwSrrCg0HexPPla5e3lD2NNWngeNJJELrzhNtCMS0khYBQEOy+LHjmE3ZCNajFq9J
	8isBOpRAgaT4TMg/WsPUmhCfRcAL9aPYURAJ5b0KS7dAaz6e+f3IS7I2pn2AlT06KLbAcqI
	ta8wvr3+49iQRIO1j1HoZekDKctzAO59Axr/C0RLGnugkobud8Qa0VWfXuX89J/QSBucOzn
	gU+GAvyQOBrxoKkb97M7D4o5sc3tsp/RsZn61/MwJYWf67jV68fprMNDIAfh5UjeB6DbEFd
	W4zVhc9xJWmudpA1bYJynMVhNueeEuMsCR3PjGNbMgPjE5w+L7
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

aq_nic_stop() disables TX before it cancels the service work, frees
the link IRQ and disables NAPI. Those paths can wake the queues again.
ndo_set_features, ethtool ring changes and XDP setup call
aq_ndev_close() directly, without dev_deactivate(), so a re-woken
queue is still reached from ndo_start_xmit while aq_nic_deinit() frees
buff_ring. An IGMP transmit on a UGREEN DXP2800 then oopses in
aq_nic_map_skb() with buff_ring NULL and a non-zero sw_tail.

ndo_xdp_xmit can clear that stopped bit. aq_nic_xmit_xdpf() updates
the queue state, and a drained ring has enough free descriptors to
wake the subqueue. The device stays IFF_UP across this internal
close, so a redirected frame can wake the queue after it was stopped
and a later SKB transmit can hit the freed ring. aq_set_ringparam()
then frees the aq_vec that embeds those rings while aq_ring_tx[]
still points at them.

Close an admission gate before the first queue stop, and publish it
with smp_store_release() only after the rings are initialized.
ndo_xdp_xmit holds rcu_read_lock() across the ring lookup and the
transmit, and returns -ENETDOWN while the gate is closed.
synchronize_net() runs after NAPI is disabled and waits out
transmitters that already passed the gate, including those that woke
a queue. A second netif_tx_disable() then drains SKB transmit before
hw_stop() and the ring free.

Fixes: 3aec6412e007 ("aquantia: Fix Tx queue hangups")
Cc: stable@vger.kernel.org
Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
---
v3:
- No code change. v2 was left in Changes Requested by mistake.
v2: https://lore.kernel.org/netdev/20261104062716.4096311-1-hanson.wang@ugreen.com/
- Gate ndo_xdp_xmit and synchronize_net() before the second
  netif_tx_disable(). A drained ring otherwise wakes the queue from
  aq_nic_xmit_xdpf() after that stop.
- The same gate keeps ndo_xdp_xmit out of aq_ring_tx[] while
  aq_set_ringparam() frees the aq_vec that embeds the rings.
v1: https://lore.kernel.org/netdev/20261031032308.2991494-1-hanson.wang@ugreen.com/

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 42e0fe9248f288fb052fc0372f8907e4b7ebf501..e791ed18f1cd69ff7d0ca6fb0efcd6396a541415 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -597,6 +597,8 @@ int aq_nic_start(struct aq_nic_s *self)
 
 		netdev_set_tc_queue(self->ndev, i, self->aq_vecs, offset);
 	}
+	/* Publish the initialized rings to external XDP transmitters. */
+	smp_store_release(&self->xdp_tx_enabled, true);
 	netif_tx_start_all_queues(self->ndev);
 
 err_exit:
@@ -1428,6 +1430,8 @@ int aq_nic_stop(struct aq_nic_s *self)
 {
 	unsigned int i = 0U;
 
+	WRITE_ONCE(self->xdp_tx_enabled, false);
+
 	netif_tx_disable(self->ndev);
 	netif_carrier_off(self->ndev);
 
@@ -1448,6 +1452,17 @@ int aq_nic_stop(struct aq_nic_s *self)
 
 	aq_ptp_ring_stop(self);
 
+	/* Drain external XDP transmitters that passed the admission gate.
+	 * They can wake TX queues, so wait before the final queue stop.
+	 */
+	synchronize_net();
+
+	/* Service work, IRQs, NAPI and external XDP can no longer wake
+	 * queues. Drain SKB transmit before aq_nic_deinit() frees rings.
+	 */
+	netif_tx_disable(self->ndev);
+	netif_carrier_off(self->ndev);
+
 	return self->aq_hw_ops->hw_stop(self->aq_hw);
 }
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.h b/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
index ad33f8586532b859215cc996aeaf1d662babd97a..84ac097ba12405ee257759cfa2241ec8a5ffb37c 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
@@ -136,6 +136,8 @@ struct aq_nic_s {
 	unsigned int packet_filter;
 	unsigned int power_state;
 	u8 port;
+	/* Admission gate for ndo_xdp_xmit, drained with synchronize_net(). */
+	bool xdp_tx_enabled;
 	const struct aq_hw_ops *aq_hw_ops;
 	const struct aq_fw_ops *aq_fw_ops;
 	struct aq_nic_cfg_s aq_nic_cfg;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index e1193c6719d9d6e01ad95e3b80950b70a88d510f..6ff916fe25e424a2e0da44f11504e53e48005d47 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -19,6 +19,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/rcupdate.h>
 
 static void aq_get_rxpages_xdp(struct aq_ring_buff_s *buff,
 			       struct xdp_buff *xdp)
@@ -422,6 +423,14 @@ int aq_xdp_xmit(struct net_device *dev, int num_frames,
 	struct aq_nic_cfg_s *aq_cfg;
 	struct aq_ring_s *ring;
 
+	/* Cover configuration and ring lookups as well as transmission. */
+	rcu_read_lock();
+	/* Pair with aq_nic_start() to observe initialized rings. */
+	if (unlikely(!smp_load_acquire(&aq_nic->xdp_tx_enabled))) {
+		rcu_read_unlock();
+		return -ENETDOWN;
+	}
+
 	aq_cfg = aq_nic_get_cfg(aq_nic);
 	vec = cpu % aq_cfg->vecs;
 	ring = aq_nic->aq_ring_tx[AQ_NIC_CFG_TCVEC2RING(aq_cfg, 0, vec)];
@@ -433,6 +442,8 @@ int aq_xdp_xmit(struct net_device *dev, int num_frames,
 			drop++;
 	}
 
+	rcu_read_unlock();
+
 	return num_frames - drop;
 }
 
