Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892A357D02
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062027; cv=none; b=SFK9gzuV90ZdmGdsP23MKOqBdTRqS11t2d2TFqq6mEpDM0p0i04h+mtqkdWuA1zfS3WChRAkFFg7ZD/xuwn3NTo1qSRKiFn+dYmtnXdK5Mihd/40dRWsAJ2DLLCyk3sHqKTveT8/VQbE0DTJkBh0dklnjGo+NvfQLabRKhn4eTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062027; c=relaxed/simple;
	bh=Av+FGjwoY3yk/xo27LgIS6t5fs/LExN+zH51SpAyCVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbax/KOVmoar+ioy45XN8y7jxMYeH78Wx7dq1ZHh22i6NAFe8XDh6wiZ31m1jT/Y7m2YNkxe14mue+SbrTyqnNbNIDTdq5opJWWIpTe9r7vogl2cz4lDbGMYyYybxXeKkU92Io+cgGHMtXwBSuoArdcZgYWGt7v61uq+2tel4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d9jJ0hvI; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d9jJ0hvI"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so574765e9.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783062024; x=1783666824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4fISY5Nru22VZDWDI5xhsl3OaYFamOr1yzRy76AwW0=;
        b=d9jJ0hvI12GddObuUOzHSejI0LA3gareJ9L3S+8P/Ad77pFn0QouJ6r6YmT3XDPitX
         mHLsrnMueFJvD2Rvw/7PzjzYMsx/PgdHbBjhxvJtlISTyAr142yGid9IzUJyeBe6xQ8J
         1206hkgZcNg3+1OeJycRWh71U6RXp4Rrp0acvLjkcyklAUTJo8er9X7YdqMegYJGqq8V
         CWegsSX4Uw/HnfhK3ZAIedRlWIrB4J2u8+9rJEXPl8XPsNbFIjUraCOcTR9ll8TQiKWq
         3pTRl46D+Jzij4agEbesK6pjKMr07dN/q/XtGyCSuYW/Pp5TUprZLD1DjbOKrU+xcbtB
         Gxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783062024; x=1783666824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4fISY5Nru22VZDWDI5xhsl3OaYFamOr1yzRy76AwW0=;
        b=MGDEj+NgqhBEoNT+ilY1ExEI3m5EOB0FMUdIDBLxz3ofveD/7uppihlgzw25FtTVmX
         LBa+3xfa6vF5YteYw4P96FCQFI5/LaUBrTZWRtihUpz3+zsl9G6SVCgkX0iowZEuQLC0
         lC4Ijj28HwVuJbSKzNkxepvXkdfb1refZb8GN1mB/0Vlz7gLjWMDYDmBgpV24qGPiGq3
         GpDxPRtksn4YoACXnLzhK2C9aiccTtZ7JjpnLDORUjXcevLIEI8eVTfiMM1hZP/a+Cqm
         Migq/tIasOexXyGXWgsbsMmuERJgUbOsxQ8LuS71WMtkWxMs4L4eeBXWWZyPai6a9q1y
         g/WQ==
X-Gm-Message-State: AOJu0YysoAF9zQADM+JoKxyJyVS5Iz1hUwb/eNVKrgRzlAnwLLGFALi8
	RkwvWvFjiUoGzMZUOolT+GdHykYKgcwcokNi3vnGT/+iLpsXZHUJEkq4N1jglBgaRTU=
X-Gm-Gg: AfdE7cmv27Xb5754OBzAeQANqPfCjKa8LfUCACUB14fbqQkcLLQd5dUOwItoasZitOg
	YpssIGsw4N6Psh60n4bqKai0LEHzj0k+GTS2KCg+lNcVIEqYU2i8aqomi7U6xeOcRDsFA3NkcMA
	YOi10z+G2qo5+Z8ScuR5mOQX/0GD5viA2KT+gd/ZUyeUBlRvpyUR7H54mBcYiFQik1kx1LffsEH
	86cfKnzedmzfv1Ymty1cOTYS4p9y2i04Lp4xq63hqfHUKulkLW1W5opVq2h2xbD7sws5I6ewGDN
	kC8jNpT6diDT+ZYDa90QKOvImFENM1ZNH69a86PUkoJj0dj31paT1yI++yVmeLsjwdOC81940bP
	56S+77gbDJazS7cHAogttRp4tppCpr9ZuxxbXiRw8/HCjRj5d3u+XLDcnOYspaysX7hvnZAKWs1
	ejVVL+0iY8dMikvt/pB9Hj/3PO1IrHxBEP
X-Received: by 2002:a05:600c:a4c:b0:493:c55e:9fa1 with SMTP id 5b1f17b1804b1-493c55ea121mr87125075e9.39.1783062022761;
        Fri, 03 Jul 2026 00:00:22 -0700 (PDT)
Received: from u94a (27-53-162-24.adsl.fetnet.net. [27.53.162.24])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-497d17d3274sm3706972b6e.1.2026.07.03.00.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 00:00:20 -0700 (PDT)
Date: Fri, 3 Jul 2026 15:00:08 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 00/60] 6.18.37-rc1 review
Message-ID: <akddu8pDgJ3itnfh@u94a>
References: <20260625125645.554579168@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625125645.554579168@linuxfoundation.org>

On Thu, Jun 25, 2026 at 02:02:45PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.37 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps, test_verifier
in BPF selftests all passes[1] on both x86_64 and aarch64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/kernel-patches/linux-stable/actions/runs/28642657596

[...]
