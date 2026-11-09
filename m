Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189567;
	b=d5SNlN+fxAb/ZbCcmpfsgTFKU+dXCwicmZLuWAtRdmuC4pTtipV8UOOewsag86xzYOTC
	 SjsKtQb/qB4FMMRdV1M8sKDRWtwGljSUe2bKZDmupf0Jm+8zylVeZdR1Td9Jzh/bJOryO
	 52RPVs/P/eSLqkoQabpM3/3xcQUfzYgomFpUVGWKxEmEX5Lob4J0urtcyWV8iGcIfQjLq
	 6JAXQ+5Zv07k09CzBaBO0iNg85wi0O/gc14DXtYwiz4fRp9jh6afneoEXcZDfq3n32FRj
	 PAH6f67m491F9KFEHmzAvBAynrBE+D9+2WkDsEj1YcX1fleHk5dv+8Vybql40wIg75g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189567;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=EANVct4mKbMhqAt10EkfevEmU0XgcN/LyCC+UNITp0Y=;
	b=oAZ8ZGbyty/y/lX6dDL7IHFIjO8tAQB6V4I5BfMtkW531tr0lg14mrQk90a2F5TYSD3l
	 1NsdtXRxX73FDeHfE9od+MKsm1hoHP0l3NrxYVc8sMBXiBUliRWiz2zlbWDh9cbHaZnOd
	 P3kDdsFpyv64l7QLpUy2LwOTjZNaZl5ShhEqmcucjHUXI6j0f1URphQnDxw2y9zzkjKTs
	 1hBeBh25WygojH2do6EwWQM56zTQ8XvcH7a7W4fFaOAI7pN2X5UItz4d6ZQ+orgtkhAGJ
	 KtcP1tAtcC8TnOv/30n5rs5DjNGEo/vK0OnZCzfIa6SiCt0Q2V1ZYCk+MmCuMi2VSvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=q9YaRrO7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lpaHR+eN;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB6606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 01:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72CB6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=q9YaRrO7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lpaHR+eN
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A420EEC04C3
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 20:59:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 08 Nov 2026 20:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794189565; x=
	1794275965; bh=EANVct4mKbMhqAt10EkfevEmU0XgcN/LyCC+UNITp0Y=; b=q
	9YaRrO7wDyROgwyXTya6TOM9SZt4nOhZb8x/JdxAxvFg/XDQoOSJoX5WezlIUiiP
	JJEo9B+WAAh1fuh/Neh3rFbYWlBpII3t0ZCigjaJTqpKXgUDL5BoFuVVY+RP7ouo
	rJ9csXliK2p7Y0TcyG9RiWCfSp+XXWKRIaxR+QlaE0IhXefSdLotR5FyhtyKZ50l
	hk/GvS2FGpvlJsm4tHU9e3pbSCIucq7Hns0BPepaLgTuw374tpHAO8W0Z7Z35ELr
	d3+OYab80g8ccgknLgOV+XfrPzOyLWDBnGOe+qhYSw4nZByNGyjy2FTm5nwQ6CZs
	a7aBCcDJDKa9oinerXR4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794189565; x=1794275965; bh=E
	ANVct4mKbMhqAt10EkfevEmU0XgcN/LyCC+UNITp0Y=; b=lpaHR+eN4HDxJ7Ots
	9bzMcxMdNocK8r4Qugx3gi1b7zUHUNhMUgEUeZhkB7jYMu5K1yXHcklrjMq850q8
	LYVkYm/YeClrKjOazPVGCYJTi4l0LmV/DGplCpD0eIrhwg3Y0UVDtaRh+cgNfyjQ
	4hsESMSNQa+TcA+0Nl0ysGQ2dsEXz4CYBengTfmpsLQ489Gh/kIC5ASHbYzL8Pjv
	hnDQoyfDrrVU8ZQu9MCo6kPxAUVfhLODMvmHQMVgU6eRWh7p/eyciaNVCkn8dB4J
	8YR4IRJj9JM/3kQGJFjsJGEDXIY1bQY0U4h3nt6ry++wvdss+RbvbZH05DV7CdiW
	DrjvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794189565; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vI15JiOPqqhECq8IU4+okWQU+1e8oGX6SWBgCZGzi3aXfMt
	76AOKRQ10AnOZzdw9L/h8uaslHIECknKoXLXN077qsLnSsaGS7kBGaL+GFfnam4E
	/lkSsFkrNU/6hVCKn/3bTC2DfkPgQv/JxWKzRA4RAW48lJOrahdnKrNWgjVhNJsJ
	wzxcM+i5n9ym88bdg272sRGCw7BrR0GPBR4gdgr6n68RLT0BHPoddEzRNS8wj43l
	JgNa7Nci7Z7rGmN75yeqsEK8gkJbI/TBn2mtsKHCirVSqzjqFT2qpDQqFlif6SV0
	KF+8uVOmBPcO8yKzzNF7J+whwC9tQJnW5acvKZQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:u1+5uq7B/ChwbpJ4NhcAve1/O0naF6+AqlDNRNE3nlI=:Pj7d6v9m+JUAkojSsoYu3PAksUUQ4KCSraxCR+B/O4M=;
X-ME-Sender: <xms:_SjxajCh-c0ClDQDHizRWGRBZ-fbdJeOMPUGeuxrJnoal0VbybC7BQ>
    <xme:_Sjxavhg7go3MhGwaXX44kFlzbecUbyzTRk1jJh7RRNWlcepxjjRBt4lqS443XKdj
    7Jy4Cvi2Iy0Ncn7TxNkZb5KeCMSHV3qpzmjcfu95ZqiU5mrax2oaEZV7w>
X-ME-Received: <xmr:_SjxasMPh3vtTQhhuPtCmylcTCVA5pOm3Zqki_PxY8gwMzvqt7BuL2kMG16H4uEWHg9FcUY>
X-ME-Proxy-Cause: dmFkZTFL5xsFEidEDlvTjZoSmcvI3z4L4v2Wqh1Bd135ZGcfidh8fyHhq6DmWQqRsHj6xh
    dFRRjsnHCU+R8Wsip+I79k9LEiIaIdn79AdSSNsH/L7Il6Qs+nyWIo8D/27xyvIoQb1qhT
    lZHCOa+laW3OuUMPh+mXAMcwMR+xzfy+WW7+wYSOb25j1RZ9zYQHLrmX6DAYFQZ7Vd8V1j
    B2gABwKqC/wj6nLNVjT3J+u6zqJt9hgCEan6Z5XxdcpJRcgHkDvIzIL2x9V+VYiaJrHro5
    +RKwceclZ4UqJnqKkTvYqTSYOmIjjOwkw/eBP4Mq095kwyLzz5yHPoI599olMRDnZzZSEH
    RpuzFZ46nL8P/7yl6Rnsy9mWL2guq4NDnlBMf4/5YzeUI/yyZx26ELx2SNGNRQjs9XyyjM
    jw3IxzrlNSAf1tl6zKDVvx7ypuKY2unAs9rDhQVM0Oo3ocFj8XhubRiMwUqKPjMNEIEx3+
    FuI058Fbq3aMt6ziBgbtH4BPxXvhFlyXh0hkOTeODSs4PaRnfQofTn36kasYSirzRXiVfh
    DWS6ynbZKqJW/o2rc7BZEciFJtzMtT6rtUfNkjrmm+pxgYN1ncikFuY2RpBCAxsM8vXbak
    Lzh615MnhJsn0zXIBWA5gJ5A29Row9tEjaqNCfomzI8/YNNe3lxjA4BRyLUg
X-ME-Proxy: <xmx:_Sjxag4xSbqqQdyFPuEec9AkIuUb4EKdosWoIAKNMNX2vCHD_soWxw>
    <xmx:_Sjxaq306lnrTbWR8yZ3xd0UoOPrhGG5QpyYZ05h-3P8tIXKxEIMHw>
    <xmx:_SjxahaH8ZMfoeuxFfK53hwsMV2hxfXGZ6v08tUlr7kM6Z5KT8bK5w>
    <xmx:_SjxaiD7EHUsPn1FUOAA2Y_xZzi8gpXCM_ptJNXEc51uwYc501Elrw>
    <xmx:_SjxariemxUZ-J4eM8YpYMRP5RE8UzQML1fLlPwXpewPS-n8x3my4nV6>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 20:59:25 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y v2 1/3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Sun,  8 Nov 2026 20:58:43 -0500
Message-ID: <20261109015902.3034747-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109015902.3034747-1-oss@fourdim.xyz>
References: <20261107060628-failed-5.15-6320736af7dc@kernel.org>
 <20261109015902.3034747-1-oss@fourdim.xyz>
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
index cc49e651907d..3204b95742a8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4443,6 +4443,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4472,6 +4476,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4607,7 +4612,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
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
@@ -4658,6 +4669,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4733,6 +4748,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
+		if (chan->state != BT_CONFIG)
+			goto done;
+
 		if (chan->mode == L2CAP_MODE_ERTM ||
 		    chan->mode == L2CAP_MODE_STREAMING)
 			err = l2cap_ertm_init(chan);
@@ -5146,6 +5164,12 @@ static void l2cap_logical_finish_create(struct l2cap_chan *chan,
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
@@ -5256,7 +5280,17 @@ static void l2cap_do_create(struct l2cap_chan *chan, int result,
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

