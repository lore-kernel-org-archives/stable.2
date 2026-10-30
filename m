Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349572;
	b=ayVQVZFoHMbrM8lNMJ7FL/Gf79mmlWXhM/a598l1C1buKwjVRIP5xLn/RzWgusQhPWiJ
	 jBsQAWHL0K7+yhEgdxZgYYjcfl24sydOmw+c/zDKxQu+IytUr6jGIMs99s7D0Px6K+ypt
	 WW82JJar7UI1am4MLvR7ZMBNxLw3O9HynV7Ud0FZuYVm20wQoRi6/KwCaepkdkMyAJGt8
	 cm8UGhW3hLdQpBkwXgXKg5Yt6PuIMd0IG+XEJ3VwGfPjfG7OLWyIhtiWiIM/ZtGYgG6gO
	 v/h1l8zeu2u/OkQF1zILJsuqYgm/NPlUtbo1tEVA0bnjpIzYCGbOyxxkF3M5V/KB+DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349572;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iMvcjmVS7mcW+03h1rtRZeUeBjNjMtZ8NB9r8UDlmI8=;
	b=GI7p4RHpPK+p74JdQZ2lq1UJlTkGTLaltQX3Puuj52QlItxoKM9iNkBUd4IArVpk+Zn5
	 w8r3En0iCtdSDbRfztQ8ycEdLqnTTywhhLEhx7Wqi7hq4e6g0pYOwB+RMgWGIDA/znHXR
	 HWVkvk9R1qV/c149h6cO6Yxz+IyWmrg7IroEoTnIyKuN1eAnAlIZvmrxic7SCwBZDQAur
	 l3F5fTI2VX4ZVfU7J6TN4kxv+OHxgLiHjXcT08eCwcP5eZCh6pEAOfMrkH4x/3lgvWEqu
	 gf7e8mSlNpeuQmHmcMjc0LEsw55O1ZlIFodNN3Wo9GQR3gYm4G3d76LsB9xkQscrRaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=L5rlVAxX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED50606A31D;
	Fri, 30 Oct 2026 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=L5rlVAxX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C031F000C1;
	Fri, 30 Oct 2026 08:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793349571;
	bh=iMvcjmVS7mcW+03h1rtRZeUeBjNjMtZ8NB9r8UDlmI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L5rlVAxXIAL1DQCsFn4s7ChQa9iIQ6VNkvoSwK09Ly/bMxMAH72rV3SN71yTOTUFv
	 pvmZ9DX9TEmaIETPLRoniLHtaYsFEo+TgM5zCOXsAb6eJqO5wCffUN4+KW+JO4kRvT
	 /l1Y7Ix3bfhE0fw7MeZsze205g1sd9xcz4u57XUo=
Date: Fri, 30 Oct 2026 09:39:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: bo cao <treebacker@foxmail.com>
Cc: srini@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] misc: fastrpc: pin invoke context at glink response
 lookup
Message-ID: <2026103041-handrail-civic-a9fa@gregkh>
References: <tencent_18454D1845AB2A759EA9AB3ABE52E67AE205@qq.com>
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
In-Reply-To: <tencent_18454D1845AB2A759EA9AB3ABE52E67AE205@qq.com>

On Fri, Oct 30, 2026 at 04:19:55PM +0800, bo cao wrote:
> fastrpc_rpmsg_callback() looks up the invoke context under cctx->lock
> but then uses it after dropping the lock, including the ctxid read in
> the sequence validation itself, ctx->retval, complete() and
> schedule_work().
> 
> The final kref_put() happens outside the lock (in the invoking
> thread's bail path or in the put_work worker) and
> fastrpc_context_free() removes the context from ctx_idr only after
> releasing its maps and DMA buffer, so a context found in the IDR may
> already have a zero refcount with free in progress:
> 
>     callback                          freeing thread
>     --------                          --------------
>     lock; idr_find() -> ctx; unlock
>                                       (refcount already 0; free is
>                                        releasing maps and buf)
>                                       lock; idr_remove(); unlock
>                                       kfree(ctx)
>     read ctx->ctxid for the seq
>     check -- use after free
> 
> Take a reference on the context inside the same critical section as
> the idr_find() lookup and run the sequence validation there too;
> drop the reference after scheduling the worker (or when the response
> is dropped).  kref_get_unless_zero() is required because the IDR may
> still hold a context whose refcount has already reached zero while
> fastrpc_context_free() is running.
> 
> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
> Cc: stable@vger.kernel.org
> Signed-off-by: bo cao <treebacker@foxmail.com>
> ---
>  drivers/misc/fastrpc.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

These two messages are not "threaded" properly, sent as 2 separate
emails.  Is that intentional?  It breaks our tooling :(

Please use something like 'git send-email' or 'b4' for sending patches
out, that's what those tools were written for.

thanks,

greg k-h
