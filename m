Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118879;
	b=plL8Z+tJ/vE7v7Kjp4ELhLEc17MWre+UcVHA94SeKg5cGrf98uaoLSwvicEw16yA0Mks
	 WBYapNvm+qnakoJZMn6lMOZr2UnUJtCVMf3Y4Tsod3CNUa2ArFovUUnxMwBCoc+p3CWcy
	 xmhddL3dZiOJWPN1931v6z+Zm15gdhCBU5KtSY+0kqmOzspzgV5UFESWIFl2hOnms0EIo
	 HexJCDjbB/WZKPJ71+CFpiKzUjDzUpHSs/UggXVno0ypvbIO+ihwD/6BzM7/3gZ3ih+gg
	 xrkl0uKl+cJaZkq9JfWegENm5OUNc6GjHa3raKj3Mz6T15aVvN1B5bCCVAUulxxjQ5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118879;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6Ne0+lP4HpwklHj/DnRJvYMqyH23TmCPwmpDeYjvXZk=;
	b=gOdKLp17oQ0ZKTwjnOecqqo9FvOj4zXHf+3BTPT4/TE4jMg/zREyh3DiSgZYn7hj8+b7
	 NKIP1U37nV6UnDaFlC7+wUb4WuDUcIEFQfoqRovhXzlYl6svOzHQN3tfPCv1dmHM2nNGa
	 psr0nIi8apZq/uvMgTU+s7fLgVBnA2fXXRODnkDzXsyAlkjs0tvLqZCIODiOs7dbv0kyY
	 gfksrgZOEpDElz1PfUnexqCeyCBJTbjEBdoxL8x/7L/DJZfLWEZb/J8OVQdAIR+0dI2e3
	 ExPUpr4wi0qf77H+VbFMWtywJ4YznK90oeVu9xjtLek9UzH/gX6Y7khzJIV8Maj1XVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=DXduRMhC;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2F606A31F;
	Tue, 27 Oct 2026 16:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFD2F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=DXduRMhC
Received: from [192.168.0.43] (chfd-03-b2-v4wan-176392-cust229.vm15.cable.virginm.net [82.19.20.230])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 57A81493;
	Tue, 27 Oct 2026 17:32:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793118744;
	bh=WdH5A3aRHlRSs7uah5RwEnvAt/WUWp3S3jRR6nY9PlU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DXduRMhC8y+AZWf1/MkM3f4ac9/dEFuZ17WHyEVkhtKtMVOpayOEZV03DD6Cd/XTV
	 2Rq/vqUcCup2XVqbuM0RywBmZwPqG8nCPdngZYUJ9qDPPFT4vWU/Pbp6wLkSEeTrv2
	 a0FiP42LbEv8EIv6EDK8ZkJbQhOOw17JixndxbVE=
Message-ID: <09579c0c-dd04-4d03-b815-c2cba53ddca1@ideasonboard.com>
Date: Tue, 27 Oct 2026 16:34:33 +0000
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
Subject: Re: [PATCH 1/7] media: i2c: ov7251: Fix link frequency index
To: "D. Manresa" <dmanresa@gmail.com>, antoine.pichot@gmail.com,
 linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com, mchehab@kernel.org, djrscally@gmail.com,
 hansg@kernel.org, andriy.shevchenko@linux.intel.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261026111032.88355-1-antoine.pichot@gmail.com>
 <20261026111032.88355-2-antoine.pichot@gmail.com>
 <6ae07c65.e52dcaf0.293af3.e7d5@mx.google.com>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <6ae07c65.e52dcaf0.293af3.e7d5@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello

On 27/10/2026 10:26, D. Manresa wrote:

<snip>

> So either ipu-bridge's advertised link frequency is wrong for this SKU,
> or mainline's 319.2 MHz PLL entry needs more than the index fix to be
> usable. I have the machine for a few more days and can run whatever would
> help decide which.

It would be worth validating the settings for the 319.2MHz link frequency to make sure that the PLL 
is being configured correctly. The link frequency itself advertised by the ipu-bridge strictly just 
needs to be one that the sensor driver is capable of configuring, but ideally we would make sure 
that the sensor can configure one that these platforms tend to use, as the platform designers will 
generally choose it carefully to be appropriate for their device. When I made these changes I 
checked and the driver for my Surface Go 2 was setting 319.2 MHz, so I would be more suspicious of 
the driver's PLL settings than that value.

Dan

> 
> The rest of the series tests well here; I have replied to the cover letter
> with that.
> 
> D. Manresa
> 
> (Written with AI assistance, directed and reviewed by me.)

