Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581D2BD022;
	Sun,  5 Jul 2026 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783236962; cv=none; b=XBzpx2aT31ymhcEajT2k4HDb9uivF/QNnrXzYsm9y7WYJKv7B2mTeFBdsIgVPzh/u3aZfp5/xKCj9/bN5riwpIAajywifXnZUHcFZ5DHvC7GdP1VIoAvVAPOT4HYk/0mj4jfVbH8mzdXpWqajpPNFkki1HCgZ2H12dURlX7l/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783236962; c=relaxed/simple;
	bh=dhV3rAHYOOY40GMAAV1Oa9f7E0UcCzryZIJUH5O1KNw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hdIuNdTuq3Hg7YhViGci3RWldNrErwdmeoz0VchjUnbwn3lTzihLEeE7ur8eCujwjgiXaLvBRF2QZ+xWijv6WhvomhOwYUGWsrqtW5cJa2Pa5KF/tJ7nfRta9seEIbvHMMBqzd9vv8FNMY0KJuZgq1xroZ6kS+zI59WBIM2r0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FWr7oYXO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FWr7oYXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68261F000E9;
	Sun,  5 Jul 2026 07:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783236961;
	bh=A6ZkehhfOr5XXJ3jery3AcqU6u9rwntx9neKtZ84pmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FWr7oYXOt5Tp+K6Ek8q6APpXSMD+p/aNq4SvRIWBniP6sobBE8u2g/45GuabtZ7Lh
	 5E6jKvT6FbQ902LJvZk8l9k4niP2mOqpY3EAy0PXbjEdEmkzyqGxqmXJfvqHOtrnHp
	 7W8TPuCgfYN9bK/6++23sY3tVDsVYxqEXnEpRnKA=
Date: Sun, 5 Jul 2026 00:35:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, ljs@kernel.org,
 david@kernel.org, liam@infradead.org, riel@surriel.com, vbabka@kernel.org,
 harry@kernel.org, jannh@google.com, lance.yang@linux.dev, kas@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, apopple@nvidia.com,
 rcampbell@nvidia.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, ak@linux.intel.com,
 nao.horiguchi@gmail.com, mel@csn.ul.ie, j-nomura@ce.jp.nec.com,
 pfalcato@suse.de, tglx@kernel.org, dave.hansen@intel.com,
 jpoimboe@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/6] arm64: make huge_ptep_get handled unaligned
 addresses
Message-Id: <20260705003559.8b124d2b94b685cc2e4e77ae@linux-foundation.org>
In-Reply-To: <20260703114202.365553-2-dev.jain@arm.com>
References: <20260703114202.365553-1-dev.jain@arm.com>
	<20260703114202.365553-2-dev.jain@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jul 2026 11:41:54 +0000 Dev Jain <dev.jain@arm.com> wrote:

> huge_ptep_get() can be handed a virtual address pointing to the middle of
> a contpmd/contpte mapped hugetlb folio (examples of callers are
> pagemap_hugetlb_range, page_mapped_in_vma).
> 
> The arm64 helper rewalks the pgtables in find_num_contig to answer whether
> the huge pte we have maps a contpmd or a contpte hugetlb folio, and
> returns CONT_PMDS or CONT_PTES, so that it can collect a/d bits over the
> contiguous ptes. We can falsely return CONT_PTES instead of CONT_PMDS
> if the addr is not aligned.
> 
> Fix this by aligning the pmdp pointer down to a contpmd base before
> checking equality with the passed huge pte pointer, to correctly answer
> whether the huge pte is the base of a contpmd block.
> 
> Fixes: 29cb80519689 ("arm64: hugetlb: Cleanup huge_pte size discovery mechanisms")
> Cc: stable@vger.kernel.org

Please describe the userspace-visible effects of bugs when fixing them.
Particularly when cc:stable is proposed.  Thanks.

