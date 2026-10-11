Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB84E3CF022;
	Sun, 11 Oct 2026 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791721010; cv=none; b=ipksTilfoZLaM/yfp5gG8SojkYd1uShPaTBhfwH8RnsjbJCAB7YAjkPoOw3+t0x0VqlOysGVQkCV0l1o3HZMnfaKhWQZX8uDetrhklOqkw0kg/V2mzITmFpF+2rm5TkhQG7bbqunaILwvL+0I3OfTIXi+JUlzb3kwHVF9Gb++T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791721010; c=relaxed/simple;
	bh=pvx7fKXtCPZqx2ki+BFooqb6FHGLCDyAsEznjg87QJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juhFxs25WmMUj6WawQbk612U35P3q8XSujLC3sdhRmHdzXYwPuStILYJKiXarb0paMZoGLPAk12bbvUtW3PMh2V3nYWQPs9Mo3yBczAexyNg64jAZwS0Bdx+ZlLL7UGTiOZ5PYrM8EtRplzFW86Iy1ema9f7exe+HzM9vTcsdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IweVJ2vx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IweVJ2vx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1C61F0089B;
	Sun, 11 Oct 2026 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791720999;
	bh=9Ae1LksmXbVoufr8BF37M9QHcFxvUyTyFN84jCxPjg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IweVJ2vxhxiEbGej7oZke7kFrh5fGM/dKIwJesy0NarMtE4/OXtrA7UCZXL+He5vj
	 HVh6LcIYLHwSkO9SulLwblFjKpriJS3BKxXkxAHVga7V678QYc61uKzUFqcfaKmkEl
	 2AR56B3vkK6f6mlrgGIenzj6ngJsr2fMOh6qbJQM5j+TbkQRD/UKG+SDSik1rFHNJ/
	 /JdNcvwKGCyb/NiwcIlX8OrdlS/5zOSTheK+lCEdm327LBPLjHDHjA0bMYsluvRLQS
	 5yaB111pBLB4p056sXGkkTvYtjNJkeJ79BS60uOqO6E4JFLzlCZaa2HHRkgDyXC3Zl
	 5IBn7IPASVFsA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xFsTl-00000002fwF-0XeI;
	Sun, 11 Oct 2026 14:16:37 +0200
Date: Sun, 11 Oct 2026 14:16:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: fix TIOCSSERIAL and TIOCSERCONFIG on
 uninitialised ports
Message-ID: <ast-JWIDzyly6WuI@hovoldconsulting.com>
References: <20261010034616.3915864-1-hengyul@cs.unc.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010034616.3915864-1-hengyul@cs.unc.edu>

On Fri, Oct 09, 2026 at 11:46:16PM -0400, Hengyu Liang wrote:
> Commit 8ca59f7baee7 ("serial: fix ioctl hangup race") made
> uart_set_info() and uart_do_autoconfig() return -EIO when TTY_IO_ERROR
> is set, so that they do not run on a port that has been hung up.
> 
> However, TTY_IO_ERROR is also set on a port that could not be started,
> for example because its type is unknown, and by uart_shutdown(), which
> both functions call. As of now, setserial cannot configure a port that
> the kernel did not detect, and an autoconfig that follows a port, irq or
> type change in the same setserial call fails on any port.

Thanks for catching this.

How did you find it by the way? I assume you are not using an ISA serial
card?

> This patch will check tty_port_active() in these two functions instead.
> uart_hangup() clears it under the port mutex, and it stays set on an
> open port that could not be started.

Yeah, this should work. (And the flag is now also cleared under the port
mutex by tty_port_hangup(), which serial core currently does not use.)
 
> Fixes: 8ca59f7baee7 ("serial: fix ioctl hangup race")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Commit 8ca59f7baee7 is in the stable queue for 7.2.
> 
> Tested on v7.3-rc6 in QEMU (8250). A TIOCSSERIAL that is held in
> copy_from_user() with userfaultfd while the tty is hung up with
> TIOCVHANGUP still gets -EIO from uart_set_info() with this patch.

Tested-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
