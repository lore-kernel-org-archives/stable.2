Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093687;
	b=uj7T/0vf+zX2y9q4xUutvHrfrFhRh5+UiI5jmn6cbPuYnClbHBFOqpWCtD7bnGTfWIxQ
	 KEJg9VocCVWSjbtyXe6t6vZuYsDCAKfCkTYgr8uXpL9Zgl4lErhw1Cu5lP8mAYNbdRSDE
	 cp90UuQU3vtnEoe1TGYRvIJMzVFaz9EQacY8jUnnabTomDcaUMUCAJqxDN6ePpOq37rBa
	 hfWDxOnD3ilnpGoqMErGTyBRleEOw/QFYbM6v2Jf/rND5mvkxIXS4U2MUOV1d2M0AxJNc
	 SaEaMIwzwZwm+OEsUuqe1QLeK7ia3lApZF2apSwPmb89yD959fBV10ZPtq+s5Q5Innw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093687;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=QX9KdM6Y9Scydp4zUuERsrVtVZEqWXqlfDK/a4cMo14=;
	b=wj1fleYJ+HwBLz+I45YomSy6pVYum4BVobnGhYzbTJQNR4LDZXBNf4cUq48cziuV4F5a
	 MrRayqNaThLQFOR8gkGfdLjdkfuPqseOGJQTryV7s4GAxzIOhFGiUToD3uSSMgp59cRiR
	 SvxPJH2Cbv9VK/DOChQSBP7t1hDNlZBN/eEUqLq+K3K/4zOpHrmLZNhBim2FBxi/VBnat
	 caBgYVebCEQ3N8UfbTOKJmg1ZH9zPV+trMHZUVUQ7LW7doTM1KvBERFMJzYqY0hdIoMr9
	 Y+oh6E8olHzzPXrELHPLbRx4Pe6oPnMHor6Z+I1jeYJTdp2u+wxrza7XOtGcPC3/lHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=kq4E+gj0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="WBrSQ/t+";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC7606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FEC7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=kq4E+gj0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WBrSQ/t+
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1403A1D00113
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:21:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 07 Nov 2026 18:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093685; x=
	1794180085; bh=QX9KdM6Y9Scydp4zUuERsrVtVZEqWXqlfDK/a4cMo14=; b=k
	q4E+gj0K89PqNNoxpgx1a05Xt2EuG/fjcdaZYiQ/h+BoURbuAsU2clha/SazAGpi
	FpKFThb5pjO6v9JpEHz3AfiTRb2QIK+RPCsa0Dc6Hd5rVdtVMXRFJfjChL7kYcMW
	1QjraAnFhUHlgKMO1kW+8zyvNlXUi8mG8lElkBQ3Q0P187r+5g71BHniYsZRpw3r
	87koB+GdU4wOYnsg60fwPneHp+Nnsi6JhPKNPVdvOV7DJUnuYub8W/Z4303s3c8X
	dOnJlcTeahnY0tsLUw9polfCeLgQA0Y5+1zpOg6Ir15bUXpNGtJZ8IagRPx+ylAn
	K2x1C555WZxZAUtK4pzaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093685; x=1794180085; bh=Q
	X9KdM6Y9Scydp4zUuERsrVtVZEqWXqlfDK/a4cMo14=; b=WBrSQ/t+s5CIoj50F
	QWRuSUGFWkbqQP/ovjdLnw3kZTdhxePbl2fQaaFRvJFIzoK353j2NWWYnIBEweSc
	Y8Ey7gqrI2kok5yiTQVgYxcmTs2Yh0vD4ENaMvdAjR26eT2lHK96T3nHII8z+17r
	fDwiElLUayzXzn/ovUZKhx6dwecp1E8rOyCb/YvgizBvyE2RyUKMwtyliza/8KSw
	ETqC145mnVn9Hb+zRiXhmZ18y+C9KW71rkmGrYf4ECI+/iUmdAw01T3Wh8r9aD4r
	e98JmuFfvAoBqkrrRvgZGLJWrIw251CkJa7DsGcoeZcTcDUJUsm1rchwKnCBGEhh
	6Ohww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093685; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:pkqB6uBNjIwpjTYVtO00s7Z+mRqKiroxK/RTQLaUqUNPVeO
	ZXDWw4wzbSKQdn5H4jbcI4knuaml2IHwYpY3Ql5VS6UBsDnHvXFTJ5Xh2nPkidLc
	gc+okUUj5sp3FHyCNF0VivrIxZNRX1Jx5VpmZWy2HfomKGaWpRnNfTUQ4jaOnz0x
	8M12YekrXboBP7FYohzdEa6SM5SlgRWuAc4HiwyRzZkjyLPW9xTjcAVVilgMwy0T
	oYktwLSX3Q2yuk5vBQrmY9rsgDiKPYAoK4KOmzfl0wD27oHjtlZKmA8UgDKPAARX
	QgltOSeAKNbVtS3iUAwjSBDoNlNGUww9WU5dSXg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iM0FINu6WmU4nODpE0f0ZPNRXZ6gv0JfS5Dmv4TCKCo=:qyARsz4SOd0j8AQpWD74L2brSGbWcyXrEMOX/XvJbrw=;
X-ME-Sender: <xms:dbLvarVCjioxsqsm2ztWqkYSHkrv9fk7cq0laZbEguf_2XohszaBwg>
    <xme:dbLvarWIJ0xsAQmcVsKFRAjnNzszaRr3TRBDT86dI2ehkcZKAupBdp9l3sp62nC3k
    FmikRmTPCbwepU4ds8dHKkfNdHPS5gj56MnXpZEeB4TRY9fRpRvKwoA>
X-ME-Received: <xmr:dbLvaqdO5VivEgXerjiZl5o34sW4rnOGJGNhK2Uuu79x29zWulgDnYB7jEeJPDGl22YcUI4>
X-ME-Proxy-Cause: dmFkZTE2DRA88AKHqrCKvAq7hSujylkR7TEj4t6vZl0asuGgGiQn1GTOUFgI5BGA1v9ZdO
    RE7jeYEuYiNN59e1QzYenoYsTwlVJDXqpIazRja4iRvvDEOTm2Vwv5Iu42LbJWhLyG+1To
    ui6dG7c6oSaDbvCOyBHI6jBfD+PJH6hARwhp1MpC0OPJRp5ocrkGcbfsvl3nVhb43szH1J
    z3cgvL9gE5nXf0hNE+/QVpap3IAUGFq3vq6DLZvpvvZCC4lRZdcULbL9/MMvaAYO70AYE4
    oewfgGl0Au3s8DTbbExQ8AoLKDlkTE3iyH+h6y5V6FoljNt2p03DoKIoGrkdsMipMK5oXR
    KUgdSgia/IeDHUv8nYJyq6nIAkoDTo/mhavaUSZbTgR3II5Xt/oc0PMeAHW7zZtriStyWM
    RKRTlH16ZZOFdj5N7wPSYvykRkyfXM6qngqaWN5BP5nKxwbk6ffxSWhvIgqiV3BNpOGOYK
    JhG1opFh7WyvEo2AayIUeLqD8XgNb/DFPU/wROYStW/ZOR4x3ZpNXUgwPfpdnwziXZbXb9
    P5gI5EQ2JamqtDjMu97Cg35b7pePYBQ19Eiv1udwX7x0n8Jioonb0eASfHLYafpBE4WO6U
    nKJGPMPWDLtcoMevpRveVpFX5KGnrsUayrEz7B1phcPGsGDSsEfEgi3a/9kQ
X-ME-Proxy: <xmx:dbLvakUI0jx0hoodbvHE3pN3Mt7v3UveCICksYUw4LRaacKcJQkm1A>
    <xmx:dbLvajeNSnyFl7QxbY8AUEFtVX5YC7szQXBzo5HPtjmj9ZIklqEurQ>
    <xmx:dbLvagNLgCrZC6GF_52KTqet9eRg338nWtrOkcW6Gz6hkFYBZcSlgg>
    <xmx:dbLvahiwsor1mBrJ5E5VYB58tLNxszLzSZwAGh8O6QcMSWYwYafhjQ>
    <xmx:dbLvam10buxPD3Q7mNEaEowzG3GMNS4RFjf2mxmq2gfQ10iFI9Xe7hJr>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:21:25 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Jinwang Li <jinwang.li@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1.y 3/3] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Sat,  7 Nov 2026 18:20:55 -0500
Message-ID: <20261107232108.1873786-4-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107232108.1873786-1-oss@fourdim.xyz>
References: <20261107054925-failed-6.1-6320736af7dc@kernel.org>
 <20261107232108.1873786-1-oss@fourdim.xyz>
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
 net/bluetooth/l2cap_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 174f7a513f9d..69040c96e0e3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4319,11 +4319,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

