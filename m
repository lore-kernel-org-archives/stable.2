Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793557154;
	b=XcBoUk2hDYDeBns51pKJyVOemqPDVlJxCF2QPMaCsgoODYwjfZgwosVFihkhovsFXjRE
	 ER0LO37FwcDYKjQGLGbhlTE0VsZgryV+HJEj10jG2S1B5kiVRFPzERE0Mya/h9r7A1UMg
	 couy2tlFkb6jLq2lPid+piXwlZF0r6eWlNo2ExcF1Z5fhxhtF8il992dpqfCU/QKOedi0
	 LB61cueceOKmRChyTNb0dd1Me61WspsJeZ4kyZ8bFn/ZLVBX/DeBUVObdxEjyX99X9T5G
	 Kt7xY/AcdsMo1lNzdox9JBHFD7IR+ysfVup9fCPbChaLToBE61j0VycOqFzEU4Pe1EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793557154;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Aftig2Ne/3CxSWuKKfD95dH4T81sYzdzYxbLhLJC1hI=;
	b=hsWCZsZhVCb+khQCc1R2R7tShVycTVu+k0oUn+wXbiNRQlyW0Ogmqe0NEECP0Y+BzMPI
	 n5vH+4n9lPxgVJBVG1UwP/oj934TC7Rs01EX0Q+GABz5BtYiUie2RtwcmYjDGsedrH5B+
	 EOnB364wofwtN4Ne/iyQhktY2KOU7PlfPl6CgZxVm6lEgy30JNwjx+dyKCLk1YYZO+Hta
	 ZlEx9ldCII1mw/+7xwbXSrf7HZ84Ug13fvFBcMMBkF4SZ6r9hJGrsoY7UnE+qUotAsxeB
	 gi16MixX3JSKmIWmF6nRdj98gRQTA3UE/7z6RBKDKdtEM4AcV6MydPvbYhjnf9R9Gvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhMLtvVC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D08606A325;
	Sun,  1 Nov 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhMLtvVC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8301F000C1;
	Sun,  1 Nov 2026 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793557153;
	bh=Aftig2Ne/3CxSWuKKfD95dH4T81sYzdzYxbLhLJC1hI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GhMLtvVCJPf/sZKo0J2zfkg1OzOJgOYVnjkCfiGTGzVpAslztG0KTsclnh3sEsUJT
	 WZu9P5Ta3xVBztTYoV8KqxYgEJSHRrd5Gk8dpFAvGc8JSQaj9Z1ACgmcrSOwe0pj3J
	 K0piCcSM2VVjd/JypHXnXX4dqAjud9XNdhZNxCTzsPWzeqVz8X+E4kXzSa1BCc0JqS
	 VN9lRG7ey+hNaZM4SBsGcD/2+/5Hvm58EfeX/Y/tKlyPD7QF1v/qw5/YKfld0UuGsb
	 I/UfYG1oILMJsV7N1SDplDExWn3yH2kwu+3CKDsBFgzMFlGo/RBsJu3Sx+x2BSwCUk
	 8MODb0i8URwPw==
Subject: Re: [PATCH net] gve: leave refcount headroom in the RX page bias
From: netdev-bot+sashiko@kernel.org
To: amaan.cheval@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, joshwash@google.com, hramamurthy@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, zhilinz@nebusec.ai,
 jiayuan.chen@linux.dev, kuniyu@google.com
Date: Sun, 01 Nov 2026 18:19:12 +0000
Message-ID: <179355715214.3131.12199411268855919850@kernel.org>
In-Reply-To: <20261031173449.2439047-1-amaan.cheval@gmail.com>
References: <20261031173449.2439047-1-amaan.cheval@gmail.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] This patch moves gve's RX page bias from INT_MAX to
  USHRT_MAX, but keeps the old refill rule in gve_dec_pagecnt_bias()…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but in
  gve_rx_copy_to_pool() (drivers/net/ethernet/google/gve/gve_rx.c) the…

--

gve: leave refcount headroom in the RX page bias

This patch changes the GQI and DQO-QPL RX page bias from INT_MAX to
USHRT_MAX and stores pagecnt_bias in a u16. A get_page() from the stack
therefore no longer wraps the page refcount negative.
gve_dec_pagecnt_bias() now adds a fixed batch of GVE_PAGECNT_BIAS
references when the bias reaches zero.

Link: https://github.com/amaanc/kernel-bias

> diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
> index 81ea800e66e94..6533fff061555 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx.c
> @@ -152,8 +152,8 @@ static void gve_setup_rx_buffer(struct gve_rx_ring *rx,
>  	page_info->buf_size = rx->packet_buffer_size;
>  	*slot_addr = cpu_to_be64(addr);
>  	/* The page already has 1 ref */
> -	page_ref_add(page, INT_MAX - 1);
> -	page_info->pagecnt_bias = INT_MAX;
> +	page_ref_add(page, GVE_PAGECNT_BIAS - 1);
> +	page_info->pagecnt_bias = GVE_PAGECNT_BIAS;
>  }

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. While
looking at the GQI-QPL copy pool, does gve_rx_copy_to_pool() leak the
fallback page?

drivers/net/ethernet/google/gve/gve_rx.c:gve_rx_copy_to_pool() {
    ...
		page = alloc_page(GFP_ATOMIC);
		if (!page)
			return NULL;

		alloc_page_info.page = page;
    ...
		skb = gve_rx_add_frags(napi, &alloc_page_info,
				       PAGE_SIZE,
				       len, ctx);
    ...
		return skb;
    ...
}

gve_rx_add_frags() can return NULL before skb_add_rx_frag() attaches
the page:

		skb = napi_get_frags(napi);
		if (unlikely(!skb))
			return NULL;
    ...
			skb = napi_alloc_skb(napi, 0);
			if (!skb)
				return NULL;

In that case the only pointer to the page is in the stack-local
alloc_page_info. gve_rx_copy_to_pool() then returns NULL without calling
put_page(page).

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
> index caed38cd5f2b3..cb6fba3122d5b 100644
> --- a/drivers/net/ethernet/google/gve/gve_utils.c
> +++ b/drivers/net/ethernet/google/gve/gve_utils.c
> @@ -93,15 +93,9 @@ void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info)
>  {
>  	page_info->pagecnt_bias--;
>  	if (page_info->pagecnt_bias == 0) {
> -		int pagecount = page_count(page_info->page);
> -
> -		/* If we have run out of bias - set it back up to INT_MAX
> -		 * minus the existing refs.
> -		 */
> -		page_info->pagecnt_bias = INT_MAX - pagecount;
> -
> -		/* Set pagecount back up to max. */
> -		page_ref_add(page_info->page, INT_MAX - pagecount);
> +		/* Out of bias: take another batch of references. */
> +		page_info->pagecnt_bias = GVE_PAGECNT_BIAS;
> +		page_ref_add(page_info->page, GVE_PAGECNT_BIAS);
>  	}
>  }

[Severity: Critical]
Can this page_ref_add() run on a QPL page that has already been freed?

The top-up only happens once the bias has reached zero, which is after
the last driver-held reference was handed off. igb, one of the drivers
the commit message cites, refills while the bias is still 1, before the
handoff:

drivers/net/ethernet/intel/igb/igb_main.c:igb_can_reuse_rx_page() {
    ...
	if (unlikely(pagecnt_bias == 1)) {
		page_ref_add(page, USHRT_MAX - 1);
		rx_buffer->pagecnt_bias = USHRT_MAX;
	}
    ...
}

On DQO-QPL, gve_xdp_done_dqo() calls xdp_do_redirect() first and only
then drops the bias:

	case XDP_REDIRECT:
		err = xdp_do_redirect(priv->dev, xdp, xprog);
		if (unlikely(err))
			goto err;
		gve_reuse_buffer(rx, buf_state);

gve_reg_xdp_info() registers MEM_TYPE_PAGE_SHARED for QPL queues. With
an AF_XDP socket in copy mode, the redirect target returns the buffer
before xdp_do_redirect() comes back to the driver:

gve_xdp_done_dqo()
  xdp_do_redirect()
    __xsk_map_redirect()
      xsk_rcv()
        xdp_return_buff()        /* MEM_TYPE_PAGE_SHARED */
          page_frag_free()
            put_page_testzero() -> free_frozen_pages()
  gve_reuse_buffer()
    gve_dec_pagecnt_bias()
      page_ref_add()             /* page already freed */

Each redirect lowers page_count and pagecnt_bias by one together. After
65534 redirects from one QPL page, both are 1, and the remaining
reference is the QPL's own base reference. The next redirect frees the
page in page_frag_free(), even though the page is still registered with
the NIC and still listed in qpl->pages[].

gve_dec_pagecnt_bias() then sets the bias to 65535 and adds references
to the freed page. The device keeps DMA-ing received packets into it,
and the driver keeps handing it to XDP and to skbs.

Nothing appears to block this setup. gve_verify_xdp_configuration() does
not reject DQO-QPL, and dev_xdp_attach() does not check xdp_features.

The same ordering problem existed with INT_MAX, but then it took about
2^31 handoffs per page. With USHRT_MAX it takes 65535, which sustained
traffic can reach quickly.

Should the refill happen at pagecnt_bias == 1, before the buffer is
handed off, as igb does?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031173449.2439047-1-amaan.cheval%40gmail.com
