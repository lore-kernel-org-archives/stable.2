Received: from mail-qv2-f25.google.com (mail-qv2-f25.google.com [74.125.230.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E735F364058
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570709; cv=none; b=bkn3DaT4C0JFqG4VIlq38uwlUbSqQOOnEgNe1JXSqwWIhed3gOOeQvQ5+r9e2G/D+OyStCc3NCXnI4sRtSJAehSBYuGgjQwCRJsDuJVgx9yCWso3YU33ia2QWeDIwcWKGAH9dUkig7rWOTE78VMPCG2lIC+/xwNe3O5NeIl8mzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570709; c=relaxed/simple;
	bh=zqbHumWXTgyPSnBiFG7tdNAOB274jQFr/Oh4RdNiJOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArDySGsHveCoTzCXcXWNCICGA7AWatD4qe00ic4tByF66NohTkwvaH/HockTC7hbqFDXohiwu6EiTWZM1bI0ueEFH4E730X+SAZ+uPOJ4214m1eqJSKrwP03xUzByFyxencYWZzIhJlYPt3A/32BZrj/hV0ITxhiQMRoe3FpYwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=u5PPQc5X; arc=none smtp.client-ip=74.125.230.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="u5PPQc5X"
Received: by mail-qv2-f25.google.com with SMTP id 6a1803df08f44-90cdfcb5cb3so10339006d6.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789570707; x=1790175507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJ/7KRGCLt2483GTzu4rmQfCVmqSHc3OynN8gOawIhg=;
        b=u5PPQc5XgfkDEu7rParCFg56Eg75TdIjeZscdjXJx2o/l7J7dPRigdTIzSvwlbeX45
         Mrmaqg5qvMT2owAWbS2jLqWkMJqG4MWW18xIhE9LHXL1RCw/W8lfqf+FCYPDxj2yd6gF
         RVLwA2s43htz4Gotc9/zlcaT5MKWU3naAOgmyqe60UaX2B4d2H4SjpVMlbrcF2qnD9+N
         P01b5J9u1StgXPH4nIuPyQ5L2LywEtep96cQX7UpfaLpBhlwt+Cv0awroneDD1tz1bTY
         1kdWIqeA5/KkYiSfXTqMEomc+3SmixhcCTnzFihpPKhBrppali26VfFJxNkOGBnvYwKe
         /c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789570707; x=1790175507;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJ/7KRGCLt2483GTzu4rmQfCVmqSHc3OynN8gOawIhg=;
        b=IyUfqDEODNf3XYVjcD3A1iDkv8qlC7gTzjv4v+mxERZYBV9Asuop6q2G7uoA4jd6JO
         MJI+MeHxtbv9OKKUbWrLX1JTSA+W3gE9gracUdn5kTpE7UlHeXbRHj8hEuO8fq1NWiN8
         lNuNIu7/tcmfaqJXv58OhJ5wmpWLAI/6wO0LHUeMjq4/BOvWFw+Lb8fQecaiNNsTZ+Yo
         FiEd/InQoqyDQ1qfq0g7Ft05UFaXyNnOhgAbVmBKyy8IexxTgABPC7w4Or7lOx/DkOzK
         lfiwUhaDogxWwLahQzymeCkPk0aSmZpfRkYhHCDZkAl9CpKI4zYIobPWWjkglfTqNwrL
         a3TQ==
X-Forwarded-Encrypted: i=1; AKwUvBwR+a2qLe5N45CeKjkcz3kn/0uRxUvShb7u318Ej6YeQG54CvQpkCf1rl10+Aw7LViBKxH7zJc=@vger.kernel.org
X-Gm-Message-State: AFuF++m6/Yi1nk9sKacKkGJt1n1wwCnivBzGfrl5dLZ0W1m2NUikNGcA
	kP0vdmUgM0hqXSfxGndcgonqnJqyl4OApixIyNZJxVzhNmQ8yIcO5ApGbLR3YUU9/TA=
X-Gm-Gg: AYBFou2wBB23FrK5eoSJQZtZsH7TDhXoC/oqBO/l27SKwqoO0QZREReBzXY8EyaGalu
	AgO370K2uh0i+TOkMcIrz4WhnUqjZKFFPTwgHXSleecrDJCvFNRzX9sWFqTfJAY5tSu+mEpQX1+
	+tdpx3MpxYrnVIShXBnyX0DvecE4yTvFN0k2w83TEiJTkX77+7UPsP5J0CckVtoe7nEa92ugT/2
	YRkHsKiwhU3fiBt98ozQMoDBnFvjccXjkkb6e5HEWPwGsb/NNrHkvmfLW7FVVOLWriDiIZ+D857
	anmBhsceDQpzsBY+1GBAfR7V/1LE7TZc05xFq2GdZRWzZUBuQ7dMrIbBccWgT54/K+MimNkZptk
	ZAOKOM0nTzAIhY5CLzCRgN5Uij9VLoNl/EuUA2aMmhtxxHvja9B0VYog5z8rQD7dNWvdAkoaG9B
	lL0yJLTPEOZy1INDpzT/53xiN0BrmsJCyfVd/iJ+6+65g/6QVwVNUDgnN7jCBGHyr2PBORIEeGj
	riDJXYMJ08HV5YtxAmeh5O2DwQNBkSnXGtmgQUIvhSv8Wt2q2heDtziYAQlJpJmBw==
X-Received: by 2002:a05:6214:21c2:b0:910:47af:7b5b with SMTP id 6a1803df08f44-9123d7ace93mr52499256d6.20.1789570706029;
        Wed, 16 Sep 2026 07:58:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123beeec67sm27942276d6.48.2026.09.16.07.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:58:25 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:58:23 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, 
	liam@infradead.org, vbabka@kernel.org, jannh@google.com, wangjiexun@tinylab.org, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqquDtEZL1ndymGN@gourry-fedora-PF4VCD3F>
References: <20260912110832.3203902-1-gourry@gourry.net>
 <aqloB0zm3RjJ47m1@gremlin>
 <aql65IhMobL5Al9B@gourry-fedora-PF4VCD3F>
 <aqqTbGMJL86TzDrf@gremlin>
 <aqqbB_nFAOGenDhy@gourry-fedora-PF4VCD3F>
 <aqqjW5dpyznijYLh@gremlin>
 <aqqk89oTigJ9LS2N@gourry-fedora-PF4VCD3F>
 <5437871c-d9ee-49d2-b24f-965c73c29c3e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5437871c-d9ee-49d2-b24f-965c73c29c3e@kernel.org>

On Wed, Sep 16, 2026 at 04:48:04PM +0200, David Hildenbrand (Arm) wrote:
> On 9/16/26 16:42, Gregory Price wrote:
> > On Wed, Sep 16, 2026 at 03:12:53PM +0100, Lorenzo Stoakes (ARM) wrote:
> >>>
> >>> Going to spend a little more time testing and tweaking before I post it.
> >>>
> >>> I've been working on a making more extensive unit tests for certain
> >>> parts of mm/ and this might be a good time to look at whether I can
> >>> introduce a piece of it.
> >>
> >> Nice, curious as to how?
> >>
> >> Have you tried the userland VMA tests btw? Not tooting my own horn so to
> >> speak :P but it's nice, though it comes at a bit of a cost in how the files
> >> have to be set up...
> >>
> > 
> > Yes, in fact I used that as a start for exploring how I might make other
> > components testable the same way.
> > 
> > "Stubs... stubs everywhere"
> > 
> > There's basically 4 testing mechanisms i explored:
> > 
> > 1) selftest
> > 2) Usermode Linux (UML)
> > 3) Userland stuff like VMA
> > 4) Linux Test Project (for syscall and ABI testing)
> > 
> > selftests are really limited and actually create a maintenance burden,
> > they're not real unit tests and are highly dependent on the actual
> > machine configuration which is super annoying.
> > 
> > But, lets take the page allocator as an example.
> > 
> > The only piece of the page allocator that "should" (cough, simplifying
> > here a bit) be machine specific is zone and node configurations... but
> > I'm not convinced that this should require a full VM to unit-test.
> 
> I told Brendan exactly that (try stubbing it) and he tried ... and had to give
> up at some point because it just wasn't feasible. ;)
> 

LLM go brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr

I'll try to clean up my current pile and see what I can pull out for
some select components.  Something is better than literally nothing.

I'm trying to be careful about not causing a bigger maintenance burden
while also having some confidence in my own code.

~Gregory
