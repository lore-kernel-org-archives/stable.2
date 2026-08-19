Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB9440636
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787171639; cv=none; b=Gzy8zWMyaqL0VdMB2paTRUNWb3i34D/yE5HrIH8ga7pjW7eNRkaW6xw8oabaTOn1cLskRONXabVKSMx1iCCOIB++VOfFbAStUFhtVKVG8dAPUSQXgQrAESmpGhPT6Y352o5jZIK3QsOb1/GrJC25u+dV9IFLE2yrjTBzBrOpl7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787171639; c=relaxed/simple;
	bh=bvijR6UOVgGrT1+tBf081NUxEFiDBwRj6/iaXp2oNgM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nCCPgnrOTJN6SqPysC/Y4icmeGgGmQVl8oxUcSy1jPOab9AgBrj+QUlR1F9JSWvgc1mYqGnUmSQLrbdK8VcRPm7x6ddk44OU9sVi6twj8HQxo50sb7OlqLRB8msIAu/iP1ghj+eBb00JRsGCUGuKIkvBnqK0Chpvea3Vu+dRPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ozPJuFDo; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ozPJuFDo"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66c70f05859so2611411d50.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 13:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787171637; x=1787776437; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JJDZ3zG6BST+HSWSWwE8GsdZoVMnM7ou/ROzox6VqsE=;
        b=ozPJuFDov2/LqWqL1UOQtOwU3dLIdQN7ZyILPofc15tchfbFofFAeH2HvFRL0317ZH
         CHZjcp2eBLOTbJAUcUcaSTWgWsWEV4mMpMMKUXWPpzz4FE5ZFbf3wd28+NjmO+3huy/4
         9pxGvy2k/y708aQpSNK6JsBmakyNb3kLFuX+LHaOtCdJS2H0EDynzq0PsaL4NUR1B835
         GGmgR/hhEiloYBgBUyAE8lRuW9KpWBaP882u7ua/k9r1+4/B50+U0B9CqXfFWAfYRIGI
         QWQ36Dzs3UK6no73kbvo8P444j8G3Z8zKMOfvgvxQF2NBNc/IxHR8TeCSY0jBz9B3rdu
         CTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787171637; x=1787776437;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JJDZ3zG6BST+HSWSWwE8GsdZoVMnM7ou/ROzox6VqsE=;
        b=VyIKqBHb93wjpIDDRkUqITTAj0LzCNFvLbMcxQiSasZVhK+ELWKetn93fPCSDqHBP4
         0cg+fFz+vd4EesB9k/h0bOaivSvcwrMv3Jcy0dKJLyDtSO8QjR5my/uSPWCQNYM1wazW
         KDCwwgEcNSmR0drYNmCDV5/VXZ70XBgCQG9Bcuq7OI6TnXk87cJwFGx5vUlHPmam32Pc
         DlOWlhGfvPxgbDDo2WcEHeFo5oeJGq+8nu82W2/h1T8R0aW5QhZS0WFERULVxQTfh8n6
         6XBFz6/KwwN5KoIWO/8h7cS3c2EMu1I6TFK6u2iNGqiatQ3PGl+DtcBOZO0+xBQli4HB
         ru9A==
X-Forwarded-Encrypted: i=1; AHgh+Rp8SaE7MLKnzW+EhVPrA4GwBdXAtP61tpXsrswwrMPY3BVv3zIg4RFoaPGlkNnE2ZaGrCyOJqU=@vger.kernel.org
X-Gm-Message-State: AFuF++lDWXS6t2Pe0mTV7Y00uYrvBf8BKHBEzPwh0RFIDFbQmz3dHSeL
	agBbIpdkG3lsZU1acpM4iMyQsIPj+zJnvVPX4yKh2wYEaMDwemWzzleBVo7nGKU4TA==
X-Gm-Gg: AR+sD12TPUfU2zYEdJs3BRKxTGr7qSIpOjLqwaGW38RzQDGMLirNgxJ4n9JQJyRGZ6B
	AC1obccYaYqhN9EhsVSEKkrDZlsuDVbWRTbTVDNYA8vP81raaTEyDaiBUll2wHTrciXkOFCr/P7
	doZR7f7UwiygdSkoERSzK2mpRD0PZjJm5LpfUQimeZ8i2N7h/7ZKXq58queoSwF547+qHHrXd4V
	wl+wK5+DS+UJBB3roSccxL6xwVkBR0eOGW4bkT2hA4PWgeK1XYzZrJAyP/eB87tNJpOnG3H2t3F
	gSI+SI4s2GfAWmS2aEN0DqoSK9m9RhA38cijZZx8eQBAM0uCP0d9AH7vwFF/rRrtiY7IwsmZYFL
	12mA/+r0Qa+I/uK6MlX/rm+up24xQQ6by/2FsEmF/S/A8JaZlYmf9CdkVhRCzSGOrzFIExg6aBx
	39VEqlr88z26Sh5jGyswitBA6ksK4cg4oThHaBxhTWzzmaddTJ9sMxsCZd9WE5ZAX6eqlqEZAD+
	+LLELCFLTKKweD3ggHCEr51i8Y+dH6bqd9wx6Wu9w3J+h+K
X-Received: by 2002:a05:690e:1a46:b0:663:9a0a:7b80 with SMTP id 956f58d0204a3-66ccb61cec0mr2093887d50.19.1787171636227;
        Wed, 19 Aug 2026 13:33:56 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84512e347e8sm15186657b3.20.2026.08.19.13.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:33:55 -0700 (PDT)
Date: Wed, 19 Aug 2026 13:33:42 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kas@kernel.org>
cc: Usama Arif <usama.arif@linux.dev>, Hugh Dickins <hughd@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, baohua@kernel.org, 
    baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com, 
    lance.yang@linux.dev, liam@infradead.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, ljs@kernel.org, nico.pache@linux.dev, 
    ryan.roberts@arm.com, ziy@nvidia.com, nphamcs@gmail.com, 
    hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, 
    kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio
 on zap
In-Reply-To: <aoWw_iKEDLjKL2jr@thinkstation>
Message-ID: <5bd5c5fe-0d55-9fec-aadf-477891428887@google.com>
References: <20260819101222.3732660-1-usama.arif@linux.dev> <aoWw_iKEDLjKL2jr@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 19 Aug 2026, Kiryl Shutsemau wrote:
> On Wed, Aug 19, 2026 at 03:12:22AM -0700, Usama Arif wrote:
> > zap_huge_pmd_folio() propagates the pmd young bit to the folio for the
> > file case, but not the dirty bit.  The pte path does propagate it, in
> > zap_present_folio_ptes() and so does the pmd split path, in
> > __split_huge_pmd_locked().
> > 
> > For most file mappings the omission is harmless, because writing to a
> > shared file mapping goes through page_mkwrite(), which dirties the
> > folio.  tmpfs is different: it has no page_mkwrite(), and
> > vma_wants_writenotify() is false for it, so a *read* fault on a
> > MAP_SHARED tmpfs mapping installs a writable pmd via do_read_fault().
> > do_read_fault() does not call fault_dirty_shared_page(), so subsequent
> > stores through that mapping set only the hardware dirty bit in the pmd
> > and never call folio_mark_dirty().
> >
> > A shmem folio allocated by a fault
> > is marked uptodate but not dirty (see the clear: block in
> > shmem_get_folio_gfp()), so PG_dirty is never set at all.
> > 
> > Unmapping such a folio - munmap(), or exit_mmap() when the process dies
> > - then loses the only record that it was written, because zap_huge_pmd()
> > drops the pmd without transferring the dirty bit.  Reclaim afterwards
> > sees a clean shmem folio: the whole swap-out block in
> > shrink_folio_list() is inside "if (folio_test_dirty(folio))", so
> > pageout() is skipped and the folio falls into __remove_mapping().
> > There, folio_is_file_lru() is false for a swapbacked folio, so no shadow
> > entry is created and __filemap_remove_folio(folio, NULL) simply empties
> > the i_pages slot.  The data is freed without ever being written to swap,
> > and the next fault on that index returns a freshly zeroed folio.
> > 
> > This is silent data loss for any process that keeps state in a
> > MAP_SHARED tmpfs segment across an unmap - for example a cache handed
> > from one process generation to the next through /dev/shm.  It requires
> > the folio to be PMD-mapped, so it only shows up once shmem THP is
> > enabled (which is what we did in Meta fleet and started noticing crashes);
> > with THP off the pte path transfers the dirty bit correctly.
> > It also only becomes visible when swap is enabled, because with no swap
> > device shmem folios (which are on the anon LRU) are not scanned by
> > reclaim at all, so the clean folio is never dropped.
> > 
> > Reproduced on x86_64 with a tmpfs mounted huge=within_size: read-fault a
> > 2MB-backed region, write a known pattern through the resulting mapping,
> > munmap, force reclaim of the cgroup, then re-map and read back.  Without
> > this patch the region reads back as zeros and vmstat shows zswpout 0 -
> > the data was discarded rather than swapped.  With this patch the region
> > reads back correctly and the pages are swapped out as expected.  With
> > huge=never, or when the first touch is a write, the test passes either
> > way.
> 
> +Hugh.
> 
> Oopsie.

How ghastly! Thanks for finding and fixing, Usama.

> 
> I'm confused why it took a decade to discover the bug...
> Maybe read ahead of write for shmem is too rare, I donno.

It isn't entirely clear from the report, but this is all about modifying
a 2MiB+ *hole* in a shmem file through an mmap thereof, with first fault
a read fault not a write fault.  I suppose only a few proceed in that way
(though truncating an empty file to some size and then mmap'ing that size
is very normal).

Or everybody who tried to report this bug, wrote their report into a
2MiB hole in a shmem file through an mmap thereof.

Other than holes, all shmem folios are dirty throughout (and re-marked
dirty as soon as brought back from swap): so for most, it doesn't matter
what the pmd says.

This raised a dim memory, took a while to locate what I was remembering:
e1f1b1572e8d ("mm/huge_memory.c: fix data loss when splitting a file pmd")
from 2018.

Not quite the same; but what a pity that one didn't prompt any of us
to look further and find what Usama now has.

> 
> > 
> > Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> 
> This would be more precise: b5072380eb61 ("thp: support file pages in zap_huge_pmd()")
> 
> Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
> 
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Usama Arif <usama.arif@linux.dev>

Acked-by: Hugh Dickins <hughd@google.com>
