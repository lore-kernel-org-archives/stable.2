Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738602;
	b=UUHM5t64XvTDJr2j7KTjDEkumtYNwG+pZDRFDNuBsdODdndXBp6kcaTHGrbrP0Gt+8M1
	 An4WuEXllah0nTqxZoe0RzEExHaCRrzSyk+PfkGaNnZLuDHhlGylf3A3ERJPIxgZ/bMSb
	 R+ShFUUUHE/AX03WA9EdRVqvOopeyp8sb34DZ2W/eM9IB8Rd/++ZZrwqKnfpXZhsRRk1s
	 6id86jeoLVgTv2szOS689VtUitBVLN6qtLZQ/E7YYGQoPfMpq3pEUS/3wFeG2SR3PMD8w
	 OV6VdEkHLgcIv7RQSpvPBfRRS8+N4SNoJctuw33B14E9hBtSQlHg8b+HKJ15pPbwfiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738602;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=0cFp34I+2MfN+g8gsllv219XBUtN/CTQbkNtM/VyFAzeY3frpvwCtKbatV55f4rcw9kc
	 Du7TOv3fP3oQvmclVMPM2KYg7hR7cCf/t4DUCHS5Iat3vGH6eWQfS6ebvMHW6V8asxubZ
	 5KAd2e6b8+BgqqX1DHM6tKBao4aRRmUgivAgZw80M4Nt8JmdQxe7bjy9ahO009xDszokr
	 kVUJdWnB1T+Bv/85n1zMLGMlIJ05g9abb7ijp8TAHYyQWo1jLnsPlhr0wBuIjP3exWjyQ
	 4fj75tIBe03KBsVgZzBviG4F1MtPWBErAZUZFLQE3jovZUTVoH9ceC+FVPSbcNkgohA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=apHGc2Xz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D928606A32C;
	Tue,  3 Nov 2026 20:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D928606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=apHGc2Xz
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0C380202299;
	Tue, 03 Nov 2026 21:43:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=apHGc2Xz56i5STz0YNvBo674E50m+D2cF+3pODyCNf4Qab3txdwqam8LfJtOVO5f+UMY72
	5jdO/CY+UWDaZ5aK6G6dgjdOHg0hl2wNzNJKuTlR7UiyhJT+sikSPDVn5DNI5O8um2IUvC
	159RuLpUuVphwwJsAdd/vVq52ok3YK5pVazZRMXRHB1n8TfnMNBRCsPeRlKgoTzM3T5oL1
	yJdQ1YCsTyRAghTD2jCxS80L2/ZbA3Unzb7DgpKvyJMHCTEfvlbxTyZAbEFfH1ARs32gQX
	VgtePaLUnWjW4hOh/AzN32dqs2ZEz4UUmmZ+SburGUUW2tWh3pnRwjHYMqeWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=AgnFKMuiqvF+JwNHdNLiN6l22XQC6gT7O+ks0ETVceJYIAR8Rfi72L8kAWSd7vAlT5wyGl
	KPyQtyauwoWUc8CghoM8twsHPdUE5/KFylUj0qGwNmWZWKZrjSIxgKUGtOsVWmcoRW9eRO
	uLVAeYN3av1x1D17gTHkXe3USgisFvai1s44d3DQPcOmwr6OBfWfMAhFpg8F3SOPhzxKWo
	KMc0Me5yAv4tMPR7jppqWsANVzfYA1Ho+WSA2B5nSYDsDRxsHnu+sHZQrrOrqA4eYUGVj/
	VkZpXqL/BrL8Q9D3CjHf/ekrZR5cLhTkYIBy/ak6E/2sl/FAHZRXEQWXNqewSw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738596; a=rsa-sha256;
	cv=none;
	b=OjSk75TWH/Fjqa6sz/pzhr1WpK0SAKxLbmfWjN1ySkPDNLtaOT9OMbt8dXIrTgKclbpyQN
	qNVLPSvYFxHKocPKpeg0UQjVvw2Lo1i/aPOPcIg1acRFqNGCUx0W539L5Mlsdg1gzzLHc4
	hOl2cLxYnOnSsOx702R5nS7bnm2WNp3h+/26XkWitvEebwm0nZPrSZkJ/36Vsu6caElgm+
	A0IeNSecWky6lHxmpr3vvKqy7xxr2O24iDF3XeAPgNZdLW3cY0KfI7iBmfblVpvwYecQEg
	r/x9UhfNBxNTs70ybpxcwQ6qywQ5xByzQXa4nFJ+raO5io2wc8/LaIxa5pI59w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLLf-002V8T-2z;
	Tue, 03 Nov 2026 21:43:15 +0100
Received: from blackshift.org (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A37625DDEBC;
	Tue, 03 Nov 2026 20:43:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	stable@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 05/15] can: dev: can_put_echo_skb(): free skb on invalid echo index
Date: Tue,  3 Nov 2026 21:30:26 +0100
Message-ID: <20261103204305.3211144-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103204305.3211144-1-mkl@pengutronix.de>
References: <20261103204305.3211144-1-mkl@pengutronix.de>
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

From: Cunhao Lu <1579567540@qq.com>

can_put_echo_skb() consumes the skb on all paths except when the echo
index is out of bounds. This leaves ownership with the caller on -EINVAL,
unlike the other error paths, and can leak the skb if the caller expects
consistent semantics.

Free the skb before returning -EINVAL so that all return paths consume it.

Fixes: 6411959c10fe ("can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds")
Cc: stable@vger.kernel.org
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
Link: https://patch.msgid.link/tencent_683AA16E643DE00211CD2FB62991264DC605@qq.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

---

FAQ:

Q: `can_skb_init_valid()` directly modifies `skb->data` without checking if
   the SKB is cloned or shared. Is this violating SKB shared buffer rules and
   causing data corruption?

A: The finding about can_skb_init_valid() modifying skb->data on a
   potentially shared buffer is not relevant for this (correct) patch.

   The FDF-flag write in can_skb_init_valid() only matters for PF_PACKET
   use: PF_CAN allocators already set CANFD_FDF. The write exists to
   normalize frames for PF_PACKET observers (tcpdump/Wireshark) so they can
   distinguish classic CAN from CAN FD at the netdev level, and to
   compensate for PF_PACKET senders that omit the bit. That normalization
   is functionally required.

   The shared-buffer concern only becomes realistic through a specific
   chain: a PF_PACKET sender injects a CANFD-sized frame, the CAN driver's
   loopback puts an echo skb back into can_rcv(), and cgw (without
   modfuncs) clones it for forwarding to another interface. Only on that
   second can_skb_init_valid() call is the skb cloned. By then the bit was
   already set on the exclusive skb during the initial xmit path, so the
   flags |= CANFD_FDF write is strictly idempotent for any parallel
   consumer of the shared buffer - no memory-safety or
   information-disclosure consequence. It's a formal violation of the skb
   sharing rules without an observable effect, so the current code can stay
   as-is.

Link: https://lore.kernel.org/all/54a3cc01-abcf-4a33-b932-39bb1f68cdd5@hartkopp.net/
[mkl: convert Oliver's mail to FAQ section]
---
 drivers/net/can/dev/skb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 3e36c0368bae..738d5968dfa6 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -55,6 +55,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
 			   __func__, idx, priv->echo_skb_max);
+		dev_kfree_skb_any(skb);
 		return -EINVAL;
 	}
 
-- 
2.53.0

