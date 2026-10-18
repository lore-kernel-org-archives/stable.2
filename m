Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AACA32ED40;
	Sun, 18 Oct 2026 06:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792306040; cv=none; b=uZe8EnILnPyfFasv2QSxSjfQNLLjb9CJOrW2Cw0A0UgekOuNrMUvxF2ESik4tl3m641ZyAf3tnk3YFFIMUKhst+c3yJa9kblUb7i8TT6ksXUQZYFKQcjS0rbFTv1QrMnX2ZXq8Hr7Ud/8XI2ZisFOEQURpib5EtNqMoizKIVdbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792306040; c=relaxed/simple;
	bh=Kag3VvMNOMl0BZrtLk5BrSlmPs8H9EdaW8N3lXiMD94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKMuCxXnPSw2pKKzDfg59/pVPHXQW8+Iczz5TVEBOW/G9encChg1nzHDZgDwjrD7oJZ3H4j1PIohfHkhY8atF7wRSiQ1EN53b67OFBK5/KNCy1STKZjINjqiEhga5ffZUhqXAj4P1ak0EeUqFH7r+Rp9Fg/buvkK8yZtJweRtX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dxt31r+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dxt31r+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0367B1F000C4;
	Sun, 18 Oct 2026 06:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792306037;
	bh=30fmuKsiOgutazDDAqdwR0Z+rtWTId1UKgz9yLCQBBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dxt31r+Cn9KLSlF0j2FoMxu9MUUycQBkbAMhUiSpaLdgM0/Uzu71XTh3/bK1Q+kE9
	 3Y8Ey89b3PV1kJtZpHI76TopcsrFx8c8lfCrJktiPawXodaGo/4n3SAerpboC9BaLg
	 ezWnhcZA0qBN4VnpliNjYtWqnXNY5IKwh1Y5ilB4=
Date: Sun, 18 Oct 2026 08:47:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+a2e50fb40695811c2dab@syzkaller.appspotmail.com
Subject: Re: [PATCH] greybus: operation: arm the timeout timer before sending
 the request
Message-ID: <2026101814-static-agreeing-29ad@gregkh>
References: <20261017171743.24612-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017171743.24612-1-ngocthang2710.1999@gmail.com>

On Sun, Oct 18, 2026 at 12:17:43AM +0700, Nguyen Ngoc Thang wrote:
> gb_operation_request_send() sends the request message and only then arms
> the operation timer. The host driver can complete the operation before
> add_timer() runs, e.g. when the transfer fails right away. The completion
> work then calls timer_delete_sync() on a timer that is not armed yet,
> the synchronous caller wakes up and drops the last reference, and
> the operation is freed while the timer is still pending:
> 
>   ODEBUG: free active (active state 0) object type: timer_list
>           hint: gb_operation_timeout+0x0/0xc0
>   WARNING: lib/debugobjects.c:629 at debug_print_object+0x198/0x2b0
>    kmem_cache_free+0xfd/0x6d0
>    gb_operation_sync_timeout+0x1c7/0x270
>    gb_svc_process_deferred_request+0x5f3/0x1150

How was this generated and tested?

> Arm the timer before the message is sent. If sending fails, delete the
> timer again. If it has already fired, its work is queued and drops the
> active and operation references itself, so the error path must not drop
> them a second time.
> 
> Fixes: dbec27298b0d ("staging: greybus: operation: add generic timeout support")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+a2e50fb40695811c2dab@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a2e50fb40695811c2dab
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
>  drivers/greybus/operation.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
> index 7e12ffb2dd60..19b0cdeca498 100644
> --- a/drivers/greybus/operation.c
> +++ b/drivers/greybus/operation.c
> @@ -766,17 +766,22 @@ int gb_operation_request_send(struct gb_operation *operation,
>  	if (ret)
>  		goto err_put;
>  
> -	ret = gb_message_send(operation->request, gfp);
> -	if (ret)
> -		goto err_put_active;
> -
> +	/* Arm before sending, as the response may complete the operation at once. */

"Arm" what?

>  	if (timeout) {
>  		operation->timer.expires = jiffies + msecs_to_jiffies(timeout);
>  		add_timer(&operation->timer);
>  	}
>  
> +	ret = gb_message_send(operation->request, gfp);
> +	if (ret)
> +		goto err_del_timer;
> +
>  	return 0;
>  
> +err_del_timer:
> +	/* A timer that already fired has queued work which drops our references. */

Why is this comment needed?

> +	if (timeout && !timer_delete_sync(&operation->timer))
> +		return ret;

Did you just leak this:

>  err_put_active:
>  	gb_operation_put_active(operation);

And again, how was this tested?

thanks,

greg k-h
