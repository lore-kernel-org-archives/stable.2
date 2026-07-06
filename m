Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB142254A;
	Mon,  6 Jul 2026 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338907; cv=none; b=LYtnX+doBuBKio/vNzFi0vN9iSc4kWWSlnDz3muuzk+sjS3rsfPleK4I8m7OGkHKticvG7mvyiwY9hVQFrq/QAmVLJj/FRFNBMXUk2ZbQDyc1g2FcLvducPyQE24CMLi5oum9wurJmfsTwQtCtDSNxIS/4rdGrNy0ngamVhuR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338907; c=relaxed/simple;
	bh=oK3OwA3GNcUpAS22YW+4T2d+4N8SnkHpxdwEEA7slK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D72AzNnF6yH8jYcYQHmczjukwy8Smn0fm07g2Lwyw4ZBkuFWiR1IctRDer5jr3rpKsXMikbkNLxufaOTo5tANKEZ6plIGRW7z7wz0sYAa9V+hsuCgSEQq4uBhFnXZHxVR6nBD/Uz9/6LKVGJ7kZQDMrBTkodNY7TK2YrzifqoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYxLA/wM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYxLA/wM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256231F000E9;
	Mon,  6 Jul 2026 11:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783338906;
	bh=1zeff5+2id63hzvkwDo/KcQrlGts9itb0RT0AB+L234=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oYxLA/wM9K42qyMQr8xU02DGNlL/46nQXwpob5/eeu3wIQSjmv+ZWfuLoa0ZjmD9K
	 jzUnZJXyALeZlVjPQShmH7qqKesk94LSu6XqNX9FuvpDjsOsCODnP/aIEcWJZ3o6S3
	 tPwmGQ5V7m0rjqBUvjm1xYbd7We2FHX7PKnkjbZgAi0ySWM/rdn6fFKP9mtdoxezID
	 YZWSeHU1DBEaHSs5uVDl0YcSHwNTbBYR3q7igvziwncv3dizI15UmoSrRMIfKywDrd
	 uHArmD+DrXUhrRD4Ch8k0Jhgpo1ATB0pJ9lpNdKExKYn/jnWQpiYepeYk1CmySSDLc
	 UsXTCp/BwVPHg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wghui-00000001qaI-020f;
	Mon, 06 Jul 2026 13:55:04 +0200
Date: Mon, 6 Jul 2026 13:55:04 +0200
From: Johan Hovold <johan@kernel.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fix: drivers/usb/serial: usb_console_setup: unmatched
 usb_serial_put on error paths
Message-ID: <akuXmD-7nzKVgBT0@hovoldconsulting.com>
References: <20260627033410.58709-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627033410.58709-1-vulab@iscas.ac.cn>

On Sat, Jun 27, 2026 at 11:34:10AM +0800, WenTao Liang wrote:
> In usb_console_setup(), serial is obtained via a simple pointer
> assignment (port->serial) which does not increment the reference count.
> However, all error paths that reach error_get_interface call
> usb_serial_put(serial), decrementing a reference that was never acquired
> within the function. This causes a refcount underflow on the serial
> device.
> 
> Remove the unmatched usb_serial_put(serial) call from the error path.

No, there's a reference taken in usb_serial_port_get_by_minor() so this
patch would introduce an imbalance.

How are you coming up with these patches? Are you using an LLM? Why is
that not documented as required?

And why haven't you sent the follow-up mail telling maintainers to
ignore your patches as Greg asked you to do? [1]

Also I sent you review comments on other USB patches a month ago which
you still haven't replied to.

If you keep this up, you and your "lab" (why are you all using the same
mail address?) might end up banned as you've already been warned.

> Cc: stable@vger.kernel.org
> Fixes: 61dfa797c731 ("USB: serial: console: move mutex_unlock() before usb_serial_put()")

What on earth does this commit have to do with anything?

> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Johan


[1] https://lore.kernel.org/all/2026062704-detail-machine-270f@gregkh/
