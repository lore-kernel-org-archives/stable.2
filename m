Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569A12EEE91;
	Sat, 29 Aug 2026 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787967484; cv=none; b=dA9t29ldOTZdrDRJfheGvJ7qR0wyHKdE38xt0GCja4tur9toXgeA5twUhDWWzcAtcHeLPrCuj1VXETllJlCdwU0f7hK6LBvgSvqyjnXCjSVouR4x7OzYsGZnBnWuMGk7EUvTGg6K297ORH4pro+VhBPuJQ1xRQ+Y7xtcxfLTkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787967484; c=relaxed/simple;
	bh=sA9f04kJnVsxUeKi3yRTD+8qO8r+eN7yclYtlHVkVIM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I0TmVH+XnXZI81Gw1KSNzg2jPFrNr/gj5x5bx0/c+nL/pc3HUew9QP7t4maQ8xdt/yTSi6uHpdVg/YYCHVjJ8jPVrxScQCAtFyW1I5FhNBiQ94ZuARLM/buIMkXvCrrene8KHs94SQMeREOGlwmZ1P9e5A6zl/iBi1WRoJO1hqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1ooxQzN1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1ooxQzN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A55E1F000E9;
	Sat, 29 Aug 2026 01:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787967482;
	bh=EJ9sY7xCOOkZU7fkNPcRup0wxQveVJYgj0rNuabJsg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=1ooxQzN1/Iis7wo4qiD0UQM20Iq0wgdIB/2Da6G96vQezHcr2GL1PY8otynXf4F/m
	 Zoyo5eezro3XDif4O45Ll5elF47hRGsxQTfydbJr6YHQenjtHLrTy/RFznmw/1il2u
	 jrr67O1j2x2g829K+t8kiKwhd/QkYrxyzlzEmTIs=
Date: Fri, 28 Aug 2026 18:38:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: James Houghton <jthoughton@google.com>
Cc: Lance Yang <lance.yang@linux.dev>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, liam@infradead.org, Nico Pache
 <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Usama Arif
 <usama.arif@linux.dev>, Yang Shi <shy828301@gmail.com>, zokeefe@google.com,
 hughd@google.com, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/khugepaged: Don't install PMDs in
 uffd-minor-registered VMAs
Message-Id: <20260828183801.04fd2d2a6af837cb45b60e0f@linux-foundation.org>
In-Reply-To: <CADrL8HV0nUDjr432S8AdTZ_HO8fACrFSCu8cS49vR4XJQa39zg@mail.gmail.com>
References: <20260828222640.1638457-1-jthoughton@google.com>
	<20260828173302.29778f1bf802a1db932778ad@linux-foundation.org>
	<CADrL8HVzfEXgE9OQfULhe6wh1kMMOALsYuCNOUkgBqtzk_LUVg@mail.gmail.com>
	<CADrL8HV0nUDjr432S8AdTZ_HO8fACrFSCu8cS49vR4XJQa39zg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 18:18:11 -0700 James Houghton <jthoughton@google.com> wrote:

> On Fri, Aug 28, 2026 at 6:09 PM James Houghton <jthoughton@google.com> wrote:
> >
> > On Fri, Aug 28, 2026 at 5:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > Wondering what Lance tested.  Was he able to reproduce the bug?
> >
> > I assume he just re-ran my repro, but yeah I'm not sure, heh. Lance,
> > what did you test?
> 
> Ah, just to be clear, I linked a repro on v1. Here[1] is that repro.
> Sorry, slipped my mind to also include it in the notes for this v2.
> 
> [1] https://gist.github.com/48ca/d399bf534158e80241fb4937ef1ff664

Cool thanks, I'll slap this into the changelog.

# ./a.out
TAP version 13
1..1
madvise(MADV_COLLAPSE) succeeded
ioctl(UFFDIO_CONTINUE) failed: File exists (errno=17)
not ok 1 - memfd userfaultfd MINOR continue test


We do have a ton of uffd selftesting code in there.  Adding this case
to uffd-unit-tests.c would presumably be pretty simple.  We don't
really have a policy on adding a test-case after fixing something -
it's common practice but why?  We already fixed it!

