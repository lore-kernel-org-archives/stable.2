Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662972;
	b=3CeGpGcvt/JpxEHKDDbuLXNq421TanXsALAVWhA4I75sBaYn5YIUIvbv2gOZOdJQ+Brq
	 7a10BGippnt8JLOkcPTXCZSIP6og+Bzy7/iWZtsIWjAE1VATfLtAxAx0T6ufA47TSa2iC
	 t4CGfGsa721WNcEI5SczTOLL8UChvQ8kdwjNDpe0xfTaOJEi6iZAYPVp+jl91p+nODvjt
	 gKvnxirZv9JMS7X8c7WfuPno7LuMczT77cFcEM0iqLUpW0YRRi9boiU2XBJYpnxOuYaFF
	 8aixkMxlMzWYaXVHMmZAgil/OxOTLszz6oCq/rrzCMZUPLn3TIFEx0vxl135kHt8tLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JnQy500MsWrFun+T9a78f9QVRMeORY0a/XfwWvPhYUQ=;
	b=woOxkMN88QFeBCO2z12xfd5WGzpdFRYpdBSXu2tRSJy4/6C2qtgfzweIjW7QgIhsujoS
	 ZqAdR2gnAXrSo7z2qukI981/8CLfduFkKypl68EsDbJaPcZ9mfyS/E77eTMCdlqqPw5zy
	 eDeaTqOV3kxVR0u8rtUuqO5huRvy5mN6i+S1KEP9k52x0ssTH74yo1fBJYF8Jfd1ciifg
	 19wLvzPTnh+OZyfZ5dxqlmOOZAx2OlM/TuQaEEQ3LrTrOGhDELOMmsWSthgFN/AheRnqW
	 XbUeY5T5+WfG2Zxc4hzbX4pDDg42XL4R8sM1rMktdK5m/fWMd3QVQNivtcVQM+rSn5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Nhk2wPqv;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D91606A336
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D91606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Nhk2wPqv
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so40119705e9.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 15:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793662969; x=1794267769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JnQy500MsWrFun+T9a78f9QVRMeORY0a/XfwWvPhYUQ=;
        b=Nhk2wPqvSQrkiK/roTjKBer5PwoOjEZcUOiCTWZQflUNI1lHbA/yywr5hMwC4geZRo
         /nQsIvO5rfSDbIjA77jp/JC2zJbvv6gA7lT7iyi0UpvRFcKxu2zmc8pmeIOaa2Yuj2cc
         OifvuTw2PdxQxtkAyBWPS8z91JdzqQXhQ9E1kMmGqpqvE/UFlD9QHFr4hv2uECHobPeZ
         I1I7vvMTxiKtviazNZh/URE7e2Ybhu69FANtbZEcsLCykFcM1UZ/zQVXpJAjilti3kjA
         jQaIARJ4CsBE0ndIX0ro9nlfcUzDy+jTbPh/k5WL0h8d6hMrU/QYdWarlce0ISAWWs+2
         4T1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793662969; x=1794267769;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JnQy500MsWrFun+T9a78f9QVRMeORY0a/XfwWvPhYUQ=;
        b=LmlodI4vCtFHOoKISZTx6BG5jOmNBZy61j+QmPFesxYkbMR8MDWtQSMvLx5nRIRf3S
         Tygb3l0PlYAvpOrj8e5kVVNp4slldoi+vKTyEOWfylBMHUWwG8o1W6kXBXIna0a6hrUG
         37uE5cjIKxBFZFEILdPZcDqmKv9xI8rksQ4r85vQOPX7SGgEyBjksjFWqMrss+8UpcjD
         G9eR/m/Tw8AUbIYQZsk2lv8yNgDuCClC7GT7KsJ0c3WtREnqWuUhJc2V6pCVF8240yTG
         k0/luFcm3AQVGwa8TVHmFyy+gk4vGqn4UP+e4NoqtJ0BUvIWHfsMIfixsA0DBZ3/Y7L/
         YyWA==
X-Forwarded-Encrypted: i=1; AKwUvBzrNdPq3q9M+Hj0B07qAOwVmdQWeDXAduRK7qJWyIq8IYBj/4tmNjKYy5CsXON2ULch8qvC/Hc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlFbp93BQisWZMPAma1tnxFR2iFe5LpggiVlu6ocebQIwTAOed
	D28Rh/B1MA4DLMArXiB1oLb2sOKQld9ywCBXWG1hUBa0E4Alj1Cf19NMxXmoRPmhslE=
X-Gm-Gg: AYBFou2MB9L0g9Wayl+oLm7Dm82oWOcYJvHGBwDBy+q8hH+Q6yiiD8PDuEk5sVCvrU7
	pRPc8oQ/4fSbdjOLvx5Yi3H8ISE7vea9FAa+g6VwKxDpXKhJRiyucuUo6bXRSXa+kDTpEA/U4cy
	O3BqT6IHjl+ofhrYXBFuqmCXG4PnNrLVGHDHmxuVC5dKkLd53XuIWtvtFYpdLc5oTjO0B5i0AFh
	7og5+2xsGOtdvvlG52hLTlwX0kvnmeY9bBN5oKFgKPUbqqkr2bPbgTOTu9sSU0YS9ver4/3B2yK
	C5MCurbvZExE/gM2DS9P67m33V3ge7Xj/I7QShyTIVrnWYuJpynHmuWwyjtZZNGHGZB0WmNQoaR
	TyYTXCVwQYDKcGHIzNV/9bwaaeeNN240KTPrCD6fP5zIwi71YaUQWNApF3jPvlq2eVfmeJrhvCm
	x0yBL2ObK65HR64vg+Nw3DcT+QsRfva75Gm0qnWNlEfmjra4MIF562PiNKvx5V6cAubZr9FpopO
	7i60TpOy1xkkKhEPJchTuWStgDbzPRHp4YAU6F4cp4tAEGwv5DsTHzPGQadJbRAHKl7Zd/mkiyA
	nhpFeHgfxqlOY/bejgRU
X-Received: by 2002:a05:600c:3b09:b0:4b1:4017:c4f4 with SMTP id 5b1f17b1804b1-4b14017c507mr86691865e9.20.1793662969331;
        Mon, 02 Nov 2026 15:42:49 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6eabbsm41517207eec.24.2026.11.02.15.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 15:42:48 -0800 (PST)
Message-ID: <a12db355-d677-4656-9715-a537980e928a@suse.com>
Date: Tue, 3 Nov 2026 10:12:42 +1030
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
Subject: Re: [PATCH] btrfs: do not check support for an invalid sectorsize
To: Siddharth Mishra <smish149@asu.edu>, David Sterba <dsterba@suse.com>
Cc: Chris Mason <mason@kernel.org>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, Siddharth Mishra <brightprogrammer@asu.edu>,
 stable@vger.kernel.org
References: <20261102233041.310900-1-smish149@asu.edu>
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
In-Reply-To: <20261102233041.310900-1-smish149@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/11/3 10:00, Siddharth Mishra 写道:
> From: Siddharth Mishra <brightprogrammer@asu.edu>
> 
> [BUG]
> Mounting an image whose super block has an invalid sectorsize (for
> example 4097) on a kernel with CONFIG_BTRFS_ASSERT=y triggers a BUG:
> 
>    BTRFS error (device loop0): invalid sectorsize 4097
>    assertion failed: is_power_of_2(blocksize) &&
>    blocksize >= BTRFS_MIN_BLOCKSIZE && blocksize <= BTRFS_MAX_BLOCKSIZE,
>    in fs/btrfs/fs.c:137
>    kernel BUG at fs/btrfs/fs.c:137!
>    Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>    RIP: 0010:btrfs_supported_blocksize.cold (fs/btrfs/fs.c:137)
>    Call Trace:
>     btrfs_validate_super (fs/btrfs/disk-io.c:2525)
>     open_ctree (fs/btrfs/disk-io.c:3507)
>     btrfs_get_tree.cold (fs/btrfs/super.c:2133)
>     vfs_get_tree (fs/super.c:1943)
>     fc_mount (fs/namespace.c:1282)
>     path_mount (fs/namespace.c:4337)
>     __x64_sys_mount (fs/namespace.c:4542)
> 
> [CAUSE]
> btrfs_validate_super() rejects the sectorsize because it is not a power
> of 2, but it does not stop there: it goes on to report all invalid
> fields.  The next check passes the same sectorsize to
> btrfs_supported_blocksize(), which requires a validated value and
> asserts it since commit d728f2e5f8a0 ("btrfs: simplify support block
> size check").
> 
> [FIX]
> Only check whether a sectorsize is supported after it passed the
> validity check.  An invalid sectorsize is still rejected with -EINVAL,
> and the misleading second message "sectorsize 4097 not yet supported"
> is no longer printed.
> 
> This bug was found by fuzzing. The cause was analysed and the fix was
> written with the help of an AI tool. Tested on btrfs for-next
> (d6f76ca0a70d) and on v7.4-rc1, with KASAN and CONFIG_BTRFS_ASSERT=y:
> without the fix, mounting the image hits the BUG above; with the fix,
> the mount fails with -EINVAL and only "invalid sectorsize 4097" is
> printed.
> A crafted image (22 KiB, xz) and a C reproducer are available on request.
> 
> Fixes: d728f2e5f8a0 ("btrfs: simplify support block size check")
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Siddharth Mishra <brightprogrammer@asu.edu>
> ---
>   fs/btrfs/disk-io.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 8e8fb942d..b348591f8 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2520,9 +2520,7 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
>   		     sectorsize > BTRFS_MAX_METADATA_BLOCKSIZE)) {
>   		btrfs_err(fs_info, "invalid sectorsize %u", sectorsize);
>   		ret = -EINVAL;
> -	}
> -
> -	if (unlikely(!btrfs_supported_blocksize(sectorsize))) {
> +	} else if (unlikely(!btrfs_supported_blocksize(sectorsize))) {

If you want to change this, you should touch all callsites.
Not only this one, but every unlikely() branch to return immediately.

I do not like the ad-hoc fix just be cause you can trigger an ASSERT().
>   		btrfs_err(fs_info,
>   			"sectorsize %u not yet supported for page size %lu",
>   			sectorsize, PAGE_SIZE);
> 
> base-commit: d6f76ca0a70d0c814731394a625ff0dc1feb390e

