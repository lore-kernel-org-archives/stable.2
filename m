Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB405D531;
	Wed,  9 Sep 2026 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924719; cv=none; b=NS5q/3lBKA/6d3x3lnS5EjvFMQBrz3jhH6AGXkHsQKNisCfiyW7ojcxbcaQ4hbZ620nLJZfMn1gXoFH7dt8jCD+4o9RPqWYsfdGNok0fRGfoWs6e9tHleQZ62r5VcaSUxqm4UxdRPyR+zAZZw0GAGwxT7Gv0nBYbArT01rJ1RsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924719; c=relaxed/simple;
	bh=Qm+aMJVZ1idBa35wLxEgrLzJcZojK9HIKgUFsthGAJk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=L5fX1Fd18DQyV2tbYNNGFFthnSkjqRLgRI80hyvXGCfwnttz1tNonsDultp0tzVgsCMhwrhC+2vaoOJYWcOs3vUOMeOkFyO1/Vdcx0mzTI1e5x9svACmHlC0nlUeZQwFD0/8yD0bn3Xq2RhOG6T+jSKNumbo2x9X7cpZe9VHDds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ5SdLSS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ5SdLSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A3F1F00A3A;
	Wed,  9 Sep 2026 03:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788924718;
	bh=JvN514bLvBb8o7E32rh5fkZP8pnd+hgZq+omQSQeuT4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gJ5SdLSShN39mGKbDK+W3PMWstHQ5M6IsZJ3BNvrAzFpoFEFVy49WO43NLHuzVZGs
	 UrQquZ3vRZVOs8zTyvMynlvXg9J/tGPFs0eoLndkrkITaM203IOeXS31o4RmOsyLAJ
	 hU+2quI6S6lxW/LjNYksB1EaX9K1PWUDUokVEJWNDt3Y1tsG8VS5Kzm9ePEXVBYTVi
	 9DFplvxm6WsJlK7o5jamQ+/0KO9pCS4WXImw9mwkb1dCp+jthCFt/2I8tuklkPgBV5
	 +EvzgyX5fVulJtCIRDQkknWn+oAg1TeMU3JzHJqADQp9my6+RLY7fenVAMiBegsEvX
	 aLDxzLfZY6YdQ==
Content-Type: multipart/mixed; boundary="===============7905957693095893453=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <90811fbd60e9519d8b1bcc316c4d43cd21c95e24c96b37ed2917d824e007c50b@mail.kernel.org>
In-Reply-To: <20260909024011.1252694-1-nikhilljatt@gmail.com>
References: <20260909024011.1252694-1-nikhilljatt@gmail.com>
Subject: Re: [PATCH bpf] bpf: fix reading neigh ha in bpf_fib_lookup()
From: bot+bpf-ci@kernel.org
To: nikhilljatt@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com
Cc: eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,horms@kernel.org,dsahern@gmail.com,hawk@kernel.org,razor@blackwall.org,stable@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 03:31:56 +0000 (UTC)

--===============7905957693095893453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8513167a858a..a7c7bbfd90e3 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -6297,6 +6297,20 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
>  #endif
>
>  #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
> +/* Take a stable snapshot of the neighbour's link layer address.
> + * neigh_ha_snapshot() can not be used here because it copies dev->addr_len
> + * bytes while params->dmac is only ETH_ALEN long.
> + */
> +static void bpf_fib_dmac_snapshot(u8 *dmac, const struct neighbour *neigh)
> +{
> +	unsigned int seq;
> +
> +	do {
> +		seq = read_seqbegin(&neigh->ha_lock);
> +		memcpy(dmac, neigh->ha, ETH_ALEN);
> +	} while (read_seqretry(&neigh->ha_lock, seq));
> +}
> +

The commit message states:

>     neigh_ha_snapshot() cannot be used here because it copies dev->addr_len
>     bytes while params->dmac is only ETH_ALEN long (an IPoIB egress device
>     has addr_len 20 and would overflow into params->smac), so open-code the
>     seqlock loop around the ETH_ALEN copy.

Is the overflow destination accurate? Looking at struct bpf_fib_lookup in
include/uapi/linux/bpf.h, smac precedes dmac in the final union:

    union {
        struct { __u32 mark; };
        struct {
            __u8 smac[6];    /* ETH_ALEN */
            __u8 dmac[6];    /* ETH_ALEN */
        };
    };

That union is the last member of the struct, so smac sits at offset 52 and
dmac at offset 58 in the 64-byte struct.

Calling neigh_ha_snapshot(params->dmac, neigh, dev) with an IPoIB device
(addr_len == 20) would write bytes 58..77, which is 6 bytes into dmac and
14 bytes past the end of struct bpf_fib_lookup. It cannot reach params->smac
at the lower offset.

Because params points at BPF-program memory that the verifier only sized to
sizeof(struct bpf_fib_lookup), the actual consequence is an out-of-bounds
write past the program-supplied buffer, not a clobbered sibling field.

The conclusion that neigh_ha_snapshot() is unusable here is correct, and
the in-code comment is accurate. Could the changelog's claim about where the
overflow lands be corrected before this goes to stable, since the
parenthetical is the sole stated justification for open-coding the loop?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34305501194
--===============7905957693095893453==--
