Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963735;
	b=BKQgqFeOuDf99GiPgSwl8MJmU/qDI6mzI/rwKmU3Av9yH8T70D9fYWze8a25yMW/apvs
	 Xnry+CY7BZsDW/C5US0+94ExeWkd9sXPLG0LCltnO+/Jynn20Dx3CmR9blYGgrX8cMLep
	 jFu8rfviOutjF4y1Rle2s+n/UiWfCKM9r0wbwOlGFlYqezlMrGuLgtvBmcDmcmHqeBaYX
	 BwZvjUjeaIPD3Bw2o0qJBm2f493Azw+gWX0T6RijMreIEilHYFj8D3M/k+z5ngopYDYIo
	 LnHPrwnFpuIvcIiSAeHx8vARrQZncGx8l3V+LRrpdlhzwaJE8Trec8hEczOmfpXFuGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963735;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=Nyn2sZbhq3kt4CccG6fePtvo1Akg5z56u9y7maQkw80=;
	b=0/xmvlf+6eYx9URzVylaV5kcFIm2MT7m2jqTx/tsSaMlCvoZxHp2z7/s2/B+cIkfk4Rc
	 RY0TRCmCa95NIJB8pLy67v1PppB2qoJv9pzofYPkedtYCDLXPA55uu0+Fiiz7IQ6MGhrf
	 VG9N3MirRbJiA1jtnGycczeR1i4TVj/MRMyzHRI2X/X5k+DGeVMMyPnDyOYAHT0liz0IC
	 8auzll5VYl450h99U7ql4HHQRXOMn2DJtfdSMxluqDBufpM0T/ZI6c6eZZy6ygumgR4Jz
	 l4SE7LkhkXMNbzyJhOrpftnnw1b3hm+rRX75aND8KRCOQLbw8Q2fT3aXdB+xBFg+jBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LBrVpIlf;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84E60705E3;
	Fri,  6 Nov 2026 11:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB84E60705E3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LBrVpIlf
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 69B2FC6915E;
	Fri,  6 Nov 2026 11:15:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C8D985FFBC;
	Fri,  6 Nov 2026 11:15:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6A321032929C;
	Fri,  6 Nov 2026 12:15:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793963729; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Nyn2sZbhq3kt4CccG6fePtvo1Akg5z56u9y7maQkw80=;
	b=LBrVpIlfb2RThKpdFCYkqd/0DXt1SwiaBA58dChyn85XdhiAGyzmMEML8D7XgBdXTvq42h
	6IAVEqreDIgMFoSTBhkLnbWPEdsCX4gmx766Tcke0Emwb8LIhIjUOn4j+UWppoflTHeGMg
	od+eoyOCHvxJC0SMvaFZt+ZDokqo6igQ1+egrl5GCRoEDc/TeA0pDzk8sGsnxtt86fbEUC
	Q0qGK1Z2jGy6vhAXXhNaApdfzgyVn4wZrf5WbusAodPOpoZF3NAc0fB66YlmEzKB3TWY/N
	1P/4ecpTI3AJMNb10wv+rli03H6S8gwbUwHLoS5WphzSHBN+gQBWJjgT1PIHOw==
Message-ID: <58552af1-62db-4ca6-835d-bdfb597d104b@bootlin.com>
Date: Fri, 6 Nov 2026 12:15:24 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] bus: ti-sysc: Don't reserve the system timers on AM33xx
To: Judith Mendez <jm@ti.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Matthias Schiffer <matthias.schiffer@tq-group.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 Julien Panis <jpanis@baylibre.com>, "Francis, Sebin" <sebin.francis@ti.com>,
 stable@vger.kernel.org
References: <20261103-v7-3-topic-am335lpm-ti-sysc-v1-1-1b9a23b4a7c1@baylibre.com>
 <bbe7c601-88df-4162-83bc-047b810430a9@ti.com>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <bbe7c601-88df-4162-83bc-047b810430a9@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 11/4/26 16:53, Judith Mendez wrote:
> Hi Markus
> 
> On 11/3/26 7:24 AM, Markus Schneider-Pargmann (TI) wrote:
>> Commit
>>      3f6178392050 ("ti-sysc: allow OMAP2 and OMAP4 timers to be 
>> reserved on AM33xx")
>> introduced handling of am33 SoC timers that are already active as
>> reserved. During probe this means the clocks are enabled and a reference
>> is kept.
>>
>> On AM33xx deep sleep is entered by the PM coprocessor which
>> requires the PER power domain to be idle. The system timer driver
>> disables the clock during suspend but the additional reference held by
>> ti-sysc leads to the PER power domain not being idle:
>>
>>      pm33xx pm33xx: PM: Could not transition all powerdomains to 
>> target state
>>
>> The reserved status is only needed where the
>> gpt12 system timer must be kept from idling, see commit
>>      3ff340e24c9d ("bus: ti-sysc: Fix gpt12 system timer issue with 
>> reserved status")
>>
>> The timer configuration in the devicetree is the same on all SoCs, so
>> there is no reason to reserve the timers on AM33xx.
>>
>> Return -ENODEV for the system timers on all other SoCs. Like -EBUSY it
>> stops the probe but the driver core doesn't report it as failure.
>>
>> Fixes: 3f6178392050 ("ti-sysc: allow OMAP2 and OMAP4 timers to be 
>> reserved on AM33xx")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> 
> Thanks for the patch, tested on various AM3* boards.
> 
> Tested-by: Judith Mendez <jm@ti.com>

Tested-by: Kory Maincent <kory.maincent@bootlin.com>
On BeagleBone Green Eco.

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

