Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F624A841B
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420310; cv=none; b=cv+hQRvs/F8F8ZDyHFVwVr0/V+hhCHBcUKIEvphBSCCbWWUjils7czpmtOzEy+cT14ocLewFdwQlsTuxDBvvx06TSP2VZNypQssrxyUDdvWVTkxGWaXWsrwy1IBQlJK32YbtOlwvd1IjHSdyBukE5+36mGym7w7RG9K7RW16zok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420310; c=relaxed/simple;
	bh=A9Rd6XAhehC6FSAcNaYmzcAkwF+tFQQn8HWAyRXVdWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpGcYgzEVlhAOpplDPGQneJGJRmv8bk5qn25gSlFznUp+rOyl4EerNK1GOD5aquLPTGOucrVdKdoPjYhrl5IZBwOBqELO9nDaroGUz2S6ykMVa+hGANRdEjZTg3oYQAxmUrHv6u8bduqRUr9akUPwaq6+XfDW1tERRURNv5c5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIIGd/7X; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIIGd/7X"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so21550485e9.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420306; x=1790025106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RMkyii5nHC7DaWpR9AlxXwbE4x/ZU4aGF9/tiqe5J7s=;
        b=cIIGd/7XhsXJnzcaB901Xbqwl+UJBhNhc8a5Sh3dgHNy1M+y3wEsx/XE5kAh73ytL5
         fbsFeRupnsBIF98QHJm6GhI5+9catO65QXRa734WvFEwWRPtYQdD9ijelJQvLq53t6sA
         V/CC3Vo74Jl0+qmtpmlyz/1PIQyYqQQQOQ69JiAa2Gl/YoWgDVO9k97GjKD+u+NXTTVB
         EWNQd2NzsBxY6RIO8zQuVTL3xr3MtDhRTnYEWiImqGwVv6mFCrPlMeyt2UPBGqCiX2S9
         Aon1KUtkqPvvxKp3RxMC4o7HSHC33DD7aTG5L4yuBsj+dJ+FIgiX4+cklSU5L0ba7Dca
         xJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420306; x=1790025106;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RMkyii5nHC7DaWpR9AlxXwbE4x/ZU4aGF9/tiqe5J7s=;
        b=Rs1a2ILCiZK5TYrinQPqvuH6mxBUjqL4pS2Ku4CWZjh7bamQEvl8GqrsaVFhbC/iDy
         OF1uBIF6tBwt21sg+xRnTcJ6+gILyIKEveogg6f8+IEciw/chPFqNtBYmW7Y9ls8lPj6
         jFJjK595BqVa/Q/K9D6AKTSZ6SSWoUeVpOlmzPy4RUt5/o3QBkBHvGNaxL9wOsb/UXvH
         qF6Gq7m3YYc0B9oKC3h8QSQZVpfT+Sh/7Hn/Vl5PEAb4FvHcH+XynCw+9nGVzoZClMrw
         TpMJXlutB6mnlSkWOPdQptnBH+hR5+FmtnSVLF0KgSvvFBdaf7G8dAOn+qtlFKXF3YRn
         L0Xw==
X-Forwarded-Encrypted: i=1; AKwUvBxSL15mazIZ/OKrWWZmfKru+6dsDQWeEvoTN/q41FOa/A5gUqzzIN8yAMjbutPvnsk9NmeKiM8=@vger.kernel.org
X-Gm-Message-State: AFuF++mgkaoB3WeQPTey0h8x4mL+B6SNotF9TRzeSI/l2tIGLc7cYd9F
	a0M5S1OsWBjHZieQOZ6ROidRTBK9Aevu9UNiHiGqB3rVHoIgbtTVeC2KAvbfJ67M
X-Gm-Gg: AYBFou2KmntuXaXZFrVjik19QzkUoOS1p23Wpve9Zx1FdRNfhwJvgAoNDC1fcb+fl22
	Nd5lY8m05UEcNqikxixMkx33/2MxGzJgwYODCph+beIHAo3xMdVBzfbd3eoA6xiprcdy3UjU3M2
	zLn/BZCtJ9xEoDbGnK1D00eVjcIXe7/f3K+rdDQ5zhhkGiyBp9mlEZo8WQgVhLfu0dtCYyB6I71
	Z2zP/mk3xm3Ca8sA6FCNPoBM+t9Ec/1uJLV5J6YuEsJ4/O3dLU45Iufwr4opcOdRF+56VuXsBd3
	5yS/+VXir3rZWOZPZf759VfYBOJPl9wpOIY2i7+hrdPSgI50GJgkMngUGgIUTfHGOPfRaMnflPC
	SoP3VDW+zNIvua0zyRwarCh0IFn+CjSTLiWCU3oFqCQy3Wb9vT7oNiIjxPuA5o/Ew5dZJWoLee6
	aiWciMMARINVFUOLNcwmcYtPOYTuZOk28A0t9Qz8NNtLWVcs47MjQsn1cjF2VvGMvgJ3JMApZz7
	vo5+rRF238HerHXowK4bo4rjr/0hPevZsAb
X-Received: by 2002:a05:600c:1c19:b0:49c:fa21:1c84 with SMTP id 5b1f17b1804b1-49e7a692504mr62148715e9.25.1789420306427;
        Mon, 14 Sep 2026 14:11:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef28e6asm6888635e9.1.2026.09.14.14.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:11:45 -0700 (PDT)
Date: Mon, 14 Sep 2026 22:11:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, Jakub
 Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v10 01/14] rxrpc: Fix lack of short-send handling in
 rxrpc_kernel_send_data()
Message-ID: <20260914221143.2084bcc2@pumpkin>
In-Reply-To: <20260914151340.3227501-2-dhowells@redhat.com>
References: <20260914151340.3227501-1-dhowells@redhat.com>
	<20260914151340.3227501-2-dhowells@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 16:13:25 +0100
David Howells <dhowells@redhat.com> wrote:

> Fix rxrpc_kernel_send_data() to loop around if it detects a short send.
> David Laight suggested doing it here rather than wrapping all the calls in
> loops.  Further, remove the len argument and use the iterator count instead
> and return 0 on success, not the amount copied.
> 
> Note this is also a prerequisite for changing the way rxrpc_send_data()
> works to return a short send rather than an error if some data was
> buffered.
> 
> Fixes: 651350d10f93 ("[AF_RXRPC]: Add an interface to the AF_RXRPC module for the AFS filesystem to use")
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: stable@vger.kernel.org
> ---
>  Documentation/networking/rxrpc.rst |  6 ++++--
>  fs/afs/rxrpc.c                     | 28 ++++++++++----------------
>  include/net/af_rxrpc.h             |  5 ++---
>  net/rxrpc/rxperf.c                 | 11 +++-------
>  net/rxrpc/sendmsg.c                | 32 ++++++++++++++++++++----------
>  5 files changed, 42 insertions(+), 40 deletions(-)
> 
...
> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index d82916657a3d..09d9da92a1be 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
...
> @@ -912,21 +910,17 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
>  	msg.msg_controllen	= 0;
>  	msg.msg_flags		= 0;
>  
> -	n = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, len,
> +	n = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
>  				   afs_notify_end_reply_tx);

Probably needs s/n/ret/

...
> diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
> index 0fb4c41c9bbf..f3980348ed34 100644
> --- a/include/net/af_rxrpc.h
> +++ b/include/net/af_rxrpc.h
> @@ -64,9 +64,8 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
>  					   bool upgrade,
>  					   enum rxrpc_interruptibility interruptibility,
>  					   unsigned int debug_id);
> -int rxrpc_kernel_send_data(struct socket *, struct rxrpc_call *,
> -			   struct msghdr *, size_t,
> -			   rxrpc_notify_end_tx_t);
> +int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
> +			   struct msghdr *msg, rxrpc_notify_end_tx_t notify_end_tx);
>  int rxrpc_kernel_recv_data(struct socket *, struct rxrpc_call *,
>  			   struct iov_iter *, size_t *, bool, u32 *, u16 *);
>  bool rxrpc_kernel_abort_call(struct socket *, struct rxrpc_call *,
> diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
> index b8df6d22314d..dad04062213f 100644
> --- a/net/rxrpc/rxperf.c
> +++ b/net/rxrpc/rxperf.c
> @@ -525,12 +525,10 @@ static int rxperf_process_call(struct rxperf_call *call)
>  		iov_iter_bvec(&msg.msg_iter, WRITE, &bv, 1, len);
>  		msg.msg_flags = MSG_MORE;
>  		n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
> -					   len, rxperf_notify_end_reply_tx);
> +					   rxperf_notify_end_reply_tx);

Ditto

David
