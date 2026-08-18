Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B58F472559
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057514; cv=none; b=CZ14R7N2d9/chJMfDzXlY76y6XajBsj8QvRfAWh0olUms/3Ji9qLUJKww2YFPFFhtN/83fHSldD0izHq+7R0g87U8F8fYlm6wMBKxcZwleaZQaM1P3F7XHzeUo9WqEY8FKkIOOKfEZM9zI08H8iZk6DmsgxIXWcQtfTWMv2mtfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057514; c=relaxed/simple;
	bh=96iVf4HEWu6lFouSRKmCqye79ClCyvq9xplCKlblrOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRxYLLh2xnFWFHrM1mmyLSoDBTvb1WIFhW5BEGhCXOq3DL8w2xqhQVl46zbN7zGxcJ5RkppLYUZ+ih6y7zldLQZ+xsK1XCoX3qlopbDLHzsCOQ2Ip2OkbpUIs2etke+WGCiolaWXspf1+7xXQN3Ym4QI8rjYBGWSu/+KG8Jz7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=osBDDpEW; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="osBDDpEW"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52d5bfa4bafso44548141cf.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787057508; x=1787662308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kc5oCXq282LiDe88kKeCJ1XghMe7rR40RcvOL931zw8=;
        b=osBDDpEWlVqPwJFIjKiS1hmd9aoKlh6QcCz5L2pC8VHJaAA0lH8b/pCTftJbSV/KUS
         6nRoCejLQ3iDNAksPS5FGyKAzaoxOs8FbA3aOhPYNiAj9ShOnUbq7FmX0ijqspRUW+Iu
         OUjBS9HqKPMRa7LrjOt7d/E8anQ9ORirBXSZ29vQ7IrS5NZ7kIdAdkb2h9acO5CjnsMi
         zabahx7uyhfZO7MexRYbmmUAmsivnvh0MvF2naAHPCqH021b8+HnS5GdGWdb4/4iS4fm
         /gNZwKgaAPdVbi63MXYieKEEN602hnRaku9+cJWdhmVEXXpl1YVhv5Y4VRqf55GaPH6k
         S/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787057508; x=1787662308;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kc5oCXq282LiDe88kKeCJ1XghMe7rR40RcvOL931zw8=;
        b=nQvCQPfqU8couGdQsVcXrB1rvm4Uv0I0KYaXOB0P4XGQXr3dzuHTLIw+UN/9+kCLCU
         BvdkYQUvDCOB20omw0UrFDufcSot++/X/iTmWoJ9b3cQseIh3X5oI9tNaGlCXjhvdeZb
         zV0qoKkGQJ6gQCIelWIsmcMjpgZoIl6C0WCFEnEJf4hHtG5sqJ5FhGmJloBSQnWwEKg3
         Ku/UxeWVhLjpi3b6F40s/qV09zpwVLoZ0DmtTGl5vhGrBHYyGDZbRafvrws19ca9gHFX
         bFxG7a2iYGTGfYwn5gfoaVwczQ6Qo2QhdKIMj/izvRurmhpOybsaWiEsE029fjpXZ2N2
         wgwA==
X-Forwarded-Encrypted: i=1; AHgh+Rpop65hITWScOl4EtddZ0AaQE6DehqqDh3PYNsOoqkhdx/tiy56o6qhZd5AkIhnlVsIXHCtiiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+IJDKNKulL6+eaT+gZjmg09F4A5kCjSPnsqSH9+4XNqhAljz
	j1kXR06TjeNM7dFH4jMU2/Vy4NTKIkxielzz9MkFkbcrxj1ljR9gkHRk1u/tydMeXZA=
X-Gm-Gg: AR+sD13Q25XA7fHM2N3db1hGRM4PRNAu60K1s2MkXsgXfMX5K7F7aLLB7VGJfuR8jVw
	JJp9TSI3IHx7iNDSakelgJsJbtM0nfI7+ip0GLdGEsqbcg5RUmZp043M5Aik1Xr33P9MKkmebUY
	+Ng6PRNBsT2bAv3Rb+TrFDmVKDjosQUTM/iONk2Sd28qCS034T842eGNfFkzEyr6LTUE+HKOowo
	5nQlUmqMZ5bvEQH/gnDFunzYKXaYtn7TD/Dp+LZRyqii2alAF0ZIeevPJ5NYTNKHZq9EE5NE5Tz
	JAFYFxUFDaWmu3EUxhP1YnBu64d1Wej632ERy2V9kvZkcMieLHxRCL7TvffM7IiZqgMMicYAkpm
	yJLJJKMQT2T5y/VMPKzzcoo6G0QXFcxKCfbqrZclyWkhUzbCml5Dd3QRmTlvT+5jxvlMEJ9Pp+4
	ER2BATvXEs/Dz/YoH9FBFYYXPJ5zzBSOfyuq6zAJ2/Y3yxfmjlF20dv4F7STADfWbLsJXiJPwcd
	q/DgC6KAkgP2/NloHA3mX2LXvRdTTPnaDaF2Bysyzj/
X-Received: by 2002:a05:622a:14b:b0:52b:4e1f:941d with SMTP id d75a77b69052e-52d8530dbc7mr334517651cf.6.1787057508583;
        Tue, 18 Aug 2026 05:51:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db613ca70sm37684191cf.13.2026.08.18.05.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 05:51:48 -0700 (PDT)
Date: Tue, 18 Aug 2026 08:51:46 -0400
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, 
	vbabka@kernel.org, jannh@google.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm/mempolicy: skip zone device folios when
 queueing folios
Message-ID: <aoRUzDNvLgmMCqUn@gourry-fedora-PF4VCD3F>
References: <20260817220810.1175596-1-gourry@gourry.net>
 <20260817220810.1175596-4-gourry@gourry.net>
 <aoONaAtLLnYAZnmG@parvat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoONaAtLLnYAZnmG@parvat>

On Tue, Aug 18, 2026 at 09:34:49AM +1000, Balbir Singh wrote:
> On Mon, Aug 17, 2026 at 06:08:10PM -0400, Gregory Price wrote:
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 3498a5651d50f..3418b5664dcf8 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -662,6 +662,8 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
> >  		return;
> >  	}
> >  	folio = pmd_folio(pmdval);
> > +	if (folio_is_zone_device(folio))
> > +		return;
> >  	if (is_huge_zero_folio(folio)) {
> >  		walk->action = ACTION_CONTINUE;
> >  		return;
> > -- 
> > 2.53.0-Meta
> >
> 
> 
> A similar patch was sent out earlier, but that was only for zone device
> private THP, we don't support migration of device coherent THP today (we
> should add support). The patch itself makes sense
> 

Yeah IIRC that was Usama's and I got confused thinking this had already
been resolved - but i realized this still affects device coherent.

ty!

~Gregory
