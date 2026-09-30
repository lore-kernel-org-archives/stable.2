Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1BE51DAE7;
	Wed, 30 Sep 2026 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792650; cv=none; b=HnGx0VdPqgbtL+0NxgrgLoiaQVqXs3+Yvj66wcEERj1J451LjpVGbURcCGJAVe6quourfNKQGOAnxlr+cU9z3RKTDLlhTpyqxg1PG3kLfDxMjcquJ9s5gknXOlTSKGw6tCWRlWiNOJpI1z2Nxg9XJ8uxpRZfaHQXzqsDB0GPbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792650; c=relaxed/simple;
	bh=QAvOi4cchjKNlSCrsX1D95liAuQ9dq5OUbprIpUaeX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbQ8kNCXo0LB4jKq0ibjzceMOJaKAWukOPTiztVGjhgD9b6OcrhFLxISOKj0vdhZb1PgvL9f7DzraYA/++a153+jqS9bHfmUbhuDBZyvauK63vs4J+gvnIE5k3CcAZX5sEnCqiMmcfbzNAh0qHdmfBZIbUv+i4wGx2Pv8g98SiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3nm1bqH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3nm1bqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D042B1F000FF;
	Wed, 30 Sep 2026 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790792648;
	bh=FunQvZwAH5B4DZ2KKVAQe9PaR1db9gvR3K0YtXguIiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q3nm1bqH7nevKq8YHNKNgJQTY046xcAqz7j8pKgxJCIcdNu5xd2F2b5ykJmycc5O/
	 S4E0uPuPPAktCNmGa5JSzh2CgENEA10vJxxPdkXHO2CYbn8/N8bGwsFzxWiXeHhvsN
	 Nk4iNlqQdWQtwRXAwHnbnm7ybo1RpyY4Pim9O/yYQAAjBsQ5+kH6ROevSTYcr7r5Hw
	 7X3P+jQQrVPzgEvaGf3rk7cLgOH+uFawmA399Q24yZjAJsx5dKQVqJ7YjW5nDh5ZFs
	 t3NPtngodXZtww1yXE/ZRMF3BH0FQcRZcFTYgs1OodcerpISIAb7nSMESXm2sJ/DcC
	 sSQhCu0TlrhbA==
Date: Wed, 30 Sep 2026 19:24:03 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/mremap: fix two issues with MREMAP_DONTUNMAP
Message-ID: <ar1TdGugvi9_RwG9@gremlin>
References: <20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org>
 <ux7od2uydetgsu3dpy6mmilhqm5phhnk2ioxn54w3nb3feohxf@2jqovoqzfs4n>
 <ar0y2odPFkCLMKk6@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar0y2odPFkCLMKk6@gremlin>

On Wed, Sep 30, 2026 at 05:04:38PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Wed, Sep 30, 2026 at 10:59:50AM -0500, Anirudh Srinivasan wrote:
> > On Sun, Sep 20, 2026 at 03:13:09PM +0100, Lorenzo Stoakes (ARM) wrote:
>
> > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > ---
> > > Lorenzo Stoakes (ARM) (2):
> > >       mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
> > >       mm/mremap: fix locked_vm leak by splitting VMA for MREMAP_DONTUNMAP
> >
> > Hello,
> >
> > Apologies for the double mail. I did not hit reply all first time.
> >
> > I am seeing some failures in the proc_maps_race kselftests after
> > this patch was added to linux-next. The failures are in
> > test_maps_tearing_from_remap and test_maps_tearing_from_resize. I have
> > attached some logs below
>
> Ack thanks for the report. I'll dig into this and get back to you!
>
> Instinctively I suspect the tests are making assumptions they shouldn't be,
> given this series has the MREMAP_DONTUNMAP case split in advance.

OK, the tests seem fairly sensitive to change, but the correct solution here
overall I think is to only split if the VMA is mlock()'d, so I'll do that and
send a respin + cc you on that which you can check!

That should fix the tests and avoids unnecessary splits also.

Thanks again for the report! :)

>
> --
> Cheers, Lorenzo

--
Cheers, Lorenzo
