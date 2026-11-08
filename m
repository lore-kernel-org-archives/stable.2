Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096362;
	b=gFrjhSAaQPw7q+AA5iYGcbloG1EYjGdAXLeGMXkXHH0x1dfHYgMg/FrFswAgjY0CWPCn
	 YhmlNcebhS7OIEkTyyygW9dRRZQYXJ5IQbpSsO/T1uiQhQBLY898RBXG++nfI3VIrOJxT
	 E1B9ETZIrBNMI+cp+gavSg9AW5rZoE50fMRBQD5nPME6lD1QtANmO65+PCP684d9wta+h
	 M/Itr6E019InyXgWgka34Q4C2g23QT9lj8+q8VxRuQLiTrhDda/6xP+g8GFddB3NGIRkf
	 k8u7V8s1jbdUE7wTRd+shD84aeROKYWZrIOQJZ5U6FsDswy3rTslZw875UusSdTiFKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096362;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=2MdCeDdq4gx1mPuKuX3DOwDLlWXF/u4+UwqgxkHCTrY=;
	b=MJuSm1Nid+dZg3K26X4x+pW1eSGdiPN+N/FSlxGTweL/zYsZjt4ztQW2RMH/ZwIwzqff
	 R2oOTsTTIxETRdRKH9vyaKgoUokbJwN70tIWb5BdRFz0p+nJy1f7eb8OEppJa7f11GKuE
	 iN9q8ejZ2x/CfwjphSyTIE3ZCntIT1QLmZefT7DSPQ/i91sw/eyjxdTxTVRF4tBPF0ARj
	 klYlcGqQSrLs+kZHtk5WM7+SsVltEPrKz714jz3TrX3D2kzeDo7vW6S1fBS2IfRTiBtmS
	 c/hOvfsRQS21prTMKJic8jyJGSaTp//VcSghxTNWuFnByKD2Yhj4cwGyQxpBOlLsbWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=MWLL14b1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zstAqQ3J;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29120606A326
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 00:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29120606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=MWLL14b1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zstAqQ3J
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6245014000B4
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:06:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 07 Nov 2026 19:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794096361; x=
	1794182761; bh=2MdCeDdq4gx1mPuKuX3DOwDLlWXF/u4+UwqgxkHCTrY=; b=M
	WLL14b1Kqd4Q4rld9d0qLd8yDlvHrvN0oR/i4GN2MUSWuCtlOLztgwOcU/Z0RIVR
	N9BWcj2akIC2n7R1qjdMDwYMNITsbVP1OY3x9O+ESAy4ozifgsCAxEGqsr6dSzgo
	07JoSux+evALOa8Vk51rwxOALdnHrgVQ8Tr5EZRT3tdBiXkACXAq+O55AJ8MKZFu
	ReHkmhSVtcD4q5US/L7tOyGAuNqZmISHPYbwHjvx8FZW9QmwUahf2cShx4fDT3kh
	Zdu0rWrpcSN5GUHgT8aKPSGITnSerhEh2yVEZJR6RWtx9ZNWqEolLpESJ07w4vpB
	PKxyqn/PHmyG+HdNLXmzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794096361; x=1794182761; bh=2
	MdCeDdq4gx1mPuKuX3DOwDLlWXF/u4+UwqgxkHCTrY=; b=zstAqQ3JMy2Yy5w3+
	43gKBv/vrqulV++uKCwiV1/fNptxFL+pX/bREHxhc572FzFRIsLNQvN0A83PIt5s
	Z7gL8CDDlL9SpRjs4tREqJjR9v7iUAXum/c2rXt+PdGEqeZG5868AqR/JFCyElZP
	ULAp6/E5KGBpfsTmOE4WAvOC+UoiSCE6Ss+ziGvH7x5WUu5EfrQzHtevZD1yOZJb
	lJJs/rvTEtjLoA6SRCDI2d6dTDgPMUygvWz8YwXb9V6VszY5tftZkYqf1V+p713R
	QV/OJL9/Xz4UmJjXGV2D/Uz008sebY5D0g9hBMj9QvAE7uzA2UOXa+rmzpPIzeTY
	3EmMA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794096361; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:s8tQblumlmH1lMiZIv+MPlGljQg5genq7VPhiNtqTBouIsg
	MHXT62DrN4UR6k6J7QSTaDO84yY2kTnub4T0w6X7NePgn6LXeKiIYZer2OOLGpQf
	B2mmCe2wkLkLEoDgciQQmUXWiAN4aKbY6adXCGjOhuKZoqJgEYbo9ikamzxT02h3
	qgKAtkdRKypq2T94+nWWjpffcKdF0JwIdVO/bFeyECKbKMOQHvhSTX78hQfn5Bpw
	t+wVVx82rF80zgZwSkI6ZYaBDO2p4uQ5A/wF5bDKo+dqLNHPOlTJ1apHj6Gu/ADM
	3227lELkNmzsnaRtXVQnZ4S+U8k/1dttIKyIjgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:H5t8/6c9+B9EsiNMM8CYg2hYry2yA5kAoDx5hwIj6Yo=:YUEEB7j9cOdVK1atNNN5ZlLsuhosamX4AV5xlrVnAdQ=;
X-ME-Sender: <xms:6bzvasxC-logA-HI5pbB0gQnoXgUEDMbIApA9OnR7URt9IqMA0PxCw>
    <xme:6bzvamRYNel2gjMvfWYw_8qS_hZ_icg91Y5WTWLNsuSXETN04-ZisDJTjc_hkayn3
    fJnUU6Trgjo9G_2WhIb9V4iV1FUxPzaKr_A1Ro_XadSPrjeNIbiIJ0>
X-ME-Received: <xmr:6bzvar9wmaGaJGERZrgJPG9UZKI2dcfeYTxrvUD5I6lOgchIQUXdY9DfVXPPcskyhx-aCxo>
X-ME-Proxy-Cause: dmFkZTEBlNlr3mwncTMeXtQMtrGSqbfQbjqX3bBC1ItYVs40U5GjhAvcalQBDw4Hw8YFb2
    dLfNJ6+HZY4KrhvzQLvb8J+bmC46w4eJtNpYKd92C2pIjwEeMozNZTUZw3SELLsP0jt7us
    YO2XqZJPAnoIAFLawNZ09wzdAbCILuGYN7H9SeyfLJbNiCp/VJR3mFi7sQMKOb8ZMtWc/2
    Gu8XTGmgCn4ENrEehS/k0ftDtvDl+OkH2LjzpCi81BefRzm4eoRKUIbGUWevRQ8P+6ldGB
    LkvnSbvGdZsEtsL1Dus4BVr8HqjWss45thMCjU8Hbx8G0fhA6vrKubR6ydFmTTFHNm2vGd
    ZkIrO0fvyUBkcI7xr0gSqXf+SJzAu+X9i16/NSGw56SGTYoRbpkALuJjU4aR0Fsuucqmuh
    m2xDV9AoqcH8kNlw1BMNdIf+0zzy3ZtFAVakdLArh/1RyIoL6Iv9bdUVXVPDj3iASSqHIw
    fwg+OaLCf48saPM3b3sBdhkvRvTeWa373PikuUVK6FUWSkDfIzY15dmcr2IMiUD3s0Xsph
    OF2Sn68+jGKKFk/en5p7Ew1NnD83M5YNfZp0alCmRcWtqVhKv5N5fazyKFDCTJeCCtswFR
    WSAgEbPIXobWuAVOdkOsx13f8iuBlNuE7rpTEpeTZBsvKXTAxMjc0Wjbr3QA
X-ME-Proxy: <xmx:6bzvalrkjmMDnx8wzoC-pvF8ZGFInGiPoUe8qgv3_fN8nJqsl0mk2A>
    <xmx:6bzvagmUvj3vMt_-DyKTQ-QsguI7bUJLNT6wi-OayKCy5KjFiHgMBQ>
    <xmx:6bzvakIJCWf80q75oNdrU0ECB_sgKClO8034e1VsIEf8-xZWs92iSg>
    <xmx:6bzvatzvlp0F-tImK2_3FJ2f1stAk2VUEMzOOcNvmjkD54XZDJwZ0A>
    <xmx:6bzvapS8oorrczTdwXLEXbZpf8MqKRTBfuOpC8IqPmdkVG8NLRNTPyyy>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 19:06:00 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Sat,  7 Nov 2026 19:05:28 -0500
Message-ID: <20261108000542.1969015-3-oss@fourdim.xyz>
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
 include/net/bluetooth/l2cap.h |  2 +-
 net/bluetooth/a2mp.c          | 10 +++--
 net/bluetooth/a2mp.h          |  1 +
 net/bluetooth/l2cap_core.c    | 81 +++++++++++++++++++++++++++++------
 4 files changed, 77 insertions(+), 17 deletions(-)

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
index e7adb8a98cf9..1b32fb05d70d 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -196,6 +196,10 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 	u16 ext_feat;
 	bool found = false;
 
+	/* Only handle the response to our own Discover Request */
+	if (!test_and_clear_bit(DISCOVER_REQ_SENT, &mgr->state))
+		return 0;
+
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
@@ -254,10 +258,7 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 				continue;
 
 			l2cap_chan_lock(chan);
-
-			if (chan->state == BT_CONNECT)
-				l2cap_send_conn_req(chan);
-
+			l2cap_amp_fallback_conn_req(chan);
 			l2cap_chan_unlock(chan);
 		}
 
@@ -1050,5 +1051,6 @@ void a2mp_discover_amp(struct l2cap_chan *chan)
 
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

