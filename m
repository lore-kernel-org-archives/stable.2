Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653CF23BCED;
	Wed, 26 Aug 2026 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787742275; cv=none; b=tnV6XA2gVQueSzNhngx18LIGV3CBxWk57X4rGLdUyQEMQubbo0reQrp31AspHg+mBfyVQAGIx8k8B+5GHb7APKPuuawoU8yH5nzAOAbVD+zs7eBNvHJakidIrVeGFeRzRTfvmxsmohgH0xcweJE6ZSOsRNUW2xD8lrkvWUTAFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787742275; c=relaxed/simple;
	bh=0t+7/e3oqGqmDt1r1bHIZ7l8ibPqxkX9cD03J04DFG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/kDELBd/2tXY5S/sWWT33DE2JcyWwFEuJtAlNNUu7qjw7dptTYA6K1RsVLe/Ljha50mPF5ibmxvXTYKlMFPmdGt565PhX4YPmJeEmUjveO4Rqg+0SvQxyBvi2tz7jZPlNNRw22K/urJ1jpm7Ah9i2LcqTHZbsCW+quUOHKqWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZrL8Cym; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZrL8Cym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E301F000E9;
	Wed, 26 Aug 2026 11:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787742267;
	bh=uBmI5fOjIx+W9VbSYdym76cV4ZkOfJL66crn6l8h18I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bZrL8Cym9mcGQkJcKIk7xOUgiBjZIJX94P+HYk4/+Y98Rcj+dtnsz2aAJKHXYSjcP
	 crRdTnHRa+gDVBDG32Gh8c2MqG8su06iqxXVIfZLr+asmvfVqRc5Rl+QiazfLF3ib7
	 5mnAvpmPaYX75J1rq0YD+FW3QYIO9xsMzeQq3b/J8u/OZYHujlTzEU0QbtWhIl2nKe
	 MSEgzBWAyJp6Uw3/tBOXmG3KDJwf5OkuOjD040J2mhSCdB9CPGxUbINA5LTqwVkhpq
	 Gaegv6rmFp9/gxAZuGvCw3YBo28aoTkAxX9IQaOZ27ytBKyrVfd+vufJEaGNnUzhXW
	 TIILx9bal2q6A==
Date: Wed, 26 Aug 2026 12:04:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	akpm@linux-foundation.org, nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, zokeefe@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v3 1/3] mm: khugepaged: fix swap entry value to
 folio_pfn()
Message-ID: <ao7IG-tK1NY5n9ac@gremlin>
References: <edd7ed8d-0f2c-4de3-89e5-f2b23c2dd1e5@kernel.org>
 <6a9c2369-5589-4f2a-bcfe-c6e3b46a1ccd@gmail.com>
 <c8e3bb54-e4f1-45d3-8059-3ee1910a920a@kernel.org>
 <ao6c6Oe_KV0O1LJn@gremlin>
 <b6fbf952-c619-4fc7-8a8e-62a0ae64ff0d@kernel.org>
 <ao6fSHW_nX8YC9QK@gremlin>
 <42695df0-3962-4126-9afb-9a1905d096a0@kernel.org>
 <49aa013f-f613-42be-bc58-35956ef189de@kernel.org>
 <ao6jVbVHLUmuY2UA@gremlin>
 <330789dd-94e2-4827-abdd-23671263608f@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <330789dd-94e2-4827-abdd-23671263608f@gmail.com>

On Wed, Aug 26, 2026 at 05:21:51PM +0800, Vernon Yang wrote:
> On Wed, Aug 26, 2026 at 09:35:38AM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Wed, Aug 26, 2026 at 10:24:56AM +0200, David Hildenbrand (Arm) wrote:
> > > On 8/26/26 10:16, David Hildenbrand (Arm) wrote:
> > > > On 8/26/26 10:11, Lorenzo Stoakes (ARM) wrote:
> > > >> On Wed, Aug 26, 2026 at 10:08:58AM +0200, David Hildenbrand (Arm) wrote:
> > > >>>
> > > >>> Elaborate.
> > > >>
> > > >> It's overly long, I read it and am confused as to what is 'problematic' or not,
> > > >> it reads weirdly in English and pfn_xxx is the usual convention for naming of
> > > >> pfn's anyway.
> > > >
> > > > Excuse me, what? Are you now just making up arguments?
> > > To clarify, we have various users of "xxx_pfn" in the tree and I fail to see how
> > > "this is a problematic pfn" -> "problematic_pfn" is odd and why
> > > "pfn_problematic" would be any clearer.
> > >
> > > I do agree with the "problematic" aspect. "failed" might indeed be nicer.
> >
> > Right yeah. Mostly the push back is on the word being a bit confusing. Fair
> > enough on the pfn thing, failed_pfn is actually the nicest name suggested so far
> > :)
>
> failed_pfn is good to me.

Thanks.

>
> > I still think:
> >
> >        	if (result == SCAN_SUCCEED) {
> >                	...
> >                	trace_mm_khugepaged_scan_file(mm, -1, file, present, swap, result);
> >        	} else {
> >                	trace_mm_khugepaged_scan_file(mm, failed_pfn, file, present,
> > 					      swap, result);
> >        	}
> >
> > Is a little neater as then it's only on the failure path that we trace the
> > failed pfn, and otherwise we explicitly -1.
>
> I understand what you're trying to say, but personally it isn't necessary,
> because failed_pfn defaults to -1, and one
> trace_mm_khugepaged_scan_file() already covers it.
>
> If everyone clearly expresses that they want two
> trace_mm_khugepaged_scan_file(), please let me know explicitly. Thanks!

See David's reply, we'd like to go with this thanks.

--
Cheers, Lorenzo
