Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6E383981;
	Mon, 24 Aug 2026 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595775; cv=none; b=i/7tYW8HSf9r2qw+717JQTEgRsy65NnXxPV8dBsMK5lpkYcOcZup3DiHZwoqLt7neVIM/dEopTbeXe2nNlaKGxga7EEgix1aFITSQPQzqSLEp4ptQOj0hTicsBz+wtMloRPc2rLICvyMeh2iiDqqpQ6J7bIqrIjw4tdU/JA9x6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595775; c=relaxed/simple;
	bh=rxs7sO3FqqvreuB3ejp0DZZxGpzhU8PhCvK/ZvhE8/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikUX5mtsR/6qO5kDJEb/l5wF9oFkKC3gA9oy8DNUJdeMXYBD0D5shQoQ8O55Ks3AHew+KVLGIhiMa6C04jVobGM4sxfZIZbzvYvkUhx5ww4UjRKWfWI/BXj5x+jl83us7z3DwI65/sghlN082h/0XVvNpO/oU5k4U/Rxht25Oj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdNQ1jqD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdNQ1jqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE451F000E9;
	Mon, 24 Aug 2026 18:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787595773;
	bh=WmNoSysQv/hBxiCyPDAmxrJYxNZ925BTiUeBMsz9xA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kdNQ1jqD/Tkj0Wt9MM86oo99kzAarxOUdsVBK2ZWAMWj2uaYfWdvrtp1iloo9NXoD
	 WdTXl95nljlmM0b2SKl2yPc8eP+j5ahmACpK1sfcCDpoJhkauqW+rnXWLek/CQXwZg
	 V1FiX56jdTPTQH5QTSOT92SDyNwCqrc4ZJJnkhG5Gh++71bZ0rF4mp2JDr9CzCI9gX
	 npgVdwS+nByplKEP0ugnR4N4A6DSgKYNhQ93nVTqT4emspIDbceTQh1CLQAXlMGm/j
	 hJdEiFW/M/zfsMAGGXj5nWddxup1gpGP3yB16L9uaGz9BiDTk1d7FVto+yTEYEX12O
	 P8ru86ZCenRTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: meatuni001@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: act_csum: Fix missing headroom COW and integer underflow in header rewriting
Date: Mon, 24 Aug 2026 11:22:52 -0700
Message-ID: <20260824182252.2672540-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818221519.75088-3-meatuni001@gmail.com>
References: <20260818221519.75088-3-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/sched: act_csum: Fix missing headroom COW and integer underflow in header rewriting

This adds a helper csum_ensure_writable() to act_csum that calls
skb_cow(skb, -offset) when the network offset is negative before calling
skb_ensure_writable(), and converts two of the existing offset
computations in tcf_csum_skb_nextlayer() and tcf_csum_ipv4() to use it.

A few questions below, first about the changelog and then inline in the
diff.

>     2. skb_try_make_writable() only evaluates writability from skb->data
>        forwards and does not invoke skb_cow() on the headroom. When modifying
>        cloned SKBs (e.g. from packet sockets, tc mirred, or BPF redirects),
>        updating headers via ip_send_check() or L4 checksum replacements mutates
>        shared headroom data directly, leading to packet corruption and page
>        cache corruption.

[Severity: Low]
Can this code reach page cache pages at all?  The bytes protected here are
the headroom in front of skb->data, which lives inside the skb head
allocation, and skb_cow() -> __skb_cow() -> pskb_expand_head() only
reallocates and copies skb->head .. skb_tail_pointer().

Page cache pages only show up in skb_shinfo(skb)->frags (sendfile,
MSG_ZEROCOPY), and neither the old nor the new act_csum code writes there.

The "cloned SKBs" framing also looks questionable for the ntkoff >= 0 case.
skb_ensure_writable() falls back to a full head copy:

net/core/skbuff.c:skb_ensure_writable() {
	if (!skb_cloned(skb) || skb_clone_writable(skb, write_len))
		return 0;

	return pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
}

and the fast path only triggers when

include/linux/skbuff.h:skb_clone_writable() {
	return !skb_header_cloned(skb) &&
	       skb_headroom(skb) + len <= skb->hdr_len;
}

i.e. when the header area including headroom was explicitly handed to this
skb as privately writable (see "DOC: dataref and headerless skbs" in
include/linux/skbuff.h).  Could the changelog drop the page cache claim and
describe the headroom case only?

> diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
> index 078d3a27130b..c8e2f20e2da3 100644
> --- a/net/sched/act_csum.c
> +++ b/net/sched/act_csum.c
> @@ -121,6 +121,18 @@ static int tcf_csum_init(struct net *net, struct nlattr *nla,
>  	return err;
>  }
>  
> +static int csum_ensure_writable(struct sk_buff *skb, int offset, size_t len)
> +{
> +	if (offset < 0) {
> +		if (skb_cow(skb, -offset))
> +			return -ENOMEM;
> +		if (offset + (int)len > 0)
> +			return skb_ensure_writable(skb, offset + len);
> +		return 0;
> +	}
> +	return skb_ensure_writable(skb, offset + len);
> +}

[Severity: High]
Is the (int)len cast here safe?  len is size_t, so any length above INT_MAX
becomes negative in this test, the helper returns 0 without calling
pskb_may_pull() or skb_ensure_writable() at all, and the caller treats the
range as validated.

On the IPv6 path ipl is not bounded.  tcf_csum_ipv6_hopopts() can overwrite
pl with the full 32-bit Jumbo Payload value:

net/sched/act_csum.c:tcf_csum_ipv6_hopopts() {
	...
			*pl = ntohl(*(__be32 *)(xh + off + 2));
			goto done;
	...
}

so with pl = 0xffffffc8 the caller passes len = ipl = 0xfffffff0, where
(int)len == -16 and ntkoff < 0 makes offset + (int)len > 0 false.
tcf_csum_skb_nextlayer() then returns skb_network_header(skb) + ihl and the
L4 handler walks the claimed length:

net/sched/act_csum.c:tcf_csum_ipv6_icmp() {
	...
	skb->csum = csum_partial(icmp6h, ipl - ihl, 0);
	...
}

The removed pskb_may_pull(skb, ipl + ntkoff) rejected this input
(0xfffffff0 + (-20) = 0xffffffdc, pull fails).  Should the helper reject
lengths it cannot represent instead of returning success, and should the
kernel-doc claim "Check the expected next layer availability" still hold?

[Severity: High]
This isn't a bug introduced by this patch, but tcf_csum_sctp() recomputes
the offset independently of this helper and hands it to an unsigned
parameter:

net/sched/act_csum.c:tcf_csum_sctp() {
	...
	sctph->checksum = sctp_compute_cksum(skb,
					     skb_network_offset(skb) + ihl);
	...
}

include/net/sctp/checksum.h:sctp_compute_cksum(struct sk_buff *skb,
						unsigned int offset) {
	struct sctphdr *sh = (struct sctphdr *)(skb->data + offset);
	__le32 old = sh->checksum;
	...
	sh->checksum = 0;
	new = ~skb_crc32c(skb, offset, skb->len - offset, ~0);
	sh->checksum = old;
	...
}

ihl comes from iph->ihl * 4 and tcf_csum_ipv4() never checks iph->ihl >= 5,
so ihl == 0 is packet selectable; with ntkoff == -20 the offset becomes
0xffffffec and both sh->checksum writes land roughly 4 GiB past skb->data.

Since this patch declares negative network offsets supported, and the new
offset + (int)len <= 0 branch admits packets that pskb_may_pull(skb,
ipl + ntkoff) previously rejected, does this widen the set of packets
reaching that write?  Should tcf_csum_sctp() also go through a signed,
bounds-checked path?

>  
>  /**
>   * tcf_csum_skb_nextlayer - Get next layer pointer
>   * @skb: sk_buff to use
> @@ -138,8 +150,7 @@ static void *tcf_csum_skb_nextlayer(struct sk_buff *skb,
>  	int ntkoff = skb_network_offset(skb);
>  	int hl = ihl + jhl;
>  
> -	if (!pskb_may_pull(skb, ipl + ntkoff) || (ipl < hl) ||
> -	    skb_try_make_writable(skb, hl + ntkoff))
> +	if (ipl < hl || csum_ensure_writable(skb, ntkoff, max_t(unsigned int, ipl, hl)))
>  		return NULL;
>  	else
>  		return (void *)(skb_network_header(skb) + ihl);

[Severity: Medium]
Is the change of the requested writable length intentional here?  The old
code asked for hl + ntkoff (mac_len plus IP plus L4 header); the new code
asks for ntkoff + ipl, the whole packet length taken from iph->tot_len or
the IPv6 payload length.

Because the ipl < hl test short-circuits first, ipl >= hl always holds when
the helper runs, so max_t(unsigned int, ipl, hl) is always ipl and the
max_t() looks like dead code.

The widened length also disables the clone fast path:

include/linux/skbuff.h:skb_clone_writable() {
	return !skb_header_cloned(skb) &&
	       skb_headroom(skb) + len <= skb->hdr_len;
}

For transport clones (__skb_header_release() plus skb_clone(), i.e. every
non-GSO TCP transmit skb) hdr_len - headroom covers only the mac plus IP
plus TCP bytes pushed after cloning, which satisfied hl + ntkoff but never
satisfies ntkoff + tot_len.  Those skbs now take
pskb_expand_head(skb, 0, 0, GFP_ATOMIC) in skb_ensure_writable() per
packet, and when that allocation fails the action drops a packet that was
previously forwarded without allocating.

The callers only write inside the L4 header, so would hl be the right
length to request, and should the changelog mention the per-packet copy?

> @@ -437,7 +448,7 @@ static int tcf_csum_ipv4(struct sk_buff *skb, u32 update_flags)
>  	}
>  
>  	if (update_flags & TCA_CSUM_UPDATE_FLAG_IPV4HDR) {
> -		if (skb_try_make_writable(skb, sizeof(*iph) + ntkoff))
> +		if (csum_ensure_writable(skb, ntkoff, sizeof(*iph)))
>  			goto fail;
>  
>  		ip_send_check(ip_hdr(skb));

[Severity: Medium]
Can this new call ever run for the negative offsets the changelog talks
about?  Earlier in the same function the entry gate is untouched:

net/sched/act_csum.c:tcf_csum_ipv4() {
	ntkoff = skb_network_offset(skb);

	if (!pskb_may_pull(skb, sizeof(*iph) + ntkoff))
		goto fail;
	...
}

sizeof() is size_t, so a negative ntkoff is converted: the sum is exactly 0
for ntkoff == -20 (passes) and wraps for ntkoff <= -21 (pull fails).  The
new headroom COW in the IPV4HDR branch is therefore unreachable for the
deeply negative offsets.

The changelog names "sizeof(*iph) + ntkoff" as one of the expressions being
fixed, but that expression is left in place.

tcf_csum_ipv6() also keeps four such computations:

net/sched/act_csum.c:tcf_csum_ipv6() {
	if (!pskb_may_pull(skb, hl + ntkoff))
		goto fail;
	...
			if (!pskb_may_pull(skb, hl + sizeof(*ip6xh) + ntkoff))
	...
			if (!pskb_may_pull(skb, hl + ixhl + ntkoff))
	...
	} while (pskb_may_pull(skb, hl + 1 + ntkoff));
}

so the IPv6 half still rejects negative offsets while feeding the now
negative-offset-tolerant tcf_csum_skb_nextlayer(), and tcf_csum_sctp()
still passes skb_network_offset(skb) + ihl unsigned.  Should negative
ntkoff be handled in all of these places, or rejected once at the top of
both tcf_csum_ipv4() and tcf_csum_ipv6()?
-- 
pw-bot: cr
