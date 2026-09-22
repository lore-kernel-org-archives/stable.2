Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B9522687;
	Tue, 22 Sep 2026 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066463; cv=none; b=A5E3juJGl1dT+INZwfxHwtFZzBYEdVhidZb1WLlY9EtjzVRRYHF+Nj6dxWR9zdqSW4k2N2HQ0c/junUMoQLhopdoZHbXtTybA243t99MzzJqlavSC9MXr1unzbwAgb6QEWOnVN9xkUxJ6lgRkswAxImzabVpqMY3VmYeB7GAvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066463; c=relaxed/simple;
	bh=z1K4vY1QuWzZJyOJ7DWfzNrA4ziIZ1nRaT+3zOrVj0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSwoyKcT3zhrg2S2vihtjoe3MEt+lULHLIRS9SNpQJVWxYsI7dp6P/eUbavZItG037GCQzVeYUzl3LG9Jo459dE2knDv1DaQcu8dqIgMFNApnDooYJq8uh7bn9hVICBqkHJOAbrMVEzr/HNBJWYOud+iTma9mZCUjfvTdJuLXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AbeHJGRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AbeHJGRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A971F00898;
	Tue, 22 Sep 2026 08:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790066461;
	bh=YmqkH21AkFgkZkA4fPQz1x4A/HlSQ3R2zm2NsV5Vr9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AbeHJGRqxirXP3mNUHqTZOB+ioIcdOTlu1FPqInqKIpw6SaFdWOf7JkbjKZwp1Hc/
	 1En3t71xcogwA8eQmgKnoQ+HxtTGwb/pZyFuvwXSJuOItr8NAcHL5GByG5cz1O5+5r
	 GBW/F+sasI+n1xppxx+gvKLM1WhN613vm+jaACiU=
Date: Tue, 22 Sep 2026 10:37:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, stable@vger.kernel.org,
	Benoit Sevens <bsevens@google.com>,
	Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [STABLE v6.18-v6.6][PATCH] HID: logitech-hidpp: fix race
 condition when accessing stale stack pointer
Message-ID: <2026092205-threefold-hypnotize-f780@gregkh>
References: <20260401144811.1242722-1-bsevens@google.com>
 <81n26386-p78s-5rqq-5s7o-p8s01sr95q74@xreary.bet>
 <20260922075400.GA2268440@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922075400.GA2268440@google.com>

On Tue, Sep 22, 2026 at 08:54:00AM +0100, Lee Jones wrote:
> Dear Stable,
> 
> On Thu, 09 Apr 2026, Jiri Kosina wrote:
> 
> > On Wed, 1 Apr 2026, Benoit Sevens wrote:
> > 
> > > From: Beno=C3=AEt Sevens <bsevens@google.com>
> > > 
> > > The driver uses hidpp->send_receive_buf to point to a stack-allocated
> > > buffer in the synchronous command path (__do_hidpp_send_message_sync).
> > > However, this pointer is not cleared when the function returns.
> > > 
> > > If an event is processed (e.g. by a different thread) while the
> > > send_mutex is held by a new command, but before that command has
> > > updated send_receive_buf, the handler (hidpp_raw_hidpp_event) will
> > > observe that the mutex is locked and dereference the stale pointer.
> > > 
> > > This results in an out-of-bounds access on a different thread's kernel
> > > stack (or a NULL pointer dereference on the very first command).
> > > 
> > > Fix this by:
> > > 1. Clearing hidpp->send_receive_buf to NULL before releasing the mutex
> > >    in the synchronous command path.
> > > 2. Moving the assignment of the local 'question' and 'answer' pointers
> > >    inside the mutex_is_locked() block in the handler, and adding
> > >    a NULL check before dereferencing.
> > 
> > Now applied.
> > 
> > Benjamin had some ideas on further cleanup (allocating with __free__ 
> > instead of using stack pointer), but that'd be a little bigger cleanup, so 
> > let's keep that separate.
> 
> Please could we have this commit backported through to linux-6.6.y.
> 
> e2aaf2d3ad92 ("HID: logitech-hidpp: fix race condition when accessing stale stack pointer")
> 
> I will follow-up with a backported version for the older releases.

Now queued up, thanks.

greg k-h
