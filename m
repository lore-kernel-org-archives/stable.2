Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795034312;
	b=lNidtEzqUcjCjel33BzJACs4/rXW2dBSS5MRaAGaAbDzrAZgvTOQbxlMJtp01kyfZerZ
	 VBsFnuKT4QVj3juSRyQ2nGNrQKtW2ysmTVpQwI1idC+pIZNXkgyiii6DTkWEmrtYKOgbD
	 PCSkGCxy2oNcmUJFOrEJ31DrDW/IqbxTLJ0sP9WfH5NE9nqF0kJ3v7Si6ywuq1E3jBoUK
	 dDmJkti+/HRoABdw5vXcf3bK+I/09U7a3d4MOUVJCrgPySXqlRbzcyETtwCTC+R0rYQn9
	 vYrf/leG1RxsREAm3d1OTOLs0wLXIeVlEI+QFbnbklII3l0ovlaMS6cRYiR8hGhEH/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=gl3uARuCLrvmOuEUSt0jl78CwT5lLVAwnYwWKnlCtjg=;
	b=p9kMyg9AjZV9zMwO7WPjdUmjbALPRI+CK/Rk8DNXVE3CJXNgj+jngZZJ3FY5+Inf/0Nh
	 5Okmk9XDt3MmqYpwGJ3g1Gu/TQuq9BCQLZF9hoL9FPzCrFRvc9oKr5J7jZaBFlLM9gogX
	 nZo2YtXDruzAo4tOJ3v1ctxPSrIX9vzG/DtloIkNceWnfgyTG0waSfmEFxlwLIOU2Ry6S
	 3/OTKH6jbOarRZhPVX7Wz0+lzC/nBhhqM4UKuhT5q8qCC/27bG30Ao1O+j1P7yXakMI6d
	 AghU+15GyS3CZjrFCONPZfYJ9BKXk8tSG021XMprOnGwgZwhgGb65fo9fMe3gIGF9yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=aMjMPqIK;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0445606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 20:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0445606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=aMjMPqIK
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so15432725e9.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795034310; x=1795639110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gl3uARuCLrvmOuEUSt0jl78CwT5lLVAwnYwWKnlCtjg=;
        b=aMjMPqIKTeoUDpBgnMIqwkeYUd0CBMu/ebiA1IObULvrIXU2b8hu0MhxRqN4vGMBe2
         6e4QpLWrODjeS8x/3VFhJV2e+/oPGqmXBLolqnoJ97EtdwZTBsJ+3vP4khGLjB9U7S1c
         ic8Sf4Ko+ZV6WOHmoSmTrXW/zlCyWfP3ygTRmYzsBAGynkOK75a8nG3jc8V1rCfQSAb+
         s3zRFpYRITW/QUa5bUD4mXjprH5yy6u8KowlmJrdBmbL5A8MT5ymTHsCzoUEYM5gzSqC
         gGc5WYxxqGGtjQklZfBz936Jdp4ZAV7QHQNn1ySvjQ1cEyXyynywM4Klj+/3HWPUYhK1
         Sypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795034310; x=1795639110;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gl3uARuCLrvmOuEUSt0jl78CwT5lLVAwnYwWKnlCtjg=;
        b=ZrT9etRUvECVH3qNgfgUq9SBumd0JI0aZK9Xo7Mv7Lc9sL25A3HCOti8NDVVL8Ye8c
         R1apyLAqzMs8FqFDycDi0F3lcYz9WYGf0eQabDWI7rZZBRL4b8MzP3HYQcI787CQMjs8
         of2Czm1BhOcnT+zwfulfRTuj/WJVRZu5IuE+HF33FULbKv78RKifwM8bY5RS+IpHHcSS
         yVj09fWiG2VUTGCTImYVdt5ItSxh/3q0u7Rj2CAyyblKiU1/G+rlZr5Rws7RJioxHyHL
         6AIKJHB+GS4bpNc+8fuAEXzKBGjkigxiHCVJHNnQ7DN/eAYLJHZRi2LQ80g4jjNC6BpC
         t7jw==
X-Forwarded-Encrypted: i=1; AL+hErGCfohN0OLzP52f3zZgmyuHeGN3xf4oMR6DCisL2cVemslPsbfIGQ21oyxhXIUIAXXky4uCj00=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SsdKjnlpVL5GRsJyD+NXE/mySJFS7iOLB9htfe0X+iz0nhXXf
	zm39UpsxOxS2LO66nb/xqLyQmaoUQd7rX6sV63WJHkk6v3UApkW1m6ygNl6iuxbwP2I=
X-Gm-Gg: AYBFou2rDls6CmmS7athvuuOEVLYaoBNed1KK2CaWcerh59RFQwgt4wUkNOrE2MiqtB
	R/LyCLkVztP8tVay9/D0YCiMIvioMSojO8t0lymN4J1Vb9d+ZFhf5G+81MUIfhpnDfVQxUJJnwI
	Pvu+/0fyjbbNw5GflAWmUaXhIwgwMEyXeFvItFjePEuTc8qtqTR9IkJAln39Eu+PrhYHt6J8fHR
	8QARa6GHYdudpPCS97dnwMEQCax5ARrkX8i8WbaLHCvOdEehBvJvRK/cGOcpGTTuRx2JPAUk2br
	4tBLNeCvCrS/JgagQXKOSdWIMVsqEeyWFsXwLV4XezdfXaB8cRJB65DFphiiP5hRTvmjhns7emX
	sWI4XYOSe4V15ViSKdse3Vh3dNLqwrZmObeBZMAleyhVH47ZW/szjsJ0I8uZ/XgkVteF3juCB5b
	sLF+SfuEKs5/1AFezhCOaXWC/5dew8zKxbwwV9XcD/VfbUShG+Dh28w0I620yHRaJL3eI+gO1Re
	Av6j3V0DUImFCXSL8ojMLeeJbFtSoT9HWKQTGYCl17eSLFTTPGrVkjaWFDjFSSquB/sSnm+aZ74
	W/bwd9QClsS4ykYqy3Hs4w==
X-Received: by 2002:a05:600c:6298:b0:4a2:397:73fd with SMTP id 5b1f17b1804b1-4bb7da1b37fmr77157215e9.12.1795034310161;
        Wed, 18 Nov 2026 12:38:30 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3f687baaasm841803a91.2.2026.11.18.12.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 12:38:29 -0800 (PST)
Message-ID: <da879d7e-7790-4507-bfbc-55a78fe20ddc@suse.com>
Date: Thu, 19 Nov 2026 07:08:22 +1030
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
Subject: Re: [PATCH v2] btrfs: fix bytes_may_use underflow after a failed tree
 block allocation
To: Vlad Poenaru <vlad.wing@gmail.com>, dsterba@suse.com,
 linux-btrfs@vger.kernel.org
Cc: mason@kernel.org, osandov@osandov.com, josef@toxicpanda.com,
 fdmanana@suse.com, boris@bur.io, quwenruo.btrfs@gmx.com,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
References: <20261118170332.992625-1-vlad.wing@gmail.com>
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
In-Reply-To: <20261118170332.992625-1-vlad.wing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/11/19 03:33, Vlad Poenaru 写道:
> When btrfs_alloc_tree_block() fails after btrfs_reserve_extent() has
> succeeded, its error path gives the block back to the block reserve,
> although the block has already left bytes_may_use. Each such failure
> leaves bytes_may_use a block short, and it underflows and warns in
> space-info.h when the global block reserve is released at unmount, or
> earlier.
> 
>    btrfs_alloc_tree_block()
>    |- btrfs_use_block_rsv()
>    |- btrfs_reserve_extent()
>    |  \- btrfs_add_reserved_bytes()  <- bytes_may_use -= blocksize
>    |- btrfs_init_new_buffer()
>    |  \- alloc_extent_buffer()       <- fails with -ENOMEM
>    |- btrfs_free_reserved_extent()   <- bytes_reserved -= blocksize
>    \- btrfs_unuse_block_rsv()        <- block rsv += blocksize again
> 
> Since commit 19d7f65f032f ("btrfs: convert the buffer_radix to an
> xarray") in 6.16, alloc_extent_buffer() can fail this way under memory
> cgroup pressure, because fs_info->buffer_tree is memcg-accounted.
> 
> Return without giving the block back once btrfs_reserve_extent() has
> succeeded.
> 
> Fixes: 67b7859e9bfa ("btrfs: handle ENOMEM in btrfs_alloc_tree_block")
> Cc: stable@vger.kernel.org # 6.16+
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> v2:
> - Shorter changelog, built around a call trace (Qu Wenruo).
> - Dropped the code comment (Boris Burkov).
> 
> The code is v1's apart from the removed comment, so v1's testing stands:
> its reproducer leaves bytes_may_use below the global reserve without the
> fix and not with it, and fstests btrfs/002, btrfs/220, generic/475 and
> generic/476 pass.
> 
> v1, with the reproducer:
> https://lore.kernel.org/all/20261113170926.1468850-1-vlad.wing@gmail.com/
>   fs/btrfs/extent-tree.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 9b0a5c6b96f3c..8d4c66bf850bc 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5433,6 +5433,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
>   	free_extent_buffer(buf);
>   out_free_reserved:
>   	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, false);
> +	return ERR_PTR(ret);
>   out_unuse:
>   	btrfs_unuse_block_rsv(fs_info, block_rsv, blocksize);
>   	return ERR_PTR(ret);

