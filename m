Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836945;
	b=LWHsVNH5+yCkL8VQBg/et+Ht92iECqvnD6cUh7lpwWQeEg3tewUmmIJJ/2qTZxoZB/Av
	 Lj/aSVaaZ8nHfsnYT1BjPpdclOgFM0Umz/gfAI1pqasDQ2tEwTipiWBjW8j/Eg6N/cZkI
	 Q7NaAbIMKqULz+NZUO1ygyIARTcJkoEoV8BSoLdZ8myWHIzyWX2L0nMXvCeN27cQv9UyV
	 bA2jQlAwewYYCN0KuGWBTNdENtoLFvW0r5MELIQjwKNCgy0I7w5dtqed7hcKEgAmDCXas
	 0mXxflTzkANvAVw3rqpX5j/Kn/Wc6wdIbh+6PW2Qge1rbsjjehbS5VQMwL3NKR8cr2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836945;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=DFdOhWU6rrUNtBxs7OKZEKOfygj+nZIgN0RkgQ/IbpY=;
	b=Bpv+zFRN+PUJNCul//ZGYc9yvnp2vUmnvXXD8vffUJLoV3WuBtsgYtKwf8e035rYpecj
	 qrBfR9WlyW4F/i7n6zYIC83JBPKxav5JTQexoTEysdr0bV964Av62XM2u+1pM0snU4Z59
	 6zYOHOISMfl+LwzsPMT4A+fnyU1innotxQxmoxT+VIIf1vF+D0Iiuw4dc4NuA/BgNMWnU
	 y9lpsP5tMT10WYAzVkuUDGWg3LSZwf/tEPeGBp85cYXLT//DqKavz9QOePsHZ9UeAknmK
	 /jDENv5k4G6HhOTywMVbWWbUTtpf8yyZ8KEe57OoWTdCSaW8Xa0eTDgLXc79Q+QhxbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4ljiRpJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A2606A32C;
	Mon, 16 Nov 2026 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4ljiRpJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6A81F000C5;
	Mon, 16 Nov 2026 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794836945;
	bh=DFdOhWU6rrUNtBxs7OKZEKOfygj+nZIgN0RkgQ/IbpY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h4ljiRpJ7By91NxPFN7fGycl52uOpbQxSl3PglYfE97LdMKgzkuTLMsLHieTtUT1G
	 kvWGmijarYhsWpfAwo7py+gNHsu/Qs8nBraAKEjLwS2tVM45f+ZpeSchLVVOtojzPt
	 +t58RUw/io9S/csondilcc1l2MjMnxcAOW/T2RaI+7VRwGvhkZQNmHjAsa+n8MjSmS
	 UkrXX6eBdWFK+6yTXKQmfW787I62j7B8TA4kqVemzJQyJFH26F3fAB4kkw9Q3j8+gQ
	 dBCa0Yv5ruRvRmuITpwm0trzCi8jRCP/gnmA3pzZegfVW+AxP4ZxiJ0v5JsiP7V8Ag
	 WdCL6JTeAeEmQ==
Message-ID: <3009a6bf-0a76-4891-852f-3dd4e527ee60@kernel.org>
Date: Mon, 16 Nov 2026 13:49:02 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] misc: fastrpc: consume in-flight reference exactly
 once
To: bo cao <treebacker@foxmail.com>, srini@kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 stable@vger.kernel.org
References: <tencent_BA84E1B456527B98F8AB612A15AE6F5FA409@qq.com>
From: Srinivas Kandagatla <srini@kernel.org>
Content-Language: en-US
In-Reply-To: <tencent_BA84E1B456527B98F8AB612A15AE6F5FA409@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/26 8:20 AM, bo cao wrote:
> The response path is supposed to drop the in-flight reference taken
> by fastrpc_invoke_send() exactly once: fastrpc_rpmsg_callback() calls
> complete() and schedules fastrpc_context_put_wq(), whose worker drops
> the reference.  Nothing enforces this: a second delivery of the same
> COMPLETE response (identical ctxid and sequence, so it passes the

Why are we even getting the response twice for the same ctxid?


The driver expects only one response for a given request.
Is this firmware bug?
Which platform are you testing this?
how can I reproduce this?

> sequence validation) re-queues put_work after the first worker has
> run and drops the in-flight reference a second time.  The context is
> then freed while the invoking thread is still processing the first
> completion, and the second fastrpc_context_free() also drops the
> fastrpc_user and channel context references a second time.
> 
> Track the first delivery with a plain bool checked under cctx->lock,
> together with the sequence validation, and drop duplicates.
> 
> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
> Cc: stable@vger.kernel.org
> Signed-off-by: bo cao <treebacker@foxmail.com>

Thankyou for the patch, Please use get_maintainers to get the list of
recipients for this patch, currently you have only send this to few
people making it difficult for others to review and test your patch.


Second this does not apply cleanly.
> ---
>  drivers/misc/fastrpc.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index c77048076aee..f56ba5e44e1f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -271,6 +271,8 @@ struct fastrpc_invoke_ctx {
>  	bool is_work_done;
>  	/* process updates poll memory instead of glink response */
>  	bool is_polled;
> +	/* first response already consumed the in-flight reference */
> +	bool responded;
>  	struct kref refcount;
>  	struct list_head node; /* list of ctxs */
>  	struct completion work;
> @@ -2725,6 +2727,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>  	unsigned long flags;
>  	unsigned long ctxid;
>  	bool stale = false;
> +	bool dup = false;
>  
>  	if (len < sizeof(*rsp))
>  		return -EINVAL;
> @@ -2749,8 +2752,13 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>  		ctx = NULL;
>  	}
>  	if (ctx && FIELD_GET(FASTRPC_CTXID_SEQ_MASK, rsp->ctx) !=
> -		   FIELD_GET(FASTRPC_CTXID_SEQ_MASK, ctx->ctxid))
> +		   FIELD_GET(FASTRPC_CTXID_SEQ_MASK, ctx->ctxid)) {
>  		stale = true;
> +	} else if (ctx && ctx->responded) {
> +		dup = true;
> +	} else if (ctx) {
> +		ctx->responded = true;
> +	}
>  	spin_unlock_irqrestore(&cctx->lock, flags);
>  
>  	if (!ctx) {
> @@ -2773,6 +2781,14 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>  		return 0;
>  	}
>  
> +	if (dup) {
> +		dev_dbg(&rpdev->dev,
> +			"Duplicate glink response ctx 0x%llx, dropping\n",
> +			rsp->ctx);
> +		fastrpc_context_put(ctx);
this seems to be an extra put

--srini
> +		return 0;
> +	}
> +
>  	ctx->retval = rsp->retval;
>  	ctx->is_work_done = true;
>  	complete(&ctx->work);
 	 	
