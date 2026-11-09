Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234256;
	b=boHpGhSjnCvzV8k8nXVYr+kGPH2Y6X2dnjWJHpmAkX1SP6NojkK2Ivtbblfi311Xm6AJ
	 TovQ1fPQUMoLmRoRRP3YbWJmgmUwCNMwm36TrF0ZSVLgkeNPo84b9efpIPF0CcIuDYeuL
	 7rEIMEcCcXF6IZ9lF9EjUWs09Jr1Kjh0WiEQGHuxgovyzpdxCADcWqxfdCghzwffYGkFJ
	 6Yv/ldLTwMSYH1t0KHvg88MhQR9/oxvz2Av0NGV9mvbZGBwtbQCZ+SXGpT22dRSqcmul9
	 ekmQE6dulXioT0Oi4oXObcCUdtKAPoz/7F28DjSA5fP8buPxEZ0i/C0QuzeZ5gmWafg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234256;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=tsM7eQwylVMO8r5LUeoxKU/myk8k6PLrfMmALCIMcBE=;
	b=wjgH5e+GBe256xAzjVpe6wIlaqJk/wZHWM9kHZ6adYd0WMem7gOjrD62AKaxhK8bKui2
	 LwgfVdJcGJRczRxIooA6ur5R24DEMWz4y8FxGovxcEjVF98vEwCfcwMphJjuVfTEGtI8V
	 IOblESckV6VK81mJA8ggnARWc1LIDBFE82yD1tns7Qpphby5/sCXDVSlMll1U31UrtbJT
	 b+qLb/T1VDMWxVzDGnIPR1NvcIF21f8OVkeLCmgwxpb6hYAyun3is9Q2Tv1PxzEjGN1/9
	 POGA9OtpyUNRZshPLLwexKIstpDjo6VMQIoX0YVxJpkBXEkFAV8rKxx/OzsBg9HJrUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=KdxZ1fF5;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701CB606A31C;
	Mon,  9 Nov 2026 14:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 701CB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=KdxZ1fF5
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7DAF8A1583;
	Mon, 09 Nov 2026 15:24:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794234251; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tsM7eQwylVMO8r5LUeoxKU/myk8k6PLrfMmALCIMcBE=;
	b=KdxZ1fF58v/fd6xsanqRJ8XKtULMYKJQAQ+1Mv3EiffCV2a4Sjv14ktTDN7BDVeztDuPn9
	I3uX0t8He8qzwPRdZYMuJeSeODTvIUvxtO6pZsf3srCqWdGRvVtLYZky15/FyoB2QudWdr
	vj9xVMe0nzJ9Hywp1TFVwMP7R9Lt3BL5tdJzeVbXRD4VO0YdzUGV/mKlzsFFG0HFVHoXlY
	Twjz6DzSBFgBBtrhirlauBxkLa+tUMHzPtvL96i389Y5n7j4lh8edkzIrSRqNK6/VFjMLv
	pXfiQzwsK9tkZAfD0MMljPf1GWGNDgn8Ofk61q62k9KwRfb29+eAl+bmfinCSg==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 09 Nov 2026 15:24:07 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, =?UTF-8?Q?Th?=
 =?UTF-8?Q?=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Conor Dooley
 <conor.dooley@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sean Anderson <sean.anderson@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.18.y] net: macb: wait for a running xmit before
 resetting BQL on close
In-Reply-To: <2026110940-familiar-slick-4d2e@gregkh>
References: <20261109-nb-macb-close-6-18-y-v1-1-51af4b20dffb@tipi-net.de>
 <2026110940-familiar-slick-4d2e@gregkh>
Message-ID: <cac12e5512b00adae81224e0e07f773e@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Greg

On 9.11.2026 15:10, Greg Kroah-Hartman wrote:
> 
> Why is that too large?  Please backport that instead.

Context swapping was a rather large change (+822 / -439 LOC) - if this 
is
considered ok for stable backport, I will send the patches.

> [...]

Thanks,
Nicolai
