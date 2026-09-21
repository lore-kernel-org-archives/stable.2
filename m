Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D05634CFC2
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972494; cv=none; b=h0MjuoqhO4Tr4QmsBPHSQbEmeObbfWf27pz43om9FI/SNNKgMobvP7dKPnlbd4nJMVXcBT+73KlSIcvZE7qCombcRWIfCQsaoBxVdxyBrAh08N9347j917YowLB4RNuuK6A3WGudx5hBk+8FuKuFBNZBajsdRjZpLT53VlOhJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972494; c=relaxed/simple;
	bh=tzHXtSDyKoqlRcC2fF99+d0VGCnqq37KuyiMMgIOk4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOU7VFsTtiibPh/KNfyJM9OczZ+VUOMjA01NwI2PIaa6LM5yKo0Dh8EFXK1HKuQVy/CU50YLZ+EJnznJMGKTY7FXaJtTBXZxiaQ8ynhzUjhTiW0VU+Jqd1E7lvrBeq85E6ztFFbqUzBZGaODYCfWJ+fIIaWIZ9suJkAqK9x3Kds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IpTnWZxv; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IpTnWZxv"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tzHXtSDyKoqlRcC2fF99+d0VGCnqq37KuyiMMgIOk4o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789972490; v=1; x=1790577290;
 b=IpTnWZxvWGOlde77JeVjqNrRBvENzJVxijGKg905gNiwdPC+O3gYHVkTqzPcwM0KpxrBb72O
 96JWITrH8az/fHGHdr55GtSR/vK+YE3ADhJB0ncOFs96RyQkNnp4yEKs22Wf6Ei9TV6JWKmmjFI
 yHDVQOcZUHaMIHf+Qic7+CvE=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 4eb82a119267221f;
	Mon, 21 Sep 2026 06:34:50 +0000
X-Mizu-Trace-ID: 4eb82a119267221f
X-Migadu-Flow: FLOW_OUT
Date: Mon, 21 Sep 2026 14:34:37 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Hui Peng <benquike@gmail.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: sr: enforce exact attribute length for
 SEG6_ATTR_DST
Message-ID: <arDP_TE-Lsoc4VPq@fedora>
References: <aq-E5MPYZS5s9_bk@fedora>
 <20260921044025.1535982-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921044025.1535982-1-benquike@gmail.com>

On Mon, Sep 21, 2026 at 04:40:25AM +0000, Hui Peng wrote:
> In seg6_genl_policy, SEG6_ATTR_DST is defined with .type = NLA_BINARY and
> .len = sizeof(struct in6_addr). For NLA_BINARY, .len only enforces the
> maximum payload length and permits shorter payloads (e.g., 0 bytes).
> When seg6_genl_set_tunsrc() copies sizeof(struct in6_addr) bytes via
> kmemdup(val, sizeof(*val), GFP_KERNEL), a short SEG6_ATTR_DST attribute
> triggers a 16-byte out-of-bounds read past skb->tail into uninitialized
> skb->head memory, which is stored in sdata->tun_src and leaked back to
> userspace via SEG6_CMD_GET_TUNSRC.
> 
> Switch SEG6_ATTR_DST in seg6_genl_policy to
> NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)) so that generic netlink
> validation rejects any attribute whose length is not exactly
> sizeof(struct in6_addr) with -ERANGE.
> 
> Tested in QEMU against Linux 7.3.0-rc3 by sending a SEG6_CMD_SET_TUNSRC
> Generic Netlink message with a 0-byte SEG6_ATTR_DST attribute followed
> by SEG6_CMD_GET_TUNSRC. On the unfixed kernel, SEG6_CMD_SET_TUNSRC
> succeeds (err = 0) and SEG6_CMD_GET_TUNSRC leaks 16 bytes of
> uninitialized kernel heap memory (tun_src =
> 836a61ecc4d25a1042a8d60411cfb378); with this patch applied,
> SEG6_CMD_SET_TUNSRC is rejected by netlink policy validation with
> -ERANGE (-34) and tun_src remains zeroed.
> 
> Fixes: 915d7e5e5930 ("ipv6: sr: add code base for control plane support of SR-IPv6")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Drop the redundant nla_len(info->attrs[SEG6_ATTR_DST]) !=
>   sizeof(struct in6_addr) check in seg6_genl_set_tunsrc() since
>   NLA_POLICY_EXACT_LEN() in seg6_genl_policy already enforces the exact
>   length, as pointed out by Hangbin Liu.
> 
>  net/ipv6/seg6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index 62a7eb779202..8c2b156c227a 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -138,8 +138,8 @@ void seg6_icmp_srh(struct sk_buff *skb, struct inet6_skb_parm *opt)
>  static struct genl_family seg6_genl_family;
>  
>  static const struct nla_policy seg6_genl_policy[SEG6_ATTR_MAX + 1] = {
> -	[SEG6_ATTR_DST]				= { .type = NLA_BINARY,
> -		.len = sizeof(struct in6_addr) },
> +	[SEG6_ATTR_DST]				=
> +		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
>  	[SEG6_ATTR_DSTLEN]			= { .type = NLA_S32, },
>  	[SEG6_ATTR_HMACKEYID]		= { .type = NLA_U32, },
>  	[SEG6_ATTR_SECRET]			= { .type = NLA_BINARY, },
> -- 
> 2.49.0

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
