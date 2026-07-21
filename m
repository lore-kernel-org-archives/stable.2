Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DCB3E3DB4
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653821; cv=none; b=KnrKiasUvQkTLP1LqIuTNf0Z4wzI2rDo4x5BqlXEy5uJRbRYGDr1AnKD6pJfhTd20lpiJWq0E4P5VAPr95EWDYm5NfkfVNU4PLYjS0jGuKRTVF95BnwEMUqMeO9I6pekqSabYMmfro2+O3ZiHAmG2hiUDf/vx38f9KtQrFiC054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653821; c=relaxed/simple;
	bh=2JTgTd9toINIPryUJzZ4cjvrunjhL4Ann5jB8FnbsS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsEUkyfgFxm3+ZXpYBBVVcb/poqB18HGJdsq/ziDCu0wJJkHZkoKjlIyCFK9DL3oQDX1UcReO+38byPCp2NUhHkzoRBRMHXoOgEApEzzTYxU19M34oKdP1FL7ERqKFK0oELgPvyeP0tetUM/2MDxyUc6yDAOYMt9zc4P99/Qnf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfYrTuwc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfYrTuwc"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccf2360620so76435865ad.3
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784653820; x=1785258620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fkn3JmTHyZHrmeo+sPGbWVcJWg9Sa/ZKVruguzBjPig=;
        b=JfYrTuwciC0eNKbWbFj6cx/b3lnp4/Yz9+ZCra/h+71kTF6R7OpQgCmzY7RZBckyqM
         lCCrKJRRiCGcPxsYQQnYmcDUM/fqzjYZOEjFk3kW2TL5W8HUIDrw2wiMtK3Y2fc5qcT7
         UuvLgNvMyDwNgSVceDfKRYeGu9YINnoB2V1Nos+hlu75UewBPjw9FrKrrp4Xj+Bf1ZMg
         e8hFnRxGn7XtD+F5hTfFkPZQX2m/g2nmXQlG7cimvMcRGFy/BmBLTby4GrZa9GxXkfsr
         tSPuhWoUxkUCNzW/qjPlUyN8xkCyNMyhfxkTrKjrqyYAVl0bAIDRZBImPm6OHluVjfg6
         vjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784653820; x=1785258620;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fkn3JmTHyZHrmeo+sPGbWVcJWg9Sa/ZKVruguzBjPig=;
        b=AM3nwwekG5/q4zyLFjmDsxeLS0xBhD87sERZGur4qYQrEx8lw+nHGtsxbNcMLoXJ6f
         OoJWAYbVKZsPdmAXt9RErkXZpML6qE4cWXYF3+FpJA8/vIUzDz8tNHeoo9jlCQXdZ4sS
         xt6Edt1VSV0+npA8QoxYIpTkv/YdbEc1Lku+W26IBBl83tSA/+2G/+HrW8b/oVViEMXP
         RETjyeevNtlRjKWvVRAhMeQ+a0GgeSnStFCO+6L3MmBd/X0Q2a6LziyAszyxEKcad0N+
         fd5w60IvwjViCvT3zFkw/2/ZUy4Z6UQNxmivP19WVYDeMcMGCtJLEJSWsj7nXEu/iWyb
         y8MA==
X-Gm-Message-State: AOJu0YxwYtU5Rr8LxC3LMrBMqMEJsqwOMoRtgunfutyKfBZ70k6lCjc3
	220cqRx9F8cjvJwtHmzuuA9Ob/GXUuPePSn1JtNQDs2jxZfPQxmy8t1W
X-Gm-Gg: AR+sD10CLpSVYh6SbyvesZ/8zzHY2B1l3DlWBGNesJaMDzi5tF0LMohmaPZOPCIdxq+
	fmHckXfDGb35fWQCvp0noB9pjnpr/Aszq6K7zQWxJa49E5uhjvWwdFS8d/t5vhJ/G+5sWZjB5No
	XZNQ2P7Sc5kM5HmX4z/VD4sYyHWqCOcE7HePc/94jwJvPfeIO0DnkOYMVB3Wb2+C9CJN8YvYI/r
	TZpNDnuAn1gEdyO8byvSdLUGzZdRIrxs8wsIMitLTSGLNyj3IjVD+RKyD8RUdDmT4vDXx9gPV1n
	2odXvwbKEtypFx1/CR4uDf2uC01w5+1TbPVgccwSGnIOo7QJ8Ww5WQxa/EFKObZnqGOAx5TP2Yx
	vdGBVptgZRAo0BVBlui0HS+5ZUxC0Oj3utfiJOxkzQMAo40bpigNx6RBWa8hsi+n99eXDAOvX1X
	U1cGujr+u/UJItv5JOGR73UujW6c91C9lN3w==
X-Received: by 2002:a17:902:e541:b0:2ca:b4b9:4586 with SMTP id d9443c01a7336-2cf348b0a43mr211904095ad.19.1784653819673;
        Tue, 21 Jul 2026 10:10:19 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90:6d4e:7b2d:4a39:fb0c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1bc886sm585939eec.26.2026.07.21.10.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:10:18 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:10:16 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Kiryl Shutsemau <kas@kernel.org>,
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v2] x86/mm/pat: allocate split page tables as kernel page
 tables
Message-ID: <al-n-Eos9mc_7lvd@fedora>
References: <20260721-fix-cpa-kernel-pagetables-v2-1-2b255deed710@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721-fix-cpa-kernel-pagetables-v2-1-2b255deed710@kernel.org>

On Tue, Jul 21, 2026 at 01:14:52PM +0100, Lorenzo Stoakes (ARM) wrote:
> When splitting a large page in CPA in __split_large_page() we allocate a
> PTE directly without going through the standard page table allocation
> routines such as pte_alloc_one_kernel().
> 
> This means the page table constructor is never called nor is the page table
> marked as a kernel page table.
> 
> The former results in the folio associated with the page table not being
> marked as a page table (__pagetable_ctor() is never called thus neither is
> __folio_set_pgtable()) nor are statistics updated to reflect
> it (lruvec_stat_add_folio() is never called).
> 
> The latter issue of failing to mark the page table as a kernel page
> table (ptdesc_set_kernel() is never called) is far more problematic.
> 
> Since commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
> tables") kernel page table freeing has been batched and since the
> subsequent commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries
> for kernel address space") IOTLB cache entries for kernel page tables have
> been invalidated upon being freed.
> 
> Since split page tables are freed without this invalidation, the IOTLB can
> contain stale entries for them.
> 
> Resolve the issue by using the ordinary PTE allocation API at split time.
> 
> This results in these kernel page tables invoking a page table constructor,
> and thus requires a page table destructor.
> 
> Since we cannot assume one is always present (early allocated direct map
> page tables are not marked as such), we conditionally call
> pagetable_dtor_free() if the PG_table folio flag for the ptdesc is set,
> otherwise we free the page table via pagetable_free().
> 
> Regardless of which path is taken page tables marked as kernel page tables,
> which now includes split page tables, take the correct route through
> pagetable_free_kernel().
> 
> There is a user-visible side effect in that split page tables will appear
> in nr_page_table_pages in /proc/vmstat (as do other kernel page tables
> allocated after early boot), however this is a positive change.
> 
> This issue started being markedly problematic after commit
> 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables") so
> choose this as the Fixes target.
> 
> Fixes: 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Vishal Moola <vishal.moola@gmail.com>
