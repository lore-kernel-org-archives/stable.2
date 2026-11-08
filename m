Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096397;
	b=s1G9i7NHmMlkh6hrFw4VFgS5H2qQUyBro/8Pd75TJMSUPHjB6tzhwCB356E2CMX2AFHm
	 J0amZdOu0TosoTsXPfaSC/kvf0a2UnSDgy57/4hM8ZI5VJ+UXAoLVJb3beD/6htwpnYfI
	 qtFiL2N+W+YpI8EOMuv0zYbFetSdHuxksIoy5YdrxIvf/48wDB2BRHFLQrsFDeugNsY7A
	 d0s1Bw4d/yL7Ne7wBDVma57vR5biqEOyHMtoR6Bmcmdb7LQTKJTQccIuxu0gOcRfsivVz
	 n2YQpo0wi89OkGn0zX50+oqDRKqFpFtNbTdqKQOF3PqawmY7CagrdmylywVKzpfHIUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096397;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=ipVfwR4vynq2g4DUndod6MCd2i5m6U43xTAtycCWjpM=;
	b=B7RXSI9sV8nXFSeHSQUkUCuHNNPen8/lY9Tw0m2O0MI56rHis9OOWQDXCUgmQF0irUsP
	 4UnqJiJDWPo52t2J+po7GXchOrOmSSvOiE5szOs2C+L2KbjGoJ3WA23KWiiRfYARUohJi
	 B/nvDGkEwBpQHmjTV+UQRog4I1yJrlpyQAHmpFIeqvi3mpXEWpAG/cJeP+2sEcuBhioX1
	 S8PAqpV3AHyL6KLIGtI0CwTxBeTwdd/CNj1CgPFcGzEqazsUmO9fZ7zlPDvnuAFefapUB
	 Cj8wrOacQiU9NzNA0LHfNIfQ1otg1dj3PCE/hg8RKnnaF4nC5EJTJAY2FVGpy3fmLnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=CtDPzYeB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eYnVxc9Z;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F83606A32E
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 00:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F83606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=CtDPzYeB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eYnVxc9Z
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5DD6114000BA
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:06:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 07 Nov 2026 19:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794096396; x=
	1794182796; bh=ipVfwR4vynq2g4DUndod6MCd2i5m6U43xTAtycCWjpM=; b=C
	tDPzYeBEUi2Cm783EUQ65Vta2a4QSAkR+prw22mo4qZ0EsFmtrY+8P8sX0voyT/O
	mRyFEWzafyJtmmQLW3nBQRMwaXWIi9EFZj2x9KGO8Awku4LoL0qYZoNTlY6klgZi
	7d4EGOe+g4NHDLUf+P42rrMKX0vkPLY5iSFNW2g1s8cx2CHrcU2DROLgiHrLisYF
	yLN5QJwSb241gYWR5OiufQOse6yEv5OHfSY8z42tNhJhv9mEN+SvcegSHc03hqbW
	dzaUZRnr3v6/oEoKYvlRqdLpeHiYvJodZYc/xA0gXmIhGAt/aOi14mivsNlePjAV
	k5XyVdkjq431ZBIsXv/uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794096396; x=1794182796; bh=ipVfwR4vynq2g4DUndod6MCd2i5m
	6U43xTAtycCWjpM=; b=eYnVxc9ZpR73tqPlnboNo3xbjpcB/ptiulwuXIfFn05C
	wddBNzxUTaOgRSh0V/Kw1YI4jUPSKDJniHGug3m5KzGyyIbxQWC8p92U1yzm+ZuB
	uMBEyJTv6+I9IEb8SPiLncIlAEw5hqM6z3NVSYFJN9sFFzdd/spzSQ8PZ05RS58q
	c8f1tBvRtWyjsRgjfhLnfh9ISv9gq47Jk8n1SyLsKg6cA7rGoWTBFpqrgpR1Mpgo
	F3HuLEvuikWLTgvs626cVBOlH4GZB61Sx44jrzMMjiu799PghcqpRCcWWNR5J3du
	lxT5lNGGwP/KkvE1wWxqgLCEVF1Jgb97k1Uw9sOUyg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794096396; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bOyzyQ1sH0LyDjVSecA4w6a+AzGNkWTT9Os+OyLrcTrNLni
	ijudo91jYcNAqkkGwy9RH//7iaz73mSlR/LM0DLqElSX28/TA54D/LU981o26wPo
	SAaTfTT6lbEZhsnstq46ft7i2JdTHHVH+3GyMcMOhdKaCtgJbuPJtlv4bzwxJjMk
	XmNOBiXzGT/XY8pkHxjm9nrUyhcSoYFyesKQMpeB87fObFM5X624Ns3rahKkHu0Y
	V/p7E9lpoCygaoHs1rupQwduo0cnCk1ruhxVSWGCDYIVH3bFcxHPdLz2UT55cm6r
	zHgTK7YZwQ6ur4csgRC9mXDEAsYLGf+BcuY89wA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:F9G3hkMM/ZwQxX2UvulGiDO/VMS8jGJN8WZ+Nm+N5rQ=:wFOEtk+e8d6cZ1sy6ChS7Io+nk6Ur+ocvV1QuRjj2tw=;
X-ME-Sender: <xms:DL3vaoZqhXD0QVpFnVh05Nz6C4xZ2oFk-5tcLHMUl4mxM36tguA20g>
    <xme:DL3vaqXTqtTMU59bRZRVtPkBe2bHJlYwNBpEB3RcOQKHinQJdwfMtdN3Sxjl34TSP
    AmS_CCAnCfVbow8L84jSb-56a36Kt3-wznl_KoKhJAjmKCAO-U2WKQ7>
X-ME-Received: <xmr:DL3vaonGILUqXa6-PevqgKEE1zKP2Ji9JldhwpQoAdXRqpRWOO84Cqse68vQYz0OuGVkKVM>
X-ME-Proxy-Cause: dmFkZTFOcGF3t8qI5LoQ7zpRrFYHjwPiOWd5rD3d671qdJRf5H3BpXOaC+85WHEf2jUDPg
    kOv/kO7YLL6nkKTuRA3+s2tzAyJLLk73xhLwhVGL2K/g3+SQ3i6tdtd0qaZDKK50uFdkTR
    y9Db2ukEFNAoHyh/H+kmitRtxvqJYrtCzrU6gLdzktzqZzBEYxt5xqnI5nCBgQEMEUjIiU
    sp5O6CiZGpUmXBcqQ80seH4kOiM1nhvwxFBhFWBuy0Oya1xJx5muNhs9ssiiuhh3NTVxtX
    5BSrDG2tt0eoXQaot2sbG7p7Ckn+s3gG8sHVn3Ab+xcRe0UZPq5SOXJCmQtv17iKj5XUeK
    D5BMAKONqjXLsZ4tK3nT0ToQ0Vowox64fntkH5Kc9loTjzGu8tB/470Qs/XG8uVq3t0K54
    hT/dCWkl5K4MwJ0sv8gUGT29DaODaZeyu2niiDb/DAC/56K3tXV2iLE3n1oENrvWKjIFou
    RbBAOEWX/06GbcRpV3+zEd29Dj+nfWZnji0+sO2hgIdXR5bHDwFZgOKTglzb1E5nG+UkD/
    R+vwmPKzbu9MdfhO2BpNImh8Yg2FY5t28GXrzQnszJrMthVZ3HIyHm5F875lF418Cq1008
    gqh6FFd/ZYaIX8apuESPSmCq1pr/C/EM2F+hmKw4qbKKRk+H8FuJXa8toRPw
X-ME-Proxy: <xmx:DL3vanwfFc6cfHAqnNvLWHKK2yX5YCJ4fz6RNbsugY_ipAtM5kDT9Q>
    <xmx:DL3vajjFvOhTE3AuWyct2cCvz6vAR-ckHT5oKn08_JjM-oi6Eh_Rsw>
    <xmx:DL3vasU129JV-AWkMmLo3KuIulBIyOYWi3Fe4gOn8O23JuLlwI1HOg>
    <xmx:DL3val3sPzDeOosXAb0TyjyYte551nwen37fgGGWrYc68aJpjlQEUQ>
    <xmx:DL3vau5FwKP8bz8pewfQDIUlNyDwT6Nj9mWkpdBCIU5PdCrGqY7Xccnx>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <stable@vger.kernel.org>; Sat, 7 Nov 2026 19:06:36 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Sat,  7 Nov 2026 19:06:01 -0500
Message-ID: <20261108000617.1969616-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107062323-failed-5.10-6320736af7dc@kernel.org>
References: <20261107062323-failed-5.10-6320736af7dc@kernel.org>
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

which failed to apply to the 5.10-stable tree:

  https://lore.kernel.org/stable/20261107062323-failed-5.10-6320736af7dc@kernel.org/
  https://lore.kernel.org/stable/20261107062326-failed-5.10-a518b9a9ef6e@kernel.org/

Patch 3 is a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection responses
with wrong ident"), which tightens the check added by patch 2 and only
applies on top of it.

The series goes on top of the three L2CAP patches already queued for
5.10.y:

  c1398cf11b31 ("Bluetooth: L2CAP: Reject mode changes on connected channels")
  c5ebb0245fe9 ("Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests")
  226fa3b676cb ("Bluetooth: L2CAP: Use default TxWindow for zero socket option")

5.10.y still has AMP and A2MP, which upstream removed in e7b02296fb40
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

