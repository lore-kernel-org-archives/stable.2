Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093645;
	b=PL0N3ov30pjzZbzLkJ47p87SgCqwsStYWDkEsXQFXkcbgTyMjOWG98VuOz21TEdGOsAs
	 eDRiBoFewDslnpZm4Di/D/QMdKQOMIx6ScI4/i/eW8kBXlZgIr0jx7BBNLWxQPm73Ud2M
	 GDNdehPdJrnHQQOuHM1fqv+jYEVNQj9EvZOxYGyvAcNKxOiEyw/KlGgwxfb5KpWDlHAUD
	 r2szNnqxt3+3D22nT9VLWryktRrUOs7bjISmW4R1WVNxIfcgY6lVXBVtdqk/J9bYXnY3J
	 DNtyrPp2j423qx6G3+CU4T6PdqAMJbQLG4v5Ln4YxL8zi19fbYaIB8O0KLHdy8QDpTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093645;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=+cdakr+F1mzSm4bS/WLe20BMKASqXRTwQOt7S6uFhas=;
	b=FHvQnbEepN2qX9f6JZF7loWLAIqGa+NuYwjJEfTQCVFK0jplK6mi7SqVTVcYvfObwR4v
	 +Uc7ar2QKLy7aNzNt9CqU/7+bPuoC5lAG7IsUYc7w8VcQKlCFQL0XTS9FRO1KZujWil6u
	 9rOG5eUDcUcg0ZCgA8UR2zJ4knx3CZOOP0wNGwQVHmlTUbP0fOYBBdTWOkiu7xMdXZeoh
	 9ANKSsQCLN2BkbppdcGsXYsEoO5OrD7dbXAvnKn00/GLxPRI7SzIEGbNRiS+M46o1+tVU
	 LjmVlkw7BLNIWwnCBt1Y9DmkyirvUYzZzUl4t9F0yQae8xGnwBTnz1bAt258cOu5EuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=hCNBF7At;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4ff+DHwr;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B139606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B139606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=hCNBF7At;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4ff+DHwr
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68B937A00C1
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:20:44 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 07 Nov 2026 18:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093644; x=
	1794180044; bh=+cdakr+F1mzSm4bS/WLe20BMKASqXRTwQOt7S6uFhas=; b=h
	CNBF7At1mZhFzFF90JNmqVM8zHex/Ldgk3YYpN5riRENh9/rGVzK5JBql/RQmc+o
	F7FJs5exkjtOSRP6U3pjaQO8zLLYaX8SJHZwqp7peJrKZ17hVQ7zJqrV+Z1hgivS
	ILj5uNf9Em5TG63S2mYHHfF1QUMUw78fXRrhaWydkHEZ2CQKc+/eiZEyeskrhHFP
	DcXykP5OQS9KsagKEwrX9SE2XXvUiMIcURZScFXD0PfjpkpES4oi5mHixkUFmedE
	ISACDsw/IyeIPVyMtEjCindu02ui1l7T0VaFSXIliMQ9yP2jHvUZ1yOfwMpANFRm
	hdHlrMe9m9fgDvJlAClmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794093644; x=1794180044; bh=+cdakr+F1mzSm4bS/WLe20BMKASq
	XRTwQOt7S6uFhas=; b=4ff+DHwrQkGP8MPQ805te6g9wsZWkr4OczsVPiObE/JN
	Fw52gjvapjkLk49uJg18XtDDY6nLb6+HFJIBRQUeWzdCI34OBww9AEdZGVrQ25Z+
	uW7/lXhuNTMq1p7TJzj74Zxdm8UZwyCaXgwlJWpKhNjeqpvNS0vJoEJfmO6DqTKP
	vja9yXSuExnU+15KX5cgOW2e7v6U7rZqOcsX1JaqZEynuSolZqhTjn11qJsaVb2m
	+dc25Gyj8p5Limi8bEjt2jtUqvFGRr2TFIltUlDvPiZJbJbTEiV5Isa22o5IhQh9
	y0eG1CH/IsawV1S6UrhrIdK1kL/O+vuHWBVMETlcJA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093644; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XVRPfuYtI9dOkyJkttGNswBcwCqWa5V1mUWiRsa956Xc7kR
	Oqa91qs6j42TyIUlcj6tPIbfybSnv1SxeKivUPomFpRuceA+1SxGwr4kBbQiLCVW
	xPIVFHsmibxvcsrq28cUsC2tzQkOHgRDJjUjdc8sC9cCZHxNeTBlfnDphMBaHaEI
	Z6I+c3b7piXX5BGYH0iFxWAubGe98t0sgCKxGMExALj5vsmOXIhLvyh1os26fBCx
	uuRGIO2VolkxOI7IdmIDUxstTf/3FBN42f9qdAbELw1ysX9YKLBHM9KUjyjaH+SC
	+sJ5lc4gF1GKYsLvyYfJCcVyLBcx/n8Qheh1fgQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RiaCIEfXvNTZgWDYVR0pAOa97woM90DlbtwseKogNx8=:2l0aQTztnPrlgH6s7Wrec1eTRbb7yzUrV/taFOJvolU=;
X-ME-Sender: <xms:TLLvamzwhUc-SncWhfX-ZlVynBp9IY47gX-0Ij-LgjAohQGfjBdBiA>
    <xme:TLLvapN6OLxplmQ74QyCIEuS4IEl5WKTtjwlyHN7J_5oKh3Z6ozARoE6GSu--RwoU
    bSnrZIcuqYPyy2KJrs69KSE8BkcbEGAdkptfkqBJ4HNWJhNAEjoB4lE>
X-ME-Received: <xmr:TLLvat-t0teCpnLV4Ab65dCZo8Q2yzWf1sRcdhCrdRFaDf2-rrj506s9yQMaP-0e3-GB4A4>
X-ME-Proxy-Cause: dmFkZTGhDHIMLR0JVx9rhRiRaCOwqOHlJ9oKwetM+uvnWYPQFIOv/ITWf8W9+1nOH2Mgax
    WBPLuHlVlIQabK9p3kpxRYmI1HHt+3bnXfA/0SmUcuYRWEUDv3lmA89gGxs0yjRdASR1aP
    wC+9Bg2R8YwXsLicqqAfW759EE7dvcdj0gNsmQxlabA1WlwWuDqukdsFXwx6/u7Lp46A1G
    zR3h6+gatF/v9ORc0oI0SxQ0jqprMfVOMLjNNG4EYoRWjpqeNN1+SH7kmq6bvwqTcqsVsG
    5Z3X/+quSkb3nwEJojtSdkYHdvlzfWWIcC/pD54JUIGqSQDJL4dLVhI1QE1Zb3Qsk4YFds
    PPsycMZnloloFJFD+rEbChMfexAwdMDOejGDaMEeJwR5YVlNZ4iP7Mpw9oG8clmoCyzK9b
    y9D2Zlv7JHnenmTXWzgf5nwTQl5SVPczDgdzuV3MAzDsJ868z7JhHe30ETjZhuilgcI3K4
    JJn/e6EED1+sla6we1GJ4oIoofEDHKz+MqnxcxX6+N8Kn+FjCnq/t6R4AU9o3H4hT7oIxT
    0UO95CJVDNBxSz8T/OazBzFG4GO/+5lvUzppY2NbZZmT1glJKz/LCV82l81XK8HhWFmDcx
    4NQEzXqf96/dVSU4E1phJMkZ65F4o0VgnpBpznT4IPiAFBZv7ZcQpxSHvVkg
X-ME-Proxy: <xmx:TLLvahrj80AIisVoQB1duJlT1DQEM7zbmpQ4tmF5qqJXSbykN0jimg>
    <xmx:TLLvan4D_k5S5oKq3zOJxarFo40cQliJQpXi6aEmHTNs3ulKe7RIww>
    <xmx:TLLvapOdHRf-NI-rztqxgA-30klDvoOh46rBNl5ZuZxj292yPFCXnw>
    <xmx:TLLvahMzsT9t8VBMxc1UdtsLW_6Ulm-9do7U_HibvG0C-3yrGHFJtw>
    <xmx:TLLvagwtb29yOpS9tVRAH4ABCpNTAyxJnQgd7kQLrsQaKZxmsd9HqHz2>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <stable@vger.kernel.org>; Sat, 7 Nov 2026 18:20:44 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Sat,  7 Nov 2026 18:19:57 -0500
Message-ID: <20261107232033.1872805-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107053519-failed-6.6-6320736af7dc@kernel.org>
References: <20261107053519-failed-6.6-6320736af7dc@kernel.org>
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

which failed to apply to the 6.6-stable tree:

  https://lore.kernel.org/stable/20261107053519-failed-6.6-6320736af7dc@kernel.org/
  https://lore.kernel.org/stable/20261107053521-failed-6.6-a518b9a9ef6e@kernel.org/

Patch 3 is a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection responses
with wrong ident"), which tightens the check added by patch 2 and only
applies on top of it.

The series goes on top of the three L2CAP patches already queued for
6.6.y:

  c1398cf11b31 ("Bluetooth: L2CAP: Reject mode changes on connected channels")
  c5ebb0245fe9 ("Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests")
  226fa3b676cb ("Bluetooth: L2CAP: Use default TxWindow for zero socket option")


Jinwang Li (1):
  Bluetooth: L2CAP: Ignore connection responses with wrong ident

Siwei Zhang (2):
  Bluetooth: L2CAP: Reject signalling responses in invalid states
  Bluetooth: L2CAP: Only accept connection responses to outstanding
    requests

 net/bluetooth/l2cap_core.c | 47 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

-- 
2.56.0

