Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C819E3DDB0D;
	Thu,  6 Aug 2026 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002898; cv=none; b=oXne/4ZHCoMx6gMLd9YkDuhmMEYtt0UVZvUBcP2ckpDkuouo7/3IgkRPIA8toUgr1jU6zIuUh+x+sC6lygLVGd2FHbrifdc1+orTyM2ezyln8ONdxxuooJSL7P7n3UfGq2oy+JYfvxsGwqub+rug6Iyy1/aAslLA2YiL+EkQ4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002898; c=relaxed/simple;
	bh=oOuj2XexbD7aYvAbKD9gS8BWwHEtqAxYWGMOzC1w7Nk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Vhppx8OUyM3wx0a2JNy1jVGw/6Up136lG4GlP7eEkJ3M7lSEUUf9MKiNCU9kBZOi5K/Fgda6PTrMBdCsXxIMisNIsWw5NeDCx+fma1k9F93YkH27AY4wdyxsCg+ShreSo4XuixM7Np87FCMjaqTW2FZdbc/ZJdu/J585rsHql5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsdl1UiQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsdl1UiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90CC1F00A3A;
	Thu,  6 Aug 2026 07:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786002896;
	bh=CRYSMgJq4CXjTVjH5DRBnaKyazyDlpfdN0O7vqJN46A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=fsdl1UiQuv2jjNFuuO/luG73N1n5/9L6v2ZrEyzBuXlPsnR0snmiuqLTcZqIyAUtN
	 Kic9a1VTpC5bCUJxAgNDbqnjKCaHUB1fiUd7zZdDboXfNtYM2YcVTOxo7H5VPAYYz/
	 JwsF06pxdjnvJlxQFO/tkFzgZQEv5hGlU1VqEc9pZLF96u+L+NxtBG8ZseMWkz8+9d
	 lN+aGwXy80T35Jp0gACPmD/0+9seSRzUK7zomoyd96fIFR2NoiFGta4uliIfeRSgPD
	 8wjBxAXZUdTdmCCprQQG1LxDwYTUQYVO7QBgxF2O5Gfg8lYWRP7bc3Tq0ivKAXsMU7
	 DUGofP43Zy3rw==
Date: Thu, 6 Aug 2026 09:54:53 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Hongyan Xu <getshell@seu.edu.cn>
cc: David Sterba <dsterba@suse.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Ben Martel <benm@symmetric.co.nz>, 
    Stephen Blackheath <stephen@symmetric.co.nz>, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, stable@vger.kernel.org, 
    jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] tty: ipwireless: shut down setup timer before freeing
 hardware
In-Reply-To: <20260806060741.714-1-getshell@seu.edu.cn>
Message-ID: <0o798512-1s28-4s72-op84-r943s56020s5@xreary.bet>
References: <20260806060741.714-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 6 Aug 2026, Hongyan Xu wrote:

> ipwireless_stop_interrupts() uses timer_delete() for a timer whose callback
> can rearm itself. timer_delete() neither waits for a running callback nor
> prevents that callback from rearming the timer. The callback can therefore
> continue to access struct ipw_hardware after ipwireless_hardware_free() has
> freed it.
> 
> Use timer_shutdown_sync() so teardown waits for the callback and prevents
> any further rearming.
> 
> Fixes: 099dc4fb6265 ("ipwireless: driver for PC Card 3G/UMTS modem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  drivers/tty/ipwireless/hardware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/ipwireless/hardware.c b/drivers/tty/ipwireless/hardware.c
> index 0bfcbca6e2df..fb3554a6e04b 100644
> --- a/drivers/tty/ipwireless/hardware.c
> +++ b/drivers/tty/ipwireless/hardware.c
> @@ -1721,7 +1721,7 @@ void ipwireless_stop_interrupts(struct ipw_hardware *hw)
>  	if (!hw->shutting_down) {
>  		/* Tell everyone we are going down. */
>  		hw->shutting_down = 1;
> -		timer_delete(&hw->setup_timer);
> +		timer_shutdown_sync(&hw->setup_timer);
>  
>  		/* Prevent the hardware from sending any more interrupts */
>  		do_close_hardware(hw);

The driver is queued for removal.

-- 
Jiri Kosina
SUSE Labs

