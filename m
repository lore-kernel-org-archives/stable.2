Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337887;
	b=go0YwZHApMZbjDJs52mRy7Usi2xba/iVSubAecP3lIkXMvDkSAWMAEh7oK0n+Q95g8US
	 hOhc73R6yoMtZ9FxSccpQJHYRJ2i0olWfvJxsxjBEr4oU2zR/PW/ci2GGfPKjh+QCODys
	 0VvZEXnnXyddY5Hg0mrYREMZxev+CvxAoAC01kjiWpynPfCBTTXPkQ4NqtdS0oLPIRt+h
	 /pAmGN+THHDHvfApcJho9ROrWH9K8swuwSTsax8EQAFlStmJacxvklAiuoz0tUHYBQuHX
	 yFPBNMmQgDdCcvkOAgPJTWhwpbPqvut+tneswY/e6pKVfvgIO7ihea6inyR6GmL4cLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337887;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=PMUWBMfq30Mq7HyUgGTYDDVOep9BKY3FWq1ildp7o/w=;
	b=M0MbtM6MvRB0elmPp1fJCMSz5Qo/IOdzFEJhIMVYa3T5RgA/Kt1SDfG6P1vsITOikjD5
	 ts1/zbw/0B5yTsxEQHkMJz1EC39MyYH4QlP5AoBQmy3LxYuFsgkzznXM+R4K5y7Rnba5V
	 6g5GRj08YmTi77HqcHeIZYikUbOjkVkST98QAF8PhxChmkWLn0H71/ZgK0+HGLVNt5Al8
	 dTLszR8PrxD67Id/4Jl7pzvSGtwP+W9UHuYhV5XcV+K/EN2j7xQQmzTvN3P8JcI3CdjPT
	 7/ho+kfUEiF5sCVVw+2yAVT93UEOzele5u7x9p+x4Fr4g+3lp49YldLxiRjYWKt/GSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=sT+vaEmy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BbHgIDtc;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1A606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DD1A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=sT+vaEmy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BbHgIDtc
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0465F1400139
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 14:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794337886; x=
	1794424286; bh=PMUWBMfq30Mq7HyUgGTYDDVOep9BKY3FWq1ildp7o/w=; b=s
	T+vaEmyT1MdRE0Wx+2nR90naDsJxJrdzifA21c56953bnJur9K53paYgIRZVzjWb
	2KqmPG8rtjLJBV82nd/MuNDvFmpisA2cB9b1pRvBljQpR35TNfznxlqLIIU/lNzo
	sOFIYiVhWLcn9xn0DgmdV46u3KkqXGgAoLjx6/DZ6vJ9LoKFbKIMD3l907t8yawt
	D/s6c/NkK7JQ8AFmEeBy4Ij1j/Qn1qA3b5Pb3ztBfjYhrEqofkrLvjnMl+Bpo0Ju
	pn0yVUPzH38PIGO998WRwHbdMoXV39mcEmG49Xhkn/w1tW9It2QRrN4FzrEnvpfE
	n2WUrZ0Lg0uCRtoMBo8Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794337886; x=1794424286; bh=P
	MUWBMfq30Mq7HyUgGTYDDVOep9BKY3FWq1ildp7o/w=; b=BbHgIDtcfNKHi/mNM
	9xjs8oMNRVC5ukI6lRF1usi6n1jF8hNlyxWPP8qKZsU+lwgLnlnsQvXiP2g5aqzx
	scTk+hTYzyglWyX16VftQBiNN91bjyGzrh2DkOpMuVV0vB4wvz4g1XhwIq9v5EEZ
	G0tRCCmQJsOfFdQsGRXWp668wLMN+aWN6kkEEsbaPIhI51FEqKolcN0dwb8X+4nx
	SBrbds6Tkd/3B46k4ByIRIdbJnn9Oqw3C6YX/gbxFFLF4F7oUqonro8dlA7R0BM0
	yfOxQkWRwo9fdPxxPATfmJx+PvQDENTaTMI56k36r0riOubZ6yc94k1vdo88iP9n
	g+9SA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794337886; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:wR6Mb016fa0TKvoyqQN+mMnVCR5qBC4MuxQ2AoH+HqOWhTz
	VU5EqtejU2BJf5X8t5Kh11nSusKQqNJWnQDYP1Op50hvhAlH0ha8pUxGwv+zAPW8
	pdVi5EPjWGwRItGWnQV6l3ayt6lZWHK7UkEq29h/WgijQUtUvIUtld6EKtCXUtOI
	U2BaYulMCuNqZcLCpj5BibjJtoCLQUZ8v0oEfdC9PzjdYIEH9IOagerdUsQI/GRH
	AJHoNsZLvmFObOSgN8heKO5bF9VkEo+ZY+ReKge9mc5h2wx8S+W5qJ47im6PHrNk
	jW1d+zyHHTWQkXGWSWyphC8eR3i20d4m6HBAPyA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hi6cYgmM36EVHkTHYR1/5j+S2riOtBRu9eVOFgdFv3M=:4/Ws3CzfxKxhSA9G5BsKQz7FF1QlhY2ZXx3MSsBeql4=;
X-ME-Sender: <xms:XWzzahvxofVaz0BrO-HuxuGJwVDaFeTBxdxIOmmvz1H__Q71OQj3aw>
    <xme:XWzzaiNuQKxgSJ22W-u0ckH4umE_YwGPxjHbkmnHl7Sj2U9SnXTxlrWb_7BFImvnu
    eievMDwUgejcLQ-7oucfHUosFtIFli1liJJ2N3XCYtL-EVq1zgHeMzX>
X-ME-Received: <xmr:XWzzan3SB4eBgwbvVItQpHvUqeRuWy8oZ4UULbGPeYOAOGz4t4cy54SrzzqIcX_eV8bmm0k>
X-ME-Proxy-Cause: dmFkZTEu9BqDtNH88eLZ+S8C5IYoX51v3p1TQB7sMGS0s/AXW/6Mp7qcLhxEuxj8b2Llo8
    oqfr8kgEgX4zVOHIe/M/BkRQ0mQK4aGxEIm+bHuzUJSWgY9Zrmop5IyPeTyaBUPVGeJSiS
    2KGNnnNnVcE6rfy1uqT1FNPEZ8nAvP7YwqVYtiWGvdMfrHbU7aXfNPULbwHPQ/f0fB/XNj
    bjTPa9upP+sLpukeD+yylxx/nvf8cYMui4+rpu/NboVBopNZ1ww5JLLBP/O4AXCUwtOpN+
    q1ztUB4zc8rCPIyKVW6eM6PyqvVJtcWxMFuOpvRVm4s/weTlUTzJG4ae5yARKrvDHqckf6
    FGY0W+2q7i/OwzyzZvDPRJX6N7w0aRd8DiRQB3X0irUGBz05zOHst+RLT9yu+d9gmGM739
    o8PwF4ObHmel+Slva+IvFD7TWCm+XNELlTADvwpP7yh8JZAXwrWj67iAnf8j58GwsGGYqb
    +5/gZOhfE7JRWKsE5HrJ9+DMOE3U5YC4FLrH6gMGoKRlQ45YRlJ6OUBOroNOEAYA8HZQFz
    mxwogLVZeVI3fqqw5CeIMY9gLljZKXXTbdt5nLwEW81+tQNgInIAMb4xGoM/y4uf8wyxAx
    pKcFWYc7j2I2KOwtFTf1AyHINOX4HGtCzC2AlhA1l8PU2vpsLiHwOJOiTjrw
X-ME-Proxy: <xmx:XWzzamNuPgE-HG47B2UDEvE1QuCjA_wJMzNqX3Moxhh4ilYxd-cQbA>
    <xmx:XWzzav372KlgkOGy9ZK2_15vnF6EPnYeKp1vE5uoIoP2F8RRTsGIxQ>
    <xmx:XWzzalFZM1rtV8UbkWhOx-r1V0aEtC1zLWTD1yxqp1WV3sdTtEfh-A>
    <xmx:XWzzak7bsYzJ1TaCS3asXdt_bKjViB-WLC0J6jPHeiTEM2idr9FL2w>
    <xmx:XmzzanvdD89Wo1zNtifRCeailz7GkGHwA-IZuj5k_223PzBlJuOYpqDv>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 14:11:25 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Jinwang Li <jinwang.li@oss.qualcomm.com>
Subject: [PATCH 5.15.y v3 3/3] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Tue, 10 Nov 2026 14:10:52 -0500
Message-ID: <20261110191058.1747963-4-oss@fourdim.xyz>
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

From: Jinwang Li <jinwang.li@oss.qualcomm.com>

commit a9f9eeb5344fc7dc625e5700ccf09891bc2603b5 upstream.

Adjusted context as stable does not have the lockdep_assert_held()
call in l2cap_connect_create_rsp().

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
v3: Drop the AMP change to l2cap_move_channel_req(), which is not in
    a9f9eeb5344f.
    https://lore.kernel.org/stable/2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org/

 net/bluetooth/l2cap_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fd6c39c5c81a..fcca325c004d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4465,11 +4465,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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
-- 
2.56.0

