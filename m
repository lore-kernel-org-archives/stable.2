Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200750;
	b=KKGO2cjd+ZLMe6o+KZmetqNZZOxC3PzN8sPdOze0rcZJB2i397TRiL15gNwnqfZmOiEW
	 xzsaTB+cjrTlQHgXT1LN1WFkLUaG6ReYirKVknsG7vBkXnHenL6t4+DD8RWu5TjgirXhx
	 nG5yYWdnpl80LZG64kBasHnVUFXCdHqO+JaZt5F+tJBbiLaJwC1tIZQtfLENtwkxXgJ4h
	 576BepjCbiiAvoJspEzOIGv95OxPkBlr7IWBwces58t0nvDiHSVFrr1s/Njz01baV8SAM
	 +R4H5XzfMSrstRr0qKUKHI3MV9LrI8Oyse/6jpQIx9rHFCVYAa/0Bx/Z88R4PKkM8Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Bx7hw4DAGiNHt8n2+ovyeWcleIZQ4+n68Zz3MpzhkSo=;
	b=k72s6McPL9epf2+lF2LA6b0xsqpKdiUHppD4qcFisP9lpEqoNfT7KIcXQy7bYuMWpjL9
	 xTioUDPE78++E1Pt2E6mJSTkLaWQHGW+HWxcUhwrk1A3gskWNgWWRbrrK9Uav2I6qblCw
	 lVhy3HKfNoQvHQu+bHM797HId3HVYNCW2r0JxyDhUb5sjAUKrJpYT+pkrwRLJinzb7Ky2
	 SkKlXAdFdv8F3RCTLI2usMMW1NZsv5xy2aRdgOSiluarfkpkib11nLbxGPpcFO75TRt+C
	 T9zXx4NGdK/U4/Qr+hpbo+6dIJKXSgg+58iwIeyfTCjJgt8QHB5Q1SNdnaIEBfM9xNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=nhK8cGaG;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797DE606A320
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 797DE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=nhK8cGaG
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ac4806e210so9517077b3.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1793200748; x=1793805548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bx7hw4DAGiNHt8n2+ovyeWcleIZQ4+n68Zz3MpzhkSo=;
        b=nhK8cGaGFswEzQzn6jxV8d7rWrcdufVj9AiZWeEMEA/Wupaev46NciUKgGJUUt3ByL
         uao2VGURsbYEidWyayLH3DVOhUbQRhSYSuzIu28/fAoxmcIG0WedVAvdu5647p5yknP8
         kWlj+kneMmtUzA/yOYN4x6liHGLFt1vXF82qlxKhaZtv3f+2egWqfsBb2ENt6uJ2RXAK
         NM3tLDc6FE8jxJ7UEeKozD6X9whokC1ta0k/a68oKBzaoD7h1PjK5rMScjVHyC+rtG+2
         yJm2ktJusv8LTxfcvqDJq5ure6P22NbWO1Uf2DYmUx2A/mXHzlRtHpSXAc+UmBBZ4N7H
         mldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793200748; x=1793805548;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bx7hw4DAGiNHt8n2+ovyeWcleIZQ4+n68Zz3MpzhkSo=;
        b=2czfDjlozif6oOwQ5BAlqahE/J7Mr+Ipf3EyJdd0fgicxAWUuNidGSXxJKxljKDAJN
         B9n4RCWCLO7m0IjhSfejkcnwlqIHJDVlI9+Ipa/4Z2fp+FE6zVMTM1y+2/nE1deNIprH
         nTU0A95kE9MT0nJYpDPK6Mx7cvlwJRdjPPqIIgDi8upKuCdSxmexi6BPgPSRAbKIHDAk
         w0LLaBxXD+aN8Q5NJuY2/tclDZRZhUDJtupSF9Gwm9RNqfJpSVZcufeZ05tDTtGPTnxV
         G0VYZGUct0etZlPoYSXievj4k9dpPkwkaTYDAG68CD8WbRNZgwPBYsdMNGTfgjShxoPN
         VZKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjbZz++NeqqBUJJUBE5iDOGXnBlshg+Nj/wJKiVn//rWgAVJsIkm9up6r4Isy6mLxUDHamANM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIy+CWUON755iqyWaxD+uxpVbO5LISeZt5XPAPojQX0Lpj4WyHl
	n5hUOYwPjv76hyzLKGSwHb+ifPHqw6WeCJjFFZdxCav9akq2WJjGxm0PpOvEF3rnoRk=
X-Gm-Gg: AYBFou0nE3kkE6n2DL1/nLSK8tryyz4p7djUex6WYMT3bnHLfAb1yHOzXuFwhh7GAzC
	biHJj9GZakeUUA85DOzaE9x8/MO3eDEJu+/XsevEmyomkWNh53LbjRaMYzh0pDAussbIQFOnQL9
	BDHCGjUxP4Wr3nobaHyds/T2YsTyM6dJZXMtiF/TD5Ha0vKdONCL/M1ZsugnFSaYV0ANcs0ob6k
	CJAyLYOiQSoj6DGo8Ono7Ig5wGKTQFCeKpXdn4Uw03LqUFQP1YdyCUd60TQGakvBTtOf8otaw/O
	/PGtD0p82yQX6xK25O8yvuMkxtsaRph3pWFqnNZSArcyyYhD3sAkpIvQl8xJXj8tzA34O3eiLT5
	Kf8p7GI2e4Ysr+79xpov1XHP20wraFpmA+2DTly8TWFqJrsWmjNhKMJCZF1YqdRLNhIa+DZyrUm
	4gegjm69X58s4oaqnbgU3whbbBlbmO83xKLrPe6qPW39jgfuwSsDi6pGEN3PGMX5V0LclqqlO2W
	2C0OeE+wTxnVnkddJ/44YKSQYYPe8lEqmvMo9y2Iux5VYF4CYV9DZJ4QQaKQ2eQLDOtejQW1wd5
	Dg4gfsmggW0ZSeP6Udm0ABLsTiMb
X-Received: by 2002:a05:690e:438e:b0:671:4cca:b8ce with SMTP id 956f58d0204a3-67a7bcdc2f1mr1541191d50.61.1793200748154;
        Wed, 28 Oct 2026 08:19:08 -0700 (PDT)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a19ac69sm1870050d50.21.2026.10.28.08.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:19:07 -0700 (PDT)
Date: Wed, 28 Oct 2026 11:19:03 -0400
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
Message-ID: <auISZ5w318zwUZuc@cmpxchg.org>
References: <arFBr22V60BMmVpl@cmpxchg.org>
 <20261027150002.318916-1-dipiets@amazon.it>
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
In-Reply-To: <20261027150002.318916-1-dipiets@amazon.it>

On Tue, Oct 27, 2026 at 03:00:02PM +0000, Salvatore Dipietro wrote:
> 
> Hi Johannes,
> 
> Vlastimil asked that v6 of my page_alloc patch [1] not go to mainline
> before these two patches land, so Andrew parked v6 at the tail of
> mm-unstable and dropped its Cc: stable until then.
> 
> Are you still planning to work on 1/2 and 2/2, and if so, do you have
> a rough ETA? Or would you rather post them as a separate series as
> they are? If anything is needed on my side to move them forward, I'm
> happy to help.
> 
> For what it's worth, I ran both stacked under v6 on v7.3-rc1 and saw
> no performance difference on my benchmark with or without them.
> 
> [1] https://lore.kernel.org/linux-mm/20261001082152.2879289-1-dipiets@amazon.it/

I'll work on this today, will have patches before EOD. Sorry for
dropping this.
