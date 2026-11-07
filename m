Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093437;
	b=lFGThWiAJVwldiJbgsr19w0mMt1YIBTnUXbtyxkP1jzfwgcI9ucpKKRAzu6g7ilEM9nI
	 gM9vAdiS1sEJN9PAQtOZooddAOJO6FOwwdx0O2W1uGqATb/Iu+oVQDjSeybl8ccg2YEjh
	 gGeKuzsIFbdrZy5vOpbHot1qYGwQZnR/3mdch9LtzuXMqQ3auv5UV50mUwSwpKNxzgODA
	 9FQ6lh20YhKavpzayl0KMHHNmUjv8kpXONHMM/wXQ0GNc0MOlRvJRtL8z/JpO0ql1MkOj
	 x2K1+bOUWyowUUxQVwLHMxbRX6k9Rtx2cm/zgPvKtAo7wxsUsNdpCahCuhoePqhei4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093437;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=yJb40YSjrTU2BR8qn8hkq6t6ZT3ipaBBNoHP9Gp45HY=;
	b=M6Yy/Kbolck5WF9Pay4y0ogEfG3yUP3t4rbP/Bk+tjGAlZ0f2JzztwLhmOxtk/Ywh9bQ
	 6w0AfzjSSbXoPSszEjBDRO/booNmldmYiTLWwlXRs3GQHAChVdMKjBiaFPqHQNM7vMeXh
	 RSjsrFBsvgGR4mB41Q6qeqwZ+eZ58RWmtjV0Eqz+nWrVnKl99eg8QLrdkXIoI412vcsWg
	 YfD1RLaN5av6H+dtlfFhgBZMMXP1aUapmyyOzHLoT5UcNpABLZSJsV2uK9lT04RKwHY2B
	 74r+HG3W9apIZXTU0t3fM4X7YNbVeOIuy/QxQFl/PKEM7sUtpTwLWTNYzZ9kYMhQdzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b="l/LhqQmT";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="mDU/rhWV";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8472F606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8472F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=l/LhqQmT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mDU/rhWV
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 10F231D00128
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:17:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sat, 07 Nov 2026 18:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093435; x=
	1794179835; bh=yJb40YSjrTU2BR8qn8hkq6t6ZT3ipaBBNoHP9Gp45HY=; b=l
	/LhqQmTwmo7Ki1F22cJyi02runz6mtybC8fmvE6ypgZpzoD13vHcdOzk14WtVIJD
	9D1w7oShY73HegpNLZZELrGGke/pP7zKLgehq/FrO5zxHjxkQgUK3xn3KzQd1XyX
	ybANbTrycrpy0SGkHU/BNSRHVlDiOzRNNn836D1KQ8lDpm9mSmv8xctGm0LLJt4l
	aJaMurEJhqax7NyYigjZG8gWx7Zm5pY8IINQtAfNvWRhilYJc1M/SaMtzcrKUbWb
	TycaUJdpmaJdr2RMfmF1qPqWxcqSGNu1IWe7KCqbizcoVO4knh3BC9Dwt3sU7vpg
	pBt8PWId+GSGIxXVY19jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093435; x=1794179835; bh=y
	Jb40YSjrTU2BR8qn8hkq6t6ZT3ipaBBNoHP9Gp45HY=; b=mDU/rhWVj8Yk1y1Vj
	HaDo65mpfvHGZ4TaruRA3+7/7GW4cGPD65Y6MhN1VLqJnkco67TfJkAAI8RLjI3+
	M4XkuRobTpaARhHzgpMfsiqZ5I3jhHb2h0+TYmOdTVSJJ/b3v0Whl1Eo3wnZd0cP
	5N//7gVFpiU/yIz73N2qzWda/ykhi6AO32ilR82Xp7bikLOgUZSZgXSrhxNexEIl
	XTUC+aTY0IxuqL1v0QkWZrjiGwDh0OOXIa7ylqJYR+LxVH1MfYW1BRYKkFDO4XRR
	oTnU5sJVeN6cOv1szZQG5RtBJ6b9paqt+5b1AqL6q0G+/jWRvc5uQyedQHnH6H4L
	h+vjg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093435; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sPTIqWGga97TkhUVFKyh05iO7IeWGNWv3IosJQTx3V1DuTC
	fV/Ln7xOngcBRdVot2J20A8siTMjcbs/Y3uQUxhC1lSeF9BY+84q7+d0Y3/Qz0z9
	uOQ5oqAzNAzNmO/HKq0isk1m5GWVC3TQ1tq3qKhpTmm08WekUa5Lm9qotPtlY1sE
	y7NoFtOkZvJlOUhCPAwuW5J+/6IubVGSiLUrNVnqQFAN55tJd4CXTVhMl48c03zq
	Gw8/SVDtb2gRMQI8HsAvxkh6wzxhz/SPcEsFoBVMbqajTqZ96QYEZ2ugF3m8XhHh
	PIlk14cZNk26RO6a2KW7An5Su/OOdFGKdRbm0bA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xrS9mmJHiJl7BUVn4WNqSqvoyx+ydOYaywwA986TE0M=:nZik0kcTttO/XSq3vbX0w7M/8MldBruDMzdr2PgQO1w=;
X-ME-Sender: <xms:e7HvagmMtC-oP-BI3OEnN1j0r_ktfEmGJd4J7-1BUkvmbi9BGrOMbA>
    <xme:e7HvagCsRKDjvwgyA3ro96gUx-gy1SBVl7AhrL9l8r6dzcbXbZSK7SRUUevfym9mN
    glnypoKtW2Kxctsefz4mkUhp2K1WltTb1FqlVMepm6SN48upmzO_a0Z>
X-ME-Received: <xmr:e7HvageFn6f4Gwpqy4y0396abWlGZiiK_wGJoqD-skFkTiDFvnQ8zWz79KkBMq1ieitQuII>
X-ME-Proxy-Cause: dmFkZTG4OKBtoL8ZCR/RILZ9HVIYsiyedYNwSoMK0fs3pjy1KoVI5QKNGkIR+qu2UJo0gZ
    HzA+zmsNEg69ZzY6X0FWa+zLkMFDxwNIsl9Ph4OTn+01QWTkR/Jo/5qW1rJ9nmoNurDIue
    QT+8hE5vQWriKMP4z24vPZOqUxClR8mW3s+b3sdgoVw/1pbgx+Rgr+CuyWm0Rw7VFfh3wm
    Ff/aXmVih5IN3xK3FyGhWQgzJM3srbjX1XKkRojmxjm98IEvfarefkGccvPNsccoj0M2Fw
    IAKskIg7qpYthFMz478vaSMrfqTxTgpU5kYVf4IOXxXEkR36tX+BOJ2DsnIOetXZBNvFcc
    82n3d5jti2YTwpH6NzTL/R08JRANBbXZmOW2R97qw5tjS4U+prnaz6pO4eb3xfWQB9ooBC
    E9+4i0/47p3SP8efthKaA3HMagL3XghDPZPPbGPHjh0TwW7ZTQ6KoCqDqYPshSVRA05dIi
    +gG8DZqT59Emo8GlPIkvg0Zs+v5wSuBIhCR2IeGRJBVYxbjp7F7UBY22o25XbUWLKRGWY+
    JuNlzIJuA2Uai7AVo4ZKWsPdqcMVgqe4krsnz3xQCwptfDH3Y0h2MMZYmOTgvg3/oYP+wy
    /BAFkfmq+F0voRaORUDJXryjRj6dg9Hf2WGF4j91wsZsfIZmnILlSAVwoHAg
X-ME-Proxy: <xmx:e7HvarJrqk7RxQMMFQ49lnC630MenB3DZ1HrMzdi7Ym6GrEfmWT0oQ>
    <xmx:e7HvajeyAd3d4YyozXzl9WOb3s-1qUbNbpfZeqQ6wiA3ZjMi0CQ4VA>
    <xmx:e7Hvai3-HnhV8sByX6jlaY0p5tQ_ClrCN7tUCE4n3r6MThbGYLPjag>
    <xmx:e7Hvasie3AYLAWGkMTR99MzY0ETTb-w7Hwect9A5Z0dO9mqqm2uczw>
    <xmx:e7HvarAj5OuGqDjdGoTXVk0I6ItwwDbwBat713kcuXEAAxz2iqD7313P>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:17:15 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 7.3.y 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Sat,  7 Nov 2026 18:15:46 -0500
Message-ID: <20261107231558.1868970-3-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107231558.1868970-1-oss@fourdim.xyz>
References: <20261107050447-failed-7.3-6320736af7dc@kernel.org>
 <20261107231558.1868970-1-oss@fourdim.xyz>
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
call and the __must_hold() context analysis annotations.

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
 net/bluetooth/l2cap_core.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3e57c605cf8b..01945c55e1b8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -158,6 +158,28 @@ static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn,
 	return NULL;
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
@@ -4298,7 +4320,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		if (!chan)
 			return -EBADSLT;
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan)
 			return -EBADSLT;
 	}
@@ -4311,8 +4333,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

