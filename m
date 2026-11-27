Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795777499;
	b=HKW0NYIkyOeM81tGhdhF2RjpPHbXx5Mdyg/HHt0DTgxtKZFfqESuUcHKTlDYdp6tAoUW
	 MKIhFUW3VlpAT42TXFXMVHM5AROnuS9aJK71uVHicUGVFLWtvEg0gO3cEAMKXqDTpdLFl
	 C77XhDWtfacIccergyM/zDdBUTdr+jkxCyS4dAvdt63r7e2EUZyUc/I1qEjylVDDCoIJl
	 9nHX+NHKjyE0Wh2PC22xGx8f/p2jYxz121PDTm7yIObxMIqvIkgx83ZL5MyZchzbptKMh
	 KEDUpW/HKnD9ocRh8snZTRgtVJt844uUemBzOCHhunMq/qe0Wdw2NNn4NVPgwraL0eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777499;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=ER8jZocxPLPmILHQgyoN9JTV0B3dXhV6CyXeBPGIICQ=;
	b=bFGs4YWuRMcJIMRYw26C9HhUeStGAqG4ftrpjeVbpmARO4f0xVoBOWB7rkHRDjFHqwN/
	 GjfU/JiIgEXeODor/RACmwtwu11tdXmxTHFZ01mantzgmHaRe4mAqpTltlBso1AZfr4O/
	 VE/X3Ze2HX4GnO6VOWUtVpwpjt2n5NzZTkuFF64i90RQMle2WrFMFfFUbusxAxBpyQEMc
	 kB3/WO0VIc6oT/EzsdsYmqIoDOiZSU4bsCNxlvvRgQxbwtPPXuDeNS08490XrdiMhHPA4
	 ZwuxHlC32FJjbMD8K9EdTS1Rj7FjnMOqILHCedQYdeGgeuP1+17I/OIWMqJvD2yj7qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=w1wiWbX3;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1680606A321;
	Fri, 27 Nov 2026 11:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1680606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=w1wiWbX3
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5B4514E417C1;
	Fri, 27 Nov 2026 11:04:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 285C46049C;
	Fri, 27 Nov 2026 11:04:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D76CF11E69318;
	Fri, 27 Nov 2026 12:04:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795777496; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ER8jZocxPLPmILHQgyoN9JTV0B3dXhV6CyXeBPGIICQ=;
	b=w1wiWbX32tVw8kVzORE+NyhFnc9+sPl6VK1ZAnUJAAVJsuHcZthfxIjEhb3bmLTh7FDam7
	RKcH5N/wVN1JAYOLPPohourLcH4EfACdnOG7OOMnup35NtnCxME9ijH4UXATFCZw5izwXD
	kLmzg6TpvIEHE1UgsPQIHhEEgPnEpPb88MIYWDkAJBbSIHrW6+yZwIEpUO6SRl/irvOUu1
	K/7KqrW5/2MY1ZCimY77RBPExVh1crhKIKTr58OGqMByHz/fP3WXwzSTzzOlRQ+luESnbL
	sg5i/qp3WWL6pM2NynT0bW16jBs8cNjuONX3QlzVDJnfmlTHi/3iLtWEOrHhvg==
Message-ID: <67f6aa99-c625-437a-bae8-ea7a1637afe1@bootlin.com>
Date: Fri, 27 Nov 2026 12:04:53 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: cgbc: Fetch the status of a write transfer
To: "Haberlander, Markus" <Markus.Haberlander@rosenberger.com>,
 Andi Shyti <andi.shyti@kernel.org>
Cc: Lee Jones <lee@kernel.org>, "mfd@lists.linux.dev" <mfd@lists.linux.dev>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261123-cgbc-i2c-write-status-v1-1-5b0fa0322b57@rosenberger.com>
 <179568834099.302193.16315749597111506309.b4-review@b4>
 <awgwO98qx3zX4MaY@zenone.zhora.eu>
 <b0d32861-c123-4f4f-8bac-aa0e7e48c719@bootlin.com>
 <FR4P281MB4840894892BD79C05D844CEC84412@FR4P281MB4840.DEUP281.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <FR4P281MB4840894892BD79C05D844CEC84412@FR4P281MB4840.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/27/26 10:20 AM, Haberlander, Markus wrote:
> Hi Thomas, Andi,
> 
> On 11/26/26 9:18 PM, Thomas Richard wrote:
>> If I'm not mistaken, USEC_PER_SEC is only used if master_xfer returns
>> -EGAIN (arbitration loss), else __i2c_transfer() directly returns so no
>> 1s timeout. And we never return -EAGAIN.
>>
>> So why should we wait 1s?
> 
> Thanks for looking into this! I think Andi means the one-second loop in
> cgbc_i2c_xfer(). Before my patch, when the controller was still busy
> with a write, the next call returned -EBUSY and that loop simply tried
> again, for up to a second.
> 
> My patch now waits only 2 * read_maxtime_us for a write to finish. That
> is enough for the transfer itself. But if a device stretches the clock,
> the controller might stay busy for longer, and the write would fail
> where it used to succeed. That's why USEC_PER_SEC sounds like the safer
> choice to me. I'm happy with either, though - you know this hardware
> much better than I do.

Ah yes clock stretching, makes sense. So it is also valid for read
operation. So we could drop read_maxtime_us. But it's an other story, I
want my series to be merged, I'll send a patch later.

Markus I'll add your patch in my series, and make the USEC_PER_SEC
modification. Thanks for your contribution.

Best Regards,
Thomas Richard





