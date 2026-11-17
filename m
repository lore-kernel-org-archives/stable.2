Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913373;
	b=HHr82lUSaX09Ps+hUkdHKkMLCfPmFM3D7MFpyzZKmlgYdNTwjnjC1+rz/XLD+o/hEVr7
	 TZlSS1LLVKh4i6jEtD7O0SErHrfOcoe1yaUxG/wXyxy8i/h+qzUHQJP+Fu0z9cxUyrenn
	 vOdlYnlI9aEuncAwLSc0mO5onTGQjqe6VDhVQ5Ud+tQ4+0qkE0XzHKCH6b0oAInCkUMb/
	 EiATE04CqjT8G/Kuw4wsAqltWBU0JaXFTZUjz4Lv9nRBpHYCJGVZbHiXywRmnJaJHnojQ
	 fZKn127EqZ3vR4b84E00OWwP65X3L3YQvoC6ODevzVscDpNpxayzZmQ3M5EhEMvy40w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913373;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=crEmioOjMzsnzH6L7JboWvkyCFcBX6fDyVf9lGMy6eg=;
	b=lC0CC8ihbBYNfsjWegm8nC4ddg010FAGzl3YRlmOAGOPrQLDZ8zVD/lGM+qSZP26kaoy
	 om9ln42rpxn5IX/iGhyoX0epjQ1kQmrU7rXB11jVUqk7wwPHfJ2BAtZNvCV8B/UGlgpWa
	 6E66iB0kbBcojoKesJsdCUnQEag4G6j5tw74Xckr0b8US9HRqwm8B8VjaKhUidYW/CsiJ
	 eQCziEp7nBB9gzYaPNHPvLBr7+mbm4vAMh/B70vAOTOKnVRMb6d7BgrW3Z3wxKdCdvpSM
	 fvmRI0PJxKcSHGcIXtUZNCQSmLMent7kmenPVvjFiS5wFsVgzpVWKZQTUNrb9ZByE5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jD9TEQPU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F3606A33B;
	Tue, 17 Nov 2026 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jD9TEQPU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862FA1F000C9;
	Tue, 17 Nov 2026 11:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794913372;
	bh=crEmioOjMzsnzH6L7JboWvkyCFcBX6fDyVf9lGMy6eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jD9TEQPUGxO+mI/+inKff7uoSP7g0a0erFOtxFVtDkPnPMTbL0D081VhE33DJxbG8
	 5dVj5e9HYeiDdT8hAL5IpDQbEHbuCC69/sE82COwPzr+ih+zjcYgUBHZT8A1r02nBI
	 je2u94IG20Y4QpFov792FdB8+HkE3G8nSGn/QCZFfy+Mcm0IRMyqEDOk0Cp1XsOY56
	 dEtCmev7DxnVFDk0RBErzUsr70H3zpp8qfYD3s2eFGhB8qrSfj6YeG1ESbpaS5zMYQ
	 fdYqYoUIreWD8guOCclZ13kkzJn+IAD5y2yxDBES7ERoEjpEkNFJ98Gruwt+OvGW9c
	 nP/F+RKLvJHAg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 0A46D198004A;
	Tue, 17 Nov 2026 06:02:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 17 Nov 2026 06:02:49 -0500
X-ME-Sender: <xms:UzT8ajzhIRDuZQmR1yXTDLuGA3b1U0tuSaourJSyrLDTrQ_Um2nlVA>
    <xme:UzT8ah-gVHw4IntEVOfc5Z14VjjzN7T7Q8B2FvFR5VBoen7b-HPD3m7hBY_KVQkTE
    lA5xwY_Wo0lHo-IJ34H8B5KdKsLoJFuxG9Et2vFBrnNw5WdWVHCbak>
X-ME-Received: <xmr:UzT8ahxcJlhvBNfVqovWJPHAn97L8-HJYkti8PJU_65bhna8ykiR1lDXN20>
X-ME-Proxy-Cause: dmFkZTEdL3a0Ww8UBR3R2vq6MmLMcrG/RZX5swqKljzNR9iQbYhJjAbY7PI1ciZ9LK7lxN
    G/X6ntG0iaY30AQsAjEuf57i6CZYjfm+meUK3SNiYXmeCWWUJ6eJZs3up8jphiYl4q8gjl
    jx/Ahq1GKe6I/bXKrTuw70GcxIwNT2jp4gfkCI76UMri6prm91X5ZHCpQ0CSw70eKatw9o
    W897R67TYQMC9tdclNiHUmVbeQonLxDDsNNr0tVhsGpDu129aHDLPo6xC+ZTyK9ZM6Qnnt
    MYuzQ4L/hdyqL+ol7coGPamA67VuEepBf0wI/8gPf+rreyi3dAUVv7YzP/OCpkMvoNRZhV
    YgsKbRCIilSfSP7pZVhBNK5pp+l4zUFWKPr0XsF4c/Rmq0cqJXBoQeoSNFwc2DiFDWZFSg
    NfO+shv886RE5kd2tAFT+FTIarUIaRL9KRbOP0qtmfBkRi5y8jE6SPjvymtIKQCEHqK1h3
    RYgAGGj/RxAuRRjdSRPlvRnDYhwbkOoHHLBugCLRdy6igxtIkdJ8SsiOfdaC9wZow2EeCV
    Ejy4XNZF76vFloczn0M2QIsslwD2xaCsTZRX1OSP+ZOi7OtUBkmhno/iE/fXq03rTXkSbw
    do3CK6UiTx4ST1p3Q59hLB+vj8psXH2OMMFeeHtUpnx+YFCTloQa9ChJJNoA
X-ME-Proxy: <xmx:UzT8aruuJmQ7dDiwarHdYjVtP70RG52TxChOPLKFH7afF7h6-akdFg>
    <xmx:UzT8aryVAcVUMmv2aTlcVJcYor6UcfL9P1w1L0anMWhtGRDIctF4jg>
    <xmx:UzT8altjzJNLBNiYpIhGi_vWWH7VmxarJzm-N-JcvvJ1fgUMEfeHjQ>
    <xmx:UzT8aljV0jDctEZAsJHbv0Ypfdw61mWX4M9wO2EfhtqHNe0Af12BHw>
    <xmx:UzT8atCXyMGt2Yq-MlBZYadsi_cXIiTQmqxJmcETVf2oWtX0YRICrq70>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 06:02:42 -0500 (EST)
Date: Tue, 17 Nov 2026 11:02:41 +0000
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
	byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com, 
	joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, matthew.brost@intel.com, 
	mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org, surenb@google.com, 
	vbabka@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm: don't PTE-batch a swap-in of a folio with a
 hardware-poisoned page
Message-ID: <avwwMyk462raQFy2@shutemov.name>
References: <20261116063624.1382944-1-usama.arif@linux.dev>
 <20261116063624.1382944-3-usama.arif@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116063624.1382944-3-usama.arif@linux.dev>

On Sun, Nov 15, 2026 at 10:34:56PM -0800, Usama Arif wrote:
> do_swap_page() checks PageHWPoison() on the faulting page, but the
> large-folio batching path then maps the rest of the folio without
> looking at its other pages. A poisoned page that is not the one being
> faulted gets mapped anyway, and the fault that would have reported it
> never happens.
> 
> Skip batching for such an anon folio and let each page take its own
> fault, where the existing check catches it. do_set_pmd() already backs
> off the same way.
> 
> Leave a freshly read folio alone: it is not anon yet and can only be
> mapped as a whole, and falling back would free it with the poisoned
> page still in it, which the retried fault can then get back from the
> page allocator.
> 
> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

With the check moved up as David and Zi suggested:

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Do we have the same problem on the file side?

If memory_failure() cannot split a large file folio, it stays in the
page cache with the poisoned page in it.

Consider a write fault through MAP_SHARED on a good page of that folio:

  do_shared_fault()
    __do_fault()
      PageHWPoison(vmf->page)
        // checks the faulting page only
    finish_fault()
      do_set_pmd()
        folio_test_has_hwpoisoned(folio)
          // backs off with VM_FAULT_FALLBACK
      set_pte_range(vmf, folio, &folio->page, folio_nr_pages(folio), addr)
        // maps the poisoned page as well

Possible fix is below. I can post a proper patch if the analysis looks
correct.

diff --git a/mm/memory.c b/mm/memory.c
index fb76d8922e37..25b53847943f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5893,6 +5893,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return ret;
 	}
 
+	/* A poisoned page must take its own fault */
+	if (folio_contain_hwpoisoned_page(folio))
+		needs_fallback = true;
+
 	if (!needs_fallback && vma->vm_file) {
 		struct address_space *mapping = vma->vm_file->f_mapping;
 		pgoff_t file_end;
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
