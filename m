Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655838;
	b=5PGKyjGDtq/VAmQo1DQjGF4mvbChBdwFF6eTXeFx7YCtykstVK1UX5lSookRZzHgtSiA
	 m9/9FN0sbHJqlYgU5g4+wTUarPbwZT07Abb6DEHTgyle5FJA/lq/EWih6GydPJTMS0FXI
	 u/ySXry5409zav/UNo3NMZRtrD5RZK7IkR1Pz15lPwVcwWEou9hKx1mKjPd3hTdEXMBz5
	 TwYTzFciOigHJM1pDfgv3TmMiC07PpG9eMsG3mjsoBtgSmiMRPCJD3fVTNqdfb15tvXaI
	 9cc8NhdNgJdZIzy562IkmGA0amkZF52QFVIUmk/CYSf0keHayAJjp8OBGjLBf2VTdIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8vhDEbyn1nkYBGZ2jl97YuxcDAz2vqULbU/VOeX9XGM=;
	b=JAZ++TO/Q48AYlIEs4ce1wi7ioAOeGBpy0/sbsIRRIwKv90brEuThKYVIVnhWt8muOa8
	 FTMm54QisJK1OwsdGOSG75wvG2lJA2DLw9SbmljxKRCppoBLTTs0KeA1a/W8e0Vk1442d
	 72DXHm0L61LIM5eWVVrDxSWhaX7WPONtstZp8Xl7FrTq+KeG+8XRYn0dT5meoDSXDI1Kr
	 6X8YTlRAwJh9NZo7MX7/fXHQWJVXPYKvyQKIklMt1oy4BlGzPaVRl+vp1QtKtV3+z+GDX
	 6K9jykzInBOhhqrV3ZSH5AFr7Hkp54fPpuxfG30g8ekbo1ZNzYpLdrxMUuwiy4ptS+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EuPcaFp9;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE43606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AE43606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EuPcaFp9
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c50933bdf4bso1226830366b.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795655836; x=1796260636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8vhDEbyn1nkYBGZ2jl97YuxcDAz2vqULbU/VOeX9XGM=;
        b=EuPcaFp9BXac6sMmb6amC/sR4AV3C810SzQPpUadP/CfYhNJy95HQsqugEQEF2j6X/
         hM9gfQzFVGfyzTwTLXpS2VwXeFVoKiz7QXps9mnzKN+jSK5XrUvLQErzOEBZ/SYP2uOX
         G3j4mAXF0nUzjlVKJrVvXV4JEl/A8e1PcamDXVPTTvUeHC0JpBHWGUBCwXPrnQmH3n3p
         j0y3yd0wXW/9fQJQariK7blt2FBn1GiGFGUIhMW3zwY7qsr1Xop+Y6wgHYs4DkmRt0ZT
         XHk6U65FBDhQo8yOok+iVuRTpH227Jp94oddWifomkp13/RdmxXbFcExrnj0funb7Zmj
         OQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795655836; x=1796260636;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8vhDEbyn1nkYBGZ2jl97YuxcDAz2vqULbU/VOeX9XGM=;
        b=YFMqCmcANGDxLJlP4dL0Kfb0ImsZYe/K0c9HQd5/swe5Ey74kzzeMjIqxBb1xMKMzZ
         Jh+UfaOxLw7DgmV8wI0gfC216tJygnnDeO5JZstMHfRjuFnAav1HpP8NJjJFM7ZxqDeQ
         nm+W1xivq+dFL5fNwUYclEWXjUFdniNQcS3Gy/0qQmSl4y1u35jdj2JZOOrZM1JKf99L
         MafEpZPrJ/HFu0HwwJ6v+hufJiCrgYBAHAPqbBAOZRgkt6mQ5SirgJYiBX4/jC38Fite
         j2kGA4UvYVo/5d4YRcl27CFzoGXX1wcQ1JJaqKiv8pkRdpKjX7tQzYUXUIOqnvX8i1N6
         MPAg==
X-Forwarded-Encrypted: i=1; AL+hErG7DxJ4sG2MKGz6jVWnwsrrItiya8XaUe/R8JM6tKpFUqkC/1bp65t5KamP+Ld/yu84JPm4QGk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9H9YAL+mOP+gmlU8D8WgvgVbQ69r9uEMQYnMm8tGUvkpLAS2Um
	AWcblL+0WVLJ8radJ163en0yWXl9gSJCj3aGqbT62bgw0w50MUAQUo/x5wWdolZjZo4=
X-Gm-Gg: AZFdTZeEA8wIJzTS6ZIgEku3g/Fh01/180jpkDSAIhIAOFZjILvFLKvNyZUJDjo8kGS
	7P7jbFC9wbjO0JY9P72AZop612ezmmPX4jD2kcwu1YDN0TQB+Q56KzXWQYu2JBfCkWcEKLKP64+
	rTeABrR5HTNUmz2R8Dapoagen3kskHCq6vgHtfZhx+5VJBjF2pXvjOpqLcfGCiAEtY3yYs0P3mo
	jXq9MWiczZoCOJ/qzs1h/IKdwU/ORe03Plum+rMK9wN3PBRc6uFfo4x+ccIKi/FJzv4hnlKwBQZ
	b+KxzQXR/s2zxkC10kSfXD2QPQAhI0+BVwyQ5gedEk7tOvcVK+FvuV17MntGxA5iS5Td9k0+yqm
	1oL7MHaE0ddodKHTLlz1DtAmdaI//9QzdF6FuXoD+a1lExloEeI0Oo2wLlKnYB5Q/mZhpJJAwiJ
	//8DC97rVIBUu7fgOW83F939Bho0H4NI0qyNyp5SH2+Lz5t34ZqLWcWEEDpf+VhGOxWgHMg/Ukr
	MoURqYxJ77R3+n0Zp7Yr/iyiGJ8Jp+u406eF8WJmEouN+AhKjfJ3IbvjT7YGf9cOWkbfRysSiwv
	uA8hFti+HyfpsOFXwqjjnaK1z26g8n/LgeohZZODLm0=
X-Received: by 2002:a17:906:730a:b0:c2e:1b6b:8b19 with SMTP id a640c23a62f3a-c51319443e5mr1859065766b.23.1795655835781;
        Wed, 25 Nov 2026 17:17:15 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cff4c1asm9716494a12.15.2026.11.25.17.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 17:17:13 -0800 (PST)
Message-ID: <03dd7e64-2357-4e8a-9383-d748b4883efa@suse.com>
Date: Thu, 26 Nov 2026 11:47:02 +1030
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
Subject: Re: [PATCH v2] btrfs: tree-checker: verify tree_block_info bounds in
 check_extent_item()
To: Elkin Cruz <elkin@google.com>, David Sterba <dsterba@suse.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <mason@kernel.org>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, irogers@google.com,
 stable@vger.kernel.org
References: <20261126004332.1712403-1-elkin@google.com>
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
In-Reply-To: <20261126004332.1712403-1-elkin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/11/26 11:13, Elkin Cruz 写道:
> check_extent_item() only verifies item_size >= sizeof(*ei) before
> reading struct btrfs_tree_block_info on non-skinny tree block extent
> items (BTRFS_EXTENT_ITEM_KEY with BTRFS_EXTENT_FLAG_TREE_BLOCK). A
> crafted filesystem image with 24 <= item_size < 42 causes
> btrfs_tree_block_level() to read past the item and potentially past the
> extent buffer's populated folios.
> 
> Verify ptr + sizeof(*info) <= end before accessing
> btrfs_tree_block_info, matching the inline ref bounds checks below.
> 
> Fixes: f82d1c7ca8ae ("btrfs: tree-checker: Add EXTENT_ITEM and METADATA_ITEM check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Elkin Cruz <elkin@google.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Will push to for-next soon.

Thanks,
Qu

> ---
> 
> Changes in v2:
> - Use (ptr + sizeof(*info) > end) with matching extent_err() format to
>    follow the existing pattern in check_extent_item(), thanks to Qu
>    Wenruo for the review.
> 
> v1: https://lore.kernel.org/r/20261125221849.1424464-1-elkin@google.com
> 
> I am trying out new Clang static analysis checks for kernel bug
> classes, and they flagged this code as possibly buggy. The findings
> were triaged/fixed and commit descriptions were drafted with help of AI,
> then checked against linux-next (not runtime-tested on hardware).
> 
> Thanks,
> Elkin
> 
>   fs/btrfs/tree-checker.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index d2bf21c7b848..40f2355cbb1d 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1665,6 +1665,12 @@ static int check_extent_item(struct extent_buffer *leaf,
>   	if (is_tree_block && key->type != BTRFS_METADATA_ITEM_KEY) {
>   		struct btrfs_tree_block_info *info;
>   
> +		if (unlikely(ptr + sizeof(*info) > end)) {
> +			extent_err(leaf, slot,
> +				   "tree block info overflows extent item, ptr %lu info size %zu end %lu",
> +				   ptr, sizeof(*info), end);
> +			return -EUCLEAN;
> +		}
>   		info = (struct btrfs_tree_block_info *)ptr;
>   		if (unlikely(btrfs_tree_block_level(leaf, info) >= BTRFS_MAX_LEVEL)) {
>   			extent_err(leaf, slot,

