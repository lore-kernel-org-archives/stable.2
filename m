Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337910;
	b=25iIy11j3SVzUrGkkBxgN5m8kDMOtlq1v859HP3OlRPnLjunYEcoNyBAtT96Lw5d7DBk
	 JSacB/F6AOwTaUW6ivJytOSl9O/iYgrCkmONH6QZkWboCKdXjV9ywBN9LQKEWY/YDvMVj
	 ii0g8Iqcb9csXBG60f3DM2lX62UJnm7eT5LjgN1QfXF2Gezr8mGCNTrYBWg1ynQLNHzNR
	 AbnS67WorvUPXQqpeeo3Y7ZAjYMpFKZFdhK8/g4wNxwAknVc+zTeXIUbp5+1x08H/Vrgp
	 WsthVMrLhetRv0wQzguH8xbINEnPo8vAEzOS22JwXSn32nTIWHygiiY+ZRJs0nN/+Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337910;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=k0C8oGR4+WVV/DW34Zcau2p73El3GX6DcWBpE3hVIwM=;
	b=Zi9f6a9FPmU7tObDH+DmgN7lrNRGpdDvF4oXpKTO+BGbJTCY1VnQfcIrViv+CuphSgZx
	 iuyn74xIMEUnyJCLTnwH8Sj17fyuD9YHzdyljkHUMy+bgXYBUDbvYCPBsUqJVVifXtS0h
	 FWoNPkaK2ZdDjgFvDkD2xgRTnzlDC02toqBCoTDJOKdBMXUK4SzYOdlvY9YRl9Pddjf6F
	 ppSx3SWUVBPIaHGhqGIQU9SpYz25KcayJZvNp5MHBL2+pBMrWOrUI7ZR5KBi7TZRJvDjB
	 OiFq/p41zT/btL38QKJqqX/Ub5KM1O8uYmDmbAMxzw4hJgXn5tCqpM7fH2+B4V5U0Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=e6n1l1os;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TxxtpW0H;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D5606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F9D5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=e6n1l1os;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TxxtpW0H
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13F181400138
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 14:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794337909; x=
	1794424309; bh=k0C8oGR4+WVV/DW34Zcau2p73El3GX6DcWBpE3hVIwM=; b=e
	6n1l1os9LOCZzCwrV1fYdGkRP402Cb9bqGQy1jVzyexXH9Nytvsux+vCbi8X+jZ+
	UN5NkrH3dvD/jOvPs6I7VXUq9bZKoJ2LZpFk0rJ80xpvd8CvbQ2w6QxRKil5dj8H
	mxr4B/chgMCJlEEyMlWN4MMpHCv07s6fpW9oScFRT4BWCCW4tjlG0idefDjL9m70
	xAwCUskAXNFzaCqcJWUK/w2JNmIm8WlKJPmeArU7ExTwLEkSzYiO4j4hxG5PHOJW
	XLomVdt3pd41LiVpWnMcJTFmUXVzGJQ7jFNFiRsHFjRZ1xW3oEl10fURrMQBAMZ+
	8vwPaVHc3FmaEZvNPpMiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794337909; x=1794424309; bh=k
	0C8oGR4+WVV/DW34Zcau2p73El3GX6DcWBpE3hVIwM=; b=TxxtpW0Hrz4MNhO+S
	0BoFZxXCYo+B4Z6ZI7TMpO91/LKDR0dLcctEAI39/LkB0VgzgWhHTVqkUzF0qQ4n
	ieJWV65GKrYUgvT+F1W5JCls3ee1kwnR4aqqt4TfzxfUutafV5V55g8tAVWnTVFD
	CHoHhTi7zNpZu0h8K+DvZLGjDJbWJ/DjHpuStWeC9zbeUpqSNJk44TdKa4eH9uel
	Gj+/hL4MoQhUYed5dCIP0/GX1DnFRuoRUFdaVVIPgNmfo5cJmSIlKhXqbLq4r53x
	0f3VEmXfqWcKAhTm3aXZnjx8wL839oJ9Fyblc5lIuMjFDuB4+ZXldLRAVZrGKlch
	D5S8w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794337909; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ahoojisYCuUJROM6a8FiOe8iZQXaPGePOSigK6Yw9QXNtzn
	TkEbsm8SIKuEbcE0AHygtAUnvfGPGrRHoJHHnvkautDNifO8sf6yIIaMeiJN4srH
	ZoYuzifTUX9Ui3CjLpS7wqwPt2zrunES5LoLSgffVlKAGj8mwVwrGqp6/5Jk582w
	Mhvyvb76S4tLEamDwYi9/f4GNIUYUckX6kzwK50DoLc1epYHqJ3CYI9upr72p0+O
	UbeAdt6P1xMmhk5dDmpqYTP/WMHkdYW/8NTyZeMNEhfKudeF0I/iaRl6jjvAg86z
	jzOjACmGSV7OgIpYtRgwCde+FNPClvZPKWyeg/A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:db86xlce9QkqfMdsPudU0rPrkQfDvWnmQtit+XuaHyg=:UX4T+iEGf3F1fEWwQ/UZ0p1z2LrFtoxyi53/gsZp8AY=;
X-ME-Sender: <xms:dWzzaiz7ZnikkEU7gJ9yneGBAvhix3SfCUFGeiA4WyqLZzfYMGZhkw>
    <xme:dWzzakQZplbIzwE-AEEswbkQLq0Vf0CUM85YYQQQbEv0Yegb_qyk65h3te-_jsODy
    5AMKZgpV0xb_-elks2vgGNGNrkC_EU3q4fCEshc6D-UdL9DLtsiDXIn>
X-ME-Received: <xmr:dWzzah_QZJZEcy_zbM-e_wD13_zuOGHddZQ4yS0-Ffzl_tsO6B8BLbMciqRWef1DREaPMJs>
X-ME-Proxy-Cause: dmFkZTEu9BqDtNH88eLZ+S8C5IYoX51v3p1TQB7sMGS0s/AXW/6Mp7qcLhxEuxj8b2Llo8
    oqfr8kgEgX4zVOHIe/M/BkRQ0mQK4aGxEIm+bHuzUJSWgY9Zrmop5IyPeTyaBUPVGeJSiS
    2KGNnnNnVcE6rfy1uqT1FNPEZ8nAvP7YwqVYtiWGvdMfrHbU7aXfNPULbwHPQ/f0fB/XNj
    bjTPa9upP+sLpukeD+yylxx/nvf8cYMui4+rpu/NboVBopNZ1ww5JLLBP/O4AXCUwtOpN+
    q1ztUB4zc8rCPIyKVW6eM6PyqvVJtcWxMFuOpvRVm4s/weTlUTzJG4ae5yARKrvDHqckXW
    QHITtSGjwgk0AlU04c4EGkAtGKtxmUpzAEEsuuVrkGfjAY1mn9fjoCT6nVOXo4V2uT9E7u
    I5bAgF/VqJjAoHIZK6ft8nDtD/8tMLnvcdSC9E/neZiiuoxMCKYki1YiQthZg+LWAYA1BC
    pcfiygb9BudR6sx7Nj8WMQ23s8I2MgC1KnfgX8V/NoFEB5+A0H9bp0XXrjOQWIzuiezKg6
    rcHpWsfwAJ1/RFCOzkO67lZ0NZ8etXNABDfjUdfn5nsmNu9mxZLPLjQnWyy3h8Y7eF5Vv6
    mjIp85G6Ob5YwB8QMUX9T5RHE0moPu7Gg7SEiSYUc0UHDE8FW6I5cLhT8N7w
X-ME-Proxy: <xmx:dWzzajrAVoKHG8V0Y8wMwIyyHyysAFN3s-PhmyYEtIdA62DZz9Mj_A>
    <xmx:dWzzamly4tq7Hgvs3f3YZu691y74WsMSA5NyV6XD5Mq7F-ZP4pJrjA>
    <xmx:dWzzaiL4mMmsIngIk6ifJMlgoRx_tosR3FA-DDaiP9UiMDhvkn8zFA>
    <xmx:dWzzajzl_FugF29u0_4vRhn-UkoxRW4UBsP1sUgwwgqIzyFGJryOXw>
    <xmx:dWzzavRep-x7OpZQmpxPHc76OKAgJpzTB-vaU-BaUmp_eDzOMf5jt7vY>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 14:11:48 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y v3 1/3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Tue, 10 Nov 2026 14:11:24 -0500
Message-ID: <20261110191136.1748573-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110191136.1748573-1-oss@fourdim.xyz>
References: <20261107062323-failed-5.10-6320736af7dc@kernel.org>
 <20261110191136.1748573-1-oss@fourdim.xyz>
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

commit 6320736af7dcb90da6ee9fd651ecc11c564d45b7 upstream.

Adjusted context as stable does not have the lockdep_assert_held()
calls, and l2cap_get_chan_by_scid() still returns the channel locked,
so l2cap_config_rsp() does not lock it again.

A peer can send configuration messages while an
incoming channel is in BT_CONNECT2, before the
security or deferred accept gate has completed. A
configuration response can then promote the channel
to BT_CONNECTED. Configuration responses can also
act on channels that are closing, and a late connection
response can move a disconnecting channel back to
BT_CONFIG.

Accept connection responses only while waiting in
BT_CONNECT. Answer configuration requests in
BT_CONNECT2, but defer our own request until
BT_CONFIG so configuration cannot complete before
the gate. Ignore configuration responses outside
BT_CONFIG and BT_CONNECTED, and only complete
configuration in BT_CONFIG.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v3: Drop the AMP changes to l2cap_logical_finish_create() and
    l2cap_do_create(), which are not in 6320736af7dc.
    https://lore.kernel.org/stable/2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org/

 net/bluetooth/l2cap_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index de97a746bb38..5a24d655b535 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4478,6 +4478,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4507,6 +4511,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4642,7 +4647,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
-	if (!test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
+	/* A channel in BT_CONNECT2 has not passed security or userspace
+	 * accept yet. Answer the peer's request, but hold our own until
+	 * the channel reaches BT_CONFIG: the CONNECT2 -> CONFIG sites send
+	 * it. Connected channels may also need to reconfigure.
+	 */
+	if ((chan->state == BT_CONFIG || chan->state == BT_CONNECTED) &&
+	    !test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
 		u8 buf[64];
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 			       l2cap_build_conf_req(chan, buf, sizeof(buf)), buf);
@@ -4693,6 +4704,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4767,6 +4782,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
+		if (chan->state != BT_CONFIG)
+			goto done;
+
 		if (chan->mode == L2CAP_MODE_ERTM ||
 		    chan->mode == L2CAP_MODE_STREAMING)
 			err = l2cap_ertm_init(chan);
-- 
2.56.0

