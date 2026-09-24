Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD11372045
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258830; cv=none; b=Ts6py70GthMHs86AYLPLlzav+ex02vivOEgX95rU1pwqcaI8c6t9ie4wl+wWiWzdI7plcZK9zhdnrVVYf/ijsJuSeeu6IwBZzii106Nmy542t2uJLfc9JLLHOAggYq34fEdUihbIboGwlXq5nLCV+hVap4m2AURzlx9Z/qWCesc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258830; c=relaxed/simple;
	bh=8tYi0WAgjaIJKipC9deR0xFZyoQuyzFMvHZ4foYg+RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc+HxoTXsaJMcHKuzqLJDfNBlm3/4DAp3DzylLbULuPrE30Ukynfp/8EXc010/Wi5yJmoAOgiRgl7hmQAluBFywKkZI/3KOT1URlNIh4BsbkgwK9pXBB2/rRdH62WjnVe/GmDsOQ9r2pnQB/atyBlTLCvMKJJFVhbDymUrAXy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dcimGur3; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dcimGur3"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530d0d5ae11so20496621cf.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790258828; x=1790863628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ztBx4OPk6JOhZIQ7ImRBBL50CNHJh8elF9MxANZMVE=;
        b=dcimGur3kPV9EKM93rmL3TDcB5EE3EPswfpDMtbdZfH/MJnWsv7KWDImHpNRV1IF1C
         MTO5Cxdmxz8kw0VfY35H23Ca6QrzCWq/g5iBRE1DpOgIiRoFlONvQqppJcc+WCuNZcJZ
         ZtER8+1tUg+FY3Hbb0SfX59ElhBp1WRBguMmZYx5oDM83S8iuDGSJAwyao4VuoVjdEXC
         l06IZQyua43U5iABwOmcOnIHHG/v2RFll0PSgaKT+0hYQ3TWJWkfyCFtnwQjliSDo7zd
         OgY7LmaJ48q+Hj5Z22OGyVRCVNI7Z7zdxKJjObVfd/4NnasrJ7CLKuAhuKr9ZP6zIBnt
         Flhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258828; x=1790863628;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ztBx4OPk6JOhZIQ7ImRBBL50CNHJh8elF9MxANZMVE=;
        b=tRw9v1q07I2s1xHT8tPKwBGe+fNXifjqJXoqd+5MLhKQPo2DAYQhtbrckn+xlHR9/F
         uWG+xmX+EKXH4PuZKc1EEoob2LLVmFINn1RJXDS5Xq4I+o51zMDKWvQeU/1qTJHV598i
         aIcV99g1f4S9qjADO4lqTt6k/gH6Clnxd5sXbuo25cviYhX6oE5vPk5U4RCy0mf/bLw2
         luholiWixKC6qfpP5zOL2eqTaj7KARfoGKKWlFJZW5mCSFY3Su8cF7LEC3/RTwPCyzpV
         w2iUChSu8xwpTjFq9G9emRd+aIHFBw3KcxmFuAoAoJ09sa9I55m5D0kUwm3aGu59VICD
         sIqw==
X-Forwarded-Encrypted: i=1; AKwUvBwigX7Jzb4i/h9WFs8DqDj9RvCq4kHpCW1z1gl5/tKDaWSo5RMLJOdoC7Mi4eW8IRXH0y3J4u0=@vger.kernel.org
X-Gm-Message-State: AFuF++m3CHt+mxRAVcoTapaP3MYfSdXLxBewav9koXjadalfHwL2cXvk
	eliWlPA4CyXgoxoMKT75mW27jlcNy0vSxqJx86xKGNVYdLHZz4f51wEj4cTnvAdkEpA=
X-Gm-Gg: AYBFou0icca2yZwQMmXyWqyzI4I13McGLjwUfEq52ESzbt/B+3QKXfNcJDyUtXnZtgo
	8JoiMz9Aby+MngXayVB/75jhjjpzIR0hCce8J33nMG9okOyy+2gXlXrKuO4jCiu6Z5oBsiS4k+9
	aiYLN+POGVK4WUMA1qnX63RB7s3vLpbB1qvpEXpmCa9eqECi06cO+L73zjOAf11n3cE3OWl4n18
	JhkXw2I2pn/5d1JmS2v3vFNeu90P0b9mpsk+EJQBvyXFCj0TQlY3ghDLjSLYTZ5ekoET8dNHWhh
	cRgsPNkvbKNloE9NeXkpY5b252buaZg1PdVWrPb1mE3QAcb6bQuAEQdOGw9PRyby8uDQwDNF7fg
	U+d6KP3OG7vpynlqtUmUMZBJ1YY4pY9fJxHMV/L7CjpMR7kLt4QFo6LHiIi+JTNwymEWfkKDvZT
	0kbY5ko3vwYQtQPLdgZ4W+EY2bQSnYMeBVzhaMY77C2oSYgVHeKFniuTJqP9QvpMEHVeXrKOpEt
	EytsgyK2GsnC7GfXZM+h515FzWyvKGhmRMVb3Bs/Snqp1vLIjA4tew=
X-Received: by 2002:a05:622a:1f8f:b0:532:bda6:a48b with SMTP id d75a77b69052e-532fea0a65cmr25291591cf.12.1790258828027;
        Thu, 24 Sep 2026 07:07:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eaec185esm43147051cf.3.2026.09.24.07.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:07:07 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:07:05 -0400
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
	hannes@cmpxchg.org, shy828301@gmail.com, raghavendra.kt@amd.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/7] mm: allow shared folios to be promoted to a fast
 tier
Message-ID: <arUtcPIw_FaUSPv4@gourry-fedora-PF4VCD3F>
References: <20260922182928.2199090-1-gourry@gourry.net>
 <20260922182928.2199090-3-gourry@gourry.net>
 <f0cd5c54-deca-42e7-bc85-1838dfa917f3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0cd5c54-deca-42e7-bc85-1838dfa917f3@kernel.org>

On Thu, Sep 24, 2026 at 01:59:15PM +0200, David Hildenbrand (Arm) wrote:
> I wonder if a better name would just make the comment above (about memory
> tiering) implicit and make more sense of the sysctl_numa_balancing_mode &
> NUMA_BALANCING_MEMORY_TIERING) check.
> 
> 	folio_promotable()
> 
> 	folio_is_promotable()
> 
> 	folio_numa_promotable()
>
> etc.
> 
> because that seems to be what we really test with both things combined.
>

maybe:  folio_numab_promotable() ?

> > -		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
> > +		if ((vma->vm_flags & VM_EXEC) &&
> > +		    folio_maybe_mapped_shared(folio) &&
> > +		    (!folio_in_lowtier(folio) || !node_is_toptier(node)))
> >  			return -EACCES;
> >  
> >  		/*
> 
> Sashiko has some comment about anonymous shared COW folios. I think it has a
> point, but didn't look too closely.
>

its tl;dr:

`skipping this check means those folios could end up freely migrating east-west
 between slow tiers`

Which cannot happen (we only migrate to top tier, numab will never
migrate *to* a slow tier).

basically false-positive

~Gregory
