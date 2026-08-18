Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2E40EBA6;
	Tue, 18 Aug 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039733; cv=none; b=XBg6mH5cb7vBUrE6zyIHZBUFMoAj8pK5V/OxCUc6TvVa82Yssv9zIxJIA7qdGVdOF02d9pp1LucIpFW6MidqjqHwchBPtwhsGzHb4AGlU5RHq9lqRYviW8we4Ghg0bsOc91OnLaQ6/UEhGwK6/89bQE3t9GHs7SdcRxvR/LWfSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039733; c=relaxed/simple;
	bh=eFzmdhqQ5BpanUeVM29on0nJk9Nw8ZpWAzZ/cXvHd6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afKKrQU3EEMhOrt4fAisxkgSG6cc7ydZuG30+s7/5ZAGOtPQpyqebxBv7U/XffviCq53AMEBlqgDvrNNGyabXzwece1P8qrSQsSlD1TVltauL7xpSLgr8LDAwEP82YEuKKVOj/ZedKML1taBeiuvdCaDGVupQuououXxYPNOePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRT/BkZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRT/BkZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2041B1F000E9;
	Tue, 18 Aug 2026 07:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787039730;
	bh=QZnporgsCvtWMtob1znBR7f2kEfoTXRZyh1wuITxSwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MRT/BkZC5TF+OlMKxH4IYVL9qoTOTMlB2nxo6Y4AUHKnrKi2gRnq6eAsGbrQ8Ihg3
	 Ejudxth0LEqR+RTcZvOXWxxIfAeAr+jTAqyr7izd5XRFtPo/Mn2etk0xJRDlDjmn/N
	 /uGWdgHBcTIPNsVaFITcRtal/INbPQUAyfFws8W50dvHyOV3GtdoU8t3icOozL+1Ol
	 tpoZCxzDIN8uBBrJO5qLdhZZIuZWpzmntUi3flXc2ttyW97oFN+ManIfNrfbY1fwkF
	 ubzILSslg1FvJKAMxpnVbFFiRvwbXxHgDQCHPVT8aCy8zY7vxTWUbaYMbmPmlyXIRG
	 IVWsLolEMLLQQ==
Date: Tue, 18 Aug 2026 08:55:25 +0100
From: Simon Horman <horms@kernel.org>
To: Qing Ming <a0yami@mailbox.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	David Ahern <dsahern@kernel.org>,
	Robert Shearman <rshearma@brocade.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] mpls: reload header after pskb_may_pull()
Message-ID: <20260818075525.GA265046@horms.kernel.org>
References: <20260814095404.7205-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814095404.7205-1-a0yami@mailbox.org>

On Fri, Aug 14, 2026 at 05:54:04PM +0800, Qing Ming wrote:
> mpls_select_multipath() calls mpls_multipath_hash() to choose a nexthop
> when an MPLS route has multiple nexthops.  While walking the MPLS label
> stack, the hash routine caches hdr for the current label.  After finding
> the bottom-of-stack label, it calls pskb_may_pull() before reading the
> inner IP header.
> 
> If an skb is constructed with the inner IP header in nonlinear data and
> insufficient tailroom in the linear head, pskb_may_pull() calls
> pskb_expand_head() to replace the skb head and free the old one.  This
> leaves hdr pointing to freed memory.  The IPv6 path can invalidate hdr
> again when it performs a second pull for the larger header.
> 
> The issue was found through static analysis.  A reproducer sending a legal
> Geneve packet through a bareudp/MPLS multipath setup triggered the same
> KASAN report in 2 of 2 unpatched runs:
> 
>   BUG: KASAN: slab-use-after-free in mpls_select_multipath
>   Read of size 1 at addr ffff88800ecc6e20 by task ksoftirqd/1/23
> 
>   Call Trace:
>    mpls_select_multipath
>    mpls_forward
>    __netif_receive_skb_list_core
>    netif_receive_skb_list_internal
>    napi_complete_done
>    gro_cell_poll
>    __napi_poll
>    net_rx_action
> 
>   Freed by task 23:
>    kfree
>    pskb_expand_head
>    __pskb_pull_tail
>    mpls_select_multipath
> 
> Reload hdr from the current skb head after each successful pull before
> deriving the inner IPv4 or IPv6 header pointer.
> 
> Fixes: 9f427a0e474a ("net: mpls: Fix multipath selection for LSR use case")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qing Ming <a0yami@mailbox.org>

Reviewed-by: Simon Horman <horms@kernel.org>

