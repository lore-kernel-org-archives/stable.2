Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A54C367B90
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489440; cv=none; b=tWUgTnK9kWBnSGTIGPqvRP83YyD6+m+Dv5IoAiZIU3iCYsYI4NWew8hPY+us8OXeCx3QmiKe+x1YiLlelE6Q0wt+WIpexAFKggjl8YX7MUCW7yjC3818T50N/MSdsBtfB7oJmqP3rYE6U3ITIFRGxw4Ns8T6W3PilXjuiy+RTvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489440; c=relaxed/simple;
	bh=Dj4DC1J9pwwMveaZ+k/5mOg4gpIBiwaLjJdzckrEfQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfbBrb6Cn43/7PUwg+2SGmv61NIfHSgRakKTc6NtIzENydXShZvjTyu1MG/OhAInGKQ9A3awje7CLTMXGZzuUYoT2ODZRM5V4+tseANUAGlBCTfrbeg6Xgc196wvx87bHt5ETEVho0rylaifnulIKHEp9uGA4JtrD6BF7BbDeHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=RgHXWMa8; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="RgHXWMa8"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e615efd7d7so9412514a34.2
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 05:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1780489438; x=1781094238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df3sqTjVTq2Z9AgKRAsUVI3Sets8Wgdw4AUE2oIw9s8=;
        b=RgHXWMa8UU22wqUbX8HJ63BHge09lMBfjqZOpn/gc1NoStmH1sPatUCon/C+UENfTV
         qheEWPBIuM5GAIZCzdz1PJUDaB78xnfVJp1RJvkDlA2in/qygY1btr6C7ZvDsLCO+NH3
         xZ0Loaa7iWac0Cwua/28SOf/tzwrhkw9Oms/s5aqcbUb1AcmjkOYgTLsWV3Zc6BUWF5q
         2i5VcuiPC8i7rIMvTEhsVgEoH/m8rXEUeGlkmhikVBJl+lXb3oVIWAGbqc6G5QBmKASE
         sCUO/fgjSnE0+Zl24+ZU+RqZv3hgBIZrtD2Zs5jrVqBsY4FEVWliCFd8+mSyZijt40uD
         3cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489438; x=1781094238;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=df3sqTjVTq2Z9AgKRAsUVI3Sets8Wgdw4AUE2oIw9s8=;
        b=LVAnqPBhrvo+r/mL8KuQ0sYzyT0+qUFjHziN7q0Ed8ETwe0maYzwsm0RK/1q+1HzAm
         2lFVUneyM2IkimJhhiULqi1OkwlXNaUzv3zDBOPRppBgCnrzcrp7hKRxuKgG82ptXi6y
         Fl/TP0n8bNl711ErHl83lwf0r1hgw0Lm/pWxFFqSDwXK0ORa/TH4KFGu1ADLMv5YKmT0
         JWMjmsrept1UV20lR1DNVlc7aFEFjpG4NjOrW/kR/MLHaYy5FYULQ35RofpUcnBK2zq0
         gVmw3qrA2r9+nBS4J1LxpDEU9rw2VCBIa+hM53SOv2NGqM0+ea2Nxj77hpN9/0JphlNh
         yxlg==
X-Forwarded-Encrypted: i=1; AFNElJ8brMcezANWQ5hwobzvhfEiWrRqGhxG1uNq30Ks5ny+WLfXvyMHrDAPUFYCnmzwjeas6nYg0D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9aHXJI/MscbIAa/aDcBkjKToMbN9gzYnJt1CwL9Jn3bg6Rv/
	6SRVE2MGBuZ0XsiUNpmAm1NkoYU1r2Fnj8z88HALEilISTGoxX9GXL/r6qpxqhgCFfKaH18Nm0r
	9xhX+
X-Gm-Gg: Acq92OHbwgG6KpciwnTXrT33TxHXMCKxhw8TZxeQCUgc20mP7QrooV/5xt8MhIn9jy4
	0DDuVo2do5n81q95qaYeg9ZDYSdbSO29zoN5xNy4fsjb3SQbMmOf04nkL9oKAg9ZsEwPKd6E6LW
	TmAU5kTdEoH0DwTm5cuOwcAyOxjhJ3CVH7taFNECxHXPVOO74xqUF6fj58VusYLJjxYFWN7W2F+
	eTn/Vq5R0/g9UB3C3o0cx1gpmRpITt8GVB1fWKurWfTwQk6nJoFeOv4Gwen7WZ2fwQd5r5PhvL2
	7cwck9ypvI1A3QSq3s0G69IEbkNf3C/KhgjBhCTnTHUk5ggKF0wLwHoUT5Wq9EEfucf1hOCpiU6
	CpcsR2BYn6KMkwa5e8cqut1trMQb83PWVLDacHU8VdyLLMoTtk+TlPwMOGRrszRCrKrnjwLC72/
	JAgT+Eq1/QwkQZ3eREkFiU3GwA7Vm9DZO/4p1WCTNFlTKKzNKIc/KwUmASVaixoiAij5ngqVHao
	92et89v07ODlHM9N4QAJammZA==
X-Received: by 2002:a05:6830:378f:b0:7e1:cba6:9837 with SMTP id 46e09a7af769-7e6e94dbc52mr1614499a34.6.1780489438403;
        Wed, 03 Jun 2026 05:23:58 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:144e:c181:b1d6:32f9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e746a50bsm1580331a34.2.2026.06.03.05.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:23:57 -0700 (PDT)
Date: Wed, 3 Jun 2026 07:23:53 -0500
From: Corey Minyard <corey@minyard.net>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ipmi: fix refcount leak in i_ipmi_request()
Message-ID: <aiAc2QgS6kI35bii@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20260603120634.3758747-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603120634.3758747-1-vulab@iscas.ac.cn>

On Wed, Jun 03, 2026 at 12:06:34PM +0000, Wentao Liang wrote:
> When a caller provides a `supplied_recv` message to i_ipmi_request(),
> the function increments the user's `nr_msgs` reference count. If an
> error occurs later, the out_err cleanup path only frees the recv_msg
> if the function allocated it itself (i.e., !supplied_recv). In the
> supplied_recv case the cleanup is skipped, leaving the reference count
> elevated. The caller ipmi_request_supply_msgs() does not release the
> supplied_recv on error, so the reference is permanently leaked.
> 
> Fix this by explicitly reverting the reference count operations when a
> supplied recv_msg with a valid user pointer is present in the error
> path: decrement nr_msgs and drop the user's kref.

This looks correct, it's in my next queue.

Thanks,

-corey

> 
> Cc: stable@vger.kernel.org
> Fixes: b52da4054ee0 ("ipmi: Rework user message limit handling")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 869ac87a4b6a..5b9d914cc7a9 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -2347,6 +2347,10 @@ static int i_ipmi_request(struct ipmi_user     *user,
>  		if (smi_msg == NULL) {
>  			if (!supplied_recv)
>  				ipmi_free_recv_msg(recv_msg);
> +			else if (recv_msg->user) {
> +				atomic_dec(&recv_msg->user->nr_msgs);
> +				kref_put(&recv_msg->user->refcount, free_ipmi_user);
> +			}
>  			return -ENOMEM;
>  		}
>  	}
> @@ -2420,6 +2424,10 @@ static int i_ipmi_request(struct ipmi_user     *user,
>  			ipmi_free_smi_msg(smi_msg);
>  		if (!supplied_recv)
>  			ipmi_free_recv_msg(recv_msg);
> +		else if (recv_msg->user) {
> +			atomic_dec(&recv_msg->user->nr_msgs);
> +			kref_put(&recv_msg->user->refcount, free_ipmi_user);
> +		}
>  	}
>  	return rv;
>  }
> -- 
> 2.34.1
> 
