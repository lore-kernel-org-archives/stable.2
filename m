Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9792F6586;
	Tue, 25 Aug 2026 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787656710; cv=none; b=b/0ZVPfOMaPlx03ngnuryXQk4n1NcN0MytiFX8OYtOYxpPkrjB/Hzuy5mv+1UwsolNjZ6BIVqiFLDpbvO5VeNcP7HEPsxjn/uOpJG8ZTLWVJxlc87A/yhVKXGPImExQyBZNmpv6zKYno0UAVoPh4xqIXh0YVh9eVxpmmvG4DmKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787656710; c=relaxed/simple;
	bh=kBhdER13jAp6MxknuAJUTIZC71E/Zc5bUmUHnqda1uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3sJGBDS0TqVtyzNiqAqVb5ujYUGwaObDbdnQWXK5ZK++1RL6PjaWDKcnDbQKEvvEsJlVE/Q8VA+CY/XT7OGS5rYOvaM9DZvxegHdpZrPc7lBoBzdP0XTi1s4o288VP7BKcb5/iE4AO4575xP3DXFBFyw03GN0mfstu0+FHGHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGEZC8Fp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGEZC8Fp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2851F00A3A;
	Tue, 25 Aug 2026 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787656708;
	bh=W05Dx/VZMWvzT1SSodsvq4ca5CdFdSoDwnfBlPLV4jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YGEZC8FpPuaGJTkbj+O22U5UJ5eHCoQdZKhpk0mREl2Yhk1RMhKjSQpZVNe31G3m+
	 YlAF98rAHthuPnCeEeP2BDBRfWFYWrhFCZSj+FQ012T9VJ1eTTtm8QPVK7syzOLegH
	 V9ZiVnNdgicGC8JEfJxGAVgabPWhYKdwE/FTOoMtBnJtXlOq6HM00gzfgnm0ePGNyT
	 bdQx6Ohwqgi0e5QDnLrTGTLLnSBNt+v7tVseSXE2lVvvw6LR7b4r2lfLpcpG/CikO0
	 0JE1rSzDikmxz0iMjjpw5PlAkn59CAORWeqRN3yCOvyMc0pM7RMZU6Byhgi7nSFckA
	 cGJv4dRxlzK0A==
Date: Tue, 25 Aug 2026 12:18:20 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Daehyeon Ko <4ncienth@gmail.com>, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Hagen Paul Pfeifer <hagen@jauu.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] mm/secretmem: properly account locked pages
Message-ID: <ao13TmFVVpsv0zO4@gremlin>
References: <20260822-secretmem-accounting-v2-1-fe445a7c6eb1@kernel.org>
 <17e9f7d6-d095-44ee-9997-8dc10646f3f8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17e9f7d6-d095-44ee-9997-8dc10646f3f8@kernel.org>

On Tue, Aug 25, 2026 at 12:50:57PM +0200, David Hildenbrand (Arm) wrote:
> On 8/22/26 21:14, Lorenzo Stoakes (ARM) wrote:
> > secretmem has a relatively laissez-faire attitude to accounting the folios
> > it allocates.
> >
> > The intention is that the memory is treated as if it were mlock()'d and
> > thus is limited by the RLIMIT_MEMLOCK limit if the CAP_IPC_LOCK capability
> > is not in place (which broadly allows unlimited ranges of mlock()'d
> > memory).
> >
> > The lifecycle for memfd accounting against this limit is - account on map,
> > unaccount on unmap but the lifecycle of memfd folios is allocate on fault,
> > deallocate on inode eviction.
> >
> > This mismatch is problematic because the folios are unevictable and remain
> > so until the inode is evicted (set using mapping_set_unevictable()).
> >
> > This is problematic as it eliminates usual mlock() semantics - mapping
> > folios then unmapping them does not clear their unevictable state, since it
> > depends on AS_UNEVICTABLE, not PG_mlocked.
> >
> > A user can therefore easily work around the RLIMIT_MEMLOCK limit - simply
> > map then unmap and VmLck no longer counts the secretmem range (or more
> > involved - fork which also achieves the same thing).
> >
> > Worse - they are not accounted in the process's RSS even if mapped again,
> > meaning the OOM killer won't know to kill the process.
> >
> > A user without the CAP_IPC_LOCK capability can therefore repeatedly
> > map/unmap (or map/fork) and consume all available system memory with
> > unevictable folios and cause system instability.
> >
> > A secretmem fd can be passed between processes and over fork so a
> > per-process limit simply does not make sense.
> >
> > So follow the precedent set by io_uring, perf, skbuff, iommufd and xdp -
> > track the number of locked pages in user_struct->locked_vm.
> >
> > Since the scope tracked is actually inode lifetime, the RLIMIT_MEMLOCK
> > applies per-user not per-process. Also given the change in scope it doesn't
> > make sense to bypass for users with CAP_IPC_LOCK, so remove it.
> >
> > There is simply no reason to carry on marking the mapping as mlock()'d
> > since it's misleading and the lifecycle is now correctly handled, so remove
> > this too.
> >
> > Additionally, fix the selftest which checks the limit as this now must
> > assert SIGBUS on limit violation on fault-in.
> >
> > __secretmem_account_pages() is more or less a duplicate of the code that
> > io_uring etc. use, but since this is a bug fix that needs backporting,
> > defer any de-duplication efforts to a follow-up.
> >
> > Reported-by: Daehyeon Ko <4ncienth@gmail.com>
> > Closes: https://lore.kernel.org/linux-mm/20260813225328.2010303-1-4ncienth@gmail.com/
> > Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Can we split off the selftest changes? This stable patch is already pretty big.

Yeah I can do! I seem to recall people wanting tests backported too hence
the change.

>
> I'd assume the changes to the selftests are not required just to get if fixed,
> because the changes should not be breaking existing user space (and cosnequently
> existing selftests).

Yup confirmed locally that the changes don't break the tests.

>
> [...]
>
> > v1:
> > https://patch.msgid.link/20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org
> >
> > To: Andrew Morton <akpm@linux-foundation.org>
> > To: Mike Rapoport <rppt@kernel.org>
> > To: David Hildenbrand <david@kernel.org>
> > To: "Liam R. Howlett" <liam@infradead.org>
> > To: Vlastimil Babka <vbabka@kernel.org>
> > To: Suren Baghdasaryan <surenb@google.com>
> > To: Michal Hocko <mhocko@suse.com>
> > To: Shuah Khan <shuah@kernel.org>
> > To: Alexei Starovoitov <ast@kernel.org>
> > To: Daniel Borkmann <daniel@iogearbox.net>
> > To: "David S. Miller" <davem@davemloft.net>
> > To: Jakub Kicinski <kuba@kernel.org>
> > To: Jesper Dangaard Brouer <hawk@kernel.org>
> > To: John Fastabend <john.fastabend@gmail.com>
> > To: Stanislav Fomichev <sdf@fomichev.me>
> > To: James Bottomley <James.Bottomley@HansenPartnership.com>
> > To: Hagen Paul Pfeifer <hagen@jauu.net>
> > Cc: ljs@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: bpf@vger.kernel.org
> > ---
>
> [...]
>
> > +
> > +static bool secretmem_account_folio(struct secretmem_inode_state *state,
> > +		const struct folio *folio)
> > +{
> > +	unsigned long nr_pages;
>
> Nit:
>
> const unsinged long nr_pages = folio_nr_pages(folio);

Ack

>
> > +
> > +	nr_pages = folio_nr_pages(folio);
> > +	if (!__secretmem_account_pages(state->user, nr_pages))
> > +		return false;
> > +
> > +	atomic_long_add(nr_pages, &state->nr_pages_accounted);
> > +	return true;
> > +}
> > +
> > +static void __secretmem_unaccount_pages(struct secretmem_inode_state *state,
> > +		unsigned long nr_pages)
> > +{
> > +	atomic_long_sub(nr_pages, &state->user->locked_vm);
> > +	atomic_long_sub(nr_pages, &state->nr_pages_accounted);
> > +}
> > +
> > +static void secretmem_unaccount_folio(struct secretmem_inode_state *state,
> > +		struct folio *folio)
> > +{
> > +	__secretmem_unaccount_pages(state, folio_nr_pages(folio));
> > +}
> > +
> > +static void secretmem_unaccount_all_folios(struct secretmem_inode_state *state)
> > +{
> > +	unsigned long nr_pages_accounted;
> > +
> > +	nr_pages_accounted = atomic_long_read(&state->nr_pages_accounted);
> > +	__secretmem_unaccount_pages(state, nr_pages_accounted);
> > +}
> > +
> >  static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> >  {
> >  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> >  	struct inode *inode = file_inode(vmf->vma->vm_file);
> > +	struct secretmem_inode_state *state = inode->i_private;
> >  	pgoff_t offset = vmf->pgoff;
> >  	gfp_t gfp = vmf->gfp_mask;
> >  	unsigned long addr;
> > @@ -72,8 +134,15 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> >  			goto out;
> >  		}
> >
> > +		if (!secretmem_account_folio(state, folio)) {
> > +			folio_put(folio);
> > +			ret = VM_FAULT_SIGBUS;
> > +			goto out;
> > +		}
> > +
> Okay, that works because secretmem does not support any form of truncate, in
> particular, no FALLOC_FL_PUNCH_HOLE.

Yeah exactly. I think I covered that off somewhere in my essay-length
commit msg but if not but yeah that is a thing that I noted.

>
> Overall, the idea sounds good to me. Nothing jumped at me.

Thanks! So in a way you kinda... Ack it right? :P If only there were a tag
for that 🤔 ;)

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
