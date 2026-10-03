Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0C35676A
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791037794; cv=none; b=OOnSJSffCGGXeLs5SkXOW2OHbX5AgZGAQNVihts7eD7+CnuGGySyEv5OvadMitn/mTdwkIPexLk2DBcZp21NFHhGp8BmVRCJWOOGIk1yd9/z8zQ18DkDtjMCCAC7I3Go8jGPlznDJ7JCj6zrF84MSpe5NLMpKXiH2DVVCr4HuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791037794; c=relaxed/simple;
	bh=0FDlgE8/WtKxquJ1GTctYIuuqUHSqOHXaOawd/W2wAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaNe9khNrVp87VUg8Z8lX0yYcdwTwTFK2q0VREYX6cHLd27Hfq9/ze2XAL1bgAFoM9Aa6/nmbfQPP4PiE0L0KbNUzYeGm51z782zwhJ5gP4WxsZvYxom3uqzGg8CDq7sIDsATtYai3SB5dfz7BniMkshIWOrUYFvUPgmxpnmRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfRVTunU; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfRVTunU"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a003bd18e5so3597615e9.0
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791037791; x=1791642591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Nh4xYcLHpPWPglzT1Rb9TR1ScNizAo9fpmTf/BkSqU=;
        b=DfRVTunU9jbFEsqPT9kqur/9LUCxYqIC+cipGl1i2VS8mMiqkJSoQUrdrA4NYvYU1F
         i5yqhKQBaDUnT6qZmuLwxlfrps9z2NNB/Hdl41KPPHWvE2HNvKAW15itrkWMckQtckOg
         ESuy/bZmn9SSge4YdhSFTpilIczq21qJSYMN0VhVdO4sLjx7112gOGUWV1GoyRItZqfn
         FUZnvi9uX5E50UP1/cIXtLqwIxIE5Hs7mGkwjA4UptForWelIRe9wGNegybDXpI6ls+6
         mhgSiNy1FbIthXXp48buPfw1UoEYPlTCsu3OKx9lf2IqqNUN0GYbMXqRQO+TyS7arerY
         6Kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791037791; x=1791642591;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Nh4xYcLHpPWPglzT1Rb9TR1ScNizAo9fpmTf/BkSqU=;
        b=IoU56VQk7tbGQeDf0FMY6VjBrRyZSHV8MztqgZdGnsswZ2kwqhRVbSbXW7zYTIPyKW
         EDkbYsWglDlpc4RWj1ATZt1bsGfOcgivlHBsXjnuE+r3pEYscCfwAHI0N5j8RAm/CVXN
         D67SdPyUg59oGbOvBzhLCmtmAdsHORlrYxGwHDf0NAteasHGUf2Kzmp7PG+ah9FIhZSu
         piziV87CPiIrheM9Pu0Y3mNTojhi1KZVIVT8RWSGmF8URCRdYGgRgM+ig3p7s3h3Nwh3
         pqr2o+1rr5IlR5B3s1JU9l7+GhNSPVUbc33Xa+xb9v99dT89ijofqZdafUS//ieFXalb
         FKxg==
X-Forwarded-Encrypted: i=1; AKwUvBz+aYbUJKUwiGV4w7AQUIL1jlzpWWCG5hnX4DkDIm6SASJKtz2uQSdkDjdc2B7kEUxNHttQdAI=@vger.kernel.org
X-Gm-Message-State: AFuF++lXXAOvBCU7uSzU2JqN2w3NEI7UNRzOSXpH8Gax/mUMGySv4bHm
	7XJ4OEh0+Uclxlulen9peN+5Pk1EZ2UG4I2x4CQ7+zQKZNtgO1ue2Biv
X-Gm-Gg: AYBFou1xs9oU9+IlEKxUmT7ImMDp2PK8XnX1BXJAgSTvkYPFNZg9zmhWSI/c03XpNvq
	Z5l0md+KflFG6bkefQVTq+8TVMWL1OutfqAA9M0VHfQq40fKg1pPiLSL0UScYkjcL+nBUKnOohx
	sQw9drZWrcAXkgMnE9v7DC8W2mVlhPHGYtUBPOhrxzzKM6xqEMLQbqGuXrdVKlwp8o8uYM8bjNj
	8gZTqexcfLAvv+NvT/j+KiG6HYRUnT9zEa+Nvm+BYIGiaE4Ed846+mf9z/JJSkyDk8fGmWMcbj6
	622NgtVdpefVcQWtrVCEhsxYASz7V4elDWpKTuVdLWS8GlVZO7HTQj52hbbHNYcplCtUryZ0Yr4
	jcmtpRpa9fizZGWsxdDsAll/D1yvsMzRVdxByYyJHkyG5Yo5ao4I2BlAG8VTU0gdKHa5bxCOtfn
	x0vqGZ56iXOs4l96oNJPVSc4j5BnIQtJR4CnnRu+ljYDnJumg4MS+/1c7wMKgcCvQoXELxytsJR
	j8lLuZcZ3dQWnBys6na14ZRkoIIlnaWSVPCTzjn5T1c+0sOl0UbtbJx9UqXO712Fwqxgtd/yYC3
	/qIGO57TWksCoh7oM7hkeFljM0Llnmk5staVoKWD4IC+IRHFiw/kAmCo2e3/iAJfHdjlZ2NYc8Q
	=
X-Received: by 2002:a05:600c:c162:b0:4a0:1b77:db0 with SMTP id 5b1f17b1804b1-4a0276b86b5mr102814875e9.35.1791037791041;
        Sat, 03 Oct 2026 07:29:51 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a030326132sm146494905e9.0.2026.10.03.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 07:29:50 -0700 (PDT)
Date: Sat, 3 Oct 2026 16:29:48 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Keerthy <j-keerthy@ti.com>, 
	Kevin Hao <haokexin@gmail.com>, Alexander Sverdlin <alex@sverdlin.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: cpsw: fix failed-probe cleanup
Message-ID: <asEQ9o6etFua8Hof@gmail.com>
References: <cover.1791035789.git.kmehltretter@gmail.com>
 <179103680648.1402591.2581152276872666183@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179103680648.1402591.2581152276872666183@kernel.org>

On Sat, Oct 03, 2026 at 02:13:26PM +0100, netdev-bot+sinfo@kernel.org wrote:
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.

The rx_mode_work lifetime issue was found during an LLM-assisted review
of the 6.12.112-rc1 stable series.

Reviewing the same probe error path in dual-EMAC mode then exposed the
older secondary-netdev cleanup bug.

Thanks,
Karl
