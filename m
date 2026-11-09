Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189568;
	b=OahrOu6koMS8y4NBQAVK48xBBXYuP8SFTMhnMmRTmvustUMLjKRBURnZJErGfMavzk1K
	 yV4aAAtXSLDIp4jXmm4YNdnM3dK9x40L22FmPlPyD3NhNTNmTu05XE08I3BeRUW0rVwvQ
	 bxnD8k4riSOqDHRbuNZ9d292Js+/+JQ1b/+6lGREyrrw1t7rjJdndaTrMAz0ttq1WU9xX
	 QbhQTORejAkPcnSTc7gn8fr6pTHgyLuH0J66lg6cOQDD1m05nbXeDsdpmWT29v5sNVFkz
	 228vodvAAbiQFUt+GIWvb/hdVe5CyRyBTpYGT+tM4m+q5Barpqp82SpjfP0ODPKcgnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189568;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=jo7jKf6nrGUk1TsyWAxXIoaS0KJU8jkqabnUKHQ3jwU=;
	b=K95U5s/55goQEi1ePJcs5dAQBRXielmkVQ3bk9kegVPanIkOeRQXXulnYf0nRuKVXulN
	 QMO9QftQ2vahI5FPXnnzqWt7d1yaFwqoqNZO9AwaOseMCezBW2JM/OZBT8Q0KiZYEoZOH
	 xWNWq/rHLgiBxWA7G3UygxEaGMEM54RzB7O9EmMWMPMSuOqQUE+3Xtvfd8jrmh3eqotKf
	 qS1AB9EOVDIv19bZ/uB1lK2pqFOWJSVZJNH6AqUAG28wRv75naOyz/CRDe7d2Se2Eks2J
	 kH0HpOgBYnAdXJLWOYT9by8yZqfcjB7UQsTwCmwiJ7nHnh+Cf1GpndFub2Z2Fj3O4kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=OGQ3KZLE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XnsgO9Dm;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CB606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 01:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D57CB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=OGQ3KZLE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XnsgO9Dm
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1574BEC0582
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 20:59:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 08 Nov 2026 20:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794189567; x=
	1794275967; bh=jo7jKf6nrGUk1TsyWAxXIoaS0KJU8jkqabnUKHQ3jwU=; b=O
	GQ3KZLEpnbAgsEWfb9oYGdWRZXTzQgBaDY7vscvqomHf2zSlwLPHyL6K6eX0Qfbw
	gFOzvTp+0yn8CzY6c0Fwj+9ZW649gpHg6ju3QyTx/eDjd3THTt6zXWYLfYY8bKkL
	ZwPzwziR1s5Fk9J2X3Ihkiv8D6bFG9qI+j+5YApt8sKPfD8277dYjYDofibOfa9C
	tVSwWavBbTtQ/Ur1KoOxFSMG8OeeyNfhp5/+/PULWG1bXGl57zV5ID5N+qJ+iO85
	rpFAUjBzqHvGxGZO34zqfK0eIfsRMj9MBIOQz6x+JyatilRtBZ8OXKHlAGgYn+0c
	tka+6cLJi9qwqpuKcqR4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794189567; x=1794275967; bh=j
	o7jKf6nrGUk1TsyWAxXIoaS0KJU8jkqabnUKHQ3jwU=; b=XnsgO9Dml/wUPxmaj
	GNZjqpAGAaHQ0UH2lDuLCA2Uh2syxPMOnftyDDbT6YEndF1IG1VAa+R6tts6TY0U
	kQ4tJtODdLnAlS5yupKwUGhbfr3aKOL4BYepDis+K7wTO0yo0IOq9jFcruh1p9iV
	sO5/7QLAX/K9Nk8WAcVjlkWSmF0JghWjFKHQCTjdjSBxJnQzgYA1/inJ0CFRwvTA
	opRb4B/LlbL4+UvmTyKY19mP6TOxvxcj/7Zu3TpNUbSiGdjGe2GZBf+iY75/78UR
	os3FVpV0piygpN3gt8+rJyaiiH+j8rFsyZb72SPxX46+h+jPPiIrCTiHWQR4SPU/
	+7d9Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794189567; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gSqn2wXvHmDVz93CiWYtwprIzkuSCxg05q906qzzZJp7NMv
	SCB6ToKCCJ4+P+eJDubQfQoQKdy7TxjjVphvFmmSA0jkNkjiCkdszsY80eE1TvZq
	OXzJdDfa6OlPpa+4jvrI+0cvfOH3sIGaoe88ZRTH/4ez5LSnwMMpKhGASSr8r0DN
	8xu9Ekn8DFpK5invs3VccROfPwC0UUgxVg0V7akGlcL/iGQaP5oaDdke7IgkcSkO
	MmY5g44xy43236BppmLAqBq0MhYEl1VF0TSgGAnmtjsyKqAviDriiIHeKr12LQUq
	EMkzHmRkh+DxdjY976kKiW0KtxBZ9kQbywIxPfQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3xgo1zj/CsR0VYb+pGRb9C1tBSy2/pZIiRk4tZl7Q9I=:xapEg7X0bENqYcNVY2v6FNYBAGHN/YqajNO8hSWKD7c=;
X-ME-Sender: <xms:_yjxapvy-vQ8-sB5DoTH63wzHxFMhE1hvcGcBabbStGxXpgb83EGpQ>
    <xme:_yjxaoctSK5ze6CQfl3_k3FmDSbBUb5W8g7d10VXC6FsXLXQ7hREuK7xKskfNcoVY
    Wmg9llD6rEASy7_il9FlwkfFfQgJa2fHLspl_DbbDk-oilFDZ0_D6OpTg>
X-ME-Received: <xmr:_yjxaqaiX0w20d8-7g1YkOz68vNPcFfbQAOXR4EsFn7yd7RBhdvJopz4xPAmrF5J29_Kz4s>
X-ME-Proxy-Cause: dmFkZTG2cyxO8u/pGkbkM3O4xTZi7ycXFHOalX7nmWsfKsiFkgbBQxzNLcO/5kGMGioxE7
    uaap0KH87XZjutXjRWOeePa+tMp31zsyF5BDF4qdIMYzigW6z10vT85guxyaMaaMuOctJw
    ZSTDrnqzD0Y9bgkgqorSkpaGCYCuCaMmGUUBPVU/GpSCK+yTsDqxNWJFKhtQurUliP1EG8
    l0wQwXH7KAGA+Okb4wwJ1l1LhQWQRvxkNORbQdBFHzSbqLSQKFElsaXwVK+eA+Dwb+WUYv
    +uEuGRVO7fatIeH+lHZsaNdLUZwKhAnqsHWh+15zoG+XbYOEIHB6lQAfcyfEGs2Gqp1sk2
    yB1oB3YopnTehG4eDnT/aXiplC5LimlUl7JHSg0ai+9+VzFWHGrg+8ezDPVFyuYZT/DavH
    JJXpZGenJthWu/NNB91VcgYgZ7v5p9QmGBMG5HAC7KqoZR0rQJnwSNFZzS0xVHrSnBQqVC
    w+1PnoPD31u9zo5QJMjL5FL85Xw2ryDPIFwc2DPgh1vZHK5A6MsduRFVWXtB3E3lX4OGkC
    NN8+Nzvdb0ToS0vlbU4TJNUtHM9jqBkfTFbVes4qVsjWgkyzthXtupEvI5bQ1B18pMnjbb
    pXIm7lxSqOYFdnSSztznzcrI2ch41YM7MAaK0il66VwMXNJ6F7FkY0NUjFbA
X-ME-Proxy: <xmx:_yjxarWtu33Jaj03EtvLJ-PnGCPQ9oVTnQkzRTcfqT9n2BlQazLPzA>
    <xmx:_yjxasgRnClPnPlfFUvGKfiAroJBgqE15QaCsTrpmtrxM1TPRovHKw>
    <xmx:_yjxapUtZWG__X3-7J9UPVI_dfjhpvtWCDumW6mJHzuImMqEJFSlsw>
    <xmx:_yjxajP5-HV5NDidbBQUBg3x5xhSPiGp16j63VrhwdsH8jXmFz0jyA>
    <xmx:_yjxavN4E0UzxA9Gb9tUuJ9lH1vlAYmKh95EBQ3WUSzR5ADzjpgAUQXk>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 20:59:26 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y v2 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Sun,  8 Nov 2026 20:58:44 -0500
Message-ID: <20261109015902.3034747-3-oss@fourdim.xyz>
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

commit a518b9a9ef6ee3b18ecdf6ba5360c608aaf969e9 upstream.

Adjusted context as stable does not have the lockdep_assert_held()
call and the __must_hold() context analysis annotations, and
l2cap_connect_create_rsp() still holds conn->chan_lock and returns
through the unlock label when the channel lookup fails.

Stable still has AMP and A2MP support, which upstream removed in
commit e7b02296fb40 ("Bluetooth: Remove BT_HS"). Close the same holes
there:

l2cap_do_create() sends an L2CAP_CREATE_CHAN_REQ whose response is also
handled by l2cap_connect_create_rsp(). Set CONF_CONNECT_PEND in
l2cap_send_create_chan_req() as l2cap_send_conn_req() does, so that
the response to it is still accepted. This also makes
__l2cap_no_conn_pending() see that request as outstanding, so
l2cap_do_start(), l2cap_conn_start() and l2cap_security_cfm() leave
the channel alone until it is answered, as they already do for a
pending connection request. l2cap_do_create() itself now does the same
instead of sending a second request.

When an A2MP Discover Response lists no AMP controller,
a2mp_discover_rsp() falls back to sending a connection request for
every channel in BT_CONNECT, including channels still waiting for
security or the feature mask exchange, channels that are not
connection oriented and channels already setting up an AMP link. A
peer can send that response unsolicited, and the request it triggers
sets CONF_CONNECT_PEND, so the peer's connection response would still
be accepted before security completes. Only handle a Discover Response
while our Discover Request is outstanding. Move the checks
l2cap_do_start() makes before sending the connection request into
l2cap_chan_conn_req_allowed(), and add l2cap_amp_fallback_conn_req(),
which only sends the fallback request for a connection oriented channel
that has no request outstanding and passes those checks.
l2cap_send_conn_req() is no longer used outside l2cap_core.c, so make
it static.

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
v2: Pull the payload of an unsolicited A2MP Discover Response before
    returning from a2mp_discover_rsp().
    https://lore.kernel.org/stable/2026-11-08-1-daily-reply-0003-l2cap-a2mp-5-15@kernel.org/

 include/net/bluetooth/l2cap.h |  2 +-
 net/bluetooth/a2mp.c          | 12 ++++--
 net/bluetooth/a2mp.h          |  1 +
 net/bluetooth/l2cap_core.c    | 81 +++++++++++++++++++++++++++++------
 4 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 57315b9dc059..47156c773362 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -998,7 +998,7 @@ typedef void (*l2cap_chan_func_t)(struct l2cap_chan *chan, void *data);
 void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
 		     void *data);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
-void l2cap_send_conn_req(struct l2cap_chan *chan);
+void l2cap_amp_fallback_conn_req(struct l2cap_chan *chan);
 void l2cap_move_start(struct l2cap_chan *chan);
 void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 		       u8 status);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index e7adb8a98cf9..2ef7e3280325 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -196,6 +196,12 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 	u16 ext_feat;
 	bool found = false;
 
+	/* Only handle the response to our own Discover Request */
+	if (!test_and_clear_bit(DISCOVER_REQ_SENT, &mgr->state)) {
+		skb_pull(skb, le16_to_cpu(hdr->len));
+		return 0;
+	}
+
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
@@ -254,10 +260,7 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 				continue;
 
 			l2cap_chan_lock(chan);
-
-			if (chan->state == BT_CONNECT)
-				l2cap_send_conn_req(chan);
-
+			l2cap_amp_fallback_conn_req(chan);
 			l2cap_chan_unlock(chan);
 		}
 
@@ -1050,5 +1053,6 @@ void a2mp_discover_amp(struct l2cap_chan *chan)
 
 	req.mtu = cpu_to_le16(L2CAP_A2MP_DEFAULT_MTU);
 	req.ext_feat = 0;
+	set_bit(DISCOVER_REQ_SENT, &mgr->state);
 	a2mp_send(mgr, A2MP_DISCOVER_REQ, 1, sizeof(req), &req);
 }
diff --git a/net/bluetooth/a2mp.h b/net/bluetooth/a2mp.h
index 2fd253a61a2a..1bf31aed8547 100644
--- a/net/bluetooth/a2mp.h
+++ b/net/bluetooth/a2mp.h
@@ -15,6 +15,7 @@ enum amp_mgr_state {
 	READ_LOC_AMP_ASSOC,
 	READ_LOC_AMP_ASSOC_FINAL,
 	WRITE_REMOTE_AMP_ASSOC,
+	DISCOVER_REQ_SENT,
 };
 
 struct amp_mgr {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3204b95742a8..227b1c8f35ca 100644
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
@@ -1305,7 +1327,7 @@ static bool l2cap_check_efs(struct l2cap_chan *chan)
 	return true;
 }
 
-void l2cap_send_conn_req(struct l2cap_chan *chan)
+static void l2cap_send_conn_req(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_conn_req req;
@@ -1329,6 +1351,8 @@ static void l2cap_send_create_chan_req(struct l2cap_chan *chan, u8 amp_id)
 
 	chan->ident = l2cap_get_ident(chan->conn);
 
+	set_bit(CONF_CONNECT_PEND, &chan->conf_state);
+
 	l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CREATE_CHAN_REQ,
 		       sizeof(req), &req);
 }
@@ -1592,6 +1616,26 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon,
 		hcon->enc_key_size >= min_key_size);
 }
 
+/* Check that a BR/EDR channel may send its connection request now */
+static bool l2cap_chan_conn_req_allowed(struct l2cap_chan *chan)
+{
+	struct l2cap_conn *conn = chan->conn;
+
+	if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
+		return false;
+
+	if (!l2cap_chan_check_security(chan, true) ||
+	    !__l2cap_no_conn_pending(chan))
+		return false;
+
+	if (!l2cap_check_enc_key_size(conn->hcon, chan)) {
+		__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
+		return false;
+	}
+
+	return true;
+}
+
 static void l2cap_do_start(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1606,17 +1650,23 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 		return;
 	}
 
-	if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
-		return;
+	if (l2cap_chan_conn_req_allowed(chan))
+		l2cap_start_connection(chan);
+}
 
-	if (!l2cap_chan_check_security(chan, true) ||
-	    !__l2cap_no_conn_pending(chan))
+/* A2MP found no AMP controller to use, so send the BR/EDR connection
+ * request instead, if the channel is still waiting to send one and
+ * passes the same checks as in l2cap_do_start(). Test for an outstanding
+ * request first, as the security check may start authentication.
+ */
+void l2cap_amp_fallback_conn_req(struct l2cap_chan *chan)
+{
+	if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED ||
+	    chan->state != BT_CONNECT || !__l2cap_no_conn_pending(chan))
 		return;
 
-	if (l2cap_check_enc_key_size(conn->hcon, chan))
-		l2cap_start_connection(chan);
-	else
-		__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
+	if (l2cap_chan_conn_req_allowed(chan))
+		l2cap_send_conn_req(chan);
 }
 
 static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
@@ -4426,7 +4476,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 			goto unlock;
 		}
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan) {
 			err = -EBADSLT;
 			goto unlock;
@@ -4443,8 +4493,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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
@@ -5269,6 +5322,10 @@ static void l2cap_do_create(struct l2cap_chan *chan, int result,
 
 	/* Outgoing channel on AMP */
 	if (chan->state == BT_CONNECT) {
+		/* Never send a second request while one is outstanding */
+		if (!__l2cap_no_conn_pending(chan))
+			return;
+
 		if (result == L2CAP_CR_SUCCESS) {
 			chan->local_amp_id = local_amp_id;
 			l2cap_send_create_chan_req(chan, remote_amp_id);
-- 
2.56.0

