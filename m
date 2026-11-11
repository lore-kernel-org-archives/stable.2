Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435104;
	b=cENcQxAuUnDkWpsblwokoO+QZOJA/ehqYN/pY5Ik4C9hJjdmqSXaeLpCUWEOS4Nh3+7y
	 Vm9I+NrNfYBrhkf3J+lvX+ll0g7Z0PzQu0sRnv5Peaq1mRppIXZWEjt7KUF/1CeSXb+PG
	 xX38M0e0JiELX0PuBcFPmyREp+IYG3qesGY6vd39Lqgz8HOuBTNh7LKzpOsiescootoMA
	 w8n1y1Xfld7g04eCI746WoAXS9g29wqMDA816IfiE6fztjHLgVvFG1kCbfdLp9tfLNwxl
	 Q69yQx41RB0Uf2Yt+i+hC4M+/8fNcdUQPSYYftqS/w1IreE7yjfcRYoQ+D09JeNSYVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435104;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=Ci+vdTqLYsgEtOnWel4mPpiETa5xiNwGajwa4+EZk08=;
	b=NZstcX6mvPY+UkYsI4DbSQjfnnO02W1VtKKnOsYLfRDM4w0NdCKt9yFpLyQCCmPUGxMt
	 5cAy8jiimfqF97AS/ByaTzhGyXJPiuHHz2ga+wXBNgbBbuClsS6h57l0o0wDbLeP0Ok//
	 ygTUtScd1jkQWeFovJZ7hoTvilna9ENta1hOG3bQykvEfWE4Sr+gqwqtsfdGkN0wXifq0
	 e0P7owpbanfEp9ZomVqG8P8Jp1VL05ULb5bO8gkissyQYo3K+/DS4vr5S//ixDYVWx8ZE
	 gwgzJPjsEpt1HZ43j9jxO5S4+N+I7SdcgpUCcHNP6Bz7WoE2QTTU77cvVk71bP4XsEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=BQzpUuIQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XUHpMFgw;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95A606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B95A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=BQzpUuIQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XUHpMFgw
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 61F9D7A01B4
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:11:43 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 11 Nov 2026 17:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794435102;
	 x=1794521502; bh=Ci+vdTqLYsgEtOnWel4mPpiETa5xiNwGajwa4+EZk08=; b=
	BQzpUuIQUSXuNOlMynYlCywSctWRCHFc4BsNU0SCsOfpHxr9lRLVBIswzXzrdhLW
	+09ayeSuZ6XwhU3NnEqZtB0HuKrH8YWkkHtdSZshGD5OMUF2iOIG4/YrLOexo0xq
	4RmamPmaQjCowYSpeoZIyj+JUxfQ/KusZWLmB1IjSTwaKQTQxYyuuhQiQKVloA2/
	laWKbOlbxDSqdVw3CK2qEadJs9Twi1v0cM4zuiVzZqcTSx6fGKS/dlu222RPhyD1
	LuPlzx84ToV7MsjzQeZeg3OK8VWFWjNaLwAB2XrqlOV/XqMGKoNPIVKQ+ICAaG9V
	W2qOXt2HskDwXlHaLjCtcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794435102; x=
	1794521502; bh=Ci+vdTqLYsgEtOnWel4mPpiETa5xiNwGajwa4+EZk08=; b=X
	UHpMFgwIxBdVJ5I53hs7muqstMFvq1gNriJalf4OVyFOpMPhlF6F3M5H7qanTT5r
	LLmuDr8vcqLfsAzZcqwycxq50HBtWEygFKBcZ/VLZxKAuw5sS/DsvuDPA/2O3Wm6
	/hLzNOcO6eLPKUqO4nrYIzJy/QspqSKnkZuxkPfjppq/swiZwXJsxvV6zQwTGlC2
	n0O25nI8IzaJU7nY99w5BumwuRKuhfQWUX2sNrLYwt5HGgiqu8eVMoZCbHdMxntl
	ffnDjSqFYhLOyPWIrAaq8rAJ0rdUZF67w2TSv8HCmePXHhU7jUTBWoFZfzgQ1ds1
	6q+c93ZxiRlAGpCaFWClA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794435102; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:X53ec89nJhrl0bDqXfbc3EnatVuLiaK1XCReiKfgSRdNoSV
	7yLlIvja7tw7jABxD3wSPw6lFOOQGYZ1yTgwqQ997zsXcn2mZhFe19VRk7Rb1GEN
	Qf/DHaZCQmeGecLWWfd/UVud09pdht3X2wuPvf0VWOT4VAqJfpEa4lUAPhenLefT
	RaPVHnwoHZW1ZhbITbX4p14qFNEfaEqnzmVnJCPcok9CW0RAwNfNk6ry6fFQUDJQ
	5BY6Uo/yCHbXecaimqJC6bT4tHt5RtRVE3S56Ek2fyQAOHO5+TPVROZPi0KltS+h
	Kn2Xyhyp3YFFEY5Eqhu/6wrQTihe6qMUSsyAcvA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:25rUscOmfEYdQRAt3bgt2oPeyg61dI6JghyaV4T7rus=:xo7kk/G3liBwNsEfVjDhvanCPDvAlCEFL3NApVU1h7A=;
X-ME-Sender: <xms:Huj0anlYl5VhkZxj4FbZd9y5-ksIVdBiov7c6WsV0bXH8i2ThaIh9w>
    <xme:Huj0alo1CAQfj6teRj2qbWkZryXon7WG3RqQdC5tglqiA_L-rW5nashRGUCa_Lkur
    -u_q-VUR4-iVYM3f8r0KBwf3Eh6kibwfZgh6T6aetdHt4SvkTfj3QKM>
X-ME-Proxy-Cause: dmFkZTF6w9IW36ov1m2wmz35B2Gre551+S6xx98kIiCcLeSC5u/waMKmyrIrINXpP8Bcgk
    nVgi5JIxEI4xCumj51CXdZF07Bc8FhQOftMUDxsZZeQuCiUfp64HQAGQNxgunxaptWE1mc
    WrNv9Ucc89i7Iw2WXNhQUHji3dgjicmFdu6UhQG1XQRjlJPrpGT+S9GzFo3qOjvoD5HtD1
    TaJN38bAI6yn10F2Z+3XmqVXoWczqxQupDncLQ3lHTUllo+upqjm4kIQHHKMOTeM8IWtOq
    3cltTIIZ2SYs8gTV521eooAW0XTjt8Ee8xgJZ9HWpGWPzhmkifa0EeXhui4x4+FbGncGag
    VAcxquITWoXTYc0NUNAhzSu3Fh29WmHaCou44eMbx/34EU86HTfAghzqS2KNklxJDxleDN
    xcKW+SBSZ8b/BhvFLXq80nUGJ9V+yiIxImu7aUF9dU9Rkva+gSBMVTs8MurVOc7Myt3uxh
    anHtbGKugZXRvJ7e+9SvNWKp0Rq4sAkRvBCN3J8K+5rU0oWg780hjIsA+uNLsbHqmBLOXr
    6zq5qtXnnRtULoN7/eRboUt3cJ8wKiRqBTP69YIwph90wmHggD7lG3TjbdoJmtf4UgkJq+
    pwNW8ktaUzMhjAi90z0ZcKzcYyhmbCVI1IMpo4fJOCZkmMF82qTuVHJngM4Q
X-ME-Proxy: <xmx:Huj0akj4PVPjhT81K8Qb-_YtG2KIMobmDUGJ-ACoYEaKf9RtnHyhqA>
    <xmx:Huj0akzqnVkhEQ7mtuXM2pbGgK5kggqO6JAEQW76t5yNzAG7Al7u6g>
    <xmx:Huj0avKFLlnGYCf5bxSqwkV5uhnVjRrMk-wEdfQ55CFY07cXx9OulA>
    <xmx:Huj0ajT1zya1_xvUToG3JQ36b5MQYlYT4S5eCThG6vYH-lTz8eEjuQ>
    <xmx:Huj0avxDHiceUtZxGNpAomAL5Lb_k4G5NmE_f0S8z_MAYBKFoGn8X7qT>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BD2F5216008A; Wed, 11 Nov 2026 17:11:42 -0500 (EST)
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
Date: Wed, 11 Nov 2026 17:11:15 -0500
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Sasha Levin" <sashal@kernel.org>, stable@vger.kernel.org
Cc: "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>
Message-Id: <e4c956e9-8d67-483f-a657-c2886d4b01a5@app.fastmail.com>
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

v4 sent.

Please check:

5.10:
https://lore.kernel.org/stable/20261111220851.3076201-1-oss@fourdim.xyz/

5.15:
https://lore.kernel.org/stable/20261111220745.3075256-1-oss@fourdim.xyz/

Thank you.

> -- 
> Thanks,
> Sasha

Best,
Siwei
