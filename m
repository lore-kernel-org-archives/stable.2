Received: from mail-qk2-f27.google.com (mail-qk2-f27.google.com [74.125.230.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C00650C2B8
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739830; cv=none; b=s6yxTESjCnqXT8k9oBhEB7dVZ9XMKqwZJG7T+xDyNJ4G88ydBTLjPBgok7ZUtpr7Dl8OSqLYa9exGeFGIcruVgdpq5350gTbtIWUu9sLwCAR9hn/r55hMI249mWjlXFKHr2bKkmYZGqbJ3gWqb6zaKSmwLNHFiqHJlWbnBPgQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739830; c=relaxed/simple;
	bh=93R51HW/dcJOiR1JyahPVCs2TrE1eJK3iUcdGqdUp8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvErNNVk/ZEqCiOXGKyJzZoQTplF4EQjyWjTV8RqKeBhb2GClAEdVlKcH6IzJv+7mayoclqI+7zwcVhX6PWtus8aAqUv7dmUB88GWVfNPkv0v7jRycaS+tTmdUCkEMtOIEdy9TRBPxxGhe6BcQzNM1eMdd92JEQyU99roWvOvx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QW1OPhNU; arc=none smtp.client-ip=74.125.230.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QW1OPhNU"
Received: by mail-qk2-f27.google.com with SMTP id af79cd13be357-939ca12ab70so95668785a.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789739827; x=1790344627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OiMqaqWbazIIJAAiWkvYfZs2lBb8py7IOOpDM416lKg=;
        b=QW1OPhNUcDsQkpZ0reqj8GkRt1n7Mw2oSFPqfOAS+rKn/4gEyVwkDfMvZYraI0KUho
         twuSKsNttOSZpyoPaRlm10K87o2/GgqZfSkgyIhL4GEj3YXkmf6afQHjY/spsQHcTPK8
         NtHzyY40YP2vjKdhVon6p6I4oWsvFYrv4zeYx56Q6G+Ks5UN84tKLlplXDqsP8pl6gYJ
         2NAwXqL5gdidoNhfo8MeXkRJ7Te0PgLwInf9vWh+gmLj3rn0psnLW3zVSfvUYb6p5s+Y
         myuNXamtC0b1Nvj6X/voxJpZCfSBsext26c+bkLT+YfREJolDy/wfVyXaP5xJVMYXlCD
         S/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789739827; x=1790344627;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OiMqaqWbazIIJAAiWkvYfZs2lBb8py7IOOpDM416lKg=;
        b=H7gO6Ejg8nuHHrMyg/rI7Hy/aWdwccpQuPdqyFl46sfXKvUkQCi5m9LA7bTfgAQJfl
         cvgBa7xutrM+DbbZDdsYFWhgKGeO9dEN4mG8OdQluKqP2MNyiNVIjKHHMTcCEIByzT3s
         Gor9UxBU4vx0hYxnRpeS9FjcqAaXrzbkwIiKkwSlFNIrixHceh4FgQ3muHARGxwRDnJF
         KX32t49aHXcV5RL+RTuLSMQocHFdDpkJwmCNx6qmYY34a8QzqJdkyQRgEd8G5hwZAkhe
         rqj2M7QJrp9kBXJFt0F9tpQlOMxsACe/irigpfHBxB8gQ6IPZMJ4KC2Gb2JEnUwRZI9/
         1p0g==
X-Forwarded-Encrypted: i=1; AKwUvBxMLLKmvPmE2jbNdW5ydEkSDfIAYCn3g7QFmxkjWnYqFObYKmRU5W53EqqCXHbP/dK6bH4dIuw=@vger.kernel.org
X-Gm-Message-State: AFuF++mRMZu80PW9Co7cIVVcyDzj51oqAnCbTPnR0oekSzZXkclqc+0m
	NR2w1K391qjn8HUTubeuik3TvGcmdgQgryAfm0aEOHAM75L6DVlC5eH1ZqUQTsDS69Y=
X-Gm-Gg: AYBFou3/QO4V8g9oXLRFguFa3QS6HE3C4OlSJLUkf7ULpjApdAKDqq+ooyDwyZgxBIk
	DN5T9ox+GaRwa8fkiqeqY5sWvmnq6QINfC/LP4Cue3N7LcS+KORl9gGwoOJqEfG42kkNpwN9igu
	+v8/DZbtXP98EZMukR+FaC6Ac2V1Ifr+254DlbsQ64tky+el1tCeQ0oP5ks0gQYIiQVaeD6gFYP
	6EE+4fWUfMjyENLy0xbylIAQgHpwHUbn+tWqmjJQ+oXWVefaYvAA+njcudydmO8iZr4eV1Vyph1
	AkYRaqoGcQ4xUEU1Fv79fRLw7/O8pQkxLeH6T0Wc/ZkUmHk1lLKCE/V4lPSoCRuMjTOiHRSHGDN
	3VLqgEFF7XQJm01jRWTFSeI9d6U/iPzY0Rdr0u3iE1C+YtFVk2nuezHVtFvR7tRvFQ+QO4DVkpI
	QeKoImZtl3/fIz8YLgs5e6O2vnCO5X391KDYNa/ozOtFM019ozDqm+IlLPi58MHFfkxGZinzeuh
	aRbXRkLhiqiutQT9uCrIod2K0TNmvVNvXYv29YN+jKQDtINTmL6rjA=
X-Received: by 2002:a05:620a:4415:b0:939:e71c:7740 with SMTP id af79cd13be357-93bdc4e42d6mr349294685a.0.1789739827329;
        Fri, 18 Sep 2026 06:57:07 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0e54ff3sm144885585a.9.2026.09.18.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:57:06 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:57:04 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, 
	osalvador@suse.de, hannes@cmpxchg.org, raghavendra.kt@amd.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] sched/numa: scan read-only file mappings in
 tiering mode
Message-ID: <aq1Cwh9hNw4wWEUP@gourry-fedora-PF4VCD3F>
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-4-gourry@gourry.net>
 <0ed3ab3a-80b4-492f-867a-0584441722a9@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ed3ab3a-80b4-492f-867a-0584441722a9@kernel.org>

On Fri, Sep 18, 2026 at 02:58:36PM +0200, David Hildenbrand (Arm) wrote:
> > +/*
> > + * Read-only file-backed mappings are expected to be cache replicated between
> > + * accessor nodes, so they are not worth sampling for placement.  They can
> > + * still strand on the slow tier like anything else.
> > + */
> > +static bool vma_is_ro_file(struct vm_area_struct *vma)
> > +{
> > +	return vma->vm_file && (vma->vm_flags & (VM_READ | VM_WRITE)) == VM_READ;
> 
> 
> MAP_PRIVATE can easily map a read-only file with write permissions. So the
> function name is a bit misleading.
> 
> This smells like a helper that should go next to other vma helpers and have
> clear semantics.
> 

No argument here.  Would like to balance improvement vs backportable
bugfix though.  I broke out the name to try to make it at least a bit
more readable.

> >  		if (!vma->vm_mm ||
> > -		    (vma->vm_file && (vma->vm_flags & (VM_READ|VM_WRITE)) == (VM_READ))) {
> > +		    (vma_is_ro_file(vma) &&
> > +		     !(numab_mode & NUMA_BALANCING_MEMORY_TIERING))) {
> 
> I'd vote for >80c here and but it into a singe line.
> 
> Or just use a magical helper
> 
> const bool tiering = numab_mode & NUMA_BALANCING_MEMORY_TIERING;
> 
> or sth like that.
> 

ack

> >  			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SHARED_RO);
> >  			continue;
> >  		}
> > @@ -4306,7 +4316,8 @@ static void task_numa_work(struct callback_head *work)
> >  			continue;
> >  		}
> >  
> > -		promo_only = !(numab_mode & NUMA_BALANCING_NORMAL);
> > +		promo_only = !(numab_mode & NUMA_BALANCING_NORMAL) ||
> > +			     vma_is_ro_file(vma);
> 
> As I said, maybe that flag could be voided.
> 

ack.
