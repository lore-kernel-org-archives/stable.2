Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007672;
	b=yCIpNUcZuTUT8jSDjwxGD6K4Ok5T1QUMGN0MRdLs9uf/iQA7HahQjtBun7+rMytujUHp
	 sUG/YrQX89ZmUPABcw88CS3I31yrmaOc3z1Wfg5RN3gvKkdTr+sz5//1hQKtCVW48SruD
	 +umIp8HqsjrZSDYJzh+ShZQdI+aYjjwrCPyS0MipO4XVIFQsb5tMQMJpqdCwwGZe6bkCd
	 JNbLOADgpDuHyiNjXZu3vfXrFkuFvG3UrhIdySqfUHeVXcUMsTnWTkDNEolP+Vfr9y0u0
	 EqUV6VkPDUz9NJsrlMqZYtRKJnfF9bL9JL1PVILLYfr6KsYN/trBo3XiRqTu6FrCVyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007672;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=REIzglI+UokdSSqST5CDOezePfcdiVtDX4vr1iybjIw=;
	b=aSEEE/efCuoythz066gKYl90EqQtGBB6AIErFiUh7RDQ4nVufNxX6hiR9CPKNz4Aoh5H
	 9yJdKlcjz2CIgoWX6IlyztE+TarOWltQns0B6VWOMZh0rrT3sh2H5cV6jRiZ+EUx+IX9h
	 XvHxUPD7I08P98hXMuogobmBPiYJfEvGPmIwGe74YJBX7yDqcxcOSuQxwawj8VqaRd3r4
	 +Oo/41zB0/01UQfgdi8zQHU2DlLpivS1cxtiKLdYkeHUzPVWR8kT1Jvpx/6iNVeayMyer
	 fmQcMO7B69iuIfxcM0YpfrmU/hp0ZVY/gMo83KE/eLAC/2YgjHexF4N9gN2cinOjxWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QiSloQfr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CF460A2609;
	Mon, 26 Oct 2026 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QiSloQfr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D665E1F01829;
	Mon, 26 Oct 2026 09:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007672;
	bh=REIzglI+UokdSSqST5CDOezePfcdiVtDX4vr1iybjIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QiSloQfro7y48xGi4gcFNCghKwpJoJ0tKGbEHTBRyyphetxebruHsVADA4ArSYXur
	 8hVsrDaMZUzgAXNsEMae6m8qD0JSY0GeC9mYZUYW3HBpFztHdb0544QYlbPpTVaWzz
	 7YBcsNT66LipxPoZ6bopJ4Pqe7irxDLQa6Eq96Wu1HSvlTlrWu1hy4ZackBV5OnSf6
	 KprOyE0ZVhA0yNVB5Sf8yMQwprTqDaGr5QY56YIcRQXyBpcIBhbRXjjW6aG03+v3Vl
	 4TcpefDK8jjvxK8uoAnrWkCx+40PxsMvF6jOFIiLFWiYcSz5nnu/hIm1g3ecCB/m8G
	 2thglL7zp4u8g==
Message-ID: <d1d58902-cb44-415d-8063-6b3ab054cc99@kernel.org>
Date: Sun, 25 Oct 2026 13:36:27 +0100
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
Subject: Re: [PATCH v3] mm/ksm: keep soft-dirty when merging a page
To: Samarth Narang <samarth.colleges@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Peter Xu <peterx@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261021182157.1873726-1-samarth.colleges@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261021182157.1873726-1-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/26 20:21, Samarth Narang wrote:
> replace_page() maps the KSM page with a PTE built from scratch, so the
> soft-dirty bit of the PTE it replaces is lost. A page written since
> "clear_refs 4" then no longer shows as soft-dirty once it is merged, and
> a soft-dirty based dumper treats it as unchanged.
> 
> Copy the soft-dirty bit from the original PTE to the new PTE.
> 
> Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
> ---
> 
> Notes:
>     v2: https://lore.kernel.org/all/20261019010934.697895-1-samarth.colleges@gmail.com/
>     
>     Changes since v2:
>     - Keep only the soft-dirty fix, as David suggested; Lance will be handling
>       the uffd-wp/RWP part.
>     - Fixes tag reduced to the soft-dirty commit.
>     - Dropped the Tested-by tag, since the patch changed.
> 
>  mm/ksm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index dbfb8f98b189..910a1307ac9f 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1463,6 +1463,10 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
>  		dec_mm_counter(mm, MM_ANONPAGES);
>  	}
>  
> +	/* Preserve soft-dirty when replacing the page. */
> +	if (pte_soft_dirty(orig_pte))
> +		newpte = pte_mksoft_dirty(newpte);
> +

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
