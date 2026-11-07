Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093555;
	b=HjcIVao+L37jMTb8ccLFUUKjVN5SmSjq8+1RaK2/2yu9KHrVNpnqCKAQ2TMjOYlevLo3
	 W9x2Fo70Y9W5ZQ6QMdXh++q90DlyTY2xG9MB6mhJqDUxqZ3vgfGgX1EKIEEEBt+4XM8PJ
	 P2xcAeKqbrU1fYPpnH59QezmaZC5By12GeJ09Szs6K4sXIpwmRK6v8ZkJRnVsT2gXTX9q
	 fJRDSuQt1TCt7zHblnwUTRZgsFBkL9DkCf0NJmB9JAt1OAOZkXwQ7k9yZfkae4lAcOY5G
	 ZQ4kTcSf1orzuMrtm3hYO/mtbavhQDf2DfAjSRhIhH0vpVDGw3XOXwXTPK/UaLgEZZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093555;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Vl7w/lbXqq6S80yOrsuDEd6jJpIF5xUDhDKVcv808TE=;
	b=kh8Rv60vIvhjzM13qqSyTq+h5z5X9LuCgu6IlmAqvqLWjhPT4FfmYb8pCbled9tgODud
	 zeLOyA2E2YDt7Sqf6n4WiKeU2k+gTK8Cj+oK+YnQcf8GVIgvLYwL7XMIkCkycDMTLp0Xw
	 8DZe6Uh8brRSjmRcFMouOVUN17OtCLJxMECuziJx7Y0UNQfKIzfutRnkwJRo0XGxMmI1V
	 7sjtzAyW+eaYs+Np7u/8VFqF/ClFetZW6w8YwcBu0pQil2LyxW/fBlrBlxzk8OrQnaT7q
	 BybViBPfewW/KL8rYD2S6t3IuUoZ6IupKzcgEIASbEsfMPJhwkkvRurDOEiQmqNiltA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=Of6foikD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4SBThQTc;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 977B3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=Of6foikD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4SBThQTc
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB5027A00B8
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:19:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 07 Nov 2026 18:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093553; x=
	1794179953; bh=Vl7w/lbXqq6S80yOrsuDEd6jJpIF5xUDhDKVcv808TE=; b=O
	f6foikD/QKwI9dittbSaWh3l3AhfFeiUHlbq9r8M36LklgLCwgSDpDitc3dbtwgJ
	HPF0LYBn6khNW3xwvugpBy7YA12H4EZYbOxqv1cXa7tZIK2WoZIaYvYz3TIvPYBR
	1NtXW7M1s/NlVoZ/V9eRsZBM54lvD955uFM/J6wGoEP6qmgiGO1MdcleYJipBfjx
	/cDtGLqm73iDc+kBEmaLnOI36PzgDWMFimYakmzciDsX+MxlELH4rfilB/39YBzW
	oBe81p/V/531wZEPkNiQFXq5MedlQY1Xm4hF6Gdof1Fw7mbm+FrdxiiP2KpRxBHk
	k59wHRploIktpHh97LUHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093553; x=1794179953; bh=V
	l7w/lbXqq6S80yOrsuDEd6jJpIF5xUDhDKVcv808TE=; b=4SBThQTcBkiuhNvDk
	dji+E5TbKk2HQHPF7eHIfZPhR+pOwOnfAqNR++2xNIdd9M0lZ/JDpsgafpxBeHEj
	qprWNIHYApi+dv6vXvZmr3N4oTjQ5stPZHkMbYm+yTnEjYz56GfwlLP1NdomZmcJ
	IU2nE79zTA0acfOkCGsEutFkdAT4uyYjq2LkH1bLG3jXrwSwUgaiQolN1dC1OI4w
	8MV72s3dWXSiNdZ4LX3cFef1BOmXPC9hWEUIMzjADrsTWba/ZtJnnY6HQ0tG+SNY
	HAgMcNvQf/03yGSnFHJyRwAA2mUDVT7BEd+bfFnOnNL9YeLFe+NPL40TiTqO+8+r
	OgOOg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093553; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:o2iUWTI5nLGQn/GdLjUHbRSACifv5hndGzX55ALaZGP9AFc
	KmioYQcUMLqazkbKdQFm1PU8Zd4AaT3l+osoi9DeqEi63QzlfTkK2lEQISBy9x0Q
	hbskO67R04kBT9b1FK7CWEVGAv1ohbpdjLcHq1cZchKhU+P35tiWfqqQNRX0unnS
	42j1rQHXqcvTGpLRBY+BwalY14QQXo1zit/glTPYfO6BW01yCQE4rZha3amusu1i
	HGrqMgLhQNw1cNMl6vcLKUZXGhfY4g8i+CWHb0N+3J8YFSHaGxT7et5vXpDL63vl
	w0iLRNB6i14b5z2jzDG5QyAe5lWP5eYhQZn6wdA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nb5nEa1DuD3PyyQ+/2FTVjmNIczakKlFhIpWlC8Zch4=:aM6mPkXh7WVhxzSFVcNgARqnNZ8k3lDJsDWfXUiRYOE=;
X-ME-Sender: <xms:8bHvajU4U_mRBnA05DWte25GD2ojAMgl3xCoxt7XWmrviHrNQq310g>
    <xme:8bHvajUQlZzNMghkpDIoJ2dLIJOktQGnD90_H-c4gyAy8mHqrexRm3r3a2IZBH0-7
    vT_RB1SdPplojsmb2gkMXOysoDRtBIgkrVg4bnpz9V9CCcNkHITIsHp>
X-ME-Received: <xmr:8bHvaicARelsgA06qUTbZ_HApxsmVFE0WIag0imOz7IreMOwHMoeOyg2ev2wplUnV7EWc18>
X-ME-Proxy-Cause: dmFkZTE2DRA88AKHqrCKvAq7hSujylkR7TEj4t6vZl0asuGgGiQn1GTOUFgI5BGA1v9ZdO
    RE7jeYEuYiNN59e1QzYenoYsTwlVJDXqpIazRja4iRvvDEOTm2Vwv5Iu42LbJWhLyG+1To
    ui6dG7c6oSaDbvCOyBHI6jBfD+PJH6hARwhp1MpC0OPJRp5ocrkGcbfsvl3nVhb43szH1J
    z3cgvL9gE5nXf0hNE+/QVpap3IAUGFq3vq6DLZvpvvZCC4lRZdcULbL9/MMvaAYO70AYE4
    oewfgGl0Au3s8DTbbExQ8AoLKDlkTE3iyH+h6y5V6FoljNt2p03DoKIoGrkdsMipMK5oO6
    QO4EQbIXFAOnapQ85RDtoAORJfSc7UrcpVr3nStAWOoAfCWn7CqE3Hrh8ygabAf8dDP6zJ
    +T8GZbsmPL6+xBHFhTtvUPetWPCLQslaKViaqNo5XcYb/VTZX8ooRsOStpqlj8UFnC5v84
    hVSavA+r4eWjXreYGF7uH6ehiaCoF9EMkDpjFc9S9iyi6tpQipov9OSnR8cXpDQNdtbyT6
    9ubCCOsem52R6lRSoVr9ZR/mcUI2T/puLO3qlAHXDpJMMyww4wXiZrOy5ca8Ve9Eq78MZT
    +OYMPKp2bS+nK6+BJ/my1Zj+WxwW2sJnMVeqODDgyYJthLaowDt4UeooS7Lw
X-ME-Proxy: <xmx:8bHvasWbCVEfVO4l4bSPjykwXaNsaSl881pXIv7kd17n0XSWmNNtsA>
    <xmx:8bHvardaeQDV4uyTAx_Hetkmnm7LL9l-I15LrRWMJHKOaT35xuxSaw>
    <xmx:8bHvaoPKDvGrqK5_zgm1-_1sAubrLoxexGPclnQQiPaJ51TxH1QHQg>
    <xmx:8bHvapj566VC7PoLJhc5UJZ5t_XGp2HtyOfvbl27bbB3LoNRdhxiXw>
    <xmx:8bHvau0jK19j3WAP4-LQo8lPRNQm8e11YbbxuIShqCVP3nbHZgfSyFVP>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:19:13 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Jinwang Li <jinwang.li@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.18.y 3/3] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Sat,  7 Nov 2026 18:17:20 -0500
Message-ID: <20261107231852.1870314-4-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107231852.1870314-1-oss@fourdim.xyz>
References: <20261107051130-failed-6.18-6320736af7dc@kernel.org>
 <20261107231852.1870314-1-oss@fourdim.xyz>
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
index 22bac1222fab..d648d5729954 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4332,11 +4332,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

