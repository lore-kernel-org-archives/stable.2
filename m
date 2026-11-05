Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883730;
	b=Q6Vh0bkHRSo2L5rVa7iBc1k8YEawjIviddf5xEQbv+9gKdBO+hRUClxaZbk3FjCo28lt
	 HknhUkzEXb8HVjmqU5yxqlkKcpXuaxWO2zOEGSfDiqHmvffapfEH6TncRC/wWG5sdp42h
	 LkTkHVLWCocW27wPCoGsKFPk8KzW3/FeGODZg1KjrTiRfYmLd66fxDPYHNtywoY8sJO0C
	 q7kjQ37aYthrRCuIk5McwT1k0blq/TwFomNc4j9wYSQIfU8sOa7LE8ivE+Gw9cb7zk4BV
	 AFpr+bFCp2CB+YdY00CTWWRGmYAD6IbtHttZ1L83IeNJKBHF1LCqNcsXMCgPE3sNkqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883730;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ODdbidwungoC4joZGqAWEdUpjvBaTXtHkaXe8rKCFAw=;
	b=UH5OwfxULKq9q0xSgdqDo9jDbn1AjyD7UJKa6yqabiphM4ocESDwAyUtdGShQcwJ8O51
	 zTHFrmVAqonsrOUny3OySb7kX6+csRX4JMjTAyTFZPb7XbFTur6IAXEsRTDoiBKmaayTJ
	 p2QWfa/XymP2zRxiV4VxQlL8lbBCzrvSi4JyleOnII/cCAyKKLVT5oAyraoZvXdAH8gGl
	 ifBxU9FqQcHRZ14kw8YTJeIV2WuROI5hVPYMCStweq6NgLTuM7XnuQ+uI4a0zBTst5K4o
	 a7qjcpYUy77PQJu1Af3sYEjCVo0BtC33IaDkmrqv+kgurdowAYxyzsXAJ9h8+hlRzfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQ0oCC+y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83718606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQ0oCC+y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6121F00A1B;
	Thu,  5 Nov 2026 13:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883730;
	bh=ODdbidwungoC4joZGqAWEdUpjvBaTXtHkaXe8rKCFAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZQ0oCC+y9os0E1ZeMgu9e/N5WmpHjAOIrF4l3liGw27+gQmFuauUAu3QG/q9uDWTl
	 3TKp+AU0H1wWqayQPvKZM57PaRJibPQUloG2nqac2lBeRqb0UEPX1dYD8h01AEjzDz
	 vNGUIdx63ttmmh3zf3eIMHbzwnndB5k9MDBk4e+uow5NCSLEIH1cFyXz74Gi45tgp/
	 Wa26Nd2c++AdKkgxRFXZAi6sa5GBBD2QE3KUoQkbJT7VI9iZhSrWybSuBgYbpQGlB8
	 g3JErI4ZReV8vX8nOC1ZbmltupQcjstxr5TXRSSVm0c83LP1wwssH4qoIu1I1Wfl3J
	 sDALxcReIe8CA==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.ams.internal (Postfix) with ESMTP id 0F3EE198003A;
	Thu,  5 Nov 2026 08:02:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 05 Nov 2026 08:02:07 -0500
X-ME-Sender: <xms:TH7saqG7wrZYgS8Mw0OKSmpa6lUlaIpWmaaxiMhNQ2_I9GE5fGmgsQ>
    <xme:TH7satot4vh9OJnZQntbjnUpxcJanpaSDK0e6g1XrjWSdyQj5KtMNuq8mIsfVbK4R
    O_S9txFhPKaLFT4TTMZb23wg-mNgfFZBeARZFINIWtUQTlSuusRnv8>
X-ME-Received: <xmr:TH7sai2_SpttBsmoGsUTIFVzlHSABshtJuyvUk1T9udcIXUDJtEeThqzxuw>
X-ME-Proxy-Cause: dmFkZTGWioZ5UsUZvGXjaow1BsUGadLs8aZQdTF4UnV/07NAN/af8tN6pM/FfLXYfyZLfb
    xRpT19JopPsgAFGYsm8FzaqvOcRv05DtuUalhGCfVBg5TYHs9JXv+Q47gmOf937P2Gi3S+
    U2sfvRv8HM/m1nYX6eGi2a4miDiVYyQMuuHiidk1Rop6z5ppK7guJf5jvUfTyMXleQeyL+
    YFG9WYCksR8P+f/IoUx4Wo08VB8Mvto3/EHOpPBXbwb98JXOAs0bmRST4eO1cbxBPUkzyb
    YU+NZSxhcSt0KRFVrgpydwZFv0ufeT4P8d+qRyppjSLMzQpNREs19lQwYqTs8BowLu6Nt2
    5Am7l6YekVqjY83nXhyttgWii20fB0sq0/gLxPQHon5CrRkTEqrIGD//hCWFKqOgzqGCvi
    aMcLQ7cAZew8NgHslTKKsAByAnDUby/6o7zf6t2iuxqMb/GVhW/urcyLO2AQ8SZ818X9mS
    KvrqoB35qasVInQXx9O0IC9DWqxqX0BoD/o9yiGn5oqOKYTbGXBdOAIO4z+H9UZl5AQPCz
    X5k1DEL86ay2iE++MFKAY52MrLVWAVVhibUP0tLtOKiw/bidGrXPVW2Da/VrEL1xMbaVji
    gk/Rfm6DtM/to8/mnKjVPcrauVt2Z5IcYYLnNu1hKr6ktYnVJlpVoH4xcT1Q
X-ME-Proxy: <xmx:TH7sahDqPgMnM6imR1rATIc4Ws5YrXF92NPtBNndS3RcrHPbByQR8w>
    <xmx:TH7sat8lZSx0ZfTRSH73tiR_oEt_6GxNUq-DXVFxZ20237HLHQwtJQ>
    <xmx:TH7savMpe0K9HyMh1PrMBNDDIaNN4W1yi749wUvB54Lc8e4xuSX9Tg>
    <xmx:TH7sanFEmmZkFS9J_XtjodG9fU1CrzxAv4fcixThKJt6YmAuCEHgsw>
    <xmx:TH7sauuRyf3FUbrFTX_8ORVoKejL2DOhUuj_v288Q3YNMXl9vOfBxqQs>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 08:02:04 -0500 (EST)
Date: Thu, 5 Nov 2026 13:02:02 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: free unused page table when setting a
 huge PMD fails
Message-ID: <aux9liPvdZgpKCpa@thinkstation>
References: <20261105-khugepaged_set_pmd-v1-1-cb79ab117199@kernel.org>
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
In-Reply-To: <20261105-khugepaged_set_pmd-v1-1-cb79ab117199@kernel.org>

On Thu, Nov 05, 2026 at 01:16:05PM +0100, David Hildenbrand (Arm) wrote:
> do_set_pmd() can allocate vmf.prealloc_pte on architectures that need a
> deposited page table, such as PowerPC with the hash MMU. If the PMD is
> no longer empty when it takes the PMD lock, it returns VM_FAULT_FALLBACK
> without consuming that table.
> 
> Since collapse_pte_mapped_thp() uses mmap_read_lock(), a concurrent
> userfaultfd operation can install a PTE table before taking the folio
> lock. If that races with set_huge_pmd(), the unused preallocated table
> is lost when its local vm_fault goes out of scope.
> 
> Free vmf.prealloc_pte on failure, as do_fault() already does. Successful
> PMD installation consumes the table and clears the pointer.
> 
> Having to do this cleanup outside of do_set_pmd() is rather nasty, but
> other callers depend on it already having been allocated. This needs a
> cleanup at some point.

I hate this being outside of do_set_pmd().

What about making do_set_pmd() freeing ->prealloc_pte if it was
allocated inside? Nothing changes for caller.

        bool allocated = false;
        ...
        if (arch_needs_pgtable_deposit() && !vmf->prealloc_pte) {
                vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
                if (!vmf->prealloc_pte)
                        return VM_FAULT_OOM;
                allocated = true;
        }
        ...
out:
        spin_unlock(vmf->ptl);
        if (ret && allocated) {
                pte_free(vma->vm_mm, vmf->prealloc_pte);
                vmf->prealloc_pte = NULL;
        }
        return ret;

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
