Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993919;
	b=w0AOMcp46RgBwj05JxGI1LXGd/L8uoT5+RDjobudla4p8IMAa4E84+Aft3K57Vro2L1W
	 boYL/Gb09EzsEM3jBjo0vaFAAykcp5/q2BR5f011ORhx69eDdbVRU+myvn5R6n/d5cL4f
	 AsZOpZoiuGNUS7wI6hy9qpdw1pPEKxhYpgNQBAWvmrnxmkTsz7HQaxkG/8ATXYXPMxFv1
	 hT9Odfa2mTu4q3h5hjRHbalT9XKCx1p0ug4PORKNj5EBCs0yI7kGDeCRjP7L7/I6w7hsU
	 OxOp/n9mkTN3Xkuccs0YikijeHl/qWL2oCXpTvbLeMT5b2A9KtF7GAP+EHnXBHi/44w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993919;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0BwIbAgO4w25lpI6cBszZErjWnrwx5qWXtLMQEt52vU=;
	b=Wsmbc7Kbd4Z3gVIZExZP5dFgYhgB8X8NTdTfhFj/rMvIpkN9mdV2TTBjkjoD8xXD0mtm
	 tqmT5DmwEb1jx9e5FiGhaLINVh8rUY5NijWYTmUtOr1Ta8KqQdAla0t4ldpaNTQ0oFJY6
	 shBO8yTqLA8XPnNc0I4HYB+/fgQGqVREyvAc76vaDD8WqC1HhQ39A8YDf25v06ZvrMrLQ
	 ctzt0QIGkc6DPvFWywb7T7ikv4pCEYRVnzM/up/7sxYH4TrgRVynOFyWdeWLDg5BW5Bp4
	 CgbwcgT474qIpenzMDXWh7/TZVeqQo5o/CeLxlgD2uKqrRVGPLY1ByS8JW7eMWkK1yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jfUMzFRN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B2606A31C;
	Wed, 18 Nov 2026 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jfUMzFRN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12201F000C4;
	Wed, 18 Nov 2026 09:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794993919;
	bh=0BwIbAgO4w25lpI6cBszZErjWnrwx5qWXtLMQEt52vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jfUMzFRNkP+zjdb9+fLF/yx0YwJT2D3cfSqE3+17ArSBDZue1KcqexRnIDzh1w8vU
	 JFio2DogKkzYF6MkwtbbKtlxEVBol8pq0LCn0EXTQmdWRjgUmlOKHjRXlJc4rKz2LE
	 bRrQKSPjKcFPVQHmslrhPgG2O7TwTCv9SRvtQ9CQ=
Date: Wed, 18 Nov 2026 10:25:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ziheng Wei <zihengw03@163.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] parport: do not re-enable interrupts in
 parport_claim()
Message-ID: <2026111833-smudge-judicial-02bf@gregkh>
References: <20261118075816.2323688-1-zihengw03@163.com>
 <2026111853-raffle-entwine-0b64@gregkh>
 <20261118084818.2348842-1-zihengw03@163.com>
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
In-Reply-To: <20261118084818.2348842-1-zihengw03@163.com>

On Wed, Nov 18, 2026 at 04:48:18PM +0800, Ziheng Wei wrote:
> On Wed, Nov 18, 2026 at 09:11:37AM +0100, Greg Kroah-Hartman wrote:
> > Are you saying that this lock is never held in irq context?
> 
> No, it can be taken in hardirq.  One path is lp_console_write() ->
> parport_release() -> parport_claim() for a waiting device, as the
> console write callback may run in interrupt context.

Then your change will break things?

> The invariant that matters is that every user disables local
> interrupts before taking waitlist_lock: parport_unregister_device()
> uses spin_lock_irq(), and both wait list paths in parport_claim() run
> under write_lock_irqsave(&port->cad_lock).  Plain spin_lock() is
> therefore safe there, even for a hardirq caller.

That feels wrong, don't you think?

> The old spin_unlock_irq() is the problem: it turns interrupts back on
> while cad_lock is still write-held, and for a hardirq caller it does
> so inside the interrupt handler.  The "blocked" path in the same
> function already uses plain spin_lock().

Ok, so the larger problem is that we have 2 locks where we should have
just one?

> In your other mail you wrote:
> 
> > So, this isn't a real issue given that no one has actually noticed it
> > in 20+ years?
> ...
> > parport devices should not be used by 2 users at once.  If you do so,
> > you get to keep the broken pieces :)
> 
> Sorry, "two users" was unclear: I meant two parport drivers taking
> turns through the wait list, not simultaneous use, which is what the
> wait list is there for.  The race is rare and was found by code
> review, not from a user report.  I still think the change is worth
> having, as it is small and fixes the interrupt state, but I will leave
> that decision to you.  I am happy to drop it, or to resend with a
> clearer subject and without the stable tag.

If no real user ever hits this (who has parport devices anymore?) then I
would not recomment changing this.

thanks,

greg k-h
