Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072279;
	b=rSWP9fVgjbP8m8tyY/+vxHm8SJ/TMRVjnqf9x4YpUODEcEAQzKT9EdqNSTviv8lCNzUz
	 aoiFvqH+3CmGBcAKLzq6nLKNug0U/kOvizzx+1M0VOpp5E/c/vLDTscj9k5G++wtrZUtB
	 sQ9QyUAyD/OwSfTQwmEJBZvyfOhU0MlfvRabYEgR8y7eDXlI8eTgTnyNsrIDxV0YemZu0
	 GBREa+209IvUe/Zcxh3xvrc9KG8EicL3mV8PT3mLyS5+K7S9STmtvM0+DFtnzn7aJnr40
	 RDxOervjUsD5u7w34xMn7mT2FpLUU5SOVL/1Db1yhRMtz6g81LYr1aQLY/tH8eOYoGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072279;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Pv4D+oSBbj13nSy5FVEyYVmO1wSsAmwa8GeyhZBw1sQ=;
	b=crwFGgVoTuv8JA6a4EjqXN99FDbzMO78gJqL5dOebELBgCTEtuD5eXc01RVX60e+nFOH
	 jCLqF9Tpehu70AqpqA/p0hnFA4mOirwg86dMM0r7hpUF8uGsSzX1PM/XfZ3ISRDgZUV35
	 T5ynlUsdiV+tduRqHw4pVEwl4YeW/UnhRxXV3D+jZpAq518RI0itiiaVba8blMy4LCoTL
	 bpQl/tYU971CCSrCNAqHceXrdb1K1ABold7J1EskYVfB9jNiZhihddrUEqAbbBjoplg+/
	 UAZNP7BTYApFooVr+CkLYF1ONFlslftUrmJe8lQEd7PEdBCVP/9VM8TH/eLPF9VmROw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=HutGURtX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93545606A320;
	Thu, 19 Nov 2026 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=HutGURtX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD661F000C4;
	Thu, 19 Nov 2026 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795072279;
	bh=Pv4D+oSBbj13nSy5FVEyYVmO1wSsAmwa8GeyhZBw1sQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HutGURtXfVynAu6rB0e+Pp6CijsEHIvVbwW+biDVcVeMMZJbC2Xnt0bAOgzvu9oRQ
	 Hzi5JLqa1W+DlUL1Ya0hCI+NM6hAGhIL2mglmDNnH8OSiKkSuqDeuMjX5COQjzxxr3
	 bbSx7C6ffdKu7MRPVTFD6pwvXgzkELPB+2LXv9OU=
Date: Wed, 18 Nov 2026 23:11:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: <mt4022@columbia.edu>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Jane Chu <jane.chu@oracle.com>, Zi
 Yan <ziy@nvidia.com>, Kaitao Cheng <kaitao.cheng@linux.dev>, Mike Rapoport
 <rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>, Yu Zhao
 <yuzhao@google.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <tz2294@columbia.edu>, <stable@vger.kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, David
 Hildenbrand <david@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memory-failure: don't unpoison a leaked
 raw_hwp_unreliable folio
Message-Id: <20261118231118.ca2d773881cd953d1efee4ca@linux-foundation.org>
In-Reply-To: <11f434ce-58c4-ff16-9c93-946a1e83eb10@huawei.com>
References: <20261103-hugetlb-hwpoison-leak-v2-0-98085750c145@columbia.edu>
	<20261103-hugetlb-hwpoison-leak-v2-1-98085750c145@columbia.edu>
	<11f434ce-58c4-ff16-9c93-946a1e83eb10@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 14:39:24 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> > +	/*
> > +	 * A hugetlb folio without reliable raw error info is leaked once it
> > +	 * is freed, and its hugetlb flag may be cleared by then.  Check the
> > +	 * flag in folio->private, which stays set on the leaked folio.
> > +	 */
> > +	if (folio_test_large(folio) &&
> > +	    folio_test_hugetlb_raw_hwp_unreliable(folio))
> 
> It might be better to add a unpoison_pr_info here?

How does this look?

--- a/mm/memory-failure.c~mm-memory-failure-dont-unpoison-a-leaked-raw_hwp_unreliable-folio-fix
+++ a/mm/memory-failure.c
@@ -2818,8 +2818,12 @@ int unpoison_memory(unsigned long pfn)
 	 * flag in folio->private, which stays set on the leaked folio.
 	 */
 	if (folio_test_large(folio) &&
-	    folio_test_hugetlb_raw_hwp_unreliable(folio))
+	    folio_test_hugetlb_raw_hwp_unreliable(folio)) {
+		unpoison_pr_info("%#lx: cannot unpoison, poisoned subpages are unknown\n",
+				 pfn, &unpoison_rs);
+					
 		goto unlock_mutex;
+	}
 
 	ghp = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ghp) {
_

