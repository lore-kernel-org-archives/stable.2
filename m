Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600190;
	b=5LQeFuPz4JQa5BxQ2Wkt1yXUshBeZiHW4+uT9RWZtBjkhbv/RsKVCcQUZ/RWk9OWXNb9
	 XY6L2vvRVUTS2dyvSPd5yquWo/L7tVv5FGCBxy9zci9SXaKkBW6AnzcNnXZv9UUA7HMmI
	 EVD6a/tDimC7kC9ZlLVSeqTMJjccc8ePLP82cmWJcyuMBDIdydz8S5qzfa29lODN4KYrc
	 8TvPY9WHQrfaHDOxT6uk70dDZSTGZQ1E0NOy2nrBfkpzbv8TAStB9fmlU0bnCvXjilOWL
	 zy/rKPXE/N31G0KQ1TX0snY3MwYuU76EOgEIfvJWR20w/VWin+PDDen1kamQLHyUwdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600190;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=HdQQRt/CgHJflkJafdeqoWxFHY5SFOsLjrXPZfDp7E8=;
	b=i8PIR1lRaPsKAf3fb6DGmHJhDNidUM0IlsJpS8eJqcqnqzVgevELzQANO/g+bchBDoLs
	 6wpW/EaPVEL9cHcg9FQD2Uf8DHapjEE27fSC6J5H0ZjI4FnazEJcBhdtyuk7fBPjqG2sx
	 eXvEI+eUHrQdPKW3rWQlz1Tw1hNjRaNDmIJ+YnXJrXQljPpyOQ9Tp6dyrJw92vmXVnLQy
	 UpbWaTXAsKZguLfAxHAjdvyJ+HWMNEHkUBCoGZkm2cS8GXHePRXGv6kcVM3i746MUf26h
	 aQiYMRedqKYS9QGyiSZPsIRYsWXBT+djBrQFtdTDVN9iEVkYEYvTe/XHNT8RIx3qYWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlrFg8X0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCBB606A323;
	Fri, 13 Nov 2026 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlrFg8X0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901F61F000C6;
	Fri, 13 Nov 2026 20:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600189;
	bh=HdQQRt/CgHJflkJafdeqoWxFHY5SFOsLjrXPZfDp7E8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TlrFg8X0AUB4Vm67OzMwLnuL9ahl3Pw5r3X9tm+PjK/f3ZGnXwMx56AU0yk2zAn57
	 GDIOEAe/hcJOW795WrjVEMPe9PSEKQ/w4IyIpnKgcypvlNIddvLpmUQ7xuwaFwejzZ
	 dSr3MD6IQGYdygBLKFvjyNJ0rzzWChkutY4pTXadyw1/FyGvEWWELV5QFeV7U4rMOE
	 DkiZdGgY2cPRtxHO5905s6aMxNcChen4/Au3qZ70bQKYLRRj1nccZLkHpxMdxhuwRL
	 QkDE/YTxe29nxalHy0hwbrV2IiyzuaaVWUjPz085uA7WpZVxCcrxUOvmG66jXzGfM9
	 hFxKTW4IUPjyg==
Message-ID: <69e27ce5-8378-489a-ad8e-37c364cf63c5@kernel.org>
Date: Fri, 13 Nov 2026 21:03:03 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
To: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, jgg@ziepe.ca,
 leon@kernel.org, akpm@linux-foundation.org, kas@kernel.org,
 dave.hansen@linux.intel.com, bp@alien8.de, rppt@kernel.org,
 stable@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
References: <20261113195536.2660763-1-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20261113195536.2660763-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/26 20:55, Gregory Price (Meta) wrote:
> HMM can grant ordinary device write access to a userspace shadow stack.
> On x86, pte_write() is true for a shadow-stack PTE, so a populated page
> can be returned with HMM_PFN_WRITE without taking a CPU write fault.
> 
> Nouveau translates that flag into a writable GPU mapping.
> 
> Reject shadow-stack VMAs in hmm_vma_walk_test(). Use the existing
> unsupported-range handling: a requested fault returns -EFAULT, while a
> snapshot records HMM_PFN_ERROR.
> 
> Link: https://lore.kernel.org/linux-mm/20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org/
> Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
> Cc: stable@vger.kernel.org
> Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/hmm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 2f1e98c6b644..fa61ca59d927 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -596,6 +596,7 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
>  	struct vm_area_struct *vma = walk->vma;
>  
>  	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)) &&
> +	    !vma_test_single_mask(vma, VMA_SHADOW_STACK) &&
>  	    vma->vm_flags & VM_READ)
>  		return 0;
>  
> @@ -607,6 +608,8 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
>  	 * allow write access either. HMM does not support architectures that
>  	 * allow write without read.
>  	 *
> +	 * Devices must not gain ordinary write access to shadow stacks.
> +	 *
>  	 * If a fault is requested for an unsupported range then it is a hard
>  	 * failure.
>  	 */

Cool, so I can drop

	e27dc0754e3f4 mm/hmm: refuse shadow stack vmas in hmm_range_fault()

:)

Acked-by: David Hildenbrand (Arm) <david@kernel.org>


I used the comment:

+        * Shadow stack VMAs must not be written, and there is no particular
+        * reason to allow read access to shadow stacks from devices, so just
+        * disallow it entirely.
+        *

-- 
Cheers,

David
