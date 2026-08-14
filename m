Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFCA44C66D;
	Fri, 14 Aug 2026 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698454; cv=none; b=OBC4TP/NFpc4ZmRojtjdQ47PH5S3u3IU1y6G3H2yfyiiJ0ilvp0QMpBhA6SP2cW722tpPV6evoPl9zmMwloVFeTe7UjgPRgYMXuIkfZ32sQgVouR1DW6/tO8ehCZdYyAlpdFZ0YvseRktGYZ2m6rlNsIAXDXMzStpgGOhtHAAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698454; c=relaxed/simple;
	bh=2H53DttV5BdZmzreQWs0C+zv9sMRKgxsrWwHz2IaFnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHl2sFGmv+9+loAjVhjpPpZrDCklUDwXJGR7SaGs/IeTQQCldl5KqjwrHEJB19x3qZ7nOEgVw6+lERYmvKbKweAA/rtuSsfFMj7lUF0Vf7wng15ETLgsiohAHiHY045nKfNM5SJfKsfNWwqAYN+sc0w5OVL3g48bpO42kf7G0qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrDcHrek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrDcHrek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FAA1F000E9;
	Fri, 14 Aug 2026 09:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786698452;
	bh=oQuZysmKK6PrvHBQnl/k8KCAszznUjD2fZKyBp7qo9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mrDcHreksz0lD1JAi3AcNxO9iDKeN/55r3qiwzhSKgBGHwA/DFrl5gMUOj903YGOJ
	 u6cqXW/UhCMO7bGw5xxwCEYjYV8SdUB0F4JDub/DVGxytLL+Aq3GT2/yq131q1c8V6
	 8ax9IUekMd/QN1Wy/naiBKFIDq1EKUkgyn3kIC6+F/8z7mwwUqqlKW7ttTluxE7TZB
	 etdBZhAnZHV5a+F1wEiLbYmnxiyV0nLKF2OkhzHMfHiwdMGugVmXRvAQlCfEU71KZ2
	 MFXi0cLZL343t5LPgtw/Ypxv5cOEeF7/4y2QmdJH1rOveLQuupwN/H1Rs34PA6spIh
	 es6gE/6xASwkQ==
Date: Fri, 14 Aug 2026 10:07:28 +0100
From: Simon Horman <horms@kernel.org>
To: Qi Zhang <marsy12010123@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	nicoyip.dev@gmail.com
Subject: Re: [PATCH net v2] net: pktgen: use a consistent flow count
Message-ID: <20260814090728.GJ265046@horms.kernel.org>
References: <20260812052130.32823-1-marsy12010123@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812052130.32823-1-marsy12010123@gmail.com>

On Wed, Aug 12, 2026 at 01:21:30PM +0800, Qi Zhang wrote:
> pktgen_if_write() can update cflows while the packet generator thread is
> inside mod_cur_headers(). The latter first tests cflows, but f_pick() then
> reloads it when selecting a random flow.
> 
> This allows the following interleaving:
> 
>   CPU 0 (kpktgend)                 CPU 1 (proc write)
>   if (pkt_dev->cflows) // 10
>                                    pkt_dev->cflows = 0
>   get_random_u32_below(pkt_dev->cflows)
> 
> get_random_u32_below(0) returns a full-width random value. Using that
> value as an index into the fixed-size flows array causes an out-of-bounds
> access. The kernel reported:
> 
>   BUG: unable to handle page fault for address: ffffc8fe2d2674bc
>   #PF: supervisor read access in kernel mode
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   CPU: 0 UID: 0 PID: 65 Comm: kpktgend_0
>   RIP: 0010:mod_cur_headers+0x16f8/0x2840
>   Call Trace:
>    <TASK>
>    pktgen_thread_worker+0x305a/0x6bc0
>    kthread+0x2c6/0x3b0
>    ret_from_fork+0x36e/0x5a0
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> Read cflows once at the start of mod_cur_headers(), pass the snapshot to
> f_pick(), and use it for later flow-state decisions in the same packet.
> Publish proc updates with WRITE_ONCE(). Flow selection then always uses a
> nonzero count bounded by MAX_CFLOWS, while a concurrent update takes
> effect on a later packet.
> 
> Fixes: 007a531b0a0c ("[PKTGEN]: Introduce sequential flows")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> Signed-off-by: Qi Zhang <marsy12010123@gmail.com>
> ---
> v2:
>   - Use the written value when reporting the new flow count.
>   - Add READ_ONCE() to the remaining lockless cflows reads, including
>     pktgen_if_show(), as suggested by Paolo Abeni.
> v1: https://lore.kernel.org/r/20260802152309.821584-1-marsy12010123@gmail.com

Reviewed-by: Simon Horman <horms@kernel.org>

