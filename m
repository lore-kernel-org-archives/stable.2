Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096359;
	b=Cjcq+/WLHWq0c/gBsnFwiyYat0bXAasMhnS/94BJnJZ8ajEN40lcxPPHIifyMZrSPPVA
	 Yr0YGAZ+qelRoJYPNw7XWnwhxKgnOK1jMD3D3dFKBBE1JvQgGO5L9Q2YF4hk2oqrf+fB8
	 rN5yPrkLXv74WmIlp/iq+Qw9+v7zY8dxhxbh6PnzPP42/DRU4xSTXZTLyEO/Na5OYdQxr
	 LLoE1U9QCgiha5JrIuwGcGIFqXrq0cblpByTEbmC2QKW1hB/hB5wkYDOHbbmiC7sZhvzB
	 vxtCDMMCbYsOVmwNCvylpD3AVHWNv+iWtSFnWpxnZI6vjJbhX2Xq+v2TEsRQKyt8LMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096359;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=/Fb2Aib73y2boaGOALmC0NYFXeWJNko9y2pFB+cDW/U=;
	b=m7hjxti1i2Zn+8Z8T3MfS3FDDs/O59r+LMq3HxFKt6U2MZtkGmq+JHSDCAJiSyc8QPi8
	 n4Qarm82LRXvbd3g2CQTCVnph5NbSXnDgIDkVkl+N6sKrBZPjuXTUYgs7WK3UyMnVwoYg
	 7BwSQ2w5tlG14MdvmzCZNfUh/cCxc7Wb+/V5DddI3qgxk+tkwuNV/nnMl6KJ0MwXIuo9J
	 mK0wD9zVqjrgP6FTOxeByvGngN+mOpJoTVioE9RfFwsTfAv5ml9EYkvhinA66GLdapNbz
	 D86IwkZqoUKnFN/vOQapVtENCCU2rtA/s3LapJu/IvAh2nwxmdRctHulThGfTv5xq2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=nLnx2yS0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kSWAdCn9;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E2606A326
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 00:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E6E2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=nLnx2yS0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kSWAdCn9
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 92063EC001F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:05:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 07 Nov 2026 19:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794096357; x=
	1794182757; bh=/Fb2Aib73y2boaGOALmC0NYFXeWJNko9y2pFB+cDW/U=; b=n
	Lnx2yS0TdeN+F1cCuId60ztaum74Ut9/AfBj13KynVflpij/QAqMgR7jrpis41Hb
	2ifk9D79SBl1yRHLP129piIBzpqrN2GjSTr/o5uMf9lIEmSpM8nH7YtWye+XsEUW
	Jxpgv8nyjAV/uMd8vz9uOSTmvwlcENJUrt/SOGonr1e7LzW4OS/+yeXE9N2JyWZf
	eNXzdlOtubpTcRhAuoswUIo35L/I7+J1ruQKPqs5u1pat4xxCd9bRaeuvVk6UQJh
	lEJ8yNorJ3YRkCDkhlVpLRMptAPUUjZcoWIfMJffzk4deyKrX+5WKhHxkZnqb9+x
	vK4TnW2VmUMWlfR+azbfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794096357; x=1794182757; bh=/Fb2Aib73y2boaGOALmC0NYFXeWJ
	Nko9y2pFB+cDW/U=; b=kSWAdCn991izWVRiA/Mvj9lmH4OfZ81kvDTaaU2lzaoG
	kmnCzaNhNZvPcVIoFltcL4jm4xNDkJ0nqLr4At7RTAT1Wz3KgVY9vHgntZv41j6Z
	CSruYBpYvYu/M/3dk+OZXyK4nMA84/sHsaRJKaX5j3RRWoFOVMiP5wsld3ZgWzJo
	NXvjABGjeoN0xvj7wF49DDxjkBTmG5hFTIQIwZ18oWerUh+B8AsYRYlCTdj3cVdd
	mSZToUL3I2uPrk0iipDnycFxe0jeVxnEs/4Xoqmo5mgBBIEG8vujJ/G+m4ynE7ED
	/Wr0YeFo8sTfyOVeHeQitV2v+sLZfY8Mm8QOHiwjvw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794096357; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DY3rcqJO9xBN3kvdIOwpszcqBiTO+KbjIgyLDdhbDZOxpZP
	a5CTgg8Hr/GvIo7yLsZV4vCXL9cetbS+adN716t3oGiuH/nv55mkBvSAkLdqoEvs
	5L71X/ssK3a5uETLDFweKfRRJZ9XSuNYdNrwNsQAjIm8FJYIBh1+Y9FjUKCGPTEA
	oXIX+WdFPRSImkO7EIFd9Z32hL7gjZfoykYtkEKDa2B2JOYCniD2NvqIiNoGyBFP
	Wo+g8od58hu9fTwjR0VXLwW4Dvb9DnGbBhhei5wzFn1TD0YTmxOS3eMzvXaHKSQ4
	k1xV8V2eoCe2jFM8v5t//4YdLl9QCMj2PZYfNqA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QIo5JzHbje6rrk8iK3y1nJoEqNu+K6oe3yVBS/cMSM8=:ignA+FHKW3ZcVOse1HGAiZIIx1psVh7t+XZDuIIJGGs=;
X-ME-Sender: <xms:5bzvaga2uv5WBjsu9I8fzj28sTYVjCBKSs2OPZfTLwEQc3GEpWf7uw>
    <xme:5bzvaiX5MN3Y1wXQc3mJIYKBbIiTTa6cE0mHlEm2v5qUZhC5fwXOoXAeSsc1cGhmb
    5ODqlecVzlLPClDEOFqlAsga5hXUGLtbxRGeTv2xasRFwjhJCqa2mxB>
X-ME-Received: <xmr:5bzvagm-720djZFeDcxThoOtpiE78gwb7o9ooFyeNNP-59_c_iyH4E0HM2hcFWn2Q2A84G8>
X-ME-Proxy-Cause: dmFkZTFk/qSI50kWB+yYDutcyhyfibE4jU3dMwqVrofPFIjxsXnaALnwKz5afRHfgq4LMx
    98O6ftD5kF3x5Tgc3pNNgSeTT75IGYffPyQoUvFMT0q/Rcb/IQgAjxVB8g4Hb4zQdmMuCl
    I3f1wxp/24M8p7T3v5Zh3lE0tqCChVNnHCCqCWFszKm7tDCjRiwA1KzHLw3EXJQamzBkQa
    q7G0uxQXZEmhCsDHw+vdySYxEvy1FWv3rnKMtoxpddfxVPUOX8ApB3fTPeKuwed8BN0JDu
    vEYZWjTWWnlZgwhStFDIC0X28nMciiPshOUWgIPIwE1LAEDYDuN/YPS82i06aVjTG2uVH4
    stjx+Yo4A6qOpVdWdr/aCRVKvUE+t8Sa8D4W9NRsi9lO9Ii3bzohGtR1uetxKXOfnuBrxU
    Wt49aIfUdoEPcSX5g1E38uRx0X0bTEDaXUzInUyPX37BTdwhs+3eX4vlPJ1wbWKfnVuFEr
    pWqOnOZxNsJyOZi+Kdws9ncKI9ZDHZWmycOEztgBGJO6vMZC+RjBb52Sq7TpWWXKEGVTQU
    PHsfrP5uGJ5xV0ZaeBv8mP9KT7Ui5ZWNfR054mWTwULHhK/8LqrliRDeyiWbljlAfNQv1l
    C3ar64naO8lWG80gAQrEurfwh2mBb84ziQybZhlRHzEvKn4jF0sDI7HQw72Q
X-ME-Proxy: <xmx:5bzvavyAkZrKdveQRUwyNYPUVfq-PjZOoYfNCCjmXInt00x7CqrpqA>
    <xmx:5bzvarhIS5tPViHSy2beqRZPgazuqixBmJutRcHdYGSF0ilHDm_P4A>
    <xmx:5bzvakUzrh36EG8YEnPsRgByPqaSFqhFwRWNFvSAVw0MXPx2RSqAtg>
    <xmx:5bzvat3b1k0guvymp54xD1XAQEdvSwwh87t7nO8e_R3V4gPLr6dk6Q>
    <xmx:5bzvam4HGLZbUSr7ugfV7obHTRs0x_ftgXlV5F2LZg9AOtEJ7eOcngfI>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <stable@vger.kernel.org>; Sat, 7 Nov 2026 19:05:57 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Sat,  7 Nov 2026 19:05:26 -0500
Message-ID: <20261108000542.1969015-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107060628-failed-5.15-6320736af7dc@kernel.org>
References: <20261107060628-failed-5.15-6320736af7dc@kernel.org>
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

Backports of

  6320736af7dc ("Bluetooth: L2CAP: Reject signalling responses in invalid states")
  a518b9a9ef6e ("Bluetooth: L2CAP: Only accept connection responses to outstanding requests")

which failed to apply to the 5.15-stable tree:

  https://lore.kernel.org/stable/20261107060628-failed-5.15-6320736af7dc@kernel.org/
  https://lore.kernel.org/stable/20261107060634-failed-5.15-a518b9a9ef6e@kernel.org/

Patch 3 is a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection responses
with wrong ident"), which tightens the check added by patch 2 and only
applies on top of it.

The series goes on top of the three L2CAP patches already queued for
5.15.y:

  c1398cf11b31 ("Bluetooth: L2CAP: Reject mode changes on connected channels")
  c5ebb0245fe9 ("Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests")
  226fa3b676cb ("Bluetooth: L2CAP: Use default TxWindow for zero socket option")

5.15.y still has AMP and A2MP, which upstream removed in e7b02296fb40
("Bluetooth: Remove BT_HS"). Patches 1 to 3 also close the same holes
in the AMP paths; the changes are described at the top of each commit
message.

Jinwang Li (1):
  Bluetooth: L2CAP: Ignore connection responses with wrong ident

Siwei Zhang (2):
  Bluetooth: L2CAP: Reject signalling responses in invalid states
  Bluetooth: L2CAP: Only accept connection responses to outstanding
    requests

 include/net/bluetooth/l2cap.h |   2 +-
 net/bluetooth/a2mp.c          |  10 +--
 net/bluetooth/a2mp.h          |   1 +
 net/bluetooth/l2cap_core.c    | 126 ++++++++++++++++++++++++++++++----
 4 files changed, 122 insertions(+), 17 deletions(-)

-- 
2.56.0

