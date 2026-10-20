Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465456;
	b=IRFAk16pSpZUXj8hf2gsGiSlPtK7xNPohqANCBgNsTRGZikXIo4s17QGlYu2n5aK/HdF
	 1Ii/KGqcuJnsG0+eov2+yp3UJ/AxjhycRt70iGEIkw7otsoxKjc8bXHldO3vsoEcDC2rq
	 VSgk5SIo9ifWsK3sK6UYg9j384QyCajLvv1IhmBZkW34C8wB13miaBKTuUjcua9d9HDeS
	 HEyLBZEvdgtNdgdT54Gy2tjSbM+F0LRPiVnjdUOectrDcwLjWQKWc/4EGc3kRMO7F9YgW
	 NbJOXW9UQCTaNUy4y2gSu1FOy+tOOPUW2QviIrSUrAgFp9p/aR215u27Lgn23mxHvhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FvpcUWOMJRPh8Fi2Ngt6U54Np2NRjnE0G0LmqIgTo0M=;
	b=OWqvH/AE4G/zuO0uCEWbcijRxPEw4POf6FnpRY1fYho5Stu2fm9QfDmBENtAsUcLjsga
	 EY6PgnPgbkKnA433y1WOdgNSxtKBGulzTnRSVh6EPKbi+/7Gxa3Fu69XZUyTu8httujOt
	 eWinSYqvgRuG3Ng/8XRmfHvGbopmy01bAXpscJDMRfbY7xurq4wG3+QkW3nrkIgHaqV8T
	 EvA0WUPkfj18opmYn1UhbRGL7q2HKgr3rUbU0p6uCNa4MZ3DEK+k7X6V7gsZIb7wNwhjt
	 aKdDn1pN5QBnPnYYAJjmoUCRxsxz7l8rnjOYs6eZOMYdqLeKesAVKLcyNKPn1yqW4GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Rzv0PZ11;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA4606A31D
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FAA4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Rzv0PZ11
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f1cf92c9eso281997885a.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792465455; x=1793070255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FvpcUWOMJRPh8Fi2Ngt6U54Np2NRjnE0G0LmqIgTo0M=;
        b=Rzv0PZ11amlZCBHSQbI4tLaoQRJGFkTwgDTozpYth43bGQNLv/XgH1xNcWB7xJcKTX
         xNDuN+zQmcKHGzGII7v6lro3YCzTRCY4wGzBaYNzK4gumG8CGE+WlLi6oWc2MMetIcjz
         LdfPsKZbQLsgpOX6XztwWzeLGKLyu4MwkyLxxXFKdQh6QuBzFBkNjUYqN+NjjimDsV7j
         hakRQ2///8iSro4qBTbiWCFKcGAFfBeZ6CSV+xyp5uMemxJNSr29O6y+6OT+Ei6z+Kro
         Jz3NhYi78jjRoLREQFfO50TeHi5ZGSsSivKR3bsvHXoayJ436aGTNy3uE8YBDNGLTfV3
         Y/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792465455; x=1793070255;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FvpcUWOMJRPh8Fi2Ngt6U54Np2NRjnE0G0LmqIgTo0M=;
        b=P+uuZRRR1DBsNlAam1NlA3/xdCye61+2sZSbVFqp15kYW9kFGsiZesBBZMZXPJ/3Rv
         1okiQnzmsy9r9R5QzVeuQ8hoRJTPneKgmKTyQiT/I2XhE2DyglqPcbECevfNv0mALhxm
         HVmlH0xFGtICGyBVkHHTrVUWB5AZR4WhpWyGHYFRc5K5H2GkSAbACMMRcufuz/AgtxOX
         BCrzWk5nMY/wYLK6jo6LlXkwyIADBb8TrMDunyZInLPk20w6rYJlYo44LZGNpAx/aXg8
         OfU4s2RM9w5FZ/kytua+FcTAQej81gey93cta3ADjI80z5IUz8RhwKWW/JZZh9oBT8D/
         F+/A==
X-Forwarded-Encrypted: i=1; AKwUvBwR5uucKekjSsyR8yKfD9S2I17YKHCuEWjCAxeK5UMJBfz+bQsk+9n1mzHzldR3knPPyPrT7io=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBG3ecULy0NbNWLRzmVxq7J2zM5BXnTsbMAW0PZfXhFoEi9IqU
	oV70jXcTioFFEV3fQjUDoEcDT3+Uhq+kHNQ01mhNU4XfQMqchSK6pi35zMo4FQKfGkU=
X-Gm-Gg: AYBFou0ffGg1iQJDrlCz4Qy7/tdfBPnrgXGDO7K72AEDcSSMtVbX8Lcbyb3c4CZlkjV
	bGbjplXgXj/8l1js3e3vtjkTT9AvYinph+jpYIjfxAVoC0uoOYYAAB47rW5+h9a1Aaek7BD7VSn
	vFm6UYBsz4gYfijMBDGYwAlGdzhE1zYp6z+tTyBjke7mvmo0nH3voMHDljXzKaoJEiRooTYnGWK
	rr6SYeCpqvEiOWficp4vaVmsx7x183oXJ/T7TAuOeAmalnq2qWQ2OwtCdpkKcuSbHHX/gNW9eL6
	WE4lOTCXb/7ekwgoz8ZxmeNsUKpZ5+o87LzurEwJmldkpdlySauybYKfE07QUm8Psf9S1PQ1Xd1
	IplmZyDiGFZATtTb0S5YglS9J2zcHUBQG7RnyBuI10Mz7kDiM1IpFEgZsQKLMiuRGWoDC8x8brf
	YgBYByvkMlDM8VoNsqbMAk2oIYw2hc7lxyRPX2YXMStwauRhtBBxXiE00U5zy+SibWuLzwqIIc7
	GzTD0cvEOteFgRJOW88EbAvmd76ypPn+PpXCjIInimequQZWE4Ml6E=
X-Received: by 2002:a05:620a:28c6:b0:93f:3565:813 with SMTP id af79cd13be357-93f3565089bmr1140582985a.9.1792465454862;
        Mon, 19 Oct 2026 20:04:14 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4b0c4f1asm114948985a.33.2026.10.19.20.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:04:14 -0700 (PDT)
Date: Mon, 19 Oct 2026 23:04:12 -0400
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, hannes@cmpxchg.org, 
	david@kernel.org, mhocko@kernel.org, ljs@kernel.org, dave@stgolabs.net, 
	roman.gushchin@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive
 reclaim
Message-ID: <atbZyUYli9Ioy5O6@gourry-fedora-PF4VCD3F>
References: <20261019185002.3428594-1-gourry@gourry.net>
 <b7aab691-ae63-498c-8d0c-1696592eea60@nvidia.com>
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
In-Reply-To: <b7aab691-ae63-498c-8d0c-1696592eea60@nvidia.com>

On Tue, Oct 20, 2026 at 12:49:37PM +1100, Balbir Singh wrote:
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index e82ba737c028d..90f7a7bf4e426 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -8180,7 +8180,7 @@ int user_proactive_reclaim(char *buf,
> >  		} else {
> >  			struct scan_control sc = {
> >  				.gfp_mask = current_gfp_context(gfp_mask),
> > -				.reclaim_idx = gfp_zone(gfp_mask),
> > +				.reclaim_idx = MAX_NR_ZONES - 1,
> >  				.proactive_swappiness = swappiness == -1 ? NULL : &swappiness,
> >  				.priority = DEF_PRIORITY,
> >  				.may_writepage = 1,
> 
> 
> I just noticed some other issues with this code, in terms of honouring
> zone_reclaim_node (not related to this patch). I'll send out fixes, for
> this patch.

I'm shocked, I tell you, shocked!

These are all things I accidentally ran into by just uh... using the
interface.  I'm absolutely positive these interfaces are full of bugs.

~Gregory
