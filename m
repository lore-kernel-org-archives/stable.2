Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22143371CE3;
	Wed, 23 Sep 2026 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189111; cv=none; b=ryG7TKkd3vEca89sG4o1z7vkV+w5va6K0EQJ8A64dyI55t0SpA7lWGCHDcR7w/n7k3H9gmpUv7elqOBHoidVi59XceKGeOyxfFvi/Bd6yPD2lqlY3TzC/jEAe+DM795chhQmRtHi8tkHE0sa9mZaWWYdmQeWS5DYpufYqSYERRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189111; c=relaxed/simple;
	bh=UfAMVRepPDJ+nE8qy6ID0+WNeO1wk06VWwuoQWH5/jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfA1+JDC78PCRx+KzApfAm6SSr3fsmm2y0CqVj2isao+y1GXZ5lO3ulzoEeYM4jbtMc/tMkhLAR63Lk5OUMr5S19tVQQUU1QiL/vdVpPrHdqfS5dIrlsX/GCHcGbB/nEG5RF1igP7Zfp2JuFptYSlm28kTxbpWUBnoxWR08TbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds4NOxiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds4NOxiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9D11F00899;
	Wed, 23 Sep 2026 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790189102;
	bh=xy5baOBDcSw5z+GtROh7B/lMKxJhkWDYTFpOBzsz6MQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ds4NOxiGDFgjYSvGh0N+f5zLjGpEKFRZbadcvuSygxjL77oH0vwPaIrDv1SPUelT7
	 +HvrpoEyhQ5mIOT+nqPPMQRim15Ty3LuOUjt/20/5J7b/vrmcEAGEIib2EMrQoZBWT
	 NCFXzb0Y+EQZOqom56p7Fw30UWxO+6/jTVq/hIQis38U0V+gG4kQ3+nhfjPLdknXmU
	 jBBWzGDDiuMEwbHfiiGbSRtQ6aUt57Cn5JQmIigjFhVxIjI1WcURrlxyAywdVdBEGS
	 iCVmQDLb+BeoH3C5MdwzbYSwU0f6x065u+k0wetpG0Aupac0x4HvE0o/BZgSDdiWoh
	 OHLY259vaenkw==
Message-ID: <dec62b4d-15ce-4760-bf09-69dd541104ce@kernel.org>
Date: Wed, 23 Sep 2026 21:44:57 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: microchip: isc: Initialize DMA lock before
 requesting IRQ
To: Runyu Xiao <runyu.xiao@seu.edu.cn>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jianhao Xu <jianhao.xu@seu.edu.cn>,
 Balakrishnan Sambath <balakrishnan.s@microchip.com>
References: <20260830023228.2054498-1-runyu.xiao@seu.edu.cn>
 <77440bae-7381-451f-861d-1399bac4d925@kernel.org>
 <20260919011013.3383669-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20260919011013.3383669-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/26 04:10, Runyu Xiao wrote:
> Hi Hans and Eugen,
> 
> Thanks for taking a look at this.
> 
> On Sun, 30 Aug 2026, I wrote:
>> The ISC interrupt can run before asynchronous subdevice completion,
>> but the DMA queue lock was initialized from isc_async_complete().
>> Initialize it in each SoC probe before requesting the auto-enabled IRQ.
> 
> On Thu, 10 Sep 2026, Hans Verkuil wrote:
>> It's dubious to just init dma_queue_lock here but not
>> INIT_LIST_HEAD(&isc->dma_queue);
>>
>> I think Eugen needs to look at this as well to see if this is actually
>> a valid issue at all.
>>
>> In any case, this patch doesn't look right to me.
> 
> You're right that moving dma_queue_lock alone is not enough. The interrupt
> handler also accesses dma_queue, comp, and awb_work, which are initialized
> later from isc_async_complete(). I also need to confirm whether an interrupt
> can actually be pending at this point, and whether the required clocks and
> hardware state are ready during probe.
> 
> I have not established that yet, so I'll drop this version for now rather
> than send a v2 that only moves another initialization. Eugen, could you
> please confirm the expected reset and interrupt state during probe? If there
> is a real probe-time path, I'll revisit this with the complete ordering.

Added Balakrishnan , he can test and review your patch.

Eugen>
> Thanks,
> Runyu

