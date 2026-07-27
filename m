Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC5042BE82
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171023; cv=none; b=DHIKZsNfs0vAwNVky8uvcok0TpFYMO3JpioZGEutewB5Qc/O9cwDzb68aU6TZaKxnQuApdiRG9xYUgJy83EeW/dXEVVG2oNxjL/+EBMqxOL/QpleIcGXgl7HHr+/pfkZ8IqKGeY+fIqHc1V5eVt3Yb9ua4Nd3D7gA5cBYRljAxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171023; c=relaxed/simple;
	bh=5mQRN6h7tTCFnsXFddM0Ko1zLoseWwOecIpZi53zeOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvHMHpygfA5ZEQV4YHoRowSKXovMvzA0xXX8Kx+z24PDIcilxCW24AJU+f8Ow7AXt7qOyq+cz3j6YbxP6IxR9dI27D3Gtpnd9kwgdsow7632O81q56NG6vQ/zxPQWQcXZHyUeve5LkZFDKEswA8gByQByhkfmyPZYOzvCwQiJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=lNYRGiQ7; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="lNYRGiQ7"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e99ef0902so186620485a.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1785171019; x=1785775819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TyxgjtQoCDEFZf0QPk0ARVlu8b9GSZjprhFXfcluj1o=;
        b=lNYRGiQ7/6kmXd2ooGskBxw5HlySPgfWOmd30CJ91vs2RsCs8jXML7QMkkm4pdOsOT
         +hQUdBMwldz2HPRYGpysVcm0VA7em7ZpP32dmByNpxxJMZsDqxCXxx2JCd33q26IGeTU
         7s+5RP3hnchkKrfP7Nc7GfJTjyHY9mALbQWoGOJKTRleI7mL+IMQMwFAJZRFQAGK7C+s
         0nuHhdB1oZP3CX0mmQr50/xb+woRQfNhQE5+UxC8mkJcb30suuvvNuIhECcjBLhvo8mW
         ZfvyX/v34IJBCL75WRgbgS0Lmili+0bUnSDyMaeKS1Y44WK/rhT+JTPnd+ZqcrZZKfBe
         KTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171019; x=1785775819;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyxgjtQoCDEFZf0QPk0ARVlu8b9GSZjprhFXfcluj1o=;
        b=Y2tALs17Hk5GICmikAlh6is29+dtoYiC685DUBMBOJP9KBQFlu42SJWw29lVhdgM0E
         YMGCWGTnhhH9w1yWThxPn1xeNtYcfMX7nKr3BQDinePOTj+qdGzv/oVth1Nb0hdAOIBm
         97tYLDw3AgN8HK5slbYwAmOPEC41UTSMTzmwqnSwtp0TDHVdlZrPATr8G0fN8qszS5zp
         tYR4Yh5zlhq/UWVB/3uOanaaEBzVSEXnpfk98U5tKgKXT4HtV2HPPCur9h3UYX/LmT1j
         m6vxqRpqlELT3WpiU/PtacrxZEmeQVBUY7lVCnhK3SMLSR09kI1qkpfNGrrgpIs3mYLi
         ad6g==
X-Forwarded-Encrypted: i=1; AHgh+Rrmsq7IuDf3REERTt3gIlk7pdHjbF+ld7HdgJ7eNoNOGvEjY0e+z37Tsyma+k2ttNnFNzVGQe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIdt/c4EQBUHbS34HWzYd49mzJHR5JnLCLEtW404Pz8oVg9I9p
	mDJgyP4NNkwNgkE9RL4fpIMph0DDdOd5VvMPgTqJ5BHTbO29X1/e4gBgBfbvnQnTeuc=
X-Gm-Gg: AR+sD11jJ+AX+/C1nY4owCsNCiXPSNwHvbd/CGzEfGo0YFiQnAlIKjXiSO97zrZa/p+
	0HBcEF0QJ922Ny8yPQX5EvinP5kfy6X65L6vh0i0NTS7K0nYYTGuUP30PPu5mzSO5w3TCDnBiGp
	P8yScO8ThuR1JdnSioWzIpa2Yi8Bt13MaZA5ZVsz0uGFRaJDt1GVo7A3XT74y4ptlVT+YwdlFSm
	KjBUm5+EMjt/FWAIi/51jsMscyQ52do/ai2vOWDNVZGIJI7oFHdaJ/hSqYNVM9dfLJMtEQnP+RO
	MLIjSM4085j919NKgw02f/khz9YoiwzHrO3J0dWMV00cZunK9n5UVMKt9lxnO5LP5mKvKdo7FxT
	3ysU2xlLwXz25i8MJAgXnwFOJ5NFKKKdhFPSqA+j+D4Z2p3hh44mjE+Fz90vHlHh/fg8Qnd5um9
	4H
X-Received: by 2002:a05:620a:2983:b0:92e:a48d:251e with SMTP id af79cd13be357-932fe2b5b4emr1445285a.24.1785171019290;
        Mon, 27 Jul 2026 09:50:19 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de5150dfsm649312085a.3.2026.07.27.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:50:18 -0700 (PDT)
Date: Mon, 27 Jul 2026 12:50:17 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: page_alloc: fix non-movable reclaim storm in
 defrag_mode
Message-ID: <ameMSbNO49M45Ieo@cmpxchg.org>
References: <20260722150006.3848560-1-hannes@cmpxchg.org>
 <20260722150006.3848560-5-hannes@cmpxchg.org>
 <DK7NM9RPUJOD.11PNJJ5N2OBED@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK7NM9RPUJOD.11PNJJ5N2OBED@linux.dev>

On Sat, Jul 25, 2026 at 12:34:29PM +0000, Brendan Jackman wrote:
> On Wed Jul 22, 2026 at 2:56 PM UTC, Johannes Weiner wrote:
> > @@ -4169,8 +4185,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
> >  	barrier();
> >  	WRITE_ONCE(current->capture_control, &capc);
> >  
> > -	*compact_result = try_to_compact_pages(gfp_mask, order, alloc_flags, ac,
> > -							       prio, &capc);
> > +	*compact_result = try_to_compact_pages(gfp_mask, compact_order,
> > +					       alloc_flags, ac, prio, &capc);
> >  
> 
> Nit: the comment for try_to_compact_pages() is falsified by this,
> we need something like:

Yes, good catch. Thanks.

Andrew, would you mind folding this difflet in place?

> diff --git i/mm/compaction.c w/mm/compaction.c
> index 0568623d9384d..ca57403dc1522 100644
> --- i/mm/compaction.c
> +++ w/mm/compaction.c
> @@ -2823,7 +2823,7 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
>  /**
>   * try_to_compact_pages - Direct compact to satisfy a high-order allocation
>   * @gfp_mask: The GFP mask of the current allocation
> - * @order: The order of the current allocation
> + * @order: The order to try and make available
>   * @alloc_flags: The allocation flags of the current allocation
>   * @ac: The context of current allocation
>   * @prio: Determines how hard direct compaction should try to succeed
