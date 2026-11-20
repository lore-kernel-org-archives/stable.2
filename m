Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164347;
	b=FKG/aQ0fUIu4MlQ7A706RD46rskSkUm/sUn/WJQlfQUeNbUsLxfZ0VyxplsoNZQdoN2N
	 dTvI2YBwzrzJCpW/p+R+QvzB6qPON4rKL1TrFRVNwR56tSbbnTvgSgSRQGL2IJWVDKjxk
	 8cGB6Wcg95cdnJOzLD6fDCCcYD+GfxbX+0qDVIKGvXrq/Yobh3QgHRmsr0sSiVF/ZElt1
	 By/OwW6QksU1Afqt5UG7XaXaNeBPUvdd7zuW279UWnjDVR6ser7q/Ztw01Iv35D/OqXxe
	 e+0BMlUxRX0Eky50MNsukIIzRG+sJE6z0IRqN+GHgyTMZV7LCsi4CmmwyE45HhdjK0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164347;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 DKIM-Signature;
	bh=4VvTXkf2XeNKXdsZD2LZXbg3e98NlnzNngOW4jq286s=;
	b=fQ2x0sRQrsBamVXpd2X2fc0gmcN+jjEk+DAQRq3xURiAHc4NC0Xv/onY6O+EH3ZSoZw2
	 Mmo+6XyuqXzJMbv1zdb6ghVZcukjSURXn1pWhBY0uXr1gS4AKodaZDNTS/kRttjwlHE7s
	 Cb501ffh4gE8Km4Pbfc/WBIPjiDW9czxQJzVpXVTOkN+yJRiICEzPIcZp5GV6P8Z15nOG
	 Wt/DYzaFc3CPP5rTpWD/roybIvVaLL7KoJfVGjSz6bgsE1fItnl/3TpYfq9nJBRUCHvDd
	 8Y+kN88uclw2O6fkfGcTloa30HccqbqgMi+N3ComfezG5jAha+voxsf2/yBDNwDH5jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b="T/tpUyWN";
	arc=none smtp.remote-ip=217.74.67.49
Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01D5606A88D
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E01D5606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=T/tpUyWN
Received: from nr200 (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Fri, 20 Nov 2026 09:45:32 +0100 (CET)
Date: Fri, 20 Nov 2026 09:45:30 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, bpf@vger.kernel.org, netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com, tianyi@cloudflare.com,
	tavip@google.com, toke@redhat.com, aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org, lorenzo@kernel.org,
	magnus.karlsson@intel.com, ihor.solodrai@linux.dev,
	edumazet@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, memxor@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
	stable@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v7 bpf 2/5] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <awAIqhZWK9mr_zGQ@nr200>
References: <20261119133032.2015656-3-sst@poczta.fm>
 <fd9b43958f6297b0031158bd33bdc6cc54f3c9338a4ee2e30bd6e50acf775a60@mail.kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd9b43958f6297b0031158bd33bdc6cc54f3c9338a4ee2e30bd6e50acf775a60@mail.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1795164337; bh=4VvTXkf2XeNKXdsZD2LZXbg3e98NlnzNngOW4jq286s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=T/tpUyWNIBy5mAXGlC65E8/588bEAvTDs3fLQFnzPRJNU87ADHOgwp89hhFYNyY3U
	 K2/s1S8Sjy45DwfdGPSuWqO2ZIHaZmKXKHxuYaJXAAy8QWfNcxpDUjCq5DsXvmSai+
	 irHYLrWoQjdczFqq+KHoDzhRZOx1kA58lHZU4zto=

On lis 19, 2026 14:11, bot+bpf-ci@kernel.org wrote:
> > xdp: introduce xdp_convert_skb_to_buff()
> 
> TL;DR:
> - Commit message calls the bug a page leak; it may be a use-after-free of
>   page_pool pages
> - Stable Cc 6.4.x predates the Fixes: tag (v6.9)
> - kdoc may overstate mem type usage (nit)
> 
> > Then when bpf_xdp_adjust_tail() calls
> > __xdp_return(), it acts incorrectly due to mem type not being set to
> > MEM_TYPE_PAGE_POOL and causes a page leak.
> 
> Is "causes a page leak" the full impact?
> 
> The mechanism is bpf_xdp_adjust_tail() -> bpf_xdp_frags_shrink_tail() ->
> bpf_xdp_shrink_data() -> __xdp_return(netmem, MEM_TYPE_PAGE_SHARED) ->
> page_frag_free().  That ends in put_page_testzero() on a page_pool page.
> 
> With page checks enabled this is reported as "page_pool leak" and the page
> is not freed.  Without them, page_pool keeps _refcount at 1 and counts
> fragment users in pp_ref_count, and skb_pp_cow_data() allocates
> fragment-sized chunks.  A single page_frag_free() can therefore hand back
> to the buddy allocator a page that other skbs or pool->frag_page still
> use, which looks like a use-after-free rather than only a leak.
> 
> Could the commit message describe that?

Yes, I will add that do commit message in v8.

> > Cc: <stable@vger.kernel.org> # 6.4.x
> 
> The Fixes: tag points at e6d5dbdd20aa, which first landed in v6.9.  Before
> that, generic XDP linearized every skb and never set the frags flag, so
> this bug cannot occur on 6.4 through 6.8.
> 
> The later veth patch in this series (1d3541dbf827) appears to be why 6.4.x
> is listed, since it uses this helper and needs it as a backport
> prerequisite.  Could the commit message either say that, or align the
> stable range with the Fixes: tag?

Sure, v8 will describe that in v8.

> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> 
> [ ... ]
> 
> > +/**
> > + * xdp_convert_skb_to_buff - build an xdp_buff on top of an skb
> > + * @skb: skb to describe, packet data is taken from its MAC header onwards
> > + * @xdp: xdp_buff to initialize
> > + * @xdp_rxq: Rx queue info to attach to @xdp
> > + *
> > + * The memory type set on @xdp_rxq is only used to release fragments that
> > + * the XDP program consumes; the head can not be freed from under the skb.
> > + * A non-linear @skb is expected to have gone through skb_pp_cow_data(), so
> > + * all of its fragments are page_pool backed.
> > + */
> 
> This isn't a bug, but is the "only used to release fragments" statement a
> property of this helper, or of its current caller?
> 
> It holds for generic XDP.  However, the veth patch later in this series
> (1d3541dbf827) converts the xdp_buff to an xdp_frame on XDP_TX and
> XDP_REDIRECT, where the head is released through the same mem type, and it
> has to overwrite rq->xdp_rxq.mem after calling this helper.

True, will add that info to commit message in v8.

> The kdoc also does not mention that the mem type stays set on the caller's
> possibly shared @xdp_rxq after the call.  Should the kdoc say that these
> properties depend on the caller?

Yes I agree. Will add in v8.

-- 
Slawomir Stepien
