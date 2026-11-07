Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093440;
	b=Gl1NKN411IAninQxeORkRcGdQC8TjlUDWDI08WAhRN9FgcA8WJhjrylGprkP0E5wivse
	 qIkoqgvPSyxu0MvzrtTn4mafuA9ilQ1SHtYTOvxSAmEcayqtGoCEJfvtkS1Ik5KkM8ES0
	 8Lww5K5VRArMls6XyojOuKpQ0FZK9RDN/Lf7JwjzY1mQ+jmOEj9upNq1L+IJpreSiRjNH
	 92GoPdsTGvwomNtG7Ttvgtmtd77ftcKCv9V/OiE1zvgVISnUkg1RIlK4CDPiH6eDGpcCg
	 58bPxt8WFung+Mt3OMvkJtZFYXszbeL5Swf1Wam2M7n4BCZAZEA6/BMQ+0TxrPCon4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093440;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=kFaWX46VbZjLwgMXINCqlhx5Ylqbh0Ouibvyt4q+A+M=;
	b=Df+mo0XE08tYCy9UZ94cl0gANCtz/JiMnyC9lh9IAYOFMXEV5/eVJ1zK8mS0euyizLYV
	 Xc1qQHZ2EXsu/IUcVXhK7UBJdgYK4tZezrRTEO6PfXBtIbeyB/H+AS1T2zHd+yr4PhGMK
	 uFgc5m5+iB4FdvJ1D9kG08WEp79p1ezY0Ti2Vvtkd6PzsCTALjvcLevocwKN5Hbozzjov
	 7jZEfHyjVj54wrAawp36hq8A17dO16xN6Ak/Nc8MV5I4yAhUskU9eC9T2CT4TxIZwgmM0
	 qaGjZzAvrE0r8vhOFwGskWqSnsT9HVbHTX9CTYVYJQf6nNhDcfZ22ru2Kye2AdrNNAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=UcapwgmL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OU6X1Nhn;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68D9F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=UcapwgmL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OU6X1Nhn
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E9AD11D00128
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:17:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 07 Nov 2026 18:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093439; x=
	1794179839; bh=kFaWX46VbZjLwgMXINCqlhx5Ylqbh0Ouibvyt4q+A+M=; b=U
	capwgmLc8HmSead8LAsxSZkIiLQni1wnoAHpXax7U3TSIJoFJHxB2pz8HsTuNQjy
	fk3i5JT8kfVfJpGTxcvlOk3hGUfnSs0Swi3sIupaR3MRNelyPndDNDtwRyut7Apt
	W1qU3ckfJk2mnkAO/vIf1wHUjqJtghcyfB5pSLin75CpbN6McEZ7uLXyjrOr63Fz
	Uw8dvLw7N4fs+TvQEvDzFcXAHpg676GrBg1p8CYkj6kAotOp/jQMm6BvL9omXvQ3
	QCOKphgtjsO7vmeIkrYt6sE1V+dnwai4GZTPVqdrkMQwKqZjQmVu9B9UH9W/eLs7
	Gz+DV/6BdlcVpSGN6lHLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093439; x=1794179839; bh=k
	FaWX46VbZjLwgMXINCqlhx5Ylqbh0Ouibvyt4q+A+M=; b=OU6X1Nhn4q2z6zdxi
	QIgKYfV4pnDpeUlNhtPgAzE+npuf+DcAaQ3qIZhJByRs8wiGlVnMns+J9vBGCOPl
	V8GSpBk5sp5MZZGZ/+bKVeYrDt1/fSy83azS48gisjsqAZPqB3UsjNobDV51sj6N
	OFV7ovVJm8lFFaiHyxrR4ms4rQ9BBTImCIrUXzcMaimsvfMty8+LqJ1lhrUJbbWA
	xgwxV8UiF9qZRRUnApYEoB1g6t6Yzn7flMYJAEuSP79gv0HdOXcxAf4gGgTQAPcN
	tjyiwyUDYE/UgbQB/JxqKENugNShEDs1oSN/4Lxt43oELoK7f8hUTHSm1I8bArTx
	d5t8w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093439; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OSWFNuLGmwoNUdQbFiC198O9h5bJuXyPubTVSwuT7xThjce
	3vdDTBoQCHB/s6WZQqCbSrkN+K/WarYp01/CPRxWuD5a9VyxNgcNZ0v/lzMNnG5Y
	Nn3JXY8IMHDMlgQTqwMDtKDUwcYjvOpilVCedrV6bo2RmoAmEXgyT/3L/yTdc7cg
	2Nt2iU/p226OEsCQ5fzJYQVeLKClN0SBgNLq9/YkIiENrg5wjURKQMbGqzlqi7s3
	LFyUnVGN4X+DHFAb7CXKoddbaamov3FXzOuAw7CXR7oLmkZKMUXF2FGkDnsmI3qz
	npnst9pOBkCMzKzgxGAfF+ws0vkkjb/JoWEGKLQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vWoGtsTrkf2QQ5QQbEX7qeOrlhb+zIb/Vl++xguGL8o=:Az4tUwk0Z0RqiQJxkFjh7+VxW5JNYKDDiqLxp1GrFY8=;
X-ME-Sender: <xms:f7Hvak8BXjl4fct14GeEbFq3_hRa46ut9eiAKiaOI_yZa7rvpMF8LA>
    <xme:f7HvakcM0oFEKt7Irg895dSO2iT_FHIUPQFqm_JZPZ9Wjpq6Z9fBRIW4DOK3vAboc
    r_ZEQulHHUlY1uFiq8i1fZV4PJoyt6xNnJcyoBVQVUTbw7eJF7wGNBUtA>
X-ME-Received: <xmr:f7HvatF_TEtzJSH9Rc2s1yBVYPykMPyC3W2G9hyXa25PWZ1OX8p1mtLPN5SlVqo6MSENv9s>
X-ME-Proxy-Cause: dmFkZTG4OKBtoL8ZCR/RILZ9HVIYsiyedYNwSoMK0fs3pjy1KoVI5QKNGkIR+qu2UJo0gZ
    HzA+zmsNEg69ZzY6X0FWa+zLkMFDxwNIsl9Ph4OTn+01QWTkR/Jo/5qW1rJ9nmoNurDIue
    QT+8hE5vQWriKMP4z24vPZOqUxClR8mW3s+b3sdgoVw/1pbgx+Rgr+CuyWm0Rw7VFfh3wm
    Ff/aXmVih5IN3xK3FyGhWQgzJM3srbjX1XKkRojmxjm98IEvfarefkGccvPNsccoj0M2Fw
    IAKskIg7qpYthFMz478vaSMrfqTxTgpU5kYVf4IOXxXEkR36tX+BOJ2DsnIOetXZBNvFLi
    ejqhSjYU3CcYkBG6O8JISUO4XUopmRqw3XpPFbT98R8ONw008D03DnviumyG/ffEWyXs2P
    zkfuLWCXWQeyzIAlDbIon/X3d2o380f3INHXhI7XQ9xBLil0wqA43Zl4I4h/hcnc3X/Vfg
    t89SK4Ms/SU1BUfykQQwCF0BoI2UAOW2RM3CdkW6QZWavway62Bity7eoz1eNfHey/MQoj
    PW6d5wfwFAqBUkARw/G1Ux+sNhphV3TrzXvjRW6OexpaIAXcpgx7Bk6EjgWCrGZ5htOU97
    DGJ0iBjRbieQIJgIpdaAoJBjaZCjtBL2ySGrH0xoaeGaqlyyn1eRE7GH2Brw
X-ME-Proxy: <xmx:f7HvaiezpeeOw1E0c4sq0IaudICIPu8oTkR6o3-4jMFTbY2wA8P2CQ>
    <xmx:f7HvanFbSegje65Fbs9UACZ5cYBS4UVa1BHXVX5RXaTFz7H8e449ww>
    <xmx:f7HvarU1vnzA-ebM6gmYyc5vJZdK6LTY19g8rNGrzwBAHMQ5_6s4cg>
    <xmx:f7HvauKJA-iuvcpaop8s3LoMIi3cJ8LfvKeDylxW4pcp4TdTJGw5JA>
    <xmx:f7Hval-kBMBm-Wjw_QlXlC8f87ZiqSskcrQ0qg_kQWdxlRzHfj5CclHP>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:17:19 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Jinwang Li <jinwang.li@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 7.3.y 3/3] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Sat,  7 Nov 2026 18:15:47 -0500
Message-ID: <20261107231558.1868970-4-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107231558.1868970-1-oss@fourdim.xyz>
References: <20261107050447-failed-7.3-6320736af7dc@kernel.org>
 <20261107231558.1868970-1-oss@fourdim.xyz>
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
index 01945c55e1b8..47f0449588ea 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4333,11 +4333,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

