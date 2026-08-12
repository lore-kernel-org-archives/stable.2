Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9B4334C9;
	Wed, 12 Aug 2026 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535191; cv=none; b=cWZYVPfLrLLhm/iNRBei53d0YD6ItsE5PGRAxOM9wxSi4gCin8Gep3pHLE0QiEHZn7kc5wsBwdLn/RuSKtakUDDlYOCb8t29l9jllKlc+5O/g+6nAJFjYk6emUG+E7lBwiyCEUPgrbIXd3sUMOJmI5roSunOPm15iys4mtlJeSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535191; c=relaxed/simple;
	bh=nZ2Zmedqqh1yZKQRnlGmUyX94SM5nErzTHSmkk4+QuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKAihUDI2dzeCC4l1ziZJcHncy0To16vJYXpzSa/Cn3vci334cXu2gcisFGe0mhgWOocb/nub/O0PRBuO75DVWYqtwnSpqLTNru3EofPcBVldwpwUvn1zyquQcym8624Hbu0nqBldybaZ/g1OfVbF+7EZUAsUjn6Nm/rApg0oAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tMsqib6R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MR7iuXqS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=orB4stpy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zZDwUFpd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tMsqib6R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MR7iuXqS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="orB4stpy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zZDwUFpd"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2AB6822AA;
	Wed, 12 Aug 2026 11:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786535177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fUx2zvms+OpIRDy5HIRpqYJ3/My2Mv1XMvMmiX+J8I=;
	b=tMsqib6RmoZkk3Fm5B6AWIjHa2Lx4UAbKi9bqOwW3em+d7uQzskBRRF7xJmcrzoTohmJ2i
	vYV5W+rdTLQiGFfAh2xfL+K7Rd8CMQzunmafGerid9n2j9YtJACRVhx1Ox+V9I62wQs3Wq
	3WjflYLgf7UWffEW+qFKh7cbDgk9mAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786535177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fUx2zvms+OpIRDy5HIRpqYJ3/My2Mv1XMvMmiX+J8I=;
	b=MR7iuXqSIJQx5/oXWxV/aQyZ4sIKS0CcvvPPi1W1rRK+QPBzWFwhz5H5Tzfdcy5a9UzaUs
	bwygh7ZbUl52ZcAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786535173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fUx2zvms+OpIRDy5HIRpqYJ3/My2Mv1XMvMmiX+J8I=;
	b=orB4stpyATSV447DU1enA22k6eamKgRKWo3oEis/EYYmK09OYTpIbQsY/tujfroUbrTdeu
	AJ5MQGm9/FySDKpoPfNRqOPD+ARqds/vsZRjWdjhPZ3geJCLynA5w5LpCHvCYvR3Bh8hyg
	wk84DwKSsTlk+5bpAOxUU7aykEyPC5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786535173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fUx2zvms+OpIRDy5HIRpqYJ3/My2Mv1XMvMmiX+J8I=;
	b=zZDwUFpdaA1fbsWbteSSpBGfBMJoLQfE1xJTR4iZeLzXl18VgvoX6e9qkpAzLkLZgFmosT
	FAk1fpkzfEnhJCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1360779B1;
	Wed, 12 Aug 2026 11:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i/LyJwNdfGoXfwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 12 Aug 2026 11:46:11 +0000
Date: Wed, 12 Aug 2026 12:46:09 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Steffen Dirkwinkel <lists@steffen.cc>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Denis V. Lunev" <den@openvz.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, David CARLIER <devnexen@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org, 
	syzbot@syzkaller.appspotmail.com, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Message-ID: <anxbSdxDlyq__-T1@pedro-suse.lan>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <555ea1d43a12c30a8f1eaf10c899b3790d728f33.camel@dirkwinkel.cc>
 <anCK3eWFMwZqq5ka@pedro-suse>
 <anXvODEvV4f_Taj7@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anXvODEvV4f_Taj7@lucifer>
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[steffen.cc,linux.intel.com,openvz.org,linux-foundation.org,kernel.org,alien8.de,gmail.com,redhat.com,ziepe.ca,suse.com,intel.com,infradead.org,zytor.com,linux.dev,google.com,hpe.com,lists.linux.dev,vger.kernel.org,kvack.org,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL3mhzhn45zpqpmgqn4z7synfm)]

On Fri, Aug 07, 2026 at 04:36:08PM +0100, Lorenzo Stoakes (ARM) wrote:
> Thanks,
> 
> If Mike's going to respin worth examining this.

Thanks for taking a look!

> 
> Let me paste in the attached patch to make life easier:
> 
> >From time to time, the following BUG can be observed[0]:
> >
> >> kernel BUG at arch/x86/kernel/alternative.c:2576!
> >> Oops: invalid opcode: 0000 [#1] SMP NOPTI
> >> CPU: 0 UID: 0 PID: 355 Comm: (udev-worker) Not tainted 7.1.3-1-default #1 PREEMPT(full) openSUSE Tumbleweed  8c1795b03ec64f997e57a8ad38b1161e3b98da64
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS unknown 02/02/2022
> >> RIP: 0010:__text_poke+0x2aa/0x450
> >> Call Trace:
> >>  <TASK>
> >>  smp_text_poke_batch_finish+0x2a7/0x320
> >>  __static_call_transform+0xb7/0x220
> >>  arch_static_call_transform+0x5b/0xb0
> >>  __static_call_init+0xe9/0x270
> >>  static_call_module_notify+0x11f/0x150
> >>  notifier_call_chain+0x61/0xe0
> >>  blocking_notifier_call_chain_robust+0x63/0xc0
> >>  load_module+0x1c92/0x20c0
> >>  init_module_from_file+0xd8/0x140
> >>  idempotent_init_module+0x100/0x2f0
> >>  __x64_sys_finit_module+0x71/0xe0
> >>  do_syscall_64+0xe1/0x610
> >>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> >which matches the following BUG_ON in alternative.c:
> >	/*
> >	 * If something went wrong, crash and burn since recovery paths are not
> >	 * implemented.
> >	 */
> >	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
> 
> Ugh yeah, it seems the CPA code is just teeming with this kind of thing.
> 
> >
> >This can happen if vmalloc_to_page() fails, for any reason. Such can happen
> >if text poking races with CPA, which can possibly result in the collapsing
> >of page tables (or breaking of PMD hugepages). It is not a problem for most
> >users of vmalloc_to_page() (they solely own the vmalloc'd range) but, when
> >CONFIG_ARCH_HAS_EXECMEM_ROX=y, various modules own a single execmem vmalloc
> >range, and can call set_memory_*() in parallel on it. This can happen to
> >race against __text_poke and cause havoc in vmalloc_to_page().
> >
> >Fix it by excluding against CPA using the init_mm mmap read lock.
> >
> >Fixes: 64f6a4e10c05 ("x86: re-enable EXECMEM_ROX support")
> 
> You'd need to somehow state the dependency on commit "x86/mm/pat: acquire
> init_mm write lock on collapse to avoid UAF" from this series because this
> depends on that.

Yeah, it's supposed to be queued up on top of the series.
> 
> That only goes back to commit 41d88484c71c ("x86/mm/pat: restore large ROX pages
> after fragmentation") so you'd need to somehow indicate the backport would need
> to port my change even further back...

Hmm, I think this is the correct Fixes:...

> 
> >Reported-by: Jiri Slaby <jirislaby@kernel.org>
> >Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1271202 [0]
> >Reported-by: Steffen Dirkwinkel <lists@steffen.cc>
> >Link: https://lore.kernel.org/linux-mm/555ea1d43a12c30a8f1eaf10c899b3790d728f33.camel@dirkwinkel.cc/
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> >---
> > arch/x86/kernel/alternative.c | 8 ++++++++
> > 1 file changed, 8 insertions(+)
> >
> >diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> >index 62936a3bde19..9071eb870eab 100644
> >--- a/arch/x86/kernel/alternative.c
> >+++ b/arch/x86/kernel/alternative.c
> 
> Should include cleanup.h.
> 
> >@@ -2559,6 +2559,14 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
> > 	 */
> > 	BUG_ON(!after_bootmem);
> >
> >+	/*
> >+	 * Exclude against change_page_attr() collapse in execmem ROX regions.
> >+	 * These are PMD sized and this module may not own the whole PMD,
> >+	 * thus breakdown/collapse may happen at any moment by concurrent module
> >+	 * loading, which races with vmalloc_to_page().
> >+	 */
> 
> Worth saying what this pairs with. Right now the comment doesn't really explain
> why you're taking this lock.
> 
> >+	guard(mmap_read_lock)(&init_mm);
> 
> This is problematic.
> 
> text_poke_kgdb() -> __text_poke() can be called from pretty much any
> context it seems. It's another debug_pagealloc type situation :)
> 
> Claude tells me there's a in_dbg_master() variable you can check to avoid this
> and all other CPUs are stopped when it does this so it's safe anyway.
> 
> >+
> > 	if (!core_kernel_text((unsigned long)addr)) {
> > 		pages[0] = vmalloc_to_page(addr);
> > 		if (cross_page_boundary)
> >--
> >2.55.0
> >
> 
> I attach a patch (hand-written :) that addresses all this. Feel free to use it

Artisanal!

> as you like.
> 
> Cheers, Lorenzo
> 
> ----8<----
> From 2759f0ea4457e572c2972c7e5a0bbb39f2a9a2e5 Mon Sep 17 00:00:00 2001
> From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
> Date: Fri, 7 Aug 2026 16:23:40 +0100
> Subject: [PATCH] fix
> 
> ---
>  arch/x86/kernel/alternative.c | 39 ++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 62936a3bde19..cafcac95e90e 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -6,6 +6,9 @@
>  #include <linux/vmalloc.h>
>  #include <linux/memory.h>
>  #include <linux/execmem.h>
> +#include <linux/cleanup.h>
> +#include <linux/kgdb.h>
> +#include <linux/mmap_lock.h>
> 
>  #include <asm/text-patching.h>
>  #include <asm/insn.h>
> @@ -2543,6 +2546,30 @@ static void text_poke_memset(void *dst, const void *src, size_t len)
> 
>  typedef void text_poke_f(void *dst, const void *src, size_t len);
> 
> +static void poke_vmalloc_pages(struct page **pages, void *addr,
> +			       bool cross_page_boundary)
> +{
> +	pages[0] = vmalloc_to_page(addr);
> +	if (cross_page_boundary)
> +		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
> +}
> +
> +static void poke_vmalloc_pages_safe(struct page **pages, void *addr,
> +				    bool cross_page_boundary)
> +{
> +	/*
> +	 * execmem ROX ranges are shared between modules and can be collapsed to
> +	 * huge PMD entries, and this collapse can happen concurrently with a
> +	 * racing set_memory_rox().
> +	 *
> +	 * Prevent vmalloc_to_page() from racing by acquiring an init_mm read
> +	 * lock which pairs with the init_mm write lock in
> +	 * cpa_collapse_large_pages().
> +	 */
> +	guard(mmap_read_lock)(&init_mm);
> +	poke_vmalloc_pages(pages, addr, cross_page_boundary);
> +}
> +
>  static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t len)
>  {
>  	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
> @@ -2560,9 +2587,15 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
>  	BUG_ON(!after_bootmem);
> 
>  	if (!core_kernel_text((unsigned long)addr)) {
> -		pages[0] = vmalloc_to_page(addr);
> -		if (cross_page_boundary)
> -			pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
> +		/*
> +		 * If called from kgdb cannot sleep, but all other CPUs stopped
> +		 * anyway so safe.
> +		 */
> +		if (in_dbg_master())
> +			poke_vmalloc_pages(pages, addr, cross_page_boundary);
> +		else
> +			poke_vmalloc_pages_safe(pages, addr,
> +						cross_page_boundary);
>  	} else {
>  		pages[0] = virt_to_page(addr);
>  		WARN_ON(!PageReserved(pages[0]));

Hmm, yeah, this looks More Correct(tm), thanks!

(for the record, after this email I tried exploring if we could feasibly
Just Hold the mmap lock on callers, but it becomes messy quite quickly)

Mike, if you get to queue up my patch then please replace the diff with
Lorenzo's (with a Co-developed-by:, I guess, since he went to the trouble
of moving quite a few things around). Otherwise, I'll figure out how to
re-submit it after your series lands.

-- 
Pedro
