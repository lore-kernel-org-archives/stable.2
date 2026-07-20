Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A943AC0CD;
	Mon, 20 Jul 2026 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784530128; cv=none; b=QncouEG7P8r57KeptojiWioeN3A0H8GIm0K+GKw0c5U0NZvPsO//KziIQJmWajECzw7RHPvUJRyTKRGTW/wpPmGXcjodvMD6VN4j0P1AAskq0BJNsNxl1+6o8pFvRLoCREiVeaRboy57ACRDcEIiWZVpcyNnhfT8nsWZ3DI79PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784530128; c=relaxed/simple;
	bh=a18Xb0eI3sl9REP/uERv1Gq0RhSlvk7kAV0Sj3faOCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxhLmzimCMngIF27F2cnYsu+dUZRPL5s4/sgwfJKsHijVNp15M/s4bf3b/kZj6NA1UVy+BzIl+tv4l7JGUkwo2LJg68g3VJIN5qw5nXvD8LU37q6w7YasY3T6nmzQeN5BuZA40pT9gMy1rB05PcrdSwaN+I47J+r3PHwv9tlFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YFgdBJMR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YFgdBJMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290CA1F000E9;
	Mon, 20 Jul 2026 06:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784530126;
	bh=cqugzPvbA9SsigO3tQ3gJBzJlAcwfQ7qo51FdfbeQ4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YFgdBJMRxP5JlgRaJlER8u2UIsmGJwx/UnmhMVnp0eewJs+srHjFhz23lHptWL9xu
	 GTML9FYfcce6vA0hfDbzUr6TTjpBuQq3h/9IPgSAODuDTZFjuzF3QJxlKIDL4LLnSD
	 2nhhhVMQ1u3YkPb7JaYkC4xqj95vs3ZisEBbzD0g=
Date: Mon, 20 Jul 2026 08:47:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
	john.ogness@linutronix.de, andriy.shevchenko@linux.intel.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com, stable@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: validate iomem_base in
 serial8250_verify_port()
Message-ID: <2026072015-ammonium-dismount-7af5@gregkh>
References: <20260720053733.102186-1-25181214217@stu.xidian.edu.cn>
 <0d58c9fe-7aed-43dd-8d00-6edfee9e2876@kernel.org>
 <706101a4-abf9-403d-a2cb-778a12338d99@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <706101a4-abf9-403d-a2cb-778a12338d99@stu.xidian.edu.cn>

On Mon, Jul 20, 2026 at 02:44:19PM +0800, Mingyu Wang wrote:
> 
> > 
> > Pardon my ignorance, but isn't TIOCSSERIAL intended exactly to change
> > the type or mapbase when needed for ports without UPF_FIXED_PORT (and
> > under root)?
> > 
> Hi Jiri,
> 
> You're right — TIOCSSERIAL is meant to allow root to change io_type
> and iomem_base for non-fixed ports. My patch was indeed too restrictive
> and would have broken that ABI. That was an oversight on my part.
> 
> The issue was identified via local syzkaller testing. It reveals two
> related behaviors:
> 1. Root injects a bogus iomem_base via TIOCSSERIAL; opening the port
>    faults in mem_serial_in() because the mapped address is invalid.
> 2. Because the fault happens while holding tty_lock, the mutex remains
>    locked by the dying task. This leads to a cascading use-after-free
>    when subsequent threads try to acquire the same lock.
> 
> While (1) is effectively "root shooting itself in the foot," (2) results
> in cascading failures beyond the initial fault.
> 
> How would you prefer to handle this? Should we treat this as wontfix
> (since it requires CAP_SYS_ADMIN), or would you prefer a more targeted
> check to avoid the cascading UAF (e.g., ensuring basic validity of the
> mapbase before ioremap)?

I think we have been through this before, look in the archives.  syzbot
shouldn't be doing things as root that are known to cause problems with
the system.

It's like it calling 'rm -rf /' from a syzbot script, just don't do
that :)

> I'm happy to drop this patch if you feel the risk does not justify
> additional checks.

We can't break existing apis, sorry.

thanks,

greg k-h
