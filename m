Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A437B402;
	Sun, 27 Sep 2026 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790508682; cv=none; b=WIgpEt6cZR7AiZgB9IG5XVmvBFoxL6dSHqSTSreMWHx32J0bPlnso0pKiMHeAqXddbfjQpnNfG86XI9oHy8nN4hTJvclUUmLzxh6qJuyNrgmlaWrtNkhSB39iROPbYC7o2y3w9cN86/os9aUUVQGXxfcdWMxlKQIFQBuwAUjjZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790508682; c=relaxed/simple;
	bh=gvgyza77N7QnyYYehYzgRJu/cmlb0XtrTuOYfiqjKQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYW22dPeGYWtW0KJB+AR4mmok2s00HyFTyy5zo7m0y+pV9Zk8BdkcrpkgyrmdzYsD3XcPm/w0g+EwypzseFaSpwNhuz/hBWb5D5B4mUuqNQaEmK/jDpVnY9kKlxvVyGh3lSuyy4CmPCDGLXzQj+4IUVDW+EGElNWB1xnDsSZASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSNqHkr1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSNqHkr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336471F000FF;
	Sun, 27 Sep 2026 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790508681;
	bh=k9FG9PmEH6E2I7yDzIB5tEBsu1/Jt8Pb9DQ2kexMBEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mSNqHkr1QLnO+xExH127wfNtU3hPXg5b9rRpPaCqSPKNEWBAni+2y3qdKwQZIZnoD
	 tvwcAVgBTNBZiPaeJBG3rh45KEZTnOvuIS2h+Ima3RZAzMzwsy8ZpGb04OvCBV7fvv
	 ps0aRW7MrBE9PW1+n44VBgWhhuQ75VGzfmr46Z/AcVD9eNI+JvZ6O1VHZCNwBZEb7r
	 E0rHNjrXeKXlM0hsXhflfM/UInprcgRuvoKVoU6WOh4fS+l2zJ937l4RVZBeMq4myM
	 JoigMvK9QwCbx7n7gxqAOisoOOl/Ds0MieSOGxnM+u+u4PTGKlOprY1MHxh54o3SHw
	 VSAO3xcNB1hlg==
Date: Sun, 27 Sep 2026 12:31:17 +0100
From: Simon Horman <horms@kernel.org>
To: Yuchao Zhang <ndaugoing@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, toke@redhat.com,
	jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: sch_cake: prevent shaper corruption and
 stall in cake_overhead()
Message-ID: <20260927113117.GI13925@horms.kernel.org>
References: <179000041222.2160803.11108326722307773525@kernel.org>
 <20260922084124.36858-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922084124.36858-1-ndaugoing@gmail.com>

On Tue, Sep 22, 2026 at 04:41:24PM +0800, Yuchao Zhang wrote:
> In cake_overhead(), the header length up to the transport layer is
> computed using logic borrowed from qdisc_pkt_len_segs_init():
> 
>         /* borrowed from qdisc_pkt_len_segs_init() */
>         if (!skb->encapsulation)
>                 hdr_len = skb_transport_offset(skb);
>         else
>                 hdr_len = skb_inner_transport_offset(skb);
> 
> However, cake_overhead() suffers from several issues:
> 
> 1. When segs == 0 (e.g. from dodgy GSO packets where gso_segs is not
>    recomputed), the multi-segment arithmetic underflows: (segs - 1) wraps
>    to 4294967295, causing cake_calc_overhead() * (segs - 1) to produce
>    an enormous length. When charged in cake_advance_shaper(),
>    time_next_packet is pushed decades into the future, permanently
>    stalling the CAKE dequeue queue.
>    Fix this by returning cake_calc_overhead(q, len, off) for segs <= 1.
> 
> 2. When the transport header was never set, skb->transport_header holds
>    the sentinel value ~0U. skb_transport_offset() returns ~65535, which
>    is not caught by a negative offset check. skb_header_pointer() fails,
>    and hdr_len stays ~65535, charging ~66 KB per segment to the shaper.
>    Fix this by mirroring qdisc_pkt_len_segs_init() and checking
>    unlikely(!skb_transport_header_was_set(skb)).
> 
> 3. Both skb_transport_offset() and skb_inner_transport_offset() return
>    signed int, but hdr_len is declared as unsigned int. If post-enqueue
>    mangling (such as BPF packet trimming via bpf_skb_net_shrink())
>    produces a negative offset, hdr_len wraps to near UINT_MAX, causing
>    corrupted header length accounting.
>    Fix this by declaring hdr_len as int and falling back to
>    cake_calc_overhead(q, len, off) if hdr_len is negative.
> 
> Fixes: a41851bea7bf ("net: account for encap headers in qdisc pkt len")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
> ---
> v2:
>  - Accurately describe the impact as shaper accounting corruption / stall
>    rather than OOB read past the allocation per Sashiko review.
>  - Fix pre-existing high-severity integer underflow when segs == 0 by
>    checking segs <= 1.
>  - Import companion check !skb_transport_header_was_set(skb) from
>    qdisc_pkt_len_segs_init() to prevent unset transport header sentinel
>    (~0U) from inflating packet length to ~66 KB.


Please do include lore.kernel.org links to earlier versions in
the changelog. This helps tremendously with review.

Please do not post updated patch revisions as responses to earlier versions.
Rather, please start a new thread for each version.

Thanks!
