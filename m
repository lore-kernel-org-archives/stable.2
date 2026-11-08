Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096401;
	b=1wKAb7Mjzq436w6NOCmOVwyFTqB2+424avQePKEA1pz+RbNTbx7JFvg+q2EGOnI2hZSH
	 PihW6crqw1Zt0TO/ClUvXzJvNPupLs+FMXexXxoojATWiyJ4FPTREeIXNSTRQ19dnysbM
	 LlXOasemiI5ENERVU2CDUaJZGorUJSeF7PeqCxhykb2eY23+Z+9ExvUrbdwCmwRVwKKPt
	 cS32epCk6TgKduGAyQr+gquWX8ECLp/AC6N6XJUTk2N/je+d45DGYGxuqEjg/amwtsH5Q
	 WtGwed3Npydmjg3h7uDFbCmaQhZ166Eb1Un9dDU//oNELvxCgwXvodQeEb8aFlvLfWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096401;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=6h8GtYvq53Itl+yDdgLlCb/5BgvT5nMscxwLTrsCQMM=;
	b=tjFhPgNMrY/AQUGvS8JE0MKXZEOamO7n/Zxo5qKhJJrldochruzJByLRLgEFzwiTxl2t
	 MizwBLDzzDY4oNvv8f+GPG+9tYcUjXFeI2ilEa2PiB7Llr3ehgO0I177dtB5xmUf1AJgE
	 ynHFW9bVYO3rkkS2QfPNOEab96MJq8JfWDphnZQiF3jlmtqdoPLMV8xg6BbtLdgjcHByx
	 5SCcVq2lLU5BY7NP2E7f5RXJwKDY4AJb05dySSKjFt0gsnxHZWKVrmLCW2khXUOq6QPyq
	 kTo1VZCabA3JTO5waN3JNSvsIMf7bSGJIh3r9eY6Oql4oxVB3ZQon07yEUlz8QJ3Crw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=hKtGzPE2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=F5NMYZah;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06A7606A32E
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 00:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C06A7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=hKtGzPE2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=F5NMYZah
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A64A140007E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:06:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 07 Nov 2026 19:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794096400; x=
	1794182800; bh=6h8GtYvq53Itl+yDdgLlCb/5BgvT5nMscxwLTrsCQMM=; b=h
	KtGzPE2S4rjvRNjBtVadmkFWh2A/3Pjc5bgn8nmJZu21YXho0WMzYluoxYY2Dx4W
	IyCeBgrHprbyTHyLLMg5/rdJ8XOrv0ETRqz1rM7a34jW4CGwC0xQz1Cs7ipS8+81
	AAyJ/jjTg98sCOv132bcf1B2ASMOG5K+LdgIJQcDRdIet4rfnrHFOdoVS/t3HShW
	9f1I26xde6qlXgPNoEoDfYK8bpl9lg1F7ZTCG1mS5p/Bmq3iHCWBffD+gnBa1lEK
	+4ibJlKz0lGPLmx061Dh2G99gv+7C9bu9doPa3bSkUjUOYw63ts3tQFRuRsUHPp8
	lwSPuEVLliCeRabZCUEtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794096400; x=1794182800; bh=6
	h8GtYvq53Itl+yDdgLlCb/5BgvT5nMscxwLTrsCQMM=; b=F5NMYZahuSUWzVppt
	GmlYPhlWHuXcpb7jvfEJuoCajG879GTFDoBVinuGg6W2AwTjPypjeeV+3EGEbj2y
	07JIxb/yl6SkWjzcaUvVvg3YehNaMsRmbPmaGbekSZiQWfbiMXR402uBv82n1iNL
	kUBNNEjrkZ2iGlPekAWVeV5NGLuns4ihRhDc1ktCPDS0wKk75oSt8WPHpd6eJW7N
	kfDFl9jiRkmunq9IOkLbGWovlz6PfeTpppzxgzNSM13zBA8ZhR+0tD6pXPvurOvU
	xO9hagxPMCHEkJP+fzFgJdlUsARjB67Ie2qDwXVV0EVc/aq5KmKE9MYx1TjCg+31
	qFCqg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794096400; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BpR+mnnYnbYuJ/v4ERMN4qwPSobzqf4FrbzJ1pBEmW6QQMV
	WMi81N1ZHNFr4lrVgYbNF6ZrbSVxwz3a71yAxLiKvvsZr/sWeawVgEXJZdqqqnmH
	+mLbTJDY4kUVTmFC5HoUPSwfSzSivTgmMcqfliV0xtzi24Jj6mJgXsmgIanhgcY+
	J1LQT32tWw9UYRA+Ps0PcHo2bgd1/yzleCD5zPYuqlqd/1dLV6+1zNwqJmI7zguf
	kHGJCC1ZCUfs1wkO3hTOr5/NYrfl4jj1kK8/Q703xL+5IIYtp6ukzRexJufWW0I7
	UzBM0y4HP+cYWih+tuhnMWt1tK0miN/RFlpEGpw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:KMET+CUPhtIdnvHiab86vBWXmriePyOFb8kNNX191ME=:HtCBueWg1PYvCa/T9vdhA235xyTGHC5otHpdDjsZ6LA=;
X-ME-Sender: <xms:D73vaj1PhhvF5t9UJbH3T6NI2CBlAdcSpfEz6tE0H6kBbN-MtCRNQQ>
    <xme:D73vaoEqMC4dZFdJx4bFivnbHLAEhki0n19ZU0Yw4_fI6qFyWAeCNFUFPAWdLo2yr
    8HpGutwxA5-c8KbsW9O2J6QIxqrflD9ntuHzcTDvmHoTPzpyh1Srwi_>
X-ME-Received: <xmr:D73vahj15jGB1Tca8qK43zp5DfERRTrl0TTdtunHo7tr4vg0xKfNMc-wAsWUiET9vmnToM4>
X-ME-Proxy-Cause: dmFkZTEBlNlr3mwncTMeXtQMtrGSqbfQbjqX3bBC1ItYVs40U5GjhAvcalQBDw4Hw8YFb2
    dLfNJ6+HZY4KrhvzQLvb8J+bmC46w4eJtNpYKd92C2pIjwEeMozNZTUZw3SELLsP0jt7us
    YO2XqZJPAnoIAFLawNZ09wzdAbCILuGYN7H9SeyfLJbNiCp/VJR3mFi7sQMKOb8ZMtWc/2
    Gu8XTGmgCn4ENrEehS/k0ftDtvDl+OkH2LjzpCi81BefRzm4eoRKUIbGUWevRQ8P+6ldGB
    LkvnSbvGdZsEtsL1Dus4BVr8HqjWss45thMCjU8Hbx8G0fhA6vrKubR6ydFmTTFHNm2vCD
    9QAPNKhsJBh0I+2aIfGpUhukXof9f52n8b2Hij/ZH1JSuzgxHId4qFKy09fVfLMzJOaMvh
    HiuWarEWJzjcUjtiwSgB4p3PaghEh5gDVRtmA/rSpX6UBe338QCwaOKsz2zZEpzv8Ar6Q5
    BcExvq7ZgpQMbOZ7VeSEyI4dC/23h9XJrHXUkiHEsQ4NjsmKP6bNrkLJ2yLZ1Oa5RCeOvl
    0UYPdsVTJ1zhHLsD9RxVNGLy6RLkTPt981VZP0vFAjoJoAtItF9AmWB8myjbY8Hxf6EhP5
    p+XPeXFiQaUoLkzkMR3gSXXFMqF5/HLFTdRA94zJXzDEi5iiJIR6bKXFaJjA
X-ME-Proxy: <xmx:D73vaj80hKm82wA6Rg0INMbrCAMGwSkx5BPLh25JrsDtCm1qQLGuvQ>
    <xmx:EL3vaopWFarXzl0bxrJl8yFdD3IFZXaJDW6XwZZ-8VTN-K3KjHKKGw>
    <xmx:EL3vai_ApaeWaiCmeSV9e48Eh24HatOpwEhFHbFlVn2HXtFMDio_wg>
    <xmx:EL3vasXAJRUM85Vq0OjHHpHKsvp06y7-5o6mG0T1TYr_l1aVDqTmJw>
    <xmx:EL3vanWYKCro9yC9kTC0umtmZFmxky2JU9maF4-lbV4ap6oQcAZ49V54>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 19:06:39 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Sat,  7 Nov 2026 19:06:03 -0500
Message-ID: <20261108000617.1969616-3-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108000617.1969616-1-oss@fourdim.xyz>
References: <20261107062323-failed-5.10-6320736af7dc@kernel.org>
 <20261108000617.1969616-1-oss@fourdim.xyz>
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
index cbde15ad06fa..89a0d60d5c76 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -1006,7 +1006,7 @@ typedef void (*l2cap_chan_func_t)(struct l2cap_chan *chan, void *data);
 void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
 		     void *data);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
-void l2cap_send_conn_req(struct l2cap_chan *chan);
+void l2cap_amp_fallback_conn_req(struct l2cap_chan *chan);
 void l2cap_move_start(struct l2cap_chan *chan);
 void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 		       u8 status);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 882805df735c..f018851b59a7 100644
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
index 6b13f6784c40..57015fce49b2 100644
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
@@ -1331,7 +1353,7 @@ static bool l2cap_check_efs(struct l2cap_chan *chan)
 	return true;
 }
 
-void l2cap_send_conn_req(struct l2cap_chan *chan)
+static void l2cap_send_conn_req(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_conn_req req;
@@ -1355,6 +1377,8 @@ static void l2cap_send_create_chan_req(struct l2cap_chan *chan, u8 amp_id)
 
 	chan->ident = l2cap_get_ident(chan->conn);
 
+	set_bit(CONF_CONNECT_PEND, &chan->conf_state);
+
 	l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CREATE_CHAN_REQ,
 		       sizeof(req), &req);
 }
@@ -1618,6 +1642,26 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon,
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
@@ -1632,17 +1676,23 @@ static void l2cap_do_start(struct l2cap_chan *chan)
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
@@ -4461,7 +4511,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 			goto unlock;
 		}
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan) {
 			err = -EBADSLT;
 			goto unlock;
@@ -4478,8 +4528,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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
@@ -5303,6 +5356,10 @@ static void l2cap_do_create(struct l2cap_chan *chan, int result,
 
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

