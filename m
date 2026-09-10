Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170453CA481
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789068385; cv=none; b=jas+TOAqDfJ5N8K9SUtb4CHAAfVL1iHKRBK5Ofrs8MSXqv6+v6GjAC2uKYqTNa4HGmcVnevV9mzoQRPTeuUYHh98OkE7nYUqe7WU5SnpBQSTM81fsdFzJ6x3Z9fNuCDLKjKqdIlps+go2gW3Pxer22ZS5Kz1Gnu4aorBAG+6adA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789068385; c=relaxed/simple;
	bh=PK8bn5aU171tfON89RThbs87i/BE1OYud3wLsDUh4hU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=cuinUpWZNqRw/Z2sIiA+tNZ+zWMeJPJdme1kvhQoIvLiWZ5Ne6uLWfq6v5qffAj/+cIXVsrigQWfiA3n9yHp0El2/JCYuNHGJcuUfBXs0ZqqRkMzNFaL6MiFwx7ZYudIjwunYse/JkMM6zSDrT8/LQKaumJyktnxYc73ok3L+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TJzVSaBe; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TJzVSaBe"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadeb4so5516685a.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789068382; x=1789673182; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4xukxtRxDbbfqZShrZASrA+GXX4dRNxrhliA3H85hXQ=;
        b=TJzVSaBe6JWN3LWgLyYOZUFto49U5CTuJraV4VIPAmuBR7ZJBmyKCIBU/+2bTVxEW4
         L56FQrsc2n++FdHOiZlMa+30UoluoJ0OCeD82XWQ8TnSRUcpS6ELlAFAWX3rYjhvxYxa
         I2N+mbEtMnPAp62CPX6EQDkK20snic25TSNJ64Sdyjf0tiOv+O9rDDGOhIPVsNhFqjof
         L/w7ohojbwyPI8eaVyj1W6zxrNkyHzPZ6GQ8yVjBCucZL9KINHUD4D25ygbh5MGbCV8j
         u4s29Csmji/0TXNgyFvp1JVremYVguwLbdOkyQa5b8ktuNfjBxUz806L0llSUr5ufvr9
         irJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789068382; x=1789673182;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4xukxtRxDbbfqZShrZASrA+GXX4dRNxrhliA3H85hXQ=;
        b=NuVgAlWmnsNZItaiazZs3G0gtGpvh/+PfueRaUHzU/Wl02w4skKOqLwfQAL7/qUL5w
         iwNnhUjMMILgTJRqEAwzLYa4wObeYVQH6zXQJT7vpMGFfvJV/QMQIsuEjsb8gPM+bvmx
         l6P+PtSUXEd9uxZOa84wD5+vq/qWothKmxpXa9m8KPpNOexyM05KpLdrIp/pBoWqwDpk
         ijWv4bVGg4Rl8EUOvPkk765MbF4fQcqKCRLXd05syNKNkV6MWtJYzfqEJ8ndA61TXqmm
         Qm4ugr2FtF5IjqN0gIxAH5I/oTnevOlOPAEHwsVJ1mTaHOuacE1viiT7YTguma2SnoVo
         CoYA==
X-Forwarded-Encrypted: i=1; AKwUvBwZ1Uito2/O7G9BJZoqJ4i3m6i9rH7iz2Q6gKdI00JFBNDTR/OkALOdzJFSYEmsz/BW3yqLujU=@vger.kernel.org
X-Gm-Message-State: AFuF++mc4feq0yX7AllxQ1IIcxUPIsKMbGypRZ7lHlFlm5UWgS5XKr5W
	WKWcf+2IV1nxN8qZjpnhahC+U1IxiZ+hbzE2lbLXEiNddbsf1uZfHAO6kIgwkIXTaw==
X-Gm-Gg: AYBFou2BKx7aoCTa3DmyFwuY2Izft6mR+Vlvk9LiMhdor9sbBV/jUe0vAZupZyzi3L4
	mmAYLgxAqTU3jLvcEAQ0yzEuR56NdVROdBdfIk4QdCtVrzi2ffHb6oRk0A4p5ndNBIfGodz0uem
	T/abW/gj7rwkYw5xFLfuAvyhv7dZZy7YYf/v3pgDXHvdlVrh7d9ZWgqkZ5LQTu8OdYcg1W0bnvS
	ifDVHMiErvGeeVAYHE422xi6KQ5HAM+o/swSENwcdyiJ4AG3CNIaiRJcQ9vCREs/h+1iTIMZF7g
	g87HofiMGN+aKxNT34VMi5GlvIGlVZnROF8xpLY+0mi7uw+TZYvGewHxI/EElXICLQFNyy9bb8e
	BB5/es+8Qk1ndT7Nir8vI6V8KKfpzqpXtNxjtOnMzklBEOPZoC34BgzN1p8y5EyjNFbg7OyMRvL
	M5eO0Zga8Azyvcbuwp3Yf1tZvqd1RaVv25zSadQqa9euct6n9CepOWnSuFXzC6FUW/tZpfXnaPM
	cDIoFQ97eIDm4Z5avSLpdojV8DACxcOVDsiMoz8yhFlyFpKgu6ghugqkWRTsY/L0HbuNA7/4Ll/
X-Received: by 2002:a05:620a:28d4:b0:936:8840:427f with SMTP id af79cd13be357-939ea037c44mr52546485a.4.1789068381925;
        Thu, 10 Sep 2026 12:26:21 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e8045b46sm56168385a.18.2026.09.10.12.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:26:21 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:26:20 -0400
Message-ID: <f444c557e77c22eb578216a5e6eb5b98@paul-moore.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260909_1743/pstg-lib:20260909_1550/pstg-pwork:20260909_1743
From: Paul Moore <paul@paul-moore.com>
To: Bradley Morgan <include@grrlz.net>, linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bradley Morgan <include@grrlz.net>, stable@vger.kernel.org, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] lsm: fix size queries for getselfattr with NULL buffer
References: <20260619130305.27779-2-include@grrlz.net>
In-Reply-To: <20260619130305.27779-2-include@grrlz.net>

On Jun 19, 2026 Bradley Morgan <include@grrlz.net> wrote:
> 
> The lsm_get_self_attr() syscall allows callers to pass in a NULL context
> buffer to find out the size of the output needed. That path still
> compared the computed entry size against the caller provided size first,
> so a NULL buffer with size 0 incorrectly returned -E2BIG rather than
> reporting the required size.
> 
> Only enforce the available buffer length after checking for the NULL
> buffer. Cover the zero length sizing query in the self test.
> 
> Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  security/security.c                                  | 8 ++++----
>  tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 5 ++---
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 71aea8fdf014..fa0d7e036249 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -406,15 +406,15 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
>  	int rc = 0;
>  
>  	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *));
> +	/* no buffer - return success/0 and set @uctx_len to the req size */
> +	if (!uctx)
> +		goto out;
> +
>  	if (nctx_len > *uctx_len) {
>  		rc = -E2BIG;
>  		goto out;
>  	}
>  
> -	/* no buffer - return success/0 and set @uctx_len to the req size */
> -	if (!uctx)
> -		goto out;
> -
>  	nctx = kzalloc(nctx_len, GFP_KERNEL);
>  	if (nctx == NULL) {
>  		rc = -ENOMEM;

I'm not sure the existing code is necessarily wrong.  The existing code
allows for an E2BIG length check against the current necessary size, so
one can still do a length check regardless of if a buffer is passed.
Even in the NULL/E2BIG case, the necessary buffer size should still be
returned to the caller so that the process can size their allocation
appropriately.

Or am I missing something else?

--
paul-moore.com
