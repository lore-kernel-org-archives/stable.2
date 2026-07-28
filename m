Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D11449B1F;
	Tue, 28 Jul 2026 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249113; cv=none; b=UHLglGrMlCGr+YUhHOEMh4/8E/cba8fgTgyflV19go3jGB1emnFWwmkCQg+cs0GiZ8AuD0GQSDo32Rt06sD0PJpzmeMX8jp+55OkDkJSyawFq1nkvMGtRSLPtLh6BMRmin6hSoJJiUzKKAbyQ+snHLvcLGDQIGlEgsYBJURby08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249113; c=relaxed/simple;
	bh=Xa1UbLLuDPNrmX++MKgqefbM0T9HGAdK0vw+TDjzPWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qoj0uGrjs27x9lMl4l6vevBhZ35k/qVts8E6IxgM7pT9B/mleGEzrGAxGTD0RLDHZPRfXQHSdc1TMjjZE3aklq+olwINeajTNUhxCx1Dtl0ntHt1unZQKDLcVWUusqDllAqJzgFJiMLoviJA7ltpitUPyZTsnSzXgkS3xCGUzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uxw4gS+V; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uxw4gS+V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ylxLw5Zvv2evU7jmmQqp6rI9pLf6NLfhr20HsnCki9w=; b=uxw4gS+Vs58Hy3vhqrWgntua5G
	zQEksmEBJvslx0KRQxb0RXudR1WgcRb/xnnRwBS9xGVyxrjJGeybLRCAQaNQ2dnlvPhJrwVHHbcVP
	aIK3TfogFkt741WzhEPW1VMnaH/h6cWazMrko7O7Is8P/AAGyfKnIlMnjhiU6VY73iLk+FL2N1I/1
	5kEFq2Ky7h7aC6sta8P2tAqPNWK8qYp7BOejIKZpNSWNWaoW43Yllxp1D45G/uS/IXIRKG2MfVbTA
	8F2JdHUVQONJdBQ8/GetX+lhN8EW45KSVbsZma0nYiVdVzZs/zNk0okjdkVXKVz/DUC2iWV5znW7l
	Tm3+dgqA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woiqG-0000000DS1h-3WHz;
	Tue, 28 Jul 2026 14:31:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AF4A0300CDE; Tue, 28 Jul 2026 16:31:35 +0200 (CEST)
Date: Tue, 28 Jul 2026 16:31:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	David CARLIER <devnexen@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/5] x86/mm/pat: introcude cpa_lock() and cpa_unlock()
Message-ID: <20260728143135.GG651302@noisy.programming.kicks-ass.net>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <20260728-cpa-fixes-v1-1-2ed2352300b3@kernel.org>
 <20260728142108.GW751831@noisy.programming.kicks-ass.net>
 <adfffb36-9943-4af7-a0ee-0e762e47fa11@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfffb36-9943-4af7-a0ee-0e762e47fa11@intel.com>

On Tue, Jul 28, 2026 at 07:30:27AM -0700, Dave Hansen wrote:
> On 7/28/26 07:21, Peter Zijlstra wrote:
> > There was already a patch merged that removed the shole debug_pagealloc
> > exception. Is that not better?
> 
> As I'm scanning through email this morning, there's another issue that
> popped up with that patch. It's causing hangs on boot.
> 
> It's looking like debug pagealloc not taking the lock is actually
> functional, not an optimization. Although, I hesitate to say
> "functional" and would prefer to use much less nice words to describe it.

Yeah, lets figure out why that is before we retain this wart ;-)
