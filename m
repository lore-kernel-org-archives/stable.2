Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E1019D07E
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 05:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449600; cv=none; b=enc4Qgfa3DwXpOAEGMd9Mpf16IwSdsLJRL+PdDDVsWcVjyUiKhx7YePuQ0z66pTyir94T/5nIJVSxtcQJkZxzdtVkZcNcd6H4qOV05Pxzt26YaNZ8wOKIjBvqGyC2GeHxBmdP7m/pmUCwguNv4ZfIwSfWXJv9gvyO1Iyc8Gs0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449600; c=relaxed/simple;
	bh=gNcrHum2h1i2kbH/WlpN4W1849JxGf0TTmLYcZ1KnuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4g2EFp9thHZpjgwgsszXqlNA0Pk++bZXlLQIMrt7qX5zP2sd8t4pJX4V53IDffi71MtddBbseFgyCpkLDSODvOALAbt9pTcWvdVKu0SxMZpUEOXTkKW/rtBcsRa5d/jv1CtCJpFCsxX9afpd6iTKjrKSJGMqUa49E7PetE0H3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ryw8RcSB; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ryw8RcSB"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-939e59ff27eso393512585a.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 22:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789449597; x=1790054397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lEsdiGwvz+hN4Uya5W3W3ek2drBfy1jE28a344uCWRE=;
        b=Ryw8RcSBGyPqH+MDZkUINMSQaaaUzeXCgfoakUbIVQ4mOgwsNQplnK7uCY6ykQRENV
         /H6oSn1nq0/DXK4IgAbgoMXlrqlW7/4eCuBwgCkx65jdz7xmXPXDG7EGQasl9bJTEQIl
         hsxx6WTmO5ne2XBy8n9vh66S6UZofLUddb2MHnF7R+pbRcZlFj8kd3OnUVPmwn3IVi6R
         +C1o3GMZizO3IMmfLLMwhwU/9ffty9Tbi4t7r2n+bVn3jYLC4XRMbP5QHkT02wMHn1W4
         159nyLhEGq823AULSDfsf8RoM0dhODR0Yr7S7E4p3i4rHvGaD/+5eixlZdKPL0uKU1uj
         omZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789449597; x=1790054397;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lEsdiGwvz+hN4Uya5W3W3ek2drBfy1jE28a344uCWRE=;
        b=uJp2icHLNb8tFjjlvWJIyeR2j+LkAkd/4G9KBQXwDYSQMh4N5DvA9yeKyiyMwJxikT
         ySkynrwHpGVPg1OXGu7+ELxjPHNiazqollM4UiakN/kpf4O4Gty+UImbCd4TWEyA2TBg
         n0AFDD9TKHBND/8bViMp4QKEg0kai2tmUotj0BmM1DWjwGqNcqr/yQqlyEnfJfaaRibk
         tcMYLpT8q7FOYpmiQzR+ySW5eP6GuStlnxp5D4GNMMQkb0O0zXS2YbB23+DhJX18RIV5
         pQZIn+bpRhHO6A64A11RtAcNxIlVVRSIVQBEsVNI3yZwbHCoJGY/h+vUz7vNERPJGhkZ
         IhsA==
X-Forwarded-Encrypted: i=1; AKwUvBxo8BX41uESNLXPnQ/HMj5/HE/+0BcDLMZnUhNYXs+h8mMDv1qH0a6N4cbQxjXG5i7/DG06u6Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mSn2Z0Ih/WBg5go/9tNVYFjebHuXBIL7amsYq7I9rCdGxEalL2
	IezOfiLD7L6pIZLqn1R/scl8ssWFOv5Y37yGeVeHlEJPV9c+/KfQYesIAW3i9Bm+AkY=
X-Gm-Gg: AYBFou0E+mX9lYBrpzZY7jiR675XkCMPJ2WYK/HzMdb4B7MPtg0ATaBf/T9gd99XANR
	oF/q6mZjJRF0H/+QV2cJYeY2E4pfKA9gZwtHLz5eY43MzK4pmqRqKObchM/5F/Xeh3Ltpf6LiSz
	2vUA+ZkASEivC8yTAD82/IMv58+NlA/xjMvWLZQsPmgzg/EkleoJYGW5S7BmoacDRhw3H7h6pR+
	omuyyiz+xs43AKwW6YSVyKVKQCHuu8Dlsf4p6WoUpfXiQF3DQvm3m8GvvSQkMn9N+pj3D/XB++T
	bJ77Yp9Na63BRVMCVl8r/SDXda8p4N5SMoX1m+fxg+DauZknB6uTlMzg9ALLtogRMH8q8Z7K3aY
	VDuKhWgzmGyvGaLcAeQRyXw4KDHVInFWBzBCC89AmqYMIXvkKvfgW4yxN/2/OG19WpXLcRZatTY
	jasIKuMHQxzydHYZ7NBRIEEDoQRjSq9/ZUBv26PfGp+g2QQevbZIGQWuxiOYt0rUrMkIpiqtu/n
	9I77CGLof/GTojZwhRiaq1Cz4iWgU2Oi3oCaOBYP6OgkEKFH74PmHA=
X-Received: by 2002:a05:620a:45a9:b0:936:576e:227b with SMTP id af79cd13be357-93a29939976mr829769385a.24.1789449592537;
        Mon, 14 Sep 2026 22:19:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e811b572sm1191802485a.47.2026.09.14.22.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:19:52 -0700 (PDT)
Date: Tue, 15 Sep 2026 01:19:50 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, jannh@google.com, pfalcato@suse.de, peterx@redhat.com, 
	jgg@ziepe.ca, david@kernel.org, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] proc/task_mmu: handle special PMDs in clear_refs and
 pagemap
Message-ID: <aqjS0xWes7fhhI9A@gourry-fedora-PF4VCD3F>
References: <20260912122822.3348978-1-gourry@gourry.net>
 <20260914214910.a22cfcdc250bfbb6b14edaf8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914214910.a22cfcdc250bfbb6b14edaf8@linux-foundation.org>

On Mon, Sep 14, 2026 at 09:49:10PM -0700, Andrew Morton wrote:
> On Sat, 12 Sep 2026 08:28:22 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> > mshv_vtl_low can install a special PMD from a PFN supplied in the mmap file
> > offset.  That PFN need not have a memmap entry.  Reading /proc/PID/pagemap
> > or writing /proc/PID/clear_refs for such a mapping oopses the kernel.
> > 
> > With a test driver mapping the PFN at the 1 TiB mark:
> > 
> >   echo 1 > /proc/self/clear_refs
> > 
> >   BUG: unable to handle page fault for address: fffffb5b80000008
> >   #PF: supervisor read access in kernel mode
> >   #PF: error_code(0x0000) - not-present page
> >   RIP: 0010:clear_refs_pte_range+0xb1/0x1e0
> >   Call Trace:
> >    walk_pgd_range+0x50a/0xad0
> >    __walk_page_range+0x6a/0x1d0
> >    walk_page_range_mm_unsafe+0x193/0x230
> >    clear_refs_write+0x18e/0x3f0
> > 
> >   pread(pagemap_fd, buf, 512 * 8, addr / PAGE_SIZE * 8)
> > 
> >   BUG: unable to handle page fault for address: fffff57840000008
> >   RIP: 0010:pagemap_pmd_range+0x3cf/0x6b0
> >   Call Trace:
> >    walk_pgd_range+0x50a/0xad0
> >    __walk_page_range+0x6a/0x1d0
> >    walk_page_range_mm_unsafe+0x193/0x230
> >    pagemap_read+0x1dc/0x350
> > 
> > clear_refs_pte_range() passes the PMD to pmd_folio(), while
> > pagemap_pmd_range_thp() uses pmd_page() followed by page_folio().
> > 
> > Both paths assume the PFN has a struct page and dereference bad address.
> > 
> > Use vm_normal_folio_pmd() and vm_normal_page_pmd() so clear_refs skips
> > folio operations and pagemap skips folio-derived flags for special PMDs.
> > This matches the PTE paths, which already use vm_normal_folio() and
> > vm_normal_page().
> > 
> > Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
> > Cc: <stable@vger.kernel.org> # v6.19+
> 
> Why cc:stable?  Is a crafted test driver the only way of hitting this?
> 

Technically reachable via mshv_vtl_low, so i tagged it stable.

It's hard to make a judgment call on some of these - so I err on the
side of backporting.  Feel free to drop stable if you think it's not
worth it.

~Gregory
