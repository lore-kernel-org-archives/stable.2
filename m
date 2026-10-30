Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368278;
	b=WdwjLc7dKGGx0GU+C1MA7kMI4RKKOJuASatpyV7sVJZ+1lzv6MdArNsvUn79TyhREsGW
	 ZLpKSvjlmDCgIQnOEqxVSzT1hDIqOa4vJfkyjbRgE/FinqoRUIFQqdt0ud7hp2YH1ujtl
	 U0x3Ier5vOH+mbM5Qpu+DESLJ4jJ92QXtox7khXPW83u650HlenkHna3TGVzy4Fftgw+B
	 WMwzbmaGy9Wwc/o8uq6ve+MAW+fmmavXPwV7qPL3pumEeDvegw/WZGMAxVvaf0gQC3MS1
	 6y5qziEyqsBEZj+lU51nJo9kLS0S96ULQkESLbo/1rRkrRtKZTBVGS+F+YGeeVTS7vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368278;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j+2BwYgv/HmQwxVDsQr2KpcBgioUFvA56E1Bh2/W+qw=;
	b=y9LvvIHKcvoKNLBobMMWMvKdZrQKIAnxBMnBrJ3NDBJgasfx08f9wprk5i7VT77byrsd
	 0bMg7EbpmXqpjs4etgxSm5k0qv87B3iF5PbaiuBqTT1+itwinlwohUnQxcOYTCNoRnL5E
	 vMA62ZCwI/SnaAXu9AM2BRn1wc60ERknQJoLva4rFzSo9+XYAjWCcqqpiMzTWnsGfMOk5
	 ImSdDNGUCz3PdyPpvheACZFzvDXnA5Au6sg+oL4FRp7EOrBXCTYQUdZX5fE+z7lOOjz+A
	 8PIx+uxArQ0QIwd6JkpIxXg9ZgYsOl2vIif5nZo3gRqGQBnItXJzJ1A6X1pQ0RfNNfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=KwSSYVR+;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 44E75606A31D;
	Fri, 30 Oct 2026 13:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44E75606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=KwSSYVR+
Received: from kero.packetmixer.de (p200300c597124Fd839580C360D3ed6F6.dip0.t-ipconnect.de [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 52ACAFA092;
	Fri, 30 Oct 2026 14:51:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+2BwYgv/HmQwxVDsQr2KpcBgioUFvA56E1Bh2/W+qw=;
	b=KwSSYVR+j3Ex7HO/kIrM4R7zYbBDwTKPr1USn/mT52jgHfy5cUjdWRQwptwx01McsMWY/V
	6yGRKoU7UiEdaZks0yTW7JeH31M+SBQfH/uXHEPoQWCG1sNC7QSHlcTt3ltVigE4CFa7ww
	wy2+preBNuuFfR6opVrNjeJNJArqZmckXy31bbKvIphzzhC3hk2hOqEekr7Kxu162N7XZ1
	qrTqjQ8aY98rF6qDpYTi8GLTLJmLUQwtg16RVoc6uGlLzJQuP9bmDVmvZrOS76XH2072Nk
	CBEko4Y2AfgdkbnOnHkn9PNuf8fNq2zt9nLwMW/b+FJJeraEvpGcV6YJlG6k/w==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net v2 02/14] batman-adv: Close OGM aggregation before transmission
Date: Fri, 30 Oct 2026 14:50:53 +0100
Message-ID: <20261030135105.2555887-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
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

From: Chengfeng Ye <nicoyip.dev@gmail.com>

The OGM send worker leaves its forwarding packet on forw_bat_list until
after batadv_iv_ogm_emit() returns. Aggregation holds forw_bat_list_lock,
but emission reads and clones the packet without that lock.

CPU 0 can therefore start emitting a queued packet while CPU 1 takes the
list lock, finds the same packet and appends another OGM. The sender can
observe the new packet length before the corresponding direct-link flag
is set, or clone the skb while its length and payload are being updated.
This can transmit an OGM with incorrect flags or inconsistent data.

KCSAN reported:

  BUG: KCSAN: data-race in batadv_iv_ogm_queue_add / batadv_iv_send_outstanding_bat_ogm_packet
  write to 0xffff888100fedcf8 of 2 bytes by interrupt on cpu 1:
  read to 0xffff888100fedcf8 of 2 bytes by task 70 on cpu 2:
  value changed: 0x00c0 -> 0x00d8

Mark the aggregate as full under forw_bat_list_lock before emission. This
waits for any ongoing append and prevents further aggregation. Emission
uses packet_len to walk the OGMs, so all queued packets are still sent.
Keep the packet on the list so interface purging can find the worker,
wait for it to finish and free the packet.

Fixes: 9b4aec647a92 ("batman-adv: fix rare race conditions on interface removal")
Cc: stable@vger.kernel.org # 4.10.x: 434becf57bdc ("batman-adv: Limit number of aggregated packets directly")
Cc: stable@vger.kernel.org # 4.10.x
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
[ sven: drop assisted tag, document new meaning of num_packets ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 5 +++++
 net/batman-adv/types.h      | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 158d2b8f04036..85e99506a53f5 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1909,6 +1909,11 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 		goto out;
 	}
 
+	/* Mark aggregate as full before forcing emit. */
+	spin_lock_bh(&bat_priv->forw_bat_list_lock);
+	forw_packet->num_packets = BATADV_MAX_AGGREGATION_PACKETS;
+	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+
 	batadv_iv_ogm_emit(forw_packet);
 
 	/* we have to have at least one packet in the queue to determine the
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c19caa84e6920..b3e6dbb360dae 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2047,7 +2047,13 @@ struct batadv_forw_packet {
 	/** @direct_link_flags: direct link flags for aggregated OGM packets */
 	DECLARE_BITMAP(direct_link_flags, BATADV_MAX_AGGREGATION_PACKETS);
 
-	/** @num_packets: counter for aggregated OGMv1 packets */
+	/**
+	 * @num_packets: counter for aggregated OGMv1 packets. Set to
+	 *  BATADV_MAX_AGGREGATION_PACKETS (independent of the real number of
+	 *  aggregated packets) by the send worker to prevent further
+	 *  aggregation while the packet is emitted. It must therefore not be
+	 *  used to iterate over the aggregated packets
+	 */
 	u8 num_packets;
 
 	/** @delayed_work: work queue callback item for packet sending */
-- 
2.47.3

