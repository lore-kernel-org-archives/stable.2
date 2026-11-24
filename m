Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519928;
	b=ZGjwcdDzXFSdUNPJgcYMeQKVIolh0np/tx7gafiHa8WIsU4vpXgDkhnM2O/v2Zjd5Js6
	 c9czIcFn6l4B1cg3vMywQQETokHCZsTt/HfhYB4tgOzZqaUoCRzPDScyLehbGJPa/Q2iN
	 33XNGvJoFgNzScPiwzz+JRICZrQeFloABWguG45fI62SSmvzXYD5l5U2NACQATqXW64iY
	 SFp6YI8YEsKcMP1WAkwekUbDEqDMExE4tQVgk3peVKuQmmV1FR2Hz9XFapbR8Vyg9DO0B
	 HEXOO0JwupRqwPqxk/nOGhiN4Qjjgone46W8A5jy9wCG/Us+AqHapM5MtNtzb7peOUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519928;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=4yhgTB2b4MbxQevqr7E5Hvejx3zY2tPTaRjJ3Th8LfM=;
	b=r/vD0LnFfU3DloPPJafgMMLhaiDz4xrox6TMbvG+gqRp1T23NCZKbKGetxxYpx++UhCi
	 aIMWEUCaegfF0TA336MiyHYwoJ43m5W3N/A9Yy14DtA4RFZHfwzsU769JhnjgTT9TjY/t
	 G3mUvxeERuYM6TWtqKpbPPylLiQhMY4PCU3iQgxqWJcsFJURBrJikmTCQtyhAVD/84lTt
	 dHuFS6rjwmFU+h6upK8xA8zI4s2QPpb4Wkl3/WgVvOkU8v/kg81srVa4mwqSb7Lt6YNtB
	 gcFZMu1jfjBh2Z+kYp8mIkUdL/z3i/zVgRCtzjBlhLWRq+xyknJHLie+zr5ydcjyI7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEJcLswg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71048606A31E;
	Tue, 24 Nov 2026 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEJcLswg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B687A1F000D0;
	Tue, 24 Nov 2026 11:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795519928;
	bh=4yhgTB2b4MbxQevqr7E5Hvejx3zY2tPTaRjJ3Th8LfM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hEJcLswgSBG8aMXFoyE1WPvF7kRP2R6SnXa/zR3nLQr3Av2x0YJP4jESZ1u/P0Kqp
	 E5E5JZFDbvZ+Bmk6zgTJ6icQxAWD+Ctm9BiR2mnMN3ZSr9Xe1lf97x3GanRoAZ88vG
	 y+vBANLV9UWi5CUgpTr4qEjYMCnVfB4uLaRehwgLg/mmsRg32bJSwLg8jTvFxKF56M
	 1TmxGOtR8YeXRVGS/SDjQfXF1W8q3Cf8s5h+yjJOqStUkuwEV6raBs8T7CI8Qzr/Lg
	 ATmiFqWJC+kDJl5Zjqmuq33hDKyLgr7Qnhwuj+BLljwyfimqyPeSsolivMPeO/Q14B
	 EZ3JXxCCWFwmA==
Content-Type: multipart/mixed; boundary="===============5305319266284041173=="
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f2e662d99995522aab39e990c48d77e8d3d852c0b603bb064f893ebbf0b8889d@mail.kernel.org>
In-Reply-To: <20261124104016.532341-4-sst@poczta.fm>
References: <20261124104016.532341-4-sst@poczta.fm>
Subject: Re: [PATCH v8 bpf 3/7] xdp: introduce xdp_convert_skb_to_buff()
From: bot+bpf-ci@kernel.org
To: sst@poczta.fm,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,maciej.fijalkowski@intel.com,tianyi@cloudflare.com,tavip@google.com,toke@redhat.com,aleksander.lobakin@intel.com,ilias.apalodimas@linaro.org,lorenzo@kernel.org,lorenzo.bianconi@oss.qualcomm.com,magnus.karlsson@intel.com,ihor.solodrai@linux.dev,edumazet@kernel.org,pabeni@redhat.com,andrew+netdev@lunn.ch,horms@kernel.org,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,emil@etsalapatis.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,stable@vger.kernel.org,sst@poczta.fm,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 24 Nov 2026 11:32:04 +0000 (UTC)

--===============5305319266284041173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> xdp: introduce xdp_convert_skb_to_buff()

TL;DR:
- Kernel-doc may wrongly say the head is page_pool backed only if copied; a
  future caller could free a page_pool page via page_frag_free()
- Commit message may omit a stable backport prerequisite (e6d90293fd16)

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
> + * Sets the memory type of @xdp_rxq to MEM_TYPE_PAGE_POOL; the change stays
> + * on @xdp_rxq after the call. A non-linear @skb is expected to have gone
> + * through skb_pp_cow_data(), so all of its fragments are page_pool backed.
> + * The head is page_pool backed only if the whole skb was copied that way:
> + * a caller that may release the head through the memory type, e.g. by
> + * converting @xdp to an xdp_frame, has to set the type that matches it.
> + */

Is the statement "The head is page_pool backed only if the whole skb was
copied that way" accurate?

A driver can build an skb on a page_pool page and call
skb_mark_for_recycle() without any copy.  For example,
mvneta_swbm_build_skb() does:

    skb = napi_build_skb(xdp->data_hard_start, PAGE_SIZE);
    ...
    skb_mark_for_recycle(skb);
    skb_reserve(skb, xdp->data - xdp->data_hard_start);

and reserves MVNETA_SKB_HEADROOM, which is at least XDP_PACKET_HEADROOM.

netif_receive_generic_xdp() only calls netif_skb_check_for_xdp() when:

    if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
        skb_headroom(skb) < XDP_PACKET_HEADROOM) {

so a linear, uncloned skb like that reaches bpf_prog_run_generic_xdp() ->
xdp_convert_skb_to_buff() with a page_pool head that was never copied.

Nothing breaks today, since generic XDP never releases the head through the
mem type, and veth takes its own page references before consume_skb().

But a future caller that turns @xdp into an xdp_frame and relies on this
sentence to pick MEM_TYPE_PAGE_SHARED for an uncopied head would free a
page_pool page with page_frag_free().

Could the wording say that the head is only known to be page_pool backed
after the copy, or that it may be page_pool backed for other reasons, so
that callers check rather than assume?

[ ... ]

Separately, the commit message has this paragraph:

> The problem exists since v6.9, see Fixes:. The stable range starts at
> 6.4.x, because the veth fix later in this series, which goes back to
> v6.4, uses this helper. Before v6.9 generic XDP linearizes all skbs, so
> there the mem type set here is never consulted.

Is the last sentence accurate for stable kernels between v6.4 and v6.9?

The mem type is written to the shared netdev rxq, and the write stays
there.  In those kernels bpf_prog_test_run_xdp() runs multi-buffer test
packets with alloc_page() frags on
__netif_get_rx_queue(loopback_dev, 0)->xdp_rxq, and reads that mem type
when the test program shrinks frags.

On a kernel that has this patch but not e6d90293fd16 ("bpf: test_run: Use a
private rxq info for XDP test runs"), those alloc_page() frags would be
freed as page_pool pages.

Should the commit message record e6d90293fd16 as a backport prerequisite,
the way the veth commit lists its prerequisites?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45379686209
--===============5305319266284041173==--
