Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434944;
	b=uwloi9Am56l26+uCtS20ZJVxqWryTPuH3yL1vRnqcucr+2eGTgyprbyZs51yntgl6qXN
	 +7uNiQ3kXhGmhsGP+ysS1HVt8J2j476auTXjxY+7Z4K2/bwoVCuywAubfZMahEHZPwvQr
	 UxdMUV2434Uzavc/uKeahtS2Ma8BIaGLQN22g9NU2Y09WEiPoUbgk8pKNHJ/OzEJdLcc9
	 ujp6bcBWjdVyam2vlouETPP9Btd7/+q4tkngt4mktn957Cz8luJBSbLt5zASDCEr9XNIN
	 +vlR/eeaoD5orOtv2Axw/joneJR5ZxCFhv91+q5fHW8GtV0KqlHeyHcda2DaN0CTYQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434944;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=ixOAZiHOJooBkL1mmuOHX991eGZosm0RF0LiuWO+DGE=;
	b=hbiejCGOsEk8F6vLZFBOi8Ngk9t7yfJkajFe6d3xpnSSR4leQ6g3BpWbNGXilYgdMR8j
	 QWqEXutYZSgCa+DhFhgFEPi89UBdLui3h8acMDvFOaTSiLL6NN6Xep0xLAwwC1Fvmz1/D
	 unhcsru9WXqaKhu+7KWdGRW+unRGDOBpExPSakoYXO6oSIdsAzsu3tQg/dpZ0BA6Ia5WN
	 0Xk+z3PqkcFwGGAixnj32G3UbtQi5xJKCJbeiFxjut3jZJotvdzIwkkJmog5MJBmE77rP
	 uF/d/WjRhEz2aaLNA6CZWCDe56Sw43Ymn6RPmduLeDA5EGppim3KJuZbvOHWrLCnR9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=BY7l4S8K;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rC+l8ImS;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3FE606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC3FE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=BY7l4S8K;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rC+l8ImS
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 53FC11D00136
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:09:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 11 Nov 2026 17:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794434943; x=
	1794521343; bh=ixOAZiHOJooBkL1mmuOHX991eGZosm0RF0LiuWO+DGE=; b=B
	Y7l4S8KAo46OHriFlZrLEXaQUo+CC2TYONUduw1Pfvi+e07uji+ua0y7ywMJ/7d8
	992lSdfKKEUIZRueQiG00pj1NZSWfmzcqZbooqueufTu3ItdD0Hj8Mh5uhyquV8G
	Xxhbo2ZZfHUU7FEw0Dec8XuUXeFwT34xb/GJgCMnJW3ek8sLVG2OED0czboKo4w4
	CaHL2xaXbIdOWVU4V3jNq1Cwl3RlKV0+rNh3h0bsWcRmIyd6WHc5eLg2dcsw24Q4
	8yShr8/Tz1z6RC0KDqYaNcU3bzV0BoKmoxxLBZ3rzk+T5PMHB70yH4v90A/C/PuX
	hcUBk616Pong91/SaQSvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794434943; x=1794521343; bh=i
	xOAZiHOJooBkL1mmuOHX991eGZosm0RF0LiuWO+DGE=; b=rC+l8ImS79UBD3ApN
	l80JyMdVE3ibZ/QCgW5hFETl9vWr2pNt+auGXZPoTqrzziBtttsQLxMTqctU3GSQ
	pCL9TK8ECQd3BZZyfZO0PvIj2v0egQYjrkqHf02VE6SFDzWlwytUbT6wYvrRXUlP
	av69hTMdW1iZuYFchr1NXpPbdeCn/9NJ+nr324ZYCdTPwwMHfNC1xBcCZH/i6Uj1
	93jlwga7LUl4tX9uwfzn6W9M+/L4RsRCxAhZt84blzgcAGqcWoFC7P+nFUcmdop9
	PdlCh35MbDfRjn4u98YJcwZ8bbCLr+pta5N3oFtHRWQoTLtyJzGE60BIu6tvTjX+
	NC7tA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794434943; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Euw1alCShXiP8iA/XaiY8d7wtMXMc9gK18tJSJaX0L/k7P/
	M/T1U4KOjcGaoQjHQtzKOm6kbFQqCIGLVrUZyS5Kgq64Bb8HxEFJKgUe4msE38Y1
	EDdM5pDzqpv0YrvwQAAHG3hBDBFb/OIVh+Zn/VJORQ26dF77JdoodzhAGBd6fzva
	Vdcymv8/dP/1KJ6eIvQcmB0X/PeTkDM655d3qSGMJEdmH/V/zCyoEqgjYXPCAtTG
	/iEIJARg+rjoNgBEF2dfO8otaLWy0ebkltb8bbJX9plb6aqeU71gBejChw9OPNTS
	HgQrcG/yVvA03Nyw1yfbM7GyOS502cxQi2cbiFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1NS87Ye8l1KAdoytatsWANwxYQr+pgieokULlkeUGkg=:rKfVW5tjJZcFaH9Qei1TpXHxMNCH57p9Ad+9IGZ7NzU=;
X-ME-Sender: <xms:f-f0asGhW1V3H9wGP9IFjIy9wxW_R4XuYYKfmRMN0oG9Gl-Ll9zlYA>
    <xme:f-f0arXk1v_VMpE325K5VgzOf3kiBIk4jwGW6O_VKvZf8ZPRYZO4OzqWsPyatGSux
    ZE28zcgJNi2FOiebhClgJJ4rnZh9VkSEC-9jXSe_cwdyrgJSfYE_9nt>
X-ME-Received: <xmr:f-f0ajz1HgH17pRf8ic20cLwiAEUpBD32KlwUK16ifpKlXQ0GzwUozOIkqnS_XGBrSTGGuI>
X-ME-Proxy-Cause: dmFkZTEijvUOy5pjvmxPmfqPx9Fpjt4e0UrFH6WaW7CRlfYuyZxNmM3WEUBk/qgMqrN5gM
    vOynFiAr2CIW4EgWmJRvIWFajStHGruHWY92Z5tdci9MXse4PJoXvI0K6OfsNHCXn6NYxm
    HLRCAty6RiTwsPpgyT2kmi5AiAujM8P5DJuZVhttuHLQLUbgnO7e0DnoLIvSPPd1xcsIZL
    9RTgX58CUMbZpVlBhq8D3962Js+dGOJ5I7zyNqmj/xGSBxS6HxAfdI4mEpyWvxzn01YDqa
    nk5DoeuAwLh8dlJXs0Ea5i8Lqv5phtKFwN+371XAa3Zkb4GYYZ5NUrYrUNJYfAAAC9gpPN
    RNPimlDEQEB7ro8VIeGiXbkEMvoFWXRrnWiw3WJXMIdsMwQkJ5nExry0B5i7mSRwA4YrYj
    kMYAoY4Ft46xi1bdaqHRR/VMKXgIeNnjLpzx71zK0HB0pmdhEBNSsWuMI4yqtINZpMDJw+
    8Lwi2Ilea0IzSiA41tbr0OXO+PoydilP6KmsdNpxL/mkwNGUN+Xpe2TsCVzDjJKIu5ay8I
    P3caDe0ZVp75A/GG7sAk2dyrv9m4pRZs3aLYDkEWLCPBZuvc0RfUWp93ScUwiHN+rnaDUS
    1b0+SF4AiMLbtwYyPlnORr8hTcz0ZLHF64Sg6pdktOLba4W2Ix7NUoNkf5tA
X-ME-Proxy: <xmx:f-f0apObrI0ev5ofwYoKlyaIWlR3WrDxXEqshvQwV-U7p8FDYIMFFQ>
    <xmx:f-f0ak7NjjXdjlKYXnFy9icpVp2zwMvUA8z9pk1l5GUAyGh5LMiM3Q>
    <xmx:f-f0aqNpwZ9IMU3QNF7u3fdp2kZyawMsatXWHaKfn6jVDrDBpQK2Mg>
    <xmx:f-f0aikfG2KmkrxUUDGGOrTPQBrGHzqO2av5acgN3IHD6xhxE6dxZA>
    <xmx:f-f0arn80Qb8UIY5YB1I2Lpg1s0TFJ6DHX-rK_0tPpd3gIRDxwM0YzeI>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 17:09:02 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y v4 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Wed, 11 Nov 2026 17:08:13 -0500
Message-ID: <20261111220851.3076201-3-oss@fourdim.xyz>
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

commit a518b9a9ef6ee3b18ecdf6ba5360c608aaf969e9 upstream.

Adjusted context as stable does not have the lockdep_assert_held()
call and the __must_hold() context analysis annotations, and
l2cap_connect_create_rsp() still holds conn->chan_lock and returns
through the unlock label when the channel lookup fails.

Stable still has AMP support, which upstream removed in
commit e7b02296fb40 ("Bluetooth: Remove BT_HS"). The response to an
L2CAP_CREATE_CHAN_REQ is also handled by l2cap_connect_create_rsp(),
so set CONF_CONNECT_PEND in l2cap_send_create_chan_req() as
l2cap_send_conn_req() does. Otherwise that response is dropped and an
outgoing AMP channel hangs in BT_CONNECT. This also makes
__l2cap_no_conn_pending() see the request as outstanding, so
l2cap_do_start(), l2cap_conn_start() and l2cap_security_cfm() leave
the channel alone until it is answered, as they already do for a
pending connection request.

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
v4: Set CONF_CONNECT_PEND in l2cap_send_create_chan_req(), so the
    response to an AMP Create Channel Request is not dropped.
    https://lore.kernel.org/stable/2026-11-11-1-daily-reply-0024-b3f3824e55d7379b942d@kernel.org/
v3: Drop the AMP and A2MP changes, which are not in a518b9a9ef6e.
    https://lore.kernel.org/stable/2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org/
v2: Pull the payload of an unsolicited A2MP Discover Response before
    returning from a2mp_discover_rsp().
    https://lore.kernel.org/stable/2026-11-08-1-daily-reply-0004-l2cap-a2mp-5-10@kernel.org/

 net/bluetooth/l2cap_core.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5a24d655b535..a44d4cce0527 100644
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
@@ -1355,6 +1377,8 @@ static void l2cap_send_create_chan_req(struct l2cap_chan *chan, u8 amp_id)
 
 	chan->ident = l2cap_get_ident(chan->conn);
 
+	set_bit(CONF_CONNECT_PEND, &chan->conf_state);
+
 	l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CREATE_CHAN_REQ,
 		       sizeof(req), &req);
 }
@@ -4461,7 +4485,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 			goto unlock;
 		}
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan) {
 			err = -EBADSLT;
 			goto unlock;
@@ -4478,8 +4502,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

