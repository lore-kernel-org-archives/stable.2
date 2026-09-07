Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F54BD103
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786421; cv=none; b=tOFRzjtch72SLoBL00bXmngjWdsjO2mp+XW80EV/XUBdfiZuNHnCJjptZMc4oaqQMipMRukR4GRypVoMVDgTCF6XJSz/na2KrBGkX2UjLgEVVDZaf0BVcE56TS5lQYP0qtIsVYrPwwJ7Cpz1jOldci1HURwGcQo0ZAi0kRubWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786421; c=relaxed/simple;
	bh=eoELJwkDlwS9cl0WbC/oBljazj8jzeYPt267DDxKQMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiQemtIMqDb/2mZ1scKnJ06ghJ1jYLrBeHN/YElRdICc5NatF/OzPm45SzZ0MaY1JEJwchd4WobQFLPV21wtdEUbd0vMcz1PPIeqC/Bjtzzh/8VH4YY3LxbZRJOyGI24jqolH+nMnjkWpqnCZpDOyZNiUUo3G2F8VFMOY3S9rvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN1OaUhM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN1OaUhM"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48589798dbbso2904751f8f.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 06:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788786406; x=1789391206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ySxHLNrdZAbSwcz4SMQYBg7MBYiQBtCno7JKBz+dwo4=;
        b=dN1OaUhMVVuEw0c3URs5MBke2AXqLEWnlBw37xX2r1J5Vj4X4SiR4QP5oETKIYeR1y
         VORiQJTSScTbCy2k9R+IKlZuzhdTCl/W7CYCgCRLkqXs6kMzMskSrZQve7qYwkq877ZY
         dyFx01Ihs0FuR1p+SPINfUvrdpMm+r34/twUzRNLZ74X9hGpMmq19OEned9pvmCpHdez
         h+y1RU2OxT3y4dkR9OvypkeIEq685qXquuW6IcvkTISaMoZ26cNF8yG7+Xh0UuSREITh
         pa+YgjGItCzAOWGfj3TF0cuvIiTliUMZw6H1KFUXyn/eQx7ph60XBKA60iw9z+O8Dwjz
         aAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786406; x=1789391206;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ySxHLNrdZAbSwcz4SMQYBg7MBYiQBtCno7JKBz+dwo4=;
        b=TDyvALo+RTJaLI7hfhPTYsrU033C0I+19Lfe1Fq+C7yV63gZV5H8kwQCxmqr/e4YC1
         l4qMeyRo49NqGKc6AWbXZNa4XidpmZJtQZsPKlBic3fRw8BtwgyCvh5Y2QZMeWPDqTwv
         5h/PfdR5NT3Gk//KkN3o0pueJR2jBytcHnMP4M8OF6dAnBOkFaVIJq8sZOjoBRUVV2UJ
         cEBK13Uc5kQVMYqvyjTDztd1owm2SiUAKlEEiUfZn0WIKs3oE5tiU4Cu7BonrhWz2gQ2
         zqV1G0h6/zCWsGMU9O6Jl4tYiUsyO6r/zJN8DxV8FLSEa0LRB0VaVyIXhGmBzDi4xyZ7
         GQpg==
X-Forwarded-Encrypted: i=1; AKwUvBz3O1JNecOn4xZYhTHZIlqjCxFm5ZKQbb+bmTn0mSHpnU3LFGO5Mo5yYfayjbLkG+FN88WJp10=@vger.kernel.org
X-Gm-Message-State: AFuF++kWAHASNNiyQeHL+vHXQgvg2JDS6ckioZBP/7NSuQU6hlYD+S+6
	bYuKpw1c1gEe9QTHFtJ72jCNEmpHJFwTgPhCw8plAOc3Zr3SpD1GxrRk
X-Gm-Gg: AYBFou0/jmLKB3sb6xciZ/eSfqMQRYVIWhpQ38sSy8L7BLVP+xRzo4DaRhu4JdTLEwt
	7npcLLB8jokBSo0+F4Qz183jPnoY5TTuy9NKVSufEhQNyF8qtuEMSXjQc5W+qTV9ZCMWKTThMeo
	Oi5h1GA39noWRY5iXoAeWhC6+JmrBbs/xPLUjGEd/DB14XP66UBh49hcprto8h+xymDJQYnOzEt
	h0+feF4/3tMalnLJ0FpmR+xqJBKzYTXOOxPa6uwFfSg5khTVtsJv4zGSHndoreEFO1OdQNEG6XX
	uclZKhrA+30x4Z93vozEBOyUnY1KYjpi8heVXBqwRI+fg+2vTJzjk7fnTn8Y5JjyFBQJwrezR/N
	J+iScnC/5jMRpPtjdothOxVfvZFXxdZf5YNv7hiKLhY1C9K1bMR335l/AogD2O8mFAMqZ8nQCBF
	lJtkZbW+Oy57+BbSQhuNIkdLf3+TpkT6mcSr82W0eTAu/yKDHn2ZniofX6TzlM3o1Z+SFC41n7v
	XnWc9F5QiVm3dguqGE3HrzBUg==
X-Received: by 2002:a05:6000:260f:b0:485:8be8:b2ba with SMTP id ffacd0b85a97d-4858be8b4bcmr22749936f8f.49.1788786406401;
        Mon, 07 Sep 2026 06:06:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c81c3sm28717743f8f.26.2026.09.07.06.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:06:46 -0700 (PDT)
Date: Mon, 7 Sep 2026 14:06:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, Jakub
 Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v9 01/14] afs: Fix lack of loop around sendmsg() to
 rxrpc
Message-ID: <20260907140644.18dba619@pumpkin>
In-Reply-To: <20260907113743.1453210-2-dhowells@redhat.com>
References: <20260907113743.1453210-1-dhowells@redhat.com>
	<20260907113743.1453210-2-dhowells@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 12:37:28 +0100
David Howells <dhowells@redhat.com> wrote:

> Fix the afs callers of sendmsg() to send data through an rxrpc socket to
> call again if a short send occurs.
> 
> Note that this is also a prerequisite for changing the way rxrpc_send_data()
> works to return a short send rather than an error if some data was buffered.
> 
> Fixes: 08e0e7c82eea ("[AF_RXRPC]: Make the in-kernel AFS filesystem use AF_RXRPC.")
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com
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
>  fs/afs/rxrpc.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index d82916657a3d..a80b043d36be 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -412,26 +412,32 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
>  	msg.msg_controllen	= 0;
>  	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
>  
> -	ret = rxrpc_kernel_send_data(call->net->socket, rxcall,
> -				     &msg, call->request_size,
> -				     afs_notify_end_request_tx);
> -	if (ret < 0)
> -		goto error_do_abort;
> +	do {
> +		ret = rxrpc_kernel_send_data(call->net->socket, rxcall, &msg,
> +					     msg_data_left(&msg),
> +					     afs_notify_end_request_tx);
> +		if (ret < 0)
> +			goto error_do_abort;
> +	} while (msg_data_left(&msg) > 0);

Is there any reason you didn't change rxrpc_kernel_send_data() instead?

David

>  
>  	if (call->write_iter) {
>  		msg.msg_iter = *call->write_iter;
>  		msg.msg_flags &= ~MSG_MORE;
>  		trace_afs_send_data(call, &msg);
>  
> -		ret = rxrpc_kernel_send_data(call->net->socket,
> -					     call->rxcall, &msg,
> -					     iov_iter_count(&msg.msg_iter),
> -					     afs_notify_end_request_tx);
> +		do {
> +			ret = rxrpc_kernel_send_data(call->net->socket,
> +						     call->rxcall, &msg,
> +						     msg_data_left(&msg),
> +						     afs_notify_end_request_tx);
> +			if (ret < 0) {
> +				trace_afs_sent_data(call, &msg, ret);
> +				goto error_do_abort;
> +			}
> +		} while (msg_data_left(&msg) > 0);
>  		*call->write_iter = msg.msg_iter;
>  
> -		trace_afs_sent_data(call, &msg, ret);
> -		if (ret < 0)
> -			goto error_do_abort;
> +		trace_afs_sent_data(call, &msg, 0);
>  	}
>  
>  	/* Note that at this point, we may have received the reply or an abort
> @@ -912,8 +918,12 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
>  	msg.msg_controllen	= 0;
>  	msg.msg_flags		= 0;
>  
> -	n = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, len,
> -				   afs_notify_end_reply_tx);
> +	do {
> +		n = rxrpc_kernel_send_data(net->socket, call->rxcall,
> +					   &msg, msg_data_left(&msg),
> +					   afs_notify_end_reply_tx);
> +	} while (n >= 0 && msg_data_left(&msg) > 0);
> +
>  	if (n >= 0) {
>  		/* Success */
>  		_leave(" [replied]");
> 
> 

