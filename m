Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795238804;
	b=ovKrkzl+OJ1GtECmOPljgApUcHNewIS1jODlYgFhMDAjp/SdnGA1I8wMRXz/6YZOpnN3
	 2IUsdqdND4yRMKgCSgGDHryj/E4L+jW59fGdsGaiOXnMuAL66TqE5M8IooAVLhKAOo7+b
	 x6BA7v+L6eUQUJdN8dFvMNtCqrG0b6Mc7d5BKOVNpQ2An0Zk3zKgr731XQZOS4Ff1+rjB
	 ug64ycheRTC/Wm4wnrPXJ/e73rOQfWEbDOtVmFJKU0iV9KwY/Wwx3zsFK/Y1jAS7SjmjX
	 +oW5rxyeEp5gO9FV0/z6iR7lL5vs1LzxUmMnDxKIhKybcMYYxLQCewwczrwI3S/+yJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795238804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2mKaz/dqifKa6tvgIjKTsGu3wdsWa8OrLCV4/chX4LQ=;
	b=aPjjCUmvCEO2fHwb0BxuQvEBuih+Yak4UCyWRqqGfBhv4d5YeoWgfIO6GmoaSSJEeYdn
	 bgD9xrTrxfgJKR9JppqqFgTQPKrlvzGYvHTcmI+SGJn08Z8xA858gVbC/aBnAttYQFOdx
	 OQ1HlcDxSQuhkBUMCa173Cdh7NjIxmdN0ikQxbAT4Kyjnv3INPgzlLSkWkyWBC6znZ3TO
	 xzf8EyKOFdpwTGSIKgBKojibcuu0vWlN9Sh05yZoKwl4Vv75bLJ+EoFLTgLI8+DkLKNnL
	 DacK6dtSCfLLVxh36huQq5OLKBgm1Fo4r3bZGuyxlLMvNzymMs6+rv15e+1YFpL75Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OMjvtjYt;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389FA606A69C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 05:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 389FA606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OMjvtjYt
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso696325a12.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795238803; x=1795843603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2mKaz/dqifKa6tvgIjKTsGu3wdsWa8OrLCV4/chX4LQ=;
        b=OMjvtjYtuz/ck4cShSktGQWWBs+3kGP9qYEgUF7wDld3Qlmz1nB/udxsLsVhvf4yku
         tagAPNPBBMmGf6HpALhJATxoXyF7m56tSmsO/1BZx7j+c4VfFV3PMF2qARoVGL4gInzl
         WNLZOoAI5z98uwxlfrwSZFnjxujJ/SVpCepL2q31TpbpqOUFoFzZv/gpy71IdsuVJLWn
         a+K9NI+YH1uKUKZgjetD+Dmmo7zFUM1hosU7hAXftGbU6okW8uLQuQD2nFyt2GTYynpJ
         +JXzRyaPM7mQDk7mMteEOF0bNl34jcxAZwrmnC7TxbgWwbso3NGVH4HmV1CUZsbQ9xkS
         79FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795238803; x=1795843603;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2mKaz/dqifKa6tvgIjKTsGu3wdsWa8OrLCV4/chX4LQ=;
        b=d7Xy2ovjDSQZxBQ/YKKS4L571Z9GETfA6cyTA+elXndeTMhkF1IBwvd8fiKca3ii86
         OOFSsqbfFFUBAzWczWvaHp3eVkouktKmr7zPTEa6u6TcAB9SL98YhDeiPzzFkBIWRunh
         SthnmGs79HtI+7+1yE9JLzKL1yYyxO/xTMakBtNHHVM5xGpeKotFjX1kKBxUvQA3V4kg
         Le7T3OZ6v2fVovbdAD9titk9XC/z5Jw5z5Mf536ztEmnDjz9I1N+xuEp2B0VSafG8mjn
         I0PNpRO2TFzWks8ejsV1ukTfSyHrrqmx8EBTV4UXMcuKcdjUlPcgv4h2S4W0pL3OJVCI
         nZsw==
X-Forwarded-Encrypted: i=1; AL+hErGuDLtNBQMuA3jwaMatO61BjXhxVMVmvTNBlCtocT+IUDWJ4HQpGX2xZbWn+VKwjl4s9CaW7f0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CylqZp2XxN7XbuP+9bcV4J/Uw68Ftx6PAqXNvsegudKQNIr7g
	iwRL4a8mF6TRTOA3FHDzwqx1Ld8SKYirePB5qzxH+5zR3nuDKrh4RXiH
X-Gm-Gg: AZFdTZdcUj8kyFYcog0FNKg0QK+NIh0IgKL1tGQU3k9qXL8K7L3RsLT5txKWczeWHOb
	otNQhpfXmt+0tQYkfD+n/0h8K9wqxh0c7htDRm7HPc4Hjp2eibuoXCO+suWEFXNqv8EBxqnaszW
	b1Nv2YJ5qp3GCuDIpYtyeE4I7bwLIIKxWd9flOpH/YHTHdvFegPSOmo9kanoNoWB9yp3QuZ5d5q
	z7HYLWamCs01glqSTKAUNu53P5oQQpIA5Ec01MNDh7BOTJK/t1Ac9dDPmTmlsPdNPkrHomJuQ9c
	ulBBdxepAcnLsJ61euAcbT2SWm/GHyRBMsJd3Z1ZR6FDL8XK1gYyT0vA9iTv554VY6Uss/nrK7U
	tx8PIzC5Ntwlb//cKiHM36zZkBcnEzKod+4sEX2sxZPEtSy+DREdZeK5pfMCPjSShTgQoPncbYn
	ueYGzUhMDd4tMpN6gSpoi08I5S0f6TS2A2ThSj83VjmGqez+YY9CqSgtncU/EWwUduOGl/o1o3q
	NBezG+JwNH5bcVoHUg7s0vMmb5T3I9OZLY3B6GXrPU3SpRYK/r/eyPT7aFTtl/tAHFt7tXcmTd2
	D5XFkr7wBE0e/MuqG07x1n4Cw3LE8Rd5ltrfr2RYLy0BA1GU
X-Received: by 2002:a17:90b:3890:b0:3aa:548f:eb77 with SMTP id 98e67ed59e1d1-3b41c97deecmr5244247a91.56.1795238803409;
        Fri, 20 Nov 2026 21:26:43 -0800 (PST)
Received: from rigel (106-68-220-184.tpgi.com.au. [106.68.220.184])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7c6513sm1223708a91.4.2026.11.20.21.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 21:26:42 -0800 (PST)
Date: Sat, 21 Nov 2026 13:26:35 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 7/8] gpiolib: let the character device free its IRQs
 first on chip removal
Message-ID: <20261121052635.GA32792@rigel>
References: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
 <20261120-gpiolib-chip-removal-v7-7-aambrozewicz@nvidia.com>
 <20261121044657.GA17013@rigel>
 <20261121051900.4118973-2-aambrozewicz@nvidia.com>
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
In-Reply-To: <20261121051900.4118973-2-aambrozewicz@nvidia.com>

On Sat, Nov 21, 2026 at 07:19:01AM +0200, Adrian Ambrozewicz wrote:
> On Sat, Nov 21, 2026 at 12:46:57PM +0800, Kent Gibson wrote:
> > > @@ -1690,7 +1697,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
> > >  			return -ENOMEM;
> > >  	}
> > >  
> > > -	mutex_init(&lr->config_mutex);
> >
> > What is the rationale for relocating the mutex_init()?
> > Looks like a gratuitous change, and if this patch is going to be
> > backported then it should be kept minimal.
> 
> It is needed: linereq_free() now takes config_mutex, and __free() also
> calls it when linereq_create() fails after allocating lr. The first such
> failure, kstrndup(), returned before the old mutex_init(), so it would
> have locked an uninitialised mutex. I plan to say so in the commit
> message in v8.
> 

Ahh, I overlooked the __free().  That makes sense then.

Cheers,
Kent.

> > The lines removed/guarded were added in patch 3, so note that this patch is
> > dependent on patch 3 in the description[1].
> [...]
> > The line removed/guarded was added in patch 5, so note that this patch is
> > dependent on patch 5 in the description[1].
> 
> Agreed, I plan to note both dependencies in the v8 description.
> 
> Thanks for the review.
> 
> Adrian
