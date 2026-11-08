Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096404;
	b=lSVKeXgtWChhTCpbkCRwJqr1Hnmm92hOKWwiztS0XLgC8RhZ/ABaXWYKMQAF1cp8pRBc
	 qOmWXC7jr28s/9JaDt76qdglnugVJOfu4Ei5cnIYQmmVg5qTJNOQVB+W+zdJHKRmLlYUS
	 cHWNB4+zi7mYAqiW+g1lQiM8fF3aLxhTB5jG0A/JpstV+1eWNHvlf/tpwaUrhnZrZRrf5
	 CNE8yk9phWZVKxhYg0mhrJyBlYF1LuCz/wVFfYUeZdXAfguf+lWAZ9ekDT0snl9trMQLm
	 5bZ3ur4482Jwd7GdCZsqUgBfaYFAbTtAgeHjQtlCEodvnCCdLRvOySPpogWyZ0ANgbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096404;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=LpMzsAzNZAtjIF4ibMIUoeiLT6+XOfuHsJRsZodHquw=;
	b=1DpDyzG1M9b6l08bcNfGXEnP/HAGFkoDyfX/w3fV5ORscgvVeXGML5kCF0oHXc7GYg35
	 /iPlFIBHORrF5yjJK0lh/gtUVr8mbQcv2WfY/kSFWUMYkt/CbwGR8D5sRbwUGO4r4no7+
	 JVhjTymA6f1ki4aSXwmlifv/Rv1o47W5XPCo9QGKA3VxSoOkuHw3+T/rSAjjvHYiYDI73
	 mv0H8TyzUja+XXAutwwBZbkv4Zciyd6BpSoExmvAd+Jxsm3WVXScycC/ukxwtIxBMWTvc
	 gBXmEFsT4KM6vPlZm8AcGYgXVwHxqaBp8bj9OSPBBP3MKT14g9w7+0eexC+AZBBQdjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=Auc16KMH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fw3HV6X9;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6B1606A32E
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 00:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B6B1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=Auc16KMH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fw3HV6X9
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A3C6BEC00BC
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:06:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 07 Nov 2026 19:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794096402; x=
	1794182802; bh=LpMzsAzNZAtjIF4ibMIUoeiLT6+XOfuHsJRsZodHquw=; b=A
	uc16KMHyEpstbIk1gvt5KFetnMwBCzMzvdz16Ii5IwWj4TyANDPQOR2FzkK7Jdnr
	JOmibIUSiLiTh5bJIvlK6iPjT6c050O5h2aYULYv8F7vSk5SNj+zOaZrxmSF9M3n
	CNoUynatees5Ve7bdGr8mLQ87ImBmlvhVkdaEjkALYQV2rcwuGrmKMgH0ebGKB7O
	psHlbbW1+aU5+8d4sQq+kvLoG7kD/2PXbBJ+vw9ggipbcGnbc8VDAgIAPrwbTX6f
	0w2wMCoUgboQVeykHS8AZTDL0Ynmbz+FoZo6r/BafqubKuLUFLMPrfpUzx4NJxyh
	EDxWe6e36O9ViY5gin0qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794096402; x=1794182802; bh=L
	pMzsAzNZAtjIF4ibMIUoeiLT6+XOfuHsJRsZodHquw=; b=fw3HV6X94zSdWC9pk
	q25iYIStHkgrpJP2NvGGhnG7HJKfWdmc6i5479/86ugAAw6emCaUdza2lJYG4xGI
	f3HzpwZOvKJw2gilR/UIxpwtCsMKDWzeveVBPnKETTsCqUwwQb4QmPJkjrXfqhOU
	2LHCmGkEbFbKjRa7yjwYZVyCRJCQ06r3dwllpcOxngqUfA4sZdiE3tOJIEpKakzR
	BvbeJAv9zYXXp/EA1yzQTeCKJxvQc0DOBIGYwvX5mZIbhwGhN9nmvnhIw9r1MdBB
	x7mGEd9QLpzClyruTYR3nYgtWzTWRubjUsDnxnwxh4Sgl4g5V9mONAl+6BX5nm4c
	A8WDg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794096402; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gx7COuR8tAW3LaJep8ekfs1R/cvl7//K5vwAhu84rC3TLBv
	besNxW1NK3V0Rsb1JpHhBbTNrnUkpef/RsgWNwd59MxgmbH87cVHphOmjOlZjNQ5
	TJwglrYRlz6up7sJTdIjskLQ23GeMGNWWzzCFwSe+b9jXCb5kOFZIPK2w92lny0r
	7DGJn4yMQOcdxVZtEFAYu0uCnJ8DkLnQT9ZeRyysAAoZEs71rRBu3V+LTS7xNfDv
	7n0Pq+GFWqZzA7gWQO7PZIvZXmyQgMIlBilDeqBBZMguGiibZglrFcmuxcfb8d9r
	Z4RpCM/tWN03Yzb533y5iy8xZ56Su9msM1a+/gQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:95EfVacwM5AnmlMy2g9eWkysUuQ1tBfk8p30q7Oo5n4=:E1ZLPs37Fq1uBLWYyO9pVVCtU2ZvrjJ/Kw4szh2YMJQ=;
X-ME-Sender: <xms:Er3var8We2OQI458t63STOq24olfTLT9TI98S6Cfb3OTu0qPfd1nKw>
    <xme:Er3vavfMtnSDO7GvA9d8IGUjz8rqvDNNwx51umXIi1Le3kPpQWD01gDvvLHanbMnk
    h5l4blDF_Ipz9cQ4uXXfWF2SpB9W5X6rn8mAVcPC8mwMWGNwq-63JE8>
X-ME-Received: <xmr:Er3vasGqEH7ZNwpH8LaP2nchWrGdLlpD_dPzE6DfkCY9YDW7ZkJqD7hoTmpalobPx3maiR4>
X-ME-Proxy-Cause: dmFkZTEzXctB9+QqvlwitGYXl63iBXXDJxaOS9iHJl+vQ3FaLqekKmL/SMRSo6RnttZEDd
    7F+IBEcIKrLEl+/01lY5NAmtQWbv94R46wLTPfAw35TMcYYay118ApvkUGHwUQ37405qaD
    G+ZVa+19wEM+Y9oXTRDli7LF9vfn5TcQ3W7fMaJxIxw70w9/u0Va9o0K9LtgED0WKrxAPL
    /e4hpz31kanYMcQbbVyIiN9+8wEqgM3PoEdAHe2MXeJ5Gio6/AuZu8NyDC+JAZ6WHCJQhn
    HmUtrUB2hO8UsABi7j2YG3F61c8c9LLUxwZF55eD/XPUJ2cCBW3e3wymPrWZgHDCluiaIw
    sEiEGoz/45Zv8eGUEWmjkFJ4Ep0RkqLiSZuUhWJ8uK2h0Yzhg3IbhW41AjQAG1T5Xp83Ht
    xZWkv4wZodYEvYZry1oPC/tZpvNK1694+odUMtkfSRCQG2+4rSof4PJ6x0H6w4Vl2vMZNx
    +w+0TjId2VBA46v4sK8N5Vm4eu7xznLazQrbEDB1TKReSZMGbDvGFR24EC/qt+wLKea50b
    2+ZOvx4tzV1PK0AAStOHLouP88JCRDc/ZYXBOz+7MEE2XXrsmRf3WTxUMVwkH9FbWUuQI9
    FwP71D3XGET07+tLHVmXD7FOJHF1oy04icDsbSX5vI1coPzh1h+b9CzseQUg
X-ME-Proxy: <xmx:Er3valeb_3gjt50SPGceoWCHl-wT0bhnKLvyQs3MctIoa9Z1tHE66A>
    <xmx:Er3vauFXbD4d5bUDSkqcgHxizdHWeYwGlTAka5L916forV7p7Pe_yg>
    <xmx:Er3vamVRsG-P8EW8YEDqjpMQtXDG_4A1JH1lyIYinnzsQ_st6uq0vg>
    <xmx:Er3vatJzOQSn02qi9qwuPeq9wF2lvbCrQ6enyr1a5Ro41s5-I4JXeg>
    <xmx:Er3vag8eX9p7t7SEgYppT6H70OE4BxnMZ07tBH5fonTgXmbCOhulUav->
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 19:06:42 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Jinwang Li <jinwang.li@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y 3/3] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Sat,  7 Nov 2026 19:06:04 -0500
Message-ID: <20261108000617.1969616-4-oss@fourdim.xyz>
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

