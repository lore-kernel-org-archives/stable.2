Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D040802F
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760913; cv=none; b=uCYVIJRiJt+JFBRu/oVczzTciOieN0mqdfIo700nO8veyRlKcRXJULzKaUMjrtNlcWSwBpVC1JRGMokc8MkwnmJVG6+5LKfklDgliuWwGFPyyEVT3UHRk3J1MZ+11kxrT2jPpnJwbQg+2kReynZSqcOiq8UBUvPd019oqhZ/0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760913; c=relaxed/simple;
	bh=VtwXvO03/d0Np5b75y/sGJIOp+lh4BJuGwz96xd5TZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlsNq3xMvJFHLUT71RmBCxm+YY/wf9se81mP5txQBrQWWjHa6SbaMcbq3CtMCUmvJGBOOGRwTQHVZ6GQo84gDca/NZufG60TG/Q5aSlNt0/KJRdX/+WiLFTFOifQDi0bOHQgOdikRnlONpwH3DizJnOdkaUGqdRmI7xk8g9cL0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YndVUhhs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rxaAgSfH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T+pUauja; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DUEa6KbP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YndVUhhs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rxaAgSfH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T+pUauja";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DUEa6KbP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 18F377F0E6;
	Mon,  3 Aug 2026 12:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785760905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ODL6gCk8lof5B/HMStAKTE/E0Vq5yUl2rgXGKUHBio=;
	b=YndVUhhsn6D+xFCay2LMawar+ReWclRkw0K5TrxNoDo7HKj5P8kfn0p0wA/kIrgVjguYEn
	B+7gcaYxJpC0ouMiWbRla7tPefR4OAs8tfvZZUeDV9Of2cI0eqoV7AM/2coLKtyeQ7xSmD
	7T045LAIgwFm39g+PRGd0J6xQ+Pg6ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785760905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ODL6gCk8lof5B/HMStAKTE/E0Vq5yUl2rgXGKUHBio=;
	b=rxaAgSfHajmj2MULUhqVM9DoGPlRJIjG+f6wT/HWG2LWYwll1qfjEjP0FCZ7J/Ivf/QNa0
	F0Mq+25xMD/Oc3Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785760901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ODL6gCk8lof5B/HMStAKTE/E0Vq5yUl2rgXGKUHBio=;
	b=T+pUaujadhUEuzF7AIYqqNeI6LapYg3PXnwUPFVlo/5vy3LGvd9eDpA2VA+oj5/0MAM3Wt
	nkAR7pCNV/J21jLpSIWw8/ri5F+floyzpUlreyhWtzY57kOO0hynLtsAmj/M5aU+VxsOU2
	4XbNneXfDF6WIeoM6SU79ltF5/7nWMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785760901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ODL6gCk8lof5B/HMStAKTE/E0Vq5yUl2rgXGKUHBio=;
	b=DUEa6KbPFzZTiB+sI1npko+DVVChlHKpZ9fVEgKgILoCLtiKoqwKNh0nsyLI2RubGfRQEn
	6m+G7cmj6hao5DCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14A75779A1;
	Mon,  3 Aug 2026 12:41:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 98s4AYOMcGpuWAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 03 Aug 2026 12:41:39 +0000
Date: Mon, 3 Aug 2026 13:41:37 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Steffen Dirkwinkel <lists@steffen.cc>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	"Denis V. Lunev" <den@openvz.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Juergen Gross <jgross@suse.com>, 
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org, 
	syzbot@syzkaller.appspotmail.com, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Message-ID: <anCK3eWFMwZqq5ka@pedro-suse>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <555ea1d43a12c30a8f1eaf10c899b3790d728f33.camel@dirkwinkel.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bh5jbue2ogdsvams"
Content-Disposition: inline
In-Reply-To: <555ea1d43a12c30a8f1eaf10c899b3790d728f33.camel@dirkwinkel.cc>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[steffen.cc:email,opensuse.org:url,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,openvz.org,linux-foundation.org,kernel.org,alien8.de,gmail.com,redhat.com,ziepe.ca,suse.com,intel.com,infradead.org,zytor.com,linux.dev,google.com,hpe.com,lists.linux.dev,vger.kernel.org,kvack.org,syzkaller.appspotmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RL3mhzhn45zpqpmgqn4z7synfm)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,steffen.cc:email,opensuse.org:url,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	HAS_ATTACHMENT(0.00)[]


--bh5jbue2ogdsvams
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 30, 2026 at 05:53:50PM +0200, Steffen Dirkwinkel wrote:
> Hello,
> 
> 
> On Tue, 2026-07-28 at 16:07 +0300, Mike Rapoport (Microsoft) wrote:
> > There are a couple of CPA fixes floating around:
> > 
> > Denis Lunev fixed races between split and collapse of the large mappings:
> > 
> > https://lore.kernel.org/all/20260715183453.2381141-1-den@openvz.org
> 
> We saw the error below and I was wondering if it might be related to these fixes
> or a similar case that's unfixed still. Seems to have happened during concurrent
> kernel module loading of kvm and i915 (similar to the case in the patch from
> Denis Lunev). But we got it without KASAN and the stack looks a little
> different. I was not able to reproduce this with a ~16 hour concurrent module
> load unload loop so far.
> 
> Kernel: v7.1.5, PREEMPT_RT, tainted because of /dev/msr access
> CPU: Elkhart Lake Atom X6214RE, 2 cores, isolcpus=1-N
> 
> ------------[ cut here ]------------
> kernel BUG at arch/x86/kernel/alternative.c:2644!
> Oops: invalid opcode: 0000 [#1] SMP NOPTI
> CPU: 0 UID: 0 PID: 559 Comm: (udev-worker) Tainted: G S                  7.1.5-
> rt1-bhf-369933-f1a4ee1dd787 #1 PREEMPT_{RT,(lazy)} 
> Tainted: [S]=CPU_OUT_OF_SPEC
> RIP: 0010:__text_poke+0x356/0x3d0
> Call Trace:
>  <TASK>
>  smp_text_poke_batch_finish+0x1aa/0x3a0
>  ? vmx_switch_vmcs+0xc8/0xd0 [kvm_intel]
>  __static_call_transform+0xfa/0x1f0
>  ? vmx_switch_vmcs+0xc8/0xd0 [kvm_intel]
>  ? __pfx_preempt_schedule_thunk+0x10/0x10
>  arch_static_call_transform+0x57/0xa0
>  ? vmx_switch_vmcs+0xc8/0xd0 [kvm_intel]
>  __static_call_init+0x1aa/0x230
>  ? __SCT__tp_func_kvm_mmu_split_huge_page+0x8/0x8
>  ? __SCT__tp_func_kvm_mmu_split_huge_page+0x8/0x8
>  static_call_module_notify+0x11f/0x150

We're also observing something very similar downstream
(https://bugzilla.opensuse.org/show_bug.cgi?id=1271202) on 7.1.3 kernels, on our QA infra.

I wrote a patch that should fix it (I didn't get to test it yet, since
this didn't hit mainline/stable yet), on top of this. Mike, do you mind
throwing it on top of this series, or should I submit separately?

-- 
Pedro

--bh5jbue2ogdsvams
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-x86-alternative-exclude-text-poking-against-change_p.patch"

From 0a483fd05fda6e3953861b722995b58daf4878ef Mon Sep 17 00:00:00 2001
From: Pedro Falcato <pfalcato@suse.de>
Date: Mon, 3 Aug 2026 13:16:25 +0100
Subject: [PATCH] x86/alternative: exclude text poking against
 change_page_attr()

From time to time, the following BUG can be observed[0]:

> kernel BUG at arch/x86/kernel/alternative.c:2576!
> Oops: invalid opcode: 0000 [#1] SMP NOPTI
> CPU: 0 UID: 0 PID: 355 Comm: (udev-worker) Not tainted 7.1.3-1-default #1 PREEMPT(full) openSUSE Tumbleweed  8c1795b03ec64f997e57a8ad38b1161e3b98da64
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS unknown 02/02/2022
> RIP: 0010:__text_poke+0x2aa/0x450
> Call Trace:
>  <TASK>
>  smp_text_poke_batch_finish+0x2a7/0x320
>  __static_call_transform+0xb7/0x220
>  arch_static_call_transform+0x5b/0xb0
>  __static_call_init+0xe9/0x270
>  static_call_module_notify+0x11f/0x150
>  notifier_call_chain+0x61/0xe0
>  blocking_notifier_call_chain_robust+0x63/0xc0
>  load_module+0x1c92/0x20c0
>  init_module_from_file+0xd8/0x140
>  idempotent_init_module+0x100/0x2f0
>  __x64_sys_finit_module+0x71/0xe0
>  do_syscall_64+0xe1/0x610
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e

which matches the following BUG_ON in alternative.c:
	/*
	 * If something went wrong, crash and burn since recovery paths are not
	 * implemented.
	 */
	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));

This can happen if vmalloc_to_page() fails, for any reason. Such can happen
if text poking races with CPA, which can possibly result in the collapsing
of page tables (or breaking of PMD hugepages). It is not a problem for most
users of vmalloc_to_page() (they solely own the vmalloc'd range) but, when
CONFIG_ARCH_HAS_EXECMEM_ROX=y, various modules own a single execmem vmalloc
range, and can call set_memory_*() in parallel on it. This can happen to
race against __text_poke and cause havoc in vmalloc_to_page().

Fix it by excluding against CPA using the init_mm mmap read lock.

Fixes: 64f6a4e10c05 ("x86: re-enable EXECMEM_ROX support")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1271202 [0]
Reported-by: Steffen Dirkwinkel <lists@steffen.cc>
Link: https://lore.kernel.org/linux-mm/555ea1d43a12c30a8f1eaf10c899b3790d728f33.camel@dirkwinkel.cc/
Cc: stable@vger.kernel.org
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 arch/x86/kernel/alternative.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 62936a3bde19..9071eb870eab 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2559,6 +2559,14 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	 */
 	BUG_ON(!after_bootmem);
 
+	/*
+	 * Exclude against change_page_attr() collapse in execmem ROX regions.
+	 * These are PMD sized and this module may not own the whole PMD,
+	 * thus breakdown/collapse may happen at any moment by concurrent module
+	 * loading, which races with vmalloc_to_page().
+	 */
+	guard(mmap_read_lock)(&init_mm);
+
 	if (!core_kernel_text((unsigned long)addr)) {
 		pages[0] = vmalloc_to_page(addr);
 		if (cross_page_boundary)
-- 
2.55.0


--bh5jbue2ogdsvams--
