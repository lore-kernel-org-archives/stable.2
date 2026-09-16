Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08634AAC4D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577643; cv=none; b=m9ft7Bk/XERVQyJDHvQuOmjSYvq3D3MpNig1uAu1qcOYCyO/k73/DUXL8mztrO2rppi35+hV/kQVQx1isQwIGZrrfo/DAAzgO0POntCTqEUmXVAyXFI/ckuuEmMpTNym0iJ9Hw+ZVpdm96EqUi5L0n6Bwb/0XhpjtEeFmXbGVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577643; c=relaxed/simple;
	bh=EM7CE+WdCTpAe7xOGaTErjOkfP5tYkgIqeyCvMsIy14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ya6iQ1pA10TDx1HmcAb7TcCeHB9IJeDK70DwfJhWb7TvNqtHMbE6KuPPBD2+7Rl0PE5eudrEB5294oEgdvI1HzDQP07Cvb2D+nl+xmRLZ1v0553Th7zu6Ihkc9x/vhUjFL6OvHwVX/O0AM9YNVTzejce8C042YFBC7dsK+u58j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APOYAFfI; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APOYAFfI"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae6f1635so665389eaf.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577625; x=1790182425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qiMEGCD9dITrWSfnCr0MqfmzsfjQT2aA9fOLt9oXWrQ=;
        b=APOYAFfIbWCVrGQuRaTBLCgMSL1JCI7tgh9x8gmAONSADgnCnY12/vJ2wxHvfAcHOW
         39Fj6c3KHR5m2Jcz69T4SqWjX9DQYqJDTr7ot55Zp8XUHGESrq/4xkGK7VnuH3EtDebL
         h55MLPATOrJm4deRVrHgE8HmFAme7AQ6CHOloGdP5khJbuKvGCqymGAjMwn6JvE06ShE
         0mIIbLjn5OcYETtXDd2WxchroRZICEL8jKAScxjUxhasSL1S62YNq92kJeJ1jN69M38Y
         k66ReB/Hy7AfKBWs/CxKyQjJ22T9iO0wWaImNmtIz51UTqkKDhxM7vfIzGwgS4VBhzU2
         051A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577625; x=1790182425;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qiMEGCD9dITrWSfnCr0MqfmzsfjQT2aA9fOLt9oXWrQ=;
        b=YW0Xcnu/aqYkbSvrP9FQaaCcvFtMG8DakOpX+Fjk+5M/KwyCGa8AvN6K+LEfiRTjUy
         TjS5Y/Mck/w37xYU6/9ay80vx9AXeB4l3s8ZF5/5sIAC5ihQWzLnsC571ZHyxhT4a0zS
         ZUeskOHEV45Z5VeYWOjWHt3vM5L67tbpci51m+qCwsQz3WDTAbKe3I0lmLnOcGgSiZ/8
         deL6z5HFVOA9un4meaKb/3dkYbORHhXJFoHV8J74BjwSkmCIFmwbrObrT7hwWpFBc6Ce
         L9KGWcVY03bE7S43l04LBVnGIyu8YQxclXdQGTHfxZcy5fSuL00VOglj9JvgDwgS1516
         Vx8g==
X-Forwarded-Encrypted: i=1; AKwUvByL8I2BMdAdmOeeg37PP2FaIoTATNR9RIG6zP3sN0D/GutsSZXB6+YwOCp8/U2WP+nIR0Cjkpw=@vger.kernel.org
X-Gm-Message-State: AFuF++lUNZPifEPJMFL6dPJJJcLmjYt4B/noEoguRQzj2uYuOhX3C4Fj
	c4+I4BaAlwtR53faW4m2TLSZcY/goktTbDntsIBqotIVPsFxNlhIunHk
X-Gm-Gg: AYBFou0ljyBkxLVQbIBGicV1CiVs2O5pv2Y9Pl6NSMDxNrfpYCEqXUmExw5357037MD
	jq9EigPW/Ck2oUkeGQ9PVRC708ROAzKr/yAH6AFU5+zUiLXX9dTYsvsKZKDQSaP3inkOwXobbwy
	EHzDuTZRhJhdiaJGjcVLXZemWzzmu7i7KMINf4SnNpczakaeaCOHx+pie0AYv2QxURR2Rcsj9wB
	tjhgUDCUJ//3dzmziDCHlgUYb0MSzqI5alnuj5PrmKf6F0o+aRT22u1A+1DRXNctIgtFql9vL8s
	V05lkwS5GqPE0KW72ilFDr5auI3CIyyKCgvBfeskanaXGsrqJ2+tEABWMYQOsNt3r2ss7ZrUGKK
	DzAV/SDYa3rArgakomje+scfsk4KroumWrS+U3rKlz5PRT9Er36dAV475S7Y3tYKm6GvQKRqGDC
	zZcaHNHeu+uB2mm1rRZZA9l5OgeBEGrl+q/zHDefAyDxM7AqN3JVgMCZLRGKFCmNXWEx8NbGvLr
	YgNdFUSPW9NKLEd9hmB
X-Received: by 2002:a05:6820:827:b0:6b7:46e9:96fe with SMTP id 006d021491bc7-6c7d3fe8d67mr3338481eaf.46.1789577625513;
        Wed, 16 Sep 2026 09:53:45 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4842a786574sm2835261fac.16.2026.09.16.09.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:53:45 -0700 (PDT)
Date: Wed, 16 Sep 2026 09:53:33 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Luigi Leonardi <leonardi@redhat.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] vsock: ignore empty child namespace mode writes
Message-ID: <aqrJjfJHWXJafehx@devvm29614.prn0.facebook.com>
References: <20260915141547.3010692-1-qwe.aldo@gmail.com>
 <20260915173050.3176344-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915173050.3176344-1-qwe.aldo@gmail.com>

On Tue, Sep 15, 2026 at 02:30:50PM -0300, Aldo Ariel Panzardo wrote:
> __vsock_net_mode_string() returns success without updating new_mode when
> the transfer length is zero. Its caller then reads the uninitialized enum
> and may permanently store a stack-derived value in the write-once child
> mode.
> 
> Return before calling __vsock_net_mode_string() when *lenp is zero so
> that the helper is never invoked with nothing to parse and new_mode is
> never read uninitialized. This also prevents an empty write from
> locking the current mode.
> 
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: stable@vger.kernel.org
> Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> 
> Changes in v3:
>   - Move the !*lenp early return before __vsock_net_mode_string()
>     instead of after it, as suggested by Stefano Garzarella.
>   - Add missing maintainer CCs per get_maintainer.pl.
>   - Add Luigi's Reviewed-by.
> 
> Changes in v2:
>   - Return early instead of initializing new_mode to the current
>     value, which would silently consume the write-once transition.
> 
>  net/vmw_vsock/af_vsock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 622dbd0467..XXXXXXX 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2879,6 +2879,9 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
> 
>  	net = container_of(table->data, struct net, vsock.child_ns_mode);
> 
> +	if (!*lenp)
> +		return 0;
> +
>  	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
>  				      vsock_net_child_mode(net), &new_mode);
>  	if (ret)
> 
> --
> 2.43.0

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
