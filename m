Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323344;
	b=m/RM1VvuN6kiTH6aJPToeSQ1jFne9p4e1bDfmr3V5qJeyDKUWaj4nL2eBuaw8Uj/vzJV
	 DY2tLQl4dqWYBXauNFYdVJXBnDd1V3TSUUufwyOQQaIqHPrYJmEpRcrbKTO+HOBKZUonL
	 rXwF7ULyR03vohGX/JR8T0MO1aJdwBXIUAmv/7MqTa5Wr58NHJzRbTw4aTs81HKC0NkYw
	 PYlXaS4ZkNuiAN0UU4p970kmpddSL2zN7kY+BWBKNR4BiDNAz+FZ4iIJVRymcWwdK7o8+
	 2po1lqnP+goAKT9hfOpLCJdirooR52hy539jc4hIAxZKSK+R3EjFW8AVYWEdfJ/gLHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323344;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=tPmTt0WU2o1nYWlwdFqyeJkX0bhZcQyilyXObznn64k=;
	b=zd1kKrcQX7f+pV/jkWm7Zb4L/SjXg7r1Zz6KsFSQC+GG+8DUbe/Zlb5NaP0d6dMAbFmG
	 B/+TCYRaL3Uo4sY2Fg7tp527g+2dPaa9FhZLJAiaHm4aTQDrxZD7ZaDuO33cfwSCzmbIL
	 opST2mGRtv4Fay/60w9oMYKQrRxPEwza//5sj2u+XPN8GGwRS+s0QT6gy9eVjqKJm5x0e
	 1LVdYrpD91t/RuS8CGwQadlFfhyLgXI9Zj2R0wUjwjLXZ7XPqyy6SAOLQEw6GN0QZpKyr
	 Xb8Qz2rzvptQLqNC723xSRCPSrEZoPVUwMUGWOxiYQH5wM4RPyJn4qK9MQvHfMAK/6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=temperror header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=eKac4iRT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=31JuktLA;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83660A2600
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF83660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=eKac4iRT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=31JuktLA
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED4E41400170
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:08:57 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 10:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794323337;
	 x=1794409737; bh=tPmTt0WU2o1nYWlwdFqyeJkX0bhZcQyilyXObznn64k=; b=
	eKac4iRTstPz0pLWL3ORPCZPelZdiQeLwtZDzRgGOPpTGPv1WzmKE8WMUe2zPabQ
	4qaEDwXASEiNBZ5PkhvpIknRHWiwcHcakqrjhNLwb0HRlGINMPKmWxBcXMi/c45R
	kyPpvy5f2E5/EXcBz/wtAvhyTMTgfowEjth/9m836ur7oML4X43//bRXdfqIEL21
	gO8MUXOPcCcNifZLVnUsfcq7GFI0fYbEenLSKArfr3xOe10vPh50XhW4HV2Z8yoJ
	eR9jmb+IhGHeUjODJO31aUhYzlU4BKCVWvHrSbwgSfoW0KcPrMfouNCYnNpN/F/r
	EcRMBzkBYUQ6DrbtFmM3Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794323337; x=
	1794409737; bh=tPmTt0WU2o1nYWlwdFqyeJkX0bhZcQyilyXObznn64k=; b=3
	1JuktLAdNUCP8cF28whFStojW5C7I+muQi2ZlKtWYm91og0sVvPIVXnMBtBTqU5W
	jEIXATVEfJsvyJm9R6TDN3lTwenVyaS5F8Xo0tmt0P4UqdjVOJmbFUbjgTcBx38i
	ZWZ8uhZasNRFa+w6iYusor6TewzsLE4hHWvxHrPHzvnVlmCTe22+bcRr+WWutg3j
	9Djy8wnff9Vfq7MAfudqlH9LsyYzBkxkKcTgeFETXMxVdwrgmjV6GHJFkjZCasGg
	pCDGyI1160DoFcQkXVZbM5mhm1X3FuSOMU3l6g0cR3HLlYP+WXCzwFBU4aWsrgyW
	tmvR9f4KhTlvcLCweuHnw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794323337; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rFkEDmKsGeBwOGfjBV2w1ArKPHfjKWTc8br3FunNfDVtkrT
	jCDWWlhNCLfVDM2NbXzaO6DZgAa29mPdJ3E5LYuQEYRwXWClzKL7KqwZ5L1Og9Dr
	oQXWRvww9Bp9QBFmipNr/pZURXxDomWbCG6J8CyOu5Dl37dIxfPUyKsvRRtiLxUV
	A8wJ2Z1VSAws5rMrKEBKO0KDpcOiZnbJceX9o5eUU0wWF8cGYXCxr1pFDXTc/MqX
	GSnWrmuRodHl7ucmw/T3KPGClkwb2Xp9xhmSv0iQa8iqI8uGu/7K71yvspLELZou
	bueBsVs7lZndpasmNoD5eBpYuim/hi8EjzohX9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+7WJ0626dh8Hn1nzGQk+mEQ+UiDt0pZ6wW+u2qjUYqA=:V2BOroXsBIamJEfpPzkHclj6DwYpFx5TBP6iUjVqd+Q=;
X-ME-Sender: <xms:iTPzanNSpMY5klqOziG28Lu6WjIThwa4XnHDfmVd2k6RH4WxwXNFzA>
    <xme:iTPzasxAnc2uYs9Ge46RHkNqbjEa_qlFp3ykCUtvKRSJKcj5l_tzBL753p541MzD5
    M6lBPjXbfXJ5vIFWc7Z4PIA_O301mCDicwwfLB_JlBUimBrg8k2dPY6>
X-ME-Proxy-Cause: dmFkZTFk1pexQypjrQfLV+J/jlcvJoDW7B7ZXwHUYgviRebFPYyMWbfukYAZk1WOfwpGt5
    dRLYMwuzWdrCy/aKkvcOjbHhz/r+9v/H/Tc9SOzITYulMFQkwsYW0BZfqU34wfyoabeItZ
    TNsZDPpNphtuMzSazPm56cRhJYoBFXDNNbFVEVSziSz2MeVcl7QCKqMUYo4m6MtxSX4LHf
    xnicY05eGfmmv2vKEEB3SlbQgNf5IFk0rjt5rBbiNyk3Xr+OvHjPEoCKu2vf/XZdS92hdD
    +ixwF5I8VDg/s6lIzrRtXvhtSwv27zlAM6aO8m0V/nsujM/z0wbqVQO+c4CY3SMr2ylkLA
    MwE9nTOGgNBfyfbJe+28phIM169eGmra0Glh5SaW5CqUhSJ4sY7TU6cl79RXqf3hQDLcXr
    TVkOmnrgiOVwooFw+nfDcdiytef0QAynwWMrOCgbwMmzagh5fr4psEPNM8PlqXv0z8AVj9
    t4v8AKCm+cL4lhgRI9MrmSlDb9+eXHTKUG5QGs+xdRHu171AlpC9DBlpj86FqT/3Uilzy/
    59Hh/wWfShR/hjAt+zsAE49eDa3rv8KhH/hZxZyLEH0ZxWwbFt3CNta/HBT5i2ilpdbJnj
    AsqyFPUWSXc7lxQXEqdbeGQEX7850gYFjzVlRVEX64hMkeWzvljD2T/oUjaA
X-ME-Proxy: <xmx:iTPzapVO3_X-WNbyDjfm_rYkWpiOJ_n80FWOEDJ9u5Y8akgaTP4svA>
    <xmx:iTPzalChoEancqVzmAGGFZVDxfO3m1NO06b5LFFs_420-lZDJsTOCg>
    <xmx:iTPzao6i_QDy1UhIWEOrLt1hcmB-cNG7LHkZ_PAqPpmMpp29TxN1xQ>
    <xmx:iTPzagyxHmZBUQ6g1zr08GGO-St2nd0YlNUCZDs1V_ao1eOuDVwzLw>
    <xmx:iTPzalb2gz2lwybhUEUhzcqVEDTd5OIp72R4aWtRCHqpxaNQD4zdIdaN>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9A20E216008A; Tue, 10 Nov 2026 10:08:57 -0500 (EST)
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
X-ThreadId: A27n4ETjY7Bw
Date: Tue, 10 Nov 2026 10:08:00 -0500
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Sasha Levin" <sashal@kernel.org>, stable@vger.kernel.org
Cc: "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org
Message-Id: <93c80552-6d35-44b4-bddf-b08f69800c13@app.fastmail.com>
In-Reply-To: <2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org>
References: <20261109015902.3034747-1-oss@fourdim.xyz>
 <2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org>
Subject: Re: [PATCH 5.15.y v2 0/3] Bluetooth: L2CAP: signalling response fixes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Nov 9, 2026, at 10:53 AM, Sasha Levin wrote:
>> Bluetooth: L2CAP: signalling response fixes
>
> Thanks for the v2. The 5.15 and 5.10 series add AMP/A2MP hunks that are not in
> 6320736af7dc ("Bluetooth: L2CAP: Reject signalling responses in invalid
> states"), a518b9a9ef6e ("Bluetooth: L2CAP: Only accept connection responses to
> outstanding requests") or a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection
> responses with wrong ident").
>
> Luiz, could you ack those AMP extras? I will queue both series once there is an
> ack.

CC linux-bluetooth for better visibility.

Original thread link:
https://lore.kernel.org/stable/2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org/

Patches for 5.15:
https://lore.kernel.org/stable/20261109015902.3034747-1-oss@fourdim.xyz/

Patches for 5.10:
https://lore.kernel.org/stable/20261109020039.3035406-1-oss@fourdim.xyz/

>
> -- 
> Thanks,
> Sasha

Best,
Siwei
