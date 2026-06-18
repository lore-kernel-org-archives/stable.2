Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43123C1F46;
	Thu, 18 Jun 2026 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774736; cv=none; b=PowFcQwBex5qGoI9aPdXrV8UmSv4UhqbhVxxaUOu48eqiLvDgi89XJki27CuFFmamoCeQbYh10i7YUmXUhnJJlM/RwL1NWfUjaIudoyEwkjVaftD0HsaK5EbgZeLxnI56kw/txgf6WRZVcPfx8Q6LvaWLoBTaVS2uKz86vrMA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774736; c=relaxed/simple;
	bh=c/Yhs+7WBhaIPkkCMsA8/YjxP8kYwiFnRqUDGGZtiEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ms8dAEaPMNJyuWhrHI/sD0RT5JTIhA3dlothwhzfOFOAT+WtNq7cDM01lYTkVPIWDzGeLTKOTjHeHnJYqkaRWoUX/KBGUqem88NHNxUxvOwIFyWzlOh1tcrDTWQEuiK+Tg1aWHDSono8BfSubIl2yEW2ftR/6NZ03NnfscQEROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg7LIiJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg7LIiJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E9A1F000E9;
	Thu, 18 Jun 2026 09:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781774735;
	bh=DgKcClasxSrNEwOyhFc/Pf3yXG2qRJHjcQekLSqD8WI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fg7LIiJR7AX9Jn66wWOxFwFC1Ilz8tBNN130l9pe8+ski/iiRItU7Grqgq/n1pD3b
	 a794jZ3egI+eNs+hsjI4MdhkR8FGxEytWyl1w7i6X/OCyHUeCqu6fuato879HTU0/g
	 mGLdvtRPpJAoRQtm9YYitdXw8vvnoOA1CWdr3jth5lNTf0j/apFF1zhS0hvHD22QSf
	 fBvryou88infm346UlwypugTjY6FwlgJSkiKVobm+r0QlbgAgMIQ/KduN+w2495mnd
	 W5srq7C+k7qgdA45I30LwtGtgtnK1gcLK6+EPxaAcJIXZU9RycxyrvqEXwy4n0KCIz
	 jaelC2pgNc9/w==
Message-ID: <dd2ae577-9b7d-4e40-81d0-fa9fcd7e0767@kernel.org>
Date: Thu, 18 Jun 2026 11:25:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] userfaultfd: prevent registration of special VMAs
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>,
 vova tokarev <vladimirelitokarev@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20260617194059.2529406-1-rppt@kernel.org>
 <5a993689-f730-406d-8515-8bb6025cc851@kernel.org>
 <ajOtfdGgFQYL-T6f@kernel.org> <ajOvwGs5xhnfBu-k@kernel.org>
 <41ef0dce-e973-4947-b5e3-150fdb07f1a6@kernel.org>
 <ajO4sLq2UBciSgOn@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ajO4sLq2UBciSgOn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/26 11:21, Mike Rapoport wrote:
> On Thu, Jun 18, 2026 at 10:47:19AM +0200, David Hildenbrand (Arm) wrote:
>> On 6/18/26 10:43, Mike Rapoport wrote:
>>>
>>> Ah, hugetlb sets VM_DONTEXPAND, so it must me excluded to allow uffd with
>>> hugetlb.
>>
>> It would probably be cleaner to just allow hugetlb, and then check for
>> VM_SPECIAL if not hugetlb.
> 
> Cleaner in what sense?
> Will be uglier for sure, just take a look at vma_can_userfault().

I was thinking of this:

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 180bad42fc79..8a6803618a91 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2029,7 +2029,10 @@ bool vma_can_userfault(struct vm_area_struct *vma,
vm_flags_t vm_flags,
 {
        const struct vm_uffd_ops *ops = vma_uffd_ops(vma);

-       if (vma->vm_flags & VM_DROPPABLE)
+       if (vma->vm_flags & (VM_DROPPABLE | VM_SHADOW_STACK))
+               return false;
+
+       if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
                return false;

        vm_flags &= __VM_UFFD_FLAGS;



-- 
Cheers,

David
