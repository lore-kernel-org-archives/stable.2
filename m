Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097486;
	b=tTRaRlxiQImsy95yIPr+zhDQtYXEv+Baf6knimNs5/goNhc3IPqNeusBI0B4+3WRf8sK
	 AW6Z0VjQ3u0kMX9AHDiAJ0cUlH1Oxvx/WLQMYouoJOfCdiIbT+64qwGK6/7AEEEIWRyQN
	 6F904f1UZvs/ZnMfvAykSVS1XjE0mlBCLKcIbqmsCHXZyzfmxGDdIzpafyaQ+QUWJrsMG
	 Zrg+mOSFBv8rKqaX8sKJByRNM17Di1H1sBJPfUq9NJxkWNHKD+gGoRcfvBlNqxGUzhVbL
	 cZ8zR3uJLTH2Yvs+FPJgTY2vlenS/qvJIE1mCakBK30uBd5nhat6iEI/Qbnd/xyl05w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097486;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=bf3s9RgIY82SmvQaR+hK80LHud4bx2Ddycs3hcBL9WE=;
	b=0d0jJWvCN79UOh0Oi4/qUmyAb2lNVdnI/N89sapk1ZzsZ+4Mx8BN2s9MDoy8SVt5Dyz7
	 RrMl/ifCFVC2HBPnVr1KPykLozt9wzFYWbHK/TU1NFrBfracaHp2YI/ApGSz9bJd1uBiu
	 hoO+XQyCJnTgK58Tlr+TB9ZDj4011Hj8qkRWMz4JLAa435q1Yo4DPNRIbphtRqB34+edj
	 zeQyJ8hbaul2yoCGx2tDfm1w+88I3eIuYHYfGTIs22/lSSgGKztp6950rD8Dr8bBrlRp0
	 8GrbfXh/J9pJwHXrZE7I/auYP6d5kNcmqXBSffQ+ZNvDQgfeHkaMRODh7UHv40j1Kog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omL137Mu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F71760A260D;
	Thu, 19 Nov 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omL137Mu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7C51F000C4;
	Thu, 19 Nov 2026 14:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795097485;
	bh=bf3s9RgIY82SmvQaR+hK80LHud4bx2Ddycs3hcBL9WE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=omL137MuvhpSe/wi/xx9MkwCYV21C8J9Cb4ElascXr7mkFMGFmXiY8OnZVKOOR3mL
	 3bL0SAe1KMfdMgTA9wEg7Fs5s/Tn4PKAqn4xrzYQ4zr7BgRwLQWSOtxP6ezTe2LNaD
	 a/V/epuUf6QZhSWcmV41KLbjXam4m9+1m6qQn3dBzC5e9r96Jgp36R51qTo1OMUFHm
	 J0G2fxgmvx5w18IQ5tlJEeSib9VGzFw23oMyJeUiUXTDJRri43ILTYRovHvHjO9l7s
	 lHtxfXqi1Qpur9WnmJjwlyCbIJ8fHxSduGm/+N82MzRTkKDzJq/oBO1/gx+i1mrKwa
	 uHuZPEBYhTjaw==
Content-Type: multipart/mixed; boundary="===============5181703165338020747=="
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fd9b43958f6297b0031158bd33bdc6cc54f3c9338a4ee2e30bd6e50acf775a60@mail.kernel.org>
In-Reply-To: <20261119133032.2015656-3-sst@poczta.fm>
References: <20261119133032.2015656-3-sst@poczta.fm>
Subject: Re: [PATCH v7 bpf 2/5] xdp: introduce xdp_convert_skb_to_buff()
From: bot+bpf-ci@kernel.org
To: sst@poczta.fm,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,maciej.fijalkowski@intel.com,tianyi@cloudflare.com,tavip@google.com,toke@redhat.com,aleksander.lobakin@intel.com,ilias.apalodimas@linaro.org,lorenzo@kernel.org,magnus.karlsson@intel.com,ihor.solodrai@linux.dev,edumazet@kernel.org,pabeni@redhat.com,andrew+netdev@lunn.ch,horms@kernel.org,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,stable@vger.kernel.org,sst@poczta.fm,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 19 Nov 2026 14:11:22 +0000 (UTC)

--===============5181703165338020747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> xdp: introduce xdp_convert_skb_to_buff()

TL;DR:
- Commit message calls the bug a page leak; it may be a use-after-free of
  page_pool pages
- Stable Cc 6.4.x predates the Fixes: tag (v6.9)
- kdoc may overstate mem type usage (nit)

> Then when bpf_xdp_adjust_tail() calls
> __xdp_return(), it acts incorrectly due to mem type not being set to
> MEM_TYPE_PAGE_POOL and causes a page leak.

Is "causes a page leak" the full impact?

The mechanism is bpf_xdp_adjust_tail() -> bpf_xdp_frags_shrink_tail() ->
bpf_xdp_shrink_data() -> __xdp_return(netmem, MEM_TYPE_PAGE_SHARED) ->
page_frag_free().  That ends in put_page_testzero() on a page_pool page.

With page checks enabled this is reported as "page_pool leak" and the page
is not freed.  Without them, page_pool keeps _refcount at 1 and counts
fragment users in pp_ref_count, and skb_pp_cow_data() allocates
fragment-sized chunks.  A single page_frag_free() can therefore hand back
to the buddy allocator a page that other skbs or pool->frag_page still
use, which looks like a use-after-free rather than only a leak.

Could the commit message describe that?

> Cc: <stable@vger.kernel.org> # 6.4.x

The Fixes: tag points at e6d5dbdd20aa, which first landed in v6.9.  Before
that, generic XDP linearized every skb and never set the frags flag, so
this bug cannot occur on 6.4 through 6.8.

The later veth patch in this series (1d3541dbf827) appears to be why 6.4.x
is listed, since it uses this helper and needs it as a backport
prerequisite.  Could the commit message either say that, or align the
stable range with the Fixes: tag?

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h

[ ... ]

> +/**
> + * xdp_convert_skb_to_buff - build an xdp_buff on top of an skb
> + * @skb: skb to describe, packet data is taken from its MAC header onwards
> + * @xdp: xdp_buff to initialize
> + * @xdp_rxq: Rx queue info to attach to @xdp
> + *
> + * The memory type set on @xdp_rxq is only used to release fragments that
> + * the XDP program consumes; the head can not be freed from under the skb.
> + * A non-linear @skb is expected to have gone through skb_pp_cow_data(), so
> + * all of its fragments are page_pool backed.
> + */

This isn't a bug, but is the "only used to release fragments" statement a
property of this helper, or of its current caller?

It holds for generic XDP.  However, the veth patch later in this series
(1d3541dbf827) converts the xdp_buff to an xdp_frame on XDP_TX and
XDP_REDIRECT, where the head is released through the same mem type, and it
has to overwrite rq->xdp_rxq.mem after calling this helper.

The kdoc also does not mention that the mem type stays set on the caller's
possibly shared @xdp_rxq after the call.  Should the kdoc say that these
properties depend on the caller?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44535627869
--===============5181703165338020747==--
