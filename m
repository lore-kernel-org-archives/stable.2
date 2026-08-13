Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60423ABBF;
	Thu, 13 Aug 2026 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641206; cv=none; b=gG3+ZR+O1A46Z1SM44Ub7utKfO1TVZE/cDaJwBQcktISYxAeWo0y4xA6IKAcdL0rwp6rZno892iR1zUBgEz/v4nZEdFw3noZdFuS8jQJgeKXvGhjeRmj6ErY5xbmaUPNcrchzfridKh9PrgJ7jSexMERE42+wN9RjfvhL3kYgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641206; c=relaxed/simple;
	bh=TUfxY3t1b+w7Wn2N7rvrr5qu1bT3LWeRrITU9jo+FBc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kiQbpwaOYqSnsK9yTzCmcQUPLKl0yFMN5uP/XLGTCHFfe9n/jsL2SWRStyenI+jYvDd9ayZd8NdiAxboQPGFDXskoepS5D3M0e8Q8b5fxlyOlf6DLftnVL8S3sczD4ZCn1sYgl8GC1Hn3LsZcsRkv5bRd28NrlX67ZHFdGT9F5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q88b+0mF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q88b+0mF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3E11F000E9;
	Thu, 13 Aug 2026 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786641205;
	bh=pUOC/FC4PQF6+s0qEZTpGq4bNKV31D5cgo9gvuc/ncU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q88b+0mFOy7f5xOve/935GyjlURclUSFAIHLWIDPPl6nplURGd+Kurct98CZVpXWa
	 hOZIIyGv0LEq7+VRCnmY1+hggNdXUPLg7y1Wu66aH4+hnJ0LhlPqfzP5Krg076WOig
	 QcvZmdUcFZ8JJVSsInNW5LXdWEq9SEuzE/kuli+A=
Date: Thu, 13 Aug 2026 10:13:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, David CARLIER
 <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jiri Slaby
 <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, Kevin Tian
 <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Nikunj A Dadhania <nikunj@amd.com>, Pedro
 Falcato <pfalcato@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter
 Zijlstra <peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Steffen Dirkwinkel <lists@steffen.cc>, Suren Baghdasaryan
 <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, Toshi Kani
 <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, Vlastimil
 Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org, syzbot@syzkaller.appspotmail.com, x86@kernel.org
Subject: Re: [PATCH v2 0/5] x86/mm/pat: CPA fixes
Message-Id: <20260813101323.86405fa229aa6a80fdb53d63@linux-foundation.org>
In-Reply-To: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
References: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 12:01:23 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> Some of the fixes got merged into x86 tree, some of them got merged into mm
> tree and some are still hanging in the air.

I'm assuming/hoping that this whole series will be handled by the x86
team.


I have retained three random pat patches in mm.git since July 23:

x86-mm-pat-acquire-init_mm-write-lock-on-collapse-to-avoid-uaf.patch
x86-mm-pat-acquire-init_mm-read-lock-on-attribute-change-to-avoid-uaf.patch
x86-mm-pat-allocate-split-page-tables-as-kernel-page-tables.patch

just to get them some testing exposure.  But they're old.  I've heard
no reports since adding them.

There's nothing more to be learned by keeping these in mm.git so I'll
remove them now.


