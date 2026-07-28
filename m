Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595823EB0E7;
	Tue, 28 Jul 2026 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785224620; cv=none; b=ITFIKOxhE01Rg5x6hPYxe7dDIgSyvHvh99CLSD4Ttx40+ARU/NlW7WU2s5Pbp4HSAzvcGkui9wIhL/Fr7fpB9gdPGz+b008pieYPRimvZzx7EPAnT4MOQKPArVN78kGzqfkbdhU2vg6P3at+QD9ZEj23gUMRRayp1yEP1xNbwBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785224620; c=relaxed/simple;
	bh=26A16aMC4MlWjBNCLXYhBsl70DKaB9ml5ukcEAah/ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6udeZVLyW55e979Yo0fv1MC91gHgti4Kz1xrPPSXPFByNAvC9SKwH9etZmPfg2CqTxLJw+3ji684rEySXA59kpfTA2lx/2zaXjIhtXOUfkuOSXZSs5Ge/08gpGnZ9Bg2KW8VYnQ9bCdcJk4TshRDafpl2WSHMirKAO1XB9KLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qYozVrB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qYozVrB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14271F00A3A;
	Tue, 28 Jul 2026 07:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785224619;
	bh=XvL5I3FnY3i8MLgT9IDKNxY+wJGj6bO3PI9Rg4QyYGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qYozVrB2a+OETQNBBdh9bepoxKPWvUzHNEp5c3Pz2dh9K8/yuuo3sWj8w8deA2a9M
	 95o1Je3oEtjZtKCeUrV6AAxewKapWzfh9Gk5HAyJb9YmFkszyNWtwzbP6ypm5t46rP
	 foHt7mlisz5Nb8VW5ZSVTmf1OujL/hKEyhZKAOLA=
Date: Tue, 28 Jul 2026 09:43:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] staging: rtl8723bs: fix skb->len underflow in
 monitor TX path
Message-ID: <2026072855-protrude-limes-4f11@gregkh>
References: <20260718185445.63070-1-meatuni001@gmail.com>
 <20260718190212.64409-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718190212.64409-1-meatuni001@gmail.com>

On Sun, Jul 19, 2026 at 12:02:12AM +0500, Muhammad Bilal wrote:
> rtw_cfg80211_monitor_if_xmit_entry() strips a radiotap header with
> skb_pull(skb, rtap_len), then immediately dereferences the 802.11
> header fields (frame_control, addr1, addr2) without checking that
> skb->len is still large enough to contain a struct ieee80211_hdr
> (24 bytes).
> 
> Further down, it calls:
> 
> 	skb_pull(skb, dot11_hdr_len + qos_len + snap_len -
> 			sizeof(src_mac_addr) * 2);
> 
> again with no check that skb->len covers this amount first. Plain
> skb_pull() does not itself validate the requested length against
> skb->len; on a too-short injected frame this makes skb->len
> underflow to a huge unsigned value, after which skb->data and the
> following memcpy()s operate on a corrupted skb.
> 
> This function is reachable by writing a raw frame to a monitor-mode
> network device, which does not require elevated privileges beyond
> being able to create/use a monitor-mode interface (CAP_NET_RAW).
> 
> Add explicit skb->len checks before dereferencing the 802.11 header
> and before each skb_pull(), bailing out via the existing "fail"
> error path on any mismatch.
> 
> Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 6a97afd89dc7..eac1b6ac4c67 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -2034,10 +2034,15 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
>  	/* Skip the ratio tap header */
>  	skb_pull(skb, rtap_len);
>  
> +	if (unlikely(skb->len < sizeof(struct ieee80211_hdr)))
> +		goto fail;

Unless you can prove that unlikely() provides better performance, please
do not do this.

Let me go revert all of these and wait for a new series.

thanks,

greg k-h
