Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4DE518148
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749521; cv=none; b=qbKY1liSp3WISb3Rskdmt9aEiF8Ql+3POaQXDIX6gTYrngNDZHEycR4Z1QQAhlQFa2DPeSPnBs/NUgJ3Js2B61KXGdYQI2P3eW/DbBD/uHecKzreJJiQN49ncWrphRaIW9ocLjvMPs2JJLb8hBRaXIPzO0LGJAexdk3aTyvIaBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749521; c=relaxed/simple;
	bh=KRGC9wawDzgkbiMY0zM6hzk3Dv8DE+14/bvdz6PWn+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2cZIfA7vXkUWu5CYCCrmpgk/0nzXRSZzsvfjDsGaibEJy2LeCgbEPXCqvIdKv7IHkyHOUXcl/LKHdzucjQfDBcyq8nn8u1K2VxVNmYxvfYFxYOH06ywFjjDKVKydS3L1hCXq0HNtwhevlxvKgOX8ZR6BsajrL1tE8oyGtJkWwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WLmkjs16; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WLmkjs16"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a2a8c29c4so101489785a.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789749519; x=1790354319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ycexu/7p8mN/PXe2TLXJ60lA5nKStrY7x+9HFkGFF0w=;
        b=WLmkjs163rP9Bg1OExrPB1CtCIYmhMJ9/fjIKpUnCYQstCqG/1SqPPqdeigyS4tDZi
         QxsKbkhBp46DGzEdDKqoV7iN/kexse/+xwpFMgrnwaB9+Qq1hVyM4Kr6NtDifLgKNCbK
         7zyk669rxLXO86tva/GdN6tmk5o2uYlAGgLecK19sFpbJ4EsO1nbzEiXjF/dxBvGRq3z
         C5miYXTBwrOBuQb9YI2HCABIZmhUzxFo3XQnyYDkfVs/hILExUPnh3mv685sLOxYaxx7
         396BYIkrZcYSqwm9sUA1kTR4RrONNen58epVGojhh7sEaJf0uiPs8HPE+yXrYO94pWc2
         haZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789749519; x=1790354319;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ycexu/7p8mN/PXe2TLXJ60lA5nKStrY7x+9HFkGFF0w=;
        b=1xEH/xfGG3ze5xa3B62AfamLKvQN+Q1KKNZiUQU7gcf3/ou34oy0Kyc1BXdqmmnB3p
         q1CKhi8QMwx8+8QGc8BYaTFugcyWdRdaQjoJF/CYEABr+1RbwsqL3UqsN/tT2olyZYY8
         kbps8It+9eJGNSla4PKmKuMe9iRAW7lgKItfHpqZyYj2FoU6tbR6DdaOo8eqCCIjb2gp
         8t5ULJ3p1xNKs3Xr1nezjbciPn2jeb8zGNsl+RBordCABUxgQeEVHoS0HSmt75RIq0cb
         LiV2u1MJaHcM+CeTDPnp1lEYHdhPhJZ0mjJ4eIJJLEa83SIWJ1JXPQyEH627FAKWxaLn
         b4Eg==
X-Forwarded-Encrypted: i=1; AKwUvBwto1TizXz60qBzwz6Xy8H4ryYo8c9B8AAqXhZ5MciK/yCLZnq1n+87AsxHPSPtLPiXJRUkTEg=@vger.kernel.org
X-Gm-Message-State: AFuF++miYxgWbc90Dqi+oUOk9QnX2J1AbcRFnAAj3HtgEvWlIKQS/Xhd
	W+BxjPPongyclbDwam4eYKRCyUQj9QW64usJQWnhl5hTj5FW4yj5AwwWEbNniU40pXU=
X-Gm-Gg: AYBFou0Z6P+Y2p5EvgnVlJT/zG4c+2VOCIfQsgqzm1eBJkgkYQVm09v+1mfP47Fz2TB
	nYgyuvqsMC8PpA3XcNHF3XddD+jUZTIa4ML1BWOPwpzY48NOtx3K81wZH+rDRcOx5hicA7aNO4j
	mFgfF4Sc4dWDFKk30xsXAylvSkGtO1BBv+mb7l4e7oO5WZjNntxSMJd8I4j5XrinQreSzkB12ss
	kGrrTi/Q2Ab+Y1Q2becYQCmk2hA1+upn+hxgz1FTi1EyKWHrcRAq+8qrzA9RDtVU59L7CIbPx5R
	px1ryLSAwlGKdsHfGsl6lKRGA7sG6Z67sDobEgj/m67kjR5kysYKNRRglkDctbd9LwLledcSj5Y
	RTs4vwITki14ik+pKVcu3i9HqmVbSx+J94yH1njEVu8tEAsW6DdWcSVJKLmQ6DJgP9LkWKerqXF
	C+8WJHQvV3RoBcITNwx8rXHaw2iBw/s6lm5ugQh+Rnfk9wU0tQDBRGvhCj+vPVJBVzZpbT0mG0Q
	Kc2+0cb3sTBIWQorcqojF9v8ShebXVkFZ40X6+Ty171rwVmFSx+e9A=
X-Received: by 2002:a05:620a:17a3:b0:93b:d7a2:83c8 with SMTP id af79cd13be357-93bdc8c69f5mr461480685a.55.1789749519034;
        Fri, 18 Sep 2026 09:38:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0e90276sm176813285a.21.2026.09.18.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:38:38 -0700 (PDT)
Date: Fri, 18 Sep 2026 12:38:36 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, kas@kernel.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, osalvador@suse.de, 
	hannes@cmpxchg.org, raghavendra.kt@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] sched/numa: scan read-only file mappings in
 tiering mode
Message-ID: <aq1o3TYZR9JNkXXP@gourry-fedora-PF4VCD3F>
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-4-gourry@gourry.net>
 <0ed3ab3a-80b4-492f-867a-0584441722a9@kernel.org>
 <aq1Cwh9hNw4wWEUP@gourry-fedora-PF4VCD3F>
 <c445a20c-ae83-4571-ae97-031ce7facc45@kernel.org>
 <aq1FDhy00epXXtgd@gremlin>
 <aq1ZUTgLQfLBxn80@gourry-fedora-PF4VCD3F>
 <aq1inYWiNWtZlyoo@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq1inYWiNWtZlyoo@gremlin>

On Fri, Sep 18, 2026 at 05:19:31PM +0100, Lorenzo Stoakes (ARM) wrote:
> >
> > Can you at least propose a patch on top that adds the cleanup you
> > suggest? Much of the VMA stuff is lost on me because I haven't had
> > the time to sit down and consume the novel.
> 
> What, literally writing the function for you wasn't enough? ;)
> 
> I can follow up on it _myself_ if you like + you nag me to (hard to keep
> track of things...) good enough? ;)
> 

Sorry i got a bit triggered by "If you check out my 40 patch series" :P

give me the weekend, i'll see what i can clean up

~Gregory
