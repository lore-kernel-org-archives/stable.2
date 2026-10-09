Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB134DD6C8
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550214; cv=none; b=sBQEvDUivKI4O5q2Mb+OeReugIIbejW+1zmvj8fK/ak2Fp3uk/3w9EN62CncUCZ92BNpElV29GL0llwCQsaV/X69+g6BThlS/UFhr6YZIkr+l8nNcdz/65g+BZj45i8fovV+sesYJQ5J1GcZg0X/ozVEsiPH0Shcq+u5TXEEnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550214; c=relaxed/simple;
	bh=Vm/Hck2b9bM9igyRdhUPr6w4WmDAa6R5TgT2R8RCzOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1KmiCK/MTUBzJte5imdDCmXnul3G4gD/euSVLUbUcthsU837rL+6+adnkm/WAcH8ZseR7q52ItTIQxE3YWSfwtVRo89kvpq6vyglzC8NrXrH4/m0Kjs650sMW7E2ZRMKjzvfPc/slRi+/kaoWNPjOseKVbN/hZ7HIFtcoEN1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=AwftwgVG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D+30l+Gc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="AwftwgVG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D+30l+Gc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 056531400126
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 08:50:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 09 Oct 2026 08:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1791550207; x=
	1791636607; bh=kwuLlWvseYD+74dMnCLktedh4fOzXytMC82OiOvL5ak=; b=A
	wftwgVGELghKG4AwtQpy25D1oTqdyYSv1F0iE+dqzNYbQyl8drsVqpsja9Im+iVr
	AlAGCfNLzubPKjjjirM+khSbXmAMkgYIMb/dzJHKWucl31BPU/nsDn5KPYA4sm3G
	5bBPb7qiEjKEgtAnEW0UjGL4EVmBxkXsc/xu8gBAVfSorI7FXGr/ZwDNQWCroUnF
	ZIAdcRy0utvee4Wr6ScPnWqd+/+KoIxCMwePu/J7/inVadWDuK7WZWXHn5q5Kuh0
	hZS3lmaVONsdtkoyZx0nu10kqz0gziTTlw/IBpGipzvfcN8BjiigjeKPf9Hf2igB
	yp+cxfYzic08UK2uVQDqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791550207; x=1791636607; bh=kwuLlWvseYD+74dMnCLktedh4fOzXytMC82
	OiOvL5ak=; b=D+30l+Gce/d3Zh4f+q8ngVvAcVDQhSfZgGub0mYOK7g3qJZXjpu
	V9MFsEObI4hcjX13BGYAQzUBVNtBrOTiq1vt5QhrC21YV1Z4tFxqxYURJ7QJphBA
	MRPCJLPoGvR4KXM+dNr/YyiEbWNWx7vjMxMiiDPU9cMpPQcaW/XM91AH9aime9RZ
	PJzUZwTM9Azf0JAJXiPQsJPuZ6qV+KZGops9PKV0FNnVefAoXl1VJgr2YG8PJhDC
	vLrFLohrezJ3+1GoSF1ExImvwoSjwVf/XsRyodsNZ+TXW3//uj4uKMlL8u5ZrJ6P
	YPCH9HbHf5XZ7vEv5UgUvPumZFUr+i7Y4vQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791550207; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:W6XP2x9zV1kdXzJxAhA7kGtfUXzPSvSDGI6P08VZfBiuJJP
	ZpOUt+jRwnTRa5EPQPIEztmHoxRn1aNSI/twro4fvztMEk5HCyB+nM72h/iqbaRW
	iPvvgji4lh1bZznXgvqAjxM21Ipj1w4ndTfiMQDob3HPvkYk8nA9/kG3NZ8GBxDj
	ayGeOclRoQjv23tgFdKqUK1IecJzatFjwUupQ5C3AoRlRshUg6Y94XKAJEkB02sc
	bcCKNyByTsyz9sK8Q711F/EghjBnKWDK4rLvAzwlZJmIsFAtedN8G0EdB8L5LGb0
	qFrKix5Se0hQk819Ew5kjw1zddHswdh5irVrJUw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dPwl2ptZ8KQ3KssmzCbccTofY//b/3Xh8ddybmaiLhI=:Vm/Hck2b9bM9igyRdhUPr6w4WmDAa6R5TgT2R8RCzOk=;
X-ME-Sender: <xms:_-LIaguEsuIEEDDbRjcyfdA_r5MOKD-R9ZuR5Ru7F_nrZcX07q3nsg>
    <xme:_-LIalMOTtzHnsFuJNTXMrLSt3nZuHG6xA8-v4ZCFon_i-fkYpUu7RNBhvhlFFvWi
    WOlB_4C9c-ruQbhJHELgDnziTE9WxQOsw2YlpgrG4206d8EVQIOG7g>
X-ME-Received: <xmr:_-LIaqXREAD42QT4nykwIDeMg-hS8YPOZOamHPFYr2Rn5hYIUH5jTKrfFuc>
X-ME-Proxy-Cause: dmFkZTERXjv5sRhphf2UpmNikN5/RjMZ9jdv2AoBQ3JcwuQkL+3XVeY6isvJ/I/LHHxVfn
    MKwVsK/+JLYhLu9ZrsWE8W0rCySsp2zlzECQxKGDnlMSG71Ip3pNKIKK2mocz6/wEaNrkF
    7TA6zmnT5XM08JHDewuy71GqykKz0AmDsneejn77fVdgbVpFO2viBVmYbl6T020Qj7ZyTs
    jtSROHjwQMvePCMcSRku+ZeCkxc2CraVCmn0F5I/pbfzaxI2d1NPkMZFfe4v45ILMJqBcK
    THyiEYkQbzTWWuGKgnbx2D9+yDexwl4Y8t54Nm+i0K06Hrd2I9AYEUu+LtwsAn8iy8tYQu
    /RER2RoYALbg+AEeDMuIcA7xo9Bw9oVDNBUt8GBTNQKHhiYyvGnE99BcPF4Z6H9Sqjl9TU
    SzfVqySmJTqUp+dvjCbTwthQ6ZdKtalOx/l8QeTNp5xFTmaFF1DVfNcvM3pyDPpb21Www6
    3R3slpGbiMqAzaIIRUsYMPRPNxuTaQWRtECOrTDRwaaq/Vk38K3WtX2Pghy4rw5doBSXNq
    E9pkEHFEX0nrwHiLAo6fFaNSULmknGZhmsHc3t4jTpHIwDKewXL9fimqBZTV9HK5kVaQnZ
    agMSisNVLgaNkf5hzfNCMymSL//IYqaAJA7B+GsF5DUsPdmLKl9qp6ZaY0Qg
X-ME-Proxy: <xmx:_-LIatiCMneJH0HIy2y9okd0sPi4VRQ0NWsj0kBcPJyK5DI8Z5iRnw>
    <xmx:_-LIak1x8Jw0mvKWmn4PraDfclGS4gfCfhVK0pwixN5v79DHp4BOpQ>
    <xmx:_-LIav10mlKaM1P9mVDFgzrLZsgdspP3VwVWh1v1YsKz6JffEdLcjA>
    <xmx:_-LIalxN4F1GFZFaV9wpQU6VAthEXluLxW7Z0gQLgg5iDh387ajG3w>
    <xmx:_-LIanXgaClIrAcoxotbckLmHIRKltUhrrAX1lztfmx10PQ3MqjKauD1>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 08:50:06 -0400 (EDT)
Date: Fri, 9 Oct 2026 13:50:05 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <asjivmGzSIqTzTXB@thinkstation>
References: <20261006091815.897133-1-kirill@shutemov.name>
 <20261007155316.2010164-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007155316.2010164-1-usama.arif@linux.dev>

On Wed, Oct 07, 2026 at 08:53:14AM -0700, Usama Arif wrote:
> >  @@ -5007,14 +5034,20 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >  	 * of free memory (see __compaction_suitable)
> >  	 */
> >  	if (did_some_progress > 0 && can_compact &&
> > -	    should_compact_retry(gfp_mask, ac, order, alloc_flags,
> > -				 compact_result, &compact_priority,
> > +	    should_compact_retry(gfp_mask, ac, order, reclaim_order,
> > +				 alloc_flags, compact_result, &compact_priority,
> >  				 &compaction_retries))
> >  		goto retry;
> >  
> > -	/* Reclaim/compaction failed to prevent the fallback */
> > +	/*
> > +	 * Reclaim/compaction failed to prevent the fallback. The retry
> > +	 * budget was spent on making blocks, not on the request itself;
> > +	 * give the fallback a fresh one before considering OOM.
> > +	 */
> >  	if (defrag_mode && (alloc_flags & ALLOC_NOFRAGMENT)) {
> >  		alloc_flags &= ~ALLOC_NOFRAGMENT;
> > +		no_progress_loops = 0;
> > +		compaction_retries = 0;
> 
> Should these counters be reset only when the work order was actually
> promoted?
> 
> For movable requests, and requests already at or above pageblock
> order, `reclaim_order == order`. Their retry budget was therefore
> spent on the request itself rather than on promoted pageblock
> production. Resetting the counters here can give those requests
> another 17 no-progress reclaim attempts, plus additional
> compaction-success retries, before OOM or allocation failure.
> 
> How about:
> 	if (reclaim_order != order) {
> 		no_progress_loops = 0;
> 		compaction_retries = 0;
> 	}
> 
> instead?

Fair enough.

A movable request only gets here after 16 rounds without progress at its
own order, so the reset would just delay the OOM kill.

Will restrict it to reclaim_order != order in v3.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
