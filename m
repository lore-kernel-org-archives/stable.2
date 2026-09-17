Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F564EFFBF
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661680; cv=none; b=K8lh0HVY2UZ/ZkJgzBUD908Gta7RekCJXcuVFzkADhDOF+74ObkHzrXINjpI7XmM8J1UZyTcE1kg1ioWLSIn4I5KBMszBBoi/+N3W5UK0tHuPZ0mM2UrMKSD3s2yLbZ0Kb+DsF4jIh5DBRjZCoeBJEXlpXkwgXWYA/8JSQtNmGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661680; c=relaxed/simple;
	bh=pOhqefWnGzuYlbjyx7H3ZVYADwMZhHbKtiJKYlJ4mlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9tFgwzBfFC0rzZO9XssBOA8eVxhK97tG/bto0wuuwsSe2JPDWGAIKJeovXeZDwFrMEfRRVv6XuW84pApJ822+SNTrY0z6NVA35uXLKpg6gqDA19zTe658JTa8f5avnb/FqU9QWXWqDKp80qyQDV+Ho3TGdfCQCK2qyzz+iir54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WefqSriu; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WefqSriu"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5311edbc154so8204321cf.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789661675; x=1790266475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LsJba/wwthkDPTXMKxwEUJe6vAc8xqzF49EUX8rDHcw=;
        b=WefqSriukiG4B9oYvpThXHNUj4QrByA6ymBkWoI89OSUkRLDslwjDxw+rDOZlV0TG/
         8VNSgeq4gNkkHGu8qsv7jnQWG3IY1/LteN8pLLzm5+fE7X3r9BZ4dGBx8h0JbTJbjUFq
         XLvK4NZaoDgaIQ1z9NFYd50+el3/os2cPOGTsfyCb989/wMk/+gDWv7nF20Bb2MGGEFG
         OaGP+wu6ltS+8BgHFMuLbtvnahl/1r8bSc4+eejidiLX8ngLKjuVRFlDDxEePheyb56H
         zBsjffG1yH2jbNrNXJ/8pDtVh1b5w21kd3KkvxdJ57JSddsSGBE2koUvun+ALSbsAznl
         SI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661675; x=1790266475;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LsJba/wwthkDPTXMKxwEUJe6vAc8xqzF49EUX8rDHcw=;
        b=GJUmbEUxFh3dd58h6f2TWoEGupcmAqGDsGAFUe4KtsyUHcNujbW6uYVSpLvmj4Ks6j
         +AeEuKToPqHZn1A2yv0iswaom+nMdGSkeeY8UuKM7JEeLSHxchUmK4DK71cSdY1dpF+K
         DU1If9urcY+0T/4dTzxTFh5Z2gVdKPMSvfowntJzifFHsHcH1pRkkKDbbE5IMnUjjTpE
         5JRpDCEUm3imGYzA0k/pLyMW0bj+TJtd2yOSLkZ5LVA9cJFjrYY8lGok4jEgc7ORSMSI
         uFUr3L/hUdz8yXU2U1DI+SrO2uQTqQkWQClo8y53WgVkKTthMM5nRnsYEc5jjwCHLtGk
         frNg==
X-Forwarded-Encrypted: i=1; AKwUvBx5EocA+GRFWo37g9mPpQ+kTXcnfmH6qSYHogPBxGiwKIy47Qerjayx1z+C6NemLdnXg4CMLrA=@vger.kernel.org
X-Gm-Message-State: AFuF++lM+G7Ejfq+prH/4wHErWfwlRPS4L447+d8VrdeKX0um35mqPml
	zz1GgvdUp0e3NMVopVD+xPgtWvIlz+b/+4zij1HaWUqPIVMNX09gxzctCmeCAlGVsHY=
X-Gm-Gg: AYBFou2AWRc90joWbgyo2+6oGAaOV1t9h2Lm2y52CkwlZWiyxEaZF6iPeTOMYGUWP2R
	ObRtP0PKR35eS7ch76IjLH0igX1rSPCp58ZTjTOZSD2XhXMJzNhu5bjD8bTWhzMUmzo6qS4m/2z
	gSCwjPFPhNwZL7XsJDMaqnWM/ne9RpDMf8dn1hNFUP/lJl5ZnnSQu2sSTqJOg7JtoMHWp6pShYY
	FjzDytufey32btDwrJGYQivl0l8yZpkHF0ciZnSPuax6LUklTDQiK/H8JCiAX6RrnDFVRjJaFvz
	Rtpzzp9XoqEiDqjP9Hfdvts3SIWRFKa0Es7lB1ZBPAIJE6x1w2Ye2Aa7I08aFFSirzyiXTgfrkG
	+Wo8xYfGPx7D0al3CvQa7iGVoe55ruxzCp4TORaolpU7izfH/1ocnuw7+MD6ZI7oWlX4uxvD+vL
	/Ccb/K4BerHFSf0y7TXimgi73K/yEXrzL9Ho1QJ+OabguYQgHfcQzURHXaEFb3Xpv14tSgZhqjq
	5snYTUx4pDOu+s1MPwB6xnd2q6joxYNHVEZeDnlRKz9LXKEEflUD1k=
X-Received: by 2002:a05:6214:e87:b0:912:517b:90a with SMTP id 6a1803df08f44-912517b0c9emr19817166d6.41.1789661675506;
        Thu, 17 Sep 2026 09:14:35 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252c7cb8bsm1199036d6.20.2026.09.17.09.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:14:34 -0700 (PDT)
Date: Thu, 17 Sep 2026 12:14:31 -0400
From: Gregory Price <gourry@gourry.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, 
	osalvador@suse.de, hannes@cmpxchg.org, raghavendra.kt@amd.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm: support promotion-only NUMA hinting scans
Message-ID: <aqwRX7Ula6ImRw3c@gourry-fedora-PF4VCD3F>
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-2-gourry@gourry.net>
 <20260917160328.GM4121339@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917160328.GM4121339@noisy.programming.kicks-ass.net>

On Thu, Sep 17, 2026 at 06:03:28PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 10, 2026 at 08:18:23PM -0400, Gregory Price wrote:
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8dff37059faf..81359b414947 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4129,8 +4129,10 @@ static void task_numa_work(struct callback_head *work)
> >  	unsigned long nr_pte_updates = 0;
> >  	long pages, virtpages;
> >  	struct vma_iterator vmi;
> > +	unsigned int numab_mode = READ_ONCE(sysctl_numa_balancing_mode);
> 
> This thing sticks out like a sort thumb, does that want to be on top?
> Typically reverse xmas is preferred and all that.
> 

oi yeah sorry, should have given this a closer style look.

will fix it up.

> >  	bool vma_pids_skipped;
> >  	bool vma_pids_forced = false;
> > +	bool promo_only;
> >  
> >  	WARN_ON_ONCE(p != container_of(work, struct task_struct, numa_work));
> >  
> 
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1237,11 +1237,12 @@ static inline bool vma_is_single_threaded_private(struct vm_area_struct *vma)
> >  
> >  #ifdef CONFIG_NUMA_BALANCING
> >  bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
> > -		bool is_private_single_threaded);
> > +		bool is_private_single_threaded, bool promo_only);
> 
> Two bools rather than updating the existing bool to a flags?

every time i've added a flag field someone screeches at me, so I tend
to avoid it now - but i can do that's the preference here.

Otherwise, i tend to follow rule of 3 for generalizing.

~Gregory
