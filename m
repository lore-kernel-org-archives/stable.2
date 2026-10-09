Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F24C10D8;
	Fri,  9 Oct 2026 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543928; cv=none; b=SKgJVKfku6uWHpTVj9S45fPolTwPBDo7Bri2NK3tkZxLc/5IlHlTAZ66mhRbWOXigHwHbgQm4QjbCru3mg65gasniwXoe5PhuIeEbEfpH0SioJ/6nIpiYSqtUCNs9/9KcFxamzEMXN2AQS6cmSOsgOUyHSKBNpsDkEqRzuPKpdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543928; c=relaxed/simple;
	bh=odYrS8Ro68F/4BCB0GtFm47Hz5skNniA5U8x2orGamk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3onYyK4OVBuBwM/0VCArBAJDTAmyaWvlQGkhNbEjaiWas2KM+TBESPlMINQNG1ZtlUUdkZ7qaoJ982GRrUf7t2ypGB1CzYYths7SLCsPCnWDwJQxIhaCylKxJrW8yfJkUO8QDwbAOQJqRiGt7aRG3XP1n+NYwWz2+Ohq6JrjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gf22fGh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gf22fGh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51B71F00893;
	Fri,  9 Oct 2026 11:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791543917;
	bh=0J2t7tD10PfuC6fDorgJWLWI61V3dJe9D36lKjQnfv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gf22fGh7cYGEVSPDOg2h5vUUcJE3R/+WvUa4rWhy3kA2RTrW6Km7yk6I1dD+zmIgp
	 QTDIxA+Nhhk7S27Myg/reXHCSsH9Vlh2q33wvqHGlfMkQvKXTvvc6kW0Hty9bM99GK
	 MKPGCd3SX+9yFGHsrSmV80TEXzKq8EWF/mGSOEiQ=
Date: Fri, 9 Oct 2026 13:05:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Kees Cook <kees@kernel.org>,
	"Dae R . Jeong" <threeearcat@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com
Subject: Re: [PATCH] watch_queue: Fix missing locking in
 watch_queue_set_size()
Message-ID: <2026100954-spindle-sleet-932b@gregkh>
References: <20261008224233.9675-1-cenzhang@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008224233.9675-1-cenzhang@linux.microsoft.com>

On Thu, Oct 08, 2026 at 06:42:33PM -0400, Cen Zhang (Microsoft) wrote:
> There is a race between watch_queue_set_size() and post_one_notification().
> watch_queue_set_size() publishes wqueue->notes, notes_bitmap, nr_pages and
> nr_notes with plain stores and does not take wqueue->lock, so the four
> stores are not atomic as a group and, depending on the build, notes can be
> stored last (gcc 14 on x86-64 does this).  Since keyctl_watch_key() lets a
> watch attach to a queue before it is sized, post_one_notification() can
> already be running on another CPU at that moment: it reads nr_notes > 0,
> passes its bounds check, and then reads notes while it is still NULL,
> dereferencing notes[0].
> 
> An unprivileged user triggers this reliably by watching one of its own
> keys through a notification pipe and racing ioctl(IOC_WATCH_QUEUE_SET_SIZE)
> on that pipe against keyctl(KEYCTL_SETPERM) on the key from another CPU,
> triggering:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:post_one_notification.isra.0+0xa2/0x1e0
>   Call Trace:
>    __post_watch_notification+0x148/0x180
>    keyctl_setperm_key+0x119/0x130
>    do_syscall_64+0x108/0x4c0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> Fix this by putting the four publication stores under wqueue->lock.
> post_one_notification() already runs with that lock held, so a poster now
> sees either the whole pool or none of it.
> 
> Fixes: c73be61cede5 ("pipe: Add general notification queue support")
> Reported-by: Dae R. Jeong <threeearcat@gmail.com>
> Closes: https://lore.kernel.org/all/ZT-S8Q7tyutcvu_q@dragonet/
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Assisted-by: LLM
> Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
> ---
>  kernel/watch_queue.c | 3 +++
>  1 file changed, 3 insertions(+)

No need to cc: security@k.o for public patches like this, thanks.

greg k-h
