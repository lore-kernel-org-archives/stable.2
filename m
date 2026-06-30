Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18847218ADD;
	Tue, 30 Jun 2026 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792275; cv=none; b=P99epPHnUjgHDZj/adMSDYkBHLbhuWm2n6BG7VCMFLxAaEHg9bprDUiIBHa8TLFd87jqpPJZs4RCw9Rk2Kdi7oGA7IYdCJ4v34bP6LnwktxcioEcLXwCE8RBhneeKCQ1bVEyvUr3KE39fb/p5/SeWNY96GbdS/rUstvLzqyDY5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792275; c=relaxed/simple;
	bh=iRThSzdjk6tt5hS24c/DK0j99hoxWLkt2fK24mXAH1I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QYL6uFMBiLd2d7f+9q3tmwuEbS49H8VBqeRrVm75eInhPv44k3cE95Jk5haVJ2Yuq0xJLJjuDMUq+lBh6crBzwPqBsE0VyB3TxnHf9GLwk0hV0wbLSBufPcrf+enwTCvCC7oP4fngFU44hTcMpAPCK9Xdz9WWiOxJVjSO6IeXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mjU6FFPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mjU6FFPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAC61F000E9;
	Tue, 30 Jun 2026 04:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782792273;
	bh=JfxABrcsfDcW4VTbSIwcTfBacc21ZxE5i80Vw55Kf9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mjU6FFPVqm0ty5BDWsRbDuKA53i0q2nEliQq3Fsnwby+j5bvHlsL5OKva2KYmPTel
	 dBEnbJ1TFkxeK7vmT7KKCPYpZgYbIH22ZGEMppmp8HE8u01CPSRJHB2RjkhWtBUu8r
	 SqJZwmG5dblu+CcJDjW1czwpl5/LDsfvhWiZ+uy8=
Date: Mon, 29 Jun 2026 21:04:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 tongtiangen@huawei.com, pasha.tatashin@soleen.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [RESEND PATCH] riscv: mm: exclude invalid THP PMDs from page
 table check
Message-Id: <20260629210432.ef76ce885cd9ccd28b7a2127@linux-foundation.org>
In-Reply-To: <20260523042052.35476-1-cuiyunhui@bytedance.com>
References: <20260523042052.35476-1-cuiyunhui@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 May 2026 12:20:52 +0800 Yunhui Cui <cuiyunhui@bytedance.com> wrote:

> RISC-V THP splitting uses a temporary invalid PMD state where
> pmd_mkinvalid() clears _PAGE_PRESENT and _PAGE_PROT_NONE but leaves
> _PAGE_LEAF set so the MM code can still recognize the PMD as a THP split
> in-progress entry.
> 
> That temporary state no longer describes a user-accessible mapping, but
> page_table_check currently treats it as one because the RISC-V PMD
> user-accessibility test only checks whether the PMD is a leaf and has
> user permissions.
> 
> As a result, when a PMD-sized anonymous THP is split during a COW fault,
> page_table_check can account the invalid intermediate PMD as a live PMD
> mapping, and then account the replacement PTE mappings again when the
> split installs the PTE table. This leaves stale PMD accounting behind and
> later triggers page_table_check failures such as a non-zero
> anon_map_count when the folio is freed.
> 
> Fix this by tightening pmd_user_accessible_page() so PMD page-table-check
> accounting only considers leaf PMDs that still carry either
> _PAGE_PRESENT or _PAGE_PROT_NONE. This preserves the THP split semantics
> required by the MM code while preventing page_table_check from treating
> invalid split PMDs as live user mappings.
> 
> With CONFIG_PAGE_TABLE_CHECK=y and CONFIG_PAGE_TABLE_CHECK_ENFORCED=y,
> tools/testing/selftests/mm/cow completes successfully on RISC-V after
> this change.

Thanks.  This seems to have slipped through cracks.

AI review appears to have found a couple of related and serious issues
in this code.

	https://sashiko.dev/#/patchset/20260523042052.35476-1-cuiyunhui@bytedance.com

perhaps you have time to take a look?

> Fixes: 3fee229a8eb9 ("riscv/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

I'm not even slightly a riscv maintainer, but I'll queue this up for
some linux-next testing and so I can keep an eye on the issue, thanks.


