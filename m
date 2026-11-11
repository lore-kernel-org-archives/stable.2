Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434943;
	b=wbl44EYPtlFEdOQuVgbQ8ZnBqbbFrrNzLWyHl1SZ4iBY2Pyci0zs5jTDdAm8CbblvZXp
	 uQFLQ0hxQ4/WdGIOjatR+9pzrM9spv9qtorFCPfiJjglZZAotsHI9GP/sMIW2/tlpeG61
	 rVW1sFPtSz46vikSAv7hs5GPMTgepOaKTbkPsAA8k7MIzJxElJQcmvyzIwmiPqJbAdp3v
	 61s4X2Cd/fwKDrTFxxTmUs8PRSR60PQmRLRDTN4sZf0gnJ2jnJXFhiEEhwrTSxx8XrjF4
	 zw/kBwrUar0ePHQCzD4wSsSdAZxoE7jbAEICUiAVUSbNvMX+cuPDTcpp7ZJAXguQ/CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434943;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=TdOQEO9yvfCYlzLgX1jx1f4pRXdvZaX2z81Eco7/mU8=;
	b=uqufGB+OnD/woQJrN6bqcDdhCnK4lmy8L54cmJwBeoKlhOu2ScZFzzxkrZ6NO6OLrR4a
	 uYGE5QBaGt1F3iqjc67s3i3S/WXFMvhyTiBIg7TbONM60cxNHk6aa/lKkpzkNNxI3JIoC
	 cG6taPN1LVbPz9xxqMgW1oDa0hB3YR5b5NGigiIZUnzoIHv6NODrMJ9poPW0fRPO54j0G
	 eV2Zc6MupXIIZIj+NFNvuG3UkZrAdzODuYPGokz5lpDSNgDWRjnqG5Tg7iXibaTyp/8KQ
	 foIeXboiwUKs4TxO/EUz/IfqfKDVOASVLcy8obPW502ZRwue8QTibdHZtH2AlRcip/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=Wl+OZ+gR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5aDdXO+Q;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3A5606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC3A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=Wl+OZ+gR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5aDdXO+Q
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C064D1D00136
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:09:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 17:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794434941; x=
	1794521341; bh=TdOQEO9yvfCYlzLgX1jx1f4pRXdvZaX2z81Eco7/mU8=; b=W
	l+OZ+gRDpUSm+KBYDEquuUHPa/cwgQcyYK0A/+iVF3bdwAYpuioXauVqxlMQopKS
	Pvquj/P2Q5V+mL5r75Zujs72zasMgRH3aYRsN/mCCzUT+5fwXVol7sdz8qyKPhNJ
	ExF8j3yG8kXbK/A/YSSEwuybJ7y+SQ8DE+NzoIstoV+JWvhPhOOPlXJcOEB+fQrB
	bhWLYEfv4Ce6cD4eHOF9kxFeF0dLdKpq6YCldsBpIu6OMkz7c/bm+dpOOKnJ1cmQ
	c++Uo0HaHjNmtzNLxAt0ETmPg0SGTdwWkL0AXk9/t945YHZAWWokiMiElOPl9MSG
	OAVnAu0+h0E2PqkUO3d3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794434941; x=1794521341; bh=T
	dOQEO9yvfCYlzLgX1jx1f4pRXdvZaX2z81Eco7/mU8=; b=5aDdXO+Q6w3c1gvxj
	Zo/uEJS0ivSaJ/kvKfX0gnzIsokPDi81+z0LtmHQILEp4NkvHkm3BNvzLbKo2wB/
	B86jnAGi9Gl0HbuueuwCQ7w8Jq07nQFfiKT/y7lXT+XU5X8vTHv0IgqdLpiTrMD/
	vam8I58F7YI3VNL6dufBu9sJw0NH3qkDzHkDULuKQ2j2rMAKe6NUJfImwrTiL6R5
	udkqjPjMp0fDMPkzmTEjVxrzrQfXDIizgBwlyuPyE26WgZVuKCWcAcOfJoU+hQkn
	5liz4xGsuGCyx/FHTp4sRY+k7tPI7twYOt6ey96PbydOK5FmSQ9aXqbwGpEqP0IZ
	cu8Pg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794434941; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:TPtUtGXYznIzlLC+pJx9M8cS667h/Atymnu4Gg4fzJUrj9G
	xddB03GNPKNO8YHKWNra1teU3X6AB4Ub4B8g0qz3bhgKvE7BFuIP0fy42r5QLGHl
	6OYqkHP8DtxOlCES4X0sgPnQBbFI+nJuV6jRh8K6MvzC/U47OnIS2jILsrkX7FzM
	GufHr0R3HW+TMVJXMAtb/5jwO/kDYWIt9MzBq/S3h2wJxNnw2nADr6Qb0hfclGFX
	20iCpUjiup/dNHJj7rSmbjMhyOzU2/LAyticxptdIrG7zK/2KNbG8qv6nNI+PW1g
	qET8wf4dHBZGlEfWzSEuYmUMyMqwkrfntocl4jw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:uBS4E1EP+cnpk/J8FPMqhz9907CR79C/ejFPhBuONsk=:xLy5lcE/YgUBjbb7CYXwyvuAQymM6acpSlIJyuNMFZY=;
X-ME-Sender: <xms:fef0atSUZjnb8sy8PniMXMJYMqPXgviEgM8y0FCfZ3oq5V7GtiQsbQ>
    <xme:fef0asx1Z36tQ7oqDtjsTbftGNbsh3oqWaJ-G2-Ye4rbZmm3NekWeJAWSacNK0IYD
    KPlPiYg7CN01A_7rvs-IQiVNnth7hsc8EEvkji2sX7Y6GZ-4ZhBpAcx>
X-ME-Received: <xmr:fef0agdmO3qNLDB0DpFXw3A9EP7IPeAUzj18OrbFgwwtuVQRRJ-rtXOQCKqZImjzVPR5qwI>
X-ME-Proxy-Cause: dmFkZTEijvUOy5pjvmxPmfqPx9Fpjt4e0UrFH6WaW7CRlfYuyZxNmM3WEUBk/qgMqrN5gM
    vOynFiAr2CIW4EgWmJRvIWFajStHGruHWY92Z5tdci9MXse4PJoXvI0K6OfsNHCXn6NYxm
    HLRCAty6RiTwsPpgyT2kmi5AiAujM8P5DJuZVhttuHLQLUbgnO7e0DnoLIvSPPd1xcsIZL
    9RTgX58CUMbZpVlBhq8D3962Js+dGOJ5I7zyNqmj/xGSBxS6HxAfdI4mEpyWvxzn01YDqa
    nk5DoeuAwLh8dlJXs0Ea5i8Lqv5phtKFwN+371XAa3Zkb4GYYZ5NUrYrUNJYfAAAC9gph6
    aF/a4D3ylDIZCg3TIv8z+vLX7Wb4AgPwMwKJLMMi0YOZx8Dk05L5JYBI8VgofX2kUeBprS
    cyjcpOy9OIesL78/61b7fOqjgc9ng842cPhQR+PFvJNNoU5HXeMmuJgq2zAD9g1K4maIyX
    svTT3u3kjzV+XChereonMLy2eolrhyZYbBMUPttp8CHnd+fxeAVxJt4sdR4V6d9e5d+Z+a
    ZoI0Rui7GUQucPzTMqmkTR3m9SP+hYUn0uutrNdoMapvjhodY1nO/5+sQen+pMidq6lFfH
    xRHZ11f+hzNd9qlTwTA5OWaqTLlFSUGKoVrtq1CWLqrDwP3AjoQQa7PpDWuQ
X-ME-Proxy: <xmx:fef0agIEQ7Ga2-5aJZjtUgy1Bcaw5pEIC0g_sfPHKFaG5IXn7waU0A>
    <xmx:fef0apH-wAZUlxNuc4Tm8qbx-CzdhpQLAsH5U1EKZSBS8E-yj9sgdg>
    <xmx:fef0aiqVJk57d3R0bmsywHKlKEC1p7s-p-r3Y5qqfB67UD3ToYwR_g>
    <xmx:fef0aqTxvbrzWIM3mkXcWCfjVBq0s_XAnYqTpd91GsN8iMxF1xq94A>
    <xmx:fef0ahziWDjXytBnk_EbCKg5I8nZkskl2bDkk2VtwwgNg7J-cOsIH6Yr>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 17:09:01 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y v4 1/3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Wed, 11 Nov 2026 17:08:12 -0500
Message-ID: <20261111220851.3076201-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111220851.3076201-1-oss@fourdim.xyz>
References: <20261107062323-failed-5.10-6320736af7dc@kernel.org>
 <20261111220851.3076201-1-oss@fourdim.xyz>
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
v4: No change.
v3: Drop the AMP changes to l2cap_logical_finish_create() and
    l2cap_do_create(), which are not in 6320736af7dc.
    https://lore.kernel.org/stable/2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org/

 net/bluetooth/l2cap_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index de97a746bb38..5a24d655b535 100644
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
-- 
2.56.0

