Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1F724501D;
	Mon,  5 Oct 2026 05:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791179262; cv=none; b=YX7oA+WrQQf0UG7l9TnltHPw0NpPyMQS9no5JUq+qGdy6OZ0faTaAi+BUGK0Boakc2EGHo90UTnospG0IFsgiM1Ty94OpR6Mce6oIZztEt3P6h1cgNqI4jFlimAW+VrtY8Ubsr78mF5nUuL4UIZzB9fNgekUsYE6TwNyIYyzPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791179262; c=relaxed/simple;
	bh=blIbCELApWWb7ltOu5q0RLEfGC3Ryu7sHTIdGznkYLk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pT6IaH250jlEGdZr5gsuZlynEir/+gy5zjnkYlTpP2ix8Dd40FU1ClMAXMINJ4RODpdpFZUUAVlOozqBngwULtJMf5e0LQ0i+XuhSiK43UQ2fZk1MB3hPgIwgmWn/9gcuOTgJqwfY21d6DbVtp/z6guMsh2i+C5zhN1fTSOSKJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WLGt33lf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WLGt33lf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254B81F000FF;
	Mon,  5 Oct 2026 05:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791179260;
	bh=WdID9CqCiCBBOkKgGvMyhfoS09YR9XZ5psi88CHqPqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WLGt33lfQhis85EhMbNynpfjFZNyIwXjFSFdF+pCNdRzkvKA814/rYRLNpHxSnC6F
	 jo+wc9HEpn8HqriJVcmIk8aXetaWaed83RxyOdVgz0WFtLFEOgoeoaE6XiHQmJg7tI
	 m9YUkYcXqahMPm0Z/PBITQlt2exEEtIPGDOW0/bE=
Date: Sun, 4 Oct 2026 22:47:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, riel@surriel.com, linux-kernel@vger.kernel.org,
 qi.zheng@linux.dev, nadav.amit@gmail.com, thomas.lendacky@amd.com,
 kernel-team@meta.com, linux-mm@kvack.org, brendan.jackman@linux.dev,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com, mingo@kernel.org, stable@vger.kernel.org,
 toshi.kani@hpe.com, david@kernel.org, mikhail.v.gavrilov@gmail.com,
 pfalcato@suse.de
Subject: Re: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with
 TCE
Message-Id: <20261004224739.e1049f07332d388169f7ef08@linux-foundation.org>
In-Reply-To: <20261005052302.43042-1-lance.yang@linux.dev>
References: <20261005052302.43042-1-lance.yang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Oct 2026 13:23:02 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> pud_free_pmd_page() uses a single-address invalidation to flush the
> paging-structure caches before freeing the page tables. With AMD TCE
> enabled, this only invalidates upper-level entries associated with the
> target address. Cached PMD entries for other addresses in the PUD range can
> still reference the PTE pages being freed.
> 
> The AMD manual quoted in the commit enabling TCE says these instructions
> remove
> 
>   "only those upper-level entries that lead to the target PTE in the page
>   table hierarchy, leaving unrelated upper-level entries intact."
> 
> Even with all PTEs cleared, speculative page walks can cache present PMD
> entries after the earlier TLB purge.
> 
> Use a full TLB flush before freeing the page tables on CPUs with TCE. Keep
> the single-address invalidation otherwise.
> 
> Fixes: 440a65b7d25f ("x86/mm: Enable AMD translation cache extensions")
> Cc: stable@vger.kernel.org

Sorry, but my usual complaint applies.

Check the first 32 lines of
Documentation/process/stable-kernel-rules.rst.  They're very simple,

I'm sure x86 people can immediately grasp the importance of this
change, but nobody else can.  This includes -stable maintainers as well
as a large number of other downstream users of our work who are
wondering "why should I apply this to my kernel".  Let's tell them!


iow, and not for the first time: when fixing a bug please fully
describe the userspace-visible runtime effects of that bug.

Thanks.
