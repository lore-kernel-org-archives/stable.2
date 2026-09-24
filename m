Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2F83A1696;
	Thu, 24 Sep 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262722; cv=none; b=fkIWSvfHhe/WOLzQ+cg+8Za4rrL6Vz6cpvFIFWJkHJ7wY6B2yeLTVf5BGkE/DlzirmXGJpYD8aiUw+O3P884JbVzv66bi66NS1vuvMnGVwQ4/8AUfs3JBIm5pq6hBEETqlwru52EaSx29xxTSIMuD6JytTilJdfTS4oYhICd6PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262722; c=relaxed/simple;
	bh=ZykuZkJ4JL+Et9AOMagm3MkYCr3EzzexzQ4kmYPzF2Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kbnlbfwG8MEqZlF/kZxsTSIbCKQFTHkJEM5NoEQCLScyexJy4tAdW8grAQsnsPOTuCOn19KKMHELAJ9OwCMADAIzOPDic7IQvS8u4tGzas6SxusTzEbVifzDl7FfG+UzsCQZar01XJpFY5DdzxJcIY6kLliZXARRir//qtGdUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WsVmNySU; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WsVmNySU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 46647C211E7;
	Thu, 24 Sep 2026 15:12:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ADB6C60341;
	Thu, 24 Sep 2026 15:11:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CA5F103293D8;
	Thu, 24 Sep 2026 17:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790262710; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eL6oLqTGeMgwRc+mGLllj+d8cQJlbDrWIsv/RTygnkc=;
	b=WsVmNySUi/GaEvuAJLoHJce4dzMcNEzJ+YZ+jBptYPB3p9G0ORgDPl2fGtFTSmpt4bKhr9
	QWYLg49IqpaynIRLGbbkKqhssfezt2yJnxtcq3DLwgIcOBkYO/cXxebSPKv+m6VJnE+D6W
	iVKKz15yQAyEoHT3pRD2MqdftLuzPWqIePkKR04THJIVYhNT5R05aCIWQHRB1YSC4BpYyC
	21/uUfKyUrZkNGANEg+Ci+CzUDnOT0M7FoEJfM2QQLGFW7U01pzG1LzM1yG9BE9PxF5cRN
	pO3zr2HZZwrcN//jqo3XjqrzqIPfVbTMmYllSJ8SNwy+7g5LkVDoFiCAuujfFw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 17:11:43 +0200
Message-Id: <DLNN5W7M505X.TWFOK1HD0CQL@bootlin.com>
Subject: Re: [PATCH net 1/3] net: macb: never give hardware a NULL RX buffer
Cc: <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <nicolas.ferre@microchip.com>,
 <sean.anderson@linux.dev>, <atenart@kernel.org>, <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <nb@tipi-net.de>,
 <vladimir.kondratiev@mobileye.com>, <gregory.clement@bootlin.com>,
 <tawfik.bayouk@mobileye.com>, <thomas.petazzoni@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <stable@vger.kernel.org>
To: <netdev-bot+sashiko@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260918-macb-close-v1-1-05e32ce98813@bootlin.com>
 <179010942002.2160803.8691011751847108495@kernel.org>
In-Reply-To: <179010942002.2160803.8691011751847108495@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello netdev-bot+sashiko,

On Tue Sep 22, 2026 at 10:37 PM CEST,  wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] gem_init_rx_ring()
>   (drivers/net/ethernet/cadence/macb_main.c:2793) now sets=E2=80=A6
> - [High] gem_init_rx_ring() now publishes MACB_BIT(RX_USED) on every RX
>   descriptor of a queue, resets queue->rx_tail/rx_prepared_head and then=
=E2=80=A6
>
> --
>
> net: macb: never give hardware a NULL RX buffer
>
> This makes gem_init_rx_ring() set the RX_USED bit on every RX descriptor
> before calling gem_rx_refill(), so that a refill that fails part way
> through does not leave descriptors owned by hardware while their skb
> pointers are still NULL.  The change affects macb_open(), macb_resume(),
> the HRESP error recovery path and set_ringparam().
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index b8234ac4b602..751fa9e68099 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -2785,9 +2785,14 @@ static int macb_alloc(struct macb *bp)
>> =20
>>  static void gem_init_rx_ring(struct macb_queue *queue)
>>  {
>> +	unsigned int i;
>> +
>>  	queue->rx_tail =3D 0;
>>  	queue->rx_prepared_head =3D 0;
>> =20
>> +	for (i =3D 0; i < queue->bp->rx_ring_size; i++)
>> +		macb_rx_desc(queue, i)->addr |=3D MACB_BIT(RX_USED);
>> +
>
> [Severity: High]
>
> Does RX_USED now carry two different meanings that the RX consume path
> cannot tell apart?
>
> gem_rx() uses RX_USED at queue->rx_tail as the only indication that
> hardware delivered a frame, and it has no bound against
> queue->rx_prepared_head:

Yes that is correct! We can fix that using our cursors
rx_tail/rx_prepared_head that tell us which descriptors were
reallocated properly.

IE in gem_rx() we stop once `queue->rx_tail =3D=3D queue->rx_prepared_head`=
.

[...]

> [Severity: High]
>
> Is any exclusion against a running RX poll needed here now that the whole
> ring is published as RX_USED?
>
> macb_hresp_error_task() runs from system_bh_wq, masks queue interrupts,
> clears RE/TE, and then calls mog_init_rings() with no napi_disable(), no
> napi_synchronize() and no lock:

This is a known race, but we won't fix it in this series. And in
particular it is completely unrelated to this first patch.

It is semi-related to the last patch that puts in place the mechanisms
that could be reused to fix macb_hresp_error_task(). But again, not
here, not today.

[...]

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

