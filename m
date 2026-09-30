Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFF13939C2;
	Wed, 30 Sep 2026 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760530; cv=none; b=ht1hhHloDHkMl0G1HN6WQVkX5r9ZweQFynRSJf3uA8SwsobV2xApeuOXNSHCaS4vve0Gdot/wnfwg6PXc+8/Rb9sAP1RRtzaovcD8n8W317H8p1ImzXgXeXcXRJ4+zAWshWrGsgRDePC74r67tnco8Wo/Dw5DZ74SUzZZiCwU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760530; c=relaxed/simple;
	bh=XrAQsPqi9pVk+zpJjBQqrYjfZ7MnRsHSmYcJOCzLQzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9I+FgjM27D6BV/tSYkcBnFLvL/aRkTfxBgtNV2tjtnbNEbfHA5j8wsL1w/RWdoskpIy2i8QBZurgllidWs0pJWUhhTZXK/bF2vzylIFiiw0nekBIFbFWvGEAwCA5oK3to9BbmP10D67A5YTiCmeFXvkY6Q+fVxorc+l8xvQAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzVdckd2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzVdckd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9891F000FF;
	Wed, 30 Sep 2026 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790760528;
	bh=WqEtnUHXagCUT2Ek53+GJZXdG8329czXCPbszLGnvqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EzVdckd2PZUA5vOcHYr+UWtP4L7F+Pp91DJB13VJvkh8SjTX7wDOB7AdIOZUCyvyB
	 LRw7Di31lL6B5CzbFRwZweiK2N2GFeGMDIsDEy3x0wfJ3fUk4MPs/6Sbxb0y4y+SL0
	 Xn+Hjmh/bazoDPq4DY/B4DLJ9qarIEuV2Di7s16rxSjggwS7FJO53oUDXf6p0zLnZc
	 XrzqsOGybQ0izIlguJMWdBtJNFTwnPH0/Q7kf+/u7UUKOMKGVl5N9oZFOMFzJ3a8PM
	 iyq36XwGfitOR7tNdBIXXds7gkWwndemhBhEHyWxd7LnfvtNHaF3YeIK972nDbyG42
	 JWTE7NA9qElFg==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xBqcI-00000007Cva-1UvX;
	Wed, 30 Sep 2026 11:28:46 +0200
Date: Wed, 30 Sep 2026 11:28:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: David Lin <dtwlin@gmail.com>, Alex Elder <elder@kernel.org>,
	Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] tty: fix saved termios reset race
Message-ID: <arzWTv2cslkhyt6V@hovoldconsulting.com>
References: <20260930091938.1715754-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930091938.1715754-1-johan@kernel.org>

On Wed, Sep 30, 2026 at 11:19:38AM +0200, Johan Hovold wrote:
> Resetting saved termios state on device registration is needed where a
> minor number can be reused for an entirely different device and where
> the old settings may prevent the port from even being opened (e.g. when
> CLOCAL is not set).
> 
> Not all TTY drivers guarantee that the minor number is no longer in use
> when registering devices however, something which can lead to a
> use-after-free when closing a TTY (and saving its termios) races with
> re-registration.
> 
> Add a new TTY_DRIVER_RESET_SAVED_TERMIOS flag to request that any saved
> termios state is reset on registration and only set it for drivers that
> make sure that the minor number is no longer in use.
> 
> Fixes: 93857edd9829 ("tty: reset termios state on device registration")
> Reported-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> Link: https://lore.kernel.org/20260926184154.3017929-1-nicoyip.dev@gmail.com
> Cc: stable@vger.kernel.org	# 4.12
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
 
>  	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
> -		/*
> -		 * Free any saved termios data so that the termios state is
> -		 * reset when reusing a minor number.
> -		 */
> -		tp = driver->termios[index];
> -		if (tp) {
> -			driver->termios[index] = NULL;
> -			kfree(tp);
> +		if (driver->flags && TTY_DRIVER_RESET_SAVED_TERMIOS) {

This was of course meant to be a bitwise & as Sashiko noted.

I'll wait a bit before sending a v2.

Johan
