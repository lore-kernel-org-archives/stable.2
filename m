Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD7379993;
	Sun,  4 Oct 2026 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791077197; cv=none; b=enNM2+7Rq16wEiDiUVGalMAPJJQNN3Oi88DzKdCJKOKQcdKUqGTJCTA1vufYf4y4CShIPyaRft6TcTsdsESSV2YgzWqs3Pqc99q4J/DhmFH8l+beF71mFqySSTfFq6YQQiuQIFPRace8nL+2kKywgWJfavSnvylRnl2SiHtcoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791077197; c=relaxed/simple;
	bh=sDzb+9XAxHR21u675SEIHxFuHBI7eu+neLUAoLP0Mzk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kLz/Iv4YUxwLFCdVCywa3yddtZaaaU7H2lLLhRGnWQTP1Oxb3vhQobJ/O4/zJEZDLy/z4EabIbSlqLxozbX+zoJhG5g6cBGUZm/96lZ1fq6+m0mfTMomCH4QdmeyE+iZYIw82LAoSSzqMyBwisQK6jLtrBkkUkm+gpqBcwY5y+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZQE5nkH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZQE5nkH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AD81F0089C;
	Sun,  4 Oct 2026 01:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791077196;
	bh=uptfHPgWljdWsUZOtLuRKG6qwtK2ze6it9zMEZTX3Ao=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NZQE5nkHQcf0sDo2dhqNp4NHzz02ZRhRkH7IjBq9t4sDf+C6HGCW3WMGGWw9+9Exz
	 de7ZCfYiB36mNuEwUoz3MFRnWA280NfwN4XYAboeJI35NOFwvbaUX53YEHt8sc2/qO
	 YFhcu9cBZ2H25fJnec4fQNw4/ogYI+SAw57C6XQDHa7iIIyE2PpFgAE4ko/XroPbt4
	 7/06nV6svWg5zeMe9sM+QDKrP8QkQn3HtYqUk1+0wxeVbzoVmYOakP4lRb7gG+Y9Iq
	 UwOxz861nRxHzlgxpetmWtKRKe39NlIYMB5dt7ZfCrmShu6hdb0hzEu3q95Dvl8rth
	 rsQoC3ncJB08Q==
Subject: Re: [PATCH net v2] net: dst_metadata: fix fortify trap + overread in
 skb_metadata_dst_cmp
From: netdev-bot+sashiko@kernel.org
To: jpsergent@gmail.com
Cc: netdev@vger.kernel.org, i.maximets@ovn.org, kuba@kernel.org,
 kees@kernel.org, stable@vger.kernel.org
Date: Sun, 04 Oct 2026 01:26:35 +0000
Message-ID: <179107719545.434549.13172512532862853272@kernel.org>
In-Reply-To: <20261003005449.2675.3@jpsergent.gmail.com>
References: <20261003005449.2675.3@jpsergent.gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message and the new code comment give the wrong
  root cause, while the code change itself works.
- [Medium] The Fixes: tag points at 69050f8d6d07 ("treewide: Replace
  kmalloc with kmalloc_obj for non-scalar types", Feb 2026, first in…
- [Low] The commit has no Signed-off-by:.

--

net: dst_metadata: fix fortify trap + overread in skb_metadata_dst_cmp

This patch changes the METADATA_IP_TUNNEL case of skb_metadata_dst_cmp()
to address a FORTIFY_SOURCE memcmp() panic in the GRO path with geneve.
Dsts with different options_len values are now rejected up front.
The struct and the options are then compared with two separate memcmp()
calls.

Closes: https://lore.kernel.org/netdev/20261003005449.2675.1@jpsergent.gmail.com/

> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")

[Severity: Medium]

Is this the right Fixes: target? 69050f8d6d07 first appears in v7.0, but
the panic was reproduced on 6.18.54. In v6.18, metadata_dst_alloc() still
uses plain kmalloc(struct_size(md_dst, u.tun_info.options, optslen),
flags).

FORTIFY can size both objects here because of the __counted_by
annotation added by bb5e62f2d547 ("net: Add options as a flexible array
to struct ip_tunnel_info"), which is in v6.15:

	u8			options[] __aligned_largest __counted_by(options_len);

The memcmp() itself goes back to 3fcece12bc1b (2017).

With the current tag, would stable tooling skip 6.15 through 6.18,
including the 6.18 kernel where this was observed?

> Cc: stable@vger.kernel.org
> Reported-by: Jean-Paul Sergent <jpsergent@gmail.com>
> Closes: https://lore.kernel.org/netdev/20261003005449.2675.1@jpsergent.gmail.com/
> Assisted-by: LLM
>
> v2: fix subject prefix to [PATCH net]; no code changes.

[Severity: Low]

The commit has no Signed-off-by: line.
Documentation/process/coding-assistants.rst says the human submitter
must add their own Signed-off-by to certify the DCO. Can the patch be
applied without it?

The v2 changelog is also in the commit body, not below the --- line, so
git am would keep it in the permanent history. Could it be moved below
the ---?

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

Is this the right explanation for the trap? The commit message says the
same thing:

  Same disease as the tun_dst_unclone fix (4c6d43db2a4d), on the RX
  sibling: kmalloc_flex() in metadata_dst_alloc() sets __counted_by for
  the structure to options_len, which is then initialized to zero, so
  the compiler's view of the metadata_dst tail is 96 bytes at the time
  of the access. Geneve carries 108 bytes of options, ...

The old code computed the read length from the current value:
sizeof(a->u.tun_info) + a->u.tun_info.options_len. sizeof(struct
ip_tunnel_info) is 96. A 108 byte read therefore means
a->u.tun_info.options_len was 12 when the call ran. So geneve carried
12 bytes of options, not 108.

The fortified memcmp() checks the first buffer before the second:

include/linux/fortify-string.h:memcmp() {
    ...
	if (p_size < size)
		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, p_size, size, INT_MIN);
	else if (q_size < size)
		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, q_size, size, INT_MIN);
    ...
}

For a, p_size is 96 + 12 = 108, so the reported 96 has to be q_size.
That means b->u.tun_info.options_len was 0.

On RX, neither dst still holds its allocation-time zero when
gro_list_prepare() calls skb_metadata_dst_cmp(). geneve_rx() fills in
the length right after udp_tun_rx_dst():

drivers/net/geneve.c:geneve_rx() {
    ...
		ip_tunnel_info_opts_set(&tun_dst->u.tun_info,
					gnvh->options, gnvh->opt_len * 4,
					flags);
    ...
}

If options_len really were 0 at compare time, the read length would be
96 and nothing would trap.

So isn't FORTIFY correctly catching a compare of a (12 bytes of options)
against b (no options), with a's length used for both buffers? If so,
the options_len pre-check, which the commit message calls a "While here"
fix, is the actual fix.

Once the lengths are known to match, a single struct+options memcmp()
fits both counted_by views. Is the split into two memcmp() calls needed?

options_len sits at offset 88 and options[] at offset 96. The old
memcmp() would hit the options_len difference before it reached b's
missing options. So the user-visible failure looks like the FORTIFY
panic, not a real overread past b's allocation.

Could the commit message and this comment describe the mismatched
options_len case instead of an allocation-time zero?

> +		return memcmp(ip_tunnel_info_opts(&a->u.tun_info),
> +			      ip_tunnel_info_opts(&b->u.tun_info),
> +			      a->u.tun_info.options_len);
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261003005449.2675.3%40jpsergent.gmail.com
