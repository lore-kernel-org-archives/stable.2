Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A0E486420;
	Tue, 13 Oct 2026 04:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791866140; cv=none; b=nIW5TtYT5chMfO5N2F5ZRV8QA6tblMbX8ZHGt2YafOyc2lF/o6GUwBAzgA3W/2oZ6mQzhgX1p8HpHSLS4DtDBx+2TeaA/Qa+EeqEk52velEhGdfYUHJH1cdZJpNeiZ2xqiePxPeN18GJ2a4YT4agU01THpuwAltHfKAQNGSkfcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791866140; c=relaxed/simple;
	bh=cRZOo4ZOoELPxBJjX3ApA1pSLAtlq9Csax++UhkOGXk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T/d832IMYvOM1zUkKmNWkBMrDAsW6q6zffE2UD00weBAQ1jpdI/j2CStoodFGhRDy0CuaR6KuolUOQ98TMPnmB2CF0XxeY4tsBDwucfimXPQYccnU4dBycPoXy6APq3p6vL5e2RqoWjKGWmmppa2viNiTyXitlkKVDFDs+dTvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+AY+DA+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+AY+DA+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AC71F000FF;
	Tue, 13 Oct 2026 04:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791866138;
	bh=7Jq8d3/iBoOJIdi4ivd7yD8f/nAg8TWz56OXs0A/+dE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c+AY+DA+OBvc6DHh2Ja8a0AjN6nSedXD+AYS64NDCldXdjLy2dRszH/XAX15C4kCp
	 iBKKkKvN1wHn1rhYM+0ffjIo0cKZaGCCgEBQYg2XWZ1UrBvX28A8ikRos7RLMKLqC4
	 OMCnYpCxxMRfeO/zXwXNRoxh4OXFcNGT3TzT+sux3AmTyJPDMuul+ZD3e1Ncy9G0a4
	 wSIVxe/jUn8oZQSbBGpxRUjOQQd4jtV/klvM/sG5kFOZIg+CMVDws1mc2mCKS2VWdr
	 9gKUHGv7ejnyr6lf7u2UPr/cbo8LHi4yDbsN+gKwjfcp62i1udqvbqPpV8lA/iHta3
	 YLc2GNl2iwqnw==
Subject: Re: [PATCH net v3 3/5] eth: fbnic: return a pending Rx packet before
 reusing its buffer
From: netdev-bot+sashiko@kernel.org
To: yhlee@isslab.korea.ac.kr
Cc: alexanderduyck@fb.com, kuba@kernel.org, netdev@vger.kernel.org,
 kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, daskald@meta.com,
 mohsin.bashr@gmail.com, bobbyeshleman@meta.com, daniel.zahka@gmail.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 04:35:37 +0000
Message-ID: <179186613772.434549.1298596260107746925@kernel.org>
In-Reply-To: =?utf-8?q?=3Cdc2fd0f8b4ff068c3919444d7b4a88ad55e5831f=2E1791775?=
 =?utf-8?q?409=2Egit=2Eyhlee=40isslab=2Ekorea=2Eac=2Ekr=3E?=
References: =?utf-8?q?=3Cdc2fd0f8b4ff068c3919444d7b4a88ad55e5831f=2E17917754?=
 =?utf-8?q?09=2Egit=2Eyhlee=40isslab=2Ekorea=2Eac=2Ekr=3E?=
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch adds a second place where an Rx packet gets thrown
  away, and that path is not counted in any statistic.

--

eth: fbnic: return a pending Rx packet before reusing its buffer

This patch changes fbnic_pkt_prepare() so it no longer only warns when a
new header completion arrives while a packet is still pending. It now
returns the pending header page and any attached fragments to the page
pool, then clears data_hard_start. To make this possible,
fbnic_put_pkt_buff() is moved above fbnic_pkt_prepare().

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 7dda59bba14ee..47ded7a9e0a81 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c

[ ... ]

> @@ -1025,8 +1052,12 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
>  	unsigned char *hdr_start;
>  	struct page *page;
>  
> -	/* data_hard_start should always be NULL when this is called */
> -	WARN_ON_ONCE(pkt->buff.data_hard_start);
> +	/* a new header while one is pending: release the old one */
> +	if (unlikely(pkt->buff.data_hard_start)) {
> +		WARN_ON_ONCE(1);
> +		fbnic_put_pkt_buff(qt, pkt, 1);
> +		pkt->buff.data_hard_start = NULL;
> +	}

[Severity: Low]

Should this new drop path also be counted in the Rx drop statistics?

Every other place that discards a packet in the META handling of
fbnic_clean_rcq() counts it before calling fbnic_put_pkt_buff(). That
includes a META completion that arrives with no header:

drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:fbnic_clean_rcq() {
    ...
			} else {
				if (!skb)
					alloc_failed++;

				if (skb == ERR_PTR(-FBNIC_XDP_LEN_ERR))
					length_errors++;
				else
					dropped++;

				fbnic_put_pkt_buff(qt, pkt, 1);
				goto next_dont_count;
			}
    ...
}

Suppose the device sends HDR_AL(A), [PAY_AL ...], HDR_AL(B), ..., META.
Packet A is then freed here and nothing increments dropped, length_errors
or alloc_failed. So rcq->stats.dropped, rx_dropped and the per-queue stats
do not show it. Only the first such event per boot leaves a trace, through
WARN_ON_ONCE().

Before this patch the packet was also not counted, because it was leaked.
Now that it is dropped on purpose, should fbnic_pkt_prepare() update
rcq->stats (or report back to fbnic_clean_rcq() so it can bump dropped)?
That would match how the other drop paths are counted.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791775409.git.yhlee%40isslab.korea.ac.kr
