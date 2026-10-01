Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51233E2ADB;
	Thu,  1 Oct 2026 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840904; cv=none; b=nvsA/iWUGkRD3SVyap0ZBpMymcWVfaZoX8XaQ91zO8sjPOq86EwTaFn6m6Qy/Vsi38+kyGxc9clQhROleDxBk20IuARamUw07bZGEmFmIwNgXk6U2ciMGfa/9tRm59tq0dA96DcON4MCC8q9pkqlI8pV5yPxBlsZS55UB1Mu7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840904; c=relaxed/simple;
	bh=yg69lzNJ3fZPhpDznbur/c3nxkH01CElVx8mElSsiJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYb5MhL6vji1m9MS+s1AoqmPsBE9PQcmTDxH1ZUfJgET5LFZIXpdn0otCZMszvnRRJlJBLFkSwGEBktHrYkrh9Tg7hZsVcTUnn3mtNpvtmotHLmhpZVaLRPrCwa7wpq1J34fKe28nUu4NFKf7Rjqy00GtNsyQ/il6/za5dqRawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b8Xx7JPs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fOiUvp11; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8Xx7JPs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fOiUvp11"
Date: Thu, 1 Oct 2026 09:48:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790840900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DARbdJqOEdFwsn0mY+WvbsESMHGkYUdCqPS/ZWhkTMo=;
	b=b8Xx7JPsYj23mx4m/9nqC6bOz3OdUmJTOUKHN5qXNopGLpCJaLUjVeW+hJWlHIPQvKjco3
	yOnbIIV+6/maa/pqONei53cykAcjSuJ8bI9ItjpslFkYLoXKBFrYgDT+/jNur2KXnqTXSI
	nKhMmLeMEP27o/X9mlzFP+gNwf6G16memsVblYktS5CIUZYVyhBKTZceXEnbS1i6frjg/U
	tSq4BIWkxkgbEacw+82FZ8cZ5cA/LwXvvXUoICxY6plrEexfX0YHJ0AOp3IsX2yAz+cZNK
	o+NgGt2fvhk9o7UrxCVSYQDa7qWrdKnOMugdCoNjwyF9jMEq9/bz/E7PSvB2oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790840900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DARbdJqOEdFwsn0mY+WvbsESMHGkYUdCqPS/ZWhkTMo=;
	b=fOiUvp11GFAv3NdAykr5PrAEjCub4Jwh4Enps6OLUsuBjRlxe9OnMRlcoxLcrHKimJsuV2
	lS1cKx2WulVA/0AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] netpoll: use a raw lock for the deferred
 transmit queue
Message-ID: <20261001074819.gQ3w8q6P@linutronix.de>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
 <20260930192103.62973-2-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930192103.62973-2-kmehltretter@gmail.com>

On 2026-09-30 21:21:02 [+0200], Karl Mehltretter wrote:
> netpoll_send_skb() calls __netpoll_send_skb() with hard interrupts
> disabled. When direct transmission cannot complete, the latter queues
> the skb with skb_queue_tail(). The sk_buff_head lock may sleep on
> PREEMPT_RT:
> 
>   BUG: sleeping function called from invalid context
>   in_atomic(): 0, irqs_disabled(): 1, non_block: 0
>   rt_spin_lock
>   skb_queue_tail
>   netpoll_send_skb

How is this possible? netpoll is only used by netconsole right? And this
is CON_NBCON so it only prints threaded. What is the missing piece?

> The delayed transmit worker has the same problem when it requeues a busy
> skb with skb_queue_head() after disabling interrupts.
> 
> Add a dedicated raw spinlock and use the unlocked skb queue helpers under
> it. Keep raw critical sections limited to queue operations. During
> cleanup, splice the queue to a private list before freeing its skbs.
> 
> Fixes: b6cd27ed3388 ("netpoll per device txq")
> Cc: stable@vger.kernel.org # 6.12+
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sebastian
