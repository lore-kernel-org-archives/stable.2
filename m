Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408652;
	b=Dn/8Y5+M8iT6frLDHbRctMduGJ4FNzVFaqvfa1EkTNnTAMsaZIYj3NOS3IJyf4NT3H40
	 a9mclZrBOcAALmiATgH/ipSC7MjcTUg1aVu6KYPP+gfYGr7um4akdPg4quEOz/eKhgV4a
	 bAGT5rE/aQTy8ve4DFwsuTMJR7pgh1StoJIWEz+2HPKx9Mx7KV9P+M5cCTRUL9xYl9Pwr
	 5F3RgD9OWXebpgpeHTrqPAH/C7drCny2BVH57cFG+r6+uFD+D6P1M8qm64uoRHCRZUAsr
	 Jmug5y6WFUX9fDG3nU+vbasUjAQYtymtMgFIALa0iHt8ae5Dbtx12IiTzdnDWCHFoLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408652;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CRO5Tel1RjzXs1ay2+39z6lAjKHeD4/T/34ACHBY2o0=;
	b=4/dJutJjEn37O8iCF5nVfQ9zvO6ZE3ZY6KWj9Oacyy47k5T4ezjxSfgdG+kdVi799Gd6
	 Kzv1Sf09I+bdCC/+7ud4MVJV1Rduzon/AYbSOcJdvWDGgqvA949xYo8HUCNajQVgDzi4h
	 9bFv1whcIfIWkhXSsn8LaX6Km9EhaOqoIhcn1ePSDbwullry0K5M1SGVoj8qoIiibzuN0
	 wzZUOfik/3K8gMnABI3x+Pk0kvW74DuZQ2B4l78/oQYIZbdE9UllS7V04GV4Cj4YNE4Tv
	 WhH6L/jc8r03Rl0IYvP2VIz+j7yk0W9OdvWjz0Hiy7YPh9pi/66xUsKHczpsrzOAR7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oquIw1Lu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A74606A33E;
	Wed, 11 Nov 2026 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oquIw1Lu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCB71F00A07;
	Wed, 11 Nov 2026 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408652;
	bh=CRO5Tel1RjzXs1ay2+39z6lAjKHeD4/T/34ACHBY2o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oquIw1LuPko9xQrUJELBnwskn345Pa0CjNLnbaWuTe1gPG46TRshOlT3TQTMUsqWr
	 H5HPwgGE2gaTAEiCIIPcRxefE/kDsuVfCrlIruA+VfqXzNAE+AZqo1RBFiaP9D64+X
	 chT/Mt7RzF/In9eWtub/qYXtnu7lb18rmyQtPEC+na4fQBU00FTD0BjKK79DNcz3py
	 ker3YOqseqzE5f9NMCriCvAZJKaA1plKrNeZJiPPPj2anRJ3lLh3FpFXfKyiOQUM4A
	 zpEvBx9/ykoYnWsNrmihF87OpWsKUmIJYkwO+ng+MmQP0mIXpEDwVBaG57p/04JaT4
	 ftu1eTthVnb7g==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xR9ez-00000000VcO-449A;
	Wed, 11 Nov 2026 15:50:49 +0100
Date: Wed, 11 Nov 2026 15:50:49 +0100
From: Johan Hovold <johan@kernel.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: core: do not hold the port mutex while
 waiting for references
Message-ID: <avSAyV6QE0Id3rAk@hovoldconsulting.com>
References: <20261104-serial-core-remove-deadlock-v1-0-6a30597adcbf@vaisala.com>
 <20261104-serial-core-remove-deadlock-v1-1-6a30597adcbf@vaisala.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-serial-core-remove-deadlock-v1-1-6a30597adcbf@vaisala.com>

On Wed, Nov 04, 2026 at 10:27:15AM +0000, Tapio Reijonen wrote:
> serial_core_remove_one_port() takes the port mutex and then waits for
> the uart_port_ref() holders to drop their references. Since commit
> 8ca59f7baee7 ("serial: fix ioctl hangup race") uart_wait_until_sent()
> takes the port mutex on every poll iteration to check for the hangup
> before it touches the hardware, while holding its reference for the
> whole wait. A tcdrain() in flight when the port is removed therefore
> deadlocks: the removal holds the mutex and waits for the reference,
> the drain holds the reference and waits for the mutex. Both tasks sit
> uninterruptible, and the port is unusable until a reboot.
> 
> Reproduced by unbinding a UART driver while a process drains a few
> kilobytes at 300 baud: the unbind blocks in wait_event() under the
> mutex, the drain in mutex_lock(), and reading the driver's proc file
> blocks on the same mutex.
> 
> Drop the mutex around the decrement and the wait. The decrement is an
> atomic paired with uart_port_ref() and uart_port_deref(), which never
> take the mutex; the clearing of the port pointer stays under it, where
> uart_port_check() readers expect it. Between the hangup and this wait
> the removal already runs without the mutex, so a mutex holder seeing
> the released port is not a new state.
> uart_wait_modem_status() takes a reference and then the mutex in the
> same way, with a smaller window, and is covered by the same change.

Thanks for catching this. I can reproduce it here as well, and we should
fix it even this is hardly something anyone would hit during any kind of
normal use.

> Stable trees before the guard() conversion of this function need the
> same change with explicit calls: mutex_unlock() before the
> wait_event(), mutex_lock() around the store of the port pointer.
> 7.3.y has the guard() form and takes the patch with a three-way
> merge.

Right, the guard conversion makes any backport a bit harder, but that's
something for the stable team to deal with. So you can drop this
paragraph.

> Fixes: 8ca59f7baee7 ("serial: fix ioctl hangup race")
> Cc: <stable@vger.kernel.org> # 6.18.y and older need the open-coded form, see below

And just drop the comment here, and if you want to help, send a backport
when the fix fails to apply to older trees.

> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Reviewed-by: Johan Hovold <johan@kernel.org>
Tested-by: Johan Hovold <johan@kernel.org>

Johan
