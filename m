Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527622;
	b=oZzGgwpSH0U3rYanEC6i9/Ifhr5F9GtSanxS9fM0hNDGRmrEKaja4kcSz6sSpV9JdoEe
	 R3GmoV0VU4Andqm5ZBHldid2FYAkKUEQm0+Ble9+OPBOuTGZWfWCqozCtAJb7gOKpQ4j9
	 RRz7bUtczwvFb48RfHskAY0wg3XOAfLWNHW4/RB0uw8Dsd7QU2Yx2juV+fVmaXlsUJfmP
	 pxSHD8e9UEqO8d3ge4oWCm/osVwg+rBUsrQz1BoBtzJ+H9ag6ylHypA/XqZClGXNxXbjA
	 anLT9WerhgKzeIkF8hYIJRyASv5D3BVBOzlG9qtkgnbsRuU8pHZyKFX26ShdO2E/5Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=EPIXAJZkQDCcHbLvbKTfW5OnsdsgE9PbSQDDg/rz3K0=;
	b=5ErI8mYjZ6PcpCoVZiOK2hwohRNJv250eXTKJOtwVzePOPAfmvpCZ5xchPEIHKoVHsUu
	 sb9lr+ILA2hgxN3P4rdmMxFFkA+1MFBP0CHnr79vSTA290RJWZmkR5tMuUgPTG8mzAxum
	 32FmncfQ5K6CPFwjk3tmaaIYrGfJ3U58K2JJzKuz7cXwklx3H9b3Kuol4t22+RWC+kQ6N
	 KcXPYuhL/Os9H4zSn7mKyuX3pZhU5gFvrXWFt3E+igKRlfIdNNdQWd7QMH6uix56o8R5m
	 rQtInQ7bBw69KOZyPp9xYDLkFNDVe9wnWL9cyJ04NQeqZzmLKgoXg5Afr+zngOw5j8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=bOuwAPAt;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ECF606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55ECF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=bOuwAPAt
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53394bffe0fso10809861cf.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792527620; x=1793132420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EPIXAJZkQDCcHbLvbKTfW5OnsdsgE9PbSQDDg/rz3K0=;
        b=bOuwAPAtKcczF949cnW6uJfDZ/2l/cCmLn+ov2hnEvuK9ipVEuATvir0+R/tI61RoB
         soOQIQDSpc3SvMKXxS/62liN3mKS5xrLoX+NQXjFs9mJhAUUiEyRtHMoWFNLbtO2yAif
         w6RHxusWHz//MD+hoAClMBf+j1tog7m3yLj7ovK1LrQUyrJj7BmY6AVPyqvxVunjQWOJ
         b7hztBmvXapUs26J3IJ4uwI9xOQALKLEgGzQCHa/FxZZjs/TBQrdMWJmEXx5z97AxC4b
         EvR3hnWVutU1HEBTIyUaUPKVr7sjKRa1Zlwr9/ch5CIhG7QFeHShwPbNoAorRWtF630E
         gdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792527620; x=1793132420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EPIXAJZkQDCcHbLvbKTfW5OnsdsgE9PbSQDDg/rz3K0=;
        b=AEL6PodRL6cYP2GYiCFUiTaTXptEFtdfJ8G5AG8VfMbsqeESMkPUCVMN/xxbu9KXAn
         Inz80PrKrgIeAviP6P5W3M9BVtZl6buYz+B7j8FAvueJTpoQLucAwfEaNOX2aCOB64VW
         +kI5BepB6F/0yI7ykJoAbPvS0V/tv1V0PH2sRvfWdDU9RALE430P+Rb1fhEsT5xS3qa1
         xwCCL/xShuf7BQ/fdwM+XmvyMhZNahcJYs7ebRI5UygKZOMDRfGmp2TVY/CzgQv5mooh
         YHoqJ0j8DFwG/100SeHZLn8c96554J1EUaFujIX9NMR4AcDo8YqtV6QtsCWJ7Q+lwQ1f
         TQCg==
X-Forwarded-Encrypted: i=1; AKwUvBzHhhs/xnGdJTGlSMIs+gE4HXocl5X5nxnkP86BQTyq2Tj3DaZd+zO/ltqWxrJ00bNj/D9G0Xs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmQf5Sauy3W64qqkSSKWD3QHR2HqAgTiQJXMFd+nWBpdi6WGaS
	E/a8k6GJ5k2QpB0Xddpp6US26ryPfdd9sei4bZpfuQ53Q7kC6GZRRCP0nkn90/uq2KI=
X-Gm-Gg: AYBFou07pLsLCHZXlCEgu6jv/PGESateg8AkhpqPg+sZo6JTff7QKMAiminqkNX12Ut
	gi4DtoGHFoXVSqsm8rAwEC0E9zHr3ibIwXuBtE3p4CGOqoKsJQ4OPmsZLJSSMY/vIksECtlEjkb
	bmjpDJKhlP2RXmOXXd4BKmhiYO0B1pCWyLl9YSBa15WvstoB7+Y0vJtrAl0kokxDKccwANavu0V
	5fjHqwC8GdGxJa13fREJviQPC/RlSuuRWyvSu21kfGyuqbCHQZCH651KU4qxnnDtedws48C1tzB
	ZjvtNHOQ5zNp0zc5H8GLAnJiyK6Qme3p20ucqmBcGXOv2B4nfMCprMyZTA1bb1uiIc5wLCnMc5O
	3R/Ro0975QEwMI/A5rsUKTSgGJMPIZvcwczxfUJlXC4wfKcd5Tarm4kovcm4AcIahW7JVsC0JOg
	h1TklAo2UehFMWvshIgDKermJH5CZTQWok+y2GskT7p4CPM9dD8PaezTvJfN83Xxbwj7KlvzJvS
	ZgKXOgwNqKwYmBze1y4+bUS3xrB6rZMnVPHwZH2RFvqqhNMs2QeXA26ASHMKQeEtA==
X-Received: by 2002:a05:620a:44c1:b0:93e:c173:f690 with SMTP id af79cd13be357-93f57fa664amr59174285a.36.1792527620137;
        Tue, 20 Oct 2026 13:20:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e30610sm68153885a.43.2026.10.20.13.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:20:19 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:20:17 -0400
From: Gregory Price <gourry@gourry.net>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev, 
	hannes@cmpxchg.org, ziy@nvidia.com, mgorman@techsingularity.net, 
	jiang.liu@huawei.com, Bessel.Wang@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mm/page_alloc: validate zonelist slots against
 concurrent rebuilds
Message-ID: <atfLxfuFm-c8pKnP@gourry-fedora-PF4VCD3F>
References: <20261019172346.3344005-1-gourry@gourry.net>
 <20261019172346.3344005-3-gourry@gourry.net>
 <45ef34c7-eea5-4813-b54f-3e34675697b5@kernel.org>
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
In-Reply-To: <45ef34c7-eea5-4813-b54f-3e34675697b5@kernel.org>

On Tue, Oct 20, 2026 at 05:22:11PM +0200, Vlastimil Babka (SUSE) wrote:
> On 10/19/26 19:23, Gregory Price (Meta) wrote:
> > Onlining the first block of a zone rebuilds every zonelist in place,
> > shifting the slots after the new zone. An in-flight walk can use a
> > zone it previously filtered. e.g.:
> >   - a GFP_KERNEL request can land in ZONE_MOVABLE,
> >   - a node not in the nodemask can have its zones selected.
> > 
> > With kprobes holding the walk across the online, I was able to get this
> > zone/node misplacement to happen consistently across hotplug events.
> > 
> > The iterator approves a slot by its zone index and node, and the
> > allocator then loads the zone pointer from the slot again:
> > 
> >   CPU 0                             CPU 1
> >   first_zones_zonelist(nodemask {1})
> >     slot 0 (NORMAL1) approved
> >                                     online_pages()
> >                                       build_all_zonelists()
> >                                         [NORMAL1, NORMAL2, ...]
> >                                         -> [MOVABLE1, NORMAL1, ...]
> >   get_page_from_freelist()
> >     zone = zonelist_zone(slot 0)    /* MOVABLE1 */
> 
> Since the zonelist_zone_valid() checks you're adding happen before the
> "zone = zonelist_zone(slot 0)" part, I don't understand how they can be
> helping here. Aren't we just reapproving slot 0 when CPU 1 can mess it up
> between that reapproval and load? Am I missing something?
>

Heh, see patch 3.

patch 2 and 3 should probably be re-ordered, or maybe just squashed
together?

~Gregory
