Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447667;
	b=lXRX/G7112s0v5Zz47lis4ldfIuYtGQwDiKLddvdlcFnmiPLClyb7rEMZYgSzSRa2Q5x
	 DzwuUGIrmR3fpnxPvxhh6SVUKbTwbWNKs9idQx9xrDxSiKAiQKmiv9zh23d08I03esPdS
	 QNEzWOsEL0Ch0ROUERRqfMpwFB4EmWzSlpR8Wv6EDCUCAW+Q384MUIOgM38o9NLY6EYGg
	 MMK62gRO2567Bm0atV/s1cjpc8zf5Wz2bM4eNyjykNCZ7kegiLGjVk9vGu23GJCCrQjIw
	 iL6A7YxPGP/MnPqDK7njJy7SWQAworIFV6+QsQ+tc+TiHfneQtTzXsakqPFN2/f8VCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447667;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=78GpTlryXdmrJjByh3BUkZG9u0d3fTR+T73cEQZ+ISo=;
	b=OE9rcyizBOC4hP/iVFb+v4zCvb6J7/phYNlnSX1SQDyA9i6venLLd7mQ8WZWwSYVMcTV
	 VhXIKJQ+te9f4PdkPLxIClRAx+UX44yhxJ28OU5qbOsNZPQGLHBEY5OTDyFI6Phrg/rXb
	 7ASv0klUNEg4NXY2EYDoSmmCTMp+/F0ZPYel48akrRTO8YkoUKC2vjzAyw4lVkKTzDnJJ
	 wMoBUNxUjAlAjBTVoX/Y/+8KJ6+kkd0M6suOOa4Y5rJs3t2mY6IabYQOEMRe60uEL7gTN
	 mEjpMvDMDyNhrf25/vbb8eT28pGoAVZpRpgmblV0jw0orKiQtHAot/6D087uZ3nyuGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RMNW/hj3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056E606A321;
	Thu, 12 Nov 2026 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMNW/hj3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0121F00A06;
	Thu, 12 Nov 2026 01:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447667;
	bh=78GpTlryXdmrJjByh3BUkZG9u0d3fTR+T73cEQZ+ISo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RMNW/hj3cip2bnbqZ58DP7ZCuhYbB449WbkhHiLHdXYIbp+Yj0UstquCla7tCJSBP
	 H1fwSCTJ6hX0PLFgCOyqKHiVnQPByXuUhL2h9rfOUxssaZl10EbHdOx5hiij2kVnFA
	 W5TTwX7pWlpdHCX6cmfi7wxrVCLrXldYEcwAWJu1saz28hdaRD6oKo1vDvzlS0hcVb
	 1FyPhmjxhJoS7X0DrdfDc1Cf4Wv4M1iPRxecbSPU8YGoLn2TJP2f1fpKEbt/SjyK4R
	 EkfWaO38saxffH8JJDH5YTp4mMaE+7cI+39QeMClA18AemjYdyaGwhStSUReEm+3R/
	 tp/ZCw8zJ8OLg==
Date: Wed, 11 Nov 2026 17:41:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH net] net: wwan: mhi_wwan_mbim: disable rx_refill work on
 removal
Message-ID: <20261111174106.09f639ca@kernel.org>
In-Reply-To: <20261110043006.56681-1-mhun512@gmail.com>
References: <20261110043006.56681-1-mhun512@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 23:30:06 -0500 Myeonghun Pak wrote:
> mhi_mbim_remove() cancels rx_refill before wwan_unregister_ops()
> removes the links. Bringing a link up in between calls mhi_mbim_ndo_open()
> and queues the work again. With the MHI channels already reset, the
> work cannot refill RX buffers and keeps re-arming itself, eventually
> running after devres frees the context.
> 
> Use disable_delayed_work_sync() to drain the work and reject later
> queueing. Probe initializes fresh work on rebind.
> 
> Found by a static analysis tool under development.
> 
> Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
> Cc: stable@vger.kernel.org # v6.10+
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> 
> ---
> 
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
> index 336f89756f10..3b6b0066f673 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -650,7 +650,7 @@ static void mhi_mbim_remove(struct mhi_device *mhi_dev)
>  	struct mhi_controller *cntrl = mhi_dev->mhi_cntrl;
>  
>  	mhi_unprepare_from_transfer(mhi_dev);
> -	cancel_delayed_work_sync(&mbim->rx_refill);
> +	disable_delayed_work_sync(&mbim->rx_refill);
>  	wwan_unregister_ops(&cntrl->mhi_dev->dev);
>  	kfree_skb(mbim->skbagg_head);
>  	dev_set_drvdata(&mhi_dev->dev, NULL);

AI says this is not enough for make the teardown correct:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110043006.56681-1-mhun512@gmail.com
-- 
pw-bot: cr
