Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40713C8737
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790050860; cv=none; b=FjtiScsudXPh8i31dZ4znVhsVXgE+zGo6QIullfXGQ/OV7qarKgewTyiMZRWaS4gdsWnpooFm/QKt5ixXztOI+1C2u59YoZ+GPM1s553KYK/g56+U34/0ADqfRt/FrOvMGusIiEJRexwG9MtGIbKvW7ua1tvr9nHasKqpVJpl7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790050860; c=relaxed/simple;
	bh=TZM1KYX85yBCMfB6pkxSOsIHrKLKOo+AjP2+UyNJ9j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxyBRg9IAoJOAn+NOD1aVgnWPxN6Ldq5quFIxuA68YxSpSjBXz+BHNt8408bQwTplTWJwGwo8thELRvVUyn8Wxtgh1yWBs7XqhETdeJvA3H0fJjUqcJfAy8Bw3EmqMU2s5N1vkJYutO8LGwBL1oBw12qAvJqZdGSa6pqK4mbKvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaKwNzYQ; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaKwNzYQ"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a3688a2so2579457b6e.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 21:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790050856; x=1790655656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vw7F89gHzb0bwYi7GFQ9WYKMfHucMYNinHqo/LXrYrc=;
        b=TaKwNzYQC3IV4k5u1R0e6DP13oNkdZC59ofnDcM2oCUXDHaIhYHvlBrnrBifPexisF
         OVSBW2rtCqRzY2/DAomwW5sZzaA3AmkVw3vgMTMoJSPlMaSWfxWArz4jZ6GUXBWdMdUU
         SSv0g8yjGSiz+qzTGsW2XX0ONq9XizjcbGcQWQtIs8WNdQesXyQMVlxiZ8dsjdhihfTE
         qjRDjD0Hvyk744paP7XZrjFwW5aQou5InNmo5T8828oVSPezSpMfF4V3l7gnj995bmKD
         XkW/PTNQp6YlNQErYmaEP9xL1qd5/C4ZJwk41kLAWDGoSUDdA3Mj/k4dwvWZXwLYMwPW
         HnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790050856; x=1790655656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vw7F89gHzb0bwYi7GFQ9WYKMfHucMYNinHqo/LXrYrc=;
        b=ON4gh0qYaevXhfCUe3wsAGHO0rKv22EFr2YBRE1xJVJK9kpXSL7z5lqWNcP+tV8K4K
         7up3mA675PTtynxZIjFo4ALOYOi3Pg61GOlv5WuUQkLUtyXyzqf1gv2AD9iFNatdHR9r
         Xl1serEXzoBmbAc9O8fjx+V5x2qDNBSG1v2nXdBWRuFv2lHCjTXk6+U8AGwI83vEhaSh
         jykQr1+rNLyS8tmQtvdsoC3EAZb5BXdjHX3LcQDYveU1yHqkwB8DNhT8tLBPu9cF3Px4
         h4CGRZTUtLWkEiUy9a0PJcR97WnGProAkAalK8PU7Eq1PHezmU+41Erw3R3RYhycCBgS
         s30w==
X-Forwarded-Encrypted: i=1; AKwUvBzgCsAm0ZFrmCo+aWs8Au302VriWxFfYTVPDe3scMvvsDUiv2sDvLN6sxl7Vzbt1JPFIgOnlnw=@vger.kernel.org
X-Gm-Message-State: AFuF++m+4ZlOauvmRw4We981fOV2/7f67FY91OeYfx+NgrhAIc+PEK1t
	eT/7hh2tDkybVwQSS6xaR1Dn1dJ6MKYYbQ6Dk/MfQYrXxeXcou3tkydc
X-Gm-Gg: AYBFou1WQf3+PWOQlC8+b0wyjkLR+Rbi+j4G6lLM9bVp08oL7+wDYpayLKUIHFEMom3
	1TuieZveYY2TwoiTJiNN9o2bYeIebE8jSCAotoe4RLHvbw79q0Xsd0JTHeN7YKeEvFSc1kayQG+
	uZoQMJ5CGebzOtuIpJAXRyxjlGM9IVIriZx2mHKOasanAxHDqy9Xm01NdaZa+d9Qthmx9/Hf5P+
	oV1bGcC6qYC7VvSgSIr9GeW2hP9mnOdN7vSKCtN78X/q9a3ycuTPQ8vNSpg0Gm3nXJdJM/01cbI
	J/iOr7gdajXVkVXG7WNkJqt9kzSkdhPLeOtunTVm3kvYrAJMIQyjmD+NeoJhqAXdWTz1LheCqQE
	KPqWgCyOk9SBNt092Vwy7SkE9nD4EAj12gYLAWb/fTlVY6YDzqjAvQ5AbEfrJUCKpLVK0jN9OL7
	pm5ZMZZxAtvhTo/MX6ZTSXbZyR2dIW3Noj+5wbnd77SFjnQQNarW2pr0M71e+7+ZkIZ1ycsuAH3
	hV4uZWZTnFOGl+i8twA7oIuVKRGWA==
X-Received: by 2002:a05:6820:4b8e:b0:6bd:bf80:9796 with SMTP id 006d021491bc7-6ca9be50072mr13917974eaf.41.1790050856466;
        Mon, 21 Sep 2026 21:20:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-814e394ac61sm881122a34.1.2026.09.21.21.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 21:20:55 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
Cc: Hongfu Li <hongfu.li@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chris Down <chris@chrisdown.name>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Hongfu Li <lihongfu@kylinos.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/memcg: migrate per-node hugetlb lruvec stat together with hugetlb folio
Date: Mon, 21 Sep 2026 21:20:53 -0700
Message-ID: <20260922042054.3264663-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arIAyyjYcCKHFmyD@localhost.localdomain>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 22 Sep 2026 06:15:07 +0200 "Oscar Salvador (SUSE)" <osalvador@kernel.org> wrote:

> On Mon, Sep 21, 2026 at 05:12:35PM +0800, Hongfu Li wrote:
> > From: Hongfu Li <lihongfu@kylinos.cn>
> > 
> > memory.numa_stat exposes per-node hugetlb counters from per-node lruvec
> > stats. These stats are accounted against folio_nid(): incremented on
> > the folio's node when handed to a user, decremented when the folio is
> > returned to the pool.
> > 
> > During hugetlb folio migration, mem_cgroup_migrate() moves the charge
> > to the new folio and drops the memcg data of the old one, so the free
> > of the old folio right after the migration skips the memcg per-node
> > lruvec decrement. The hugetlb count stays attributed to the old node
> > for the rest of the life of the charge, while the target folio gets no
> > increment on the new node; its later free decrements a counter that
> > was never incremented.
> > 
> > Migrate the per-node lruvec accounting alongside migration. Global
> > memcg totals remain balanced because they track resource consumption,
> > not node placement.
> > 
> > Fixes: 05d4532b60e3 ("memcg/hugetlb: add hugeTLB counters to memcg")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
> 
> For the fix itself:
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> question below:
> 
> > ---
> >  mm/memcontrol.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 1460cba53588..9c96ebd5436f 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5598,6 +5598,34 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
> >  	rcu_read_unlock();
> >  }
> >  
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +static void move_hugetlb_lruvec_stat(struct obj_cgroup *objcg,
> > +				     struct folio *old, struct folio *new)
> > +{
> > +	long nr_pages = folio_nr_pages(old);
> > +	struct mem_cgroup *memcg;
> > +	int old_nid = folio_nid(old);
> > +	int new_nid = folio_nid(new);
> > +
> > +	if (old_nid == new_nid)
> > +		return;
> > +
> > +	rcu_read_lock();
> > +	memcg = obj_cgroup_memcg(objcg);
> > +	mod_memcg_lruvec_state(mem_cgroup_lruvec(memcg, NODE_DATA(old_nid)),
> > +			       NR_HUGETLB, -nr_pages);
> > +	mod_memcg_lruvec_state(mem_cgroup_lruvec(memcg, NODE_DATA(new_nid)),
> > +			       NR_HUGETLB, nr_pages);
> > +	rcu_read_unlock();
> 
> Why do we need the whole thing to be embraced by rcu?

Hi Oscar,

I believe it's because now getting the memcg from the objcg requires
an RCU lock to make sure it doesn't get removed while we work on the
memcg. I think this is since Qi Zheng's "Eliminate Dying Memory
Cgroup" series.

Joshua
