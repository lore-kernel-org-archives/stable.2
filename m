Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6B37DADB
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694570; cv=none; b=pUQm5tH5nCnqWw74zBf0TcQb/a7FP0XG1jsk7sc2Q8GXt5VAge1R2b8MvelWMv7pGrTlvUeRbO1tvd3lQ7JlM75JGHWvXejsQsAACgk5LFjohyyhtmCVuTIiGl1nC7gFhxO5RipHR3YEyJIgFRKEynAQ9ronoUU2IoFdYPQULXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694570; c=relaxed/simple;
	bh=WY9VsZQecKDe0TlWzi3fiPomPwta6Mz8yoHLAjob3vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOlExaD0sNn7cXpoGRoMQnvWHprJ7A9171iZgIs4xn7S0YNUnkj2EP6YfC6QM77dhX0GatKV6YDvWmrl5Ss8e0CPRQV23xDdL3Uem36kNQI6C8p0PSp5R0BGkz6SavRD4JsAf2sM7vpdpS/VqVm2tcbIU6GEFh5c/+iKExOIu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7+RShmh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7+RShmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F551F000E9;
	Wed, 17 Jun 2026 11:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781694569;
	bh=uhSrWqn0IM9g7LwbWzgWfCpDeanxPIH9UlxzhP1mWKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A7+RShmhLJ7ENpuqwWUHUmQ52PtNjbqA4LgsUkx4bGIsiEkjf22min2rodWkg4kHb
	 CpoKhLUsBl4ozOuG09JJLkMTsrYmHAJkLdFwA4+aqGjHq7CP3lWBn9RJPJbcs57PpD
	 48B7GKQnVC1/rpfwlOXiGCqgwlf63M52lCvgOEEFOvFcuphb+fu6ne6DMCw40wFNQe
	 xuLMnZ3oat3mVDbgZtAgtIOwq2ZT6WYQEZprUUiKR3g9mCyIbncFjFQhoW5Ud93/v1
	 8SZ284+wiX3obTyqHDwn45SvCqPfyX77hFEir75Zc83RAO2s04f6nFVkZrRSyHlkkL
	 2/nOskthOLbKg==
Message-ID: <8fc34141-b8a7-43fd-8c84-f843bd34fb9f@kernel.org>
Date: Wed, 17 Jun 2026 13:09:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix CONFIG_STACK_GROWSUP typo in
 tools/testing/vma/include/dup.h
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Lorenzo Stoakes <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl <aliceryhl@google.com>,
 linux-mm@kvack.org
Cc: stable@vger.kernel.org
References: <20260611012258.432043-1-enelsonmoore@gmail.com>
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
In-Reply-To: <20260611012258.432043-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/26 03:22, Ethan Nelson-Moore wrote:
> Commit 2b6a3f061f11 ("mm: declare VMA flags by bit") significantly
> refactored the header file include/linux/mm.h.  In that step, it introduced
> a typo in an ifdef, referring to a non-existing config option
> STACK_GROWS_UP, whereas the actual config option is called STACK_GROWSUP.
> 
> Commit 40a4af52e047 ("mm: fix CONFIG_STACK_GROWSUP typo in mm.h") fixed
> this typo in the mm.h header file, but did not update the copy of the
> code in tools/testing/vma/include/dup.h. Update this copy as well.
> 
> Commit message adapted from the above-referenced fix to mm.h.
> 
> Fixes: 2b6a3f061f11 ("mm: declare VMA flags by bit")
> Cc: stable@vger.kernel.org # 7.0+

This is in tools/testing/vma. Why does this require a stable tag?

What is the resulting problem (in the test!) that we even care about the Fixes: tag?

If there is no user visible (test!) problem, then this is merely a cleanup, not
a bugfix.

Change itself LGTM.

> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  tools/testing/vma/include/dup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
> index 9e0dfd3a85b0..adbc3179085d 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -243,7 +243,7 @@ enum {
>  #define VM_NOHUGEPAGE	INIT_VM_FLAG(NOHUGEPAGE)
>  #define VM_MERGEABLE	INIT_VM_FLAG(MERGEABLE)
>  #define VM_STACK	INIT_VM_FLAG(STACK)
> -#ifdef CONFIG_STACK_GROWS_UP
> +#ifdef CONFIG_STACK_GROWSUP
>  #define VM_STACK_EARLY	INIT_VM_FLAG(STACK_EARLY)
>  #else
>  #define VM_STACK_EARLY	VM_NONE


-- 
Cheers,

David
