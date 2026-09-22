Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74C48A8A4;
	Tue, 22 Sep 2026 05:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055478; cv=none; b=bEYTgtX8YPW+wcp6hTad4GbpIZux7Szxss3Czy4CsTtoYGzsqIUMntLDKMIxVDTtWtMBM6rTaNNZIX+oUNlb8U3Yj98Gssb7HTsSOe4uLQaCuPh/E7Uv0MPy0X/1HDZ7sulV6JlezUQg5mY8sUpQzlc5X5+s+GVLVw0Edrtv2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055478; c=relaxed/simple;
	bh=xZp9r60+dCXnIa0A3ozzNGf0cC3IAb+FgBmuAxrQszs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN8tMU5zDbCbmij7cAE13y4EXEThsFn7pvR17o1V11S+kwFdPSp97MGt2zWvbXVqgIH8k+w15qUORa2TGwuYocYkIdo30dVWFQcP7By9aqMPakWufA1QJ+r8LOM8LPM1IYTjivThl20/pE6cJ1aqW0yDlliiM3vdgaivFVbUOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y4UeLvnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y4UeLvnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0CA1F000FF;
	Tue, 22 Sep 2026 05:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790055465;
	bh=WrxXD5R9VUQi7qUjgHG9Pa6uBFBwGP/N2AEeSkpeg4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y4UeLvnT9ESvaLjRVUfDxsMLCYn12RSn8ZmCqCwMse5WUryxP/1iiVlagkc6um9EE
	 PYK1TR2DMtoJO+bc5qU6+nbKrKcCzdh0A/3X9Qe/zswL2UzGOu8pNFOxJObM+jRKyv
	 CPBuDAcNDVxwTrxr3JMuE+NHBHOwcKnr5ePhe96E=
Date: Tue, 22 Sep 2026 07:37:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Hongren Zheng <i@zenithal.me>, Ijae Kim <ae878000@gmail.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usbip: vudc: Prevent transfer timer rearm during teardown
Message-ID: <2026092207-secluded-pregame-8464@gregkh>
References: <20260921224130.492681-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921224130.492681-1-mhun512@gmail.com>

On Mon, Sep 21, 2026 at 06:41:30PM -0400, Myeonghun Pak wrote:
> Commit d96209626a29 ("usbip: vudc: Fix use after free bug in
> vudc_remove due to race condition") made v_stop_timer() delete the
> transfer timer synchronously before vudc_remove() frees its containing
> struct vudc.
> 
> That does not close the race with the receive thread, which is stopped
> later through usb_del_gadget_udc() and vudc_shutdown().  The thread
> calls v_kick_timer() for CMD_SUBMIT and CMD_UNLINK packets, and
> v_kick_timer() deliberately calls mod_timer() when the transfer state is
> VUDC_TR_STOPPED.  A packet received after v_stop_timer() returns can
> therefore enqueue the timer again before the vudc is freed.
> 
> timer_delete_sync() only drains the current timer instance and cannot
> prevent such a rearm.  Use timer_shutdown_sync(), which makes subsequent
> attempts to arm the timer no-ops.  The transfer state no longer needs to
> be updated, as it is freed along with the timer.
> 
> On a KASAN and DEBUG_OBJECTS enabled x86_64 QEMU guest, repeatedly
> binding the device, submitting a request and unbinding it produced a
> "free active timer_list" warning followed by a slab-use-after-free in
> v_timer().  With this change the same harness completed 4000 iterations
> cleanly.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
> 
> Fixes: d96209626a29 ("usbip: vudc: Fix use after free bug in vudc_remove due to race condition")
> Link: https://lore.kernel.org/all/20230316180940.1601515-1-zyytlz.wz@163.com/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/usb/usbip/vudc_transfer.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vudc_transfer.c b/drivers/usb/usbip/vudc_transfer.c
> index d4ce85c4c6a2..4146b746a320 100644
> --- a/drivers/usb/usbip/vudc_transfer.c
> +++ b/drivers/usb/usbip/vudc_transfer.c
> @@ -441,7 +441,7 @@ static void v_timer(struct timer_list *t)
>  	spin_unlock_irqrestore(&udc->lock, flags);
>  }
>  
> -/* All timer functions are run with udc->lock held */
> +/* v_start_timer() and v_kick_timer() are called with udc->lock held. */

If this is true, use the correct documentation/metadata style for this,
so that checkers can catch this.  A comment like this will not work.

thanks,

greg k-h
