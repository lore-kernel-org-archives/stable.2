Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826548;
	b=xnhdxLN9lCmW4W7GnU2tLsafXxGgi2LFBlut2DuMYSISy15NLg+1jcAXFW8SeF3nhoxt
	 4jaOhuJy0QoDZjnxBy4pgfhFev8M6kLOLbvRKwhJG7H3TthmmlA0t5hygR3+KX9vVZcTr
	 co8kvnN1WrAOvTZqoFwH18VJmbHdocdic8JnV3Q+pZmvh8d4TEFUrT8aOjRGJhvFBnKXZ
	 7n9Z4L3TZD6Vgx1qofo4P41PUVZ+VaBlWS81+u3H9QCQvwgRj66iX/NsyLiSqOUbbSaxW
	 a8SYASvLS251cIniK3Ri++1o+iyScmqP57/qNNXLOhRpTPy2DXaedzp+ysrG7a3kKAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826548;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JoLaVO0t2M4whSRJ4oFfITG85nuCxR3a2DUqsaJwp/U=;
	b=rnXox+3uY4tZO/QgqjbeMypUMyJAkpH8MFZvW5SI6iJPSvqxcEd7Y/wfd6atR0rXWbAx
	 6eynpFk/b+JHozxj/l4Q/oM4ydwVT+zOKScjvH8RyNAjYCPtOALTiS4OS4aiuNiURi9pb
	 C+6AQqusFCC4qeUQC0U4d2bhHteVYFRuzhlwLEg1Jy+maHS6lu1e8qafhb2QE8M2JDE3E
	 YHXyK6+k5iD3+gAFvT+xb5A3/zJUHtpLiQMlUzbyVUsstVtxNsihl0JiXyliCCSJ3vyFw
	 fEZ74Htw1YwrblxXOoaR/PXkm1GDFMvCaXSwwlwOmFTHNOUS4WsZ+EEOfqK3LV7qOrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bM+Y4qli;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE417607E723;
	Wed,  4 Nov 2026 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bM+Y4qli
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909FF1F00A16;
	Wed,  4 Nov 2026 21:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826547;
	bh=JoLaVO0t2M4whSRJ4oFfITG85nuCxR3a2DUqsaJwp/U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bM+Y4qlivWXD/hbfUoQSOt6jdxvDIO6vVwYBUAaJcXZWGokJR9RMVEqU+eeSbz7fF
	 hnfFB7Cx3gT3WkY8xzaq/MCyhCJkV5UJGtdTkTkh1nrmWsQdMxjOQKNLV03ezcTScE
	 EBTyPlSpWX6nZUZnU4EdS8yJ05D0YPHiv7Hv/QQQ3ekdPm1e8WAwNCCwl88A/78S0j
	 py+1+NpkcoBS45ikGR8nZZWI2/S0j7QuoKlp6Wj37uZsciPsY8Rlj1iA35502NnDzA
	 iyjhQ9TFmgqpttvWp2BLes5zSmzGdMnwzfJpr+N+wi0ae+TcS5tYlV2QuS5mjybTLB
	 x9ljrlBzgibzg==
Subject: Re: [PATCH net v3] gve: leave refcount headroom in the RX page bias
From: netdev-bot+sashiko@kernel.org
To: amaan.cheval@gmail.com
Cc: netdev@vger.kernel.org, joshwash@google.com, hramamurthy@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, bcf@google.com, jordanrhee@google.com,
 przemyslaw.kitszel@intel.com, pkaligineedi@google.com, maolson@google.com,
 csully@google.com, willemb@google.com, yangchun@google.com, npl@google.com,
 awogbemila@google.com, shailend@google.com, nktgrg@google.com,
 maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com,
 hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 04 Nov 2026 21:09:05 +0000
Message-ID: <179382654505.488856.2284543045939069308@kernel.org>
In-Reply-To: <20261103090651.35399-1-amaan.cheval@gmail.com>
References: <20261103090651.35399-1-amaan.cheval@gmail.com>
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

Critical: 1 · High: 0 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] This patch refills the bias only after
  gve_dec_pagecnt_bias() reaches 0, and it lowers the per-page bias from…

--

gve: leave refcount headroom in the RX page bias

This patch lowers the gve RX page refcount bias from INT_MAX to USHRT_MAX
and stores it in a u16. This leaves page_count() room for references the
stack takes with get_page(), such as splice() and tee(). When the bias
reaches 0, it is refilled with a fixed batch of GVE_PAGECNT_BIAS.

Link: https://github.com/amaanc/kernel-bias

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

Can this free a DQO-QPL RX page that is still registered with the device?

Because the refill happens only at 0, the 1 -> 0 transition hands the
driver's last reference to the consumer. With INT_MAX a page needed about
2^31 handoffs to get there. With GVE_PAGECNT_BIAS it happens every 65534
handoffs.

On DQO-QPL, gve_xdp_done_dqo() redirects the buffer before it touches the
bias:

	case XDP_REDIRECT:
		err = xdp_do_redirect(priv->dev, xdp, xprog);
		if (unlikely(err))
			goto err;
		gve_reuse_buffer(rx, buf_state);

gve_reg_xdp_info() registers QPL rings as MEM_TYPE_PAGE_SHARED. If the
redirect target is an AF_XDP socket in copy mode, the page is released
synchronously:

xdp_do_redirect()
  xsk_rcv()
    xdp_return_buff()
      __xdp_return()
        page_frag_free()
          put_page_testzero()
          free_frozen_pages()

Suppose the page is at pagecnt_bias == 1 and page_count == 1. That is the
normal recyclable state once all earlier consumers have released their
references. The QPL page then goes back to the buddy allocator while it is
still DMA mapped, registered in the QPL and owned by the buf_state.

After that, gve_reuse_buffer()->gve_dec_pagecnt_bias() calls
page_ref_add(page, GVE_PAGECNT_BIAS) on the freed page.
gve_try_recycle_buf() then sees page_count - bias == 0 and posts the page
back to the NIC. Could the device then DMA packet data into memory that
has already been handed to another user?

The v3 notes say XDP on DQO-QPL "will be blocked explicitly in a separate
patch". In this tree, gve_xdp(), gve_verify_xdp_configuration() and
gve_set_xdp() do not check queue_format.

gve_set_netdev_xdp_features() sets xdp_features = 0 for DQO-QPL, but
nothing on the attach path enforces it. xp_assign_dev() also falls back to
copy mode when NETDEV_XDP_ACT_XSK is missing.

That note is below the --- line, so it will not be in the applied commit.
The patch is also tagged for stable without naming the prerequisite.

The commit message also says:

  Use USHRT_MAX in a u16, as igb, igc, ixgbe, i40e and hns3 do

Those drivers refill at bias == 1, so they always keep a reference. For
example, igb_can_reuse_rx_page() does:

	if (unlikely(pagecnt_bias == 1)) {
		page_ref_add(page, USHRT_MAX - 1);
		rx_buffer->pagecnt_bias = USHRT_MAX;
	}

Would it be safer to refill at 1 here, as v2 did, so the driver never
gives up its last reference on a QPL page?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103090651.35399-1-amaan.cheval%40gmail.com
