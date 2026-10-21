Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624303;
	b=hB8pAs/QjCSKh8Zd5h36GD0nbyxSEVmsss9ZTTD00WAxZPjFDL6ImlSwunvjuPDezB21
	 IGpeFAEtX8yP4TbzYReQg2Rfabv9b6yhlrwXUKssH8lAh6E3wYm33q4X7YIghg1Oq/Mf0
	 JYt59fYxxTR6ADua6eb6IKv3je8n/WRuNjYPUvf6eaanNuDqBgeW6SrbEYxvVoIInK+Og
	 E5yKUU/i/MEaFDMA0L0ASW6QmXKpybcYkPsFVNUwFGQkZosLzYyfztX8BEA/7hwv5uYsw
	 y3W9ehA+khrqcfCoMrs4Gby9vAShp6cJAIPT7v5oR0+Ce22dzKVTsEHUWXgLUI38bFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624303;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=2itaPoNH+n5XOAkiT48AavHAAw1rub5CfbaAdFY6zhn2RQHPS9nn/a4NN+XWUV8TPvxA
	 PGtXGy/jUvzH9cAo5L3dgx53deaSsVGkaXd7V67Xbcre6aksy2EtjvsY29kbPe8gKQbmJ
	 yp81rpp2Qaj1kAJd50hjheFTAln+5KpGSmi9epsfAOlNcjRAQTVUpitFULcBUm+e/AJJm
	 bV6ryTvKd9hHB3W0n8Y33UbVD6emR5q1QKi0yPXIBGH7rmSuCiGqa72V64sHK3lyq/W9R
	 HHb4d8gG5IoSSpvaeb2eISYiGSPriTslKLfay1n5GspBHH6dYjLfTeTyxen4LqGa41Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=TYFL9IT1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486D9606A321;
	Wed, 21 Oct 2026 23:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 486D9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=TYFL9IT1
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C6E36201E24;
	Thu, 22 Oct 2026 01:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=TYFL9IT1ogveCgYhE6+4IWozsvEyf9YgGieoOWJJIUGq0PfftqpwScXU1USUP4qNOEym8y
	nLMLsypBsuF3kjLcX9f6RmNPztUkfuUkyJ8TovCATz0Mq4AqmSp63dnwAN2R3nwpnlwyXk
	LL2RcmIH6Eub/3c0iF+TPjERADuygZkho8aQna2OrgOw8K0LtHJLIurF1/InJJUbVhmWZH
	Qjy//kuYoRozEgYXXy7K9ELFIbptYbEQUuq6b+qLheOEp/5inL4Lg2ROnDFtiDVXgBJ5Sm
	LceTVrPhp33aad6qzKyfQEUL/bM8lkIPXAeh2ry+tjhMTNvStgv0OVA0lA51ZQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792624297; a=rsa-sha256;
	cv=none;
	b=KRoe0by6Mn7zvIRArCyRWaFWUbQsNC60cL1Q15CTrnWig6ADVebQCXWMRZL71ElkLBQqqT
	de6TsyBh147D/NmBlKDg2l/GxIxWpAA4ecUpeAu7Aqe10oal0iHQF4E+RN01NP0KiFtM5l
	XMYFTzLytpL+FNCrtiGltXSyHsxXBHdyH/nO8zThNQ81D7ZUl5/VthGTr3aZSZHujQFHDm
	rff8Ex+PSsTvnU4OhpQ53zp20q3Gckf7MmW8LguA9zW7IjlX4//HfzP3FLPFS6b3YwKFxR
	A8tV6kkLMY6Re2mmxNKzdsRzJy9/j11ZqkcO8okvKvvg+I8GpF8HFquPatX/Sg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=XuCWxoBPPi3g/rwLGMn0YEoH9d9U+BjfCJdkR1ds342WqGA51dDyqJUbMqppeT7qznNJKT
	kRiOAKfVCPjQuPC8fyNT5muOR/t+rUATB9L7iIcewMFU8BRsogeTSz1V/Symc3K5dz7UBX
	RhRPOO256QV3cELwrJF0D7eNyz1/kH0cr5JpO+wRQDm5C47FsyuW4qA7/nM0vwBwmQ8ktB
	nF6IVFHnuAlmqBWID5QKoNsezLlkfuga+3j/LB1LXxcaICkXcMINJpwRBHKpIzFq6ffkT9
	0w6v8ygyvpjfHYury+UbOE7pxsHVTYlskItSdWIjv/7Uuxd0g6OK++/jBzTvXg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJfT7-000cWX-2K;
	Thu, 22 Oct 2026 01:11:37 +0200
Received: from blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 15B2F5D06DE;
	Wed, 21 Oct 2026 23:11:37 +0000 (UTC)
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
Subject: [PATCH net-next 09/11] can: dev: can_put_echo_skb(): free skb on invalid echo index
Date: Thu, 22 Oct 2026 01:07:56 +0200
Message-ID: <20261021231130.2085690-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021231130.2085690-1-mkl@pengutronix.de>
References: <20261021231130.2085690-1-mkl@pengutronix.de>
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

