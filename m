Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC81134CCF
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791034276; cv=none; b=TZBXlcPKCGQsB8KYHjIW7+Gpr8iyHUbEUpKvZCWmjFTuqiJbIjEneJZbcBbNTlTbMIsvwOjQCffRUH/LZKXxsfuYs0SmPGMBFuOKcRDCkddsgRV4nA+X4dhXZ32/h4NLzR9X5dW4E5/f2ngdd5fYI9GUzaeTGB+3HrIFV4rtC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791034276; c=relaxed/simple;
	bh=o1ct5O7P++z+BWWKxmpMYC5OaBNz8+fxETk7z3k3D5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkJrWmT8NAl8ZTsUiaJ3jMyaDiHWCG9MXdV0Q81+BHq9SqdyciG5fLosoWK3OXCRmqy67RagDXsKS3naHK+DdH1yvKj7twNYBn/VOKJ17LDHFBRcyaH23FTgNP6CefGRZ/krH7ei5t/+nz/WO8skuVC9Sqfc7TA+Gk3zSjVM+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org; dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b=IRs9ZlOK; arc=none smtp.client-ip=121.127.44.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b="IRs9ZlOK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-13eddc7e57; t=1791034273;
 bh=ODkEeefSLrm7hij5ZurlSzDvVH3h/IuT7Yn34ArBMRw=;
 b=IRs9ZlOKcW2ikY7KN9pQ02jJIKSCy5aXmMB/OZizMd99H09Yo7+UEVKwai3M48UZ41Ll4NCDf
 JI6Th4es8sd87bkQPcssY8+WGv6JnHFTwsHPpXEB67vrJb/Lg8qh8auTbuHKfAg+MhStB0+P/Ei
 +ALfEKqqDgM0wPZO1Rb1Zfg=
X-Forward-Email-ID: 6ac1039e24093e5eace53723
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.17.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <787c2c1e-1260-43ae-bee0-9798e1e53c2b@ovn.org>
Date: Sat, 3 Oct 2026 15:31:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dst_metadata: fix fortify trap + overread in
 skb_metadata_dst_cmp
To: Jean-Paul Sergent <jpsergent@gmail.com>, netdev@vger.kernel.org
Cc: i.maximets@ovn.org, kuba@kernel.org, kees@kernel.org,
 stable@vger.kernel.org
References: <20261003005449.2675.2@jpsergent.gmail.com>
 <20261003005449.2675.3@jpsergent.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20261003005449.2675.3@jpsergent.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/26 3:24 AM, Jean-Paul Sergent wrote:
> memcmp: detected buffer overflow: 108 byte read of buffer size 96
>  WARNING: CPU: 0 PID: 15 at lib/string_helpers.c:1036 __fortify_report+0x45/0x60
>   __fortify_panic+0x9/0x10
>   skb_metadata_dst_cmp+0x11b/0x120
>   dev_gro_receive+0x303/0x620
>   gro_receive_skb+0xc5/0x230
>   gro_cell_poll+0x67/0xa0
> 
> Same disease as the tun_dst_unclone fix (4c6d43db2a4d), on the RX
> sibling: kmalloc_flex() in metadata_dst_alloc() sets __counted_by for
> the structure to options_len, which is then initialized to zero, so
> the compiler's view of the metadata_dst tail is 96 bytes at the time
> of the access. Geneve carries 108 bytes of options, and the combined
> struct+options memcmp trips CONFIG_FORTIFY_SOURCE when built with
> clang. Observed live on 6.18.54-talos with Cilium geneve, in
> gro_cell_poll (gro_cells GRO on the geneve device) under sustained
> cross-node RX; the warning is followed by a fatal Oops
> (kernel BUG at lib/string_helpers.c:1043).

This doesn't make sense to me.  The problem in tun_dst_unclone was
at the initialization time, where we couldn't write the options_len
together with the options while the currently stored value is zero.

Here the function just compares two blocks and they must be already
fully initialized and have options_len properly set.  If they have
options, but the length is zero, that's a bug somewhere else.

> 
> While here, fix a related overread: the memcmp length uses
> a->u.tun_info.options_len for BOTH sides, so when b carries fewer
> options than a the comparison reads past b's allocation. Pre-check
> that both sides carry the same options_len

This makes sense and may be the real bug here?  If options actually
have different length for some reason, then the memcmp will rightly
trigger the fortification check as it should.

However, someone more familiar with GRO should probably look at this
to see how the comparison should behave when options are different as
it sounds a little weird that they are.

> and compare the options
> through ip_tunnel_info_opts() so the counted_by view matches the read
> length (the same two-stage shape the unclone fix uses).

This makes no sense.  Single memcmp should work just fine as long as the
compared size doesn't exceed the actual size of both memory regions.

Do you still see the fortification issue trigger with just the length
comparison change?

> 
> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")

This is likely wrong and should point to the commit that added the
tunnel info comparison.

> Cc: stable@vger.kernel.org
> Reported-by: Jean-Paul Sergent <jpsergent@gmail.com>

If you are the author you need a sign-off instead of a reported-by.

Also, you're missing a lot of maintainers in the Cc list.

> Closes: https://lore.kernel.org/netdev/20261003005449.2675.1@jpsergent.gmail.com/

There is no point linking the same thread where you're posting a patch,
it will be linked anyway on commit.

> Assisted-by: LLM
> 
> v2: fix subject prefix to [PATCH net]; no code changes.

This should not be in the commit message.  Also, there should be a link
to the previous version here.

> 
> ---
> 
> Reproduced without the fix: live kernel panic on 6.18.54-talos
> (Cilium geneve, gro_cell_poll) under sustained cross-node RX; trace
> in the report. The fix itself is NOT build-tested - no kernel build
> environment on the reporter's host.
> ---
>  include/net/dst_metadata.h | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
> index f45d1e3..60878ea 100644
> --- a/include/net/dst_metadata.h
> +++ b/include/net/dst_metadata.h
> @@ -115,10 +115,30 @@ static inline int skb_metadata_dst_cmp(const struct sk_buff *skb_a,
>  	case METADATA_HW_PORT_MUX:
>  		return memcmp(&a->u.port_info, &b->u.port_info,
>  			      sizeof(a->u.port_info));
> -	case METADATA_IP_TUNNEL:
> -		return memcmp(&a->u.tun_info, &b->u.tun_info,
> -			      sizeof(a->u.tun_info) +
> -					 a->u.tun_info.options_len);
> +	case METADATA_IP_TUNNEL: {
> +		int ret;
> +
> +		/* Options lengths must match, or the options memcmp below
> +		 * would read past b's allocation when b carries fewer
> +		 * options than a.
> +		 */

This is obvious, drop the comment.

> +		if (a->u.tun_info.options_len != b->u.tun_info.options_len)
> +			return 1;
> +		ret = memcmp(&a->u.tun_info, &b->u.tun_info,
> +			     sizeof(a->u.tun_info));
> +		if (ret)
> +			return ret;
> +		/* Compare the options through the flex-array member so the
> +		 * compiler's __counted_by(options_len) view stays consistent
> +		 * with the read length (same shape as the tun_dst_unclone
> +		 * fix); a single memcmp of struct+options trips
> +		 * CONFIG_FORTIFY_SOURCE when options_len is still 0 from
> +		 * allocation time.
> +		 */

This part of the change doesn't make much sense, but anyway, when asking
LLMs to write comments, please ask them to be concise.  There is too much
stuff in there that makes no sense in the context of the code, e.g. the
mentioning of the "tun_dst_unclone fix", and the comment is generally way
too long for what it tries to accomplish.  It should be 2 lines at most
in this particular case.

Same applies to the commit message, there is too much fluff in there that
makes it harder to read.

So, please, do some quality control before sending patches, read what
you're sending.  Don't just shoot out AI slop.  Next person may not be
that kind in their replies.

> +		return memcmp(ip_tunnel_info_opts(&a->u.tun_info),
> +			      ip_tunnel_info_opts(&b->u.tun_info),
> +			      a->u.tun_info.options_len);
> +	}
>  	case METADATA_MACSEC:
>  		return memcmp(&a->u.macsec_info, &b->u.macsec_info,
>  			      sizeof(a->u.macsec_info));

Best regards, Ilya Maximets.
