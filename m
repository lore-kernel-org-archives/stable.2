Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093651;
	b=bz6DdieFzYR87E8PSaegyVm/U4xqMHp1JsxRp6UwTXqQ9YUPJLxe4m0yZQmC5wBiciv1
	 kRGDZeO4aJWY5UE7hUV2bdW3hMLhuI6dQ/CDV289zXRayBIKCrnMT/4IpJuy3AeUfmAQk
	 GD1h2BLBNlB9E+vj2nI8DrYi3igDnZJljBz3Z41cJw1TBS5+2WcxJLePlYxK1HJVEGKxW
	 kV1n/Xw6bo1aRUZaTkwBDywhapaP+tgxfWIjGASA4xgxfuJKz6SDBwFDgk3a2BlrjjHZb
	 Xtt+aC5AdXXCUiNcUlIjBtg2Z1/ufv5nO4Zgw1WWwxWnYadPCFoUlmx/QRJw97PlmVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093651;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=sy1AI5/y+MWFKJ/N7aTAXgcxhwsTJu3DxySKgrqXEsA=;
	b=U52sEDpq0dxw91BO8rGHTgL9Ox+vJm4EQK/wJfdqtg6poNtOo7cXISvYPw0N8VL6CCXO
	 huDfK9GCEnJXFNE0DhwPxrbqlRDWxUGn00wDESFmsoQquU6gEqDHpY3/yXZFYN4h8LluQ
	 S/zzse3qxQ63Fftz/Lu0AL0n/HvyZqIjslsmSIEq53JlM+EqRocCGfIT1mBocYTBSYut7
	 Dy+kaUJL4CzxNXfHeTJ9xbstr7ZjChfon5bZHm8EJ0Kgo5xmL5laJGCEWXfiOZ8Wq7192
	 MfDn2K3l57GFIFQKrnGf+vJeb7mz6VqRnqDhQ1UDxksB/hS25HXGZd+rWRkCgj9PqWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b="Y1J3/a2o";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Vm1+AH1o;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E75606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70E75606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=Y1J3/a2o;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Vm1+AH1o
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id F35D91D0012E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:20:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 07 Nov 2026 18:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093650; x=
	1794180050; bh=sy1AI5/y+MWFKJ/N7aTAXgcxhwsTJu3DxySKgrqXEsA=; b=Y
	1J3/a2oxzzWOL5BOXuVcB407ZVc9pYvUwLFK8Qf5WmWTuLsRph7AhtH93453GLgH
	akvl1ovDjr9f1iiNhBLO6ZCspcu3ikkTV/PR6bH1VFFPZADkcE0Y0GnS1dJfX6rV
	sskPpqB7I8rNewa4VvAw6L/G3rXU6Wom4SUAl19cRl66sOEOSkheF/sakm6hGYxM
	0lsUKqOre6mO50vTXpwfI7M2kXs5McwgFxk8d4DbE2J261HQbeBI8r7W70qZeoCw
	yAe2fGcHNnHIIwV56ZhWwzckL/btFs2j2pQzdeS+6EeQj/1mxMidJq7/yz5Stsrw
	8xqqT2WjlQ11JVTlU2pfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093650; x=1794180050; bh=s
	y1AI5/y+MWFKJ/N7aTAXgcxhwsTJu3DxySKgrqXEsA=; b=Vm1+AH1ocyEvt7/qT
	P0KBoMKpn3DbGfDSABaIwdKS3MLS1KK61fee3dcNSePKTp7dJ7ISbmPX2FvgCYLY
	UdkmnbpxkCGGGgWK3Z0k+vEQKI0MWmO0F3bETnvUpv3WbrJuUTwdabeP0RKD/Xh8
	x1QAHs3XFj39BiriuBg6KbQ+SX/FTsYdoMxGs7nvqs3yb/OsDM+C6vTKPNDJVMtU
	UF95779rSfrLuce1qR0fBXiZzvpg42SG9BJ9cQ57vLvUHgL9p7QIH5QMmIOCyMVi
	9IHuPE1sn5fRcQMqdFWOStnkA70Dl37+DddYGc6D0RrtbAPIdqxEyZyfcYQlFjWA
	33wIQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093650; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QSwNLU6jEIjz9sGEPpFojEPla1C9Yaz3kyw+fLTOS7cVZkc
	94Q9Bhhcxab6mX4rCkClUb7LHf6tEHswVP1VrHBU6j3T4e0lLBZk0l4aM18rrHuf
	Ogy+5V5Oph88wQrfDV+WCZrTCpf8u+0sSBIfABdLB4kltUJyGM+otPguScgHkyQm
	jtIvSMW645b4EmQOBVozqsMw161YlsEs7QpHV2gGUwHaYHZYffQfEWXxSHluWN97
	gv2iIzc0j07OxV6RZkrXexr/ATWAIhQwfhGL2RFqNrWh0gcTrw1i+ml+FDkUiF4T
	YsG670maA7ojKte0SGOx/VLU+qEBmLM2QTGuPPw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:x34L2lZY4YminVWKDLg93chdQp2IVIRnRoGaA2B6Piw=:8/ZGBX0iH/XdnsUGN5HAPspPsVwRUn9B9ZLCwF4kPJQ=;
X-ME-Sender: <xms:UrLvanNHZOEc6H1-KIG5ce1UEwyZyJpR3SmG_JsqP5rvXYud3eY2sA>
    <xme:UrLvan9de4DssXxOell74X440doDoflWvsndMdno0_A4gxzgZhUOO5Xq0MIqBG1C_
    meSFWy3OfYY-mKnFjOGh2tKtHS3IMBJUNEb_4iwFLlXJffFlpFfLUDE>
X-ME-Received: <xmr:UrLvaj7f4xGSGpBnIiuTufaJioNRYvCnT0XKrSpcmCWdpEEJpwwWDQ_TtsfCsMr4ss_WMY8>
X-ME-Proxy-Cause: dmFkZTEIZBGCpisFY+fdhMhQMR/CwWUComkm9G8pkzgx+4rdsjDawZ1p/lM4mekr6Jrfa9
    t9lCBaxA62uSScJCDTVJZCvxUjTT8lXgI6y1ytbjQFdUJAQqlREN+nI/dOsRSO/gkOdRyc
    pC8LDxn6x3PlPwNH8xvIt2eqfa5x/4kvAkT6Lfkd9YAUm//zW+y5QQzyOpHdANNZLZMR68
    JqeYhLI84sK9usprfwwmkKl6Bsmrd+K1rmmi20p4W43h20l04EoN6alO8A20N0x3h2tOrR
    Hs+B6t0zXHZI5+J2tOJigPtsZ6jVQ/WVLTNyOGH6CZRUTfmKqjC10aJjkjpnPysWnz36Xj
    pLUVS9c8gHYNr0Ip++CQEEFgeqhj8uP0smlhN2FeZxCela7Z0BE0KernEYDa5xxyvUfbsY
    zh525dek2tXnpC3f5hTSqjwigkeDwfs9ZQWkzH+WujestKGIkKdgCKkBtW4tDyXQLcpE+i
    jdA5HmpH/uT5Egy4RxctzN+11fS1P4JMxtDshC6fatu+oGD8TTD+IuesSTgs0b1rmzkFNf
    fObXPnvd8Ms6UsjV/2nGBI1BZKWkxEIly+CsKNEP0FPs3+uUzGuA3X+09g5t05GcA6lUNo
    trLnL3sHI+RKz95UBqLMm039wAx9t6f2wY5XLoqP92h8k1nt1f+w4p/4HhYw
X-ME-Proxy: <xmx:UrLvam0KmhFMeM-YrtZuP8MO8wYqOZqH2977DSkMA9tgXO4UWftMZA>
    <xmx:UrLvaiDcNvDM2rrEdiBZBCIQQGrz9Z30GEs7Zoc0DOhqK4cOyCp5Hw>
    <xmx:UrLvag1lONzR2_pzkn1QmjSO_tv58LvrIbXs3ye_FaiL5RJkxtkqaw>
    <xmx:UrLvaktnXbiahHuGB9Ga0YoEQzvBl46ZD6iYaqDDPZvTGMzJ0BOFKA>
    <xmx:UrLvaks89ny1KlRwkSt1hzQ8hsy-1GjhVyRH7DVrl8L8TVv80R2LFslz>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:20:50 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6.y 1/3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Sat,  7 Nov 2026 18:19:58 -0500
Message-ID: <20261107232033.1872805-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107232033.1872805-1-oss@fourdim.xyz>
References: <20261107053519-failed-6.6-6320736af7dc@kernel.org>
 <20261107232033.1872805-1-oss@fourdim.xyz>
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
 net/bluetooth/l2cap_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 82f51661d8f1..bb0b174462e0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4261,6 +4261,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4290,6 +4294,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4422,7 +4427,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
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
@@ -4470,6 +4481,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4537,6 +4552,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
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

