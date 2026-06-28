Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1015EEC0
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782606687; cv=none; b=PLIRtb4kXYXZT1WHafTa/+Q3gPYACVl7geGGP3UNJjOrOXUCSglq+6uyV2FGx5N5E3YQIZiHr/JSGZl8guhqO3vf269YA+r7v/6bf6PwgBG2Wil0fVZzU156kSbhS28OnLIE+gPE0h/3hk0nA/jeLUKJrYLWQLvatAdlyf5l/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782606687; c=relaxed/simple;
	bh=s+Y9WU5DlLmpv9cAOgVfG446Lpq8V5LIwHPuEJ5FUkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX75hshBU9tpj7Rnl19iRDYNHL2lFfXILDs0BPH2TpIbQn0Gc7fsseGVOGfSUUlvHx8C5jcLeFoqqtX9nq6uwjaCPJ/VaVvRXZuwItKOg9Oz9c73zXzNJpZ3G9O/Vd5tkwzZ7J0DmCo3DqYO/sPNvKQTGzb9a7XlKHiJQQezLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=awWgUufr; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="awWgUufr"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9217d13c276so163560885a.1
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 17:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782606685; x=1783211485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkN+srl6wjGtNu7iwo0FYJ4HSQUHdkfF1SLjXCC02H4=;
        b=awWgUufrjZ7rMswnM+3waZLxOEPEGf9h4MGeLZ732IDx/hoxL8hBL0L/S6ssH+UeKq
         3ESUQ2s5gRUqkVSDxaxxBQC/2zAQcKy5XtSnVHuED/T+1nGuGbtdBpHlL1Z92uQeS4jn
         eXRlBsJ//AOWfjZL0ZXc0zeb+5g/UnNoyp2Ko8UI9xlmLHs7mgPgJFbbEs6oeBM/JOvF
         nphmdGct+eNkPvhnBAbAE4YHNqPr97OMxL5TYrli2bx57cmV0+C9fUr7znorPYjuuNrb
         ZfuWGtkzXd2cfRpTN4kGmpbV0aBCQ+IKtyaFYUgkeZIu59wa2H7PiRMXrkPRtNIJwzqL
         kApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782606685; x=1783211485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkN+srl6wjGtNu7iwo0FYJ4HSQUHdkfF1SLjXCC02H4=;
        b=glcIYEgjzy74lPCTH1ebGeg2F3BdF6zBxNkO3Sz5112eGzDzB3evXST17CS90j2Fk5
         jd5d9VudYCNVXkvLWv1ttu7tYOB2kahON+M0BvOe+R1x2Di7fMAOIH1vy8qsCcSVzu5Q
         VXZCNJa04S+aZ2/xVnjwkKJrSsiqoFgVYzIyRdu4jRT2v9betoxrmpJlqcjx8MP04JB2
         2CloSbTkMBQsHZyc8Jy323Py8F0TulTpWKs83emd+tgZmBAdoQgEfFTjV1BgJZeG9vxy
         G3T7S5s3YIRTBMTKqgZ5h8Iavvt/OZwfpIZh2UlMGHMAeWajKYuN3DTMxiU2QHoEPulM
         XHpw==
X-Forwarded-Encrypted: i=1; AFNElJ/G1sNDWJVfmZMnzOyVFflYfHxMXOmvbMwGE66Dq0j3ou59s3TC1HhrzKpml9XgRwg3TKUAiyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWuWZrDqhNjuZGpubK6SxTp0NKLutXGpd35KDW2yLu5ajqCX3w
	2hhoRPfqK3A2aq/C1h0Oi1f1c44pnA83EHF1tJXeMlw18jYwPT9b8KCajBw2DIydfp8=
X-Gm-Gg: AfdE7cnS6j+XZE8f2pCbu/IANJQgRsHwQEI3GHbNGR/h9nrAjXc3bPPaFnVmPBJZK7I
	kJYXMJho3CWBYh5e31xBpcpu5vyvupHQsN4lUx9wT7UHWUuDXxfjUGAFhVGQ2iqhl/ewYOkrk1p
	jx1VtUV3XRLc5xpgj4tV2KRdT4QVVlBCntlqeIwQDuIxJytPXXABvj7pRQTajhdxc+iqUEL9seg
	MZuR9rt1+z8bNVcJGjIDa9nZtQBV8wIWZMFasLznd06tJbMH5jvKZoOPxyY9VCEvtYWj4K//aPX
	OHRvnlnNf18qaxsP1WyeAuO9LmJXYVVpgzzXCvOb7/sUk4MP2T7/CVAk8FWLCQHbI/KtOn3AbTt
	Wki9i/iNDX4SmwPwCwOqv4T/Mi+4MmHyOFQI9BxGr8av5Dm3vISgtVcYUok7P0BzEMRawttwSL/
	XKgZaLoKkMYUNfAxLnM1XFGDpMr8Z+cQuHWq1lEA5H0pAGVGPV45OIaAwOn5OCXYBErcHv
X-Received: by 2002:a05:620a:2b90:b0:915:7fe4:cac5 with SMTP id af79cd13be357-92b3e96cd68mr914439085a.49.1782606684710;
        Sat, 27 Jun 2026 17:31:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c31b4sm1637191585a.23.2026.06.27.17.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:31:24 -0700 (PDT)
Date: Sat, 27 Jun 2026 20:31:18 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rppt@kernel.org, vbabka@kernel.org, mgorman@techsingularity.net,
	hannes@cmpxchg.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmstat: fold stranded per-cpu node stats when a
 node comes online
Message-ID: <akBrVoku9tKstb9n@gourry-fedora-PF4VCD3F>
References: <20260627202243.758289-1-gourry@gourry.net>
 <20260627161007.81e4533ce561c2951a69f927@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627161007.81e4533ce561c2951a69f927@linux-foundation.org>

On Sat, Jun 27, 2026 at 04:10:07PM -0700, Andrew Morton wrote:
> 
> > The existing code zeroes the per-cpu counters and causes a permanent
> > skew. Fold the stranded deltas instead, before the node rejoins the
> > online set. The node is not online yet and the hotplug lock is held,
> > so the remote access to per-cpu values is safe.
> 
> Oh.  Shouldn't we be doing this during offlining?
>

I tried this first.  I was unable to convince myself there was a 
safe way to accomplish this.

1) sashiko pointed out we can't schedule_on_each_cpu while holding
   the hotplug lock because we'll re-take cpus_read_lock and cause
   a deadlock condition with cpu-hotplug.

2) I'm not sure we can do it after the hotplug lock as been dropped,
   at least not safely.  At the very least another hot-plug re-adding
   the node could start.  That just seemed like a bad path.

3) foreign cpu access to the per-cpu values are not atomic with
   respect to in-flight folds on the target cpu.  this_cpu_xchg
   and this_cpu_add are (i believe) only atomic wrt the cpu itself
   (can't be interrupted mid-exchange).

doing it before node_offline() has problems (in-flight folds),
doing it after node_offline() still *technically* carries the same
in-flight fold risk - just narrower (fold has to have started already).

I couldn't convince myself there wasn't still a race, so here we are.

> > +	for_each_possible_cpu(cpu) {
> 
> That's a lot of CPUs
> 

Unfortunately - cpus may have gone offline while the node was offline,
so we legitimately have to visit every *possible* cpu :[

> > +		struct per_cpu_nodestat *p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> >  
> > -		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> > +		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> 
> and that's a lot of items.

I am aware :[.  I suppose we could vectorize the collection here on some
archs, but I try to avoid being clever where I can.

> 
> I guess the overall loop count won't be large enough to cause issues,
> but it's large!
> 
> Perhaps there's some simple test we can do on the per_cpu_nodestat to
> avoid the inner loop?  Perhaps might need to add a field for this?

Hadn't considered this, but maybe.  Will take a look.

> 
> btw, "for(int i..." is allowed nowadays.  It'll make this code nicer, IMO.
> 

aye aye o7

> And... Sashiko seems to have found a pre-existing issue:
> 	https://sashiko.dev/#/patchset/20260627202243.758289-1-gourry@gourry.net
> 

Will take a look, thanks!

~Gregory
