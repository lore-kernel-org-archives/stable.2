Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217B3F9A05
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463920; cv=none; b=RHhwgkLwJiGRQWEfESJlHmlruH+d7ExFP8OZkBd94NnirVXVuY5N2H19A3kCGyjO9O3OPJDxEe7t0XXxWZxd1gWyZ4BHklAxdBuyAhomPewxowv0mY/BalaF2mSpRYRidbN1g8MQA3wRkEvnMSNmt9jk3764WDUTCAuvfBUeFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463920; c=relaxed/simple;
	bh=C2Xbm9+vzgljPIndJIOSD3k72as3GmPv88a9h7S6LMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5r5DGxFtRsgwKsxptfJhtIMyhYL6Rs2JOocHQt1O2U+FtX+GQMOMCmpEheAsXah7qmr7YbOU47MibaUTQtebEhcQkOXAE78a22ozH2sUpzATMuz+15+DByEolHDm2Lq2Wcisi7+RzhUEhxcu5hcIMeT1Tp18hu9zeMyqcjNP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahpAz3gW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahpAz3gW"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d71a50caa9so3116585ad.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788463907; x=1789068707; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GQSkipTqdF0eZVVJZB/2cKUlfMOe+A+ZO44Cnwhe5No=;
        b=ahpAz3gWj1x2gH2wEpEQn8wPnvenPZmx5felEXQ7mIm9LnkzzmilSlUC2Y8CL+P4g8
         mVCZRKRzrEtogXQgYR/oUP34tegjGjiRAk3wMC9JpXkhTw5IBiEiLWv6f8uYAQkL1SY+
         +ZUHC8/U6Fy9fOOQXb8bB0gZ7TWRdOScASSA5rvrdC13ePXkmMPHWrd0E25OJGs8guDK
         BSUfoXhu1Zmy5YKyOxZ/ya7rBImtqYILO+rr/uBjzWPdGZI1lUYfDAGGlqo0Xx08wvQv
         SUszXg6yD+T4gE6n36iNtAZrqgwFjqVCW7mFb/y63VWSf+gbNPukIig0/F2oZ6pcmocg
         3tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788463907; x=1789068707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GQSkipTqdF0eZVVJZB/2cKUlfMOe+A+ZO44Cnwhe5No=;
        b=dGsX7qYKPVvTe4JYwa5XeSuzQwKPZitk6WncUbmNOMgUryNQdIUCbOkGcn8amk8fKi
         Z7UFSlG3I9chq2+vMffgZTDdRFeizPemu39p1NIpycSGQ1oYgEw/3xqq/pgNfGS42e+B
         QxpBcYQLIo6GpuRoYApp79R2p/1UkW272ql2V8+Bj/N3yXDUl7C/INWnzS7td/subQK/
         +VgJcd7hegDzNJWaMJx9oSwFQDbPWsIzEP/YXj+VnTdEkSsF2aEV+NM/38HJYAKnFFof
         iRqzJ6GHhU+oUnrqUikuyZrTAtKfassAgafdeUSG54v13RLcC/pBWyf0TwSVJ9F5BDW0
         ZLCg==
X-Forwarded-Encrypted: i=1; AKwUvBwpBWDLvY3PVm6ng9my7WE/1TC9LWy9/o9nqMD4W0GtrT2DgYNN2YTcBFTT+p5kLRIeJmrRrCQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lNST72kjcmJ/em9M2h2dBeqUfbhGCUpZQzrC8t0nLB8RYK+x7n
	zEe1d+Bt5i1yN+sdO5vBMI2e2YXfogm/hPIsnWiYGJc4rh2rCnvHEPZJ
X-Gm-Gg: AYBFou1RgCaFgpZpbW08Wb0ueFs6ulMOMWpFJjnm3mdC6IF3ObRhqk9ubxduhM+NuHg
	ll6Bi+CFUvfTkOL9CXKc5p++7WN9r9P6XXMtd26qQlpNzyk9MnzLX2cieM99gtGpyahmyvDmXnb
	8eex70vr4Hw5zyGvgXFFW5zPe9mgjc4A06w0ayODlK4ec13JGhQ8d4cFV6ZAz1c30AQTvKMF7hP
	PvnNqwKHrDXR7IpiB4pG1ZgXvFIWxnydMP30b8acL1CxVb6C+OLaqf89rd5n2dn/GVabYHw/fda
	iBONdJh8WwHn0I7tL8xEZjXacNZfIADXGKejJ7QGrrC6cYTk8nOL0+QSkm6p24hq2mRUZwVEj3s
	6h66glflzhFsdr0wAMYriFlwjdxXYxcQH755SgaydMujkD4JJZ5cCZUJ6+X5FakufY3G6xMi1BT
	b9ug0i7OmkxURvxoHIcQWTVCu4Ik05ndJOCAkcvVosRYTpARCqfJkG5aqNrNIhjKpyI3RMSFYnf
	YF8Kk7R
X-Received: by 2002:a17:90b:4b90:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-39b2610f2fbmr1013004a91.8.1788463906583;
        Thu, 03 Sep 2026 12:31:46 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd291sm471223a91.6.2026.09.03.12.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:31:46 -0700 (PDT)
Date: Fri, 4 Sep 2026 04:31:40 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	ncardwell@google.com, dsahern@kernel.org, idosch@nvidia.com,
	horms@kernel.org, willemb@google.com, andrew+netdev@lunn.ch,
	kees@kernel.org, jiayuan.chen@linux.dev, kerneljasonxing@gmail.com,
	ij@kernel.org, martin.lau@kernel.org, shakeel.butt@linux.dev,
	matttbe@kernel.org, martineau@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net v2 6/8] tcp: fix use-after-free in the lockless
 listener path
Message-ID: <apnLHKKs8VWnMopj@v4bel>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
 <20260824033331.1084971-7-imv4bel@gmail.com>
 <apaAskNL-IvdcR7h@v4bel>
 <e121d343-9a4a-4f93-86c1-c96dd37f1ae1@redhat.com>
 <20260901085102.5c58a5b0@kernel.org>
 <CANn89i+px52TtJy3S9=uHxGj3s-WueguRo1Z_4FxO=02KLmwmQ@mail.gmail.com>
 <apnHqmYZQ4yzOP4N@v4bel>
 <CAAVpQUAVXFrRuxPCKW_4qqAAdjTpv+arijYODeFMfXshKqajHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUAVXFrRuxPCKW_4qqAAdjTpv+arijYODeFMfXshKqajHw@mail.gmail.com>

On Thu, Sep 03, 2026 at 12:28:15PM -0700, Kuniyuki Iwashima wrote:
> On Thu, Sep 3, 2026 at 12:17 PM Hyunwoo Kim <imv4bel@gmail.com> wrote:
> >
> > On Tue, Sep 01, 2026 at 05:57:04PM +0200, Eric Dumazet wrote:
> > > On Tue, Sep 1, 2026 at 5:51 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Tue, 1 Sep 2026 10:03:51 +0200 Paolo Abeni wrote:
> > > > > > Looking at this further, unhashing the listener and then calling
> > > > > > synchronize_net() lets the disconnect path handle it. MPTCP needs a fix
> > > > > > too, though, because it closes and reuses the first subflow directly
> > > > > > without going through tcp_disconnect().
> > > > >
> > > > > This looks like a more palatable approach: this patch in the current
> > > > > format looked way too invasive to me.
> > > >
> > > > I likely lack context on this, but I was wondering whether we should
> > > > potentially disallow the transitions between listening and data sockets
> > > > instead of fixing these endless bugs?
> > >
> > > +2 I think I mentioned this at some point.
> > >
> > > Same for IPV6_ADDRFORM : we should not allow transformed socket to
> > > even use tcp_disconnect().
> >
> > So.. do you have a plan for this work?
> 
> I'll post a patch to disallow the buggy transformation.
> https://lore.kernel.org/netdev/CAAVpQUAWjBuF1Rgze0Vt_XvkUT=Ajw-F+Kh+s2iHk38c8iAapg@mail.gmail.com/

Understood. I hope my Reported-by: will be included in that patch.
