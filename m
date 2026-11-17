Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927587;
	b=EZU29WhGfhnOVcMxhIZaxL5ZOPyg15PCsMCdtk3bxXY4eKvapq3idhKPCVPY1CG9pkG0
	 7+HxHF3J1laDIibwoPVZbisvVViu3E0CpF+tc9FJy0P4727NqRvWODvp2EsX/pSoUait1
	 r6doqtDAuSlu0IgD1G0kGDn1rrIaP0lnLvKywaXNE5ABuyF2BEHVmSY0LYxKWA5F72gEH
	 zIOpDzopKFKe0rKeayDPqNkmcZhRJ+JvU7rZEAto6B61bbeXKu6B6EyYLlMo1LLgrDBLW
	 ZaqbYj4UWnoplKkfHAzChU6axDmZT0k2q2H4EhTyL4xNgf1n7BYShdqOKuoLpmTmTcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927587;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y1VbFWHqAdIMKRSs1Q13+9d1GiMSaggumwroNM3vhzw=;
	b=gZ4Qst3wKp+BP5jnkBUG6/FRI2XpdmHSQWuUBllTFvtOTs/1vMTJu/ATGyfJcsFTxvdE
	 beYz0uh8Pw3G4vMm4GAKejogTbuOK2fqHsoJSRyzG4hmnJNtQV5oY+t/hgCthPLWrvf8p
	 ShojH/Q1qzbQKT80djkjnQAs2aXlWpUoehcQOYbk5HV/9hB1qq1q9GaxIg3PZs+5SJUwQ
	 spF3NSV1B7m76dInqDBOEj/62NyWWWqZ0KyDyemAhu0wdQpkOja+LTROVgWoU8BO+uiIg
	 vCPrV/oDU9ZxN5/fu02edrGMwCvIxt0b7cF54gv1xOI9HUFUb0r601k8kHCZkHKAtKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FJ6y/NLY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BECE606A32C;
	Tue, 17 Nov 2026 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJ6y/NLY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE3D1F000C5;
	Tue, 17 Nov 2026 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927586;
	bh=y1VbFWHqAdIMKRSs1Q13+9d1GiMSaggumwroNM3vhzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FJ6y/NLY7l6o0kd84uboAds/5Zo+8K92K5B7YWfjR/4MHNXllAPewqBsc2eiOEtph
	 seQbGkgq47f4a/z0Mrn4y2U6HYoeMab3NwzpPIkS4OySQIgLrv8bBT2hjeOo7fmhrI
	 esSvaEHFT5P7WsrTLnFmN8lLWpekXd2bMahIlt/KIoHVwUhSzxZPUK45jUNRxK+Miu
	 Bu96YZyywpMGrwyNAZzvgjBq7P4uAUfyps7D/+tw+CoA3gOqjsV6P/P3ToIeyGwXC3
	 rjI4JJp2VIN6X/cifRq5kQDFlVoIG49aSIU1b1M1MaL9OHeGAy4FIW8i5esQoIenXP
	 I6NWlSOlhMwcA==
Date: Tue, 17 Nov 2026 14:59:39 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, larips <larips950@gmail.com>, stable@vger.kernel.org, 
	Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jackie Liu <liuyun01@kylinos.cn>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: fix copy_nodes_to_user() for odd inputs
Message-ID: <avxnIQTcFni9G4IN@gremlin>
References: <20261117142628.3931151-1-arnd@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117142628.3931151-1-arnd@kernel.org>

On Tue, Nov 17, 2026 at 03:25:53PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The ALIGN(maxnode-1, 64) check has an off-by-one error that leads to
> rounding down too much, and ends up not copying the last word when
> userspace asks for one bit over a multiple of 64.

From what I can tell, this isn't an off-by-one, but just the (possibly weird)
convention in mempolicy.c. E.g. in get_nodes():

static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
		     unsigned long maxnode)
{
	--maxnode;
	< etc. >
}

>
> For compat syscalls, the effect is worse, as the actual calculation for
> the size does include the extra word, but the check for the input size
> does not take it into account and can leak a word of stack data.
>
> In addition, the size calculation rounds up to multiples of 64 bits
> instead of multiples of word size as documented in the man page and
> expected by numactl.
>
> Fortunately numactl always passes multiples of 64 here, so none of

(Claude) went looking at numactl source (e.g. via libnuma) and it seems it
passes size + 1 matching the convention?

> this affects userspace we care about. Finally, the 'nbytes' calculation
> for compat mode makes no sense since that is the size of the kernel's
> internal representation, not the userspace side.
>
> Fix the 'copy' calculation to address all of the above. Note that the
> off-by-one error has been in there since the beginning, but commit
> e130242dc351 ("mm: simplify compat numa syscalls") is where we starting
> copying the wrong data.
>
> Reported-by: larips <larips950@gmail.com>
> Reported-by: Gregory Price (Meta) <gourry@gourry.net>
> Fixes: e130242dc351 ("mm: simplify compat numa syscalls")
> Link: https://lore.kernel.org/all/20261117101910.1820066-1-gourry@gourry.net/
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Please double-check the calculation and retest this with the original
> reproducer. The off-by-one error does explain all of this, I'm still
> worried about getting this version wrong again as everyone including
> myself seems to have missed this in the past 25 years and there may
> still be additional subtle issues around it. Apparently we had many
> instances of the same off-by-one in this file but all (most?) others
> got fixed inadvertently by other changes in the past.
> ---
>  mm/mempolicy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 6d662a9a8c74..f318e1155770 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1749,12 +1749,12 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
>  static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
>  			      nodemask_t *nodes)
>  {
> -	unsigned long copy = ALIGN(maxnode-1, 64) / 8;
> +	unsigned long copy = ALIGN(maxnode, BITS_PER_LONG) / 8;

This looks like it'll be broken given the convention of passing bits + 1,
e.g. ALIGN(1025, 64) / 8 != ALIGN(1024, 64) / 8.

Then later that could case a buffer overflow potentially?

>  	unsigned int nbytes = BITS_TO_LONGS(nr_node_ids) * sizeof(long);
>  	bool compat = in_compat_syscall();
>
>  	if (compat)
> -		nbytes = BITS_TO_COMPAT_LONGS(nr_node_ids) * sizeof(compat_long_t);
> +		copy = ALIGN(maxnode, BITS_PER_COMPAT_LONG) / 8;
>

Claude suggests that this is potentially broken too for similar reasons.

>  	if (copy > nbytes) {
>  		if (copy > PAGE_SIZE)
> --
> 2.53.0
>

Overall it seems the issue is that e130242dc351 (understandably!) passes maxnode
rather than maxnode-1.

So a really small fixup would be something like:

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fb627b37afcb..051d411c04ee 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1733,12 +1733,12 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 		if (clear_user((char __user *)mask + nbytes, copy - nbytes))
 			return -EFAULT;
 		copy = nbytes;
-		maxnode = nr_node_ids;
+		maxnode = nr_node_ids + 1;
 	}

 	if (compat)
 		return compat_put_bitmap((compat_ulong_t __user *)mask,
-					 nodes_addr(*nodes), maxnode);
+					 nodes_addr(*nodes), maxnode - 1);

 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }

Maybe doing that's the easiest route for this?

--
Cheers, Lorenzo
