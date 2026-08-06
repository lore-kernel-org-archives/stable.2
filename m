Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504A3D6CDE;
	Thu,  6 Aug 2026 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997084; cv=none; b=JHx3P4ObvWCNlhEZVcjpqBqjFpdhVBfNVzAXRxIHU0zxU+qFOtNFyl2gxpWqpgwjFv9PG6/aCvWaYoK5rb2WyrDBAqjvz8JcLHGMwYxjc5Ohkt5qLnae96EMz/UzDHIRCvBM7pvrIe2PqhIAIXIkFjHBCfFUXz0mZUV+LQnpEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997084; c=relaxed/simple;
	bh=WsfE5oTJFqpajHH/9Z9q4CuNO+AqLUcqrf4V7jGCUog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrK7fv4R9agAQNcJLsdC44aSh6QSZIw8gBapiYt7czf8aB8sXt3PO2esXoIjKOjKUaUDHHucKaNp99ta+8NO7hKG0Boj5eRmA/s6cw4UKUsAX3HBFteGt6yAo1aNfIAxkxnRarFg5jAmqhcplpM2Be2tBX53APjRHFcK6YSxNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gEy1heAE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gEy1heAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795F11F000E9;
	Thu,  6 Aug 2026 06:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785997083;
	bh=hC5rfTwfFnzGF6RmeG1qhdm7XdxuO1vuSJUGIMBrTyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gEy1heAEYMYrJmtEL5mT/OeHL0tbX7rbTIWwnNoBe1V1u8qQgTuID+NtRXVNnQrks
	 S4rBmdWXVyNKE05/moSOlAFZxHSae66RQSSJxIKP/Pv/XB60mKjz2UW1R9Wh0nogRA
	 a30WYkJ+5bZK3t3tDsiOU/vTcnHs8veddKxMy6H8=
Date: Thu, 6 Aug 2026 08:16:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Jiri Kosina <jikos@kernel.org>, David Sterba <dsterba@suse.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ben Martel <benm@symmetric.co.nz>,
	Stephen Blackheath <stephen@symmetric.co.nz>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] tty: ipwireless: shut down setup timer before freeing
 hardware
Message-ID: <2026080627-uncrushed-boil-769d@gregkh>
References: <20260806060741.714-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806060741.714-1-getshell@seu.edu.cn>

On Thu, Aug 06, 2026 at 02:07:40PM +0800, Hongyan Xu wrote:
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
> -- 
> 2.50.1.windows.1
> 

How was this tested?
