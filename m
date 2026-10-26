Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021149;
	b=MORVQIWafrmm5HzXA5XOlsIlI8RTVHiTXzLH2OtRj3VlY9kvinlrarirnZz2+AdxZtXm
	 bgxQhvn7TfRsAPrSLsPg3Uj2ri4xJoVELSKQofdqPI6FbQXAqJQHzIPN1fLayb8xHbces
	 vrA/bQyuG59uZ/s5pCCNIYYYDO0i8l1Zd7E94irey6T9Gc8VjW6N6R59uOFKtbBgbOhkY
	 21veWTl+Jo9nDfmSvguZexMRwSEV0efcJFcWxTE3tJe48HI9iJ8tLgxvCtEbchivgMSHh
	 q+8LETpxueCFblu4hhiwSqsdAezkSRD0xE6qRejDH2h/dYmwm7LGJ8SY/lrizeSdvcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JTZ/P1YmJ6IZNJ6lk8Cg6Zigprwxb6S7rjKWG93e8pw=;
	b=hehfzlBYS73AP90lH22xxGlACuwD7vIx+H899LqY4ucmb8f/2hCt6duyLW7FKy6w9C37
	 Vw/r7b0hyMoXuxJx31zmRSbuw9I97Xwmp3U4oQHhYQoxFn2qpUlVCxhySdXZkqUa9UyDn
	 zmvtfdwCOhn2AJzjnE+DocCFx66o7ialZ4OuaWRffo+ILkWPiVv8Ll4Q7PczSrIDHQg/A
	 OzOr0a1y1QMyfbNp6LTQ5QVIPbsq2mkM1mabPks9cQK+w94R5zB5IZzyAeMlNjIJFasFu
	 xujJigdy4gat7qPFbMibkx5kzSByCOd3H9Yl1u5g1lOjgUIsCLXrau6u9kGm0aUsAhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TeC2FOPt;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F7606A33D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D2F7606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TeC2FOPt
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so18533635e9.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793021147; x=1793625947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JTZ/P1YmJ6IZNJ6lk8Cg6Zigprwxb6S7rjKWG93e8pw=;
        b=TeC2FOPteMhC84ln1XNPf2/uDi0Y1HNEWRFnSOT7TjP9dCtOt9flZwVcpmIH7osh2S
         f4kq+T7b62JMHP9bVv58rt7+W8RN6vJjr4iPpVcodn4j+Xk1X5eBtPopddvTzpYIsxMK
         3FNdwQjuoyg7XvmkqvAeADWLNLzjC0zbNgoNVN0+cfAwltOyftmC81rBukPkIweUTb4+
         G58Jwu1rTaOAWIIl5paP0+PKvr6+i4oCqNSjkpI2Q+g1OyB8CE1k4Lfg2zM+K7BeIy/2
         RRWUX450SDMx7t3w1AddmhUBy0E/491GGDHDYHDoW5vOcuWcMDODhYjAqqZKC0e5unWk
         G7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021147; x=1793625947;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JTZ/P1YmJ6IZNJ6lk8Cg6Zigprwxb6S7rjKWG93e8pw=;
        b=q6X2zYkOgm7JV8NoAU3S4iWzfEsObMmb66VXZx/6gcQsDWD8HyTfoRMweph2ZGDx3E
         H8haTfdnp84R7upOV+RdWSZ5aApZRK4d8fUxbSrpnZb8tstCFhVstMbQjoFNZjvAvDwb
         YcVDNhHfYepgxoij+AUiTB7FV7XV69T2wrooR7eqCYZOW8OiSaqgTlK2b4BJxkmqcXK9
         1yKvCnYR4wbOxsso3FhXd+ARilSXLLK39cXXNfw4Y/puTlBIBuuc4pGGShl+Ae+uAkNn
         w8kXaIJgmIcmKc6/LCDJZDvyBRiqTNO3hlMNdJ3BrtVz+tfOBBt3541QljoB5xX4b943
         YIsw==
X-Forwarded-Encrypted: i=1; AKwUvBzfO1dcEYkjm31m1lyqqVBYHzBEJxKplD6w4Y4TveCq0KecEVABbOF3W1ULTbEXBFEg9e2yS10=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNPtyd37E0ZnaZe+HZBfeSYfpMlPI6FEGFBRoYAG4giVlLqPr6
	L6aHw50FfSFdoC867ZhcfPTca4shbzEmhmiYCHcz88i6q1eH8QVSXlbVKWRJm/RPBDNwxcziFCS
	WIHBnhtw=
X-Gm-Gg: AYBFou0TmpuW1FLZCX9DRyg0K245AkIysO1GRMpmOJMhwUk3eX6LZ4v+UpiYTbsi0pX
	GalMlCdFl+JBNwzFLrIYDX8QQYcDxkLTt/OfBT2NvxEYHNwU+9JZr+7xAMs0twtVTkdG6NxT+pc
	rH7/r+JUJNI1DYPPBCf1vKFtBfgEV4J5tb+eSzr9/y0aMb1ZGOiFbpJ6AobBbmHUOrUKctwwDz2
	VqMiWMAnJqPtQbFj3TR+6DO6eHZ5C/nSIx51BAgGikdqNRzdKZSOsCtrc03T1EzgnuIz4AchemT
	acgVhtLZw4EIjVpTAvHL/gjzbPgDVZqMTh54w1mlidwb0Ld3xDHPt1I7Igw7QILvYMHhx41v++n
	opMC2E0UaOauNvLOYE2leBhoGo58CcfNedEfZ4rx0z34bjW7uSD4+WNb3qgLSRwHen/28L4eP5j
	b0t25DwCk8npMIj04d0F0fV6I2Hg8R6yNGgwm8ROCcu+N74FZhPdsombvM5SmXkHRUKuAZOmRmo
	1MbA7jCcq9hictVaAKXrTRW3XNjoJ7GpyNfZwVicbdTDdDOiID4VtExrq1Y0fo3jSMyCQ==
X-Received: by 2002:a05:600c:a306:b0:4a4:fc8c:cfd9 with SMTP id 5b1f17b1804b1-4a4fc8cd1edmr72049405e9.25.1793021147467;
        Mon, 26 Oct 2026 06:25:47 -0700 (PDT)
Received: from localhost (109-81-20-177.rct.o2.cz. [109.81.20.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a30e11bsm232464125e9.1.2026.10.26.06.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:25:47 -0700 (PDT)
Date: Mon, 26 Oct 2026 14:25:44 +0100
From: Michal Hocko <mhocko@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix NULL pointer deref in
 high_work_func() on dying memcg
Message-ID: <at9U2HvyUP-iYOCt@tiehlicka>
References: <20261023222313.3979455-1-tjmercier@google.com>
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
In-Reply-To: <20261023222313.3979455-1-tjmercier@google.com>

On Fri 23-10-26 15:23:13, T.J. Mercier wrote:
[...]
> ---
>  mm/memcontrol.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a05d9a8baa1b..84f4a8fd4d16 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2457,7 +2457,10 @@ static void high_work_func(struct work_struct *work)
>  	struct mem_cgroup *memcg;
>  
>  	memcg = container_of(work, struct mem_cgroup, high_work);
> +	if (!css_tryget_online(&memcg->css))
> +		return;
>  	reclaim_high(memcg, MEMCG_CHARGE_BATCH, GFP_KERNEL);
> +	css_put(&memcg->css);
>  }

OK.
  
>  static void high_irq_work_func(struct irq_work *work)
> @@ -4463,6 +4466,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  
>  	page_counter_set_min(&memcg->memory, 0);
>  	page_counter_set_low(&memcg->memory, 0);
> +	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
> +	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
>  
>  	zswap_memcg_offline_cleanup(memcg);

Should we simply disable_work_sync when the memcg is going to be
released instead (mem_cgroup_css_released)? That should both prevent
the run reclaim_high during the memcg shut down and and also avoid
plaing with limits to work around.

-- 
Michal Hocko
SUSE Labs
