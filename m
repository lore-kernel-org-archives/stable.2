Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A0E3403E1
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479462; cv=none; b=Vt2JlltCGp0TKgzMKBHezhzmOaUCSRjtLabuKZKQG6jP+HHLCp17nSG8bFpkU3H/sbGZVBLvxAaPf+H84+dJ4Vp/SMQAHNlL8DOkTnjMezA/KhdZHnRt1yWJFvh2jVgzCsdLytGRQUlYh7AmNo+kyz0bzdDSYRar8QlS4qdJXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479462; c=relaxed/simple;
	bh=CxuJvJ01gHjMm2lULljvuFNSSg/5K+gI13xz4M0L/yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJpll5yoNrByLoL+c8dQ49pJujQ3Fn6AT4/kG+Wcs1mzTkG44V0goSro8UWTcAhrJZutOvtF1JauA690o2OiqjQ51ps6K+JQllt2MYqEjTsF6WkaZgSMgIIXYD8wC2JUmQkNKAEy/CkRE6nkMBOwajOlxncpT7wA/qo/tceLpV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG8k1U1f; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG8k1U1f"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so167673a91.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786479461; x=1787084261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BKM2tGwtzp4e6RueqUAs7VBHsTzEw1WbCk0gGA1/KvM=;
        b=aG8k1U1f3cNz2pYSfW+Q4NAYf2gamxBz0hyD3AYJ8QwlilZy3bGn7eUjyb9eq83s6O
         TNohIGGeS7ezqYoa31j/4u5/fZlZUF7yo5Kt+8gZaXtKzPFSw4O2REuFEiMg5K7eLu1F
         35XxmLh2pvJmTYuQNKV6GUR5YLJCylQTHiSsu2vMS8W44NuhJgp315+5S8d9xuiFx8Gi
         xaJq63jvATZW9Ud11igPqO60VDBmag6VvyH+V4XDKXZYB/SoySoQ4PK4n76k/CzDgFTn
         /CUsEFWSRfHkxss4Dej0kmvMQEFW0I1Ei980yoZ2eWUmv59nJkzRlOc+QvTsuET7EgN6
         LCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786479461; x=1787084261;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BKM2tGwtzp4e6RueqUAs7VBHsTzEw1WbCk0gGA1/KvM=;
        b=GgtEruS0xbbqHvr420Gu+68hoqJl7Ri3Kg13jLFkCrYqFFxv7wuXAzU068Vt70uO7C
         FgcjiNcjV775Wq0tppeRA2677aNyeOp8BxPBDdrRzTwn6ZEhYcLWmzVTXqORNptpNYnc
         ivbvypu+ETK5L1ttRH8HdkwfBk3SqyzSAgB0mP4crnbtUbeaePZtb8uzvCaL11pUCMNy
         SqdjFq1S4fI7qD0wcycGl+qzTuZfEa+vYm0thfNiy1uX1x8XgayeSWPbVUKrFLOuvZm6
         eT9czSFgVmAUpSqnTqNxo7kDRaHD/6ztgpaDNbLsHRG8X2OMSg3jAbq1mHvrbF4r2LAD
         z23A==
X-Forwarded-Encrypted: i=1; AHgh+Rqvu0weDxHkFa1rJjkLWEvVnoyOBrkY904kZmXzyzByGkjwq3sigdiDH1Zrp2tizWuSnPVYa44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+TbD/mUSVFBB0dsXzYaoqN9M8bL0u68RQsrMQPrL+MvwEevBE
	QYxnTCjedQGBUtQvAgi2Lz37xpd3bKMP2wbulI/SWc2ONjX+1uW84Vtb
X-Gm-Gg: AR+sD138FhiejeTWDFB0azoLh6tijFIMQ8Q6+1bqjgLrt5aRRlIqnWGMrqCXGgp5U+P
	TLCmfvupqs8ud9s4qibJCc5wtTdMX50vCIcJiTgMNd9IgqcyWiZRUzLATB84otEQddtoH7xFDEI
	tdllnTTuLLOet9COauXsDjbd1Ot6W2k9xU1aw1xckOnXVoD0k2Fo+1qmp8Vviz6i5R7QpKl0Ma8
	8CWr/kSQvDpXX+2mq2KYFsmyJFgnCNtuly4YW4EFnJ2RC0Wii6DU41UJG75AzkZv3e441rrpy6v
	3CBJJoI5mXqvfSm/OXpJWg9lA5+RufRhgtrjIHNd/K6R2o22I6OEsQNTkAJucPMsrhHblGkjJgy
	KEtl88T7wzyk4qW/uI0JJr8pwyYI9modcQeyyFHke0tKQ2CIWU6B333TsS6YQvsAEu8hE+Lvin4
	30x0w1MBR8upwrD89nTAAtBg1z1N3XzPQoNWzWg1cQekvRADkPH8MOpR/X2D3Ac31PEg2ZkMtcD
	nmk2Xh8
X-Received: by 2002:a17:90b:2541:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-392ec2fc235mr7508953a91.4.1786479460554;
        Tue, 11 Aug 2026 13:17:40 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f94d5cb7sm789672a91.15.2026.08.11.13.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 13:17:40 -0700 (PDT)
Date: Wed, 12 Aug 2026 05:17:36 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Max Boone <mboone@akamai.com>,
	imv4bel@gmail.com
Subject: Re: [PATCH v2 1/2] mm/pagewalk: fix stale walk->action escaping
 walk_pmd_range()
Message-ID: <anuDYOPa0kTD9bul@v4bel>
References: <20260811161949.3879321-1-imv4bel@gmail.com>
 <20260811161949.3879321-2-imv4bel@gmail.com>
 <20260811123702.f3c60a3573e148c53ad35b97@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811123702.f3c60a3573e148c53ad35b97@linux-foundation.org>

On Tue, Aug 11, 2026 at 12:37:02PM -0700, Andrew Morton wrote:
> On Wed, 12 Aug 2026 01:18:57 +0900 Hyunwoo Kim <imv4bel@gmail.com> wrote:
> 
> > If ->pmd_entry() sets walk->action = ACTION_AGAIN, the pmd_none()
> > check is retried. The PMD entry may be cleared at the point of retry.
> > 
> > In this case, if walk->ops->install_pte is not specified, the code
> > continues to the next PMD entry in the range without resetting
> > walk->action to ACTION_SUBTREE.
> > 
> > This leaves walk->action erroneously set to ACTION_AGAIN, which is
> > incorrect.
> > 
> > This was incorrect but not problematic up until commit 3b89863c3fa4
> > ("mm/pagewalk: fix race between concurrent split and refault")
> > which updated walk_pud_range() to check for walk->action ==
> > ACTION_AGAIN upon walk_pmd_range()'s return, causing the PUD walk
> > to be retried.
> > 
> > In this case this results in duplicate walk callbacks being
> > invoked, which is erroneous and will break any caller that is not
> > idempotent with respect to this (and waste time for those which
> > are).
> 
> "break".  Please describe the breakage completely.  It's really the
> most important information in the whole effort.
> 
> IOW, when fixing a bug please describe the userspace-visible runtime
> effects of that bug.
> 
> eg, what were the results of the fuzzer?  

To be precise, this is an out-of-bounds write.

> Is there a Link:?  

This came from a local fuzzer, so there is no Link:

> A stack trace?

[    2.272695] ==================================================================
[    2.273471] BUG: KASAN: slab-out-of-bounds in __mincore_unmapped_range+0x14f/0x190
[    2.274302] Write of size 1 at addr ffff888008d9b000 by task poc/106
[    2.274966]
[    2.275154] CPU: 0 UID: 1000 PID: 106 Comm: poc Not tainted 7.2.0-rc6-00429-ga7c7074b58d2 #55 PREEMPT(lazy)
[    2.275159] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    2.275164] Call Trace:
[    2.275170]  <TASK>
[    2.275172]  dump_stack_lvl+0x53/0x70
[    2.275200]  print_report+0xd0/0x630
[    2.275210]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[    2.275219]  ? irqentry_exit+0xd2/0x670
[    2.275224]  ? irqentry_exit+0xd2/0x670
[    2.275226]  ? __virt_addr_valid+0xef/0x1a0
[    2.275239]  ? __mincore_unmapped_range+0x14f/0x190
[    2.275242]  kasan_report+0xce/0x100
[    2.275245]  ? __mincore_unmapped_range+0x14f/0x190
[    2.275248]  __mincore_unmapped_range+0x14f/0x190
[    2.275252]  mincore_unmapped_range+0x45/0x70
[    2.275254]  walk_pgd_range+0xafc/0xfc0
[    2.275261]  ? __pfx_walk_pgd_range+0x10/0x10
[    2.275264]  ? __update_load_avg_se+0x3d1/0x670
[    2.275275]  __walk_page_range+0xc0/0x310
[    2.275278]  ? __pfx_find_vma+0x10/0x10
[    2.275281]  ? finish_task_switch.isra.0+0x16d/0x4f0
[    2.275290]  walk_page_range_mm_unsafe+0x26f/0x3a0
[    2.275293]  ? __pfx_mtree_load+0x10/0x10
[    2.275298]  ? __pfx_walk_page_range_mm_unsafe+0x10/0x10
[    2.275302]  ? __free_frozen_pages+0x54d/0x7e0
[    2.275308]  __do_sys_mincore+0x132/0x380
[    2.275311]  do_syscall_64+0xf9/0x540
[    2.275316]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    2.275322] RIP: 0033:0x422ccd
[    2.275326] Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
[    2.275329] RSP: 002b:00007fffffffec18 EFLAGS: 00000287 ORIG_RAX: 000000000000001b
[    2.275337] RAX: ffffffffffffffda RBX: 0000000000000066 RCX: 0000000000422ccd
[    2.275339] RDX: 00000000004d0940 RSI: 0000000001000000 RDI: 00007ffff4000000
[    2.275340] RBP: 00000000004d0940 R08: 0000000000000100 R09: 0000000000000100
[    2.275342] R10: 0000000000000100 R11: 0000000000000287 R12: 20c49ba5e353f7cf
[    2.275343] R13: 00000000004990d3 R14: 0000000000000000 R15: 0000000000000001
[    2.275346]  </TASK>
[    2.275347]
[    2.296904] The buggy address belongs to the object at ffff888008d9b000
[    2.296904]  which belongs to the cache sigqueue of size 80
[    2.298151] The buggy address is located 0 bytes inside of
[    2.298151]  allocated 80-byte region [ffff888008d9b000, ffff888008d9b050)
[    2.299408]
[    2.299601] The buggy address belongs to the physical page:
[    2.300191] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8d9b
[    2.301001] flags: 0x100000000000000(node=0|zone=1)
[    2.301535] page_type: f5(slab)
[    2.301884] raw: 0100000000000000 ffff888107e46780 dead000000000122 0000000000000000
[    2.302687] raw: 0000000000000000 0000000800240024 00000000f5000000 0000000000000000
[    2.303489] page dumped because: kasan: bad access detected
[    2.304092]
[    2.304276] Memory state around the buggy address:
[    2.304801]  ffff888008d9af00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.305567]  ffff888008d9af80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.306340] >ffff888008d9b000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    2.307115]                    ^
[    2.307474]  ffff888008d9b080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    2.308237]  ffff888008d9b100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    2.308997] ==================================================================

> 
> > A specific example of this breaking things is mincore which walks
> > an internal cursor data structure a byte at a time on assumption
> > that page table entry callbacks are called only once for each
> > entry.
> > 
> > Fix the problem by resetting walk->action to ACTION_SUBTREE prior
> > to the none check.
> > 
> > The pattern also exists in walk_pud_range() so fix it there too.
> > 
> > This issue was found through AI-based fuzzing.
> > 
> > Fixes: 3b89863c3fa4 ("mm/pagewalk: fix race between concurrent split and refault")
> 
> It's good to cc the relevant Author(s).
> 
> > Cc: stable@vger.kernel.org
> 
> We really should tell -stable maintainers (and all other users of
> earlier kernels) all about the above things.
> 
> >  mm/pagewalk.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> This depends on the above info, but I'd prefer to process the bugfix
> promptly and defer consideration of the selftest until the next -rc
> cycle.

Should I send a v3 with the changelog fixed? (in 24 hours, I guess?)


Best regards,
Hyunwoo Kim
