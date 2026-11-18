Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989500;
	b=bJiVh7pz4VcSIltY+kZTDOSQEm8pFfjsbv3uRKRRBQyhHGk/O8nUX+yfqZ2upmoCB23M
	 X1iD/ePsASAzGO2JkvYdyksclTqXLUUHd6hKDnwjJ+IbMXpd7xReA39YlMkGAnj9VvJo/
	 a8kuAa7Am7QdpIwpWxlOvJhZqwGJTxL19z5cqS8v+8MkAhpm7Tv9VLz16thte+85VLz7+
	 c/9/+ZauIAnqnkl4peMpdFBJhZruS4pcYQK+wjP7A6jNpqgSwKRksroQ1fA3wyzwwU/RD
	 bubLbMSZx9nOd/kxDq8QsBY8WTWdaFMVLC3NKVeY/h55pJAxRx93580hba8ceeIpWbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989500;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Pe2HYnK5JpWzPMVEhg7pY3rC+1m/EkUjRtSD3x5RMWw=;
	b=ltmFo30E+HnY8k+Kt7ZSEPOkbADZi/9vKJM2IFL4Nknw5JmXpCNDz6goOa+7DiNZTnXO
	 s1+MtR+7j2AiArXkgZ9AdtOm9iuwUc6xmhcOWYjYXS7aIYgvcup3SXk4T8LDQjTDWsLrr
	 cYoSuaj2lhQbcbRsj7vx9Ly3SXfHu6+97dzcT/rJ78FGL/ETMl8HVZjwOYXQC1pgVyKIn
	 c10uRvAKXif5mdB5BDi9MtnOZeiL3OK06PKnJJ7BFsNOcDbz5hrpHNuvITs0fs6frswGN
	 oDRT+OhZNeyhwvOg8DV4yXsekvz0TkhWFHwgFKuyWNTxMA81yA8cnXuJi2ammryJW9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=L36cVUiF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4C606A31C;
	Wed, 18 Nov 2026 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=L36cVUiF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7F41F000C4;
	Wed, 18 Nov 2026 08:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794989500;
	bh=Pe2HYnK5JpWzPMVEhg7pY3rC+1m/EkUjRtSD3x5RMWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L36cVUiFLaLu9eBDCIs83oKb9cHcTy/e22ik6yxuRlZWbWyYB+lN84tC9hMlLuVXI
	 hEPssMahBiz92DN6T2arE+M775vpch0GS8mvvFUR9L7bJRXXI2Ki/FlxVpuh1rBIys
	 RYYCjQ0VQxcYRbMU+vZWN2l7aj90GmITqHSzgfuI=
Date: Wed, 18 Nov 2026 09:11:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ziheng Wei <zihengw03@163.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] parport: do not re-enable interrupts in
 parport_claim()
Message-ID: <2026111853-raffle-entwine-0b64@gregkh>
References: <20261118075816.2323688-1-zihengw03@163.com>
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
In-Reply-To: <20261118075816.2323688-1-zihengw03@163.com>

Wait, your subject makes no sense.

On Wed, Nov 18, 2026 at 03:58:16PM +0800, Ziheng Wei wrote:
> When the claiming device was on the wait list, parport_claim() takes
> it off the list with spin_lock_irq()/spin_unlock_irq() while it holds
> cad_lock with interrupts disabled:
> 
>   parport_claim()
>     |
>     | write_lock_irqsave(&port->cad_lock)     <- IRQs off, cad_lock held
>     | spin_lock_irq(&port->waitlist_lock)
>     | spin_unlock_irq(&port->waitlist_lock)   <- IRQs on too early

but that's not why spin_lock/unlock_irq() is being called, it's because
this lock could be held _during_ an irq path, right?

Are you saying that this lock is never held in irq context?


>     |
>     +---- port interrupt on this CPU ----+
>     |                                    |
>     |                                    v
>     |                        parport_irq_handler()
>     |                          read_lock(&port->cad_lock)
>     |                          spins forever: cad_lock is held
>     |                          by the code it interrupted
>     |
>     | write_unlock_irqrestore(&port->cad_lock)  <- never reached

Ok, but again, you have to look at the lock itself, is the
waitlist_lock() ever held in irq context?

thanks,

greg k-h
