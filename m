Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394174;
	b=JHo+LIvx7boymuPUNiRvVVsTsviASHJX36QBXIry5Hb2wccfWdS3E3XaqB3xiiwM/Cay
	 qPm1g2If2wO4bnd0YHUS31SlAVn3hgp5oEeB45He2CwxfMc5d1ujywB0Z8MdTyNNT+Oha
	 DpWdalwofZGznJeLtL/EoGfT2s2Gqe63Qlti2kV12xrohAB87+VNX2L5n4iHFeT63KEIV
	 3uoTW71Y8KxnJ4aJcut+X0nAwAmQhPgCKxgNRe8wb74e/7KVpowYv2AtRBTTa0myy7oxv
	 qHc6+pGYZXnVGM29rexqA5BFLW065sjk3QvFlMgzRC0ZbdRie988HCPauTIkQ3zlzsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iHHhsndpKzFs7xmvr7h0NuvDfxvFUZq9HuUCucdH8zI=;
	b=eN4PlJ33Vfc3z2ORoWh4AJqc23i1TBMeZgsKGZkSnzofpzi2v9VnNfZRvo4Ixo6Z+f9Y
	 09JojrziYC/6NKwQjPM80Nproawn1CTKLT1D+TM0i2OTUMb9sXG0Is/+5M4r5GIXtNhcN
	 3OjGd44Y5dFuNDBi/4H0jDjVPVysb9yE5cFfxPLL176Fhep1OwHSmmPD7RvLEtyKStHtP
	 t1MaJAdCXkM87/h6ot7B38PqhCtsAFqBtGLUhsnb4omQ2tY7N8KArd+fpjGC4rW6POo/k
	 Eq/me2fpOF2gPA1M+BqULoXgtAIUNbIWzWDIwOpON49xJnteX54nbeYSS2zxDhqBjbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=HjnNo8kD;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF94606A326
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 21:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF94606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=HjnNo8kD
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so12247065e9.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793394172; x=1793998972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHHhsndpKzFs7xmvr7h0NuvDfxvFUZq9HuUCucdH8zI=;
        b=HjnNo8kDn6NYBnxQARp1eI3X++lbm8+9b/7DNp8FOuEQZNupDhfLjtn3TA3O09Nb6/
         pTsMNmnvYWyj5kYN1t1mt/nHvHE2xM8c4d33t50bbKW1HFmPI4x4zx80Rf3hRZds3MII
         2tNlufIEzOIvT94LcB/sETp5GMdThEITBwt5wBKFxv7lN06xiqWNrBtirZC0vItG2TmJ
         KEvpLLv4LKgbV4OtBdPU6WuMZ1cgfzgWH+vT/vaGD2nAWmjefIfEpFakM2y8XIQM9gJm
         O75lVwR1la86hYEmIVoZcYYRfeWGAhB0bLEClfKGufYdCwOJX08uh1SLrOdzscsQ8gMC
         LjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394172; x=1793998972;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHHhsndpKzFs7xmvr7h0NuvDfxvFUZq9HuUCucdH8zI=;
        b=dB0UlxtvjZ8KJPuY0w0rFEcvyXrmg+HmBdGduM/PH1EpJC+KP5AGudHky10+YWkdld
         oPNdviI0hXBD8oPzP8En1XM+QCD1Awsz6iRvBJLdhC1Go9+yTUiXuyFNYiYvt4dhuoXK
         MhCJ7NNcbc+qi0y5VdEcRuAGQT/q75TmJZIp/cuqscOFWHrsYfDWfn/78PlTah9N8uNj
         tQqhIjCckSoaR3qmPnL5AtFgFcOKG6UxFV59oo5vgtgEwROY5Kk5dUM8c+xmpcShrL+D
         pwi/VTAi4DDM91jjQm1mp4wxLMjGdrIeom11tTKyPSbULpAwdk7yRZ6mrckh7WIretv8
         ewLw==
X-Forwarded-Encrypted: i=1; AKwUvBxwpP7Tv/09L/jTjczYg5128LjMdSX9HPNPNkbOvrNBAraOuTvQf6VUOT5cJhPQPWrr4TXdnU8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKg67XjgBZHeLMEG3ACoyZI9EFQe5IMKbVH/rZeINBZzt1+YID6
	Jeo7MGCvFOoeqMbaRsk+ZaZBimIsxsqXVqwwUGRbcgPp882uUITRlDosiF5rOp9TezY=
X-Gm-Gg: AYBFou2py1pPjO8xPRkr5Qh85Unn4550FAWHAQxrn4ydBlAtPX/nn+OPqjXePy8VCZS
	YMSbpoQDWyx41E8MmIfzu90AvkoWOQywBvNn4/yXrL/us9BNVaggR57HaYkGR9isVSXU/9XE0M+
	ONSI94WwQLKwVnNT8Fgs/NpvaQbMVzDOncqUeav1/swmbjM1RWewl19R9RXkThNAc1z/bNLd8QZ
	UEVvyqZ+6ehmMUCJkMlSqmhhTj0J1300EJ4h8rdTCq/gy9qTsyk/MV4gSAJRSINFkjgaKL7hV5M
	2/rcz+fm3hdF/o00tVlLvULxtA1PbBuvMpvLehlqd1Niui1yJyvdUUba4svMUZgpuDMsoQALAmb
	Ogd/JVqFsi9p5xA9G4tq1EKtyqCzXYZsGtrE9Fft4QGHm9DTlCj7XAZEkzMCeCOuvlD99IfKc12
	6EiYikAAuyv+KblKcbnNoz3/epyNTZwBIHl1RO9miQ3hnH5gp2YYpRishQNoEM4PoeWGdk/yao0
	xZRNyu0fOyYiPHkTlxWVLLpn1sK88ZlGhQYhrz19JX+dvuhr9tH23AVJvfAPpNvfqwwqqBVAjsL
	n+mGMUsphSBvg96sonyyQSQ6rEBYptg/eWkEdsn/AE8=
X-Received: by 2002:a05:600c:a012:b0:4a2:150f:1609 with SMTP id 5b1f17b1804b1-4ac17b2cdffmr74446405e9.8.1793394172354;
        Fri, 30 Oct 2026 14:02:52 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm5275057a91.6.2026.10.30.14.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:02:51 -0700 (PDT)
Message-ID: <09771899-6a3f-462f-bba6-9243415efefb@suse.com>
Date: Sat, 31 Oct 2026 07:32:45 +1030
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
Subject: Re: [PATCH 5/5] btrfs: don't trim the target of a device replace
To: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Boris Burkov
 <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261030-b4-btrfs-data-integrity-v1-0-f4d4196731e6@toxicpanda.com>
 <20261030-b4-btrfs-data-integrity-v1-5-f4d4196731e6@toxicpanda.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ujyBQkUpLw5AAoJEMI9kfOh
 Jf6o8OIH/0mqW+TQM4m2x3hCsnK+oB4yJH1qnGvIhFF/Lhs48wI02sGh6/4aA0hkCDfd9LHQ
 +ci4FUepZ9y4VS01+oIExbg/8ytzGYTzLtb44jK2GBOBVSJkMiha6jp22XFt7WUkT/tvbreu
 WWdGsaJIRQaZChy7xsMI8lqQ2WdmluZJ4LT0wD3l/l6QU1ZseMGySebdY9sVOQEOJNV7Qj92
 /KOAFNmeZshV/qDI8Iw1RTs6TvLqCcqmlZLCmJkYSVhT1RonWRren8xIRcFEgMe004IDnt7V
 qdQhk/nhTS9x9MBAhMRl0TTE1VKDLvVALsud3iZLrmmtYvwPApzGJk052f0m28vOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ukKBQkUzDspAAoJEMI9kfOhJf6o
 SNsH/1ysUWOKmzY0rGS3ZdS61QgqMGhSWD/EJ4UiPw+xO4l4+GtX0fOAqxqsmBKqje3vyhBa
 Z5o/1Y+gNiN+E6RBcSz4b1TAd78sQ2bvT5DWOvBjeeVxHdiuQMIn4S8xk5ZpySBw5ifjoiuL
 0M33UVtJOzM8yfAeL+d/Rp4leJw72SutjkLyZTG/gJIp4pJGD/kFHn24OLL0IxEcO0gOekNZ
 os5e1R6jAJ2ILk7+MDnvU8wXHcCiVzuDhJLI1tih1uUIE50muHQJWbYuVBbdJeu8WlIDDssx
 UOCxLylNG3gDXV5MhLubPTOpp9OiFc/XC37nvkgEcrlmlOFBv4/NJCbECpo=
In-Reply-To: <20261030-b4-btrfs-data-integrity-v1-5-f4d4196731e6@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/31 01:08, Josef Bacik 写道:
> FITRIM also discards the space of every device that is not allocated to a
> chunk. btrfs_trim_free_extents() goes over fs_devices->devices and, for
> each device that is writeable, discards the ranges that have neither
> CHUNK_ALLOCATED nor CHUNK_TRIMMED set in device->alloc_state.
> 
> The target device of a running replace operation is on that list and it is
> writeable. But its alloc_state is empty. The allocated ranges of the
> source device are only copied to it by btrfs_set_target_alloc_state(),
> when the replace finishes. Until then the whole device looks unallocated,
> so an fstrim discards everything that was copied to it so far, and what is
> being written to it in parallel to the source device.
> 
> The replace finishes without any error and the source device is dropped.
> With a single device filesystem, 700M of data and fstrim called in a loop
> while the replace runs:
> 
>    BTRFS info: dev_replace from /dev/vdb (devid 1) to /dev/vdc finished
>    BTRFS error: bad tree block start, mirror 1 want 30638080 have 0
>    BTRFS error: bad tree block start, mirror 2 want 30638080 have 0
>    BTRFS info: scrub: not finished on devid 1 with status: -5
> 
> Skip the target device. The flag is cleared with the device list mutex
> held, after the alloc_state was set up, and the trimming code holds that
> mutex while it works on a device.
> 
> Fixes: 499f377f49f0 ("btrfs: iterate over unused chunk space in FITRIM")
> CC: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent-tree.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 9b0a5c6b96f3..22155507f905 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6641,6 +6641,14 @@ static int btrfs_trim_free_extents_throttle(struct btrfs_device *device,
>   	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) || !device->bdev)
>   		return 0;
>   
> +	/*
> +	 * The target of a running device replace has nothing in its alloc_state
> +	 * until the replace finishes, all of it would look unallocated and we
> +	 * would discard what was already copied to it.
> +	 */
> +	if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
> +		return 0;
> +
>   	/* Discard not supported = nothing to do. */
>   	if (!bdev_max_discard_sectors(device->bdev))
>   		return 0;
> 

