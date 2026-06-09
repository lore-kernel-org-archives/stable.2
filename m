Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CFD26CE32
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971814; cv=none; b=c369i2Rk7uVFZrYNlU0DsfUEx09JcR9TBIJ1gsuUjEH4ULk0E6aeBXQFg5X5bqN1wU4JSEG48qJFVkioALFBZKoq3Qy+/iM0iGKv5UuAiUOsbOZgMlkob5SPkR1ZRI5KraRJODN0uJmziT7Zkigk5iOOWVM5ouVt9rdvu34yt/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971814; c=relaxed/simple;
	bh=pVXaxPaqvhfULBtXSsSlFGOVQ+R4wfwmvND7681yWFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxLABdNwF5V3F9d7NhDno25WEhpm2WiRqzTr/cGIn05c1b4Qg1yAa/6Y5wd2TW9kjuMyV9kXhd8LRPRjAy/WBiA+9OFw1QsACxhv7M+eIhCOzdGf9TFp47qCsrV1IyVNSyqdenvY78PY8LZjgkbCpnCnB+U292dHUWQpa/GMFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=MEIRBbvs; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MEIRBbvs"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ccf0fa0aacso71372706d6.2
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 19:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780971810; x=1781576610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1sg1EhG9c0ZhlRBhQ86dEr/peU6rOT1SETxtf5KI1s=;
        b=MEIRBbvsND2qJzEZEohzxZVVBJ/V3lFJ/5NRQqf/LoWoMn/2hXtjcAVFvf1QqwxXIt
         fCrhQzhUJivz5LdpT5gbKAHTxeSWm4YA+tsie5lE+HuzZ5vvIpqBz+Vc9tZb6yGEg0eR
         VYOSaDqLXczEUFdUh7YV68xUwUQTKrxqgZ5taXkih/g3iysux6P8L0GArG4wu1S4VtME
         su0sfvUbfPodS2KS1sx4GiBAJJPjl6dUnSlZkRrsh1e4V9o7X9gGIAwQ26ASgjvc9BQT
         fCho9mWQPr2Ke9iXLTSPDgByhH9TGMWbuoMrQf3ylZJ8M/QUsvN/gYYbVDe7OBqE+6rL
         skZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780971810; x=1781576610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1sg1EhG9c0ZhlRBhQ86dEr/peU6rOT1SETxtf5KI1s=;
        b=r89TdSLgbk70OWo8620WU06bGE3oIr73TU22E2EFNOEQlQJiOGSvujLZHFntc62ypR
         IFc243k9ZqQNL8jvEJJJdTNX6jnb6w26HL/++cTFtuasjIEAN4//P8+uB8k2NLTi++xQ
         b9VrldJVGA0gocYoAFEUTOVM8IQ6im64sVsMoUs0huDOVyLWj4Qo/UFbpm2jiEqIbVQ1
         NOGy29YSd4vZwIvNx6r/cWcp9Cuzz+u8jDDhiU01fmUywREyD85N8WnFKNSlFCWv6rCH
         6GlcQYQNxVmlzaoO58uPLNbpApFqc/iT04Ghn5+HJM9UzW1UvZlDqUmvT6s4nOs+nVVg
         p/rw==
X-Forwarded-Encrypted: i=1; AFNElJ8iwLWcg4VHS2npoUBqgITUVjgg2FLxP413L1buDXCLZsZS3HdT6I9tOgEEfMkiAqXhFRbHQ2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YweJhsh2XTtmebBpFxHd4Bx3Han3IPvJmRq1qE1SjMEsJtocGZ/
	ZDd+QAXglKrwrjYbs4Z7pc29j+EF2iaZ9+FK8V/8ioQh6xZAwba3jlhWvTlXF+IX8cc=
X-Gm-Gg: Acq92OEey75YCwxB/QpLx/xuCeEulNKyMwPG21DAhzVZ5ttT68YT8wGppVGSucaboYc
	xp7SGUKpZPKBmrpMz+iJVDT72/24TzALeUToNaQRbAEzjdJX5q7hUXkENudjv5vaqv5QrtscUhG
	wR6OXXEIc1yi6fkn1dqFlerzNfpFz+E+wnc3rN7Bowkj8pZcyvj5jS/tSrOLat7F+oGuT8R6w/q
	usq87gEndyVh72xs/U/jyDRrVqSCEOIMO/WGXLSzbSeF8FKji5I1iQue6wYh+U5bPAAktx0JVEI
	R7Re3HPNeNaW6Oe+aXCwBqQcjrRFOwiqofRNVygTk7+/KT6IeY0jzjMwD9PLyH+3JrJdU3eyebR
	8vcbohVCD09FbR05C5jrl2AtW6+opZ9vWXxL+01GbICRgegnYmAM+jK5+ccBoGeR3nggqjSUDaa
	ANLJ+iYrDpY+w2+itLitenyfjHnWDacepQORoDl7yJc680gl9ivmwEn89/Hdzu+A==
X-Received: by 2002:a05:6214:1c0b:b0:8ba:2c02:f9d6 with SMTP id 6a1803df08f44-8cee625c052mr320889586d6.35.1780971809622;
        Mon, 08 Jun 2026 19:23:29 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd263003sm188126846d6.42.2026.06.08.19.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:23:29 -0700 (PDT)
Date: Tue, 9 Jun 2026 02:23:28 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Smirnov <andrey.smirnov@siderolabs.com>, 
	pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, syzbot+2b5fe617654be3d8848b@syzkaller.appspotmail.com, 
	Thomas Gleixner <tglx@linutronix.de>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Andrei Vagin <avagin@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_table_check: do not track special (PFN-mapped)
 PTEs
Message-ID: <aid4yw9WRvZEm2BV@plex>
References: <20260608155758.1220420-1-andrey.smirnov@siderolabs.com>
 <20260608142258.5028187b1d245b46554eb2dc@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608142258.5028187b1d245b46554eb2dc@linux-foundation.org>

On 06-08 14:22, Andrew Morton wrote:
> On Mon,  8 Jun 2026 19:57:58 +0400 Andrey Smirnov <andrey.smirnov@siderolabs.com> wrote:
> 
> > The vDSO data store ("[vvar]") special mapping is created as a VM_PFNMAP
> > mapping and its pages are installed into userspace with vmf_insert_pfn(),
> > which produces special PTEs (pte_special()). On x86 and arm64 (and riscv)
> > pte_user_accessible_page() only tests the PRESENT/USER bits and does not
> > exclude special PTEs, so page_table_check accounts these PFN mappings in
> > the per-page anon/file map counters even though they are not rmap-managed
> > pages (vm_normal_page() returns NULL for them).
> > 
> > Most of these data pages live in the kernel image and are never freed, so
> > the stray accounting is invisible. The time-namespace VVAR page is the
> > exception: it is a real alloc_page() page that is released with
> > __free_page() in free_time_ns() when the last task of a time namespace
> > exits. Across the map / unmap / vdso_join_timens() zap transitions the
> > special-PTE accounting is not balanced for this page, so a non-zero
> > file_map_count survives to the free path and trips:
> > 
> >   kernel BUG at mm/page_table_check.c:143!
> >   __page_table_check_zero+0xfb/0x130
> >   __free_frozen_pages+0x52f/0x650
> >   free_time_ns+0x85/0xc0
> >   free_nsproxy+0x7f/0x130
> >   do_exit+0x313/0xa60
> >   do_group_exit+0x77/0x90
> > 
> > This is reliably reproducible on x86_64 and arm64 under heavy container/CI
> > churn that rapidly creates and destroys time namespaces (CLONE_NEWTIME via
> > runc / docker-init / tini), and was independently reported by syzbot on
> > riscv. It only manifests when CONFIG_PAGE_TABLE_CHECK is active.
> > 
> > Special PTEs have no struct-page rmap semantics and must never have been
> > tracked by page table check. Skip them in both the set and clear paths so
> > the counters stay balanced (always zero) for PFN-mapped pages, regardless
> > of how the architecture defines pte_user_accessible_page(). pte_special()
> > is available generically (it is a no-op returning false on architectures
> > without ARCH_HAS_PTE_SPECIAL), so this is a single, arch-independent fix.
> > 
> > Note that the v7.0 generic vDSO datastore rework in commit 05988dba1179
> > ("vdso/datastore: Allocate data pages dynamically") incidentally avoids
> > the problem by switching the mapping to VM_MIXEDMAP + vmf_insert_page()
> > with balanced struct-page accounting. This patch fixes the still-affected
> > VM_PFNMAP path used by 6.18.y and earlier, and additionally makes
> > page_table_check robust against any future PFN-mapped user pages.

Thank you for detailed explanation of the bug, and it makes sense to me.

> Thanks.
> 
> The patch isn't applicable to current -linus mainline.  I reworked it
> as below, then deleted it.  It would be better if this rework came from
> yourself (tested), please.  And a patch which applies will get checked
> by Sashiko AI review.

+1.

Pasha

> --- a/mm/page_table_check.c~mm-page_table_check-do-not-track-special-pfn-mapped-ptes
> +++ a/mm/page_table_check.c
> @@ -151,7 +151,15 @@ void __page_table_check_pte_clear(struct
>  	if (&init_mm == mm)
>  		return;
>  
> -	if (pte_user_accessible_page(mm, addr, pte))
> +	/*
> +	 * PFN-mapped (special) PTEs - e.g. the vDSO/time-namespace "[vvar]"
> +	 * mapping installed via vmf_insert_pfn() - are not rmap-managed and
> +	 * must not be tracked here. Tracking them can leave a non-zero map
> +	 * count on a struct page that is later freed (the time namespace VVAR
> +	 * page in free_time_ns()), tripping the BUG_ON() in
> +	 * __page_table_check_zero().
> +	 */
> +	if (pte_user_accessible_page(mm, addr, pte) && !pte_special(pte))
>  		page_table_check_clear(pte_pfn(pte), PAGE_SIZE >> PAGE_SHIFT);
>  }
>  EXPORT_SYMBOL(__page_table_check_pte_clear);
> @@ -208,7 +216,7 @@ void __page_table_check_ptes_set(struct
>  
>  	for (i = 0; i < nr; i++)
>  		__page_table_check_pte_clear(mm, addr + PAGE_SIZE * i, ptep_get(ptep + i));
> -	if (pte_user_accessible_page(mm, addr, pte))
> +	if (pte_user_accessible_page(mm, addr, pte) && !pte_special(pte))
>  		page_table_check_set(pte_pfn(pte), nr, pte_write(pte));
>  }
>  EXPORT_SYMBOL(__page_table_check_ptes_set);
> _
> 
