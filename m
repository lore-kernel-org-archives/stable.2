Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096361;
	b=M5jXiEyivrcKUMhi+HwZfkae1Xd64lDWl4l6DKk9OfXXZcJqK9y0reVZl4z2ht5VbJjy
	 U7UYsyUR5FMRsAycbK6BA5UULbmDXkOsw3CdMgGvOGxIgYJD58aCQJG3W9IpN8Vd6w2Io
	 CYtyfbQ6KQHpPO0+rx6sOF88uAmYtEcTXb7KwLz9WRLmtvK7MhIxIjhd29E+3mzOUBxPA
	 1Ww6o2Dwf7HMxMzKrZblk4UegYzThZU7gXqFpM1Py9bO6jHt2kuWC+pUNj4Rw3BziAzip
	 PaBTE/mEwvZL9ZJlMQ9xYLOrGlQhP7jF4BKMARHwGdAXPoHd5kxvDESS35OIzU0XklQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096361;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=EANVct4mKbMhqAt10EkfevEmU0XgcN/LyCC+UNITp0Y=;
	b=JUi2E66owEhfnmN3e1Y1oV0VZ7VUUh3MVbU4v5PvpMyY4ghmsvnOiCJTKYWUExzocGvE
	 lrL3aXrtts8aI2ZfOX6RRMfFxIBRGoMtO5sAT79acg8bANOqJopG1eRI0Ke0tzlIl4qN+
	 aDiHcVqXK5yXg3DIbXRReUhEySbGON9Gx3BDyxLnQR/LyPRireC1uK95YzuX9uzhNGeVN
	 0SxYEqaLQT0VX7M+LnIEDLhDg/jrNheBiOcup+TUVAkTKKBO8+PRotJAmxE8PQ5AexsWi
	 hwYJKsueQ/2EN493EAioHy6loImZzpQ0JrVPSO+SngsK2fcw/5Sgh0FEyE1WnBA1mkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=tupWdqLB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=E8aSH+f3;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC4606A326
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 00:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73FC4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=tupWdqLB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=E8aSH+f3
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B1177EC00DF
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:05:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 07 Nov 2026 19:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794096359; x=
	1794182759; bh=EANVct4mKbMhqAt10EkfevEmU0XgcN/LyCC+UNITp0Y=; b=t
	upWdqLBJdfeRQRSyU/y++XdGbJlftgaSK/wdqTBRqfdxBWaWAWiD07q/TwcL3NkM
	wFSBUisK1H6WEgtpu8uny+LIbyXGjy/Bu0F+IzOKjfAmIbDHSS/yjM5cXzpWJ9SI
	98/h1HAWoHr9GSsat6lB1uEaXbFOMCd8at0GTJhc60qZjGVXVJM+YZ6fU4+msx49
	aN68DY4yM8wWAlSAeiVjEpketDoXY02vWwAVvqU2EI5cc9lxOxYlr62PHf6sI1Io
	lBUv//3OnwVLPEMzbH5OYZp5AmIVuuMETQ+U3jABBJ+2/jkLelxbBHhhrH9I7PVU
	Kig/4pFncNBXnHlBVTNAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794096359; x=1794182759; bh=E
	ANVct4mKbMhqAt10EkfevEmU0XgcN/LyCC+UNITp0Y=; b=E8aSH+f3q2A+OC26X
	7PDO4TdeTA4DVFEFd/wpbQCjcx/txrhGke7OJsPiA3R5yu3j5n8V2RXuBZPLpuy8
	rdPoD47cInlD2wcJai2mTX8uqvJNmXpgH/EkJQwdBKTU2eeCI4kbPU2aGykC75ng
	Zar25ZA3clx5SYsyiIBGVRQ4LaHoL0Rqo9q6lFLTzKNmtuaY8eBtbcNoFgcQWX72
	35y6sbNdKDSD9uvh8FCQnnZPKnDsEM2InyI9Bc7f1i7xrd6ns8ur4S8IBF9mJSgL
	B+xrnr5giPwtDQsoIi8fugi6XWeN0QMQC2VVM4cAHzliUiLNckxNPYprFkg/eNwv
	KxFcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794096359; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cXwscJigoYrzXexo2I3NH47ywxAYcJyy4Tpv6VI1oyQOgS/
	XTIimkoc4xw2e2OA/2T/yow4cjRNSTlcCuZIpQslPphWuvS2Y3Bw4XTPL+8YsS2Q
	rwUf+/P83rQ+oVYnUK+R3WfegfuBHsSwaFMaUm06ePJujdtv7VLtZ94W/8rlE4Sv
	LcE4+pkLWT/a+MX8f0jMqq5G2Am8a7O9zBmBwrvwySMVTQX3kNtuTSzVfG4eXDF1
	EpLnSXDUBpHg6lxxzEBfs121sxrvLHiA8/zb8Uj3zrRLQwKVOYoWkkkGqeJuYc8L
	RHsl89pLYoHwuN5WyFoLp0f87JRW2DsKmIHCUoA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:31tvGrbMWqUH+8+UyAAIxB++GPkrNXM7+zpnltuPl70=:Pj7d6v9m+JUAkojSsoYu3PAksUUQ4KCSraxCR+B/O4M=;
X-ME-Sender: <xms:57zvaoVWS6gzvqjlryNlCoTVVFE0jqttUsgMbjl_t7dXLPZ9VPbxUg>
    <xme:57zvain0_kifcTENz7Lsz_U5l4glJSMVjoDXjn7ycJp6m7izOCdvlfiGR4et7xFbR
    FRlxxS01s4na_r0VJVu8BcEhTWPokYn9Q35XfZLqMoyZMNUn1QwPgg_>
X-ME-Received: <xmr:57zvaqDB__say5cQxmD5LUnlzfzh_Uou2qv8qN5yuSRr6WAdO_FPLbBofrRVG_s4Uq-oFrA>
X-ME-Proxy-Cause: dmFkZTEzXctB9+QqvlwitGYXl63iBXXDJxaOS9iHJl+vQ3FaLqekKmL/SMRSo6RnttZEDd
    7F+IBEcIKrLEl+/01lY5NAmtQWbv94R46wLTPfAw35TMcYYay118ApvkUGHwUQ37405qaD
    G+ZVa+19wEM+Y9oXTRDli7LF9vfn5TcQ3W7fMaJxIxw70w9/u0Va9o0K9LtgED0WKrxAPL
    /e4hpz31kanYMcQbbVyIiN9+8wEqgM3PoEdAHe2MXeJ5Gio6/AuZu8NyDC+JAZ6WHCJQhn
    HmUtrUB2hO8UsABi7j2YG3F61c8c9LLUxwZF55eD/XPUJ2cCBW3e3wymPrWZgHDCluiaXh
    ax7h0K5ne3/gJX7xJMYy9GyULWfKa99AfL2A8LqkSINy9uyNcO3cypIXfrZFNrhypm+vq3
    dwWkR/HUyKbjoqYbTySK6I1F32bNy2a+5y6xdSiHGZEgril1KLV9gi1Y0Oi+tvvbkh8rZi
    dOt8SwuI9J+ouBnPgtI7vv+zB/pS14+wSql4PkpQyf+Jex8U5uAnk0Jh5ET+MmAfwC7Yp5
    Kea0f0LHpzWl0Vj95HZauQv/j/IpI8SogYRY5dhsCN5XpUqXp6L9qZSi2n+QyiJZXpY8XU
    uM7jL985b0vGnOG81oWqeHjIpw3IiUcbwxGXKT1UE6dMIkSh3WQMW/uHBlRw
X-ME-Proxy: <xmx:57zvaid6NXtdbh6yKd4c3QtksNQugrlFjyB5RYLJFZRGawUGiKxTEQ>
    <xmx:57zvalKKPtkRCaT58XMuQY6mxSq4hj79MoQM0ZUbp0n3uc0eG2KLNA>
    <xmx:57zvald8Fu3Zr_lztvSktflF2ECn5oWDDgsG1At5DAiP0-mTvQzRag>
    <xmx:57zvas3NERSBVTmBk8_k13OGpLtYahygegm7pGoBHxs0vTmkSMjSTg>
    <xmx:57zvaj0_LM75lXwbx0j6_9_KVyzUfPDEzMfgv6i9s5l431T7NGoXErqP>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 19:05:59 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y 1/3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Sat,  7 Nov 2026 19:05:27 -0500
Message-ID: <20261108000542.1969015-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108000542.1969015-1-oss@fourdim.xyz>
References: <20261107060628-failed-5.15-6320736af7dc@kernel.org>
 <20261108000542.1969015-1-oss@fourdim.xyz>
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

