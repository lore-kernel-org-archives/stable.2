Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F75282F1A
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 05:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780463758; cv=none; b=VlXx+HJ4VuCMKgCixLhPbuVpKgey7HnNlpKORaFQEhd9FYcMdU/TgcQHOcQ2ktZHrhb3CMwLB4KWUONEpg6+zdhVZEiqAukEityfj8Y95oEVDcL+36gOivs3gu49fEcQ9/H6/PhuT/THyVaZIiQU7UpF54NTy5RCnQ9ClMXw3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780463758; c=relaxed/simple;
	bh=zcx/3RFVeIFY7fP/bgC4vBDlCjp+ZgKbDV62UK8AyJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1OvDJsVPdPRff1Ta34IXysvtn/TfDUU2SLyij1DUcP1g/hDRz/wEaj+jqKPnvbOMGhm+JnZIgqt1v8EZeEIlc8/cF3WWa6wvAbuGn4Bu5zXxliVg+jftWtwxPdAvcPsOLjE89elUMcK4NhpLcSjID1WOhmZ3qLOh6DD+8ZDR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W/vod6hn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W/vod6hn"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68be16c61d1so9937040a12.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 22:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780463755; x=1781068555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oSh1vcGZttDwboKfkW24ky4jzlC476U+WlQWgt0YzUw=;
        b=W/vod6hn7fSWrcl6BuWGyh+BClUPwZ5LTCjWwPHXbIsa6hSsQmnNwnytp4JHo1jU/N
         dWKDXxEJsnw+7J5RzqyD6p0PzxMbSsi5cc2LDX63o0FM+0XvntEX4z5y2LcRmIVySqVi
         LxFecgfB7kAJHiJEvaISrIzvsMUec+rCj0Bc3s4feZYNuZ0HLKUflt1aypFol2X3e4d3
         iYWWeQDHlfNp8ZHHR8nrMz9/B8Ik8JW0ANPhir6oHyZtLDhq8d7fVgJt9XR1TNCFcQOD
         74tYzn919jlXzK3eo27NKFGEFMGvI2H4CEripktGK/bHeAvYSxKpJNE7PdB4+PmFGMwp
         G1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780463755; x=1781068555;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSh1vcGZttDwboKfkW24ky4jzlC476U+WlQWgt0YzUw=;
        b=lutOygJQdgP2fhFusJ7bHRN3MCmFXzjXDDisRH06I51BDsJRs8g0V2C8mmK/rQrtUe
         DJe/BeV7fVvQ6hjqNkJ3Zy3Ep9UBzZfpwFVTG8sJLdRZZLA9oDtV2IJSfkOhrfGLVpvb
         b37rJymQc67DD0jkP2MbDbYFriirByhA6slzLUmCDGwnmB/U1Rqa/SOKVy85zaFmMDOc
         hXXWZyRyW9TlGe3BN95jOqc1xkG9Yc1QIrxdNPmT9wNpbcq6BB9cup3XmYSap0Byj4sX
         jHR2mMeSe3yb1RMarc/jsbHp5cwAACqOdEeVhl8rnLziVzglty3/YKDwv1EHoM4DAYEZ
         u1vw==
X-Forwarded-Encrypted: i=1; AFNElJ/w8vcUkwqh3DxMfErgdSvVPnciSfyGNF4SawAQVMFGF2psxA58HTBOo+rlCuPsqtx2ytWZ0b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1kVtFrCaTxxyNIGm1kFqNBrB0DptlXlr+vfVDhHr2HbtXw/0Q
	7vnv2JKKdkJKckbUCFMm9K5CBP2T8P13gmZPx7qgLwEq1wrbc79Lm0pnqQIJraUkg6LIPe0pCDc
	mPeX3
X-Gm-Gg: Acq92OGMbhAHlfB3B1qdAnFmgTKyyV9QB7V40+i0CtmBQDq1R1xIbLBntsamDffSJj5
	OBA1BqXOn64q54UKfEGlwVTHGhhjnA5BpuzFftL3U5ePoUa3hSQliHqXhCxq0wqx4zraEIw9125
	7kXSm17IgVdYZzZ/cy+c+7pWnj8IOOagsK5C4EqglGatjQjetle++zbk3thSmAluBqyhAEiDM2V
	Vy27ZVOtCvZhKhIAnuXQDX2yf1dXweYGapcTmQIlIpRCjVnVMVYmA54UVMUuu8d4ucVQJGgwC7X
	HueM+g0eeNJ0cz10YyZX6flST0f7UBqPZdGfFETmCLMtKgLw5AOfiMvVAtcJtrdUztyLZR4Q5lA
	rLtNYz+OKuIXJWvS3lbmkdN0yvtOZzn/kgo6JpN4iHDgBK3OfoIZW0kPP6mfCWK36qthD3XIJ2Y
	ntCwYgSPfYOi3Il421JAf4414ir3criZSoED/F82s6b+3zjJD3Iw5Bw8s9td3PyJlDfQRYJ8xbi
	Xskm19xVO80TrGJMTqPjAdVtD4f2LiklaSNGmOqwP5cB3fUQ48RtextgQ==
X-Received: by 2002:a17:907:9411:b0:bec:9f90:629d with SMTP id a640c23a62f3a-bf0b36a51a8mr66309666b.39.1780463755247;
        Tue, 02 Jun 2026 22:15:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1:0:2bb5:f164:6e6a:38d8? (2403-580d-fda1-0-2bb5-f164-6e6a-38d8.ip6.aussiebb.net. [2403:580d:fda1:0:2bb5:f164:6e6a:38d8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0bd337sm881138a12.29.2026.06.02.22.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 22:15:54 -0700 (PDT)
Message-ID: <e9f81e66-f113-4956-a4a0-d9c2a4596092@suse.com>
Date: Wed, 3 Jun 2026 14:45:50 +0930
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] btrfs: fix incorrect buffered IO fallback for
 append direct writes
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <cover.1780112003.git.wqu@suse.com>
 <8f3a0006edc5014c1de15b669f4d8c6d2aea3d61.1780112003.git.wqu@suse.com>
 <20260603043415.GA2114331@zen.localdomain>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20260603043415.GA2114331@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/6/3 14:04, Boris Burkov 写道:
> On Sat, May 30, 2026 at 01:04:18PM +0930, Qu Wenruo wrote:
[...]
>> The call chain looks like this:
>>
>>   btrfs_direct_write(pos=0, length=4K)
>>   |- __iomap_dio_rw()
>>   |  |- iomap_iter()
>>   |  |  |- btrfs_dio_iomap_begin()
>>   |  |     |- btrfs_get_blocks_direct_write()
>>   |  |        |- i_size_write()
>>   |  |           Which updates the isize to the write end (4K).
>>   |  |
>>   |  |- iomap_dio_iter()
>>   |  |  Failed with -EFAULT on the first page.
>>   |  |
>>   |  |- iomap_iter()
>>   |  |  |- btrfs_dio_iomap_end()
>>   |  |     Detects a short write, return -ENOTBLK
>>   |  |- if (ret == -ENOTBLK) { ret = 0;}
>>   |     Which resets the return value.
>>   |
>>   |- ret = iomap_dio_complet()
>>   |  Which returns 0.
>>   |
>>   |- btrfs_buffered_write(iocb, from);
>>      |- generic_write_checks()
>>         |- iocb->ki_pos = i_size_read()
>>            Which is still the new size (4K), other than the original
>> 	  isize 0.
>>
> 
> The explanation is very clear, so thank you for that. I agree with the
> bug and the direction of the fix.
> 
> However, I fear that there could still be a smaller bug left.
> 
> You have reasoned out a race against buffered writes, and the invalid
> i_size you are fixing up only exists inside the dio thread holding the
> inode lock, so the buffered write does not see it before you get to
> fixup i_size. However, after we set the invalid i_size we release the
> extent lock, so I believe a buffered reader could now observe the
> intermediate too-big i_size before you manage to fix it.
> 
> I believe that the consequence of this is that reader will block on the
> OE, then the split half will be finished/truncated, but the reader could
> still see the too-big i_size and get back zeroes. I am not completely sure
> if this is for sure a bug, but it does feel like it could be wrong.

Buffered read doesn't take inode lock at all, thus inode lock doesn't 
seem enough.

Although I'm not sure if it's a good idea to mix buffered read with 
direct IO in the real world.

> 
> For what it's worth, there is a comment at the i_size_write() in
> btrfs_get_blocks_direct_write() which also confirms that it is important
> that the update is done under the extent lock, not just the inode lock.

I just checked all i_size_write() calls inside btrfs, it looks like they 
are all under extent lock.

So even just for the sake of consistency we should already follow the 
existing requirement.


I'll try to explore some methods to properly update the isize.

My current idea is to keep the EXTENT_DIO_LOCKED hold until iomap_end(), 
so that we can properly update the isize inside iomap_end().
But I'm not sure if it's safe or we may have some other hidden pitfalls.

Thanks,
Qu

> 
> If it is, in fact, safe, then clarifying that in the existing comment
> and/or a new comment would be helpful, I think. The comment is from 2012:
> c3473e830074 ("Btrfs: fix dio write vs buffered read race")
> so I suspect some of the original reasoning may now be out of date..
> 
> Thanks,
> Boris
