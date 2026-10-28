Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208087;
	b=WP3wuG86nzi4Ht8Xk8FOY+EhqjEbPY8iEeN3YjRtCQOEBcYMTKhKqOSVrQdfr/xKnTUp
	 b+EAai1ULZMilpG4+Tva3G7a34se/jvNZA16v/yhoiG76TJ0jTLofLOmu+W2bBgxjQHhn
	 spVmgSaHqREQiAGs6Zdj+Y+oamk3CRxa4w6Cf+rvqt7S1UdbFcT4levL8KCGuhuLoKlfa
	 FrbxQzNmRiTmt8TUSoe7zpwAa8DgWaIpmm7FpIDgM8487EhPBmrn4fa9zdMyLbQMjIpmX
	 WSSx6GY47IsN3ATROcFOMwZIKdxb5KtPdUgzaTmbWyrt/R2VyldjyUzzEDsn53qddzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gKWv/vfGN+v0zoryVVsOrqbU4hq0g1uoOUtfYF5rLd4=;
	b=CJqg5tjr6B/rpFosYdyNtXlDvj7OBJNitpAg/lXTgnD4Sri8biNAdBBkZmKoeDkr8Uhv
	 pw0jtCqHY/DNXJ+qb7/OuiLDQ2RdOL/msr5h80F+BcUmqr31C2UJzXpjEdogFzmrU+uza
	 XusNBRT87mrzJ2cwwjeO2+KL99DYEacInGNoBZ/rXlyDdu8Jwa3eg7Zh6uLcpW1vNUxZd
	 O65nCHZU+DUnmNkT0bUzeeG+ZM55c75lkhD/b6XKxJS3G1AwZ89UEIAWRfEB9Vk8oQm8i
	 1YTzYouPvKQEP7BxHjvqiUouLyEBW83GrY2W/hHk/xd23mQX9o4HSsYK3ZeRN6gLVTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=SQlFBLtW;
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215DA606A31F
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 215DA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=SQlFBLtW
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6774639a8a4so1186404d50.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1793208086; x=1793812886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gKWv/vfGN+v0zoryVVsOrqbU4hq0g1uoOUtfYF5rLd4=;
        b=SQlFBLtWetvrAOGwtD51xhjKHJMBmuVVhKXJUHggsefbsTBeA9lSUtBHLEvFQVQpwk
         5rxgza6m/fEullx3LCe/5EOf9NitilOHi/ZmD+JZoZrLhue8TEStDNUqIv6MnHIQn4BL
         ASJwtOkabzww4BdFogItYgHjFyEYahE+mlqAedNSjHJcjtmSyL93pQIFRzgVKyVw/q9Q
         81abU0Nq7hvVg258F3rlDeN1MY2edyUC5XbswXKuXMO7fBepqm0oxBuoEywcY0tTHB7W
         viLo1aeiP6zlrKoB9h1bFeSUMb6NEqE315HFQ0S5k0SQT/BxI3ijsPyYAnSyXqISjRVX
         A9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208086; x=1793812886;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKWv/vfGN+v0zoryVVsOrqbU4hq0g1uoOUtfYF5rLd4=;
        b=QJHANSP8NrmQ5I/mhpHL+tJgoYfoOBsB9Y9p+4LmyRZuq6MKw5M6dJcIOYXm9bkEjO
         omk7uL4JX+yqNm2PIsOLx0EArSz07gVrH6oPlKbO0dCy0Fb3PvnwzXhRnKJcpmFAXWJ6
         uMnPh3GKKwk7fsvqNS71+yi+oONba4R2KMSJzFKRhUf1y7TxEfcFRCajjun5BKG22aad
         9IpvP2z/E2lmqosgNdjZ7bK53zLARRXF//d2NPygvad59bKwsV9yjmOFiskEqngdTPqG
         tKLLihnp4rR/QnMjIvGrqtwGIyPKmqAUcWrQBkqOT4/MNH/pLd0OerJkKD82/9IfCdc9
         3DiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPSK0TaY1AuPYhb3bWCqlLyg6megNq0WcxrbOfaPrp3DNacPyJ2XyGC4dtFG9NX4ojtxY6epU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIz6KAxtANjyFpQ8XIoxCz5Lq8/hYKCVDab4+LL6jT3xsloU+V4
	EZXsU7UaYMs0JL3vaT/uYzS/kilb8M8j7xHeAzt2Uyuqlf9elAbKTOJYF9M5fgu4tjU=
X-Gm-Gg: AYBFou1MrwxaXXW+BIO0VFtUpS+Beq6EE1BVbUbgPMRg35Sl+Eah9DpyZI+TKPbZXSl
	D79WkOejab4z97Q1UzDX4vEapIeI9IhkDRWifOEdMB9wjtFC7Gft7TktMGzcMuXkl47beCOsGT0
	Uxf7OnCE5/uYyD/UAYxt6MEZQXg/nM50uCwCGB4cwiZfrQZyNDqoKCaDJip8piJqedDsnTXBzPY
	JwIObSqDCub+YMo2zYP999htE40q9VwhrN0H8d0vHx45ddph+niVSc6wIjfixOzRkLI3lF2sQH4
	6U23m4JiO3Hy03YtTgnm+Lj1nIZzuXxrdeSSIn1Ymc70ws33OfY6V4BtSGwOhPHHiRoOYOwuP3v
	GGefqxJ/MWieCWJyXnwLObsqKio7CvoUGpii4/LQ2VNjasaf3Z3JrjVgWSaCqaTumaq1y9DxXEA
	jAH0TGfd8kJsga/glps7V5e8Oa5nEeW7mdmPS+Ku35vJqoLBcEXn0fzFAGGsWk4sgxWhNWju8au
	W2CsWzlFTTzp8bWSlgh+0YKaI9LPjKSyS/W1rcv5RSNxXpdm6gOg0eSf9/qsXYRcYJthi3Ta+s0
	OlvcqL2MPPiT+8D3toMep/xjAv/+
X-Received: by 2002:a05:690e:1183:b0:678:fa71:301c with SMTP id 956f58d0204a3-67a7b992b9amr1910178d50.7.1793208085931;
        Wed, 28 Oct 2026 10:21:25 -0700 (PDT)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a0c31cfsm2144554d50.9.2026.10.28.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:21:25 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:21:24 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: abuehaze@amazon.com, akpm@linux-foundation.org, alisaidi@amazon.com,
	blakgeof@amazon.com, brauner@kernel.org, brendan.jackman@linux.dev,
	david@redhat.com, dgc@kernel.org, dipietro.salvatore@gmail.com,
	djwong@kernel.org, hch@infradead.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org,
	matt@readmodwrite.com, mhocko@suse.com, ritesh.list@gmail.com,
	rvvandan@amazon.com, stable@vger.kernel.org, surenb@google.com,
	vbabka@kernel.org, willy@infradead.org, ziy@nvidia.com
Subject: Re: [PATCH 1/2] mm: page_alloc: do not give all non-blocking
 requests reserve access
Message-ID: <auIvFBlNU5N_PVyd@cmpxchg.org>
References: <arFBr22V60BMmVpl@cmpxchg.org>
 <20261027150002.318916-1-dipiets@amazon.it>
 <auISZ5w318zwUZuc@cmpxchg.org>
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
In-Reply-To: <auISZ5w318zwUZuc@cmpxchg.org>

On Wed, Oct 28, 2026 at 11:19:08AM -0400, Johannes Weiner wrote:
> On Tue, Oct 27, 2026 at 03:00:02PM +0000, Salvatore Dipietro wrote:
> > 
> > Hi Johannes,
> > 
> > Vlastimil asked that v6 of my page_alloc patch [1] not go to mainline
> > before these two patches land, so Andrew parked v6 at the tail of
> > mm-unstable and dropped its Cc: stable until then.
> > 
> > Are you still planning to work on 1/2 and 2/2, and if so, do you have
> > a rough ETA? Or would you rather post them as a separate series as
> > they are? If anything is needed on my side to move them forward, I'm
> > happy to help.
> > 
> > For what it's worth, I ran both stacked under v6 on v7.3-rc1 and saw
> > no performance difference on my benchmark with or without them.
> > 
> > [1] https://lore.kernel.org/linux-mm/20261001082152.2879289-1-dipiets@amazon.it/
> 
> I'll work on this today, will have patches before EOD. Sorry for
> dropping this.

https://lore.kernel.org/all/20261028171719.2043421-1-hannes@cmpxchg.org/
