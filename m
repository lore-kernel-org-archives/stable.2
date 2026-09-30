Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18942F7EFE;
	Wed, 30 Sep 2026 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760044; cv=none; b=WGzFDersizqmz1Ap0PCdvKFOB+pp9ibng9asg2yrNoke+15SlFkwgs2dTh1dXjoKIwBd0vLdCjvWfS0Yckkm8NVLa+hcoVl9+RvNno9rnhwAzeRG9yQAsgnwEn0JnnCBuBrtLknz/KG+sCzIYdt3tnIgFGFArqwIdnMZQTYLgAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760044; c=relaxed/simple;
	bh=nMq/8/xUGwQmipCSKRoQE/783HgZexu879zNJvfmrGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyLzt0m6oumCrutnuHXNGPABLETBjNC+SNN1fK2087pFJD/4+H053D7f5ZOw1pbcL/09WD9wJB+HR6PDOOg2Pb7Xhl+1nD95BuAq6EAQO9L5nhevnwC8sFLmexNQ2tw/tkVOiKlsaBrnOOuA9kz0TlzDl9bK9AHXx0rplms1/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkiJYWKX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkiJYWKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E23C1F000FF;
	Wed, 30 Sep 2026 09:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790760043;
	bh=MnV8IZQVj1FFMg9BAGwsZdL2OW//NUa9sSpDcZKLue0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lkiJYWKX/TkVanp7NKtC0wKL2v0/mCDIHUA19O8Gz/Csl0Yk+WYxB6dFYElkj3ZAh
	 uNEFeI4FNe+Q9D2+U+9W05ud8yYG8fsaxT70BEpxtOtFr1EARI82j5t19c8o+bvpnU
	 Zi3QoiKGZQ1wg1pSBehN6a9yE36l/7OKkZAWKCor70489X1p7kqXc1upgsUNqLni9p
	 YI5f72Bi3ru40UWBsqhe8POw2Abq0NBkNrmIdjqjUnjl55Yadt/H4sCDC8A/246Be8
	 DUqeZZSE+nOYhsx1y+c6bOdTAxdlU+wIHZb3V7DiayCcNgbBHYPnUXAwVIV/WPLLrl
	 KVNT/SeFZeZfw==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xBqUT-00000007COo-1WwW;
	Wed, 30 Sep 2026 11:20:41 +0200
Date: Wed, 30 Sep 2026 11:20:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tty: Serialize saved termios access with device
 registration
Message-ID: <arzUadtDI86btAMj@hovoldconsulting.com>
References: <20260926184154.3017929-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926184154.3017929-1-nicoyip.dev@gmail.com>

On Sun, Sep 27, 2026 at 02:41:54AM +0800, Chengfeng Ye wrote:
> tty_register_device_attr() frees saved termios data when reusing a minor
> number without serializing with tty_init_termios() or tty_save_termios().
> The tty_mutex held by the open and close paths does not protect against
> this registration-side free.
> 
> For example, an n_gsm mux reconfiguration can register a device while its
> previous tty is being released. tty_save_termios() loads the saved pointer,
> registration clears the array entry and frees the object, and
> tty_save_termios() then writes through its stale pointer.

Thanks for reporting this. The intention here was that the TTY drivers
would not be reusing a minor number while it is still in use, but that
is clearly not adhered to everywhere.

> The saved-termios
> copy in tty_init_termios() is vulnerable to the same lifetime race.

How could this happen? TTY drivers should hang up their ports during
deregistration so this shouldn't be an issue unless we have a driver bug
(which we do in n_gsm apparently).

> KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in tty_save_termios+0x39a/0x3d0
>   Write of size 44 at addr ffff8881012e8180 by task poc/114
> 
>   Call Trace:
>    tty_save_termios+0x39a/0x3d0
>    release_tty+0xb3/0x7a0
>    tty_release_struct+0xa0/0xd0
>    tty_release+0xc1b/0x11b0
>    __fput+0x2f8/0x9e0
>    fput_close_sync+0xe2/0x190
>    __x64_sys_close+0x78/0xd0
> 
>   Allocated by task 110:
>    tty_save_termios+0x2c1/0x3d0
>    release_tty+0xb3/0x7a0
>    tty_release_struct+0xa0/0xd0
>    tty_release+0xc1b/0x11b0
> 
>   Freed by task 113:
>    kfree+0x131/0x3c0
>    tty_register_device_attr+0x498/0x8b0
>    gsm_activate_mux+0xfb/0x210
>    gsmld_ioctl+0x92f/0x14d0
>    tty_ioctl+0x915/0x1240
>    __x64_sys_ioctl+0x134/0x1c0
> 
> Serialize the saved-termios copies and reset with a private mutex. Taking
> tty_mutex during registration would invert existing driver lock ordering:
> UART registration holds port->mutex, while tty_find_polling_driver() holds
> tty_mutex when calling uart_poll_init(), which takes port->mutex. Keep the
> new lock confined to the saved-termios operations, with no driver callbacks
> inside the critical sections.

I'm a bit torn about this, but I think we should avoid adding another
mutex in favouring of making the saved termios reset opt-in.

Clearing the saved termios state on device registration doesn't make
much sense if a minor number may still be in use as an open TTY would
prevent the termios from being reset.

I've just posted a patch for this here:

	https://lore.kernel.org/r/20260930091938.1715754-1-johan@kernel.org

Johan
