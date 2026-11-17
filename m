Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946575;
	b=PPjt5F8jinJgbX+I2m6ja2KCo5KRZeAk/OKXeLvQLfBZpeDS7QdEHWUzFfoL4wGn6sy+
	 AsHsBkj47+xFPZRN1q8G3xSFnmNDk0UvZ6ambWdw7eLnDx0OUC7kjgoRXAmuAyTPltcB7
	 GkZe8ckCbfD4GIB/rSL8LjpT474pUCT20meMaqFkJASf6UUnTh2XMUi7WkQCyqfYkvJ4o
	 HhbgPlqN5BJuJ40chN1Q31vXXDM0o7nF95FCQ1FUEdV+Jxnq5k/prJnnpKvAN3VljIYws
	 u8Fx1ZbMdEd6/nAjCcic74w7v6qm2I0VHi7BAYGAb8A59frRv1C4xRS0CVn4VwVF19A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946575;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=4gHgyZkJ85ljmtbUfZ2ppvyzZiHy8Yza2XSe4CtHOfc=;
	b=4nbq2/vi98Trlx41lHiCeFyXHg/tlXoOdZLmjKldvkRET2nv6CJLs+PnQgH+4u58xFPC
	 OZsHUGzQHQfFTEtS94b+1TDs6MRrhXLvCY4NmgQ6UcvDktVxnO4sLfvObFYQCVhmzHs1V
	 6vUALLScmEA8OrWjCZozXJ5QG9W4xfmvKlUrUubas9s89hU9glC4YdN6aJUwJ826WGbcP
	 eIuWE2wpjtk/36ML3pQI6vmKFwWkStwQVggwxQylK2neI5bzEV2rWAyh6csmuYfUfHmTE
	 x5kzdHeTn/QT1LWsZAO3Y02/zZrZZ8dEWsvINYQQhOq+8XK5OsfPi7f+izU0u39ge7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=nTPalYv2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=f0kVEqZJ;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E952A606A32F
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 20:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E952A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=nTPalYv2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=f0kVEqZJ
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0EF4414001A2
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 15:16:13 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 17 Nov 2026 15:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794946569;
	 x=1795032969; bh=4gHgyZkJ85ljmtbUfZ2ppvyzZiHy8Yza2XSe4CtHOfc=; b=
	nTPalYv2nLevYvXXnrmzznDZ8pPmmR76R6bCrbWXO537SkU607/FvckQoAQKoOnK
	z2grOXjDj1uQZE925GpNZkZf8PSHjMG1QkyCHUzZI9v6H2GjQUjMogWAYhFmtVUu
	bje3shbY1dXtpjvLBLWmZLH5lzJmhBLmgjR2Oo90dcgG1nZCYzvSgN85jC+pkfoc
	vMTaQtUajGNopRUR/C8UIL9fhgncrAZEXTZqdwahotoZ1//ra93mBlOHeTUODGeI
	Vb5VOdmyVzaKufyDopul2zGqTEwXvBcQG56AgBHrI9Bo45sYCwJKj9FGeWwCeIjk
	H8Rj4smUeYHt3ataeT/mug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794946569; x=
	1795032969; bh=4gHgyZkJ85ljmtbUfZ2ppvyzZiHy8Yza2XSe4CtHOfc=; b=f
	0kVEqZJZCzAmcw1UrJqBJOotuvtgTXTC6vJaS2saQYcpuYleZj3LcorPC9LuUPB6
	0N4E/yCdfN1M4iernSVIB2pFQPk0zC4AnZNDWicXXtKuCzhJBsNtpbiDaZ3jKt/1
	M+fx2RiyDTT82sddphx1oXAEv10i5SIEBPis6Zf4UxSc8fQgt1T0iWdLl0c0/1CV
	v1xvVs5SaLMnxA0wlHAu8b6yTv9IsTOyZgwgXcL47MQx8a2Wg17Am6Ve2cAPP/Lk
	GIQAfdn4uozW6tdxK5H05dipZMQZPyQyZqpjEfIVnpQBauhoGPz19VqZ85YGuqLw
	UaJEobjkJU0wz4SjrL+Kg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794946569; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eGGfoUbI3H46twLudiv/3EEQdY6JDMB3SGu3fPll6eQtaQc
	Hz5eBbmDz0AVC954ei3C9jQfmbTbpKdn85jUJ8fzRZ69MDS6NzDcEbxeaJzO/7am
	tbhYAbDC7PrBBfFSd0/zG1MF4H/5hWmgX9BX6WRn7ZTRlqh033wyK2wvHITB6uJt
	EWI/Hk5G+ZXORMtFVVN3H4/zqMowMW8aSnY4X5QYGDOQGgh6+D7xLzgIHpmCcIUc
	a/VNYsYwDR+JARdfC+jPG6ts9VMhU2NTX01ImF+QAQ/kdpM5lQn+z13TOjltVllY
	Vu2YAzOhmPrJvf3oW5/wUpRjYVXAIo72nJYucKg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:H35lYAFWjzt/PT3JDB+srzKd9F4jY5coVqosVXJaKWk=:zqY97fITSSBwgO6NYdHi++FrGLhlw1V/CK2RmFngirI=;
X-ME-Sender: <xms:Bbb8an4eD7Mxjhr5xuNgow9-719Ddu-H-Q4KUYRGxZAisBwy7FQnWQ>
    <xme:Bbb8ansDjA7lMOPcIA_7XRB4G0YH88GTgtLbBk3YlA1iN9F0oxEYv1uocMejPIJgU
    aQSeiA4oFgrcMQATc9tzuQqcrhnpdLVkau1XTMjfgrlC10EJLBbyPeW>
X-ME-Proxy-Cause: dmFkZTGX2j4tdhEBXhp83Wtai7HDzbSZhK2/icwqvbj+jNBIKYl/6qaWMH/EcTsxxUlklJ
    FNt+NRsGh1upWKnRORMCx6dBMm2QYj9qBwd4ricE+t/KALMLiZ9o7Yl+B59U9A/yxR9OLE
    67asVz2quecKhYHK390xyT1823BrDUYaGlNNeFaZKFGyM0h5+LXQ9PSuvPVGkQCJkFAQXK
    ueawkHayc3c3ayWIXL/EFvTnjjQo/rCTXVmsEsnwr6RIdyySbeaqeYl5kcuskh2vbAG/l0
    WXrM25oWjRxRVxANUnucFb4sGX/a6DOwrkYOEqjFY8ZQb8yP4FdsEjSMZD1hC2+cBzQVdu
    ktAHaYiHkGQ0CUZkmsHs8uSta9pGY4VmEM7JiqM0mN3bqLKyWT9d/pCblc+lK74Y+xstca
    PxshXGWJwpQKF3k6m3WXY6msOd11AVRzJ7hHtJg5mju0oKJaXS/sVOBxLwOS9/qe6RBK5H
    dUeZ3b+RqbYcAELEWjfm1lh2IpgMgvGWCqj14/G9A7PoinZm1Q+yemlQSVNLIJyttQaJD7
    T3bvucWtVNSGnxrFH7ifXNDQv9JIkxkzqdgN5iYh2MbQD4KGRcixouQkKYIdNYortMElj/
    8EkrfTNgnlGLi0kazarXtWeaCQncBdaeD2gQwIUPl26YuoUyrK5/rJrW3OFw
X-ME-Proxy: <xmx:B7b8avlo4EsGZDqFpvRGJQgbdrap5yCA03GNkiqRun18Eem0bnij8A>
    <xmx:B7b8akZkb2ndM2tuNoNasGmNQVrpVA2v2N4Qa-EZAQ0GESwNx8JvBw>
    <xmx:B7b8ar982JRLWxMT0g6xBo81gzkr03Ffp-mtrZStxnzcQLXpi_O65w>
    <xmx:B7b8ajbw-vWr4UGj9pHRcGbYD0xt0PZPI0CfnfANv7fWuqIthtxW2A>
    <xmx:Cbb8ahpWMpy65Kxk3-1n1DEqaAmlrHVo6ojZ0Ct17citMsykrpd0dK1s>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C96C432A0099; Tue, 17 Nov 2026 15:16:05 -0500 (EST)
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
X-ThreadId: AfIw-mqhlrh3
Date: Tue, 17 Nov 2026 21:15:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: "John Stultz" <jstultz@google.com>, "Thomas Gleixner" <tglx@kernel.org>,
 "Stephen Boyd" <sboyd@kernel.org>, "Miroslav Lichvar" <mlichvar@redhat.com>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Ingo Molnar" <mingo@kernel.org>
Message-Id: <101777e2-a6fe-4d1a-9a9e-7179ce89bd65@app.fastmail.com>
In-Reply-To: <20261117200127.2399332-1-sashal@kernel.org>
References: <20261117200127.2399332-1-sashal@kernel.org>
Subject: Re: Patch "timekeeping: add CONFIG_LEGACY_TIMER_TICK" has been added to the
 5.10-stable tree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 17, 2026, at 21:01, Sasha Levin wrote:
> commit c3738bb0ab2025492e5c66b7dcc89bacab4af79d
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Thu Sep 24 15:21:43 2020 +0200
>
>     timekeeping: add CONFIG_LEGACY_TIMER_TICK
>    
>     [ Upstream commit b3550164a19d62e515af6cacb5a31f0b2b3f9501 ]
>    
>     All platforms that currently do not use generic clockevents roughly call
>     the same set of functions in their timer interrupts: xtime_update(),
>     update_process_times() and profile_tick(), sometimes in a different
>     sequence.
>    
>     Add a helper function that performs all three of them, to make the
>     callers more uniform and simplify the interface.
>    
>     Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>     Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>     Stable-dep-of: 2927f7ca7844 ("time: Prevent time64_to_tm() day 
> truncation on 32-bit")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

I don't see how this is a dependency of 2927f7ca7844, it looks
unrelated to me, and the patch only adds an unused function.

Also, while 2927f7ca7844 is correct, I don't think we
really need to worry about overflowing day numbers in
stable kernels.

     Arnd
