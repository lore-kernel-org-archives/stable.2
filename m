Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97F6545DA8
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001064; cv=none; b=DezXe423KecEAgFg03ZXTdQHAEBZWI5/Pi/FPDZX7Wu17LKxquD4/5m1PsfIBSAJzTgKibaZkYOOvUdr2RvHKQYsWXq/MoCxp7ICqXyRHGid14a0QubB7mSfL3g1oI7tUY9J9V0ewCj0+dmiQQHLqVmxYyWWRsNMu8XFoL0iJLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001064; c=relaxed/simple;
	bh=4ZfibqtjyVHs6vICgBrtNWhVZNaukgTijrvi4R5y9Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGH7albGYPzFmbJBguV4lhkrBu+Gj1M5PGf//c75E6EZxA3hHyFWlyOPCWMCIxPwAdruP5mvF44S3kstv9KNWbze6lYiT4Xd1VtpUJEnLVa8ZOo7MKjD8Ebz1h/V6Iy3YTnwGYltaONJjlLAmQcX2PceUVWukhQ365GZf2aBa4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=dqSna4Ob; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="dqSna4Ob"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-823e4047037so3422382a34.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792001062; x=1792605862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sre2Q8d9osDFJ2pO/rFODA9M0mfR2oBhyc/Yo4XzZZQ=;
        b=dqSna4ObfE0OweD5yMSvF8FNwmzD6BnXgPiC+qXK8tHB9iOj693tqHvbFgHkD5PxFT
         GZ7LIZqs7P6en2S9uj3AbEmPqBArTLy2MXulzqPojQpm34B08r8cQx9e9DjBSeJY6xvu
         UsH3rUgiti9aCTfHRbUpi7woAKyOoe00OaVio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001062; x=1792605862;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sre2Q8d9osDFJ2pO/rFODA9M0mfR2oBhyc/Yo4XzZZQ=;
        b=wafd2xC58y8QGea/rfZZfAW1uMDyIuJiLvmblfGSY8CI5sg74cC4OHDbLDwf3L04jb
         xkTeliVSl99/Igjyp3CIJOQfRVPNp2342eHQrgi7iytAqW8nCHAcwpHtOPfu/S1mfPAm
         z0khVHwFs168MTw8Pq0MZeh4w0T+vtlU1mu1Y4CypDW5PwvSPGMJvZC0kB6iZvYnvNcU
         bVnjZaxVI6QqtdPV9CCxjF7xeqM3zFlkeFmp+JO2vhG4Oep5UrZJ7+Jfk3PH6JaM5wFu
         3V9ZAfOcKl/QWeJ3Abu+XvMChVSWcp6OqJgy2LlRIW+wj/N8RytviOeepOIT//J3OexM
         UKHg==
X-Forwarded-Encrypted: i=1; AKwUvBzQ67KN3V4ig0ooOEWnzXKv9zS3c3224UYbS1Z8TtXdGzZpHTGOh4EBR1QdRLwTxTZZZ2Yera8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/wkiuq86QxTrkbblaGtDhFuV9X8q1sBqAX45iYH5R7V7bEGtC
	Mc8Y6nZLEX3Q3jE8jjJ5X57rbLd/N36/x8d/2f2KLBuQXjDk453lc5tP4NvsqWOJvvM=
X-Gm-Gg: AYBFou1Z/3zYb4CQkWIcbX6oTO3qipDgi+ds2WlaeL4cPppqIUpfOCOPsNB3DTAYuCs
	keb1aeHK8FMkvu5aqrrQJkQTRB/EZ4phXwUSzVPHq5btPKt0R469f/OuWgro3Lx1RdWtwDY6A0t
	iDz5nqGtYfnWNxTyNhse66SN35acpZB6utWEe/HOZzXA2364V8No1HpPtgqa0XFYlEv4mik5cys
	CVYLylMRQCmSPSHQRMt9Dv1ffiEMlnMVVDkMS1Rky6scxByVzFzM9laQwuNfqFXOkuuOW+JdobU
	8RglKnYCs4dpN7MMKg6naBHF4PYF6hCJv67KicA4C4z0NiX4KTebYMvosQkcL/Or3JjZr9asdZz
	g4p2nierpg97mzyRotBnX2yFGplw4C7lmxg3sFwFjBd5jmijiMqEBre3uWIspv4z2+W1G1DE5K9
	bOoJlUX9AULDMKibdhXvCi8CrHPdxoco37cm20D8ekgugp8e1dk2v4ivMoWY2aXiBqNSX2YpU1W
	euVOulS+TBcvlfbzwEPmpW8tseE7U3qy5PIValsFGaRiFSvbht4GA==
X-Received: by 2002:a05:6830:6f8f:b0:821:8e71:1bb5 with SMTP id 46e09a7af769-830963f4818mr16941700a34.14.1792001062029;
        Wed, 14 Oct 2026 11:04:22 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039076dc3sm17027951a34.14.2026.10.14.11.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 11:04:21 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:04:17 -0700
From: Kyle Zeng <kylebot@openai.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	"Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: only allocate anon_vma in CoW mappings
Message-ID: <as_EIRMinCdl1zOx@com-75606>
References: <20261014-copy_hugetlb_page_range-v1-1-5b68e03fe7fe@kernel.org>
 <as99gyi-NUprRK6e@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as99gyi-NUprRK6e@gremlin>

On Wed, Oct 14, 2026 at 03:51:22PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Wed, Oct 14, 2026 at 01:53:11PM +0200, David Hildenbrand (Arm) wrote:
> > As uffd_lock_vma() is part of the same lookup machinery and
> > also contains a misleading VM_SHARED check, change that one as well
> > directly for consistency.
> 
> OK, I think that one isn't _strictly necessary_, but while we're there,
> worth doing too, clearly.
> 
> We should also go through and convert the remaining !VM_SHARED checks ->
> vma_is_cow_mapping() too if possible, but that's a follow up, obviously!
> 
> >
> > A follow-up cleanup will stop taking the hugetlb_vma_lock_read(src_vma)
> > lock in copy_hugetlb_page_range() entirely. Further, the usage of
> 
> Hmm really? Is it possible to do that without the hugetlb lock?
> 
> It'd be good in general if we could get rid of that lock as a whole :) but maybe
> dreaming.
> 
> > VM_SHARED in userfaultfd code should be cleaned up later to focus on
> > CoW vs. non-CoW mappings.
> 
> I think also anywhere else in the kernel where this is done. An audit on that in
> general would be useful!
> 
> >
> > Reported-by: Kyle Zeng <kylebot@openai.com>
> > Fixes: 867a43a34ff8a ("userfaultfd: use per-vma locks in userfaultfd operations")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> This LGTM, thanks for handling this!
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
> --
> Cheers, Lorenzo

I ran the patch through my system and did not find any issues with this
patch. Thanks for addressing this!

Reviewed-by: Kyle Zeng <kylebot@openai.com>
