Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434309;
	b=WnGwiH2nJUyhe8/zTXPh3oCh/Nkqe4n9qaa8dwfvMzLqPjsYkrv37+Nk2yG6HtuazBcI
	 qxcaojmkQswBvVUqyxeUikZgpB3LHxShmxTxKx0SH4NossxFNhFDEr8QnlVFttlQcgD6H
	 40rMwTKd7xF+p8J+aH/xqeDmwQOn3G/VYees0LZEtk1eo5YHzrlFSYbM9eLcWUrOwkiIw
	 yP7xMOFXm+/sVJFrgTYHjyxSl7LFNgogAB7jHgk5C6VZHreFe7I5I6l9e1JaSkLs/x+lb
	 yHq9t6FaQL+BZmibKpZAA3S0ZCgANxPBrnOYtN3DpwlQYM+IdXe4JT2M2vIe+7SbYFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434309;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=FuOPcmNAZYLQTQ/VWdjOXa/hovvtHmVGiiBKi6NmANM=;
	b=TcQ+Y5uoZVQaAD3yybDAPh9i6TkLpIUOMhMcG3gey5DF0uvKpb4IpPpYZaIm9vt56NSY
	 wqgVgEjgM32WIpHsj6qz+GuYEM17whpkuTdPN6TuOHy38Oe5JtSA1Y5WHkxeRdUGpzhiX
	 OXrAjlRWOfwH2gFA0IuFPyfhq9/AOweyDbAp/LMyiJBOYCJYsjywrFTwMvMcNg2r/C5Ao
	 jZWPsddLt28ZBg9qJqoLeMdrfk0uD2kiWaYRcobYSVumFvT1ZpXjX4+bRNqWhREoZa8cT
	 76jgBJouafFSKSvh6LgiboXGJ7UbNLzdWocODKK7frjR7JemG5gxhPxdP3m8RO813Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=FJ3RiTys;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fSuD1ZTW;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D1606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D8D1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=FJ3RiTys;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fSuD1ZTW
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 834C67A01DD
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:58:27 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 11 Nov 2026 16:58:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794434307;
	 x=1794520707; bh=FuOPcmNAZYLQTQ/VWdjOXa/hovvtHmVGiiBKi6NmANM=; b=
	FJ3RiTys+lpSU6Lw9obo7dXfueViMCSXIkK4nQmAH1YVtEKeUlkTTsN9gPtfkgSA
	CgPPiv0hRCXXp2Ffz1q74vbLLbPR1cibvc911X3yBxQ7zOSD9f/fEoWgKPxEx9LB
	5zXjKVClNG+lw/fP7Bw5RP/e2ZXmj1uU6LqOg9S2k7KiJJSSX9NmtTKJR8HNzJVF
	hmeReoislvfwE/Fq9kESuvlFFwh7Xj1ffbfsIaYqg1tPHnFO8fAvFJylYj8L1yrp
	M0tiPLN0VNWzxd7iSpDot8XojQp1mkRf7c6qYojtzxOT0wJ23Gxo+41j7Yr+4HUs
	7cp8tG058NcXFYKwOHsVow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794434307; x=
	1794520707; bh=FuOPcmNAZYLQTQ/VWdjOXa/hovvtHmVGiiBKi6NmANM=; b=f
	SuD1ZTWVPDvmrTsYdYiDKhLuj5RunDQk+u+7Sd+CeAO7XMQkxNqtrTMbWFGJf6Ae
	1kEh1S/QxX80fOB38LuJqAC5NN/Tv48oVW8OOwRqrfxoBULZBdPcJwx8Y3ruo9dc
	4O7Pbz/IZ/4eKOXa8qZ52jdyVBBH2jbJOpILGd2KyFuf6IOqPf0QNjh/kcWOEMcg
	fLqlK50WIhZfBOlw/A+wJUu2AZhvZuiSvsUh/KEko25awprdRQAJIh1tKJa973uW
	3XXDA51H6Yvi+eC+z4M122Wc2FJvntq0LzK6+BhcmfHRiWwDP+vU2isEEQaA0I3J
	pG8E9S/47qXub6D1EY2mg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794434307; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jkC2SnzB+42OGoP7e9IHRT8PBJ74piU+/VGSBh8dkYUFo0G
	vZHuGlgrz6yBcbaCQHIn63jMynvCsg53Qkim12UQ97Ur7SGCnfr11y1vG2igdjBZ
	G8K0J5zE6HgunUViWXutZSw7xgMJjSFAU9Y1VsqHzFvujJjiCSGFv4Yvb2G4E9OS
	p9RDjKokfic9rRXNGS3qtALgDUMVqJPp7Wz7pLlSPmVWq/nxiURwxxr4EpLIYjMl
	Y4+VVXQaMtNSylGwtnoX8jRm0O+yY3H4LEnrT8oeFVl48DJQHJg92gvf3pK4R1mL
	y0OiWq/hhcAFXC/0V57ich5F5E97PwWrbChVyAQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DS9WsKsuGdowSaZn7ggxrQJBD+pFd0PXl2EjVNFSGCQ=:rSVymuXehs0pjoi/kezVrKUMC5czqDBhXk1Zib+txnk=;
X-ME-Sender: <xms:AuX0auwS7q0ZeCTSiUYdb84bbKPHZWPC0p4u6KWqoaj5ICCNtvkhfA>
    <xme:AuX0alHqfOh_uGoChSAZrSY70ZXOZwz8j6yXIgWE9GZC8SIBFHnMJk33oNsQavrUY
    wjeHTANbmCjQruJLlS2dwFLCGfXcdiBTOqnOMBLP6W83P0fOOIxFQ8o>
X-ME-Proxy-Cause: dmFkZTG0lqHLbJ5VG9E+bamSeEU7p0a6JgIceuKa/L/C2+P65HHitQy/vT20+QSY7tHxfE
    DhGBnw9BFMRoqKIN/BzXZFWlOEPPe8YvXxXfXAGNCvPhVt1ioQafgEXO9nLI+hXYqSWRnD
    OrM7BNvHtquYrgdDeyWhM6s2lPfsGPqc1RUD2rw5wSCfaC5yaszRW+POxxzziJKvq6AU9R
    wH2wY7/3f6cL56EOf3eVBik8fTILPal344NE6OkPbdOLqiU1gfqeSGOsSv9jcZ47YW1Dub
    owsACWbUSQiVcCuvqTsnQlFTNBmjdK/QuV8Ja80D6mgUbs4i7h3AUorRY89I1lmDa1HMl6
    5mQAfFwyEBzjQgN7cmxWBvAQQehdyxg9StzluGGfD73XK4QanABgjJwwd1OL/kYbVYCBGq
    7fxgoMBLkfLxQXpike1KnJTH2pi8/lT6jUuJVtAKxmPsvDvupIr+BAnLSxrdOu9HxnJwgi
    gomD4p0Yq2cOznev1qBEnnyb0+BFW4bd+FrSks2xwRlamrDdTpOaACjT9gCjH2TmpdfZtD
    gq5d5v3Iai4xlAjSaAEyDVbpxdTN0j426xfkGgadjK80yRldToY1wJWRFuS9h652m1qtbU
    SItrac6MgWrY5cMx56w5rEW+cK3IrBIh7LTIPXoSzJD8zSKX3dlIQhlyOb+g
X-ME-Proxy: <xmx:AuX0auPD1g4o6IfChZcKBgzbrL17RrAmOxoYvMSWcFUdbeQTMQytpw>
    <xmx:AuX0akvdfZ0mw4EXc41KwdrVXtHNQMpChbiYGqn3SouLqsdqxdvYPg>
    <xmx:AuX0aoUW7pha7YvCNNWS5BycqrwEUJA1WsKg8eD9f3F5l8_QwUD8jQ>
    <xmx:AuX0asuVyCj1AFMo2xC7dQ_VBAyYFUuqzksutmhSDt2CGfMSZDsRdA>
    <xmx:A-X0aifeo2eoEgYyffFxkVWrWpBIGtrxaZFc4oY8Ps8SrRHHto3iBtX->
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DDC67216008A; Wed, 11 Nov 2026 16:58:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AoMJwJ6OSIYV
Date: Wed, 11 Nov 2026 16:57:59 -0500
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Sasha Levin" <sashal@kernel.org>, stable@vger.kernel.org
Cc: "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>
Message-Id: <ad33ead2-1363-45f3-a8d3-2e7816b515fe@app.fastmail.com>
In-Reply-To: <2026-11-11-1-daily-reply-0024-b3f3824e55d7379b942d@kernel.org>
References: <20261110191136.1748573-3-oss@fourdim.xyz>
 <2026-11-11-1-daily-reply-0024-b3f3824e55d7379b942d@kernel.org>
Subject: Re: [PATCH 5.10.y v3 2/3] Bluetooth: L2CAP: Only accept connection responses
 to outstanding requests
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 11, 2026, at 4:54 PM, Sasha Levin wrote:
>> [PATCH 5.10.y v3 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
> This breaks outgoing AMP channel setup on 5.10. AMP is still present here and
> l2cap_send_create_chan_req() never sets CONF_CONNECT_PEND, so the new
> l2cap_chan_connect_pending() check drops the Create Channel Response and the
> channel hangs in BT_CONNECT. The check comes from a518b9a9ef6e ("Bluetooth:
> L2CAP: Only accept connection responses to outstanding requests").
>
> Could you add set_bit(CONF_CONNECT_PEND, &chan->conf_state) in
> l2cap_send_create_chan_req() and send a v4? Patches 1/3 and 3/3 look fine.
>

Will do. That issue exists in 6.1 and 6.6 also.
Do you want backports for those also?

> -- 
> Thanks,
> Sasha

Best,
Siwei
