Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEF8392C50;
	Thu, 20 Aug 2026 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250465; cv=none; b=PJitFOnPNZ2qzHfpWrdqlZDttEuzm/JktuhPpvp8se63+fO/34mLUlRHIhTRbdjy64DOAsy53SjjN5xu2sgx7NUMZi2FYk7eIZHDqJA4jvQjWXhdhVeoWukCGKu/acznDt0CBwy1rxBAoc34MTjryVtDSZlq1ySAyDITx31ZKq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250465; c=relaxed/simple;
	bh=wOiDV+jQCpPAcRx+Yu245WzQwVmiIzrh+jvFMUipWf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZqTc9AoP7IOVPXyYca1U6KW23JX0AuGeUaP/LSkC6ztgpfZ6cED7F6RlLdrsbKXPrkoYF9h30ZxUR4uAE/PaF1ebkCuMO8Qn40ZDdVZnat/uPRIQw/21xVGJcZuotqY/Jhw45fna93pluESHjavclZnYyoWGDlX27XG1DmAOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtgAp7Pd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtgAp7Pd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981AD1F00A3D;
	Thu, 20 Aug 2026 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787250463;
	bh=AgLNeNi5euhDeFde3JpbiO8thnW+lPNsPaFu+Vg8n3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DtgAp7PdB+BewxMTWb1RY9hrHeRb28zCmBj1H26a+XZC6L5NyNNWrJqfsVPxywSC+
	 BEVPFEdUYXuUlRl0T6x2TUSv/KFryO3WMLqWHqLJpyTwbh71vTVrXT47IpSr5JIyQv
	 WEUVuQ+aSY2zJq3cyS1OM6w5ZUvpUE0XUTRtiEeD/n6TtTmJlF1KatYlO4Gfy9v1/t
	 jNiI3Y02WP9X2RlwH1l3+DJGqQ3IXiSZeyeAUATLxTAOn47S5hpqm5gbrmVgsG+5ZZ
	 KJ5VhRbe3V3JP5s5qg4KkE/QDHe6/Gz27xDVXkgnXamqY/RB/+1buDu+sKW9A7XC7h
	 z5/6qssEscTEQ==
Date: Thu, 20 Aug 2026 19:27:39 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	david.ward@ll.mit.edu, vega@nebusec.ai, victor@mojatatu.com,
	zhanxusheng1024@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: sched: fix 32-bit backlog wrap in gred,
 bfifo and plug enqueue
Message-ID: <20260820182739.GC265046@horms.kernel.org>
References: <20260818095927.15901-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818095927.15901-1-jhs@mojatatu.com>

On Tue, Aug 18, 2026 at 05:59:27AM -0400, Jamal Hadi Salim wrote:
> gred_enqueue(), bfifo_enqueue() and plug_enqueue() admit a packet when the
> current backlog plus the packet length fits within the queue limit:
> 
>   sch->qstats.backlog + qdisc_pkt_len(skb) <= sch->limit (gred default VQ)
>   gred_backlog+qdisc_pkt_len(skb) <= q->limit  (gred configured VQ)
>   sch->qstats.backlog + qdisc_pkt_len(skb) <= sch->limit (bfifo)
>   sch->qstats.backlog + skb->len <= q->limit             (plug)
> 
> sch->qstats.backlog and q->backlog are u32, and qdisc_pkt_len()/skb->len
> are unsigned int, so all sums are computed in 32 bits and wrap at 2^32.
> Once the true backlog exceeds 4 GiB the wrapped sum becomes small and
> admission keeps succeeding, so the queue grows without bound and the kernel
> can be driven to OOM.
> 
> Promote the sums to u64 so admission stops once the true backlog exceeds
> the limit.  The limit is u32, so the bounded queue stays below 2^32 and
> the stored u32 backlog never wraps.
> 
> The bug can only be reproduced as root (albeit with ridiculous setup):
>  attach a gred (or bfifo/plug) qdisc with a limit near 4 GiB,
>  leaving the default VQ unconfigured (for gred), and drive >4 GiB of
>  queued traffic (e.g. via a size table / stab to inflate qdisc_pkt_len,
>  or sustained high-rate traffic). The u32 backlog+len sum wraps at 2^32,
>  admission keeps succeeding, and the queue grows unboundedly to OOM.
> 
> Fixes: a3eb95f891d6 ("net_sched: gred: add TCA_GRED_LIMIT attribute")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
> v1->v2:
> 
> 1. Added bfifo+plug into the same patch as gred since it is the same
>    pattern. Flagged by Zhan Xusheng and Sashiko[1][2].
> 2. Starting this patch, and for the rest of AI found bugs,  i will start
>    adding the conditions required to reproduce the patch (see the
>    above commentary "The bug can only be reproduced as root...").
> 
> [1] https://sashiko.dev/#/patchset/20260809091657.879929-1-jhs@mojatatu.com
> [2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809091657.879929-1-jhs@mojatatu.com

Reviewed-by: Simon Horman <horms@kernel.org>

