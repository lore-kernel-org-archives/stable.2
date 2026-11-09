Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189661;
	b=p6/9G3+oX3NZ4yE/5ZEBuF8onB7hUfUIVyqV/KXAs8QT8GqXfA5ZZYhjzb1JciWYm34o
	 fD1licXTG+sdXn/Tx35oS8ZbOmyaA1eGAXykA6amW4H0nUGCx70UroxzBuI0n5PQgfBxc
	 Vd+fbVkKqLZZwGHL7lqPwLdyeLNLfKRHsyFooriLqgCFV3t3tiQQuIe0/sw1puWsTDo7n
	 LGbJL923AMQhJB1NbiFkyn8jOq76qxSCEKVG+FU7KvKyDqBydlxhWSTV5pH+D+j2EhbpK
	 wFdc3TuM80gP7U/WgjibqJ8kZNmDDirADmyyIB0zF5fqxqJ+UnxFgUfdhvJFL5dQE+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189661;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=zfjumHfMq20wNK4tT2+MwRskYri0Yw2WvbN9guBc7Mw=;
	b=24hFmqsoPsSUEPQm6i1Nf90hkbo0LQcNapbeLwDTZ0I+vcYJabct4dLbulcKD5pphYVu
	 /y/uxzvCxakQakgRGyEWlXyrPBAn7Homi91MK/H4hUAITtQePLaGd17BGYVohrQ4m0YY9
	 lQQZsD2X0dDBtmMfezX6xgHd9fHaFG90vK9tjncoQWPP4ffnN4Q3DQ2Ux9I/nPiR2BqU7
	 /kHPVYLcVfNgPRSbBRyC3zEG8rqc0UBlm9LNncDRQN7mkM+oB+0AP4JNMuabCCaY8bFhP
	 gWZ389F7rE1GmfITG7xM5a2ZT4mQ7Cqc1kk/1/cPVWaz7MQziWEXwL3r9fz2Nhp0CRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=vgv84PRy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dl4CVQPD;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8D6606A330
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A8D6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=vgv84PRy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dl4CVQPD
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 832DBEC0586
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:01:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 08 Nov 2026 21:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794189660; x=
	1794276060; bh=zfjumHfMq20wNK4tT2+MwRskYri0Yw2WvbN9guBc7Mw=; b=v
	gv84PRyMX0ZGPVARjTOLSzL+a0OQqW5FeeNkxbLcHA/+a9Ka2DHg4qsP/wUMhAtA
	L4jqHNxYiEVBre4muiTDHKl65Ru/MGflPJAyOSdGH0Rq38TKLtjAo2/p3GfOVSEC
	FrVNjyZD7oaiMT8IjVJZH7VJQelHZTIRYQLjHAKKtE4OhqA4l4T/CH9XZBJFPmdy
	T/GnLRYyMbFqhHdHQVW9fPG3yLwGlJCU86iEGdNYca2jD7jxve5QOjRYTqKXq0Sm
	u9w679zzXmoovj7gjjhAx5qA8gGriY/5LqOjeMNjg7aDAFo+HRwsnLKst+0rUTaj
	hO5ICc0IIUHkVBVWDomeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794189660; x=1794276060; bh=z
	fjumHfMq20wNK4tT2+MwRskYri0Yw2WvbN9guBc7Mw=; b=dl4CVQPD+Dwpcr9+G
	diTAqfgwYQ89u8BmWgL5YR51q3jGsugXS5EK830JgbbUIVZLTEtec+oqkFbxC9GR
	/clowe0CNJ9Zb40N6slw7oFF21uqPcL42cNQTtJFmfh/fABdkYItqri0+bXXltl9
	5r5kSPzNMvlSmGawQ6twhg/25IwTNZdo+bNJwSjC07kg72xCK8SFKS2TBpIcjAU+
	GkTXcE2zuBsdO0XsWWp9UZ+tSz4S26CddZPfFo4O7DWY1TiH+4ISfFY7GNHatGtV
	qNEvQ7fEXY7OOocajLddtajP6gAd63YfiVcOibi2HUx67Kwsdsw8KXHis4sCaRBT
	zOu/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794189660; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:uDbnkAtMV2KWvf1xcfgiovmJv4am3Ks3U0rA2keDOwsBeAP
	TIHdJtMZx7oYCbecWFqaC9kVdbYQ1U+VM8OFXFUqH4HQ/JKPUJNLcTn2UYiwbhtI
	/Jkn4O4AWuoBCkQ3fSfoWYCpIF222PVO2ZqvY+D4VQ1i2iuB6RAdskC9fKMSpWfO
	ktsjJAC9Q0+o9ln+1MFBnfoj1Lx2taGd/GCpp3Bb/n5iWta3KJO/g9IyzwFOZ9Tp
	ZZnzdNzgPeosTJE2rt0sPqdkTsdj7s3t+xV5jDDmZM+y/jpa+VWaOOYmE/Mop+HZ
	W8s0lFuJPAbht1fg11yhG1HkorVAhqCA5WpnUrA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Q1WcwS3O+rmLR/eRwCj9vEZQF4PZa1jrQ00EU84lNgc=:xS5b87t1bml/bY+3ObrvEkuPZveOBIazFZbIWxCj+dc=;
X-ME-Sender: <xms:XCnxakjOoiHkBTNqAHfPdMM3Lqn-6E4l3OJdAW9htuh7O2-Aji-FmQ>
    <xme:XCnxajAkmgoorKH4BrCjl4_LmhUxAAIvLwHebqkiLl4yZr0Ru9DtZb29srC5j-48B
    NgENQe4MrQLAQNM_K43qWlFpeoXCW5ltOLPqlPIpn_oTEncjWX1uf8>
X-ME-Received: <xmr:XCnxapt-rTDh6fSoJi1ezHG6ixjClWxgCU4OLMhmDw8HUCa0coGci1Hp2MonasVuQHd4qbs>
X-ME-Proxy-Cause: dmFkZTG2cyxO8u/pGkbkM3O4xTZi7ycXFHOalX7nmWsfKsiFkgbBQxzNLcO/5kGMGioxE7
    uaap0KH87XZjutXjRWOeePa+tMp31zsyF5BDF4qdIMYzigW6z10vT85guxyaMaaMuOctJw
    ZSTDrnqzD0Y9bgkgqorSkpaGCYCuCaMmGUUBPVU/GpSCK+yTsDqxNWJFKhtQurUliP1EG8
    l0wQwXH7KAGA+Okb4wwJ1l1LhQWQRvxkNORbQdBFHzSbqLSQKFElsaXwVK+eA+Dwb+WUYv
    +uEuGRVO7fatIeH+lHZsaNdLUZwKhAnqsHWh+15zoG+XbYOEIHB6lQAfcyfEGs2Gqp1sAX
    mTnLJG5TNKOGcQpt9kJLRvmReKzvFQ3cHD5GcC2khEsZv8CH0bPVLGYMBohrnzCq6Pnx/A
    m2GtBi+yVCUoaCu3nmAfLU0jAL1QqMSIpgamYjoG4f9A6s6bleUsWcxGpBzjdDsF2yP7tP
    HJQ6jPRxbiUkgj6C104MrtD9cValvHcTigDaVxKPiWb9j86J9ZbSQHZI55zCPSfbQNX9sK
    M/tkPZ/qXFglP+JqhZspyAe1VRKffP+w7LEuhs0ls9FYaUWTXYxfpRyWkGvoafAoVPHAJI
    pyYsHWJwQRQqI9AabMQBpCkJkNRpVykHk+6ZncEPprzox5mFzA27WfMQuHeQ
X-ME-Proxy: <xmx:XCnxagZzXOIOCdBpvfabXLHfIq9HnMlQBeqIKTHZr4_z9rE78gdnTQ>
    <xmx:XCnxakXbApg5ODbi9bwwwJC_4pt5YI2BOttOcKcs8Yaz0TLwmUJF2w>
    <xmx:XCnxas5Fa-HK10A0d1CitJKbA8h23lX5qLaT-wmxcXz5gqp9DrzKAQ>
    <xmx:XCnxanh_4DRRW5ru-kkcoIsylNXiJFYM_bh50Im2N7AmWgfaduGe-A>
    <xmx:XCnxalBWTL-qN15rloy1uhxZQp-K83rVTOiP0OM5CUoaVVs_TgkpQDQG>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 21:01:00 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y v2 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Sun,  8 Nov 2026 20:59:27 -0500
Message-ID: <20261109020039.3035406-3-oss@fourdim.xyz>
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
    https://lore.kernel.org/stable/2026-11-08-1-daily-reply-0004-l2cap-a2mp-5-10@kernel.org/

 include/net/bluetooth/l2cap.h |  2 +-
 net/bluetooth/a2mp.c          | 12 ++++--
 net/bluetooth/a2mp.h          |  1 +
 net/bluetooth/l2cap_core.c    | 81 +++++++++++++++++++++++++++++------
 4 files changed, 79 insertions(+), 17 deletions(-)

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
index 882805df735c..83669905a177 100644
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

