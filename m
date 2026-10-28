Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192112;
	b=J7rKsenMIofZIpyca2HVJH1WM6Fw3JZ8AUL/0ZI1mXiaPv6eKsucOnr7Gr/6UniPruXG
	 XpNpFQFj+eiPWxOtO1QJTJZjRhUqXQiNlkiZlHG3f24Yx1aoJQ0B+n529qlIBJht3wHb8
	 QYCKF8x1LhJ+oIEYOHDSvD0caHSSEpggE9RCmbJojEPckDV7kqbKWtxwLR3MXqfGvd7ow
	 9OSJe5FFG8u4ldTaxAnnWJprrMrR02tDAGF5VyArh1LC6PGgsmgPtav9eavXbB5tLL+n6
	 qHVy+Z2iueV1jeoKC0FV4f3DcmL7+TsJGOehfFKemZPKVTRGpLkB6d54kdw+71ws+mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192112;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=Ar7R9QMU32qAcY23nIeGRlAcN3VSNOddD17DmoDp+Wk=;
	b=oHMQ7jThbhsyE45ivREh/BKkvnArBrfhCr6h7QbYevuV1fz3FMx4RPGUp+zVdnidnYgu
	 QWgDUqYaDEw7PniozHj1HBGX3Tc5Wp3Jf1+KKlbkd7PXTAx+f1Cjt/mTcZwxcLNlioMsQ
	 c9aSyvS0vPKvG3rkJMfae/7DER08PiJrf29Arvgf6tZYfntfbGdF9XVIDcbQ29pXzy6Zt
	 xKgPKE2LeLOxFCZLNiMhS+38wntimE0huFCRxCUhyBpFsU3WEg+RoucOqwfMOW6KJ3UTK
	 HTYucPFYuEdiBT7VRqpryxmC1TMZV3JqfZlLxzxTbHGWtdj9KISewC4bOgIFSSdz44g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tEm5XV3K;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3L4wVEOZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NuxsBLoI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d7ad5oBI;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D662F606A31A;
	Wed, 28 Oct 2026 12:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D662F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tEm5XV3K;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3L4wVEOZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NuxsBLoI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d7ad5oBI
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA48322140;
	Wed, 28 Oct 2026 12:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793192110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar7R9QMU32qAcY23nIeGRlAcN3VSNOddD17DmoDp+Wk=;
	b=tEm5XV3KjbEjA41ZoYQtFK15SnyJr/jro2kAD7VcJ5Nd+xXCeh4MOSDOSl4gs16gOuMj1n
	2xE3J3A8sl5Ltrq85nxbmFf18x515DUo74zEDgzkeO03pvq4GMkN0dvsQ2UQX/6VJbcXMi
	2SihNsvbiknM4tPeVmrkd8edOj2h7vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793192110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar7R9QMU32qAcY23nIeGRlAcN3VSNOddD17DmoDp+Wk=;
	b=3L4wVEOZnbwLwpiT/6p/yUN1CGm8BCBGENEqGDXYvBfXN4ALX7tkweq+NQgRINIks9l6SY
	Oj9hq1SccSlw7FDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793192108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar7R9QMU32qAcY23nIeGRlAcN3VSNOddD17DmoDp+Wk=;
	b=NuxsBLoIZe0RCX6eCWMO4BBI2zD4MDPTwQN+oGb/8EVr6QFJtbQrfT5EbmRflQ0wO1Fq9+
	IiN60C3UHKnxFucRljWSZMNVNDbWigF0ESpMoTysxKkpo6/YVc07F+3JRBXFFVsBG8uZ8G
	IeyoyClDdnZWvRm7F4ix8zVnXzU760c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793192108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar7R9QMU32qAcY23nIeGRlAcN3VSNOddD17DmoDp+Wk=;
	b=d7ad5oBIDy9uyvYJSfVkcYBqi8kIr0BJCTIvUM3nFJwDeXTA5GEVesAI5PARxFiR78fYFd
	Yu8Y7PsZt+zW+8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6B0113419;
	Wed, 28 Oct 2026 12:55:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UmP0JKjw4WpyFgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 28 Oct 2026 12:55:04 +0000
Date: Wed, 28 Oct 2026 12:55:03 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Barry Song <baohua@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 02/46] fork: take mmap_lock before copying mm_struct
Message-ID: <auHve-G8bboW77IZ@pedro-suse.tail5790ac.ts.net>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-2-6f74bec9a5bb@kernel.org>
 <auB-3BQn_rR6IfY8@pedro-suse.tail5790ac.ts.net>
 <22b819a2-631d-468e-b724-770caf9f94e4@kernel.org>
 <CAGsJ_4z3qgCPBpCDitVTq+xiGsS=-yEhKSbEO4Lbdn9MVAHK0g@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4z3qgCPBpCDitVTq+xiGsS=-yEhKSbEO4Lbdn9MVAHK0g@mail.gmail.com>
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,cmpxchg.org,linux.dev,tencent.com,google.com,linux.alibaba.com,infradead.org,suse.com,soleen.com,suse.cz,nvidia.com,surriel.com,arm.com,intel.com,redhat.com,gmail.com,suse.de,huaweicloud.com,lge.com,gourry.net,sk.com,ziepe.ca,kvack.org,vger.kernel.org,lists.infradead.org,toxicpanda.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[65];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, Oct 28, 2026 at 03:48:09AM +0800, Barry Song wrote:
> On Wed, Oct 28, 2026 at 3:07 AM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > On 10/27/26 11:38, Pedro Falcato wrote:
> > > On Tue, Oct 27, 2026 at 12:17:22AM +0100, David Hildenbrand (Arm) wrote:
> > >> dup_mm() copies the parent's mm_struct before dup_mmap() takes the
> > >> mmap_lock. A concurrent brk() can leave the child with a stale mm->brk
> > >> and newer heap mappings, causing later brk() requests to fail.
> > >>
> > >> Other operations (e.g., PR_SET_MM) on the parent's mm_struct can similarly
> > >> cause inconsistencies.
> > >>
> > >> As a simple and robust fix, grab the parent's mmap_lock earlier. This
> > >> way we don't need to update individual mm fields in dup_mmap() and
> > >> keep missing ones. Stop updating the 4 existing members (total_vm, data_vm,
> > >> exec_vm, stack_vm), as that is now no longer required.
> > >>
> > >> Keep releasing the parent's mmap_lock in dup_mmap(), before
> > >> userfaultfd completion, to avoid moving the userfaultfd handling into the
> > >> caller. This should get cleaned up later.
> > >>
> > >> Move uprobe_start_dup_mmap() to preserve the lock ordering.
> > >>
> > >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > >> Cc: stable@vger.kernel.org
> > >> Reported-by: Josef Bacik <josef@toxicpanda.com>
> > >> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > >
> > > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > >
> > > FWIW, strictly speaking malloc() isn't usable in a forked
> > > (multi-threaded) child, but glibc/musl provide this in a best-effort way.
> >
> > Yeah, I'm more concerned about other things that can race ... :)
> 
> Regarding the race with memcpy(mm, oldmm, sizeof(*mm)), we
> still have one [1] even after this patch.
> 
> That is, copying mm_struct can happen concurrently with
> lru_gen_del_mm(). However, this race doesn't seem harmful.
> I might be missing something here though.

I don't think it's harmful as well. mm_init() reinitializes those fields.

Though I hate that memcpy. I think that ideally we copy by member and
data_race() benign races, like what is done in vm_area_init_from().

Anyway, KCSAN reports aren't the most serious thing in the world, so this can
(should?) be cleaned up later.

-- 
Pedro
