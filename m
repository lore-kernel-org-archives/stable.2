Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434940;
	b=hAfPxuAewULixp1BCuTZHVVBbmngJtiX38TMOBGePEXgwbNPpw1ZAAemOJVs6aUhadXm
	 bG96Xr/761neXQniU7BsSb6QxZVRA6zhMGPJfLe/D4dQ7PgIUFk9ZWW1B56J08yuCcHbD
	 7OIrF/I/gYjmhfio8CFP3UHpdxEjtf4vtlpzL2yMBL69rC53lWPGN9YbcIMKp/tkSGg4A
	 wMfGidsldtSRJci26fuk5N9/81EfgfsJDXixdCKcJ17VOaOEeGcLRTDsOSfDH9pvM5J3d
	 KEO1/c7SVwOj4On7GUok/Z6we3EyLVABxla8Trfb5wC26C3ZtNl9g2/qlPKHHziSQPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434940;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=n5X5ssiQbRlaT/Jr99TKTdNdSf1iHuVQYTyjURDiA8Q=;
	b=xhr5ZdqsftkbeVM4QNFIiEREzXDi5ZDYSI4y8zHpRlvB/xb1BYmRaFAlgMnMbxSWL3xn
	 R7dhT2XkmN65RGe+UWJkPS0jbxkCn7uWddo/+RRkbPQswYKj2sqnA4ia6x5ODUIxSACVn
	 A+mmbt8nM8OHUrUOuUXvbkYoyGDyAgWPokfNRvA9lBKjj6/7Oqcga540yJI5s8lT3EO9D
	 TBM4GGVEEBi7t6EDcB0sRTyQEMOTjm/jmMSfoRwvdJwKaL7QbqgF+t3cwx5yPlF5JzB2x
	 VEaZotcyJ390m0lje23Jd+SaYqZ6m4jGqN+Jv7bTr0he/MyZDvvYjV1EqIWaKyrr7/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=RSroKA5D;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nrfMouBO;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD6606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69DD6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=RSroKA5D;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nrfMouBO
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B5D761D00181
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:08:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 17:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794434939; x=
	1794521339; bh=n5X5ssiQbRlaT/Jr99TKTdNdSf1iHuVQYTyjURDiA8Q=; b=R
	SroKA5D7Etf9Ekrho2SlGXbl79JH5kKG5T+9MDZBWwLJjm4IE7X735OpHkJ2h0Ho
	uJ98Odf+cqXHyqPufr5mXV6oWAcWBBjGRkcdtu4wpBUUvNw4hYdyq0/EdYxk+1tT
	54h3hRRGfRZWgdrbdh2UC5Taqpar1eJhEspZRkoiH43SoF/DYPXmqZFFc1JvIF7Z
	Z7Mo2bz92y1zQWLWLvzrGXm0r298R4jJNwRnpyNIKy9h9kpkzsVHQ8bpDuGXqIVm
	ce01MB2FGcDzlFlfiBT8nvFepBG3jM5DBQgfn7XKO3ZqEAzjaYFWrrHVNI6kr0nY
	PoJUp+qd+2F0cVVo8qlYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794434939; x=1794521339; bh=n
	5X5ssiQbRlaT/Jr99TKTdNdSf1iHuVQYTyjURDiA8Q=; b=nrfMouBOi7qVU3iTg
	N4hr+1v3Y+1C+oO8MZVwkMfI5y62p0+weSmHjD9yht0K2Q++M1V3pnR6j8atWG6O
	ynZjg7iJuMY0EkCAkllgLSwm4OrWgmLZanevcXGCZPVflsSLv5bt4Z2hiclCiE+N
	HnaWpVyFpIBcWEH3FMMP59YmbgCt4MquSdc7V7OFq+YMY2aSrLTbKOMUowBXrB8Y
	WLbnJt7XT8/SPIXXmbm+4mM5KhGNGw7qmsdJnCgACAxpi9a9lN48K1IjX1xn7P2s
	SMDLzOhsD9sARPyYe6eMGgHV8qqJ1WOvETvO5yBHaiNzkmCe11zGUIERvvbdGKVd
	7M73g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794434939; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Qx5cfbgxrDyDCJjaV3BiCeXQ2wMhTP+5m28zHy4bNi+qAVv
	4qi62VqOQYKHCTpILx9T31nJEwMDRw5LSYJfQUcrSefG4CAXefZ2IQh8KwFwc6Xn
	cUfiQqTftxpTVGGS0Q74+a2YJg6D2uJKDWQWfU6HDMNLbvRX0A3gqPzIZYvEUSmw
	KKqEA0Sfm8Gg+v7rGK7o8/3tBbJALAEutQAWrQ7Y4GsQAxa/jMvd6l1cUsBtmxkI
	q2k2CoakN3+GfRoKtroCbusT8iYwo33Us9mug7G1TTnlz+djTmst8Cdlen9mAdv3
	ZgTYnVqaeBYWB7qzLkvW8Z5k1lRi8rAy/13W6zQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:TL3pR8yPLZBA4xHytF2j9rIS5liUdzj9qTmqo4fDrgg=:YEUHq4V4yx+isqQpMq9MCqxR5z3Div0LPu2DL8n6b5U=;
X-ME-Sender: <xms:e-f0ahkg96rytnrmlX81O68Ec6YbISUeiQ2n1i056TLxkbhNU5lh6g>
    <xme:e-f0atAWZEup3HSKqsPUtfuTXnK9mK_vBqD13-pXyyvM15iuTTPL5Ed4tLdxsPEd_
    mjRIJdtGF1yYZJ646LGQ8wYK89NifFDTW116taLh7frgFBNUkPIVfnv>
X-ME-Received: <xmr:e-f0apfftpX2u8PdbhTR2itBcqWopnP_pTAsMZ7a-7kOYc4M2l9t4WObM-GD_NFuVyZhrO4>
X-ME-Proxy-Cause: dmFkZTEijvUOy5pjvmxPmfqPx9Fpjt4e0UrFH6WaW7CRlfYuyZxNmM3WEUBk/qgMqrN5gM
    vOynFiAr2CIW4EgWmJRvIWFajStHGruHWY92Z5tdci9MXse4PJoXvI0K6OfsNHCXn6NYxm
    HLRCAty6RiTwsPpgyT2kmi5AiAujM8P5DJuZVhttuHLQLUbgnO7e0DnoLIvSPPd1xcsIZL
    9RTgX58CUMbZpVlBhq8D3962Js+dGOJ5I7zyNqmj/xGSBxS6HxAfdI4mEpyWvxzn01YDqa
    nk5DoeuAwLh8dlJXs0Ea5i8Lqv5phtKFwN+371XAa3Zkb4GYYZ5NUrYrUNJYfAAAC9gpb0
    3yWS6jM8EHgj9JDsidohWEp7osQVjtH4epgHe3kKNZ3fWkmze6MTBPocwRf3SrOE9VGHyW
    X6KFraPJx9dilaNXxC/cjfuvVvP4N2T+o6KTubX+bA0US+kg1qB1O8dwJYvulDnGK3v/ep
    YrORZ0Hper50/P/g9H/pC3i4uH3uF0yX2ReW2hFTi+UCCIoQNj/aWmtJjBfiCGIdgh9ByW
    mW4jrCYaviYbsUGlZq492ylZeFt9nJCg9lgBguvPOS4rjWkCuhRVuAlYcHJg2T/rvLqlPv
    LHJ2Eauf7AcflJJrI/HeGa7i7qVuCle8FBLknC5IEN1NNgH8hBGTRIhYsNAQ
X-ME-Proxy: <xmx:e-f0agJbuQYdG9N4zJ1SvW9qz0uiFCqBC9GXuZ1iiBDBDQjRbpasqA>
    <xmx:e-f0akd3H6TI5yOedx1UjYmL8suNxWTnn0QRfvtgtyZzeqEjlFXe7g>
    <xmx:e-f0av1FmIlYA0FsCNi94rFZ6gCcWGoRWDwniXtA4oQKkUZnvHgBWA>
    <xmx:e-f0algSxQGrKeLfAp_w7rdf40B3bV5YaZEewX-m0HEiECWeQtFfCw>
    <xmx:e-f0asBeM-yLT3xUFeg_LOSxJHlu8ddMJHVVhX6JxBK8_ttxPsmkj4Ls>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 17:08:59 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y v4 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Wed, 11 Nov 2026 17:08:11 -0500
Message-ID: <20261111220851.3076201-1-oss@fourdim.xyz>
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
("Bluetooth: Remove BT_HS"). Patch 2 sets CONF_CONNECT_PEND in
l2cap_send_create_chan_req(), so the response to an AMP Create Channel
Request still passes the new check. Apart from that line, the patches
only carry the upstream changes, with context adjusted as described at
the top of each commit message.

Changes in v4:
- Patch 2: set CONF_CONNECT_PEND in l2cap_send_create_chan_req(), so
  the Create Channel Response is no longer dropped and an outgoing AMP
  channel does not hang in BT_CONNECT.
  https://lore.kernel.org/stable/2026-11-11-1-daily-reply-0024-b3f3824e55d7379b942d@kernel.org/

Changes in v3:
- Drop the AMP and A2MP changes from all three patches. They are not
  upstream and did not get the maintainer ack asked for in the v2
  review.
  https://lore.kernel.org/stable/2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org/

Changes in v2:
- Patch 2: a2mp_discover_rsp() now pulls the payload of an unsolicited
  Discover Response before returning, so a2mp_chan_recv_cb() does not
  parse it as the next A2MP command header. Dropped again in v3 with
  the other AMP changes.
  https://lore.kernel.org/stable/2026-11-08-1-daily-reply-0004-l2cap-a2mp-5-10@kernel.org/

v3: https://lore.kernel.org/stable/20261110191136.1748573-1-oss@fourdim.xyz/
v2: https://lore.kernel.org/stable/20261109020039.3035406-1-oss@fourdim.xyz/
v1: https://lore.kernel.org/stable/20261108000617.1969616-1-oss@fourdim.xyz/

Jinwang Li (1):
  Bluetooth: L2CAP: Ignore connection responses with wrong ident

Siwei Zhang (2):
  Bluetooth: L2CAP: Reject signalling responses in invalid states
  Bluetooth: L2CAP: Only accept connection responses to outstanding
    requests

 net/bluetooth/l2cap_core.c | 49 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

-- 
2.56.0

