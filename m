Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA217B50A;
	Mon, 24 Aug 2026 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577710; cv=none; b=EV9u4Y7TeYJPLn7wtcyfM0+jxZq+eQCOHxzz4sLuiuK9rbEKJWzUZdMquHs6xDhUhjtOgW78ZPa8m3cs+rwObsyy5ovhVlVTDl5XYMfOniKOEzHxNO63PtSY23gGLW2szD2/33Xd/09BcB+4XBApTcwL0Xa3pd+QFmB2ZN6ZFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577710; c=relaxed/simple;
	bh=Lw0JsDV0WTzHsR1mYq2sQkaCsFm2SnOuXntn3KxvQ10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEDk3HyBB0mmRXnnD0e8WcEm+cH6t5Mlhglz/IUrIUlR71PjVj0u059G7ZRRsLQSsmAC22XQv41Faq9ZRH1feU/h6/OYW/nAAT0JOpme1i5gRBm96kzD+RblmCsfY0CxFbE4/XrzCLdNNbI4TuKlwL11yyDyDsjSr2wGXN0FX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3kIUzMh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3kIUzMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8431A1F000E9;
	Mon, 24 Aug 2026 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787577709;
	bh=C1JOhLm4zg8p33Eesvf4KAwYUKhywd17N8ZTmUOFlhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C3kIUzMhBQVJBfsXshHzLfqtoxocGaUhRkQoECbAKeJQlpCpUfZUYrgKN+hbK6Fmm
	 vZ+AH6AecQm4ImUrVUYSpRNZ7vp6fEPBYgLlAwq6ojg0QZ8ExNDQ/BV5BMi0+PSfOS
	 jnFW3wNpWO7dNuN4Z+5XMMJReiDd/893GjpZhJuhHBn6d5+l+XALb/h3/DysSKN75q
	 cf7disUtAvAF8RdKux/E1FKxBTsU2c0cTsyEdfslqfP/riTetz4RZ8IJMw0HHxujLW
	 aaB0xLOyX3AwIgIoHEIxVwXQl3pBUpttWNkd0G+TOdXoi+eK8lDcC16I2Syb/hHUXI
	 TGqNKfKngLeig==
Date: Mon, 24 Aug 2026 16:21:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Daehyeon Ko <4ncienth@gmail.com>, stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Hagen Paul Pfeifer <hagen@jauu.net>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] mm/secretmem: properly account locked pages
Message-ID: <aoxFYlkTvHMqdqf_@kernel.org>
References: <20260822-secretmem-accounting-v2-1-fe445a7c6eb1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822-secretmem-accounting-v2-1-fe445a7c6eb1@kernel.org>

On Sat, Aug 22, 2026 at 08:14:02PM +0100, Lorenzo Stoakes (ARM) wrote:
> secretmem has a relatively laissez-faire attitude to accounting the folios
> it allocates.
> 
> The intention is that the memory is treated as if it were mlock()'d and
> thus is limited by the RLIMIT_MEMLOCK limit if the CAP_IPC_LOCK capability
> is not in place (which broadly allows unlimited ranges of mlock()'d
> memory).
> 
> The lifecycle for memfd accounting against this limit is - account on map,
> unaccount on unmap but the lifecycle of memfd folios is allocate on fault,
> deallocate on inode eviction.
> 
> This mismatch is problematic because the folios are unevictable and remain
> so until the inode is evicted (set using mapping_set_unevictable()).
> 
> This is problematic as it eliminates usual mlock() semantics - mapping
> folios then unmapping them does not clear their unevictable state, since it
> depends on AS_UNEVICTABLE, not PG_mlocked.
> 
> A user can therefore easily work around the RLIMIT_MEMLOCK limit - simply
> map then unmap and VmLck no longer counts the secretmem range (or more
> involved - fork which also achieves the same thing).
> 
> Worse - they are not accounted in the process's RSS even if mapped again,
> meaning the OOM killer won't know to kill the process.
> 
> A user without the CAP_IPC_LOCK capability can therefore repeatedly
> map/unmap (or map/fork) and consume all available system memory with
> unevictable folios and cause system instability.
> 
> A secretmem fd can be passed between processes and over fork so a
> per-process limit simply does not make sense.
> 
> So follow the precedent set by io_uring, perf, skbuff, iommufd and xdp -
> track the number of locked pages in user_struct->locked_vm.
> 
> Since the scope tracked is actually inode lifetime, the RLIMIT_MEMLOCK
> applies per-user not per-process. Also given the change in scope it doesn't
> make sense to bypass for users with CAP_IPC_LOCK, so remove it.
> 
> There is simply no reason to carry on marking the mapping as mlock()'d
> since it's misleading and the lifecycle is now correctly handled, so remove
> this too.
> 
> Additionally, fix the selftest which checks the limit as this now must
> assert SIGBUS on limit violation on fault-in.
> 
> __secretmem_account_pages() is more or less a duplicate of the code that
> io_uring etc. use, but since this is a bug fix that needs backporting,
> defer any de-duplication efforts to a follow-up.
> 
> Reported-by: Daehyeon Ko <4ncienth@gmail.com>
> Closes: https://lore.kernel.org/linux-mm/20260813225328.2010303-1-4ncienth@gmail.com/
> Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.
