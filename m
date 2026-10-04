Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D12E4257;
	Sun,  4 Oct 2026 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791077196; cv=none; b=QatuNIFsSmpQ0BvnF0H5XzmXtaS1Ae8290r+fV6YuWXsK+okgrNNUaRSppkv29jywaxnF59jH6MUewpIRPhtcmrMecCUsElZ5AMHcRgpV2EBGhdji3w3OUMpOM2Cr//f1Jj+y+sA+9+Uc75OXJJlXKf9N+0uNiGBngWUdIxfhd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791077196; c=relaxed/simple;
	bh=BEzGUI5h/7CJwvvqrOXWTza+u1N8nXzax5WHQtls7pY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YkOVfPum3Kf9hfaKgbxmNRd+bPzJopMG1vHTsLrp1KPiT9nCy9O+rLBp4mI4wRg6VGLRzh3MTIltTbn7u7U+v58m17yfn8SSwdrT7ciD5lNSdAmTIrWtF1d/BPWOFO4gS9PaTrTNGKbSKftvOzYfrnza3X9bqsc38pda0oCI/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aznCVEOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aznCVEOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9194C1F0089B;
	Sun,  4 Oct 2026 01:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791077194;
	bh=SKOKmZ+6noJA7PYh2xhgEd2D5EveHhrMqvu/m6C+lmU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aznCVEOLW99zQHsiDofVXMXPvEIbLxwjxU2jGitRy+ec6VCvp2G3zjHwHo83Lf2Bi
	 iRqKg7/VOO5khTxBG0sRWkiqgbqhDPZSNd5y9BIr1loFFf8B4CgS8ynvkQDRexJnkZ
	 ZbwKkXB6CWw4dQpdC4zEliS6AB5ivR1t/MohlDWnP+Mm9UgmKSFSr/3rwGST6dtcAr
	 h6LVK+/PXRZjr/GXGdJ/EXHok8vxD7tL9TBTTF5MHfkVKWZfHYhpzzmNfSR5znFrFL
	 BgkV7twRlgd1jLeUEO3REEszEcqwLJz56Im+YWqj8r5IAbASO/v+igzYT9Hu1Ehm+m
	 xgPjamoSaCslw==
Subject: Re: [PATCH] net: dst_metadata: fix fortify trap + overread in
 skb_metadata_dst_cmp
From: netdev-bot+sashiko@kernel.org
To: jpsergent@gmail.com
Cc: netdev@vger.kernel.org, i.maximets@ovn.org, kuba@kernel.org,
 kees@kernel.org, stable@vger.kernel.org
Date: Sun, 04 Oct 2026 01:26:34 +0000
Message-ID: <179107719409.434549.17882025479449823991@kernel.org>
In-Reply-To: <20261003005449.2675.2@jpsergent.gmail.com>
References: <20261003005449.2675.2@jpsergent.gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message and the new comment in
  skb_metadata_dst_cmp() (include/net/dst_metadata.h) give the wrong…
- [Medium] The Fixes: tag points at 69050f8d6d07 ("treewide: Replace
  kmalloc with kmalloc_obj for non-scalar types", Feb 2026), but the…
- [Medium] The commit trailers are Reported-by, Closes, Cc: stable and
  'Assisted-by: LLM', with no Signed-off-by.

--

net: dst_metadata: fix fortify trap + overread in skb_metadata_dst_cmp

This commit reworks the METADATA_IP_TUNNEL case in skb_metadata_dst_cmp().
It first checks that both sides have the same options_len. It then compares
the fixed part of struct ip_tunnel_info and the options in two separate
memcmp() calls through ip_tunnel_info_opts(). The goal is to fix a
FORTIFY_SOURCE panic seen in GRO on a geneve device.

Closes: https://lore.kernel.org/netdev/20261003005449.2675.1@jpsergent.gmail.com/

> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")

[Severity: Medium]
Is this the right Fixes target? The commit message says the crash was seen
on 6.18.54. In v6.18, metadata_dst_alloc() still allocates with
kmalloc(struct_size(md_dst, u.tun_info.options, optslen), flags), not
kmalloc_flex().

Both pieces needed for the trap are older than 69050f8d6d07:

  - the __counted_by(options_len) annotation on options[] in struct
    ip_tunnel_info, added by bb5e62f2d547 ("net: Add options as a flexible
    array to struct ip_tunnel_info")

  - the memcmp() in skb_metadata_dst_cmp() that uses a's options_len for
    both sides, which dates back to 3fcece12bc1b

This patch is Cc: stable. With the current Fixes target, would the fix miss
6.15 through 6.19, including the 6.18 tree where the crash was seen? Would
bb5e62f2d547 be a better target?

> Cc: stable@vger.kernel.org
> Reported-by: Jean-Paul Sergent <jpsergent@gmail.com>
> Closes: https://lore.kernel.org/netdev/20261003005449.2675.1@jpsergent.gmail.com/
> Assisted-by: LLM

[Severity: Medium]
The trailer block has no Signed-off-by line.
Documentation/process/coding-assistants.rst says the human submitter is
responsible for "Adding their own Signed-off-by tag to certify the DCO".

Could a respin add a Signed-off-by so the patch can be applied?

> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
> index f45d1e3163f00..60878ea1eb50a 100644
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

[Severity: Medium]
Does this comment, and the commit message, describe the actual root cause?
The commit message says:

  kmalloc_flex() in metadata_dst_alloc() sets __counted_by for the
  structure to options_len, which is then initialized to zero, so the
  compiler's view of the metadata_dst tail is 96 bytes at the time of
  the access. Geneve carries 108 bytes of options

On the geneve RX path, options_len is overwritten before the skb reaches
gro_cell_poll():

geneve_rx()
  udp_tun_rx_dst() -> ... -> tun_rx_dst()
      tun_dst->u.tun_info.options_len = 0;
  ip_tunnel_info_opts_set(&tun_dst->u.tun_info,
                          gnvh->options, gnvh->opt_len * 4, flags);
      info->options_len = len;

So by the time gro_list_prepare() calls skb_metadata_dst_cmp(p, skb), both
objects hold their real options lengths.

The old code read sizeof(a->u.tun_info) + a->u.tun_info.options_len bytes,
and FORTIFY sizes a's object with the same options_len, so a's side cannot
trip. That means "108 byte read of buffer size 96" points to
a->options_len == 12 and b->options_len == 0. In other words, 12 bytes of
options, not 108.

If so, the real bug is the old memcmp() using a's options_len for both
sides. __counted_by only exposed it. Without FORTIFY, it is a slab
out-of-bounds read past b's allocation.

The options_len pre-check, which the commit message calls a "While here"
fix, is what actually stops the panic. Once the lengths are known to be
equal, a single memcmp() of sizeof(tun_info) + options_len would also pass
FORTIFY on both sides, so the two-stage split does not seem to add
anything.

The commit message also says this was seen "under sustained cross-node RX".
Can any Geneve sender trigger it remotely by mixing packets with and
without options in the same inner flow?

Could the commit message and this comment be updated to describe the
options_len mismatch between a and b as the root cause?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261003005449.2675.2%40jpsergent.gmail.com
