Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150D515E8B
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787705731; cv=none; b=FYgNqGYEWGSu2Om8qPdgF1XnRC5cZOZ+h72O09PaTuiVkRyQdWB33WBxHfq+IVAlLq6gwU7ZLKJvAreo2DhFyPefOqD580g7PVgo5ErA+lrBDRKohRIkP+56recnTKUY6axpTEFDVFtraRLU9Vx9PRNnsWLMA1dGYs31HvrGepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787705731; c=relaxed/simple;
	bh=KX24e/xfOUNVKq/u1CtwYE2BUexw5KY6c7GPFX/cPxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYIIsHL0NhtytcsTegYxx8SKX2Hly57/vq9vR11xXAf8n4rYI11jyszaPcy1uwudPEBDGTz5V0eTeKSYb3rF7AAZRMMu28sfo9VoEdE8mie4ydyz32xjy3Q2dhiIWqXEQxepQmrREucXr6oxsl8kg2QGgpr+xIV8WWSmJk5NyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=LT5Xg0Zn; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="LT5Xg0Zn"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-44cf70de986so345226fac.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1787705729; x=1788310529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:reply-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JZAQFf0rIHwgrxr+ZgMleVg6tK/aEVpe3lmfytJ7d80=;
        b=LT5Xg0Znf4+YEnszT3LpEhGc0Pw3xPYCee681ajyv2+Q+kOv/PO/pGguVBLf7KgQ+/
         SG4H7/okwr95WyuTSIA7HTO+SonTFfCj4mYqu6moi1nryETCbK4Aion6kRpPR2e5YRqf
         1rZETpkoqAp5ATU643zo57POKcZQvSMTxzqetRTpN0TSJaCHWFBMJryFPiPyEOekPvhB
         hXtJS7ml5j/aLese+1s16RQrQGxJ9x8EVQIzkNPFpH+z5cjdEZ9hk7W4txN6VzdhNnyq
         yewejuma+uso3nPgWvksFlDI9b75f5JJmHgVKKTfRQd67MkQwSnpMQWG2M9X0LbLH++2
         Ujhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787705729; x=1788310529;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JZAQFf0rIHwgrxr+ZgMleVg6tK/aEVpe3lmfytJ7d80=;
        b=SRcLxNVfX+U0e9x0+MxF4snZtlj4JdaUVZTZI4LXITBqM498ryl+xhY1xJlAPgTKSd
         ys6gvapPbAwqeIeeHHbFZfkmCcawJS0mgtLRk00JKpQdEZ0GBw5ao49TWo0UWBvIWYxS
         9KXibPKb9iKG9ZqWtHYNFKK+Rv/335oD68ngjksC7Ac8SU2LxG2B1gK98BGevW9dOgwg
         ElYWSBoDwjL41DKgxbxm7WpEIVpl0MAgH+72Dcz/nNVcCsb4hYvGFC8GgRYO6cHJdgBW
         Or447U/Fl7Xoi0Om2n4+M0uS21X/xI4cuVj+W3/6J6XRNmhL+V4bclqLAKbOLvJJJp9L
         GCVQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1hjDdK5+LW/8hA6LCE6FLMWXgEkc7RJFtW7w9iNFmFLhNei4I9VRl9bfzxRm19gnVeMMMPsc=@vger.kernel.org
X-Gm-Message-State: AFuF++kMm3p7fFasUsTHJtLqQbK0aAYhiadHlZ5NtXRr9Eo2CGaX5Z0m
	BW7SZ1wpp2K6w/I4Mge9t53J4GJ5dsWGTsaTl81LxOYKAoqQlmMDi/UJEWzPfqZhTcE=
X-Gm-Gg: AR+sD13bYNDDmExgU6PI1sOfXwVN1Kdn6U6Afww0dUsOjjPbL5y6tmF0LX+Czvxy7BV
	M5Lv2eFoVvl3JVazDAgUxzZRdpcSApbDZRnd0fH+aturDpANoGtW0iKUlb5PL8RAzsU+gO3QTai
	sm6SlS3vUEoZfTaWZ4kQxVYUcyFOhHnUrq5HR1DML96/nuuxV5tF7Iz+2AKjHVopgE5s8ksppkE
	1VoECfmu1ok4P1oGLrUx8wdTni/L6xvngzqXi3tAPAXbBjQ0nioCMiZK31enIcDIVu3IYlUkpop
	Gu5dxS5eKXsgZxClV+7hEFeL5QYgvJz77tyIiHpFySyDxOAMHk8KltiK2A0OQGWtSzEkpkprlyW
	Fm8qEYM0QcT0ePltaC0mkQVpkUFzjV+OpNlhTLLKEinqrcNVJUb1h/RkkP703S20nTaAJzm5O8g
	M8nFZEbHTFGzAt/lSExX81rjjorfCJrz7V5jJs5tg0qdNfQtRnCo620qsSVjHvrBKFT699h9s4H
	Tjm8tvPYULIi3IivlhHNd1vd2pOqyqPg2/CWRIB1ahdxhSqFQ/3+PHm588CUnwIHtc+VwI7Jgnq
	VfqzhJqE0w==
X-Received: by 2002:a05:6820:55d8:20b0:6a3:8738:4106 with SMTP id 006d021491bc7-6b1a04d4e37mr2397883eaf.26.1787705728872;
        Tue, 25 Aug 2026 17:55:28 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:5f83:3ac3:b8a8:ed1e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a25430c6sm435909eaf.8.2026.08.25.17.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 17:55:28 -0700 (PDT)
Date: Tue, 25 Aug 2026 19:55:23 -0500
From: Corey Minyard <corey@minyard.net>
To: Yifei Gao <gyf161023@gmail.com>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ipmi: Fix use-after-free of cmd_rcvr in
 _ipmi_destroy_user()
Message-ID: <ao45ez_1op-h2Na2@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20260825234630.1196170-1-gyf161023@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825234630.1196170-1-gyf161023@gmail.com>

On Tue, Aug 25, 2026 at 11:46:29PM +0000, Yifei Gao wrote:
> Commit 9e91f8a6c868 ("ipmi:msghandler: Remove srcu for the
> ipmi_interfaces list") dropped the synchronize_rcu() between unlinking
> the command receivers from intf->cmd_rcvrs and freeing them, updating
> only the comment that explains why the barrier is needed.
> 
> The cmd_rcvrs list is still traversed under plain RCU: find_cmd_rcvr()
> walks it inside rcu_read_lock(), and handle_ipmb_get_msg_cmd() borrows
> rcvr->user from that lookup within the same read-side section. Without
> the grace period, _ipmi_destroy_user() can kfree() a cmd_rcvr while a
> reader still holds a pointer to it, causing a use-after-free.
> 
> The rework only made srcu unnecessary for the interfaces list; the
> cmd_rcvrs list still relies on plain RCU. Restore the synchronize_rcu()
> before freeing the receivers.

Yes, looks good and passes tests, it's in my next tree.

-corey

> 
> Fixes: 9e91f8a6c868 ("ipmi:msghandler: Remove srcu for the ipmi_interfaces list")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Yifei Gao <gyf161023@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index ab4c85f3d6fe..3f4018194df8 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -1391,6 +1391,7 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
>  		}
>  	}
>  	mutex_unlock(&intf->cmd_rcvrs_mutex);
> +	synchronize_rcu();
>  	while (rcvrs) {
>  		rcvr = rcvrs;
>  		rcvrs = rcvr->next;
> -- 
> 2.43.0
> 
