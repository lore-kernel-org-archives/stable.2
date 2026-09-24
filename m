Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E18745FFCB
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267463; cv=none; b=JdvxTpAUiITX/SR2ntO6cdsh7mwVxTE3pSHvuHFU8EvEQaWvHCKqgqe453WuCqVRq9JbVB/11uGkip5F55ECV39FXMBlbDuYDpG8bX21hhcKZ3AEgUkI+9uCmwL62QrLQQLhF22nJUty+qsaZsMv/L7GprRpe6vrnGvHP7Csrvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267463; c=relaxed/simple;
	bh=AW69JSTuKRu0+owu5Z9DZUhFDLudIJOEddmW6LlPCNw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=g5NwW8T4Z8z36n0O580aIRDMMlhg5QGn4AUIF//DgvQuoNkNg0ORDlw0CjqlLdzwgESHgeZMnBQibV9S3CYLHpa//dXC4MgKyR9nz11/hHphnAqe+jzaycsB6/EVH18bOcpErV4wUY6JpYk3vsuWvqUZNlvplooYGhNpvByn9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cv687Kf2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cv687Kf2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DDBB71A1003;
	Thu, 24 Sep 2026 16:30:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AEA5660738;
	Thu, 24 Sep 2026 16:30:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E2E41032952B;
	Thu, 24 Sep 2026 18:30:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790267458; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dhFm/PLOniIQxvCkDITkzQzqbwdfD5DtiTHbFqGEDOw=;
	b=Cv687Kf2jLWjj7JAKOj+GR15zorz7Tfz7B+YYC4ycRp8S9lbsf+qO3nwk+1NyBIG2nSUu0
	jNL9TF9/vzNvz91w8vnz6UB3z8mo8QBoEpJYuRHJfKNUOTKHLht7UFT5aUMUXJpTvq6hbq
	iRcdUTwm82OD+8rcKj5Lw8CMxpPvCiDAZ6nasY+GxukuIRVXW6Sx7ODRTNZCCap3fo7STs
	20MfaOn5q3FL6zwkwh1zmWYjQnPCV6GBQQdNpqsRPne7Tb5EeMPfr1Xv4/bL6eTWJKnUzU
	6IJxOTWgO2MSXJE7PJNwWEqJEafpzgjlaK8uIEEmPnrAHRY7BlIQj8XqckUxNA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 18:30:52 +0200
Message-Id: <DLNOUHOHFIAT.2CM5NXJLGRM4H@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net 1/3] net: macb: never give hardware a NULL RX buffer
Cc: <netdev-bot+sashiko@kernel.org>, <conor.dooley@microchip.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <nicolas.ferre@microchip.com>,
 <sean.anderson@linux.dev>, <atenart@kernel.org>, <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <nb@tipi-net.de>,
 <vladimir.kondratiev@mobileye.com>, <gregory.clement@bootlin.com>,
 <tawfik.bayouk@mobileye.com>, <thomas.petazzoni@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <stable@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260918-macb-close-v1-1-05e32ce98813@bootlin.com>
 <179010942002.2160803.8691011751847108495@kernel.org>
 <20260923184756.16ce33a7@kernel.org>
 <DLNN7LYYGP7L.3OSN8JZNC37PS@bootlin.com>
 <20260924084104.25099f60@kernel.org>
In-Reply-To: <20260924084104.25099f60@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Sep 24, 2026 at 5:41 PM CEST, Jakub Kicinski wrote:
> On Thu, 24 Sep 2026 17:13:58 +0200 Th=C3=A9o Lebrun wrote:
>> > If the AI interprets the rx poll side correctly these seem like a majo=
r
>> > flaw in setting the USED bit :( =20
>>=20
>> Yes the AI is correct (unsurprisingly). But two things:
>
> If it's correct then patch needs to be changed.
> Please don't write puzzles for me to solve.
>
>>  - before this patch what happened was that HW read the NULL descriptor,
>>    so not much better
>>  - we can detect in gem_rx() using our ring buffer cursors that tell us
>>    what we've managed to allocate, that we gem_rx() doesn't iterate
>>    over descriptors that haven't been allocated
>
> Grammatically dubious puzzles at that.

Sorry for the fuzzy message.
Yes, Sashiko is correct and, yes, the patch will change.

To explain more in detail: gem_rx() iterates over descriptors using
RX_USED as signal that a descriptor was filled by the hardware. The
risk is to reach a descriptor where allocation failed (and we used
RX_USED as signal for the hardware to not fill it up). We can avoid
that using our cursors (queue->rx_tail and queue->rx_prepared_head)
that tell us the range of allocated descriptors.

In concrete terms, we stop iterating in gem_rx() if

	queue->rx_tail =3D=3D queue->rx_prepared_head

or if

	desc->addr & MACB_BIT(RX_USED)

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

