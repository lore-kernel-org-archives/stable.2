Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6039F160;
	Tue, 18 Aug 2026 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066883; cv=none; b=kbeiJteeytX+dV9Uy/pxRNm66l0akyjiThzG+4V/1kWiLPyvMeP76A7EBs3HBMVlGI0wQagxD9KHJ55IXrFi9DzsSeTUhqKAx9aDedMFzcTDwl1agmA2gzO8RWIQ14Ji5fk1AKZZm96eiElkq1L2wJBHX5897H92YGaHooAzw4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066883; c=relaxed/simple;
	bh=mWl5l1+waYMdWZU1hitSC+mQFQrrPClv0MFpq5wLiKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dv+GU0K6pRsWMtM2dT64hjWtkYUfwx18UmRZEH46cdDc4GEnR7MuUDML5pUjI7RccZ4qvDRIoFijhJqHRCkP5a8M7f+acVEsC36vF4JflvhAvYxI9rMRIATXre7d/QczV7dw0YQBovhaGuB/zKdSAlBnV67NbwYu2Z23+uLxJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikMEVN73; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikMEVN73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811631F000E9;
	Tue, 18 Aug 2026 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066881;
	bh=JhXloICc+UqKv2q5ru7puIMMw3HuImiQgtG8gSewRqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ikMEVN73DR/eZPfgW+G79Txun+vnK+roH8GFlonvy0mJrRL1jEIuGXOvlHEVvN2Ac
	 HVMN6QmvbgIw/eukQ6zKIa6um4ZLk7ANV1mvX5f1P+4eGpriBUV2wdo9nb/0HcNYZN
	 g/nM+2DgitR4fc+a+KVXhztOWXxeOMo84PSphiYON4Hf86NmamnsdIzWl++qvXD8D1
	 xOJDCi+jYOWkC5EWYr3wti9P7RQsh4eQ4at5vkXl0D/BGG0CvbUMhJylRDCdlQv4Rq
	 7XvNEajTEXSgJgzqBvcstTUxeHPLlB7IWWdtnNYsbZmcc7Llb02oiBqr1KNDnjsYD4
	 T2FVV3Mn91g8Q==
Date: Tue, 18 Aug 2026 16:27:40 +0100
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
Message-ID: <aoRx-VLojNCSBPUj@lucifer>
References: <20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org>
 <178706447572.2799959.13846195033539124794.b4-review@b4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178706447572.2799959.13846195033539124794.b4-review@b4>

On Tue, Aug 18, 2026 at 05:47:55PM +0300, Mike Rapoport wrote:
> > secretmem has a relatively laissez-faire attitude to accounting the folios
> > it allocates.
> >
> > The intention is that the memory is treated as if it were mlock()'d and
> > thus is limited by the RLIMIT_MEMLOCK limit if the CAP_IPC_LOCK capability
> > is not in place (which broadly allows unlimited ranges of mlock()'d
> > memory).
> >
> > The lifecycle for memfd accounting against this limit is - account on
> > map, unaccount on unmap.
> >
> > But the lifecycle of memfd folios is allocate on fault, deallocate on inode
> > eviction.
> >
> > This mismatch is problematic because the folios are unevictable and remain
> > so until the inode is evicted.
> >
> > This is established using mapping_set_unevictable() setting the
> > AS_UNEVICTABLE flag in the relevant address_space data structure.
> >
> > This is problematic as it eliminates usual mlock() semantics - mapping
> > folios then unmapping them does not clear their unevictable state, since it
> > depends on AS_UNEVICTABLE, not PG_mlocked.
> >
> > This is checked by folio_evictable() which first checks for AS_UNEVICTABLE
> > before looking at PG_mlocked, which is cleared on unmap via
> > munlock_vma_folio().
> >
> > A user can therefore easily work around the RLIMIT_MEMLOCK limit - simply
> > map then unmap and VmLck no longer counts the secretmem range, nor are they
> > accounted in the process's RSS even if mapped again, meaning the OOM killer
> > won't know to kill the process.
> >
> > This can also be achieved by forking the process, as VMA_LOCKED_BIT is
> > cleared for VMAs copied to the child process, whose VmLck will be 0.
> >
> > A user without the CAP_IPC_LOCK capability can therefore repeatedly
> > map/unmap (or map/fork) and consume all available system memory with
> > unevictable folios and cause system instability.
> >
> > Worse, the OOM killer will not be able to resolve the situation.
> >
> > Additionally, this fd can be passed between processes and over fork so a
> > per-process limit simply does not make sense.
> >
> > There is precedent for addressing this issue - io_uring, perf, skbuff,
> > iommufd and xdp all perform the precise lifetime management required here
> > using an alternative method - tracking the number of locked pages in
> > struct user_struct->locked_vm.
> >
> > Add secretmem to this list and account locked folios over the lifetime of
> > the inode to reflect the actual lifetime of the folios, while bypassing
> > this if the user has the CAP_IPC_LOCK capability.
> >
> > As a result the semantics change - the RLIMIT_MEMLOCK limit is per-user not
> > per-process to reflect the actual scope of the allocated folios, and this
> > limit is shared between secretmem and io_uring, etc.
> >
> > However this is reasonable given the need to track this limit in the actual
> > scope in which it applies.
> >
> > Since GUP rejects secretmem mappings, setting VMA_LOCKED_BIT does not
> > result in memory being faulted in on map, another wrinkle with the mlock()
> > accounting.
> >
> > This also leads to another oddity from the previous implementation -
> > mlock_future_ok() was checked on mmap() but since nothing is faulted in
> > right away, this check was more or less meaningless. Therefore drop this.
> >
> > There is simply no reason to carry on marking the mapping as mlock()'d
> > since it's misleading and the lifecycle is now correctly handled, so remove
> > this too.
> >
> > Additionally, fix the selftest which checks the limit as this now must
> > assert SIGBUS on limit violation on fault-in.
> >
> > Also assert there that the limit applies to the lifetime of the fd rather
> > than the mapping by trying to map a single page past the maximum rlimit -
> > previously this would have succeeded as the prior unmap would have reset
> > the mlock limit.
> >
> > __secretmem_account_pages() is essentially a duplicate of the code that
> > io_uring etc. use, but since this is a bug fix that needs backporting,
> > defer any de-duplication efforts to a follow-up.
>
> Can the commit message here be a page rather than a folio? ;-)

It's a very involved problem and the solution is subtle, imperfect, and needs to
be clearly argued.

So sorry, it's order-9+ folio-shaped ;)

>
> > Reported-by: Daehyeon Ko <4ncienth@gmail.com>
> > Closes: https://lore.kernel.org/linux-mm/20260813225328.2010303-1-4ncienth@gmail.com/
> > Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
> > index 4cc52698e214..8d7e5521f7cd 100644
> > --- a/include/linux/sched/user.h
> > +++ b/include/linux/sched/user.h
> > @@ -25,7 +25,8 @@ struct user_struct {
> >
> >  #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
> >  	defined(CONFIG_NET) || defined(CONFIG_IO_URING) || \
> > -	defined(CONFIG_VFIO_PCI_ZDEV_KVM) || IS_ENABLED(CONFIG_IOMMUFD)
> > +	defined(CONFIG_VFIO_PCI_ZDEV_KVM) || IS_ENABLED(CONFIG_IOMMUFD) || \
> > +	defined(CONFIG_SECRETMEM)
> >  	atomic_long_t locked_vm;
> >  #endif
> >  #ifdef CONFIG_WATCH_QUEUE
> > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > index d29865075b6e..537fe5b1222f 100644
> > --- a/mm/secretmem.c
> > +++ b/mm/secretmem.c
> > @@ -18,6 +18,8 @@
> >  #include <linux/secretmem.h>
> >  #include <linux/set_memory.h>
> >  #include <linux/sched/signal.h>
> > +#include <linux/sched/user.h>
> > +#include <linux/cred.h>
> >
> >  #include <uapi/linux/magic.h>
> >
> > @@ -47,10 +49,107 @@ bool secretmem_active(void)
> >  	return !!atomic_read(&secretmem_users);
> >  }
> >
> > +struct secretmem_inode_state {
> > +	struct user_struct	*user;
> > +	atomic_long_t		nr_pages_accounted;
> > +};
> > +
> > +static bool __secretmem_account_pages(struct user_struct *user,
> > +		unsigned long nr_pages)
> > +{
> > +	unsigned long page_limit, cur_pages, new_pages;
> > +
> > +	if (!nr_pages)
> > +		return true;
> > +
> > +	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > +
> > +	cur_pages = atomic_long_read(&user->locked_vm);
> > +	do {
> > +		new_pages = cur_pages + nr_pages;
> > +		if (new_pages > page_limit)
> > +			return false;
> > +	} while (!atomic_long_try_cmpxchg(&user->locked_vm,
> > +					  &cur_pages, new_pages));
> > +	return true;
> > +}
> > +
> > +static bool secretmem_account_folio(struct secretmem_inode_state *state,
> > +		const struct folio *folio)
> > +{
> > +	unsigned long nr_pages;
> > +
> > +	if (!state)
> > +		return true;
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
> > +	if (!state)
> > +		return;
> > +
> > +	__secretmem_unaccount_pages(state, folio_nr_pages(folio));
> > +}
> > +
> > +static void secretmem_unaccount_all_folios(struct secretmem_inode_state *state)
> > +{
> > +	unsigned long nr_pages_accounted;
> > +
> > +	if (!state)
> > +		return;
> > +
> > +	nr_pages_accounted = atomic_long_read(&state->nr_pages_accounted);
> > +	__secretmem_unaccount_pages(state, nr_pages_accounted);
> > +}
> > +
> > +static void secretmem_destroy_inode_priv(struct inode *inode)
> > +{
> > +	struct secretmem_inode_state *state = inode->i_private;
> > +
> > +	if (!state)
> > +		return;
> > +
> > +	secretmem_unaccount_all_folios(state);
> > +	free_uid(state->user);
> > +	kfree(state);
> > +}
> > +
> > +static int secretmem_init_inode_priv(struct inode *inode)
>
> Can _init and _destroy live closer to their callers please?

OK.

>
> > +{
> > +	struct secretmem_inode_state *state;
> > +
> > +	if (ns_capable_noaudit(&init_user_ns, CAP_IPC_LOCK))
> > +		return 0;
>
> The check happens only on inode creation, so if a privileged process,
> e.g. a container engine, passes the fd to an unprivileged process, the
> accounting issue remains.

Hmm, yeah and I guess that is a secretmem process.

And the actual bug is that somebody can unmap then remap then ftruncate(), and
this would re-open that again.

I think best to just remove the check.

Updating but not enforcing for CAP_IPC_LOCK is problematic too since any
unprivileged process that happens to fault will get yeeted while privileged ones
are fine and that's not what you want.

And privileged processes can increase the lock limit as necessary anyway.

Probably sensible users of this fault in early anyway.

So yup will remove the check (also simplifies the code).

>
> > +
> > +	state = kzalloc_obj(*state, GFP_KERNEL);
>
> GFP_KERNEL is implicit for kzalloc_obj(), isn't it?

OK, will fix.

>
> > +	if (!state)
> > +		return -ENOMEM;
> > +
> > +	state->user = get_uid(current_user());
> > +	inode->i_private = state;
> > +	return 0;
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
> > @@ -72,8 +171,15 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> >  			goto out;
> >  		}
> >
> > +		if (!secretmem_account_folio(state, folio)) {
>
> Oh, this is getting really hairy :(
> We need better gotos in secretmem_fault(), it could be a nice
> preparation patch, but I don't feel very strongly about it.

I'm accounting for the fact that it's intended for backport so not doing
cleanups alongside it.

This is correct and was checked very carefully :)

>
> > +			folio_put(folio);
> > +			ret = VM_FAULT_SIGBUS;
> > +			goto out;
> > +		}
> > +
> >  		err = set_direct_map_invalid_noflush(folio_page(folio, 0));
> >  		if (err) {
> > +			secretmem_unaccount_folio(state, folio);
> >  			folio_put(folio);
> >  			ret = vmf_error(err);
> >  			goto out;
> > @@ -82,6 +188,7 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> >  		__folio_mark_uptodate(folio);
> >  		err = filemap_add_folio(mapping, folio, offset, gfp);
> >  		if (unlikely(err)) {
> > +			secretmem_unaccount_folio(state, folio);
> >  			/*
> >  			 * If a split of large page was required, it
> >  			 * already happened when we marked the page invalid
> > @@ -115,19 +222,17 @@ static const struct vm_operations_struct secretmem_vm_ops = {
> >  static int secretmem_release(struct inode *inode, struct file *file)
> >  {
> >  	atomic_dec(&secretmem_users);
> > +	secretmem_destroy_inode_priv(inode);
> > +
> >  	return 0;
> >  }
> >
> >  static int secretmem_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > -	const unsigned long len = vma_desc_size(desc);
> > -
> >  	if (!vma_desc_test_any(desc, VMA_SHARED_BIT, VMA_MAYSHARE_BIT))
> >  		return -EINVAL;
> >
> > -	vma_desc_set_flags(desc, VMA_LOCKED_BIT, VMA_DONTDUMP_BIT);
> > -	if (!mlock_future_ok(desc->mm, /*is_vma_locked=*/ true, len))
> > -		return -EAGAIN;
> > +	vma_desc_set_flags(desc, VMA_DONTDUMP_BIT);
> >  	desc->vm_ops = &secretmem_vm_ops;
> >
> >  	return 0;
> > @@ -192,15 +297,23 @@ static struct file *secretmem_file_create(unsigned long flags)
> >  	struct file *file;
> >  	struct inode *inode;
> >  	const char *anon_name = "[secretmem]";
> > +	int err;
> >
> >  	inode = anon_inode_make_secure_inode(secretmem_mnt->mnt_sb, anon_name, NULL);
> >  	if (IS_ERR(inode))
> >  		return ERR_CAST(inode);
> >
> > +	err = secretmem_init_inode_priv(inode);
> > +	if (err)
> > +		goto err_free_inode;
> > +
> >  	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
> >  				 O_RDWR | O_LARGEFILE, &secretmem_fops);
> > -	if (IS_ERR(file))
> > +	if (IS_ERR(file)) {
> > +		secretmem_destroy_inode_priv(inode);
>
> Please use goto for error handling here.

I guess you mean something like the below. OK.

err_free_inode_priv_inode:
	secretmem_destroy_inode_priv(inode);
err_free_inode:
	iput(inode);
	return ERR_PTR(err);

>
> > +		err = PTR_ERR(file);
> >  		goto err_free_inode;
> > +	}
> >
> >  	mapping_set_gfp_mask(inode->i_mapping, GFP_USER);
> >  	mapping_set_unevictable(inode->i_mapping);
> > @@ -218,7 +331,7 @@ static struct file *secretmem_file_create(unsigned long flags)
> >
> >  err_free_inode:
> >  	iput(inode);
> > -	return file;
> > +	return ERR_PTR(err);
> >  }
> >
> >  SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
> > diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
> > index aac4f795c327..626e7033b72f 100644
> > --- a/tools/testing/selftests/mm/memfd_secret.c
> > +++ b/tools/testing/selftests/mm/memfd_secret.c
> > @@ -15,6 +15,8 @@
> >  #include <sys/resource.h>
> >  #include <sys/capability.h>
> >
> > +#include <setjmp.h>
> > +#include <signal.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <unistd.h>
> > @@ -22,6 +24,8 @@
> >  #include <stdio.h>
> >  #include <fcntl.h>
> >
> > +#include <sys/mman.h>
> > +
> >  #include "kselftest.h"
> >
> >  #define fail(fmt, ...) ksft_test_result_fail(fmt, ##__VA_ARGS__)
> > @@ -31,6 +35,7 @@
> >  #ifdef __NR_memfd_secret
> >
> >  #define PATTERN	0x55
> > +#define MLOCK_LIMIT_CAP	(8UL << 20)
>
> A comment about why capping at 8MB would be nice.

OK.

>
> >  static const int prot = PROT_READ | PROT_WRITE;
> >  static const int mode = MAP_SHARED;
> > @@ -39,6 +44,13 @@ static unsigned long page_size;
> >  static unsigned long mlock_limit_cur;
> >  static unsigned long mlock_limit_max;
> >
> > +static sigjmp_buf fault_env;
> > +
> > +static void sigbus_handler(int sig)
> > +{
> > +	siglongjmp(fault_env, 1);
> > +}
> > +
> >  static int memfd_secret(unsigned int flags)
> >  {
> >  	return syscall(__NR_memfd_secret, flags);
> > @@ -57,10 +69,32 @@ static void test_file_apis(int fd)
> >  		pass("file IO is blocked as expected\n");
> >  }
> >
> > -static void test_mlock_limit(int fd)
> > +/* GUP disallows automatic fault-in of secretmem, so do it manually. */
> > +static bool fault_in_secretmem(char *mem, size_t len)
> > +{
> > +	if (sigsetjmp(fault_env, 1))
> > +		return false;
> > +	memset(mem, PATTERN, len);
> > +	return true;
> > +}
> > +
> > +static void test_mlock_limit(void)
> >  {
> >  	size_t len;
> >  	char *mem;
> > +	int fd;
> > +
> > +	/* Locked pages have an inode lifetime, so need a new fd. */
> > +	fd = memfd_secret(0);
> > +	if (fd < 0) {
> > +		fail("memfd_secret failed: %s\n", strerror(errno));
> > +		return;
> > +	}
> > +
> > +	if (ftruncate(fd, mlock_limit_max * 2)) {
> > +		fail("ftruncate failed: %s\n", strerror(errno));
> > +		goto out_close;
> > +	}
>
> Can't we ftruncate to this size in main and be done?

I think we should be able to, will change unless it's somehow a problem.

>
> >
> >  	len = mlock_limit_cur;
> >  	if (len % page_size != 0)
> > @@ -69,19 +103,48 @@ static void test_mlock_limit(int fd)
> >  	mem = mmap(NULL, len, prot, mode, fd, 0);
> >  	if (mem == MAP_FAILED) {
> >  		fail("unable to mmap secret memory\n");
> > -		return;
> > +		goto out_close;
> > +	}
> > +
> > +	if (!fault_in_secretmem(mem, len)) {
> > +		munmap(mem, len);
> > +		fail("unable to fault in secret memory\n");
> > +		goto out_close;
>
> Please don't mix cleanup styles, goto err_do_cleanup is the preferred
> way.

OK will change.

>
> --
> Sincerely yours,
> Mike.
>

--
Cheers, Lorenzo
