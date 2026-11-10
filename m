Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337884;
	b=ATpeztQv8yVXoZ5UIPh0BijcIROXu0EpPWb4V0M3c4mxDV4Wa5nQne14REoKFSncdI7a
	 Z9owmLd0N6QKTsd6j0u9TIuwLqX7gBG8yvrdbCXO43LhnTqD7uCXrZLo+rNwfO0T0KWpQ
	 gGbqDjIfT99QK3cV7UWKiV/Hhpu0o3kt+SeSbALK0vINYwyYGJ8TxBy1NoT52ODOA3sYh
	 cndikMxz40zlBdiviKFrHkOjgLWVXzXL3pJRi2lsWrN//yqu+TsFEWQd3jI9j/Dkaybgs
	 veBnE/Azqar73vNYihMNpg5OFQsplwqYALGE++WKy1ljPYAVdio2F1ufed4TCHTUCbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337884;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=qHHC877zzHBE/pwKkpMdt/RCUbcAtQIecZ1YXelfCKw=;
	b=lGU0mfr6tSItN53ymzKLQKfRT8szfxeDnjn40PUEajfaflf01RJbkMfBidKO1X6tpuRo
	 strteXDdMr1iVjtb6AYptWGyadcBnyCA3Vso8NN7wKZ+qX1rTA4TWEigCMDLpbbCfeA4p
	 1gVSTiqBzKeHax/wv7RUfAN/hbmlvnbe0U24pGW69Kh4tKuxgwyH2CrRx2Z4JDrRDvABY
	 UG761XFBIZggJdDownRxyY13rD619Y/2YEx7uh8GgVOeplLWCF0pfwLLWrvRbbu7x3VpW
	 v0THdJusnmPeeXNlvcASdKl0Z66bFKR9KbYw0zWvB2yM2fl4YpmJt5/LrOd83Gcb/3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=fsBN1E2U;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rYeUx97V;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95D606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C95D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=fsBN1E2U;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rYeUx97V
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D0D7914000FF
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 10 Nov 2026 14:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794337882; x=
	1794424282; bh=qHHC877zzHBE/pwKkpMdt/RCUbcAtQIecZ1YXelfCKw=; b=f
	sBN1E2UN2Ctai4KVaXqitQYfCADCL4LuxVxrBfxPWh+VzyvmKpo4/cXw7ozAiPSZ
	zf9GFK70R0yRvCDjSKWDLJPzf5FlRYfV45rKMwb1mq+L1TcnxrRq0ZzAGgC7qb0x
	zE1Rr0Fuy77CWCjGp0bw7uBjcSQHC/IobE5NZi1ZrrLdSjSPT/2RSuOoDfiKJbpS
	fvN8Nw1+5Cxat6lRFwgr7GsZBJK9ArmRXvRnKkOnVRj082hvax9b2KFazaHKa88V
	W3xJBUxdjmRJ+pxBP6izegGcDt1j+lzDklQBcINgYDEk+K/KM8eMLUjPlqpF+7ub
	wGCgDCziV6EFdTd/G83gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794337882; x=1794424282; bh=q
	HHC877zzHBE/pwKkpMdt/RCUbcAtQIecZ1YXelfCKw=; b=rYeUx97VovVy8XfMd
	RPBAYIeUAY733UWfZ687bYSaVTodF6eN8YITH3tFrGSaBRDNAEBA98kfdHJozhIU
	B6x811FrKgvAdbkxD42Yp9yfiuBlltkNn2MHjB+ZOfWvGhyirh1ZQifmWmgf+r7X
	sjt5jGihIFpl/CZIEuPAAl2uX9zAfbdJ3gIB1CrOfpCEfx61SuUKOhSVvPZCJf8v
	pt4/eALyR0h/tiYOzcSVj3SWdO7rvpddJ9tkWTzfs4MYKBPH0qOQNukK2DPBaDhG
	3bl+CuA8hwE+Qy5WVpQvH21D7lHagpCBzpaamnVHTzlvmxhThRWL7HXwvvpvICe4
	Wk5Zw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794337882; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UQwlrPSg8FQMCf+rx6r5A/ad9tHIPqDw2WgO+ewGbJ1u/AL
	ACAn60rl7L95tKzJwBqRwmBkRayXEeQNAHaeob3CFVzKL/friGUeeiHCggBAe8sN
	SP5fAuBlOAIu6BaxwARW16GEGx6TSkFCFjHreTrPaURK8xDxWFZi0uyz43Y9EHzG
	Bjb6v9PjmGDT5Q++YPmOwA5Eoq5otaoZ8YkpxPwRsGuZ6pmIU3yLNNWmUxHmY0+f
	qUX6x8bjYAkj68QL9hLxsq8qijDyxbh2Zn9InDH/MyUekd20Wk910UhbhnUpktAd
	oLwi64UjW297Evl7ppRFGlqsQwNX7L1hs4Uuyvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wOZA2XHh5KaAYWik6skAF90DIe1wv5cx7+J9Qif6X+g=:2EJoFBEABwWAyQfnMdJPBrj/04i2YfkkfF0ctZViRRs=;
X-ME-Sender: <xms:WmzzasBcBXLdREiLlg-kd9ILCoByzPWSzuiZ-5E75HNx7pjs-mC87Q>
    <xme:WmzzakidMDfXLqut07hOom9wotAoESICLgKSDodCmE9eL29q-dm2K-jlpKfG3frQe
    wX2x1WXQTVn6Rc_Iz_pdm-Tqn0RL9vo-Dn0DdYQVaRJoGy49PiKk9FmDA>
X-ME-Received: <xmr:WmzzatOdqs-Ik4XEsiE6x4DJBC95wiwoNrVUxniObb4ws4v3zjjhT1Fh2tH1bdfknN5BCTU>
X-ME-Proxy-Cause: dmFkZTF6g3OKTu9bmuykajJtT5GgxaU5t37f15cAatcYA61qhwtOFXktfE5PEf8GNbAts/
    LzG0Di3rxgfD0YFcr858wOKsDGKfn0LU8S9v2Ly3d2I0u1G8myBJvsXKuwU7CAW8ZGMJQN
    9FLPlPXZF2KXtaHhFTY+4B5eJylexix4DFZKy5TK9FmCzCfy+SJC6HopYXUKcs/+3bJ9vy
    gK1EhT1BKCqr7z7uDPw99BqXxWnwyIUJFOzccMvZvfRmgW/qpz8oOJWuuR78bYrBwcuV4X
    Gaqa9xKwJWu2A5RwHssqixKQ6AraAJYMTCVUX5zVofgmegWvsrmoLPLCFfF2rzpEiBqLAu
    83TR6yxLwGfgxqLUyub4WrDmR/chplJQNmosgGWPKsVBBQhe4cZulrxLZRJpLhpcmU+qR4
    sxHrqU2zvThoQap+gthGN30QLYtbCDbobtQrqF0tvB+V2Mj2xAa6TTDs6SSAzslxUQ9tYi
    Vhk+Vx9nEk5TvKlSSKOohFa/VSZilMP4fzxYwjNcBn0ym0qj4W3wGXTOGMxwv9+j1+bQJx
    1lyVYQl15gQg0AlHN3izucgLzcFmdmOLJE7rbJDnluKNXwz0e8YGzS7IX8OtLzlxL3Xn6f
    4X4SD4+7+ynuyW3RnoS9xk3Nt7eRC0JwAgpCUwKZAkrWYMWzbkBZf3qE8jnA
X-ME-Proxy: <xmx:Wmzzat4Nz1U5CijbW027HXMk3Y18Q_LTPeAAFZIzM59bj8ehPeqaAg>
    <xmx:Wmzzaj3ZDMaR8dkeAVnmoCFVwjy32kG7kZAjCbAcc2jX1nuky8Za6A>
    <xmx:WmzzamY4eaaAOpzSzmy7csNyVjo_7UAVXyK9XQbiCmlqaIBpnOg3rQ>
    <xmx:WmzzajBa5RcJ94vazXKtKkaJCe97LxyzSht4daj2owgNTcaaskn9NA>
    <xmx:WmzzakhJxtXJHVtmpHC64p3OeudCRNgaJ3eWc8s-29TYJrwz8PZptYbL>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 14:11:22 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y v3 1/3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Tue, 10 Nov 2026 14:10:50 -0500
Message-ID: <20261110191058.1747963-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110191058.1747963-1-oss@fourdim.xyz>
References: <20261107060628-failed-5.15-6320736af7dc@kernel.org>
 <20261110191058.1747963-1-oss@fourdim.xyz>
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
index cc49e651907d..9a883e476684 100644
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
-- 
2.56.0

