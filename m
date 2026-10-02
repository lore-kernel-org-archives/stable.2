Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DAA192D8A;
	Fri,  2 Oct 2026 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960204; cv=none; b=ftJoqdYzZMgl1maNB/E6eCnWFDyQR1HPH/LgZq4HN67bfrC5tHi5qN9j5ZuBm3alw4b7elAcO4wN7Jmk8DKBMn5cXDRmA5qkGHyBL7nnEMQOzV/dvNnpSKD1gMb2Ht0mY16lYDT0mHRgJgd9Is+WWmHMqZceTtqbMrgBVQ3GwNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960204; c=relaxed/simple;
	bh=2A9iNhROlSsA0mOWc9g+z23siVj5b9QEKtEyEM17NKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMGf9IcIRwBG5kBkX9MjcIOFW4j96sTw/jzn52d+twSBklp80XH6KOBixlNj1A12m8NrTi8Z205Dkd6nrt1m/MzgAHbcDM5ROy0klslbAa1SNgajMYcO6M1VGoxlJiLVbRzy653HjZD9DRfKZPDOWHgSzxqTiCp5yPJE59E1QDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFFFnF8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFFFnF8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF95A1F000FF;
	Fri,  2 Oct 2026 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790960201;
	bh=moeRk3aQO11pRsdJuuF0MNfeZBb1U8N8My9vy7rQStw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VFFFnF8KUbE5p2bz3UmSZ3g2tqdKFKFNpOQNHBDrgSwGhVb6k4OlIXGSS0kZKCX7H
	 zLob1AzwXN3X8/J230xLlLywAugfCnPyFO6KRv3xzzFrGiIYD+vokLLJ/9mOseZBOL
	 kpOlN+4Tr2Xn1lWtca34Ue6hNUczNQ6J+mBMsrLlEfXmFfm4NEq8JxqYEZa75kMBLJ
	 HZRh23/y9794BNNjrggMNjqEJ1u8V+U0OUaTZYzx0GI9erq3X+qZj+YrK65S3zfo6x
	 ufGNd2FYHiNPolulsE5QyRDev5LgohVW6NGTOo+DexZWMUBFe0IDpM4Cd3M+06PDli
	 7KTCNrlRkqwFQ==
Date: Fri, 2 Oct 2026 17:56:36 +0100
From: Simon Horman <horms@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>,
	stable@vger.kernel.org, hybris <hybris@mojatatu.ai>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net 1/2] net/sched: cls_route: reject change with no
 routing attribute
Message-ID: <20261002165636.GJ13925@horms.kernel.org>
References: <QDISC-0JB3.v1.20260929143022@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QDISC-0JB3.v1.20260929143022@mojatatu.com>

On Thu, Oct 01, 2026 at 12:32:00PM -0300, Victor Nogueira wrote:
> route4_change on a filter change that supplies no routing attribute
> at all (no to/from/iif) reaches route4_set_parms with fold set, so the
> handle-mismatch check -- which only fires when creating -- is skipped.
> nhandle is built as the all-wildcard bucket (0x8000 | 0xFFFF << 16) and
> the filter is rekeyed to 0xFFFF8000, so the handle userspace already
> stored no longer addresses the filter. (The netlink reply carries the
> new handle; what goes stale is the handle the caller holds.)
> 
> The rekey actually misclassifies the packets. The new handle's from_hash
> is the wildcard chain (route4_hash_wild), whose filters route4_classify
> applies without any id/iif comparison, and its bucket (256) is reached
> by every packet through the h < 256 restart. A filter that matched only
> a specific realm therefore becomes an unconditional catch-all that applies
> its classid and actions to all otherwise-unmatched traffic.
> 
> Reject a change that would rekey the filter this way, with the
> routing-attributes-required error. A change that names at least one of
> to/from/iif, and an in-place replace that keeps the routing identity via
> a supplied attribute, are unaffected. A change of a filter that already
> sits at the wildcard handle is a metadata-only update and remains valid,
> so only a change that actually moves the handle is rejected.
> 
> This is a follow-up to commit 41e85e54e564 ("net/sched: cls_route: Fix
> in-place replace"); this patch closes the no-routing-attribute variant
> that the parent series did not address.
> 
> Conditions to recreate the bug:
>   tc qdisc add dev lo clsact
>   tc filter add dev lo ingress protocol ip pref 100 route from 1 to 1
>   tc filter change dev lo ingress protocol ip pref 100 handle 0x10001 \
>       route classid 1:2
>   tc filter show dev lo ingress   # handle became 0xffff8000; iproute2's
>                                   # stored 0x10001 no longer addresses it
> 
> A change of a filter already at the wildcard handle, e.g. one created by
> "tc filter add dev lo ingress protocol ip pref 100 route classid 1:1"
> (iproute2 defaults the handle to 0xffff8000), stays a valid metadata-only
> update.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907192133.2639067-1-victor@mojatatu.com
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>

