Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792429733;
	b=O8Knw6E9XVHkur9CdNyU9HuYkIhobFYc3SG5AJY/FIHAPm182UkKRdR+pOPCSNK0Iv/c
	 jW7aRFhMLSEmaLioDdEzy6AC+MS02ikQ9mL0kfhJm5gKSbVS0E1y86f4+tfqlnnhXbhgD
	 SpRkLbp9937qloieDaJGlpSGhXRgFFqx3C3hkLZAcWo0RwjtOH7ZCAkiJ1Z8Ma4Kq6DJ6
	 BspjqhdaaeT/K6K5RzFc2YHcLbru6jogel+VxY9VCBc0dJRrgZAt1/gLI2Y+f+q4vx9Ad
	 bDbGgD6ZP+hUERMFKBjLe3CbF0LaW84zgkyzujjh4Gh5f8KaIeOABwF2iQ54ux9TfjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429733;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=S4GkBwu/N1tGPqjqaDrSXKrDAqTNAAotORBDglB3Q1Bkx8u2LzoGRg6ZxmfTVLEwtqEx
	 3bu4I1nU8ID6+YEknE88l0iY32koi09k/ao3j1e0qOomBlk3D8B8MTyhqGsvFosUWqPlo
	 3GIIQXTKqaF9wXa7+G+i8+ZbzYHzCggJWK0IWNj+fE9UFgGjfPhT3e+07jfhsBRR75XR+
	 OsqwINfabsyzSUuK1Rt07KQoHBMJhcwoqZsOR/aYI4rvOn3tkbWRyOBosBeW0U3W7DC34
	 BCJZohZbxt+UYJaeDJpVXUHrG1ScaIWRoX7siDPOsEzy8VbusiB2ymOrcWcrvGgzW5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NZ5Y0xtD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB4B606A336;
	Mon, 19 Oct 2026 17:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BB4B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NZ5Y0xtD
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id F2692202854;
	Mon, 19 Oct 2026 19:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=NZ5Y0xtDV52mc+rJQshfzJL4RuDo0qC5110BtmfFyEuDA8UJaQ98M+k2jL0Zf5nK8pUx/b
	h41iycJ/3/uTfU0oN/PSR53CWpQnKNnDrRfZGgZLIozxKFtjz7QzsFZ7KnCbV0NUuO5C9R
	be3Mj2kWZSXE2ikizTKooqIXcvglWxNB3ZxTEOSUsYbTY3UYYQMfDRekWrHEPrDtb6AqgH
	zFEMDxTvIafJwrKs2aVIag6kShC27MD+CU4gAgp5YT23hUOPSVyXkm9RjTM+9kyEkDT+U6
	PRyV6Rxuixs00bIyxJ9vKbKfkw48Z/NKCJ+89t0O72fpn9tuvg5bq0TgCJtpZg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792429717; a=rsa-sha256;
	cv=none;
	b=NqDe/zZQq+zNlA/6SX2hjc0MsusOtEst9pzD4IWNBOcBaK/sBzz9bVT+N1750IzJhcj+Bg
	8P2bWgEfHU9Ic2V9MPF53bAZyyu9OHdJ3XpwUeFt2IoFi7cXSl6KkxvDKsivEPT3ha45K8
	FMFH/Ip4j121D4NV2Gz5qcHysREDeMjUtcY+R6Xh+UGeiAEynjXs+50PMwTG+c+YFRCfRE
	w4LkD145YufvcKNYCHoP54mA2gVsaXyObjXUBYRICXg5mE8MYEtQ8UuyqS9jqo8L7KBVLK
	qB2iV9pPJoNzGAHMLRTi4NAVQFDsnsxsolOwF1nQR57Tfokteg9YurYBfaZGcg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd5lSezKIyW/9dcGa/xeP6YPWeM5EbHyXW3FSFeJnHo=;
	b=c6mdLUd9/9MjouOi59dL/xp2IjUH/UoZ0cdy0rJcnH/SMzxp1khLnneuanxUhONs8npdSq
	WksowF3/6kZcJJOjqFdPC+8zJNHpj27ItAO7Z7qVGPi117V4B0jJSIDonJia3wIJQxWd1q
	OXW+iSDOSp1+ubd1P/LWJNfOqVncHX5RczoxOvNa4frk8nJoiMMqm6L8Se0is2RJITfXdQ
	08Pi57JeF0HKpftUPR7d92cbgSScPUqJI/3+ZEcxqcml/nULQ20+3f8Pf5Run2HLor6d/h
	3scxRwtgvHikOmZt+lH0hDrvA9pUWGA2uoQkzhDmgOSemGesAH7LOuKXMmfjeQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIqqi-000FgF-2n;
	Mon, 19 Oct 2026 19:08:36 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9325E5C948F;
	Mon, 19 Oct 2026 17:08:36 +0000 (UTC)
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
Subject: [PATCH net-next 05/11] can: dev: can_put_echo_skb(): free skb on invalid echo index
Date: Mon, 19 Oct 2026 19:01:10 +0200
Message-ID: <20261019170834.1727150-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019170834.1727150-1-mkl@pengutronix.de>
References: <20261019170834.1727150-1-mkl@pengutronix.de>
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

