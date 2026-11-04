Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.34.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773777;
	b=kc99F/KTITY6uH/bQplTfDawc9QfE+E9U4Zmmk/lVlGrNIqM1neH82Ls9MsD08eF/pE+
	 EL20y1PzDHAHAC7pDRNGcOvinVctIDHpawiNkQcTD/3xXxzyTWxGJB8wM1dOMRcF3LB+k
	 5drZcllFhfaH0X3ONgHmhwJDvrURLaLXC6tTDPX1HoS5HvBfreVghxseDnOurta1rewzX
	 Saeo9yTObmmmwTTgb8tU8MImFHP/ajP+IIQr5K0p2LEpxhZd2FfVBg3CV8RuOvLRP//Br
	 U6FxUt4Z6Rc6B7KZf5zpxtxJuUL20aO8IYxqMSf7T/6Pe1Kly+udbDnzien+rF0MNIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773777;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=/EDAekvv6SOFhSAiVUCZAuo8sFPKNNrY39scEMWh7v0=;
	b=cRls6eCWyvq2AsYsy/d64Yu/HnAFXl28UJLiUCjkKuUjqXUat5QzRkOY0YNOIwqJ2TYt
	 t+ShbeeTrB4YIOKcC2mKsvTtTTaDEyt24k2Dtr3ZIeyp/0o5PYPgK/Tlh5aTtCw3zT8JX
	 h2JXLqgkb2/Z4r+YTrVB886S4kpCFVYFs/kNNHVgsR7TW93JmLn/AD6cpjuyiG25hr4TF
	 v6+kuXVU/xFyO1cMTrf4+8x0qkdGtFQJEouXWIfg0oUt9MvLX6lNyeiE0ZWF7GL4YhUo/
	 tDTGmDqXF5SWat0Co7gDHm/e70Q0ffSd21Z5zkf43G41EHVfSYbnLZpzFmch0mkTyKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ugreen.com;
	spf=pass smtp.mailfrom=ugreen.com;
	dkim=pass header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=gsM6ZAgl;
	arc=none smtp.remote-ip=54.206.34.216
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC260606A31B;
	Wed,  4 Nov 2026 06:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC260606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ugreen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=gsM6ZAgl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1793773653;
	bh=/EDAekvv6SOFhSAiVUCZAuo8sFPKNNrY39scEMWh7v0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gsM6ZAgleoRJo3Ebm96DHPoRuYnvEil06UrL2RmXz82fPPEDJsUQ/tHY5d4MtunQC
	 cu23k14WPmqS+TJ/qcSdq9H7P2BOtHwvFeHg3zw3Y6Nl1z/KDiHeJNqfuWJ5UJt7I5
	 izwoNpbZTTBbsm8lFbZjyig0r8Gyv5EPg+o8KUyA=
X-QQ-mid: zesmtpsz9t1793773647td70dc338
X-QQ-Originating-IP: hz8DxLdlYCmbVq+n8DsgpkSivBYcU4dslfPbInxqbOc=
Received: from exmail.qq.com ( [113.89.160.251])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Nov 2026 14:27:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13180092541732606942
From: Hanson Wang <hanson.wang@ugreen.com>
To: netdev@vger.kernel.org
Cc: Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: atlantic: stop TX again before freeing rings
Date: Wed,  4 Nov 2026 14:27:16 +0800
Message-Id: <20261104062716.4096311-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031032308.2991494-1-hanson.wang@ugreen.com>
References: <20261031032308.2991494-1-hanson.wang@ugreen.com>
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
X-QQ-XMAILINFO: Mn6sU2dhbGGPRr29PgdKsq836CaJmhNFvQytNHLWO3P3YpM6UvdclIvl
	clHfHounljqlsYZEgYlVHN7TTu+nyboq/LP2ivRVAzLsJHARrciWPUB47ILu3/BMwpWn+1y
	ZqiyBmMdr/soqXiwlxHy2C5AdC4x4PkTY5ZF2pwzs1TYDoffUsZAP/3fL8ak3NhSRE1yvkp
	aS5zDlys0ntVwk2xRKgNnAAe8Nz9gYeVKyjELpI7C7EL5178XNdJU3LB201xApw0fTpFLg6
	y6S9SUtC8MGf4cMLulqbFFUL6IEX29HUgIebdatRUsCdeK4mC6J3sWP2p0ty/jrxw7BLvRb
	U7GyIrBKO6ACyEHsyuZlaZ5rEJxSfoXHLVRRYEp7WPch/SL6noAatevi+fDk/zSnApvuFfZ
	COTIhnMr8552ikzS+s9BimF3p6MIqGZ9/fjhm6hSBFJAgkCbkBP4FJsDTRl3A2PRf9TvxHV
	NuehKtQw+ta/UIOmMsX7KqYcDfTWQQbk92hWB1CNi7hVoN7CVJZhNcxN9Z++UGbMLPD3Fbq
	wKVQUY+oHuTCJNOefXqGEmSyDTcyl//5Rx3s9VZbXP8gECikZO8oRFkp3MrOPkOBCIMMF3l
	/hfs5DZim7KGp2YTqsOro4JyYR3Lzw+u99JqlGAHtfXtydNgQSMZTZA1Di8kas2zavCrIhJ
	T9mNIsx3MDlyzaNnjWcn3SVQrqfIsR/FmJ8XEOn8q9DHt5zCffL02ExMRo7DsgmUOcGf/dy
	fQY8BunKYEFqIGLS2cfz/cGdI7GswBOEIiIcjfoOu+bBwlURmnP1UtyGRjkyHEcSQx8aNfX
	jD41KAk5GrYWAfly49wUubYCNPHtCCDBJu4rJEzrdjyADAOldyNT2G/GobaSOWYJuI7mLKH
	bQMsaW4GY/Ay/e9XS22nARfjSu96whbVsjY2etxy7mA4v2ntuQAkgrnExcB8oAd9FwrGUCf
	HamChj5Cu9ZA5fiaWxnEANc36C6e7HtMl4F6mlhgCc8sBGmK39LUnMPMzBReZWInZHPcj6g
	fBnpEqMbLCdfnIsU9j
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
v2:
- Gate ndo_xdp_xmit and synchronize_net() before the second
  netif_tx_disable(). A drained ring otherwise wakes the queue from
  aq_nic_xmit_xdpf() after that stop.
- The same gate keeps ndo_xdp_xmit out of aq_ring_tx[] while
  aq_set_ringparam() frees the aq_vec that embeds the rings.

pw-bot: cr

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
 
