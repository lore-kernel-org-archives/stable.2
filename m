Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032010;
	b=y2+28DzaLTs66E0hxTUfQdaSamrPnSek63EChMO7eJqp4gz4YNbIRzjQPPMj3J5RgNzv
	 NfGcUttvZ7fcJgqzy4thhJugRKpIWGGLrnRwDCsG/Auv2UEwAXgXo9MYl97sunFIwX0yD
	 J6PB79Im7dOXmYWc3uTOCqXMVY+0M5y4zn+iud5Prd+YJLjjP4lvlm8w1ixYeALju/UCl
	 nLkt5ukO2/we2Xk9q6bUXesQdHtb6/SYhX20+GpHTr7esbuYM/lT2k8SL3bZfz4SEGe0f
	 sTMyyF99I8ea9WOYuxlNEGVAk4iX48gV+1Ga9UrKEgf58Yx6SHWN8/oMvJxdqeAWiYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032010;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=9kcCIz8uI9hyAOMjyWYmAiZN2bIAPxSyBMWCQskBI00=;
	b=xvVyoK4w8XD1+leDylHURUFHDuSFS2QUCixRRr530lxQ65LTE4onGABdlbVSz8DBbeqD
	 PDs6qCRYxeG9QU3aWJHAKOVLEFSjURg3i0FtEoMixhBN0Fjd0rNLThIm5mPows98NzXhx
	 YQa2nnmN2Pod8eo8pYpgaeeUJCYLx9/AdyR4aOfGBV2VPVSS+RMxa1BcpDEAkA3wFMv4X
	 9aKPyWoKfrKL4d76DmFbdFoC5QnjFTAyzymbnUFAxHGPdxUniln3kGdmC9nXvngwKn8xg
	 KK5yAbD/IwcXbmdHqUB0xXa9jpDtqpiNAAJNOE0Ov+n4dbZbl+GISXa1spjZNPEL2ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=aaPSMivG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bAcjyt75;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D138606A322
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D138606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=aaPSMivG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bAcjyt75
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id D1668EC0AA9
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:26:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 26 Oct 2026 12:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1793032008; x=1793118408; bh=9k
	cCIz8uI9hyAOMjyWYmAiZN2bIAPxSyBMWCQskBI00=; b=aaPSMivGYACEEb8Ekw
	qxtKy/2GN9ui8F7N+pDowQGFYJ/ZavKpc3P5GsE0vFaEmtILuh7++TphBlY1zLrs
	FbFGkTw3F0Hoy/fpFzl/FjkQG8bILSivzS2bsACxuFswfytvXptIUKo79vJsi8+Q
	pjQ+IYa3RPO57AX2RqQdxzizTavmDaEuTc567OZWoEjzY60xnEdDgKRSDN2955en
	a6vNN6ymPDqwfg9Uq76MUEndgvycSuDGnemzJV/r421LxkALLGbewVDaAFRuVE1G
	zHZtLsS7EUUJsfKLUKH4t4jrDwXmaMet3i+ZV3cWqTGInRvgUzIYA6S1PMpFCMEB
	FxmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793032008; x=1793118408; bh=9kcCIz8uI9hyAOMjyWYmAiZN2bIA
	PxSyBMWCQskBI00=; b=bAcjyt75C0NuwonrobpMHm/kjym8IJM1G2DgNd2e+i69
	h1bsazquTL179tHqu70DlaCXPr+zQJGLApL2Z95HrsSc0crlyrrnD5cDtlwq0JCi
	rWkNGUCxoeXkXksdCbdP8B8rIGTpoXd6rT9nmwkm4yf1HC7XdP+S+aDU1p91g3bW
	fHrRiDwiazjTjt3/Q0Wuupg4+Q51ttM3mF2KEuqWp4zy5vtVNQvSAqd7Iyw13fXt
	tv/6CEyNkUzP1W0WD9uabw2vQ3/T1kNb1L2blkaAzGqWYoYKNqJH4gmDLW+orlfN
	B4uHwr920qv3o7SHU8+sDonDzyxabqgNYTIftZIsEw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793032008; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ogmQka2jZ513BVLlDm9Y/DdOQvFIwyxQyDMTmTlN5AC09re
	H0vKXeBltoPHOO7x6b+T7ax0dNBAnnxzc7yAnqP497ao+dtY3APdxd8FpUSJui90
	ZUC7L7SAPlnJnYkpg+CNqJa/Crq++yGRc4ICtDaYViWaie2/XzbJYjChJgdqDiVi
	ONTEare1mjANlov0KPMryJ4OU5Z8o8wPxET23n+VesYA5LKRIiNz2W6iQMbnh3ad
	RIV/N1v7EDGG9g1oCwZOIgBMrwa4vsuIMjaS785/rDpaWRK/yXNMrFeDI2B9i6hP
	YwTWDewxiz/I0PEWbcfGvIjM8XTqSvqU/R/ta3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:87NNGZy3Vpy8C/WB/14Kpyf/iHKlI13Ee1/MdgmeDBg=:bvGCad+8AQBYIHE2Cxb/6mTFm3UuOddA3aWXWZSBzJA=;
X-ME-Sender: <xms:SH_faunSw3SvD8664PPD52tVXbe8TwM-5I8JMKMjpPW9YrRLtwsd1A>
    <xme:SH_far2arPy0L3HKQGwN2jAqik8zZEy8IdiKZxiWt-LvjawZiua5M6uKgFuK-mEf3
    RMFOl5kF5zKGDDIRZ3IJz-IAhoy2c2uthyVMOYeSMioR3Gw3_YrDkRD>
X-ME-Received: <xmr:SH_fancZgMgG9vEHUPpvUcbmkBugj_iIqn-6nxWhQ3VhDHr4FiJVM440kNq538B5qG811gYDk2RwWC3xuub7xd1-Yr1A5YIAvw4>
X-ME-Proxy-Cause: dmFkZTG4APGyhz6R0v3h0o2cddQphOn9sEg7EFY/1upwb8ZMKMSqp0Z6UuPGn8mG825EqY
    WnsB5mDkkAll9x61kkVm7r10hFurkgmrhkeyfUPqoctgLK8SXbUPuLJrszMl5Xw2C1yRqM
    CCr7+zGG61uwG9E0/c6iLmCawCUhpY44K4U+7mAT/3R0b9umVrqZgN/ySk+FgD4z4uY+M2
    +cRY1iemNWIBZ0meZicq9ghPplaVlOH1VKIGPxpFmPUBHkDtDz2LKEOqbNDdaexcNP77HX
    9Rd2mM7tIJFZutjySyHpqIyadQ2MQ/Yd8Qj6+wCH3ZGGflxUZ9kaxLTKaeKAs66SgdIWt3
    MbtvhDbUJ+apWxPa3xwhKk6Mi1hhD+rl0wXpEaC8r6ZVvWo7tv8pbmiBo6PSkBekoEDOcv
    S+7zE9tlMj+eNfzo8tJpUMTh0/0/9QkCQKo5ZkB09QdYnIla/LkyR2hr3wnG/fULTlbqCH
    iyafmEy0/H4L1ix+u/9z5CHlTiKAOAXKr+0MVJGwL3N/0L6xM6glJg1a7/l4CZ9Xwhyt9k
    lQg9QEpjW50xxbf1IF3Cgn9WL1ITchyuf8YyeR9fT030GTKumKUquE4/f0246TmMkDoIDT
    HDi7P+WSHLaVAA0xl0XRv+3jHRCRhN7DCBcl3rdykgZ7obOTpHchUSCnkvEA
X-ME-Proxy: <xmx:SH_falbSkeOx1V9ox1Za7lJ2HMudu1kmjXtPwzvICKUsrOsj9h6x7g>
    <xmx:SH_fasGU0uyhmLgY6CSVOmfUW6rCXYKXHXjnjcRtcz_37R43YI2DcA>
    <xmx:SH_fajlCs-n5QFH0vqcOsqVGEdr-O3ec2jGuV5_z7arKt-U4OlKykA>
    <xmx:SH_faverrADpCVn5oZhpPYRiYlWYB4C5xFFeBiiyg68zhiOyWcelKA>
    <xmx:SH_falg_FW9gtguZGfX2L6q9YH9k6H-5JxZaLIAF7JbN8Yhj3X7c_r3x>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 12:26:47 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH 0/2] net: atlantic: AQC113: Fix regression on Apple silicon
 systems
Date: Mon, 26 Oct 2026 17:26:38 +0100
Message-Id: <20261026-net-atlantic-aq113-apple-l2-filter-slots-v1-0-d72e99b69583@jannau.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQoCMQwAv7LkbMC0dhG/Ih5CzWogdGtTFmHZv
 1s8zGEuMzu4NBWH27RDk01d1zKEThPkN5eXoD6HQziHmQZYpCN349I1I3+IInKtJmgBF7UuDd3
 W7jjHS0iUcop0hZGrTRb9/lf3x3H8AEhoGbV6AAAA
X-Change-ID: 20261026-net-atlantic-aq113-apple-l2-filter-slots-6342515c5318
To: Sukhdeep Singh <sukhdeeps@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=bvGCad+8AQBYIHE2Cxb/6mTFm3UuOddA3aWXWZSBzJA=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqz79a4dWrenbJm2qW3ZhGNuM/Zdi6hr/ci3yrJ5Bo9Z8
 1XWqbKWHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACayiZ/hn/XM+cVqF8689jaa
 zd/IrPupbqZOeU+n4eMzX0vWMvi2/GVkeKxlv/PlqrCb96bPVrtvvqjwCesuFkujz4lurwM1/ae
 J8gEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Hej,

commit 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter
slot, MAC address") broke data transmission on Apple silicon systems
with integrated AQC113.
A conflict about which L2 filter slots to use between hw_atl2 and
hw_atl_b0_hw_packet_filter_set() called through
hw_atl2_hw_packet_filter_set() is to blame for that.
The firmware on these AQC113 chips report `l2_filters_base_index = 9`
and `l2_filter_count = 29` while hw_atl_b0_hw_packet_filter_set() uses
hardcoded L2 filter slots starting at HW_ATL_B0_MAC_MIN (1).
A related issue is that the multicast address list might exceed the
number of available L2 filter slots potentially resulting in writing out
of bounds L2 filter slots.

The fixes in this series restores ethernet data transmission on an Apple
M1 Max Mac Studio and supercedes my previous "fix" in [1].

Link:
https://lore.kernel.org/r/20261024-net-atlantic-aq113-apple-regression-v1-1-b8305415a8b1@jannau.net [1]

Signed-off-by: Janne Grunau <j@jannau.net>
---
Janne Grunau (2):
      net: atlantic: AQC113: Fix hw_packet_filter_set for l2 filter base index > 0
      net: atlantic: AQC113: Limit multicast filters to avaiable slots

 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c | 14 +++++++++++---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h |  6 ++++--
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c  |  7 +++++--
 3 files changed, 20 insertions(+), 7 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261026-net-atlantic-aq113-apple-l2-filter-slots-6342515c5318

Best regards,
-- 
Janne Grunau <j@jannau.net>

