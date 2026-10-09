Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B84E1C78;
	Fri,  9 Oct 2026 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553420; cv=pass; b=hStdXFd9MTuAPPD0BerXoR6kIbjzuoo+xEFyTEjty63kj3C5UYtaBxFA9uKyNjzBnlww8CoL+nw3LzIHj7IRfqNFCSwP9v1VL3OAMaosZ7DRdqbgnnRu7kgeiL4RtO6Y3H4FG7H4JzlhtOVVscqZoCav4zMpJSM+z6QIeNq7qX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553420; c=relaxed/simple;
	bh=g2FMKl/lBmFvFo3Km5VSg4ir60Zngr53bIY6J485DyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoOn5jC6c3v0fdGlqV2n7GUZb5tCA8ik0WqlWP/YsQ48ML8DdCVFRDH8otQkYMik6ZbP4t7IcqnCF3DfIiy95fQUDy5f2LaU/lH73AqRN+AyaOmXIfhzNCQCfMZau0WipkzV4xNyvE8MrT6oJ8FicSVPbRmg9jUxhtnvEytB9W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=dPnURIzC; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="dPnURIzC"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A4848202626;
	Fri, 09 Oct 2026 15:43:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=dPnURIzCBvv2dqfOSeHzOCyWFArVzaHgGbmdxa/WDDvp2g872SEMOcl31FrdlUgsFHfjmk
	Fa+AJEiF0sd55yj7kgAFpY9IDpYAQre+auv0PjuSLqxW1jYZC9fcEjuIuetBpxFfO+V9wU
	vwIOZG3gSYO6S3xNXMJ+t2aGFY6J1qmRkr4Ye0r1wnGIjC1Guq8f7DA6OpV2iosVV9CTA/
	rCJC8lF29Rox3QhDBdTEjW28snd69b3kyO3O4kzy7O1lFn0x7nePgW4FwNzoupXBjPVTXG
	hdcNCI6BMbHUlprUkSQSBzBAjL5fxl02bQxfJ9mfv7avDFQXMBG1fJJDgrnMzQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553415; a=rsa-sha256;
	cv=none;
	b=ClUao7EJZtQLCU78JsC6+ePoci60R53cnbnEmZWt8ytaeeAtL+r2zlXYjGv3qf8gUh5Nji
	AC+5P6qcUigZ0mmSF/Fxr8sHIvmmydOL+trPdRczgFq4l1iITXBKvWSRhrKIVqZrlocYye
	GZ07LaD5HCW/lE3Ll1YI9dPjSc3x0J+7ukTbkeVUX0516fF10Y3JG2d8KwxeVdfin0PLn4
	rPEIDcGqCnjHOHocV4sk3h/6kNRHPwt79phI7Lvn/6j1nWNfaCH+B7jtggyBdC7Hs1+i14
	lPLFbouju9TAgudJ8ojQN22ow8PIaTv4by5wHvaM/fUUMyerre715U+RhD2Jew==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=T6SusiKYTVr1+mBg3tmVc2cy6X6earNWFrZHNv4/X7ggrpoveTPxoEC+9RO6sRydq3W3hY
	IzCVhM7k5ZrVzTqeXq/8TkACXEoq8lV2NTrzjp1cn8CKbwfwHdjxYu/ofUxfaO72lrRmqV
	bMDlwzSbTUl70zg6DeLBgJ5CgT+OmhvRwZZ7j7Z06vkNlMa5inTqDAFPU69wEM6JKMuL9O
	wjJtd9h1Qrrtj8cE1omwq1t9HTluzw6fCD4UFQIkXzo0Rlzjj62KyPqd2V98iksCLNllv9
	wlelUUhzEVI+9bskKb4hZS3calGbVrmLDd51RjIknlJcczQb5QAqwldeJM+XwQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsp-0053SO-1q;
	Fri, 09 Oct 2026 15:43:35 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2971D5BD8B9;
	Fri, 09 Oct 2026 13:43:35 +0000 (UTC)
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
Subject: [PATCH net-next 14/37] can: dev: can_put_echo_skb(): free skb on invalid echo index
Date: Fri,  9 Oct 2026 15:27:46 +0200
Message-ID: <20261009134323.64064-15-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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

