Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793861980;
	b=fgiK1ff7QmrXY9b4nYugpa2CgRGQ0X+ncFbOc27e5mw6PgWCopEoLb1oByLgkMU9OmBF
	 Nwcmd0CZ7ZcIMcwVKRk2bsvkYvgkX5GzwO4eXIlbzwUZpDiAymRGCL1PfXw1IYZo4/bXT
	 c3AXzmBzaU1JhNAuTBHiZzeCIJ4eMSPh33siPlzL31/4TWDRGrynd7AxlJLhi3+nTo2Tq
	 aoIt9EJ7xEBOCrlRTaAL6pZ8+l11tuKTjSSdvNt5I2wgBUNGBuUWeHXRTyVBv1VVkgfGH
	 V+gZrkilH3wDl0h5sFLfVHFsusA3A2P6NO7F1nEQ3A5+SSMCammQdfix+YLb0Hu4pcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793861980;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=4YRZtBy/ufsiguFB9l3I5NzFI40FHV2N7HDeJmgHUcI=;
	b=Dvn1S2XjLTlER2vu+nu15Zoa0P3+qKnRH08lSj9ImMuWpeYIYQGFq08kFG5PGhrT5it9
	 ZwXOcd72GHBwfIZU2dTnr5UtNTRbPmGdRNJwVcJWbdYl1wvACCQNc3bDQadZIxafcUqOf
	 XkhZ40Rj1/piu9ByvA7Z8iUJ3+qi7JyBCh7JUCweY1d1PKMbojGS7K5RyKd+vbXajwRGE
	 JnfFNZ83fRcmBa/Jl9OrCcV5V2+ohvtkA4RxgexngAxfj9zNuqwtxANddzTtvJ20KuRG8
	 8rxVojJfWC+njMnFQdRwVk79rAHQ8SEFW5rwoS4lDVTxpva+Fy1YBbDsqgB349/kOvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NpKam+Zp;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED9606A33D;
	Thu,  5 Nov 2026 06:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34ED9606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NpKam+Zp
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4YRZtBy/ufsiguFB9l3I5NzFI40FHV2N7HDeJmgHUcI=;
	b=NpKam+ZpaO5jIgt9EYzx3Tj4OgHjXqsjBgC4YAYB8LY3gC1GzVa9OrhsSoK+xqfJMwiPI6o7P
	TaaYQvEGzv9s/sgnhuhsn8gMMXs/5f5YROfVgEcYCxtJpAt+kzGR8wtd5EQufL+gPFiZGoh+Mpq
	ZtJPXOTIrPIe6cnGoAcx2ZI=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jKtT648vrzcZyv;
	Thu,  5 Nov 2026 14:59:06 +0800 (CST)
Received: from kwepemk300018.china.huawei.com (unknown [7.202.194.246])
	by mail.maildlp.com (Postfix) with ESMTPS id 020EA40561;
	Thu,  5 Nov 2026 14:59:35 +0800 (CST)
Received: from huawei.com (10.25.63.231) by kwepemk300018.china.huawei.com
 (7.202.194.246) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 14:59:34 +0800
From: Sun Yiqi <sunyiqi2@huawei.com>
To: <robin@protonic.nl>, <o.rempel@pengutronix.de>
CC: <kernel@pengutronix.de>, <socketcan@hartkopp.net>, <mkl@pengutronix.de>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>, <luoxiaoxing@huawei.com>,
	Sun Yiqi <sunyiqi2@huawei.com>
Subject: [PATCH net] can: j1939: transport: validate the DPO packet offset
Date: Thu, 5 Nov 2026 14:59:31 +0800
Message-ID: <20261105065931.1302-1-sunyiqi2@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
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
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk300018.china.huawei.com (7.202.194.246)

j1939_xtp_rx_dpo_one() stores the packet offset from a received ETP DPO
command without checking it against the session's total packet count.
An offset greater than or equal to that count makes
j1939_session_skb_get() return NULL. A subsequent EOMA can then cause
j1939_session_completed() to pass the NULL skb to j1939_sk_recv(),
resulting in a NULL pointer dereference.

Reject an out-of-range offset before storing it and abort the session
with J1939_XTP_ABORT_BAD_EDPO_OFFSET. Keeping the previous valid offset
also prevents this lookup failure if an EOMA arrives while the session
is waiting for the abort to complete.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Sun Yiqi <sunyiqi2@huawei.com>
---
 net/can/j1939/transport.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..bda50432a72e 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1823,14 +1823,22 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
 				 struct sk_buff *skb)
 {
 	const u8 *dat = skb->data;
+	unsigned int packet;
 
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
+	packet = j1939_etp_ctl_to_packet(skb->data);
+	if (packet >= session->pkt.total) {
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);
+		return;
+	}
+
 	/* transmitted without problems */
-	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
+	session->pkt.dpo = packet;
 	session->last_cmd = dat[0];
 	j1939_tp_set_rxtimeout(session, 750);
 
-- 
2.51.0.windows.1

