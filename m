Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126787;
	b=OWbSmW5Onkvax+Fh9sCY/qTECtji+v0gLgR0l23ybESeuH+1DjGkYJB2TRZS8afZheyW
	 mN397rHdfjEDqMOGx5P7KFXFqyIN0TAPnNnd6N85c4aKRFPTwJBBdiYfYPsGr/ix+HtJI
	 7wvKs+xNc31H35Q70IsUP2lYM9SSVSJ0/0+s33emRxJe3Yu4fS6PvZJI/6VeX4j/eKnYk
	 fJqde7K8HkEHVeGJB3dEzTcNO4Pf6mWNsdvJPNWsop4MNa+xDkbAeJkXvHKyauFeyF7V/
	 sq5RhfvyIOOTzD80WAwf/amRQOMGNDOAUamgLP/dx+jQg2MUWEI3hlSsJbM/A9cxzew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126787;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=AiPQ4wl6tF2e90uhD0HmkSpXHz6ccxWLOtHHkF4KxNg=;
	b=yLmFTv9EUBTmlN1zowwkPNH/4ZbscAxIVVixzKhbybY/f45D2umBPQrSGLSih3Day/Rf
	 Q1dPLsnrp+4nWPtePFrMkLIdNqkDvjudCw6BUKNq4fmPJSt8IYlx2GmebDPNlDW8N+ca7
	 WjbcGKWlhq4WCN93ODO8cqV4ml5dwu4x8XHcZLHhQlK8g8FONWYsCJkbEK9ZLojt8+R+m
	 uo6sZ3refACTuPxjtf1CChGYnAlun4X7OSpruXo215flQezRKQUdjjhRTRt2U4IwJkPDi
	 vzv43pV+q1APpFaB3SLLUlmsvSy8okLd+EBhyOtc9Iti/w/6cqXI78axTWLReh2TEAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6Ihx2Fp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6A606A320;
	Thu, 19 Nov 2026 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6Ihx2Fp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74DA1F000C6;
	Thu, 19 Nov 2026 22:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795126787;
	bh=AiPQ4wl6tF2e90uhD0HmkSpXHz6ccxWLOtHHkF4KxNg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=G6Ihx2Fpp/Dy57CCYAyiaqVtXntjB8VAYpH4cw8ydBW5EOTje8iTEujXpMSO/JcqO
	 oEg06AcBjBNeRcUg1pBPJhTGDsJsWaR0MnDSzOoJtORkODc15tx1kfIg9Fd1ocaE1v
	 A7e/EIS3osWR/oylCwh8Lwf1iwaQDv7lNmhN8XD6ZFW4bqsdi+YbX4Gagm7UUpRvsT
	 wWN16VGpxmQw2+0jLej738gnehufQqV/tYQ7JEz5nTmvZ5RBn2oE9A7bYQQjOYtuHs
	 RcLa92YrubfjxIB6banH0SIBL1dj8Ms/SiFK8Asi+PsLtyiI51mmztQnQwwdpqpKPs
	 L37pGn5IuqoKQ==
Message-ID: <421ee488-e2a1-4deb-9ffb-7fc712c811de@kernel.org>
Date: Thu, 19 Nov 2026 23:19:40 +0100
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
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "Hansen, Dave" <dave.hansen@intel.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "ljs@kernel.org" <ljs@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "kernel-team@meta.com" <kernel-team@meta.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rppt@kernel.org" <rppt@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "kas@kernel.org" <kas@kernel.org>, "leon@kernel.org" <leon@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "gourry@gourry.net" <gourry@gourry.net>
References: <20261113195536.2660763-1-gourry@gourry.net>
 <20261113200303.GA395967@nvidia.com>
 <179460249376.482102.14669935557901467762.b4-reply@b4>
 <20261114002027.GE3706007@nvidia.com>
 <20261113181025.6e8b9475b29c13d29f59e02e@linux-foundation.org>
 <20261115000005.GG3706007@nvidia.com>
 <20261114170127.3d29199864eb352d9045eaba@linux-foundation.org>
 <55034934-8aab-4e8a-a74a-b30c977670ed@intel.com>
 <0c6fcb3daeab0ab3df0593cf389124e38e1d7f3f.camel@intel.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <0c6fcb3daeab0ab3df0593cf389124e38e1d7f3f.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/19/26 21:40, Edgecombe, Rick P wrote:
> On Thu, 2026-11-19 at 12:05 -0800, Dave Hansen wrote:
>> On 11/14/26 17:01, Andrew Morton wrote:
>>> On x86, a shadow-stack PTE has its ordinary write bit clear.  The CPU
>>> rejects ordinary stores, but pte_write() reports it writable because
>>> shadow-stack instructions can write it.  HMM consequently sets
>>> HMM_PFN_WRITE.  Nouveau uses that flag for GPU write permission, and
>>> RDMA on-demand paging can use it to grant device write permission to a
>>> registered memory region.  A device, or an RDMA peer with write access
>>> to that region, can then overwrite the process's shadow stack,
>>> potentially corrupting return addresses or bypassing that protection.
>>>
>>> Reject shadow-stack VMAs in hmm_vma_walk_test(), including read access.
>>> A requested fault returns -EFAULT; a snapshot records HMM_PFN_ERROR.
>>
>> This is a fun one.
>>
>> I almost wonder if we want to go one step further and disallow GUPs with
>> FOLL_WRITE on these PTEs. There should be precious few reasons for
>> devices to be writing to shadow stack pages.
>>
>> Isn't this a bigger issue than HMM? Should the fix be in HMM?
> 
> We do reject GUPs to shadow stack PTEs with FOLL_WRITE, unless FOLL_FORCE is
> passed. The tricky thing as mentioned my others in this thread is that shadow
> stack memory *is* writable by userspace. But also the kernel should not treat it
> as such
> 
> A false negative for pte_write() is dangerous when the kernel needs to decide
> when to revoke access. (i.e. fork) I think a mistake there is somewhat worse
> then missing an exotic way to cajole the kernel into writing to a user's shadow
> stack like this. So I think pte_write() being true for shadow stacks is the
> correct implementation.
> 
> But, maybe the problem is that pte_write() is doing the job of two separate
> concepts. What if there was a pte_userspace_could_write() and a
> pte_kernel_should_not_write()? Names would need some work...

Gah, nak,

pte_write() just says "something might be able to write to it".

If that's actually true depends on other factors. Like the access+dirty on HW
that manages that in software.

I repeat: *no code* in Linux besides core-mm should ever interpret "pte_write()"
as "cool, I can write to it". The exception is GUP and unfortunately HMM.

-- 
Cheers,

David
