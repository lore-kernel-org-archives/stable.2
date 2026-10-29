Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267064;
	b=vlIoAFlwAazwaZtbI4K6fWLxt3DNe4m/NE0/XOVjpRBBjecg3+W7PeiZ/qCKG4qWUTDd
	 TqavtRpzaVityVKPQlr7ZUOGJdJ62IcjjoFvCN8Uz6yDEslGpcL7UNGmXROXioLlKY0Oa
	 G/wwO5ndmdJG+5e86lS+eiQlQULhxoZzkznHgSDsSWckvnS7o4gBKIFAzUhNc/czAYgXC
	 NuNzFv7552fQRIDG7E7Do1KO+lcVJG7SkgPohe4uCmt3P0rEtmQ1wzEbrx0N8yftjUoRM
	 Vsa80rDHSy2dTMCkcYhdzt8gTdZI4CBX0GtlO0a3ZvObqBgUOSZ5VyigGrF3qRT1oAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267064;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SAEFpkJDHdcJT6sr2jpBTsI+5gKG0hsleJwMMoaxnFY=;
	b=1AE0fcRJrdhELXnhMUmf5uYY6KXq1tRQmwJ5KDRS9j6GJkgY1uQMczGqTSfCdhORRiee
	 Dz88AU8LnDud6rIvqOwPtmtAzSA/341Ota/1UpVfRVGHRWLIJjQEJrJVVQyXREWYkMQrS
	 faQWjGkJlOdXte1yuXqikDcJllLJ9OaFutqlefniVwQclyokEZ1Dp419JfwOtdx1Z+qe8
	 +Ty0WvmS0us2EwLpQ2kTkU9RkrLilvSqxSOAbngSMt+C6LEHqX34daz4jITYj1b2dW5DT
	 9zLrJLfreZSzNPWR/+jP9SmZuq2hJ8/dS7vFq/05inWDkxdxaYEgBBHjnmf5HbHaTDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Elpz4Vqa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298A3606A31A;
	Thu, 29 Oct 2026 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Elpz4Vqa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C26A1F031E0;
	Thu, 29 Oct 2026 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793267063;
	bh=SAEFpkJDHdcJT6sr2jpBTsI+5gKG0hsleJwMMoaxnFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Elpz4VqaElbFZtqE5XGmN/cRhUmmS9Q7O1V5qK6EFJ1Rdbc3u/ekWtIxqfJJv5F9L
	 93We84UX4IBEvBOPZQZbFhCoEdwSCTl8t8mA2EnzAIRcR1Yud4FZfCe4YMimRMYp5Y
	 cdqk4NFog4foGcXYxogJ/KfVJQc8kpN+9I4No6G4=
Date: Thu, 29 Oct 2026 10:44:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hyeontae Lee <wonju345@naver.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: hold transmit_lock while freeing IN
 requests
Message-ID: <2026102905-manhandle-disparate-1379@gregkh>
References: <20260815052929.146901-1-wonju345@naver.com>
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
In-Reply-To: <20260815052929.146901-1-wonju345@naver.com>

On Sat, Aug 15, 2026 at 02:29:29PM +0900, Hyeontae Lee wrote:
> f_midi_disable() drains in_req_fifo and frees the requests without taking
> transmit_lock.  f_midi_transmit() holds that lock across the whole of
> f_midi_do_transmit(), which peeks a request off the fifo without removing
> it and then keeps using it.  kfifo_peek() does not advance the read index,
> so the drain frees exactly the request the transmit path is still using.
> 
> No hostile host is needed: __composite_disconnect() calls f->disable() as
> well, so a bus reset or a cable pull while a MIDI client is writing is
> enough.
> 
>   BUG: KASAN: slab-use-after-free in f_midi_in_work+0x126c/0x18c0
>   Read of size 4 at addr ffff888104818e20 by task kworker/2:2H/164
>   Freed by task 158:
>    kfree+0x121/0x380
>    f_midi_disable+0x20e/0x430
>    reset_config+0x9d/0x200
>    __composite_disconnect+0xa7/0x140
> 
> Take the lock around the drain, the way hidg_disable() does.
> 
> Fixes: e1e3d7ec5da3 ("usb: gadget: f_midi: pre-allocate IN requests")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4.8
> Signed-off-by: Hyeontae Lee <wonju345@naver.com>
> ---
>  drivers/usb/gadget/function/f_midi.c | 3 +++
>  1 file changed, 3 insertions(+)

This version:
	https://lore.kernel.org/r/20261028074821.579450-1-sonalipradhan@google.com
turns out to be a bit better, thanks.

greg k-h
