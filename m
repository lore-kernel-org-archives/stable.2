Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189858;
	b=1jZYnhRWni8WK6qIbojoHgRrA7+T7NjgblXD4n9guoT5BktbE3ApFJa2p1cqOmVI4Ce9
	 FTj0ZZsoaoJfIPvaG3Wy3OKGPJX9sDpv7q0KOUNnd4KbA4nioex2aUKFOGg4um/JglIGM
	 aukusnCBUb2DaLzoPN7OfFFNh+IsaQ48c+39TL8yKXzMI9k9Ni0yinK1GqwZfLGYjYph0
	 HRw7hv0hzHbOP2gKxnrXbBRWRbMgtzM4jEp5/TeYwbOh5Kh5DlD9fEKMoUdLfJTyaEvj4
	 ArtoK7KHBjkuAauyDlz8jQTWscUySFZeEbyAu3zvMmJym5cWldMLAcCKxYHW9sVzWcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189858;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=j1NticOzxpK319oflwa9wXgrf+2CQg57v4w6myH7VoA=;
	b=cMYnFD/bkJ+b4ZLaVhmanPb18BQbNpgN9uRDt9SJFm4+JICWPFS25Ad82f9Km8WW7Ny1
	 kOJmt5VxdZEh8quJP+eJ6P5EXlyBgJrv2OXm5bPwc4gfgQNi0wrOsAsVvC4k7uAknuh93
	 wo4e7iATQPVwE6Y7y7LrxZEkN+G+7g6k0guihha1OoRC8r6R/6E5JroSccifxzNl5W06r
	 oEUEYBEfJOnqKATjGLoEoU1Zkeotrb1P6M9871sgy7SXw8m55bm3AsLOQKpCE1cPFAjZ0
	 P2IB+jaWb6PDyOAgEI/9k7UylzNKbNryfnSrA1WmQWw0xo73Tx8i5a4aOQEh4LUsxng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=apL3jgVw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sfaeVTMQ;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7996606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7996606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=apL3jgVw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sfaeVTMQ
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA889140005A
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:04:16 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Sun, 08 Nov 2026 21:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794189856;
	 x=1794276256; bh=j1NticOzxpK319oflwa9wXgrf+2CQg57v4w6myH7VoA=; b=
	apL3jgVwZNmtHbO5Z6/x2sn7kikCzb+gu4BhOQhJ+NPPc28AmPca7dM+yb02R9jX
	/rquiTGKxTntT09Xrw9yQmxEWGJhUxgefN/RBTa6Io9RGICE1XLWgSpOg1m8EwU3
	oHB+d+5TszcMjaSLjeRmcYCYXo/u1xHYNUhTTSHwx1G32jE6t+pnlegSyuQPJ+4+
	Hb8l+s9PDN4U35pArKqeqehCx3jgbDhWbWWIYjCM2v9864CEh2ZxQHM4M9wlGism
	5BEvu95eD1KtgkDuXpd0Cjtc8pKLFBAwJ1JLScmE5zSf3vm5CcgAntQ0RBXHmfrT
	hMoVsyRN0vHZZMoXYg0Y1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794189856; x=
	1794276256; bh=j1NticOzxpK319oflwa9wXgrf+2CQg57v4w6myH7VoA=; b=s
	faeVTMQoC3qogKIM7iPp/MeX0bCg8aFiIOsIWzL60VybLfAcWBuzbc0MXNn1Kzqm
	J8S+rZJSBOdtJfETnCyTEzhELVBdG+Hc8R5xWemBW4l6FUnGBFxKOynVwiMjDHl5
	6fb/jsCAc6nv/HbR16H1ftfHM+LxJTWZh3GxnD6J5SzV2X9FXVxEaPK+BB29Fly9
	CcfkDy7htkWEwVApkX6txCVPzeOOkJdF8L5kOn3L9GND/ekJaF8d7cBCB4QchBYR
	uQPx1bDpsvMtwkbu/oDOZRuKJjXSQZzlN/YbEGlRTTkwYqiwv5U8DyNQfB/HBW4h
	HGYrgMLn74g9nUh8OlqjQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794189856; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FKSQTCwS2SJtLv14VMyoVR8XWog+cMB7Rl6p83xKFbBplVt
	5nfec+U1S0u8qUMPDiWzkRsqsnIdlxcLVoMuE0F9c8E5wbm7T43aXSU2R7F8XbqK
	GVYhoEADZQ28Ce3a+zwjsnQGv5Efjrdqi8tF/IIsTJphCa79JkQJOrOBIbBgKpG0
	way1FW7+TDNoE2jY2NvXZ43r7EazTbxHXMss8MkYUzj3/DtA9D3gwKclq5lRzlRS
	AVTD5wiZhDeN+wZcZZX2eN/jVpcO3IN2qcn73ShtAOC34OIla3K48LMNcPsUXA/7
	QWgRwsQd/pHQ4bFnFOEpVihTOHfsFIh8kr85bqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DrpaJNHSj4niP2UJ91PgyqSnPFAvDJ9iyZdAP6amVW0=:hbI1IUURyvOtYu6tMCIvg+nS0jaJHa9GQRLgTLp8LyU=;
X-ME-Sender: <xms:ICrxakf1HX2hKsEBqJ-eC7mQZNHFFDFDikYHt8FEiqtO4DKU0dlc5A>
    <xme:ICrxahANIrsweN2-uAPAcgCQznStkAmWy1CYscpRxp1b3zaWPDLKusrIi8btJmkcI
    UVs6tjz_T0BxfBWPoCZ9IjibP3njO6419GO0i_1VFDvnS9c_7hH8T0>
X-ME-Proxy-Cause: dmFkZTFv8Pp2TnF8HsrhB4CjOwzmdeDWuemfdvDg4EziSpnqLdV9vGIprqVfhE8oDMqm7r
    OwflwK4i6Owpy76jxQcyfmtPTeM2/3MGPsjyeZHWwpjRHgD7dj1yTAxnQgE8rkq5z91tHN
    o/QZ5jZ9mnq1uEy9RBRhxqEMWpFbLCts9Gj/Uq/+3jt3eO+hZ1JuZRdbFNl78HqxhGf6hu
    7ZEevFU3boZ/tnNWAE7t9Rey0ucw8bS9V2Fy9R9SQzb2gXO/XSusobCj+Wybx9WnPdZZoT
    L7X1Ndv4y0hqTyAKAstwtUtGFQxPbH2DMULYcheei4pJSgJ3tr+AE7HW36odah6zHrpceN
    qqVbUZybeORofbf9TAeuiRnqjNBwjJMuS9RPZPlAFUlQrLkN3xy86MnHQ3QU69ppImKV9J
    sarZpMQomqNPnpwHAyELUpOoc4uIno9atix03CFVT284uX6V/5LXCjMZBF6YLPY6DjvNK9
    SbpnJobFZswt4/6KBqDWx8Ixkq/GEPsMN3H3yj555ZkROmwKYp/uYdHcc45wSbwjbv8vvt
    B2B3HW43FKV6y/3NxUcW4BVUXAAT4/sn6qUVTgeW/oWBnW/EHziAVxI1ie1hFT1W9Lb/Rs
    HZSOxQfIL/A7Wthf3F+YpcDvLbE2f5+OrieAvCQC4NkMWtmTqRhRwJJnIa9A
X-ME-Proxy: <xmx:ICrxaiYyU5wSBA1SYxrU71AHIq2yRpkQzZdNMY3p_hjaUiwpM8QvSw>
    <xmx:ICrxatIBTWYBk38k8VireEW1QmQ1a2ye_IuSW_jkWl5bmHK_yuOQ3A>
    <xmx:ICrxagDuZfLhNkT5gjYZpI4pRhfR8jhp61zYQYzKKVuoxuScPdgbfQ>
    <xmx:ICrxairXyzu7wl0-j_fyfWqLKFxXe2sQI33RwA8-MKje0IULj13RKw>
    <xmx:ICrxanpOqB7Kv20232bSvPcwsosk-piMEQ6ii870R63S8XLBn7RxaiRD>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B895C216008A; Sun,  8 Nov 2026 21:04:16 -0500 (EST)
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
X-ThreadId: AQv5gA-9FD3B
Date: Sun, 08 Nov 2026 21:03:50 -0500
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Sasha Levin" <sashal@kernel.org>, stable@vger.kernel.org
Cc: "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>
Message-Id: <48cdba4a-ad83-4aa7-8df6-5b0394a67ca2@app.fastmail.com>
In-Reply-To: <2026-11-08-1-daily-reply-0003-l2cap-a2mp-5-15@kernel.org>
References: <20261108000542.1969015-3-oss@fourdim.xyz>
 <2026-11-08-1-daily-reply-0003-l2cap-a2mp-5-15@kernel.org>
Subject: Re: [PATCH 5.15.y 2/3] Bluetooth: L2CAP: Only accept connection responses to
 outstanding requests
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, Nov 8, 2026, at 7:34 PM, Sasha Levin wrote:
>> +	/* Only handle the response to our own Discover Request */
>> +	if (!test_and_clear_bit(DISCOVER_REQ_SENT, &mgr->state))
>> +		return 0;
>> +
>
> This early return skips the skb_pull(skb, le16_to_cpu(hdr->len)) that every
> other A2MP handler does. a2mp_chan_recv_cb() loops while skb->len >=
> sizeof(hdr), so the payload of an unsolicited Discover Response gets parsed as
> the next A2MP command header.
>

Thank you for pointing this out.

> Please pull the payload before returning (or drop the A2MP extras from the
> patch) and resend the 5.15 series. The 7.3 through 6.1 versions are queued.
>

Latest v2 for 5.10 and 5.15 series sent. 
Thank you taking care of these patches for me.

> -- 
> Thanks,
> Sasha

Best,
Siwei
