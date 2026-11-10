Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337885;
	b=5nF9Wh85PblB0McWepjBTDULThuFmnr+9xYRvsJCQZzlbv418lgt3fcpBvA8GHDZso4c
	 6Ij4SVDq6h1vgAVVl3Sqt/bwWhGesgnvLwvBsS/0sM8E6Itjs9Z50/l7pkfU/hS15lqm7
	 +C2bgBprvJnDxJhRzNJIY7CYtm6akUCsSefLN0PQxDpQgYhyuaTpTxOHSkprFY87U8ZCF
	 38wngSeXgmDnIfOcaOrtSztDm8j1OVrwgYSJl0U/lmukOyknYL+OjU2Uz4GEWM+GQJgC5
	 Z7Div3RAkxnhTO54J5j/7Iou7GRzs/mb0++96GpF3rK6xxje+MLs4t4wnt59ZS4lOXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337885;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=UnEsWmRTpv1zLI3fSNPr7/xH0ra/KDEqQrGP6fBGvRQ=;
	b=DQSamP5YIxDfbHZM3f2o4JDX3cDT+bPZit05rC07L1TSZJiviuKi2836Oxzs9cgIp8Tz
	 p9hlK19mSEBnmRBGbTpxI4FLgvOyJQOx/v4aIPek6l5yyDb3NYUpzu3KT7YBfJfxmvoEe
	 8ORjyb/y9f8A2OjnSZYfChNbcoUn9xSltmXLT0PoXFCQXCkPLaIxe05zV2yoRAvR91fvH
	 dywaCZnwSxilYEiVcPxGE2niGVeVEsOVt4EcmyFlDkY1cadfPIXT7I0GPVZBFGZLOAOv/
	 86WPkodi3n1oIXaAkS+zUfQJ181Tak+dM6jztb6+lYr6ZUdCztk8x/Rs4YLa+jS8fZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=FrdxEKGG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p7G48esU;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D55606A33F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51D55606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=FrdxEKGG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p7G48esU
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86F031400139
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 14:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794337884; x=
	1794424284; bh=UnEsWmRTpv1zLI3fSNPr7/xH0ra/KDEqQrGP6fBGvRQ=; b=F
	rdxEKGGzi4IYBGgs4QY+aB+Xibom4wVOyIF+yrjf+kBryRWSoDSJDwXdHDBnliMq
	S68aT/eygbHjeGzG7zxaFqlotV5z3NCUu7hSsh8x+JjscguiBZuwrDuK6nhIWx/s
	v88GZhGSKs7z62LHqBPAsgZam5FBYULVve/jod7f4DtUwzEQPc0fM/AorZAcjN/l
	X5+z19H29h8PKLfCyzJH/EGUG7ZKdDPTck5WjsRMtN0SkzFyIXc8/eGeEXM5yGWV
	OUiLpmJxuvWQhcnJvAtwom4iUC1crL/yZ56KsaT2X6TrNSDSRNjYiDwOho7gsDz+
	wOieC1jDru/ntvBwyHnGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794337884; x=1794424284; bh=U
	nEsWmRTpv1zLI3fSNPr7/xH0ra/KDEqQrGP6fBGvRQ=; b=p7G48esUNMNMsZouE
	dxqrJC6hlNEPS//xiSMrPYqOPTzHIvg6L6W1zIg6/PaSUyOgCCUbZBe1zJUCUeNT
	vgK2bNstxelfqlq2hFTGM/q2zjKjWKGAj9yo7lFZaYUHrvCkdcN3qgSccenlcei9
	0r3W+30n1Qh+ow5EkP129fszA6eQBKK1RoatUpsZIca8chg16XMETbJPvZNx9tFN
	t4T3JTAX6o+ZkGmG0b97W+MBL+gQTN0dKLu46JlsY/5yCHdiiDGY8Z7DCihe6tOk
	8Y+UNQ0RgFToua+qOpY1EPMfDOXvUlbLb+GOq99Qbu9g4KhrHJ/ErAOwreMYgD4v
	jhksg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794337884; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CZmVF7zgKb/H9WlKJGyDdb8XHLZ/VQodE/pHeNk3kNpVvNG
	6Xb7m5oI0PH7CUtZjyWiGOHfg5Zwc0fQtul/Aghh8qgQHJeyCUPqd+9LL4Xf0BBN
	ahYRj4l5nT2YS8tQBh9uZqW+SpGKSya+o1wLqFi5Lh51JnsVy2xNcmZuyvd0VVqm
	QP3GrnxhIuZnxHrVDBVjghrTIuoLAE+jxtsec9y+xCcPrKahM1OBxVCaNTORu/D+
	72TsNlc3jq2ZqTCDMQWpuJ7IEokXI8bYO7FUZyZfid/VW3E/Rqv6+J+D/o8g2MyM
	NQbjVkZM6Q3okoyvUfhfWqTr+QzdPNS25vSyVug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:muHyOwfSe3cT7Mw4uz/a/1H2q9Ctavorn2nURAFKBJA=:9NKkbD9Hok+QO3yPi+a1B/l8nETqmCkE08qKR9xDycw=;
X-ME-Sender: <xms:XGzzasdrLqlZffEF2FoMa6Arxu6nHocQBqNO11yZES2URAg6o2fRkA>
    <xme:XGzzakNNoINHo2AkBLHhYszElfM1VDq4XZt6oT3wffTzoiLzIvUeCufHLasbCAv_X
    JMPwXgHLXLhtBYY7m-tb45gV1_-a3gu-qfFvFd8mXmxu_EqS183hQRs>
X-ME-Received: <xmr:XGzzarINuJjBGKdIiBgmAHjI40uR8ps8fiG7y1o1hqwshcDsfBobw9VwutlfxrOuG-quclo>
X-ME-Proxy-Cause: dmFkZTF6g3OKTu9bmuykajJtT5GgxaU5t37f15cAatcYA61qhwtOFXktfE5PEf8GNbAts/
    LzG0Di3rxgfD0YFcr858wOKsDGKfn0LU8S9v2Ly3d2I0u1G8myBJvsXKuwU7CAW8ZGMJQN
    9FLPlPXZF2KXtaHhFTY+4B5eJylexix4DFZKy5TK9FmCzCfy+SJC6HopYXUKcs/+3bJ9vy
    gK1EhT1BKCqr7z7uDPw99BqXxWnwyIUJFOzccMvZvfRmgW/qpz8oOJWuuR78bYrBwcuV4X
    Gaqa9xKwJWu2A5RwHssqixKQ6AraAJYMTCVUX5zVofgmegWvsrmoLPLCFfF2rzpEiBqLEb
    D7U01j286TZRzli9G+5Uauum1HS3eYT5qfWbvtDqVRQhl79sJXof6YDwt/ApygOOt10avy
    NqXAwfVcgAw5KkW0ASGxuoo7q4tmNA3vvwvWar7Sj79ITVQ+t4g0gQx2gzb6+3zjnxypT0
    4iuhqp+tCbSssFpaqu5GGO+h9fXM+9Fk+1SZFkEcHeSwdRdo3JM6JM5xBsgx53zIGAPZ5C
    43A/y1wCFNoDr572OhsHzlJ9HmiCnPD3bGqjLLXeW5W9g1sQiKK8oBdkOkhRyi2aCtK9N+
    UzyMA62bMCkSTB9HQHwmjA/zD82WH05Juq5CGvqSMrhFA45yJOmF/LY0k/vg
X-ME-Proxy: <xmx:XGzzatEJnoapd3ZChksPTItVZY7yoAB7t9QNeRny1yifs1aV68zbvA>
    <xmx:XGzzarRxjoIES4uun4M2baCCNjxVwOwCiWUUSMDke6B2gLv9z4opxQ>
    <xmx:XGzzahENVhhvKhiJ5CItDRA8c2hBh5hUuVE7eqctziTGVIWjtSOcdQ>
    <xmx:XGzzav-IoVEpUZQcFgbD-DflOFewAu2l4QefkgZB4BR9xZLij-HNoA>
    <xmx:XGzzal-dUPPqHXoC9-WClbGVHjP5fyedKX5aDSgw0XarUZiwhNQCBpAY>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 14:11:24 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y v3 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Tue, 10 Nov 2026 14:10:51 -0500
Message-ID: <20261110191058.1747963-3-oss@fourdim.xyz>
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

commit a518b9a9ef6ee3b18ecdf6ba5360c608aaf969e9 upstream.

Adjusted context as stable does not have the lockdep_assert_held()
call and the __must_hold() context analysis annotations, and
l2cap_connect_create_rsp() still holds conn->chan_lock and returns
through the unlock label when the channel lookup fails.

An outgoing channel waits in BT_CONNECT until security
and the feature mask exchange complete, and only then
sends its connection request. A peer can answer it
before that with a connection response matching our
source CID. The channel then moves to BT_CONFIG,
completes configuration and becomes connected before
security has completed. If security then fails,
l2cap_security_cfm() leaves the connected channel
alone, so it stays up on a link that did not reach
the required security level.

A connection response with a zero source CID is
matched by identifier. Another channel can hold the
same identifier for a response it still has to send,
so the lookup can pick the wrong channel.

Only accept a connection response while our request
is outstanding, and only look at such channels when
matching by identifier.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v3: Drop the AMP and A2MP changes, which are not in a518b9a9ef6e.
    https://lore.kernel.org/stable/2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org/
v2: Pull the payload of an unsolicited A2MP Discover Response before
    returning from a2mp_discover_rsp().
    https://lore.kernel.org/stable/2026-11-08-1-daily-reply-0003-l2cap-a2mp-5-15@kernel.org/

 net/bluetooth/l2cap_core.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9a883e476684..fd6c39c5c81a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -185,6 +185,28 @@ static struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn,
 	return c;
 }
 
+/* Our connection request has been sent and is still outstanding */
+static bool l2cap_chan_connect_pending(struct l2cap_chan *chan)
+{
+	return chan->state == BT_CONNECT &&
+	       test_bit(CONF_CONNECT_PEND, &chan->conf_state);
+}
+
+/* Other channels may hold the same ident for a response they still have
+ * to send, so only look at channels waiting for a connection response.
+ */
+static struct l2cap_chan *__l2cap_get_connect_chan_by_ident(struct l2cap_conn *conn,
+							    u8 ident)
+{
+	struct l2cap_chan *c;
+
+	list_for_each_entry(c, &conn->chan_l, list) {
+		if (c->ident == ident && l2cap_chan_connect_pending(c))
+			return c;
+	}
+	return NULL;
+}
+
 static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src,
 						      u8 src_type)
 {
@@ -4426,7 +4448,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 			goto unlock;
 		}
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan) {
 			err = -EBADSLT;
 			goto unlock;
@@ -4443,8 +4465,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
-	/* Ignore a late response after the channel has left BT_CONNECT. */
-	if (chan->state != BT_CONNECT)
+	/* Only accept a response to a connection request we sent and that
+	 * is still outstanding. A channel waiting in BT_CONNECT for security
+	 * or the feature mask has not sent one yet.
+	 */
+	if (!l2cap_chan_connect_pending(chan))
 		goto done;
 
 	switch (result) {
-- 
2.56.0

