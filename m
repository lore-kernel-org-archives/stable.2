Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA74ED1B3;
	Mon, 28 Sep 2026 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618038; cv=none; b=lLtH3Y+TSZ6WiyEhB+VeJMaKPcYFnkGxoo6P/sLzBbZSLoyUBEaDNgpVVEnVzKTcosvvxqb/0Z6Ja5Y0ISBBU8PV5bGMiq9t+9gdRsanVyuYrmeHWr9o9Vi7CTBSIocUzJE2ZaaOkibXE9iul5NYWFfr/yYdCv1fS1A8cvIrQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618038; c=relaxed/simple;
	bh=G09cOkI/MrxkqMvRPdzfKdIrEsVQ7p2kWFvszfLgxiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfnDboSfdpE7hD7vvp6FZzIt63hVDg2rPcBqjbZSejyHnxV8TW8tIpZ2oDZtsoeYGNMM9pmND4dnwguuj4zOT+nssC0rUCaMZs8nZtUkJ2vo9JbLiClTqkBA7Zt29J8NVkYbncUlAC1Su+nCQMkyD9taNSzE0pKt1ZqlpdAE05I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=PN54MiSU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nMsArmGj; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="PN54MiSU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nMsArmGj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A7D251D000EE;
	Mon, 28 Sep 2026 13:53:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 13:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1790618033; x=1790704433; bh=H2J22tDXrq
	e9qy7cHlYoQwkfYM38cWsjmkwp+9m22pM=; b=PN54MiSUi+SBcHV6r/iGAp+0oc
	8V4WFF9H1JJgBOiBpOIGD2ktNvstVHtvMHe5Gj58NRxArY6vTNnneRSKZVgakvgj
	PvO0qypo68Pw8razvwKwilyfaPxoeGa4H+4umqjSBMHs2SWTzN9LdLmTxMO3iwDn
	pxnRFkBHnN0DVTubXh0V/MS4cGVR0Eeosv9UaRIuLGImbkhOptWt5sRM3x9CmlcR
	0/X9ZLBKqC3z9oXkWcyWY0EmgQdc5gTZF+EXjzOT1KKU5eO97oktC7hS64/QAMNd
	GraFkagclrPBlNhCc5cEeVsQuet9E2c2WfCAPabv80B6rkWhjUvfJMfKHTXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790618033; x=1790704433; bh=H2J22tDXrqe9qy7cHlYoQwkfYM38cWsjmkw
	p+9m22pM=; b=nMsArmGjUpsM9lBAAjmBNVLxCPL5RtIZA/NXdfr0U4n5pj46crg
	t16qR06J7eFn3eTh7NJn1XYaKLRTOYhYQzzijgZMWrFrXDma182DvbuAkCbj4364
	NE+6lN19UjGUhfI1ZgSjO+ywWKZMwx/KdVaHQnjl3P3UgNCGb2s7APNceu0c1pek
	93n0PCqKcW0o/CGins3U1a5cRaNPqvfSZ/AKa4X95VdMtYd8Y+JbMkag0EWDMqMV
	+Q++r8A13C5DJc71J3sbYBPED5ss7rOynvdT8en6Sk+KoeBNb6pobMz2CfBxnvK0
	V/IDlSxp5D1OItzp8cB3jcd5l04WO3ZVOWQ==
X-ME-Sender: <xms:r6m6anVGa4x8qjFkK0EfLdckW5oiXqj7O5DFYk-qYXSO_18fe5LYBA>
    <xme:r6m6anLtZ-sJxU4E6bNLhndofBpO8xFZwcxLp5FyoGz0fsJ2b0uRFiqScanwFM-IF
    coUU3o6IacIP9xo-4VRwlMQvqIfArxesI51zi0-YiUbRFl2RJm2WNQ>
X-ME-Received: <xmr:r6m6ajCQV3bA-pffjmbqfXI5UQogigvpRwmmI3_ME4wXA18I8G4SdbR8jMzY>
X-ME-Proxy-Cause: dmFkZTE27JY/jYJ02tOuk7Aq2tJS/AQ5ZrKF4pxSRJzEJK1jjitAWfx/amsFMnJcrmi+va
    nrcvBGYWEW/sSeg51KnbUlxGkHz84N8pLkydat28eF9rRYKn+INX0hT7zyosIpSLD7SuFs
    WX8c1DodCKkNMf04NUi0biEDRDlwqsvydL12+xRWRf4P60h2Hxv/QMLxT2UZbA9HRCCVlq
    z7lAVUIUUgpxSmt8GDKBsAFXKMuZPrUCGXayJErgAj5+E4yV1jLnKGv8kYHQOgBY7DC6ac
    zm9TTqjJH+JLqvwGzpYRku14Lz/ntjfwFYvn3kGcFeRVynCMpYr3v+mj8C/v/Mwdyt/KB1
    PErIT6GCl9+9gwTmDciJ2521k63NEr8ywX15SiiZ8hPB+kuZwI/iymRA3Ntvpi7+VmcmUM
    rZh2EuDmFDXOJ7LMZkdIlCPR7ifWRBVRxNf6MQ3xViGWAkpiM2mzZCgghpu+qVCvUtrTSm
    cBpFTgIOnNEKGXDHBZ1obOc0MkyIDi09RCDLceSY/K/ayM7WPMDwttSZeMf+PZPvIRnaXF
    Ro44YkQGUUW/9BEnVUmNJ97EcOm85AEIErnzdM1aN5remZA33+56o6IRCXfxzqqN+AYMU4
    CgFfLJZmuhjf3R8eflNfGoAFM2JeZe2QvPiEfD3NeKnDFo0eSv1XryzlWtUQ
X-ME-Proxy: <xmx:r6m6avHjxk4zu3GPta10SwRgaULV7syaUFzVvBILh-M2K4EVdRCnew>
    <xmx:r6m6aoIb9298tmH2edBijzJki78Ai_Cb98_4WAjO760n_gyb613xiA>
    <xmx:r6m6amrAS6bCtdyWeeHfrfmTnhmSKvPrnQJxr9yCW86KlbPO4BnK6Q>
    <xmx:r6m6avhE1KATWsX3kUY9bkqVxSSHTLMpIYPzw7rR321DBKfun9_hEA>
    <xmx:sam6aj2C8wlsBV-gWbtWJpTVkme3hjksKk7bPNhVYk_MU-H9xH6LZVWl>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 13:53:51 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>,
	stable@vger.kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Peihan Liu <ronbogo@outlook.com>,
	Yilin Zhu <zylzyl2333@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Eulgyu Kim <eulgyukim@snu.ac.kr>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: [PATCH ipsec] xfrm: espintcp: reorder operations within espintcp_init_sk
Date: Mon, 28 Sep 2026 19:53:37 +0200
Message-ID: <dcb164e6a1064fcd32c2e72fd9ee918dd1427f15.1790617484.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When enabled on a socket, espintcp sets the socket callbacks to its
own before it has finished setting up its context and published it as
icsk_ulp_data. Any one of those callbacks that gets called before will
dereference a NULL icsk_ulp_data.

Fix this by reording the operations, and rely on the barrier provided
by rcu_assign_pointer to ensure callers will have a struct
espintcp_ctx available.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reported-by: Peihan Liu <ronbogo@outlook.com>
Reported-by: Yilin Zhu <zylzyl2333@gmail.com>
Reported-by: Ren Wei <n05ec@lzu.edu.cn>
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Link: https://lore.kernel.org/all/c30b645074a1b379e0f7fe297f917c66137d9964.1778464688.git.zylzyl2333@gmail.com/
Link: https://lore.kernel.org/all/20260819155349.3555804-1-jjy600901@snu.ac.kr
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/espintcp.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 3e72b9f067b9..1087a8dd94f4 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -466,9 +466,23 @@ static int espintcp_init_sk(struct sock *sk)
 
 	__sk_dst_reset(sk);
 
-	strp_check_rcv(&ctx->strp);
 	skb_queue_head_init(&ctx->ike_queue);
 	skb_queue_head_init(&ctx->out_queue);
+	INIT_WORK(&ctx->work, espintcp_tx_work);
+
+	ctx->saved_data_ready = sk->sk_data_ready;
+	ctx->saved_write_space = sk->sk_write_space;
+	ctx->saved_destruct = sk->sk_destruct;
+
+	/* avoid using task_frag */
+	sk->sk_allocation = GFP_ATOMIC;
+	sk->sk_use_task_frag = false;
+
+	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
+
+	sk->sk_data_ready = espintcp_data_ready;
+	sk->sk_write_space = espintcp_write_space;
+	sk->sk_destruct = espintcp_destruct;
 
 	if (sk->sk_family == AF_INET) {
 		sk->sk_prot = &espintcp_prot;
@@ -482,18 +496,8 @@ static int espintcp_init_sk(struct sock *sk)
 		sk->sk_prot = &espintcp6_prot;
 		sk->sk_socket->ops = &espintcp6_ops;
 	}
-	ctx->saved_data_ready = sk->sk_data_ready;
-	ctx->saved_write_space = sk->sk_write_space;
-	ctx->saved_destruct = sk->sk_destruct;
-	sk->sk_data_ready = espintcp_data_ready;
-	sk->sk_write_space = espintcp_write_space;
-	sk->sk_destruct = espintcp_destruct;
-	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
-	INIT_WORK(&ctx->work, espintcp_tx_work);
 
-	/* avoid using task_frag */
-	sk->sk_allocation = GFP_ATOMIC;
-	sk->sk_use_task_frag = false;
+	strp_check_rcv(&ctx->strp);
 
 	return 0;
 
-- 
2.55.0

