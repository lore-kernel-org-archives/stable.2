Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50B3D9552;
	Fri, 25 Sep 2026 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317000; cv=none; b=Yhyfhbllp9plNXExBpPBcFE0gJ0BWlpQoVY7kM4R4NRcMfbEsxs232KS/WmHA+IXtaVG0fwTDHrfC5KOJcK7359LYJa7VVXNORFx5kZQdhJe0aTDmTZksTYHspBJqLur/wqFV2IgRMp8EcvAhxqvqZvgerNVAehX9kfEQFFwbAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317000; c=relaxed/simple;
	bh=sNpGNdTPlilaSPtFkHWcqyMZWds8p1B/qQad1lXxkDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L10URr/AvD3JGguxWXnJRvkRcve62lAagJo34EvqI79xSpSg4un/T7ra/ZvK91D1t9qTaKv8/hLCzxsZUkI5muwB3mxAYr2LNNdkae+srlnjiV+PH2W2EzAOIzoQLXvcKf9bqdCb5/vylycn1OP5W5MpjNNS0CO4+0Ky1zML5Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mBDwzqjJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mBDwzqjJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 56C121A1017;
	Fri, 25 Sep 2026 06:16:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20AA56073B;
	Fri, 25 Sep 2026 06:16:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06FDF1032946F;
	Fri, 25 Sep 2026 08:16:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790316993; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Yc6B6WuJA+0CW3tYQXkvXyiY8V8tJg97zI1dnbUscp0=;
	b=mBDwzqjJPEiEMy2zx4O/CJIYtnT3P79FFGPt2w5b0dmoS0jvG0VX8mRnDPVuWUU3abElXw
	VQSW4XARWo5duI7g16uspQYKEyATzkPd2UH2iEaXotCaJY2/ciCrVL3+PlNzbQY9D1i0J3
	W1A9NCNHt+iVV7BRSHB9eHLhz2NmabUkcDi/BsWVIJWwMQ1QXx4mlL+nu/JYusbFirBRzn
	cviL8W1KPmWQV+R9s00A9YO/O8jGO+RyMSAe5kvKNDLXuOAiFO+9W8gmiR8les9anYhYo+
	wLfwsxLBxTq57171lDn2ZS8YbOYMOf309hLXv/eP9Z0nWezIbi/R0CgM+HKfDw==
Message-ID: <ee69ae01-97ab-470c-ba1d-658f1700463c@bootlin.com>
Date: Fri, 25 Sep 2026 08:16:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: microchip: save the periodic output
 request
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev-bot+sashiko@kernel.org,
 woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 richardcochran@gmail.com, ceggers@arri.de, arun.ramadoss@microchip.com,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260917-fix-perout-v2-1-d8acf3eea6f7@bootlin.com>
 <178998077822.2160803.3867886756893254872@kernel.org>
 <635cfefd-c588-4b3f-bbc4-1cf11ef0a2c5@bootlin.com>
 <99bcc883-1cbb-46f9-9283-cd03e5efafe7@redhat.com>
 <c1cde6b7-5883-4dbc-87e9-d7b86f727ba7@bootlin.com>
 <20260924080252.2169c100@kernel.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20260924080252.2169c100@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 9/24/26 5:02 PM, Jakub Kicinski wrote:
> On Wed, 23 Sep 2026 08:51:19 +0200 Bastien Curutchet wrote:
>>> Also if the issue you are observing on an older kernel is already fixed in
>>> the vanilla tree, I suggest instead sending to stable the relevant change.
>>>    
>> The issue isn't fixed in the vanilla tree, it's only hidden by the fact
>> that the driver doesn't register the flags it supports in
>> .supported_perout_flags.
>> And only the flag issue is hidden, the index still gets wrongly set to 0
>> on restart.
> 
> - net
> - Fixes
> + net-next
> + better commit msg explaining the state of things
> 
> ?

Ok, I will do it this way, thank you !


Best regards,
Bastien
