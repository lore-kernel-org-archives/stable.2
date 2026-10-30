Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355888;
	b=FhVzfh3y9moHs47k5VkYvUb8rmg6U/j79TCSOSP/hrLo1/BNpwm5C777iEGMwNUT0WSZ
	 UJYR0+0P/xD3CVlgoi9lSmQTeWKBzPHlia/q0R+KdYPW59gd2YV5wGyKDGQR9sRKVGazd
	 uLuzF3bRdvLgdOldppcGKGfQ50YCyBVwLfu7lno1bBvwe8+vn5XBRlfzxCShIr8yYSF50
	 C2dCyLF1QrdEMrLstDLCIW1vBYOlETNLMXJdgl486HmGkic6L300WEnDKx/YXDpnzlDd2
	 OpLQpfqQvlWf7tNkNNIu7nhw0A6jSGDdS6YK9nSCYuqjmAD3wpQsaaIM0DTLPwm+E9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=CwWE7UOGE7vvkgiGMpiO2wb6+EIxQ8HXhg/iR90K5xU=;
	b=aTOwogRYyfVMllTQD+a0JQ4ppvc9DOFuZ3zZK2HjTQVRsK/uRsu6J6Yg+88ZZe7GhXxK
	 8Ww9kjUy5K4Ks/QnohMWMBds9jyJDvoirWlujRwjQpoEhTCEpkRgLIzJocCretE7dYXd7
	 0/0DFpeqhx1gzUMH0tVdA0XjscKa527KlBvYtNMCWvl+9qv/geL2QNMkleGcv9GvBOEWj
	 LnHM8beiM5hcndRhrqGSiKCihuYSyUZfXWVFyLcTED8E9BimAI+A6OgKTQlEHoxLYKcM5
	 peq4UVgwpeBqJe5WzJtK5uqSq7QTCmfNT6XLw1w8yw+hkcfPNE4Ku0c8sHrcZ0+qc5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuaPdODR;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A44606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1A44606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuaPdODR
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1931ff67a29so1501546c88.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793355887; x=1793960687; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CwWE7UOGE7vvkgiGMpiO2wb6+EIxQ8HXhg/iR90K5xU=;
        b=WuaPdODRsRMFiI8tCzDGLtIWj/t3kmU7toTjs7yU4HCs2ivVqxGQQvm6C7+DRbmp2c
         mytF4JZUfqc8tWgTYXVYiq/EntpFK58ycgKy6BHzSPT/xPNddavbvn/15l7RoYj4rzJ1
         GHcJcCJvZ/nc80BsfpqAoyfDNpOoOIgczkvsBDoVQlFvsr+bbifzjM+LbtU87kjL8cRI
         8D5odWnPRckICnn9cHmMoPWDChpmRdV7BN+4koQaYRRf1EQg9k4pbSmDh6F1YQ3uc3/O
         LDtoIX9o2xiZ/xLZE0g3/sl4xa5l5+9Ds3mVpMbnuJMzJTFpChsV+mTWN20OEHtNRp+a
         o4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355887; x=1793960687;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CwWE7UOGE7vvkgiGMpiO2wb6+EIxQ8HXhg/iR90K5xU=;
        b=HtGzpxEdphcoz9OUR+3YolcFKyf9Ck8+vVFVxdRYQH6nWxiLXE3nfpfXUW9icDFcqI
         E9DnvBWvpBW3YdtW3wnairN6IjFjJ0ThQp+12teuk/IcV0f+5WjMEdJOZW1GPB+C7s5o
         rc1MzfP2L150b1UjxIUgzKIK3QezVEW49LBzPyedgJ/QJ77qZ1koLaYVqQyPA0SWPHF3
         CO9HYNMhWpxMt8FT912yxk4Nezv++tYRxPxkHelp9vbfiSe4NFp+zxAqSbnsb5+Jvrll
         GUzQmOwxICDUF9ICqBCZ4qtFft+LwXShuwuLSSfLiXfKH1ksopUoL9nOqq+CyT9I905q
         /ZXw==
X-Forwarded-Encrypted: i=1; AKwUvByunSznvGeA3m47b6vYEbedn2QKWib32PXrdqWqrwzJAE8+09rbZge3udcN0GbYZFayh0dA4k4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2UUmiNyu6sugXrLJ/affGiONKFxF7wXChlvKTE+fWduNx+ahz
	EusKZM2cBkF72t49jRIHALzDmTXSFqJ6AIqJXaAuNP62p8YWym2eohGJXF6L2Q==
X-Gm-Gg: AYBFou3VHOGoYwoG1U8aztUYQ2jBKeQkplhqg7MEK4j2jUoCxVHIUQD77nuIbx0cjP9
	tV9bFQG9jqG9RR5DJ+SMhFfaEvQxe8fBMnQZAm72ghybtBzFbzdEuoL8cqH2cGtlCHKDKT6rNm7
	QS5E/WO8rs97y4nNLYjrdhcd5EnQJ9968/hCvR2aRigh0Jc+Tu9Quzkw8fx5VzKF6UaXSPYaG8l
	OdwO2M3xTsWD/LEAQQxMWO6CwMI+BFTFSh5wkyOl3UlAqQT09kzHIyRt84xBx6QVMOZYRhAycEr
	FzJVKGOHvptxyiyLOsJebT6bc97rYIIj30iSYZohqY7llhJI2SMq6g1kDM/HfNP8y2WognhAWKw
	LBwbCsjz1guuGyhH2sWsrBbS4/1uUUeUJyC6KsevXMEK1lOLnwD5MNmm4i77CAWV6mKH9oTY6mt
	BQLVEqQpgsKTsxsNqxtC+bEL8IPPIcomAIwzG/jX3vpQyKJWMLHcdOXfBbRSM2etQ+OCNROwDVq
	MW8CTJen3bZ8zUpzY2A9sEyNbs5V7H/oUJhgHQ+21I9MFmy71w1/eRPVRwygbPbZzuOxCeN4HpP
	YyWlmsxIcY0Zx+OHdqT2i1A7zLg=
X-Received: by 2002:a05:7022:3b87:b0:196:d6e1:108b with SMTP id a92af1059eb24-1ac59fbfd13mr2589413c88.10.1793355886505;
        Fri, 30 Oct 2026 03:24:46 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b0a628bsm5805067c88.22.2026.10.30.03.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:24:45 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Pavithra <pavrampu@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: fix uninitialized ZONE_DEVICE struct pages with PMDs
In-Reply-To: <20FE1232-A48B-4F72-8F18-89EFF70EE0FE@linux.dev>
Date: Fri, 30 Oct 2026 15:50:40 +0530
Message-ID: <bj8bwkuf.ritesh.list@gmail.com>
References: <20261029063601.1961415-1-songmuchun@bytedance.com> <h5i4wlx5.ritesh.list@gmail.com> <20FE1232-A48B-4F72-8F18-89EFF70EE0FE@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Muchun Song <muchun.song@linux.dev> writes:

>> On Oct 29, 2026, at 23:45, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
>> 
>> Muchun Song <songmuchun@bytedance.com> writes:
>> 
>> Thanks Muchun,
>> 
>>> PowerPC radix vmemmap population can reuse an existing PMD mapping while
>>> populating a device DAX range whose section is marked as HVO-enabled. The
>>> reused mapping is an ordinary vmemmap mapping: the redundant tail struct
>>> pages are not remapped to the shared tail page.
>>> 
>>> Leaving the section marked as HVO-enabled makes later ZONE_DEVICE
>>> initialization treat the range as optimized and initialize only the struct
>>> pages that would be backed by a real HVO mapping. The remaining tail struct
>>> pages can then be left uninitialized even though they are still used as
>>> metadata for the device DAX compound page.
>>> 
>>> This first triggers a zone mismatch warning in __init_single_page(), then
>>> faults while initializing the pageblock flags:
>>> 
>>>  WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
>>>  Call Trace:
>>>    memmap_init_zone_device+0x164/0x430
>>>    memremap_pages+0x43c/0x93c
>>>    devm_memremap_pages+0x3c/0xa4
>>>    dev_dax_probe+0x264/0x3d0
>>>    dax_bus_probe+0x140/0x1c8
>>> 
>>>  BUG: Kernel NULL pointer dereference on read at 0x00001400
>>>    __set_pfnblock_flags_mask.constprop.0+0x34/0x160
>>>    memmap_init_zone_device+0x358/0x430
>>> 
>>> On kernels without these initialization-time diagnostics, the
>>> uninitialized metadata remains latent. When userspace later maps and
>>> accesses the affected device DAX range, the kernel operates on those struct
>>> pages and panics at that point instead of during device initialization.
>>> 
>>> The Fixes target predates the section-based vmemmap optimization
>>> infrastructure, so older kernels do not have section state that can be
>>> marked non-HVO. Backports to such kernels need to handle the PMD-reuse case
>>> in powerpc radix code directly, for example by initializing the tail struct
>>> pages that core ZONE_DEVICE initialization would otherwise skip.
>>> 
>> 
>> Actually that would be totally new code right? It won't be a straight
>> forward backport, correct? ... 
>
> Right. Because it's impossible to backport the whole section-based vmemmap
> optimization infrastructure (48 commits).
>
>> 
>>> Mark the section as non-HVO when reusing an existing PMD mapping, so the
>>> section's HVO state matches the actual vmemmap layout and all required
>>> struct pages are initialized.
>>> 
>>> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
>>> Cc: stable@vger.kernel.org
>> 
>> ... then should we mark Cc: stable here with the above mentioned fixes
>> tag? Because this patch cannot be backported as is to older kernels -
>> for the reasons you mentioned above.
>
> The comment following the trailer is used to guide stable maintainers to
> backport proper prerequisite commits. It's hard to do that. So I choose to
> mention the alternative in the commit message. But with the help of LLM,
> I found the alternative is also not the right solution. The reason is as below.
>
> That pmd_leaf() path only creates or reuses the vmemmap mapping. After it
> returns, sparse_add_section() calls page_init_poison() on the whole memmap,
> which overwrites any page state initialized there.
>
> Therefore, older kernels must pass the PMD-leaf information to
> memmap_init_zone_device() and let it initialize all real tail struct
> page entries. Initializing them immediately in the PowerPC pmd_leaf()
> branch would be too early.
>
> Another solution is making vmemmap_can_optimize() range-aware by passing
> the vmemmap start and end addresses.
>
> On PowerPC, reject the optimization when any part of the range is already
> covered by a PMD leaf. This ensures that an existing PMD mapping is reused
> normally and that all real tail struct page entries are initialized later
> by the core code.
>
> Maybe it should be a separate patch for old kernels? Thoughts?
>

yes, I think we can do a separate patch later for older kernels. I
will look at your suggestions to see what can be done in that case.


>> 
>>> Reported-by: Pavithra <pavrampu@linux.ibm.com>
>>> Closes: https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> ---
>>> arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
>>> 1 file changed, 10 insertions(+), 1 deletion(-)
>>> 
>> 
>> I think, this patch should go via mm tree, due to all the dependencies
>> coming from there, right?
>
> Better. I hope Andrew will pick it up once I send a v2 version with more
> proper commit message changed.
>

I think we can add an explicit comment like this then?

Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
Cc: <stable@vger.kernel.org> # see patch description, needs a different fix for <= 7.3

-ritesh

