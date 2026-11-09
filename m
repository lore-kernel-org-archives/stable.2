Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189659;
	b=jkf3oyaH+LCqsaZZYXOAC6G9sE57gIeuwrVOC3EKtVxhQ+uCccBC0yoiV8Oux7Ti61XL
	 BCjYvvBPfJ+Kc2VaK1hFbl9pE6Z0ZnYOKr8ic7GVx0085uIvOgS/a3+Hbo0wDEaAmgswe
	 68N85a2KuPeeYsSV3JDEP2rzzK6+gCXV11rjo8ZWLjTPtNF8m4+Z9U6cv+bafFdBDZ39V
	 cufS/0Rgy9H+CAIzSWpwMwVdaM1YlE1lXr1S/e1aXYkiyW3vqYLIqAAPPOK1eXM0fQBDJ
	 mfg7paCTIe1Wb+dvBai5YQi5CGxsLyLG8oFy9HJooNcyz6brluyjen2HOb+ZanXgifQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189659;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=XOXcmaKGRGE3JDox1DRADQDwfl75lkNJsi1z4S+ZW6k=;
	b=pRiLfZemdutsoyNSOc3IO7P2zXli86+a+tIW6VcYR7luJM6nsejH91OTsGESurk58cO1
	 wA+dBh8s8ilDwvJ7F0vlkUChI7JjWjOrp7Pyu+Tz9BFCIT2IWBp7WwVMbwyD9v99t5nqr
	 kH8M7am0H5pR31Y/oMtR5SESttH2TJ7JTbF83K14dZKpAkmtHzHCguh2BwLpB3X7N/C0+
	 1SPXKBmu4/DX1uUBariKzYMcVJx1EI65Cb2EsSlCoC1/8nsAhBnWOB3IzoiyrFUipJiw/
	 /VYrFnGUFYI4r36zeT6ipxjSk+s2Vy6xHB/AYyVGI8iW00cZp/y912WRL4q+llZOZYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=O4LFlV7F;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UhqQzAjH;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26F606A334
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D26F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=O4LFlV7F;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UhqQzAjH
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 62512EC0585
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:00:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 08 Nov 2026 21:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794189658; x=
	1794276058; bh=XOXcmaKGRGE3JDox1DRADQDwfl75lkNJsi1z4S+ZW6k=; b=O
	4LFlV7F2R1lb2VGmcbax88t1NudvUcJW/EaI7C8bxNUt3Q8iAJrk+FvCH4UD1qvO
	6Usk7tNZlm/0Euv3ViAVPJxG69yE8t3vLyZI/Of9r3zsW9oiyfKrz+t+DTeCE9Xz
	c2iUxGAxxa9KSdhSOeiLpQnQIXXn2WeBXfJ5ZCqjjamvBX/wxnrOjqYGaso5+WYg
	8mI3TpX3A0ezaUC+FH7hR0CRrgwqbiikIABpskpoUyeRLZct+0LBDNmiEDVa6Mlz
	SGfSA2Br7SUdnWBk97v4rIBEz8VxPbEtkm2vKeGuXAPlaJ/Kq/wKXnegOsjN/G5a
	29Tjf8psOXsVVe5bzCZhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794189658; x=1794276058; bh=X
	OXcmaKGRGE3JDox1DRADQDwfl75lkNJsi1z4S+ZW6k=; b=UhqQzAjHrL5uoa9p1
	HglZm47xZ1TmD+o59Sfmo0X+eckjDvorcnGTVyDjLymW4rYJ258gadrVBUKzPGNI
	+qsyaVXviEM3ECJ2kfomQ5zbYxnu+HENNO4bXU+LJ2SqNNXRf6rbTYkOkaczjOiW
	UL+u33Pkwng6MX3lj3dc1rqb0qbPoL1cyJCLZQOP8RT0EADbj1TCgGzMVYdNHvH6
	HeG+J741D9tJ8S84u0rRVfcrwgzLl3Ohxry7yqDwvgjYnpYfl3yh2FlqBXhybVN7
	eSi/K5+eFWNgtBWPAvZZM3goe/1v02iCPY7CoyN2KytfQITqEhM9HNsvPTlt34bW
	huatA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794189658; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZE+58a020EbgXxZCBM6oudeI87GrJOUcKzHFgXCUFmxO3NN
	AR/cYc0UrMjEU1PV8fMTAzV8sPwwSkU3ALV+bETKHunAbpio+0KDB8BXtMI33RKT
	fsB2FcV9x84nO5zybB9T47/oagt4gktPMq6x5VA1GyeESxOILN/D0GPKdXOcL5Hx
	1Zc9ngcXC9b5FIWjlHBmOAboAugJ3mPF/7IJG6WkWO3dBXaNm++GduZJbhPDC3kb
	xG/ebLOWT7z5U5/yzbU/qnWTgIF8RjK2ARHViEL6LBnJQ7jAtx5rUDXP1NQwBiDL
	vWpGJTmWcNLMWclII//gOquqs1Jx/7WdmF+14+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qADGQHlhBMBW02y6Did1Mep/8zNQNKBZe1bOXr8ZDtE=:CgyV7ouykAgA7lM+i5bIU9SZQk/vrz9e0qejcC97oyw=;
X-ME-Sender: <xms:WinxaleKSoEZzk-_o8eV773vyFtD2o7Ya3rInZTtQ8eMDpR8aK_zBw>
    <xme:WinxapOwztebxZPlu0rSQvl0Zg9T5_sBVAPiBBViOH-_9sT97JnFHtL8ZGBTtxw0G
    4aGlbtWa7PdH4cFwwh36en1h0b-RGGhaw3WIlTBokEpiaCS_ehWnhOc>
X-ME-Received: <xmr:WinxasI2cgvvxnyqtr1tpspKxOD5jolDoAYvZgeeaC0nlGUC_SwH0zYX3Uyq_GPbvuw5AJ0>
X-ME-Proxy-Cause: dmFkZTFL5xsFEidEDlvTjZoSmcvI3z4L4v2Wqh1Bd135ZGcfidh8fyHhq6DmWQqRsHj6xh
    dFRRjsnHCU+R8Wsip+I79k9LEiIaIdn79AdSSNsH/L7Il6Qs+nyWIo8D/27xyvIoQb1qhT
    lZHCOa+laW3OuUMPh+mXAMcwMR+xzfy+WW7+wYSOb25j1RZ9zYQHLrmX6DAYFQZ7Vd8V1j
    B2gABwKqC/wj6nLNVjT3J+u6zqJt9hgCEan6Z5XxdcpJRcgHkDvIzIL2x9V+VYiaJrHro5
    +RKwceclZ4UqJnqKkTvYqTSYOmIjjOwkw/eBP4Mq095kwyLzz5yHPoI599olMRDnZzZSeH
    CLa5NT0XTVBg+k+VpFPEw7rNz4NLtwDJTBIaLELybtlCbXZLvRo+EiFldGrGyhr/JDqJgA
    7JyfMspCjnLVQNXurqv9hTrqxbHTmRrpzqnbJjrsArgaO0VICMpq6p0E2OxJluwQNK+i/+
    hIgp4N8uJBNr+o/EDpQosLgTzQqOO9QtE91KnUW4QD9xYAWeMDVF7wC4/Qtp519UekTp+a
    EG0nJPh1GZpOOV1NdxQDK4hRtYAVB9UtjoSRPA8XK51RymV0gomRbkUJVqQd10XNtpYbWu
    /MmM7V1/Ip4RKDlH26powGUCUafLKBl9WsbMbsKIxQOOzHkHEtKhP27v+Ftw
X-ME-Proxy: <xmx:WinxaqHlhVtp-hZ45VaL3GSJUEWANeaqsiBKeBjfqnpnhkid55FYqQ>
    <xmx:WinxakTpg3wwBtB9U5XRUeGO9p4Ckny8iWhUHewALiwjzQNiy2zmXw>
    <xmx:WinxamFVBSh0vyP0-aDwWpOT2XF14JRF-mFoCGR4vUierA0GiuwwPg>
    <xmx:Winxag8z-4MAsvoj0Yq9mh4OQtkjXAlSjGCMP7p_7WaFc6Fc6bUpMQ>
    <xmx:Winxau_6sMk5byox7BBvMEJBk80SHDPnCNLctWUx7yew6iVcte8nksWy>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 21:00:58 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y v2 1/3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Sun,  8 Nov 2026 20:59:26 -0500
Message-ID: <20261109020039.3035406-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109020039.3035406-1-oss@fourdim.xyz>
References: <20261107062323-failed-5.10-6320736af7dc@kernel.org>
 <20261109020039.3035406-1-oss@fourdim.xyz>
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

Stable still has AMP support, which upstream removed in
commit e7b02296fb40 ("Bluetooth: Remove BT_HS"). Close the same holes
there:

l2cap_logical_finish_create() answers the peer's configuration request
and completes configuration once the AMP logical link is up. Only do
this in BT_CONFIG, so a channel that has not been accepted yet or is
being closed is neither marked as configured nor made ready.

l2cap_do_create() moves an incoming AMP channel to BT_CONFIG and sends
a successful create channel response once the physical link is up. It
only checked that we have no connection request outstanding, so a
channel still waiting in BT_CONNECT2 for security or deferred accept
was accepted, as was a channel already past BT_CONNECT2. Only do this
for a channel in BT_CONNECT2 that passes the checks l2cap_connect()
makes before it accepts a channel.

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
 net/bluetooth/l2cap_core.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index de97a746bb38..6b13f6784c40 100644
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
@@ -5180,6 +5198,12 @@ static void l2cap_logical_finish_create(struct l2cap_chan *chan,
 	chan->hs_hchan = hchan;
 	chan->hs_hcon->l2cap_data = chan->conn;
 
+	/* Only answer the peer's configuration request and complete
+	 * configuration while the channel is being configured.
+	 */
+	if (chan->state != BT_CONFIG)
+		return;
+
 	l2cap_send_efs_conf_rsp(chan, &rsp, chan->ident, 0);
 
 	if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
@@ -5290,7 +5314,17 @@ static void l2cap_do_create(struct l2cap_chan *chan, int result,
 		return;
 	}
 
-	/* Incoming channel on AMP */
+	/* Incoming channel on AMP. Only answer it while it waits in
+	 * BT_CONNECT2 and has passed the feature mask exchange, security
+	 * and deferred accept, as l2cap_connect() requires before it
+	 * accepts a channel.
+	 */
+	if (chan->state != BT_CONNECT2 ||
+	    !(chan->conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) ||
+	    test_bit(FLAG_DEFER_SETUP, &chan->flags) ||
+	    !l2cap_chan_check_security(chan, false))
+		return;
+
 	if (__l2cap_no_conn_pending(chan)) {
 		struct l2cap_conn_rsp rsp;
 		char buf[128];
-- 
2.56.0

