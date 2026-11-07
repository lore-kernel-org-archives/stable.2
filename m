Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093655;
	b=IQx6N4OTMwoY/gcloBZV6NUrgbHIKlKY/ZkWqsNqDDtQTUAm9GEjSLXktuD2BVc5QOd2
	 P0aMm8NWw2h1h4ZYAsHPxEghx0dH1e1bJK/eqEP0N9sIFr9RrFh96R/U9c5ZoPrNpJzPg
	 Wt76im8efLwIkxcj+YZoUoPGjS6D+EajkColYDbON/iOvEvtaustGtRlyd/+80+s5p/aK
	 z9Oj53XDqeaiDoC2wT/20jPG8yaBsv7Qqb0zkipoC7L6bKWgWAmPYw+AVUZzGtW9WiQd0
	 n23Nhg2IOqflkqsI9xj+9EfkWWJt6JstoDdFctUKWGaK03uEtcXWJ+iMuOFUUqZm/ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093655;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=X7Xpn7hnGvOEa0muKNp5N4hSGDoSQEPwsZb4EX/tEeo=;
	b=jF1zwZkGPr+k5TdTa2NPOzsID9mkkXIDL60kAkdLKJLme0Vrp2h8oxLSOgfVJ3hY7MfW
	 p24Hat9sSuqNbEt0t4HOiduTIC5iuRI1X6ze2dqrb7/Q3pXnx4ZizZxbFGRFexvuU4Vgv
	 nP/s5urUu7t7f9oV2ZSOt3X/thi5+VQLwbYE0mVVwecdduYiBPP0qcRU8CvlmodjlMFTc
	 5Xv5H7T7hwH1PWMi/blhSUm1dH5PIoSoAeK4YdCL3821lztXCakg2vP1YnMMina6epBdk
	 Gl2fPP2loMAsZkvfwkf6PJK+lF2BA6mB8DIwhdi4ceaHaWMNOAMF96t+gKj7cRWZGfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b="iKmPERb/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vYdVK8O4;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35998606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35998606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=iKmPERb/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vYdVK8O4
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B9B531D00120
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:20:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 07 Nov 2026 18:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093654; x=
	1794180054; bh=X7Xpn7hnGvOEa0muKNp5N4hSGDoSQEPwsZb4EX/tEeo=; b=i
	KmPERb/RNY+6cEDl32KF6EH5sbJMkhKb6TJ6mQfEQz0MSG3Sc5JLLW1/9SvgnFFT
	NFra21b0vSWxLukW8W/jbt5wmMDmnuEmspYSVTDeo7WjCIlpwVRqdCEpWgRFRy+y
	sOKwezWL2VCv/a8CVN2JPU7kHYdOOnVjav8hOyTNYeOdyzWAcch9LFEU4xbkmFk8
	ruuS6PFmmFPFxH3cM5pOJPsBK1BtVkpC6x41dxXMstAewa42HE69k1LUbcxqFJim
	h9VE8YYKFyc0arG9g7y72XaJAJnBf+emIb7vnB0u33zMTUhKwLweYJ5JBnyQuSpH
	6FVK/0aENTkGL+N7UFW1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093654; x=1794180054; bh=X
	7Xpn7hnGvOEa0muKNp5N4hSGDoSQEPwsZb4EX/tEeo=; b=vYdVK8O4nJhmzPEoY
	l/O58OV6Oydh3IQaPUjyZd7fPMOdlQ8RUXQBDETkhOcakR2Ful8Xr8Vskt89y7UJ
	VGW2TdmoFgQmpweWUT9S5dGUSW3iF1uIEBu3fHDwahHjPL9vKWvsKZNMdQiGS2rp
	PTnW+Yrc+6NKttW3ozbx5JpLUBbKy6EZrJBBjQfI7VifojFJiPcRKqHtVqf7iwbq
	5EQ2A9VK+AHlHhGhEpeCszuoBEExoQnrF1EImSnaK1UOZAke62JhfV0yaq/EAr+u
	PrR51Kj6nYjnXeCAQ/JrQxBQKX/Qh3oLtnARK1ZaepngxlS8EheOiFj2d9rPQ8NA
	yNL/Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093654; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:irMlxCtfgZSSMaSC6SU8+YEWypZ4gkiuWpxT1VZPofzSzYS
	TpN7p0zfNJU34mLpr404LmNUMKL/gifR0q0ISvOvop+WIqlOBafexZVnJiemDXMs
	+Qe7Q5FL+Wtz/TUngJiaOxSso6/pJ5vxUHuMoFkrunpjQFkdanuR0eaIiHKGVhM6
	6Pk6BCxNBHc6flSTPt7evdcORWirucWoOAz4/rjz2NakiLz7J7SZz3U6a93oXSE/
	+ph5pbrWUBUGSI4Mf1PICKSDNZnuYrTwUh1XkJPqR8KCu2nZXLi9OmcJwF+IMPHd
	iv0QWbnfHrASdvgOqZww8I9q1faXX7tiSGl+M0g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:g7N0n70kYOqVBLEs0Jz12SxWAOqD+jnEdVQagin24wM=:VBW8bhH4buInEz8/5CHuLtmiV3vAF9uQUnrQJGMVBno=;
X-ME-Sender: <xms:VrLvaroM40RgXManbpiqTG_WF3bzUNFyA_e1CuFIeTz2OIiLZMiwDg>
    <xme:VrLvatYKXkKhCjAAC8o8jB20PFZzR2HCVfMxpd4kOPN2fy4Dl_X1x-C3CMy6Dcw6C
    cEnoML9Pjr2hQP1Y_-ZCjFDc9h-822GBAH6bgOL3cvf3zM5MH6p8gYfyw>
X-ME-Received: <xmr:VrLvarRccLtwmVBM_rClKpG_HZmxTY5zf0Qyhtf2f6QElqdxnU5AODre5AxxqytaXztVJEk>
X-ME-Proxy-Cause: dmFkZTG4OKBtoL8ZCR/RILZ9HVIYsiyedYNwSoMK0fs3pjy1KoVI5QKNGkIR+qu2UJo0gZ
    HzA+zmsNEg69ZzY6X0FWa+zLkMFDxwNIsl9Ph4OTn+01QWTkR/Jo/5qW1rJ9nmoNurDIue
    QT+8hE5vQWriKMP4z24vPZOqUxClR8mW3s+b3sdgoVw/1pbgx+Rgr+CuyWm0Rw7VFfh3wm
    Ff/aXmVih5IN3xK3FyGhWQgzJM3srbjX1XKkRojmxjm98IEvfarefkGccvPNsccoj0M2Fw
    IAKskIg7qpYthFMz478vaSMrfqTxTgpU5kYVf4IOXxXEkR36tX+BOJ2DsnIOetXZBNvFm+
    eG0ZWU14VcO1cGHjMw9RnZqX3eLAU7Du+PVXsdP9whj2VpYtkAb4FhM6Htx65zVllFZtv8
    Ju5DVUJ5RbFRnKuPWUiky0lw7eR/hqe9YNW22sLKjp4R2RiCP2lUMxVPgY+wwdJo2rzgLV
    3NYjrd7TGxFzkwkOYl7Mfzzc5Pd5CzPxvBJpUyMUgXUTMrZx5WGBPf4p3fEQPcHLsq1aoD
    Qkt5eGN3VLz2PwRcEecW9qKaBDQwaVqV4H4fO0nzbn0EZk2v07U5c7miuNN29j6zbXKbGf
    BnEGB+l5YJWJSlOOzFgcIsrxIUL4j42lM/D/QtZwD0RBWjQjZqbC6qXHhnUw
X-ME-Proxy: <xmx:VrLvas6xolqKplhQ0JBZD5rQ83fJfRF9MgbZqbXgXa56LuXtACBTgw>
    <xmx:VrLvaozSv74bLZbpPbjsrVcUargH-0V2oppn92wwoEi9_HfDhZ8tQw>
    <xmx:VrLvajQuFXNGFi5sEnIYvYMzfN2tqkxsJ8rollOURgznp2mKDxHq2Q>
    <xmx:VrLvavVxYSUeQGJ6STVjsOvPEJ4FSUh6vNHm4kJxPiUyMSgNNM5muA>
    <xmx:VrLvamQsoWPhyPSu5U_dAzG2n-5XShiUO8DzI741NA7rxrU4SXDo71JV>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:20:54 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Jinwang Li <jinwang.li@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6.y 3/3] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Sat,  7 Nov 2026 18:20:00 -0500
Message-ID: <20261107232033.1872805-4-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107232033.1872805-1-oss@fourdim.xyz>
References: <20261107053519-failed-6.6-6320736af7dc@kernel.org>
 <20261107232033.1872805-1-oss@fourdim.xyz>
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
index 24e72a40e61a..070211b7a909 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4283,11 +4283,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

