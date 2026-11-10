Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337914;
	b=5tuHW/BM/5v4yf+1y+2HlAzNLmNUpaHECGbgBoGw7qgE7ztLCsT6IOow6jQ8SBXyj5cs
	 ckJ/dcfuXWPV9QZkeqmWSZXK8tASEEAaRBltxIAN9sfGcOMSQwbUQk2z+UjKQgVSJdlFK
	 PKZfmwmKj6rUmZkFwSonml+haxJ0T4s0WjMqFPjUk4EEzC4g2zN3FA/pLbehkSBhat3xf
	 vrDiyvEx/XFBy5OT+ZZMtN2UUzFbCYRyu4leE2sBzfYL9Gu0iVPIHWNH5WymzbVaQxgmr
	 vdz82fZHVgwVVa/MFYgUem2QOxKednB5YcZFtk8CrsDupoc6qUCra5YI6kL5WGZcj9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337914;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=VkwiFDKYfRqHjh+h81eEuVlnaSKWoqJwOnkl+zFTeUg=;
	b=RiRZbflAUO5f/TPuVKC+nYdnuyMr3hbSosFHEAZa3smBo6P7bmR9shxwtO87DdwrNlNy
	 gTx1Jh+RcwBAcFRA5AzaOC18qceROMRUCQUqdtg5UFVK75sNywljC4g655IlREMqLLFWP
	 uKp6eVTsmocL8eq915KCjrUKZzUZNJ+wigLsP5tXdUiT4BYJcM6kSpGHR7GT8/OstXI+x
	 n+xwnKg9OIMXf3bb2E4akZ6cJ1qIgWF9kOM1S+/Jncyik1XuF/YQSxnLLWCTHjCLck50p
	 RiJA4FduLWTV1xLAOBrmFREPkXwypOZ2yre4Qe2IJrj443t94pgx6hgecIK4Rq6t1BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=N6Onze1Z;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ATV1vcrm;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D26606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20D26606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=N6Onze1Z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ATV1vcrm
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 54700EC0857
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 10 Nov 2026 14:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794337913; x=
	1794424313; bh=VkwiFDKYfRqHjh+h81eEuVlnaSKWoqJwOnkl+zFTeUg=; b=N
	6Onze1ZcQpCbfpB+puYQK1U44cy2RWTC5JD5NcfyyTBU2uGQvLv62AXjjDHNUiFL
	RkFWCoFEgXilAYI3sQNAQJtRTOc703lUTTpro6NoVBshHC9kRpNU9d1So+WUWHyp
	2VT55lwtskPQWVBMswZjx7Go8bPrpXs2iIhzvrgbqM0QgEhe7mP+pRHjigRLEWEf
	1Dtr/ubBqrhmyVk1HND6Peue2JIqos/DegTFheJ62ci+DOUDAEAkhSxXTEe87jXY
	diHK6lCFQC+8ZxCf583gY4dklNJ7mrmkDwk9L3nPh9MTubpbHOTd36HDYXvB/585
	YJoml7LAYGGjRLLjNBlrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794337913; x=1794424313; bh=V
	kwiFDKYfRqHjh+h81eEuVlnaSKWoqJwOnkl+zFTeUg=; b=ATV1vcrmjdoTiezZB
	cWi9v1TSmGEN3R66oekkx3xkgoYvUOaFt8fYWr/0a8in4JoFQpOwxfhEIiei65Bp
	iJBnh5mBlG9d8ChLHm0N+JDXSdXCZN6xrp137iEQ8Vmu1vHS6ikBoYaS1pOUJ6Nj
	ibKCOC7PDef7ie015ypzlQkB0Y7TktxFHoOt9j/P7pX/DQvxgDVFabKYfg+CybIS
	fT2Z0MzsVExgXSLp9W0YVJDtCAulFXiel7//4uzU7P0+y0zlk0bxY8pkT85W889M
	5pAvecHt6KRlShXQYk5A1mfQ2fmbS7u8QuVfnHF0hgOrouQ0BxnEgE2FjJN+hI5n
	Ez8mg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794337913; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KpxZ495urn7RSlHKsNKpwQN+Aig1WW9zlj8YbFYRaXHjzUz
	v3srVexszLoyMD3VsjOFHlyWY1Raeu1V7Mu+zxEiy4e/UNrJUUSHBDB/uaS5LGTI
	wVPaigTWK8dYI1zPeQPwfqqLaJC9dIjjvbqA1/F7aOneHL23P9Cl6gNDiisZNJzw
	kcWH0DnA4TkBEJOpV9LTk/sx0VINHv2fdmTv/jREeTZz57U8/ZZ+0A7TWsE2xP9K
	MRF/x/8T0X52UpXAu6x1Q3Jo4biOumSa/Znc1HtHvVnnTnyfu/NqUEgfoqd1VAYB
	lQ2zf6v21yvvK1s7dSMplvjbHyB+Ookpdu/Z16g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0CnRwznio8QUMZtyKcOVPsPQCsWNtvRcUOXRune6MeU=:TzvywuVy7vuE+9UCweU6qy0IxwHw5v/kpsY2IUYf/nI=;
X-ME-Sender: <xms:eWzzau9bheZK35eaXoOIYaQxbxXCkund6f_DNSicdhKxRtSJeISPtA>
    <xme:eWzzamdif-Lhi2f0bL1i12B188awNoPBFYdjd3xk5dV7KZy5DQdBqS97Iwr-tlosz
    BMyY99-YAKSgsrrMdFIH5n3FAlxYKa5hD0MX89VYjs7u4oCCYCmCB8r>
X-ME-Received: <xmr:eWzzanHr-lUF3WGe98FwDNb4HJK1W96TisJs3Y3ftyFUJ7dVodAR0kawGWzHuT739Ii8ecg>
X-ME-Proxy-Cause: dmFkZTEu9BqDtNH88eLZ+S8C5IYoX51v3p1TQB7sMGS0s/AXW/6Mp7qcLhxEuxj8b2Llo8
    oqfr8kgEgX4zVOHIe/M/BkRQ0mQK4aGxEIm+bHuzUJSWgY9Zrmop5IyPeTyaBUPVGeJSiS
    2KGNnnNnVcE6rfy1uqT1FNPEZ8nAvP7YwqVYtiWGvdMfrHbU7aXfNPULbwHPQ/f0fB/XNj
    bjTPa9upP+sLpukeD+yylxx/nvf8cYMui4+rpu/NboVBopNZ1ww5JLLBP/O4AXCUwtOpN+
    q1ztUB4zc8rCPIyKVW6eM6PyqvVJtcWxMFuOpvRVm4s/weTlUTzJG4ae5yARKrvDHqckUm
    NCEQOzz95gg1E9TvhmeApu0f2/5yWky5exWchTYf5Wth4XFZA97p2EOF8/Cyy0TtA1PWEc
    vXgk9BRACeH8TJX1/gpZejo82KsIYEV6mrD447on4e0TkHT4g2IX0R/p5qaR0jPdXOkcMM
    +UqZISDIOgai2Cas7AVBRKOGH2ihbPSzhg4WLzxhEmExTqWL4Jvv+lOQ57gFcVNNWhjyjt
    85iWXX+CiZe/EsPqOGXHQDfOXwKsGARG5X04yY3UOj/IpK+qXjNBL0PqAcQAZyZcJ3OBye
    lJ3y6WpO+UqxRkrXH1b0J0i9edqn+aFSa13FRc6r2JIVYsAu7Vauxa0XLjaA
X-ME-Proxy: <xmx:eWzzakdGGyBJhJecXCBie9eIjDKhYHNXkkhM9GeqU35dvqi8VdmzLw>
    <xmx:eWzzahHAB_asx-A26MYR3DZ3HBHgPK5KbTCXJZ0EUoV-g2NoErD4wA>
    <xmx:eWzzatXNtuhDeo3xc3MvhA-HS8YdS3m7jAvwqPpaqW6uyFmPyqEw4Q>
    <xmx:eWzzaoIPCTek4eu7TSVGiD1-D7NjKr8ISJrsA-0LULWKQgVbq7Fclg>
    <xmx:eWzzan-wPEFN6RbQZWCn18FqGYdwEWSQ9fEDWAssi6vnT1PNh-4_enDO>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 14:11:53 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Jinwang Li <jinwang.li@oss.qualcomm.com>
Subject: [PATCH 5.10.y v3 3/3] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Tue, 10 Nov 2026 14:11:26 -0500
Message-ID: <20261110191136.1748573-4-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110191136.1748573-1-oss@fourdim.xyz>
References: <20261107062323-failed-5.10-6320736af7dc@kernel.org>
 <20261110191136.1748573-1-oss@fourdim.xyz>
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
index 0c081b8bfe63..015d695f5f05 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4500,11 +4500,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

