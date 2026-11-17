Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915984;
	b=AW6+PssM2avczHbzG8O6DmpLyWJXQHQO+DSA3+eVK4p+QFL+Ju2CRACi0hDbbs7UziUJ
	 pzvUAdgy4L16QSnX1RHiQ0WH1/rr25llBUMwX33mcTULT1X/FgjQETux3vp0hYGqyKiiu
	 gCMWQ+6GS0KOPBk7L5jIgKL46g/GKVvIy9yBdIbyh26yv2rt9d0kD+DVuSZRiNvDTsqkC
	 SG6bHVnSXabWNtYFkGUsaij/zbsdmOx29Qg5NJq7m/Xxd6tu+GpcBQwNEQjdpth1re9yK
	 UqB4O82X7U4iQzlenKSs04ZKveACaESv5CAkWAZoVfEKcgc/UdawWiNiCWMn+jJibBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915984;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=HQTopMIqCY4zPfhDGuHy1seuNrCTYX4bZ5zOK/2bo2Y=;
	b=g1BRZv403KP0tZjFvIF3xkBAKQC1CEknJlNec0qYnK0OIRunpBzC8UwbEJeaarCQjQWR
	 4/A4jWxcl5Jp69SeGRMeIKtDqmU0Fgdr9pWkcHjriLRHp4K1okTTQWlngxVg2F41V94Gh
	 HvxoYBzyK3w6aii8BuCj2nDjc8xVvEW2ZJVQMTZgygbalvHFge4C6+YF9JmcY4yFlmEWh
	 uF2Ny/SEKDQMv0Vn+yL9BhSu3QlqP+CVZ+z9dH5iNMwnC0hmx7OExw3UgFq0GV0Zjm9tC
	 1mZwPiFcbNKbohaDxNRwVK2+m/ir25ABIQSQ5u2wgs28V3tT6ZsMN+exfS+fn+Yqcqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djNmh7oW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2D9606A323;
	Tue, 17 Nov 2026 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djNmh7oW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABE41F000C6;
	Tue, 17 Nov 2026 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794915983;
	bh=HQTopMIqCY4zPfhDGuHy1seuNrCTYX4bZ5zOK/2bo2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=djNmh7oWaxGzZVHGeZYxIIyMfqlhZ3PZOdsThjCapg1qskB1qmc5uvQ2xEAjnlLg1
	 I2QTTqW+hwgA5XTeWC0AqZqJ8tunSQGT/vtV/WfyS95SXYaaM65PgoBCqJnF5vMAgb
	 5fObF3SBP1YiM8fZ+WvHvCM8m/9QWkjUviX+7vsERtiHWHqWfF0YHVCCN4g0pS3nmU
	 g/Liy39LTsDkcfQkzzzjhoiqAxTn7pFeiPQp0SLg5TX6ZOxA6AIFn9AB8oHfmG+TYQ
	 n3+Y6Ot5QlHCbGJZw9h6BpkG7v/GWpJBwDe1q6XhLwLQSuS+wEjgoRyjNlgC4BxARd
	 2kQph7krvKCag==
Message-ID: <366e3a1e-91c1-41c1-8a1f-f94124cd29e1@kernel.org>
Date: Tue, 17 Nov 2026 12:10:57 +0100
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
Subject: Re: [PATCH] mm/mempolicy: limit compat bitmap reads to the source
 nodemask
To: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, ziy@nvidia.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, ying.huang@linux.alibaba.com,
 akpm@linux-foundation.org, arnd@arndb.de, larips <larips950@gmail.com>,
 stable@vger.kernel.org
References: <20261117101910.1820066-1-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261117101910.1820066-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 11:19, Gregory Price (Meta) wrote:
> A 32-bit get_mempolicy() call can read past the kernel's stack nodemask.
> With 64 possible nodes and maxnode=65, copy_nodes_to_user() computes an
> eight-byte copy, but compat_put_bitmap() reads two native words.
> 
> A kernel built with CONFIG_NODES_SHIFT=6 reports:
> 
>     BUG: KASAN: stack-out-of-bounds in compat_put_bitmap+0x113/0x120
>     Read of size 8 at addr ff110000099afeb0 by task mpol32/246
>     Call Trace:
>      compat_put_bitmap+0x113/0x120
>      copy_nodes_to_user+0x137/0x200
>      __ia32_sys_get_mempolicy+0x1a6/0x280
> 
> Bound the compat bitmap read by MAX_NUMNODES.
> 
> Clamping every call to nr_node_ids would remove the extra userspace
> word when the kernel nodemask is large enough to contain it, but this
> keep that existing compat behavior while preventing reads beyond the
> source allocation.
> 
> Reported-by: larips <larips950@gmail.com>
> Fixes: e130242dc351 ("mm: simplify compat numa syscalls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/mempolicy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 79053ece02cd4..d9177c5504879 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1715,7 +1715,8 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
>  
>  	if (compat)
>  		return compat_put_bitmap((compat_ulong_t __user *)mask,
> -					 nodes_addr(*nodes), maxnode);
> +					 nodes_addr(*nodes),
> +					 min(maxnode, MAX_NUMNODES));
>  
>  	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
>  }

LGTM

Staring at this once more, I think it's all confusing how we handle
compat_put_bitmap() vs. copy_to_user(). with "copy" and "nbytes".


Likely we really should be working on bits, to then only align it up for the
copy_to_user() case.

I'll wait a bit for more review before picking this,


Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>


-- 
Cheers,

David
