Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018602FA0C4;
	Mon, 20 Jul 2026 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589451; cv=none; b=jiBiqEFGGQ7l3Zas+xchWZeoNVMaezb2o/lEJwWcMv6Csm2ySUQDckN/HBVGCX19AbAoiCZZaYlGKr7j4jLHnicAqA0kM+QYSvMdeI9TeRv3a2t1OGQk1wEiBvqJmySk0+yljCFoi6ZrvEIKhVn1Z/zyoGeJCIcHWLUx6xmlzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589451; c=relaxed/simple;
	bh=MX692lSSc20FIW0N9K8E5/XTqgWlLqdeRu/075VwaIA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Me1gexngoUaXLgQAsTZ4STY9J1Ve9xSOsd5IPqPoKSdsN7SjsprdkEixgiZXQOByqTDe78vjiSKk9S7mew/K+ZIHOMi+UYwSo2KPkIIy5CwDySj5KzHbOLcBDaED340D0A2TU8djq5lSiXwb9C5r2urFbhIMovjzNrrhdFn+Mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S+BwUH11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S+BwUH11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95891F000E9;
	Mon, 20 Jul 2026 23:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784589449;
	bh=aotx7CDCkUtl8x9Zahbu5Sa7ywaL9nXIt4JyawppYZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S+BwUH11cJ7WP3D9vhBbPMHL8VmXP9nKLdUPtKCfQa2yicomXxmiUZKXil6a5cI2f
	 e17rHxMkHQuJnl4WORjQA94fksL6U30vAJQ7OFTOMW0fQs7bCnyBNmt12/axam+MwW
	 v4M7vbe0o/QxefPU8RaWNGPD3ax0f9I0GFb4gmxA=
Date: Mon, 20 Jul 2026 16:17:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>, David Hildenbrand
 <david@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Kiryl
 Shutsemau <kas@kernel.org>, iommu@lists.linux.dev, Kevin Tian
 <kevin.tian@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: allocate split page tables as kernel page
 tables
Message-Id: <20260720161728.1e5e5d848bcb53bc8757ede5@linux-foundation.org>
In-Reply-To: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
References: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 10:27:29 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> When splitting a large page in CPA in __split_large_page() we allocate a
> PTE directly without going through the standard page table allocation
> routines such as pte_alloc_one_kernel().
> 
> This means the page table constructor is never called nor is the page table
> marked as a kernel page table.

Thanks, I'll await x86 review on this (Dave?).  Also, Sashiko might
have found a pre-existing thing:

	https://sashiko.dev/#/patchset/20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org
