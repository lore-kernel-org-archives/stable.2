Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096365;
	b=HLl30q7zOLZs2XnJm5yN0Mb6e+X/eJ6ZGGuUoFGOp0UXXIwdJWy7Yenj7WsnuA84R6D8
	 z3Z3Dw1LKHAX/lQXIbSqfQnwl4QeuoDHCl/QSen0bl18QvkAE8RTffWmum9CEwmUgr0ia
	 +b8FeKQNAlJkZru2KcZmJyRUUZHokCQs0oKkjIsgCB4LIKuCNlFuNZjKZnfJLvY2ashJJ
	 MJu7KcgLKyBvrEirdIpevKqTzs6fRkyr+DH7NrHLA0dsjj4dxCe5cH5AEm0Pmaa1Kfwg1
	 69B82BdrXomGJpJDn4JPdpMPlAzewT4NkLIyapKgZD1qn/8aEugGPRrrcFARy8OukFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096365;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=6tv+A9MfV3Ql8zsF5w7RfE4TW0szA3JtQ/lJtKfzT2w=;
	b=gIRWkRsDINEi1W0c/D4HWGccTqEQhRKG1JOSva6j07EIlaZZUdSEgkeTPzxIIjCQL9aN
	 Ud3ckvap06yv12R+s+xw8oCJFcIKKrCekgSZcnKg4jDJi3xjjrvbdnw7pVp/tOwNeePLC
	 PjyF4/ZFOD2G/PRCkC63XzRNV/AxeuN6GE8V43G4+gHGiV5qnF4qgzOh0jfSJceuO/Amt
	 dcaB9/2Yzo6QNA4/9SpcTzE68t8ssnMki2S1GY28QmYRTzOxgUYhPEu65CHuvF+vDTKfx
	 Xg1Repmp/9g6PjLFegNz7EBBTKayEQhjwd8vgLYMpfg56MdVF/gW58dx7x/49C9fCww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=TnG6g7JQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Bwex5bgV;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9A606A32E
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 00:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CB9A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=TnG6g7JQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Bwex5bgV
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E77A114000B4
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:06:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 07 Nov 2026 19:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794096363; x=
	1794182763; bh=6tv+A9MfV3Ql8zsF5w7RfE4TW0szA3JtQ/lJtKfzT2w=; b=T
	nG6g7JQqNJTDLWgnVz6hghPe1MDNJuyr0Ozeg8xW5uSi5+q99/Q5kgSf2apK/RKL
	NbPXbnKEEQJxNXyhXFZ7/2waRyD+HbPWQNwva4ZyFzQTRX9Aa5gsg+wn4SZYddCJ
	T9t9WHwNPnh4QoRImCHxOEImX181k/aXpbTeoTuJr/R6XN8Txa3fUzVcthwhJVs4
	kp192e7i/zj6A9VkDu4V74cadW/omvAktHG0BpUBavZdVvTidRwpkb0CC//QDd3t
	KBoCb9WTQ6pudBSO0IHS5M7ntLbt02D0lwvjFKWIUomR/WpAJTKqLKletxLrOerW
	ejxuLV7hUU0AyOHfpILZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794096363; x=1794182763; bh=6
	tv+A9MfV3Ql8zsF5w7RfE4TW0szA3JtQ/lJtKfzT2w=; b=Bwex5bgV4lryRb4ul
	FDUZu/eSwRAEAGpdkHqLEdRjxKZ7FW1zD5kVCz+sv1BHyf7ebddxDXv3QlHWDCVJ
	a+D/TC7WkT9vHdrFIfJrOFD+5c1FiHwfGxuM0oRBk/uNW7KKlLa2EHLgwGrLRtYA
	XHlYfVxiLviEjn78wdaQD4u+S6HEw1ygBMYZjJR3kSHI3XYeOMFHUBb8XuLfLfyw
	DN4oKMwcdUds9bz3zZeEOrc5hRvA0aGlMsRaKm3UPJSfNdyvtumTC0KyGnH4U1YO
	jS6vOPYfJ/deWn/BVqlQXOU+JtVs/jLeHiS4qxjekYH/NVtGkkt6qBpzE8mxwL0M
	9wkDA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794096363; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:R/Fat8Y2nTMoQclPoBlVn+Nq94oc1RGQr5aSG3VgtNRFlQ/
	lBghuwo5XU6dj9RBhE33ZQijB6h2kmz1Yff++j+ehGFwNTuTxLHU+L3LF67Uk3sw
	P93VBzJEZUC1qtQ12d7sw3pRSJ2fQyiBs2QbUuT7WvyG6NyNBwSf50/oA6+fwV6K
	VDFf+ve1e7ektuTZhDNVvTySoQ9nkYp99vikbnO5crTPU/86fYBRtdmGncW7z8qP
	agl9zoGyZ9erpbi2uTpc4NRwl5dEiyISxEB4B6fKYZvetiR5s6HFvUHKd+TxOKAh
	drpemM2DOQkc3qbTh1E/8ibyasFiM1XD75ojGsA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:oMXAYb5OiSWhqjvwhFr1fi0vIm+jMbYyMx9braRVPYs=:CW/ce08MVX0Yjp2SB35FEA5419DpD8drZYDDypykLvA=;
X-ME-Sender: <xms:67zvalHrH8NoBTjGLSMRjNsXVyLvbegcXK8C2V1qswcYhfQkNmYatg>
    <xme:67zvaiF7eNetVncTVQk49TgZ9AIGFxx-N9AEl7yhPcZhT_Dl6gNkivXcsB0Y3q5FD
    Se0-zvTCA_wGVor97M5BNE0mn8VZLsbA52sIOyqcFNG0DTIqWOVaBfS>
X-ME-Received: <xmr:67zvaqOOuYcIyqSjmppj_hM7CwG4eBEWF2uXDCfEgjHIrq-P_819jnC_NQyboSKPtL33Dgg>
X-ME-Proxy-Cause: dmFkZTEzXctB9+QqvlwitGYXl63iBXXDJxaOS9iHJl+vQ3FaLqekKmL/SMRSo6RnttZEDd
    7F+IBEcIKrLEl+/01lY5NAmtQWbv94R46wLTPfAw35TMcYYay118ApvkUGHwUQ37405qaD
    G+ZVa+19wEM+Y9oXTRDli7LF9vfn5TcQ3W7fMaJxIxw70w9/u0Va9o0K9LtgED0WKrxAPL
    /e4hpz31kanYMcQbbVyIiN9+8wEqgM3PoEdAHe2MXeJ5Gio6/AuZu8NyDC+JAZ6WHCJQhn
    HmUtrUB2hO8UsABi7j2YG3F61c8c9LLUxwZF55eD/XPUJ2cCBW3e3wymPrWZgHDCluiaND
    sB8NH/gmt2mVaWWwFPEMcNnxF/b+qXeZOiPOBldamElTlPgKvjCkNVH8ERRixdODjpBg4u
    FIMpjKbyz29frVjJT4QZN6lJH/CSrxg/sKEhSob3AtZlz8uRN2l6SLFphuujC7yV3295HD
    HPKnQkDKLia8xuABhaSMLYPBvg8GaoZcQIs2KtZLqWCXpy2TsaaTXIr056IgqrsqqMjtdn
    cEaG/HqUaprbvB9VyVIgk9RiRh9M9nvihoCdBlMF+O+9f74m+S84zMmieDfKyIAir722cB
    FwVHiEIkyTu6qfwwfwbEx6KpsKkVCV+rYZGVnuTh5WGt8CTomSeMWleXXqtQ
X-ME-Proxy: <xmx:67zvapGu_WLzwEsDnYJUn20JH3FElp5EfupmlNsq9i2U-PICipPNRQ>
    <xmx:67zvapOjWCreaNf14BAsugg1S5m9tZSbAYVe9eYMmf25-nosVvcGYg>
    <xmx:67zvai94ZlMCVWNQ13EaWx8i5agoyKPpetg9Dc_oyZir1DfVuyQ4Ag>
    <xmx:67zvatRz2Y287nYY6cd1RtCcl7lpnIESekBZBNASFCwybJWXyw4v_A>
    <xmx:67zvahlh2c46sCBH9luASL1cVQu47dx6Jdp6we0Kxr6rU-_emktEqIEX>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 19:06:03 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Jinwang Li <jinwang.li@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y 3/3] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Sat,  7 Nov 2026 19:05:29 -0500
Message-ID: <20261108000542.1969015-4-oss@fourdim.xyz>
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

From: Jinwang Li <jinwang.li@oss.qualcomm.com>

commit a9f9eeb5344fc7dc625e5700ccf09891bc2603b5 upstream.

Adjusted context as stable does not have the lockdep_assert_held()
call in l2cap_connect_create_rsp().

Stable still has AMP support, where the response to an
L2CAP_CREATE_CHAN_REQ is also handled by l2cap_connect_create_rsp().
l2cap_send_create_chan_req() stores its ident in chan->ident as
l2cap_send_conn_req() does, so that response is checked the same way.
l2cap_move_channel_req() looks the channel up by dcid and overwrites
chan->ident before checking it. A channel still waiting for its
connection response has dcid 0, so a Move Channel Request with icid 0
would replace the ident this check needs and the real response would be
dropped. Only handle Move Channel Requests for connected channels.

L2CAP/COS/CED/BI-28-C requires the IUT to ignore a Connection Response
that carries an invalid Identifier.

l2cap_connect_create_rsp() only checks that a connection request is
outstanding, not that the response answers it. Add an ident check
against the pending request so that a mismatched response is dropped.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/l2cap_core.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 227b1c8f35ca..c485b43d5fe0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4493,11 +4493,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
-	/* Only accept a response to a connection request we sent and that
-	 * is still outstanding. A channel waiting in BT_CONNECT for security
-	 * or the feature mask has not sent one yet.
+	/* Only accept a response matching a connection request we sent and
+	 * that is still outstanding. A channel waiting in BT_CONNECT for
+	 * security or the feature mask has not sent one yet.
 	 */
-	if (!l2cap_chan_connect_pending(chan))
+	if (!l2cap_chan_connect_pending(chan) || chan->ident != cmd->ident)
 		goto done;
 
 	switch (result) {
@@ -5485,6 +5485,17 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
 		return -EINVAL;
 
 	chan = l2cap_get_chan_by_dcid(conn, icid);
+
+	/* Only connected channels can be moved. A channel still waiting
+	 * for its connection response has no dcid yet, and its ident must
+	 * not be overwritten.
+	 */
+	if (chan && chan->state != BT_CONNECTED) {
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
+		chan = NULL;
+	}
+
 	if (!chan) {
 		rsp.icid = cpu_to_le16(icid);
 		rsp.result = cpu_to_le16(L2CAP_MR_NOT_ALLOWED);
-- 
2.56.0

