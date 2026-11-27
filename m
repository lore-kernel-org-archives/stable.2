Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800102;
	b=JOQbvjKfSuUU8uvaU1I6S7TQzMrTZeqlQReEe5J+j15GesyPhg1XoPJNNovPoUcvO5/6
	 a3MYQPalSgfECy2GKF1sxPwePxRFpsZ8sAB1SwomzhBNfcbWL6RFeaVSxD9zT5L3ZKNoS
	 XTb96mVepem3+2YL/vXO+UI32p+CS5vFu5Mp0iangJ0hXAgGSsBld6hWXZ6g7q3aelr1N
	 EMSeSPKiTvF4dhSWwFPx70AbmyDXbNRc7dCxwOr+IzwW1OPs/UHY6mUSh6FoO2t2ldgar
	 HAPGhAA7Am2d+FnFzGSzmPS8vAg15gzWADdMbuJqTVl5B5Qq1d/Cn85ipvnFdysKUMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800102;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Itd/yW7WAInpfAiWKiuZDwVnIdGsLMPm7Jq5U6tSnJk=;
	b=wK4Q6kcMFvukH/htAnRgge64FOA1r8Ct/mAue4Ys/Ni+iZ8SmVinsFDekxYeW2fH2YsJ
	 NeIpFdFaDDcJUIgMcra/zSKcmhUyJcBbgFv8gob9YW+3xXVPxXP9Rcbjq1bN6WSzChXnk
	 lZGRfp/pMW8XxZ5KqddCtDNbnowIIx12KWkQVnON/Q/oAmcKXS7yimV5eJrtlR7OyC/+T
	 nQ8AjMlaRLV5w6i4JRQA55TWDIGekj8wXaMmV/ORrBOx6/Tqs4pq4wtJJl2ycq6rcp9oT
	 won6LJbuVQWa0ctBdrM5Fhkey8Wxwr3L2kkyObEHSJO2TSxqwY61pX1dV+VKovmsLBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Gxy9LSo/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA3606A336;
	Fri, 27 Nov 2026 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gxy9LSo/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EDA1F000C1;
	Fri, 27 Nov 2026 17:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795800101;
	bh=Itd/yW7WAInpfAiWKiuZDwVnIdGsLMPm7Jq5U6tSnJk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Gxy9LSo/DBZPo2tssojtPMhJI+fQl1dqDTCMgXz5uPrjOgAie51o8QJj0ZiwhXvab
	 Mo16Vy3GsQRmHF5EAosYCIfWzD++dmC05eT990/dCtVALcAa72fbPjhJm4rlNsobD5
	 i9klkySxmQuARgvOOK6u2bW7mfRetT52eBlmyPj03Fc/4OZBpkiDifYRM6W7z9OaEt
	 dfEoXFw/PpRg0ZQSLkAscATFpTSWvbBOcqrGPuZFGaUwRND+1zpEGJsfNMhF7jB806
	 qbvsTfvQpl5bMr/12oY2ZLMrcRPELKrI7BwFnuVQfWwNe9y6zkfxomi85zXddg3++O
	 tnp6n6RWCtwnw==
Message-ID: <dcc8689e-41bc-4a18-87fc-2fa76e11eab1@kernel.org>
Date: Fri, 27 Nov 2026 17:21:35 +0000
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
Subject: Re: [PATCH 1/4] media: venus: use dma_iova_size() to check the
 reserved IOVA size
To: Jason Gunthorpe <jgg@nvidia.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Sibi Sankar
 <sibi.sankar@oss.qualcomm.com>, Honglei Huang <honghuan@amd.com>,
 prakash.gupta@oss.qualcomm.com, Alex Williamson <alex@shazbot.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115859eucas1p1ae20b01eec39080daf19dbd71aba10e9@eucas1p1.samsung.com>
 <20261127115849.2780625-2-m.szyprowski@samsung.com>
 <nohVXMHveO5nQuD8sOn0QoENkIUC-GQzMCh8HTX6v2eezbtW6OM5gX5JwJ7_MSwfWj3bC4Zmfz1CrxTDKJeFGg==@protonmail.internalid>
 <20261127142912.GK114472@nvidia.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20261127142912.GK114472@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2026 14:29, Jason Gunthorpe wrote:
> On Fri, Nov 27, 2026 at 12:58:45PM +0100, Marek Szyprowski wrote:
>> The IOVA reservation code compares dma_iova_state::__size directly with
>> the requested chunk size. __size is internal to the DMA IOVA API and may
>> carry flags in its upper bits, so use the dma_iova_size() accessor
>> instead.
> 
> WTF is this even doing?
> 
>      Fix this by reserving the 0-600MB range, below the boundary the
>      non-pixel stream cannot address, using dma_iova_try_alloc() so the
>      IOMMU-DMA core never hands that range out to a real DMA mapping. This
>      reserves only IOVA space, it does not allocate any physical memory.
> 
> That isn't what this API is for, and it isn't how it even works! It is
> pure luck that the first call to it happens to take out the lower
> address space.
> 
> We even had a long discussion about this driver and this need in
> another thread and this is the hack job you guys merged?

Have to say I wasn't aware of an objection from you, I don't think I was 
on that thread.

> And it couldn't even use the right APIs??!
> 
> Jason

It would be possible to reserve this IOVA range in DT so given what 
you've highlighted I think this and the Iris commit should be reverted 
and the DT constraint implemented.

https://lore.kernel.org/lkml/20260601041336.9497-1-daniel@quora.org/ 
[PATCH 1/2]
https://lore.kernel.org/lkml/20260601041336.9497-2-daniel@quora.org/ 
[PATCH 2/2]

Already has RB from Krzysztof so I'm happy to re-up that.

https://lore.kernel.org/r/20260614145113.84243-1-daniel@quora.org

@Vikash I know that's not ideal from your perspective and may make the 
iommu stuff you have proposed harder but, accepting this is a misuse of 
the API and "happens to work" instead of "works by design", I don't see 
much other option.

---
bod
