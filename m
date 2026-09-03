Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6BA499F08
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463037; cv=none; b=gnXEH2H+C1GpcYoYS+e7tf2K2rPmqZB95ZBk1sqQILuCHF1TvFeDdBtagJjis5/G1DVYMjNFD96FMIG+FoQaaZJDVcFRhMunsKK/LtGRpGQLKM/SVPMVJsq59zY+1f2Njd4lwhDzsKOU8SR3z+tdhlaxPmA9c981kDzhSyj8iBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463037; c=relaxed/simple;
	bh=44N1xPv98QJXFEr0fJ04R4g+ctX2PmuRF5M9Tn5FVCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLXJQGzN5RX9pfDsvnuhmJH4/FFq22CDAO1UGvxX+zCfd8MmJ5ZBd15U94s80vKVzdjkxCCFs6eC7pWP09NOZeS2OEpja7DofI0Im5oSwYJDZFVFWVsNxiCC3ZgedNr5tw4nGETetDxDfTMAvLtieeMa9RBF8UJ0fguIqf5oIKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChS/OEt6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChS/OEt6"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6efd73032so12309285ad.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788463025; x=1789067825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=znvjDv9tdm5LByLeJAxSVDbi04XmkGblSgbOPl30sYg=;
        b=ChS/OEt6qzydSoJvhbTCSLP7IHh2VC251ROs/lSC6vjlAc5KjCu9xeGNsJ2jfwX7SN
         C9RUwo16aJvMA+ivadSNHqHtINuuBT6dUxezrCyaUgqEtNt63KO+qEsfyV3YTglUmL6n
         xUdEPDrW2LTZBSGQfdiFYwRqCxge6LQ3TLoHALVWWUNZGM0jrHGliM0CLTyEFcE1GODd
         gPkxZ7fFNBJ/28I3k6HfhcYp44ykpgKaJC6NT4SosW307YCyYu/1EOResSX7PYb0MmYJ
         0wFL7Fc/CLVOCWrvwiKj8m9KqeC/TlFh6HzjYzD+1jOmkSy/tK6/SOaamZbK/ul9s1wh
         f68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788463025; x=1789067825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=znvjDv9tdm5LByLeJAxSVDbi04XmkGblSgbOPl30sYg=;
        b=PEQqdWGKG0BCPfpAxUmH4W/skvD0gNd3Hh62thrwwy69TZOHrU1fLac7DznJ3ktCUk
         TYLjvirwUG7wBCgihsub0VElxz2gy049DnElkJo4FsGLmK+n4NYKy4mgWyK4iGiLf/BZ
         hSUNl7VEcS2hb7ClavmgXz8UYXF78cxo1SPafABbw05A6TcfkGmI5i5lXVxtDKU41q54
         uVrzPS5G8yJGjpCWCqRVronxK34xWVI5ALsP3LZIwGmC+Exzmwo7qizT/NCVo5/sYF3V
         KE4tuWvzDb2/y85iZQdDFHMWwlo5x16ewreF5ODNCUz6izw2zhIwJaPzVDc2THy27fKG
         5t+A==
X-Forwarded-Encrypted: i=1; AKwUvBzSmUf0UqUSDXCQdXSJPEiISONsmRUgUTOf/ssY+pBvhHmeGF8Yw5eMiB+0FZrJmJrTVSrjj5k=@vger.kernel.org
X-Gm-Message-State: AFuF++kJvr2ABQSz4QkCrh8YJexp6IlAiS+EGsbNF5SrqypsaZdvEoOB
	ckfZFJlh5aDsmP3QgmTSFsjrUr2QhqrnuOkxYlUvJ9cCA3PAX2wwq3HV
X-Gm-Gg: AYBFou2ZBSmZ/D2+LMIum3FLPhLlm5EolVf0zPrdXvoy+OL6YXzxUGy39rOQuJ1HEVQ
	0NHlhP53c0bC2YTgEnliF0UsXOUe18DF0KXCuOa7nkROAisBAXUHBBUQc0p4kTsBNgga1GiyF4h
	lYcOPm8tQOJG3G0r0aR5Zb1Db0fuAabM5LD8mQpFN/G5xwsCDIU5PUOxiOYifs3ddkAcGY61/91
	mdBjPeSstMNkFTkwziaLcobXen1xqIfPPSsCXzI6H4Cs14Rb7Owyxewey8sIwzjV4GfKtSpvsef
	SzoWak5UP4Eufkf21eRIFvQ0kqsQzPqey2kElXrB0UNigx4ao6c5EiYew2stnfJSkknmsg6nD9Y
	I+41DY7x2SOXgi5YBaBy8lm4+PxMYmkH9A1WIIuJ6ABck8zGVD+TrqML/wDuRyb2l6ChGSREpL0
	b+1HhFLqBZRFw+wpLZ2Z9N8+gjHrANkTIJfZgSsxo9Frlc+f2sNLvBZ4dUFIBrzGx/gmTcajWAc
	6IBmwDraOoyHuoiwng=
X-Received: by 2002:a17:902:b217:b0:2ce:b3cd:7539 with SMTP id d9443c01a7336-2db159b5996mr491625ad.6.1788463025067;
        Thu, 03 Sep 2026 12:17:05 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1497fbf8sm335185ad.43.2026.09.03.12.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:17:04 -0700 (PDT)
Date: Fri, 4 Sep 2026 04:16:58 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, ncardwell@google.com, dsahern@kernel.org,
	idosch@nvidia.com, kuniyu@google.com, horms@kernel.org,
	willemb@google.com, andrew+netdev@lunn.ch, kees@kernel.org,
	jiayuan.chen@linux.dev, kerneljasonxing@gmail.com, ij@kernel.org,
	martin.lau@kernel.org, shakeel.butt@linux.dev, matttbe@kernel.org,
	martineau@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net v2 6/8] tcp: fix use-after-free in the lockless
 listener path
Message-ID: <apnHqmYZQ4yzOP4N@v4bel>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
 <20260824033331.1084971-7-imv4bel@gmail.com>
 <apaAskNL-IvdcR7h@v4bel>
 <e121d343-9a4a-4f93-86c1-c96dd37f1ae1@redhat.com>
 <20260901085102.5c58a5b0@kernel.org>
 <CANn89i+px52TtJy3S9=uHxGj3s-WueguRo1Z_4FxO=02KLmwmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+px52TtJy3S9=uHxGj3s-WueguRo1Z_4FxO=02KLmwmQ@mail.gmail.com>

On Tue, Sep 01, 2026 at 05:57:04PM +0200, Eric Dumazet wrote:
> On Tue, Sep 1, 2026 at 5:51 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Tue, 1 Sep 2026 10:03:51 +0200 Paolo Abeni wrote:
> > > > Looking at this further, unhashing the listener and then calling
> > > > synchronize_net() lets the disconnect path handle it. MPTCP needs a fix
> > > > too, though, because it closes and reuses the first subflow directly
> > > > without going through tcp_disconnect().
> > >
> > > This looks like a more palatable approach: this patch in the current
> > > format looked way too invasive to me.
> >
> > I likely lack context on this, but I was wondering whether we should
> > potentially disallow the transitions between listening and data sockets
> > instead of fixing these endless bugs?
> 
> +2 I think I mentioned this at some point.
> 
> Same for IPV6_ADDRFORM : we should not allow transformed socket to
> even use tcp_disconnect().

So.. do you have a plan for this work?

Or should I send the v3 series first? I am still looking into related
problems, and it looks like this series covers most of the "important"
ones that have to be handled right away. What is left seems to be the
UDP side and other minor problems.


Best regards,
Hyuwnoo Kim
