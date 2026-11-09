Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189569;
	b=BJYiJB95rtIZkHFv9BK5jRWXMs9N67WyLJBiNqKSJpV8zaHcvP55/6gC0zcCJlK39EEW
	 tFXAvAqql47uAAnL/bjH47pcCYmZ2X3Yv5f5j7E2SCj/PNh3b3IM7XEL3snky3bb2ExBJ
	 5cxW1rcA4MVsdJOxDPpTwqR1YCBAPek9VLa5ztNTMEy7eOuAmDIUIKghmCfZ27P08JZ0Z
	 YUH3A5Q7lRUTcAXRir9P/rH3AWiJo6Izu5uwzzaLuoSXYN3o31/CIe8xlbjBHpj+ttRZP
	 SwmKcM+9mg/1pYPra9TNhX2A7UczJjfme/2W5xq1zuumBL/Gib8VRbTaSdrrQclc/qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189569;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=6tv+A9MfV3Ql8zsF5w7RfE4TW0szA3JtQ/lJtKfzT2w=;
	b=qX1ZQ+bkcQn4Te4QXlXCdBlk9SolvcrVotO8UEJmuo1V4Huxl5ld+HDMThlT+HZbmFx2
	 +G6ELmzKH2FJJNxDWFBaqyRkDK9TgnPkxz7GCDf7RN+FWi4CXmH1ynl0e1QPmAyK5lqHE
	 ac+7X6yRED4HzWSAGUp7b1P8/KtAzorr+DQuMs/euPU+IoBVCjldYUX7h/ERIuZ6M2PMV
	 V/1/GvTYSpBYRbu5d+0Z7Psl8HxpxOFthsWI1l80VLlUfyexuO680zreS5QTS7Y0RKg6V
	 waW9YKMSqY1yTvGdYb5ZxGERiYZKELAcgvmx/yW7/GSb76a5HGVdO30CMe6cX8ksJ1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=V3cvqR6s;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gGjaOzcu;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71785606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 01:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71785606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=V3cvqR6s;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gGjaOzcu
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B1C30EC0224
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 20:59:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 08 Nov 2026 20:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794189568; x=
	1794275968; bh=6tv+A9MfV3Ql8zsF5w7RfE4TW0szA3JtQ/lJtKfzT2w=; b=V
	3cvqR6sZVEbQZF4oKlhe8fLN6bFlh4shMHr8P7rdEbCaYcAGSkVbF0rP9bgffQwF
	c+G5S2OcOFWFvfHY/+YAvT9lGpPvBb7t2Y1G+htQxsZYjObOWMFhAJTKHZ1iFeZz
	EfZxGZgYqiU0VDQ3P7G9iwPKSUbObakegUdMVA4/mDwop9abF+Y3nOM/WuYHf7ki
	mu6C1ob7iHdgd3omSwLuF2BwuCxXb6QRtwaSQ9fyfuRBEljns6Jr5Ye6Dbh8LkJ+
	HrWr3N/eVlqbQJFyAK1g1tXTWYfmnMVf4AcvfFLEssc3hR7lrABGnc82Oz7+7UjT
	ZhklgMJuy2G3B03ZBG8fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794189568; x=1794275968; bh=6
	tv+A9MfV3Ql8zsF5w7RfE4TW0szA3JtQ/lJtKfzT2w=; b=gGjaOzcuaW0pwVi39
	VhK/BiFEb2aHPEVVZf+Jh04xTsLYeXzX0r5bziWbBitRPqlDQSCbTFNJIqZzx/SR
	nBvfJ2vwXjRxDMkbt14sDRgE+B7wKDbOi0JGaIkLDUxzN8WSAk+B+j1ELb0WaE+u
	XFH8eEiggzEXc6wlKYEmpoN87vTOgXiShaR5vOvsSNzFFL8mBulk8NCPyriwPwfB
	OjOENczWUSjUp+A1xRcXNXej92Jp4bvvh/l084k4E13rPE0/bchNvMooyucQSwRo
	A/gqpLAXbQkzn+uqZzxjAywrkYgYLy8Vi1/JYNLGqPUwsGW1ipqC/VBYotRatwUp
	juzVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794189568; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Crc9f1NoBr+/HGtUkplBXjK8x+0hjTK+ZUUkY3CayiMBwYn
	E+5tYwlIJJTlCGL2Svhv4IrgJFXirRnUt/QhOiexEEc0XHke6r/aAW4BpklVPmfn
	xY/LTSqBrn9bKBczGYOxo6rpXeNXJNw3LJf4cKwQLGxshIvWHG5PPqQJaWUN6Ju9
	F034QpYCX53RkpIsngXIejapldrmPuxv4weLX/BytS+5WEPJAjdCMERGqwt8L8Pg
	PQoLu+md2VUE101CNfRksNcZJS3DndScVQSLYr1rVvs88yMOTdtd/cBXt0hggipN
	RI1FXwUl/Yx5A94jrMiG0uK7O8sgFo0EbayFm1g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5bO4bATqiWiYK0rfPxlzyHdLibGpHjWPcD+KZvksjXw=:CW/ce08MVX0Yjp2SB35FEA5419DpD8drZYDDypykLvA=;
X-ME-Sender: <xms:ACnxahcpSjy7XKo8cfvpDYVba_ZlukwsX6NvWezG7fy26rrpXMzXWQ>
    <xme:ACnxam-sfAgBRjSed1_68shNvwInNGDMR0p5EpATtsy3gdYWhaVihCDY3oDLcQgNw
    BbrE_repp87jScyksl2Q70VSCSX8IX5KYZsy-sWtIhexwOmdMyxlzk>
X-ME-Received: <xmr:ACnxatmgtkK4Ew3w3xLpXVb1KbQxrzm0UqpqvnuKLe9RxYMYL7Jf6yutqAfJrCeuZQyCN_o>
X-ME-Proxy-Cause: dmFkZTEI12/aAXmaA1CpneDiFO6RhnDLgwXlgIf7YVcZUjbceQglEDDgVxIIbIgoULjJUp
    prVGrgB0cXWeXtvJ77QdwB5NkF7zkQ8Chf+bPSqgKT8IUfcZfitnPaklFX8Gb4Mh8GlEhT
    fwwJXutj6cE+L+dQmlMweOL3ykICcK/DZVThJLKlLyvi22NQlGOd1s/8ci6WBt9Xri8SLF
    V/ap4tdG+JQYkWbrAa7WwTZZ3gzyLJakl0kLq253cDp2Xzn0qf4aR9pB1EIIOrZiGigU9o
    rNiUAcQRJ+ZkUjZC+0KV9qTTkD0DNVrCtJ/z/qrhWZZEw9CGcUh+tmtmo7JOHU4mSmcQPH
    w6ot9UpfcLTqc7UqN8Oerixl/DZuYdqCq45IRugcTB0Y/tcZ9bWSJLZg8iVsxqIstRNcu1
    eIQKeSnfOil1LsmG1f+6DDHzDR1Z4Jh4oxM0ELVuOzJR/U5ofR66Jx2MvFv/VVYTSteCmn
    Rewi4S9YOBsnK2vmSRn+9d5gN9jk/wuobXCjI+xl1u/QiNJw1LS5Oq+fZt/cLHNwk30v5r
    yohD7qM/efagHMtOnTxzWoPEdGksmoUEfrw22IiBLrKdpvtHT04tayR7Y6CBMjB9M67klZ
    PueGZu94C/KFRo7mSlJYrfM2hrd15rlS9CSGEj/JJlkBFcTcxDdzJemSrecw
X-ME-Proxy: <xmx:ACnxao_z4vwE-qpjteRA4A2l8iZhAA64yWB4lvcpT7XcAM4JSPfhLw>
    <xmx:ACnxark3G4sNBeoeCC1QI8LOxetYZO5QnDgFx28qsx-p1yjinWkECA>
    <xmx:ACnxal2wYd7RPl-OEM6uJUsIWkjQ3Pblqoab2CUFTDDVmS2jmzwyog>
    <xmx:ACnxamqzsR2LE2PLI3_8hUh7aRimk74w7m9dFzjY-CxmKXQD5dFwQA>
    <xmx:ACnxagfAwrNGscUGAwMzGFftbXWatBUvLe1LmwOKpHtppbe1ERbVZeCc>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 20:59:28 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Jinwang Li <jinwang.li@oss.qualcomm.com>
Subject: [PATCH 5.15.y v2 3/3] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Sun,  8 Nov 2026 20:58:45 -0500
Message-ID: <20261109015902.3034747-4-oss@fourdim.xyz>
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

