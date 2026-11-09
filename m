Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189653;
	b=Jb/VJ6DPCW919130Xl0txKesg56vYHlIo7WKshrm0zZCnJx4eMVxO3NH5XK+Vh68FdXn
	 MwezdnRghqrnJtf2EeewnSB38SdaSLhCmwldp9cbx6pAJ0Zcnnb10tFT5J3LWi1/oeTAD
	 E4OFMav8yYd8pCyLLmzS75jhOyGXAYz+TFNRBomx79KJG5/6FOXI/o6lEnpwCZqdW7tvh
	 LuEqSX5uMvziQJ3MLgG/axNCk333uhlnk6g2RiCrC1gD5gC3/OM3uhZBVruQTOhVxHq5Z
	 w+P1XAGGj4qyUicwP5dE9va9cXWGV82s84uScTqTWr4985wXYJ28Ag0YSG+A+rRKevg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189653;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Adc9YRkyRGWYXnR2IjJ48aJlzHbtuLZbVRXD7o3S3Xc=;
	b=l33ro5n9k7GP81VPG9xbPtwtH//sVKihJn20px+Xdva9/Dtbt2Iw6m3zio7y6BmtTJdo
	 oTg4/usMVOfhOS/r86A4Pjliv7mbIddlxMK1jwFYU+bHbsICu4HHkiOYeBtMqJcd/4vMk
	 HtfVAEbUmjccDn3u15jHk6yAxCtOiUen4f0sFxmoE54iVH1WI9GKR2hgbiuADWcRAhyg5
	 Ixcv3QkU3spz4zYMXjje9/HgBT2WW7yLLRCflmPKXRn1KWX6EQeq2OeNYa5L99viIS0SS
	 C5wwSgamEWWcgIYX67Qsbk6vd6FAK6czEc3v2ttCkgy59YT6cWF1zJ2EpZvgqS5oMHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=fk375EJo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hvkIaaOb;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F993606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F993606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=fk375EJo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hvkIaaOb
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BD521EC0585
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:00:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 08 Nov 2026 21:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794189651; x=
	1794276051; bh=Adc9YRkyRGWYXnR2IjJ48aJlzHbtuLZbVRXD7o3S3Xc=; b=f
	k375EJoH8lPWObDBrcTBr/QMBDc8iDa4lV/hpVvHvlHL6JvqbNfX7Z4p/q8sXArh
	ecR+tCs9C5vfUVAdtolVETKk8tykds7thqMLkKRibNnW4dTVqIysWbqXp4P2otcA
	VEBo9YTyHnjmnW3m9EcUjU9rfmHQo/Cj26wgpYc9DUCS+29fZdTB7MrYtSAA1fbE
	N5yWpURa8quKl54FnqvneitqL1z2NGJccce34jQfyGNAxhSZWR0Vei690s5PjmvH
	Wodb458isv7LnCLfpZAaFzITvAru4jlObglIZtPxl2w7PvlQLYWqAniaU8CfBK1/
	f7OKcJajrKsvp5yevgO6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794189651; x=1794276051; bh=A
	dc9YRkyRGWYXnR2IjJ48aJlzHbtuLZbVRXD7o3S3Xc=; b=hvkIaaOb2rXkroOYF
	iSx99kjurwdoHsEleEQy8bJ1c2EvpNlp3q6b26A66IwQKZpAcMncOS6EKQmG4PDE
	WKFGV4FsT0RVf1QoJRfWVhfas9id0mcKDZSkV+hAbAIwwC4yiIRnZr1xHaAYSX/4
	ImXHDkL9OdGP4grI9wl9ngO4/nYz2u10fGaRBv12orindEwTEKIM3GLvhFCra9eE
	5dlxCwQ9+dwp6B0esVQN0L5QSNEf9/r5emcnpzjsRteXH2pYsTRljiJGt80lgzGL
	bjG/1L1j/+IYVxlRZDsJDJ7jfdJI0NmSL/HLHFqtsDiaqq6dI1QA3UBRcEQrSmOC
	HMTeg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794189651; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:elzPYvpLt2QOMajgoU59ED6N363C/hxO1cEX+UrkDRgjk6h
	Ys0M9TAGiPT3l8zX+yfL+WmEmaFF7Q/vfIyf6ej1aF8Riz8AAxLBN3q6syB3c4vP
	AckF6gSwPCSR/AjjqVRijZX4XY25sBtVkRPqKl6x7D20Z8dlJB95SIzFc85BKx6E
	rqUXtBEgfKymutSK9Fu5If+cztL9dx8bvQeLxOLZqexjMXUpSgnJMT0sppa+Ul01
	M3bj5qr5wk6K/w4a2p6e7WtRAk4DZGT3pD1RGaUmj5JFtyvZ6NrzuKqYf/Ja7ioZ
	hT7ZUfWw6W8Z1PjhzHmS8jht418n3GdSWhUgZlw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AeLPuFLWaeh1hjSeJituSeqvvBj6edp5DeyWRJQv1oA=:ixtyy/n/L69iaRV9RUqsw4ocXyjN94iJ0QAkLENWYC8=;
X-ME-Sender: <xms:UynxakyR5MISsjnIHsSec4HDVHpcEAHDTqGSpDBve-WP9QTqSeBT9w>
    <xme:UynxauTEfwhuDGuaKqVli_qSdhdz2szNp2cJL5olQdNssYICFcQnux8jp5nUh17SA
    eCqVs33HlKISFWYZYxWRhYDo2P2wQFRicPKR8EoclZ_cWiisNEL060>
X-ME-Received: <xmr:Uynxaj-jxNeG82fWkk__Oew9sn8he6ZbqTKq2PzGt_SmJseDFzNRoxHNBkVb8e1TBu_Jxto>
X-ME-Proxy-Cause: dmFkZTF1b+cjCy0SEnx2s8WnCdHzzK18WsFUDKOdszaPMZRd7IIANhU2Gbug44zb8NuZhm
    yzdHaQ200Gk+aH8iEPbMDS4Cjoxq7M7tTE4s/yxwTqi1rTKX/BWMV/chb8/N2lJTTa73YY
    cvAXvvgYwrgx+fuNcaeg3yFGJPqvF1ZohRfjWzqyOMYEUi3F//kTgLifpTe6NM2nUH2hrv
    uYRV2+ccOxPyaY02rWPU4/RsB6fIPzGkNOyH4+PdnIMpR+9p7pdYVv2fNo840fQl/98Dfv
    u3ZXHMR86xn+4Y76OzQ9iQ8PTK3CJlfhyFCivwhUAGJLp1VEqGoiifsgKXqjruxuVhWYVP
    uFf/G5C9kDPDC9y9cPF60K4oCqJYJi3W6S2xkxreNuvrOGIuN60AJ0dpI+aEr+/C8IEYxW
    6cpsq9tddQWG+8GAjqCHUoCmOl/nwz1wr8vLMqeBxSGBuByzk8ppmWlOWYVypc5HiFo3xO
    zMtTbOjaAZbZmOTkEquyobHkpikCspaamOteedu3Uu7nsOPAk5FgjW3fsp2jo6F4qpZd4e
    +iPtz72b4GaFe49h5ERpR4IlLDDGpjOoIArgrP1KYXQkq3un7DBG6LsPWNGdK1q9Bmxl3C
    icLNv5ltTHUHwfHfbq92CbDRASq/AE56THKMO4IQrmQY0hKF0JLcsRCzJhwA
X-ME-Proxy: <xmx:UynxatpkUtH8J9Q88zRSLDCxCqEn3SNc5j_T68UZ7wAUljsLkmRuPg>
    <xmx:UynxaolKbxW6aEEoD5i6Lsl9gkGnioi8rAlUGxsGE_ilpi26xjDJQg>
    <xmx:UynxasK9PT9rf5ACDekQyAhvvuR9rLWlCcSxFKVTunD2A0tgoO8Ymg>
    <xmx:UynxalzKMmynIv877J44UUw18rW0thCxN5NbhJAM6VORYZUNSzuatg>
    <xmx:UynxahRjkhZ4zlhcmXq3cfHynZIIIkVGCdUNvCLZBD7o5QZ8QUAAJF3B>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 21:00:51 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y v2 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Sun,  8 Nov 2026 20:59:25 -0500
Message-ID: <20261109020039.3035406-1-oss@fourdim.xyz>
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

Changes in v2:
- Patch 2: a2mp_discover_rsp() now pulls the payload of an unsolicited
  Discover Response before returning, so a2mp_chan_recv_cb() does not
  parse it as the next A2MP command header.
  https://lore.kernel.org/stable/2026-11-08-1-daily-reply-0004-l2cap-a2mp-5-10@kernel.org/

v1: https://lore.kernel.org/stable/20261108000617.1969616-1-oss@fourdim.xyz/

Jinwang Li (1):
  Bluetooth: L2CAP: Ignore connection responses with wrong ident

Siwei Zhang (2):
  Bluetooth: L2CAP: Reject signalling responses in invalid states
  Bluetooth: L2CAP: Only accept connection responses to outstanding
    requests

 include/net/bluetooth/l2cap.h |   2 +-
 net/bluetooth/a2mp.c          |  12 ++--
 net/bluetooth/a2mp.h          |   1 +
 net/bluetooth/l2cap_core.c    | 126 ++++++++++++++++++++++++++++++----
 4 files changed, 124 insertions(+), 17 deletions(-)

-- 
2.56.0

