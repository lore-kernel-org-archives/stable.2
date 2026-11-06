Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976207;
	b=XvEU6bKv5un9L+nAn2I673+h/4HTf8pjK8i4MC7koxn3/AhzOx+U6DqrsPFixWmsIjiA
	 KQ0HwxSLq/jLDfaRHP2i05DbQKds37Xmgy+B6q4AOHNxUyjqWimLVmYQsfRZXTwU+I8bJ
	 7aqDQlgCwPAfazpvfEL3yX1yqDYqtLtWlm0DOx5hcNRq8TQFz5W2f7ke2IeI0jaa/T25e
	 FvBR4f4D0l1JSWpNGpG10OfyylMDvSLMpf46U1KAIaCCG4RcuNJFzeJz8YkrfuMJaVuEO
	 WfG+Cl/48GcGWmM1keDPVW3egbEoeBAacCr0sCNECRcbdoz1/t+APpdfGhkkHXB5AVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1coO61O9o20KGfWhe+U/6TV0ZY/FeV096v+PDZIBmoM=;
	b=RZ2AOFd057I4wCHOo0LUhblcnc8qb9ft+7ahsT4M9FucAP/oeXx9dQzazap1Mc55vx+5
	 WtNonEk5T/htuGa9P4UGaJiQgwtFy8WMtPICWKUcuM9aIA5B3OQbpY9JOgfmLiYZxqpqK
	 nvGQOUp0Oi0aG+c3flx5u3OzqxblisI1kYA+Oxjn1/6PWdE4LHRWMVTaK+kt6jeoRIAg5
	 1jwr8bKrTz0EARltsecdufyStUZ/G8vCAHKjzlmee8BwCY0B0EHYSRM+lExfvfnmiP5YN
	 9ZZU4UIuGPiGCXt/m34JBDmSTJfLbT1hHvCncS68Q7eRc3UP7CBiUqfIoA739m0lyjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dQ8Kjz3P;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C437606A339
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C437606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dQ8Kjz3P
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4d1b35dc42so133610266b.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 06:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976206; x=1794581006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1coO61O9o20KGfWhe+U/6TV0ZY/FeV096v+PDZIBmoM=;
        b=dQ8Kjz3Pm/40Y6QK+wnykiNHDgz7dKP607sj6/+hqieIq1ZmyilklclOYXjWaBJyZQ
         wigV9r8VouxbEKE9QgPdw1VpSrB3xLnotHYSSNbzuz878AnRPuvoVHRTNcqgEq7hLDnq
         EBy4H5xYRegGJoTvMOlxOYRVq93ULaPKtOQBRtm4a5TxD5b5qxrLBPFkjRnIHAg/fRo8
         SPdaU35rkr0LfaG3/AS4/PMkK2BSbubxBavooY3Ygux0TcvwzrklGLkuYTCBblRoq/9Q
         wGBWvVpbu/YmDkyrFWrcQ9+Xr/vMo02AxG7ipmZa006A9g2kUtdIwncG4kcQ9DAOguTO
         Q3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976206; x=1794581006;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1coO61O9o20KGfWhe+U/6TV0ZY/FeV096v+PDZIBmoM=;
        b=JxqXd/KNCBP4c0r3SqQI3VZ41D3Elm45QTFTmNUa/qZjHoxHqkDFu5BeOYYhaX4Ndv
         kFsON2GoNfL/R4mB2L+umeg6+B4AYy4oY0pfwTe4QWOgClusBXwtaWhNeWbYVXnwA/Cm
         4DVEXHEm8li/u+ItLJg8TpOdVsO/Q3tULjc3QW47lIeFOMvwkXiKlPQ0EaMv9A9GHpHU
         /2es7IltN/ftDdJpY0oM5ypC4DTJB4DxmAcB7gWedFUI/J7XOHBGWZ3URDwzlbA1wUpv
         TSlxEqr/2AK6T0OPCy2/WK++AbBVmjaDwN4c2jr5LzrMJN4ItPDwQtlXv+8gRZdXtLO/
         t4QQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMKkGE6p8VHqwvFVJt80+VmuUnqe31QTkG1exii8lw0Tg+JqyAtmBzA8pnkNNashNHwXm6BgA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hhEPabbPnWFZWFkM/5K0tM3wFWQi72nPOrV+RdSYnsfa0fgiZ
	tnUZAkwUk6TTCJaTq8tYiyOEg45CGh7GzI8j5BZdGz4Ow5ggEfh5KcRC
X-Gm-Gg: AYBFou0YTINXdzpHdn5Y/gFDCVxUZXuYEIfurmn1/Kxii9/wqGYzxSdIor0h35kjqEe
	jcfUScitm84QvtRTN5bEVX2400+GYxu+iN8OUpL6oey1hyVmAE4c0OwAZttSRZJXP/q+Qg8/vvk
	k1XENABumfWduzDs/HgV1OuOLv5IPLqthbOKaudobpwtJGWUsTGxssWeJHPNgJJtN0aYeSfPgqD
	Tb2SgEaEsoBrnXJi3biZxan6bVv0eqzY0Koshko2/0Wx89MrQvcaGC4ElqOmXJa+qhkG7Wtay+m
	bBkx0+w7FXta0kqQ139ynousQCgLXXeiCdNRyU14X/8Y8lTlAc6k9CTlp6+EFS7rhFfJZSGR2yj
	6ItYfhtLMkPI1G/YCPL+gpnOu85IiGOqS5OsRDDoacb3yrc9zMGdnDY4JTuFFsG6GaVg/pINDHW
	koIoMNs/rZQuOgoSFGY8E730runrkvv96MrEv14xYSuiEHfPJ3FTTDubM+eE+y8V7fq322A/pye
	SgMv8RxaN6G9MZC+ecpIjqFKRv7xZMU+D5qqARHnQO+7u7IbFE3heYPhD0igyAefRVY
X-Received: by 2002:a17:907:fdcb:b0:c2e:616b:6763 with SMTP id a640c23a62f3a-c4d3525a3f4mr249438666b.3.1793976205728;
        Fri, 06 Nov 2026 06:43:25 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d35631eb2sm86304166b.27.2026.11.06.06.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:43:24 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Fri, 6 Nov 2026 15:43:21 +0100
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Liam R. Howlett (Google)" <liam@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Michal Hocko <mhocko@suse.com>,
	Baoquan He <bhe@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	Lorenzo Stoakes <ljs@kernel.org>, Chris Mason <mason@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH 4/4] rhashtable: fix vmalloc() deadlock in atomic rehash
Message-ID: <au3nidyyEWsNkL9D@milan>
References: <xdzcyoou73blpfdlgy47i2ktrcsffnclerzojpgrxphid54gjc@nicdcvzqx447>
 <auqtTjXhD8is-y9f@gondor.apana.org.au>
 <CAHk-=wiE0KG+jkhmJWifXuAVivtB63WCWtdEpGAex7-T0SHd2g@mail.gmail.com>
 <aurAxRpCwzeyXeVj@gondor.apana.org.au>
 <CAHk-=wgPvbYRcKpQ8WTH-EYZRgMG0KSH+cZxY5-Hyf+X7JjWsw@mail.gmail.com>
 <aurJZ81qnbiHH_P1@gondor.apana.org.au>
 <ausS3LQNkdc6lBy3@milan>
 <auxDm_YO4oACA_d2@gondor.apana.org.au>
 <auzOjphJ8DWpXwUy@milan>
 <CAHk-=wjcKOC7O30L8_8PMniT71aqy_3ZEYK2xyoR8zW9ZCvO7g@mail.gmail.com>
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
In-Reply-To: <CAHk-=wjcKOC7O30L8_8PMniT71aqy_3ZEYK2xyoR8zW9ZCvO7g@mail.gmail.com>

On Thu, Nov 05, 2026 at 01:02:35PM -0800, Linus Torvalds wrote:
> On Thu, 5 Nov 2026 at 10:44, Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > @@ -1025,7 +1025,13 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
> >                         }
> >                 }
> >         } else {
> > -               spin_lock(&br->hash_lock);
> > +               if (in_serving_softirq()) {
> > +                       if (!spin_trylock(&br->hash_lock))
> 
> I don't think that in_serving_softirq() makes any sense.
> 
> If I read this code correctly - and it's possible I didn't - this is
> always called under local_bh_disable().
> 
> And local_bh_disable() will have increased the preempt-count exactly
> so that it looks like it's in_serving_softirq().
>
Sorry, probably i am missing something here. My understanding
is that local_bh_disable() adds SOFTIRQ_DISABLE_OFFSET and
in_serving_softirq() checks another SOFTIRQ_OFFSET bit.

--
Uladzislau Rezki
