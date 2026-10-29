Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288313;
	b=E2XPJtXaR3/sA6um/EzNUoDJv7sitt2o1ihrrTB8i/hwABMIkl/iOpPLKN1Uueo5WqTe
	 fJNc8CHP08TbkjHMiJE1JV/mjMP+2Md7F8ymi/ptQc7y+SFpVFxJXLgG+5z4EOT3oxdOO
	 7tFJN4MbBsMHCCJ47GOs5zWdYoDTswdAcp9d0cXWnuKtuqRuwWCar1fz6h7kzZt5NB1LK
	 9wCwxT7WDvVeNlDuXqwjaSgJ+rPJj4HyYb/ZHJejOTkGH/Kg9XkESIZ3SzRv4+5JBSyV0
	 lplveNXJ9IDlMIZnqdM9XFxwoYAPSRgG1waanNpiOg+H3v+Qd6pT/f2K3ZpPzVaBgrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288313;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/oAkPJMzkdi7XavbccsHCP+DmJPhcV4KmOiFA3BnsXs=;
	b=tWCN2AWfy/PGIJ5In3KgcyoCHDayig7WR3lRhbTPYhfvWo/MYT+wKM6t8KhETulnaI31
	 EO8y3xOWmIBy53PeEm6B5Kcb2+2TtAQXl6KQXbDRdnXjUoLuEKana5sYISVCoxuwUw4bz
	 8LI8UZ72WW8oJcOhhPrWic++kgNsX4T9nekaGvhCYlI7QG6+rC428Mq807LTeaVG5CvKV
	 XaFiHsWqQkS3xJ/CDuN/OTEOMrXbfA2jfC+SbxC4kEH/E+yDt3ADTInlWy4KtvfhMSkJk
	 cVdHIYGW9c9Jb1E0YZ7TLL1MjPPyntJY7uH6GNKvNWPgrmyocfD0avw56Z/CwWB2ptg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=kvZOpgX2;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2F606A31C;
	Thu, 29 Oct 2026 15:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABB2F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=kvZOpgX2
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8456E447;
	Thu, 29 Oct 2026 16:36:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793288171;
	bh=bpQsOYaB1ijQ814MqXyhJa634qCEpZYfvGruQOCEpvs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kvZOpgX2Z99DPat6gv8nUXLaC8zwfhI5ONFlsz/vtOQPsrLGmkuAjzvmi5f1kkwsN
	 +A19e5HiQAYO6GfiqxMKwqXU3jGVimJoSlbrEx78609FY6c3Mwc4KsddbUGWYrNrUx
	 euTIbArVy/vya+jgMjnjDh7ksFyf8sw+Om3+rw+o=
Message-ID: <d87d4158-bfa7-42cc-8f4f-b18d8fb86a8f@ideasonboard.com>
Date: Thu, 29 Oct 2026 17:38:20 +0200
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
Subject: Re: [PATCH] i2c: atr: fix race condition caused by static local
 variable in i2c_atr_map_msgs()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, andi.shyti@kernel.org,
 dumitru.ceclan@analog.com, sakari.ailus@linux.intel.com,
 andriy.shevchenko@linux.intel.com, gonglinkai@kylinos.cn, rosenp@gmail.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org
Cc: romain.gantois@bootlin.com, Cosmin Tanislav <demonsingur@gmail.com>
References: <20261029070818.639-1-zhangjiao2@cmss.chinamobile.com>
 <DMH6FVUD4K0S.R8UAMMH8TVZY@bootlin.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <DMH6FVUD4K0S.R8UAMMH8TVZY@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2026 10:25, Luca Ceresoli wrote:
> Hello,
> 
> +Cc Romain, Cosmin, Tomi
> 
> On Thu Oct 29, 2026 at 8:08 AM CET, zhangjiao2 wrote:
>> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>>
>> The variable `c2a` in i2c_atr_map_msgs() is declared `static`, which means
>> it is shared across all invocations of this function regardless of which
>> ATR channel is being serviced. Since each channel has its own
>> orig_addrs_lock and alias_pairs_lock mutexes, two threads can execute
>> i2c_atr_map_msgs() concurrently on different channels, racing on the
>> shared `c2a` pointer.
>>
>> This can cause:
>> - The wrong alias to be used for address translation, sending I2C
>>    transactions to the wrong device.
>> - The `fixed` flag of an unrelated mapping to be corrupted, breaking the
>>    alias replacement logic.
>>
>> Remove the `static` keyword so that `c2a` becomes a regular local
>> variable, eliminating the shared state between concurrent calls.
>>
>> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Was this potential bug observed on real hardware? I'm a bit surprised
> nobody noticed before.
> 
> Also, if it's a bugfix, it should have a Fixes: tag and possibly Cc:
> stable.
> 
> Code-wise it looks OK. Not sure a bug can really happen but I don't see any
> reason this variable should be static: it is always set before being read
> by this function.
The code change looks valid to me.

I only had a quick look, so take this with a grain of salt, but I think 
i2c_atr_lock_bus() is always taken when i2c_atr_map_msgs() is called. 
Thus the accesses to c2a are serialized in one atr. With multiple atrs 
this might trigger. But I think it's not out of the question that the 
compiler would optimize it to a local variable, based on how it is used 
(but I didn't actually dissassemble).

So, yes, it would be interesting to hear if this was observed on HW or 
just fixing code that looks wrong.

  Tomi

