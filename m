Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189663;
	b=5KDe/O5CrqlXPZUn3Px5/wbj0zOL9PwTJny5xWmabwJzsV7eW65lGX72peE0qhKR8+Pn
	 UICW878ZOwmCNNNNFtgZSZd0YRG0OSmnTadZINM4efOtM0cyC2VoAr6F3cjPqCxBP7S6K
	 NlkOWX/UxPsNA1BjGCcEjStSinCre/FMur2UqoYi/vrNu+hVrMKJ98MsvP3q1cSfl28LM
	 35ujUdXJvTKIXxHTtsLTBpi1tJqg37vg/nlKSIW9UBmwdypj7CFD9ZH/FSu95Bg+Kr4OB
	 jpm8P9irOibRjIwvJJLFlBLJDeVm467SRO4C0oAcQIm0a14pTCmUFBfD9r8OKqU7eBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189663;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=LpMzsAzNZAtjIF4ibMIUoeiLT6+XOfuHsJRsZodHquw=;
	b=OTlGlX5kL94MARfZVIKRCry5Jm6roidq56ZxdpNK64XyA9BXfQmr9wD5qeOfjyeQJqe/
	 u+S22GyNu4v4cHUA3AvE4TXICnRMEurWs4DQ9aOh3yq2EIU/RsCbyYMp2KWjtFlDgF2H+
	 YfZDR34hcnWfhP9bGy8HBSfobvifJm0KcRkGq0F3+DWBw82clAZBH62bWbqN0mhvV4DbB
	 FlEO4AtENMpHLws3bo2HmU9mo8fHqobrKY7K53rfvYlOWJm2KbKx343LyKsLTN05o3ayD
	 5x/S0lu44YFHKNC8u+Ie86swQbGHAt1Cql8BOLVIGagvMgSwR5/IGzn2RlwFwtr9PDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=MquT53bg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XQnyvx3P;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C69606A330
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22C69606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=MquT53bg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XQnyvx3P
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 76CCFEC0586
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:01:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 08 Nov 2026 21:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794189662; x=
	1794276062; bh=LpMzsAzNZAtjIF4ibMIUoeiLT6+XOfuHsJRsZodHquw=; b=M
	quT53bgfmItchpQRr7woxU1oOEBHj/pO2ovpCWIX0s6SVfihg5TuJ4CCPqjnKvsA
	ZtpYDnn/L9a1Fxa+YdW67GoSt0EKE3nVYYbHxN04bZ6x7IQzcYe+7btyTSOaH8Wr
	nYBjzdGMshbKDSFHgxKLgJDBXv3LpJAFE/dYCRcfTexO1XMxCKd3ax1vwcDzEhPh
	Xhnbv35WttmBrdHKt5G4MZ6Cm/wwpnsnjuoht1+w2j5ZtTOGUvEmGHU+MW2rB4Pa
	Qcti0IKp42l5XbhJWJfWyMSwfCjCXYXdQfI3eFWrMlPo6dtXE7S2GR2iMwPdsk4P
	6umWbJPyQEHY/TyALN2qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794189662; x=1794276062; bh=L
	pMzsAzNZAtjIF4ibMIUoeiLT6+XOfuHsJRsZodHquw=; b=XQnyvx3PH2wmCDq2V
	ecTPRHMD3a5Z3o03izgq9uEXBWPz+eRB1RJ4s8/ow4XQkrCjeZ3P5I/lhwHeFXM+
	r8jqHO8GxCXvvTXIZNAAXHS31oVbg19gtx5XJMW0vE5jX0NWdAlbbyNdu2xvl86W
	BB9LYdQTHTJKgpYhZyp943gIoNrmchMnv7RRYs+DVoxBEXruV+QsmZMVjP0q3xIQ
	zX49HAHCMPOZ/b6g/vWehJfbl/2ZINqEJxUmcbe32qCcHsFpBGV4vvvWKr7R8M2O
	4nPIWcRNs5NEw60sURCsVk7QMVJK1zF/ihFYiP9NTr0OLQXWuYHrzQQ6hzFaG4nA
	DHeLg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794189662; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:uBHFZFqPd9zDadJRdVAzzTcjVR7O0i81WPx3L1+0mPwwbJG
	wGRtJmghnv0CIiHZ90tXPD4AF72kPnhBjv6/rfWKUML/sEZD/9gcsEeMT0HS+bFM
	8aSyY22SgWqPiwsmFNGf+mF5bKjq/iSyMghvMssrXSioVVr7oCGI8AxN3wTpJN7P
	8MzIo2rtKDMgkadZ/tths1gjb7Rycl1lODQSvaRCk6ujePz79EzJsEvEyNsWPauz
	/kKofnJXVUSCMk6GVXmhr6zElNrd1rclvZWoEMMhKLZrDd4DwT3F7XMPIl1498Uc
	gVrDj8q/cEtLAAwG4pSRVcKGSpavMcYqz7V6cyw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qoKsE/Vg4/1FzGFUIuD5xZFDUvk/ouA6rAmBTHhdGc0=:E1ZLPs37Fq1uBLWYyO9pVVCtU2ZvrjJ/Kw4szh2YMJQ=;
X-ME-Sender: <xms:XinxaqDxCPlH0vdAq1apGs2HANJ_U4U7g4IEP5oi9ClxSTAhspveNg>
    <xme:XinxasQkL3o1BaEtkHeQwZ5nW5tFd_QeR6V0pZRAGOO8ERStOxdwvY2N3DD2qxgjY
    WkL4WtBFYxxy8WNxnDkpyZC5Z45FhWSZ6mDjl0pclZnWUDpDvZ0DA>
X-ME-Received: <xmr:Xinxago7LKidXNXCmtMU2h1DjCfyRTy3tIMvW_HVIA8PzSG40y-9S-4C5XaZienVQk8lK2M>
X-ME-Proxy-Cause: dmFkZTEI12/aAXmaA1CpneDiFO6RhnDLgwXlgIf7YVcZUjbceQglEDDgVxIIbIgoULjJUp
    prVGrgB0cXWeXtvJ77QdwB5NkF7zkQ8Chf+bPSqgKT8IUfcZfitnPaklFX8Gb4Mh8GlEhT
    fwwJXutj6cE+L+dQmlMweOL3ykICcK/DZVThJLKlLyvi22NQlGOd1s/8ci6WBt9Xri8SLF
    V/ap4tdG+JQYkWbrAa7WwTZZ3gzyLJakl0kLq253cDp2Xzn0qf4aR9pB1EIIOrZiGigU9o
    rNiUAcQRJ+ZkUjZC+0KV9qTTkD0DNVrCtJ/z/qrhWZZEw9CGcUh+tmtmo7JOHU4mSmcQjf
    V1fDCeVSxP6DzlyWlPLYvCoAxwjfTbSSpthD8JqgsNteNMmlwO56A9535CXP8CkQxkUwQp
    HRkgIZDdQAysyV+9LkiStUeE0stJhW84xSQGp8NhJRz7uySzAu0+TldK8wODQtnV67wdZ1
    1gCIb5dvoR7gCpawMhGMHGqzO1rN0LAppzJLeIA68tqt+NEqdzK0CsETQ9RnTEcbUckmb3
    c+TPD4wMqw7BZzK+s7Wx+cg3NFiVYBfpaqqRuvH1Of+zskLPYDBKem6PaAiC668l5jWPG7
    iXwoBjzGOGd8BklfjRcaN4y5SDJ8+l8kCeSU0ToL5d5kHVGKRpo3fvzJ+mJA
X-ME-Proxy: <xmx:XinxamygqXsTMsCMbz98ENimA46yVl2hEwGwI2lNTICWKVM0zpzTcg>
    <xmx:XinxatJfvQYKqE-ctkKO9du_eXk_7t8UqWnm5us8ci94c4-j2OrDbw>
    <xmx:XinxagI5f9cHXNyi2_R7K0_b8kSmNbSAZB7LqdcRvSslFmQZ-hyTgw>
    <xmx:XinxaqsfJcaOZ6a3YC70lBiNcGFYHfK49i-8IVcvjbXEUSJQwTFwkA>
    <xmx:XinxasxeG4q1sbi7Sx-ZfqDQMuRRbBmI-Tx_rZ6wA4aFm2WeiaYEH8cW>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 21:01:02 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Jinwang Li <jinwang.li@oss.qualcomm.com>
Subject: [PATCH 5.10.y v2 3/3] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Sun,  8 Nov 2026 20:59:28 -0500
Message-ID: <20261109020039.3035406-4-oss@fourdim.xyz>
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
index 57015fce49b2..9d3ca4bcf004 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4528,11 +4528,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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
@@ -5519,6 +5519,17 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
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

