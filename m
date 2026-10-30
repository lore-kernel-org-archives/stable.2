Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394229;
	b=IMpSpaU87SXI6slm5HzKHHEZMnXzM4B9F59BIm2yGkcz/BvgKAqBvIT0E23cCogleE6c
	 pZvhSExtxqUkJ6v1kjptwaZhY0suCnev94fV/jlP3KVc2KvJWgUOpEis8ckMHDDLwGSrs
	 L6X06ncUHQf9M5ulvBr0uDch60Su03drGTUF0KBCTtfy4P9DxxMIkfGn7XfR0dshuv92F
	 +imP0s8ruHE1SbFz7LFNGFXWYdumT/Y5bpKYkZsSSIOHPWfJsvqfOnE00s1jf3SMDoG20
	 UOkICctXiSoYzFRm3VpAFWR4/q5y6CEHvlFfPEgovVjgRlMzV4muU8bPZ69uLDsmy/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MxI6kIjG4UY4nZOd3/y/oB30lotTLtKeu71+k5vRuRs=;
	b=bxmIbeL3CyxQlfMyud84K+LV9exNbYwAQYeLMrg6QsoesRVUooJAxwmijETXVCJ4xpYW
	 4EHfRv89hxQW2OAmEdmVZQyjt+E8+kDAQQBI/+mFmUvpmBL8dtjCQazppsbkt8K9H6OuE
	 mOzEqdPFG2n0iucGG2KpNWAbL1JoBV3TWuhjWRBx21YP6mUz33ryP8GRSkIPIuZh/g+tX
	 OZlwLNUBLD/LgI00Pv8BPbSvW5fOv7ZT4WoMBTx0LT0seMtYuhuZLBaqBMOkaTGZdkfnK
	 HHpLPq3MREl1MmdfZ7EeDO6neA496nmaFNa6QfFdzJDyxGmT7HEIJPJoGdajg2dCslw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="Mmc/pkPL";
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4E9606A331
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 21:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD4E9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Mmc/pkPL
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c49c32650adso146938366b.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793394227; x=1793999027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MxI6kIjG4UY4nZOd3/y/oB30lotTLtKeu71+k5vRuRs=;
        b=Mmc/pkPL9keqqwSl+8sH9VqGmrfnkO68L1FwnZohSCpWidqUXMskW/TkOJuiUwPXZ/
         YZwO2OrpBuWAs+/NH2ufaNfUwE8eZgI9l+7LiE/9k4vu04635NtkjbmdZ1jOt308/uGh
         QMSR59QDGWScoLFCB4f0cHs5kILmdXnJOCAEHWgxwX8TC0RmknaDL9pc2jyhMPnJ6Cbn
         xvGsEP0xAJZcyGliI0wn4AhKVLoXiWw38DbP3UiLPQxhU8qCIatusBH59G+1kgRW/Y4O
         jyghO0UFPwy17EaxoYhv7MY0769A7byRryDhvf3viVODPSl4EcmXrvKfDu3aeTojfe3E
         CZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394227; x=1793999027;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MxI6kIjG4UY4nZOd3/y/oB30lotTLtKeu71+k5vRuRs=;
        b=vTzyfl/eOXe9411N6cYSWHZiQkGTA/c7fiX6OgITaTzftwLs+nZ/s+nv3wj/lmhaMF
         uZJrCpwpveVENCayFDlVFdurviZ3+04AC3LUFRhN2JuYFE6QkC5uvq//rF9wnukF9Lcl
         m7bhiPzXok+ydBOdMq1aU9UjCZY6L5RkeNrnyH87BzHYAMpZGlszR0JO0eL86XlilQwc
         blgz/4DbZXdkB/bWYbYogvBPuB+ROdm62uZiCZecrNsc9+tjGb9aK/W+COkFocIVolh5
         6XTtly6P5K+RV6mF8YsAZ1oTzvs/OGz74m/LRmyZm33WwipW0aondylWNKPCiAIXEoND
         lC8g==
X-Forwarded-Encrypted: i=1; AKwUvBzYUKNi7NFrwFHruMtHEHloETE+mcuZ4aKMGt+92Eu9eGPoS+J3FImIqu+HJpHz5kQNGUeyq2Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAcnZc+gIIMrR1ZT7rOoZ+ggNn+N8uDgZC0SPAae25bjAMgy60
	Tlk8H5rcbn/SbQgG3W9nBUgzflEufJtBCwNY4GKGRNQjpKvyqmM2zxeyMT6jZKuF3t8p8gnOgld
	2FqscxNqUUQ==
X-Gm-Gg: AYBFou3hdvDPzjpstgKOurU1GbalhxmnUNlLH7c2w2Pmroc6geK7VGNy5ZTSlx2sgEC
	yZ3oLHNOKseHCUKB04x6b3yrpQAR8pndHBva7kbHSmXCcZ21YFdouvO5a6R/prIn+qc+bFx09E0
	2ioLqdChEXUVeQqY4bI8Y6s2HI4Yk5vS77pwSGxwlfFXjTcTx9yArH8Kl82DKWvWggTfHv27alX
	7Dp8zTcEvZSu0noKK7n7sy48FfZfONuyWPL8Ec15wsG8yI4sbI8iWDaNsgLkXx14tPa5kH7JMjM
	96K9qKTyWm3Wl9UnzIYeL0O8l2w2B7EUeTGwWQCNsaYplsK9OmcjAkoulgtahWKsuLTn2TiuVzw
	lltexZ9qhYMPlQ5VOwqRaoktLEDd4JsZbxbFXbCEvlD3Kpfh0edQcanoquTk0dd8eKqyG8dNJns
	2Kvc86/DqrsCJmNwMe69IZ4yAEMCLHHpjiXPPrKFRLBiRh7YNPyjwp7I/ZWe8KxnY+lhUME6C1M
	pjfBqH/+34ckSCMgeRijrdZbKEz3RMUjrAPvLNnH+fYtWWjzWb4/Juo7EvScRriZ73Z+ayUWUYJ
	ldl8V6WcpqwvWZ2FwHHi7XC9cnpcu4cAXacMLv5STOc=
X-Received: by 2002:a17:907:a88e:b0:c3f:153a:8663 with SMTP id a640c23a62f3a-c4ca7b20cdcmr346484166b.23.1793394227163;
        Fri, 30 Oct 2026 14:03:47 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad963d6acsm403153b3a.18.2026.10.30.14.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:03:46 -0700 (PDT)
Message-ID: <fab0bfc4-3c20-4058-8b39-585b14152f6e@suse.com>
Date: Sat, 31 Oct 2026 07:33:38 +1030
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
Subject: Re: [PATCH 1/5] btrfs: don't drop the error of the last split bio
To: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Boris Burkov
 <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261030-b4-btrfs-data-integrity-v1-0-f4d4196731e6@toxicpanda.com>
 <20261030-b4-btrfs-data-integrity-v1-1-f4d4196731e6@toxicpanda.com>
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
In-Reply-To: <20261030-b4-btrfs-data-integrity-v1-1-f4d4196731e6@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/31 01:08, Josef Bacik 写道:
> When a btrfs_bio had to be split, btrfs_bio_end_io() saves the first error
> of any of its parts in the status field of the original btrfs_bio. The
> part that completes last is supposed to load it into bi_status of the
> original bio before calling the end_io handler, but that is only done if
> that last part was successful:
> 
> 	if (atomic_dec_and_test(&bbio->pending_ios)) {
> 		/* Load split bio's error which might be set above. */
> 		if (status == BLK_STS_OK)
> 			bbio->bio.bi_status = READ_ONCE(bbio->status);
> 
> If the last part failed, the assumption is that bi_status was set at the
> top of the function. That is true if the last part is what is left of the
> original bio. If it is a split bio, the assignment was done to the split
> bio, which was freed right after. If the original bio has completed before
> without an error, its bi_status is BLK_STS_OK and stays like that:
> 
>    original bio (tail)                 split bio (head)
> 
>    btrfs_bio_end_io(orig, OK)
>      orig->bio.bi_status = OK
>      pending_ios 2 -> 1
>                                        btrfs_bio_end_io(split, IOERR)
>                                          split->bio.bi_status = IOERR
>                                          bio_put(split)
>                                          cmpxchg(&orig->status, OK, IOERR)
>                                          pending_ios 1 -> 0
>                                          orig->end_io(), bi_status is OK
> 
> The end_io handler covers the whole range, so for a buffered read all the
> folios are marked uptodate, including the ones that were never filled, and
> read(2) returns their content instead of -EIO. For a write the ordered
> extent is completed as if all the data had reached the device.
> 
> This can be reproduced with raid0 data on two devices, one of them slower
> than the other and with a bad block, by reading a file whose last stripe
> is on the fast device.
> 
> The saved status has the first error of all the parts, or BLK_STS_OK if
> there was none, so always use it.
> 
> Fixes: d48e1dea3931 ("btrfs: fix error propagation of split bios")
> CC: stable@vger.kernel.org # 6.12+
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/bio.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 2c6234f6182f..fc0b021cdefb 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -127,9 +127,12 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>   		cmpxchg(&bbio->status, BLK_STS_OK, status);
>   
>   	if (atomic_dec_and_test(&bbio->pending_ios)) {
> -		/* Load split bio's error which might be set above. */
> -		if (status == BLK_STS_OK)
> -			bbio->bio.bi_status = READ_ONCE(bbio->status);
> +		/*
> +		 * Load the first error, if any. It may come from a split bio,
> +		 * including the one we were called for, in which case nothing
> +		 * stored it in the original bio yet.
> +		 */
> +		bbio->bio.bi_status = READ_ONCE(bbio->status);
>   
>   		if (bbio_has_ordered_extent(bbio)) {
>   			struct btrfs_ordered_extent *ordered = bbio->ordered;
> 

