Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793673207;
	b=ZJl7zMFdKMKHdPvZC/fIKPbxJ1Jz+fPm2W/1Ebv8rKPl5Y3Dw3ZQYrIbKbHZ+vteD9qS
	 5rli07/PL9ksLCqPPa1MO+uPwESTk6UH+yXiT8XoIIRur7aSBh3FsA1sBlKIg7CHChT4Z
	 j8TGfBwsX4o5tC1LFoUPEPja015mfQlrcVlCvQnLQ21hpP+JvxIgBqvMj40YFoIrPwBws
	 kGp2+y+NbFfv23fJED6wuKsiLq/bSGa3YDqJAAFAfbuiSw6VBxd3kdGgmsnz8tHIFQmGT
	 aYsc8fP1m52oVPs74aZj0qFG4kVJCafO0M4D6JOCbzRonR39pSryDOI3bTVu8h0b6Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673207;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=plPOmmg8Wbucg4dOntyZK89XdF19GIkTemSi8VnEEAM=;
	b=ax4SR02IZ6t5Wmu+k4E7JtoBoIxalSCk5e/7olCVJNw77jsiSeTCysaHs2WOYNocM31d
	 iIKxyROHbAdjKs8YtFHSmR1hJc5YNieSRahlxHCbsjs78+I7PLhiCgYjTF3Cl2/ITIps2
	 mEy4qqcoRI3G7/rPGoTgFzzFopK2L5Abpo+HMBTDcqXu/tccxL+eHN1belz7B7Zkb0EbL
	 bQcI7avUDpQLGtOYnBc5MyaC0hquRgsBPML942y2z1bjzesXYc26hbB2rAGR92CHoTuql
	 bMy33l5oNVBBgbV8CBt8sLjivNWCsbc9fa0xp4fzqefSBTuarvm3KneUp49GflZVtfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BgTIjVx8;
	arc=none smtp.remote-ip=91.218.175.229
Received: from mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A88606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 02:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30A88606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BgTIjVx8
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QEpd6a+5vyb7YKmH2HfXuDiiboBz4CjeIOL7fouBhLE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793673205; v=1; x=1794278005;
 b=BgTIjVx8nAsBtP3F1/GUXtMqw3pw4OJEPGpQ++uutFfQds3NbRcIfmcp3GNAGaLK7RPpjY/S
 yw/Uj5HTzpBk3eyf5tM9Jsqi8rj63sDupbOUjOGiN5/9gjgHzyT+vi9Zyr+9DoBdCp16aZJbRus
 vipK+BIW9Sgzd5Lh3Bd6yy9Q=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 09cae95fccecce83;
	Tue, 03 Nov 2026 02:33:24 +0000
X-Mizu-Trace-ID: 09cae95fccecce83
X-Migadu-Flow: FLOW_OUT
Date: Tue, 3 Nov 2026 10:33:19 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Barry Song <baohua@kernel.org>, kasong@tencent.com
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, muchun.song@linux.dev,
	ridong.chen@linux.dev, sj@kernel.org, hannes@cmpxchg.org,
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev,
	ljs@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, baolin.wang@linux.alibaba.com,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, kees@kernel.org,
	peterz@infradead.org, jannh@google.com, pfalcato@suse.de,
	hughd@google.com, pasha.tatashin@soleen.com, pratyush@kernel.org,
	willy@infradead.org, jack@suse.cz, ziy@nvidia.com, riel@surriel.com,
	harry@kernel.org, apopple@nvidia.com, nico.pache@linux.dev,
	ryan.roberts@arm.com, dev.jain@arm.com, usama.arif@linux.dev,
	kas@kernel.org, matthew.brost@intel.com, jhubbard@nvidia.com,
	peterx@redhat.com, will@kernel.org, aneesh.kumar@kernel.org,
	npiggin@gmail.com, osalvador@suse.de, minchan@kernel.org,
	xu.xin@linux.dev, chengming.zhou@linux.dev, chrisl@kernel.org,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, youngjun.park@lge.com,
	gourry@gourry.net, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	ying.huang@linux.alibaba.com, jgg@ziepe.ca, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, josef@toxicpanda.com,
	stable@vger.kernel.org, usama.anjum@arm.com
Subject: Re: [PATCH v2 01/47] mm/mglru: don't use stack pointers when walking
 PUD and PMD tables
Message-ID: <aulH7zeGrjIvF8Hs@fedora>
References: <6FACF8FF-F943-45C8-BDFD-3AFB5C060E0A@linux.dev>
 <20261031055838.60138-1-lance.yang@linux.dev>
 <a704d458-ad60-43bf-a0ce-3b128b218d88@kernel.org>
 <CAGsJ_4wjGjDoFPz3qWHqW8WTv31AkR_zrY14ON0dLbTZNsohWQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4wjGjDoFPz3qWHqW8WTv31AkR_zrY14ON0dLbTZNsohWQ@mail.gmail.com>

On 11/03/26 at 04:11am, Barry Song wrote:
> On Sat, Oct 31, 2026 at 5:42 PM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > On 10/31/26 06:58, Lance Yang wrote:
> > >
> > > On Sat, Oct 31, 2026 at 09:46:37AM +0800, Muchun Song wrote:
> > >>
> > >>
> > >>>
> > >>>
> > >>>
> > >>> Agreed. FWIW, I think Barry Song and Kairui Song would be good candidates
> > >>> for the maintainer role.
> > >>
> > >> +1
> > >>
> > >> It would be great if they could take this over.
> > >
> > > +1 from me too ;)
> > >
> > > They both have been really active on MGLRU and doing great work for quite
> > > a while. No doubt they'll continue to do so :D
> >
> > Fully agreed, we really need some people familiar with this code to help
> > maintain it, and Kairu and Barry have most experience on this.

Agree. Kairui and Barry have done so much to review and contribute
patches to MGLRU. The nomination is well deserved.

> 
> Thanks to Ridong, Muchun, Lance, and David for all the
> kind words. Your encouragement is truly inspiring!
> 
> >
> > Just a note that I also don't want to pressure into such a role (which comes
> > with responsibility).
> 
> It would be a great pleasure to work for the MGLRU
> community.
> 
> Over the past few months, we've seen many active
> contributors join the MGLRU effort. It feels like MGLRU
> has never been this popular. I'm really glad to see the
> community growing.
> 
> I may have missed someone, but besides Kairui and me, I'd
> like to mention Baoquan, Baolin, Hui Zhu, Ridong, Kunwu,
> Maxim, T.J., Siddharth, Xiang Liu, Bingfang Guo, Shakeel,
> Zicheng, and many others.

Thanks for the recognition, Barry. MGLRU has always been on my to-do
list, I will come back to catch up to review and post queued MGLRU
patches after my xswap patches are posted.

> 
> It's great to see so many people contributing to MGLRU!
> 
> Best,
> Barry
