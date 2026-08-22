Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420030AAA9;
	Sat, 22 Aug 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787424955; cv=none; b=FQ7by8iM84LuGSt/4B0JTRtGU3S7QLuVlX1DqLYpKWX9v9aECdpQYeLB0mYTZ9jGMA/MJOY54sLDW6n/pv0mK8F1wjW0a/U5R5XqZ0wcXC73NFhTCHSZPukTGE3NPo23LvG6tiTy2L4jLki/ckfXeQsYea7s4tUuvqoVUkNpl1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787424955; c=relaxed/simple;
	bh=0gkSJt4mCje9oNoaV1+NwFKtwQ2nlw/SO3gy3CulEPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8sR832EiknSd+mjjtHWO0wYZPArcchZajv+83MCuafsxmxwvOJlRF549YWYfbgXrCmNqLNvrd1/7+F3eAHtLZLxmQm9JkDgUokPDmAniE0j0lQQIIHZk5/9mckgr4fGzHLCo7hrYDf1I4ecvUgld1YLRPjYzb9gb+GNeqB3npE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnUgW/OE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnUgW/OE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485601F000E9;
	Sat, 22 Aug 2026 18:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787424948;
	bh=78SBByw6W5epz7cVxeuu6l+8VUwUHF/hNkVnqoTyScQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DnUgW/OEk1K5xfMoFU0brDWSz2iUuUROqMrQbohZNa6W65TeH+nyrXq5F9vu3mmZz
	 JbIGV8v7KWb7Tl8EfnNa98qitCYoWyHVBEsTnlC5gNY8khyp82h9G98GdIooq173Gp
	 uWa8f31tYwduZ4uKGZY6z/gsP1YvqPNbHFt+NMiMnaTvRjkdvJv/f+KcJ1MHjOaeJY
	 0JGLgT3MuzUy03AEYH291WJP+YcCIaLhlz2Er+rtuHC6V10HlS0jg0LME7nXknFCLo
	 2vkHT27XAbrnBrr7ARz3E9a8LS6acqWqlL5ulsvzt8RN9lFDQyqwUBFEknCkcGyA/J
	 2PgDnnn6barQg==
Date: Sat, 22 Aug 2026 19:55:28 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Hagen Paul Pfeifer <hagen@jauu.net>, 
	Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daehyeon Ko <4ncienth@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/secretmem: properly account locked pages
Message-ID: <aonwNh4vsmyp5o1K@lucifer>
References: <20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org>
 <178706447572.2799959.13846195033539124794.b4-review@b4>
 <aoRx-VLojNCSBPUj@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoRx-VLojNCSBPUj@lucifer>

On Tue, Aug 18, 2026 at 04:27:48PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Tue, Aug 18, 2026 at 05:47:55PM +0300, Mike Rapoport wrote:
> > > diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
> > > index aac4f795c327..626e7033b72f 100644
> > > --- a/tools/testing/selftests/mm/memfd_secret.c
> > > +++ b/tools/testing/selftests/mm/memfd_secret.c
...
> > > +static void test_mlock_limit(void)
> > >  {
> > >  	size_t len;
> > >  	char *mem;
> > > +	int fd;
> > > +
> > > +	/* Locked pages have an inode lifetime, so need a new fd. */
> > > +	fd = memfd_secret(0);
> > > +	if (fd < 0) {
> > > +		fail("memfd_secret failed: %s\n", strerror(errno));
> > > +		return;
> > > +	}
> > > +
> > > +	if (ftruncate(fd, mlock_limit_max * 2)) {
> > > +		fail("ftruncate failed: %s\n", strerror(errno));
> > > +		goto out_close;
> > > +	}
> >
> > Can't we ftruncate to this size in main and be done?
>
> I think we should be able to, will change unless it's somehow a problem.

OK no, I have to do it here as there needs to be a new fd since keeping the same
fd would mean all future tests would have secretmem that exceeded the rlimit
quota (since it's per inode now), so have to set up new fd, configure it, tear
it down just for this test :)

--
Cheers, Lorenzo
