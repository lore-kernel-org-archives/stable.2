Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9302E4A485B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001454; cv=none; b=e9ohvP9gJzMjuVKyeQaKdMR9jdvsIwA9e2kU6Ot821bEaasemaOoNjvrzUd4S91NLlbnA4LJ3POzuS6NiG9zjY2RPHr70Dd1vvhVMAPrArGErF+44kPae8tioCZDaKWbN3fUb0oNhDVBoDycoOHQ46C0MfWRAz4Cscn+5f/fs14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001454; c=relaxed/simple;
	bh=vu2KvWKFFA3N0wzDMJWi0oZ02CuH0BR9UkXp9PpwQsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLGqmj2Lj1HIgjLvw0ngR/mP0nWq0JGBNeFBGEV0CBhtr2AWedGJDJ3umZFejpr5ESxzCHrs8sBN/2MpZU1acSNZdM4+T8rio+8aqIrY2E+3KucddrZtumKIBpsnHSfq6Y/uUi6CaJ39w1ENNPrceC3qhSPnoRw9uM+uReu5Cug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=gGjAZSOE; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="gGjAZSOE"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9104e54b1abso43606266d6.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1790001450; x=1790606250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2vUrOHpknLsQODHI2VwdgOODmPETkIBd14WWg0Q6gUI=;
        b=gGjAZSOEjIaxKx0rdVUPsz0SmRs3cCI08XIo7lwjSMAEXPTKAEcXmZWfEfW9Jht7oH
         7A3f7/UR2wrlWGhIMjUyeXMBZhb5+HiqYfFUa5XaNIDDTPJNjSKEVqr3fIplf2Dh1O4r
         1pSWQgbLLvt78yRTbyF6TGbE6SfDlihfWkHWPU0Me9nFoF2KFgjUy/k3G+sZ7dOCAS0E
         i34EpHTE0RXK+DzLa4XGsx7b26hET134pWpl/hCSYa57CnNu4VhKTr2l0FvCSvYjCBHf
         EpxF/E8EooECmNpNhBWyzFr7BRvmBk3c62TWnATpVP9a87EVkhOh6xZP7zc0OZjDm+AA
         ln2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790001450; x=1790606250;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2vUrOHpknLsQODHI2VwdgOODmPETkIBd14WWg0Q6gUI=;
        b=0iQ35cau7XyOWxlFkJMuRqQAN9oB8O1bsQlsqfMNz3E6B85fH/Ftbzzi/DKxxnxe0P
         dsLr3An4a33Kqkzp3redbbgzpwBh2oITDQL5MwdlgQ0n4zT9RwNbCqcuvBtRBUfLeob9
         OJFRK8ENwY32f4WVs219KDbAQ59VjUSoRQYh6NwHu+AtDxfFwcY7sp2stFKvW7JwB3mJ
         dQ8C7ESZibjyehvtzdPYAxmEcKOvdUpi5vUpUoWGHikDtahC0abUWDd+snVzhOQo/dIk
         iYm0W4jGFqTovl5g8KcZ1rLnEL9jnRYxduhean4JoaGxvTedTn/1YM9iy2GNEeNftgxa
         I5EA==
X-Forwarded-Encrypted: i=1; AKwUvByZbXO0mfeUhv6U9o4PBUi6bOOLNSIigW4oS3IyXzmqLoMDE+0uPghq5tBOjPknHix7zNUprnA=@vger.kernel.org
X-Gm-Message-State: AFuF++mmi26myx1YymgRtcOBWQ+HhY4wG/deyVcvWA8dTueAgfXJRAaT
	nlEQXddBWNzojWtqHN/534dwnLZUEHi9N6t9YUlQp9m+7ps/w9TJkqO0J2u806qzJKY=
X-Gm-Gg: AYBFou3ZOZobY+ajZHo4tLgUbOWGvPh4wOsvUFVj0i7NizaNgK7wz0R9cfaDbHHewyL
	HH1LYWj/Kv668WgZr5BYnAWzdcWXSh0LtHszYHNAk59uTO1GIBKCbiz0TirfAZKn3TEYpkJQu+/
	JU/cZthcpXuV8jbB2O/DV2n59XBRnmONv/yCCVi/5CL1U6ZAXScDxt5538mx885xTX0YMqwJ2MI
	Vzt4WPk3F0E66I+5Kdlv8K6ekof/md9LRsXA1S4FstDumjAgAJDi/Zm+IE8a00SVVFgYUa3iNrZ
	VWKrBBTw85L78Q2p60w9rpruG2uTdqz8WiEEoxQuMUJdj2njgbcrXhlV59oeDOpAXfLBWbpA4Mv
	5wBJam9cfrnC4jAgmaleEOI86oXWK+Ko097eatmVui1EXsewuhdcqT/+sV2TMWnK4S6zDralaP6
	X7M0QnC79FRKd3gVSGqihxHULPSqoahS2N0lw/6nxKsgAJrcM/pSayZO7JVPXFmQY0B//f
X-Received: by 2002:ac8:5e4f:0:b0:532:ca19:afc1 with SMTP id d75a77b69052e-532d8d8a849mr9913591cf.29.1790001450247;
        Mon, 21 Sep 2026 07:37:30 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae511210sm65434551cf.2.2026.09.21.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:37:29 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:37:25 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Matt Fleming <matt@readmodwrite.com>,
	Salvatore Dipietro <dipiets@amazon.it>, akpm@linux-foundation.org,
	abuehaze@amazon.com, alisaidi@amazon.com, blakgeof@amazon.com,
	brauner@kernel.org, brendan.jackman@linux.dev, david@redhat.com,
	dgc@kernel.org, dipietro.salvatore@gmail.com, djwong@kernel.org,
	hch@infradead.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mhocko@suse.com, ritesh.list@gmail.com,
	rvvandan@amazon.com, stable@vger.kernel.org, surenb@google.com,
	willy@infradead.org, ziy@nvidia.com
Subject: Re: [PATCH v4] mm/page_alloc: avoid direct compaction for costly
 __GFP_NORETRY allocations
Message-ID: <arFBJdYaRx_iJNDA@cmpxchg.org>
References: <20260905174239.99e31515fabe220aa7d8e6fa@linux-foundation.org>
 <20260910114602.926944-1-dipiets@amazon.it>
 <aqQlUr-1h07G8JWM@cmpxchg.org>
 <8d6a8a63-4adc-458a-b548-a47bf5ff8eb7@kernel.org>
 <aqq8pWI0u1IZNWHT@cmpxchg.org>
 <9f415dc7-adad-4161-b20d-7c3173f50ff3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f415dc7-adad-4161-b20d-7c3173f50ff3@kernel.org>

On Fri, Sep 18, 2026 at 09:05:40AM +0200, Vlastimil Babka (SUSE) wrote:
> On 9/16/26 17:58, Johannes Weiner wrote:
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 12fac9084c48..c79cc7aa4dff 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3246,7 +3246,8 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
> >  			 * reserves as failing now is worse than failing a
> >  			 * high-order atomic allocation in the future.
> >  			 */
> > -			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
> > +			if (!page && ((alloc_flags & ALLOC_OOM) ||
> > +				      ((alloc_flags & ALLOC_MASK_ATOMIC) == ALLOC_MASK_ATOMIC)))
> >  				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
> >  
> >  			if (!page) {
> > diff --git a/mm/page_alloc.h b/mm/page_alloc.h
> > index b9259deddb59..11714ddca254 100644
> > --- a/mm/page_alloc.h
> > +++ b/mm/page_alloc.h
> > @@ -60,6 +60,9 @@
> >  /* Flags that allow allocations below the min watermark. */
> >  #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
> >  
> > +/* Flag combination from GFP_ATOMIC */
> > +#define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)
> > +
> >  /*
> >   * Structure for holding the mostly immutable allocation parameters passed
> >   * between functions involved in allocations, including the alloc_pages*
> 
> Should work.
> 
> > 
> >> Unless I'm mistaken about that MIGRATE_HIGHATOMIC part, it seems all sashiko
> >> concerns can be dismissed and then indeed v4 is the better version.
> > 
> > It looks like a real issue to me, but one that already exists
> > independent of Salvatore's change.
> 
> But Salvatore's change (v4, not v5 IIUC) will make it worse because
> __GFP_DIRECT_RECLAIM + __GFP_NORETRY costly order opportunistic attempts
> with fallback will start eating the highatomic reserves too?
>
> In that case the fix for this should probably be part of the same PR to
> Linus and be also stable with Fixes: 281dd25c1a01

Yes, agreed on both.

Sorry for the delay - while poking around I found another oddity in
how the reserves are accessed.

I'll reply with two patches that I think we want to go in as fixes,
whether Salvatore's patch goes ahead or not.
