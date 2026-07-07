Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A73E8688;
	Tue,  7 Jul 2026 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436326; cv=none; b=a61cDLOuCfH508pxsiDhzQgVwovIwmdk2GPmcphCArxCFt9USSPoCZrMfEBQufJI4SMr64fU3IjYkOSMhyQWmS5VMaCzYogRyps6qq9n1nwfaANq/fBotZtHSbDIvcL2yej2BlC0shcOblIhKb6bILrQhcFdMKqWC+sJAoDRBAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436326; c=relaxed/simple;
	bh=PlMxsGARKkgfcMvVXTnKC8/T3l8zRC4VArlMr7lNFQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OW6Hofc0i52a1wNgU0ZnUY360Jd7/XgC0MZUCS6q6+lf1ZerTdTl3STt+HOnXNzn/0snKxPjrkMz6r94w8tih/UWt3U/q4tSz3a9bYExlX5u1Spmn/5B/Q4VmIbeoAmCu7pDAnBHOjBshiSIj3qCteTBelkIWwsMOqA/BVgysbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfDIla2s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfDIla2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4C71F00A3A;
	Tue,  7 Jul 2026 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783436323;
	bh=ygpMICMoTnkpL1/1oxwmS7t/GpkK91ripgRv9mbioew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kfDIla2sbEsBl3KxEfELr0718lUqk8sYVGFqtQmOcUJdRMzBbBOAovYXorXdGZoFO
	 g7NineCVlSviBjqaUlWQ0OfCKobp0+HEbPnZ0z9/f+d/xWFZugdwHunU4/0lIeRaY3
	 sOyMTlWG1wwWFtHZj7kz7BhgrEHYHRYOXM0c85aMjDdD2ptPSgvD4HunFJ8k2D4L7l
	 Yw9OIZ726jyBAATK0QzS/KoTfDfA4cJpVxXKrmb8sK2bTKtoH1wj/Q5De0WOeEWsll
	 opt2e8PlkYvAzCPH2R1YNEpxY6qNj2GeOt5sfy+JcjJiOx4tQV0H/3+uu2lA5IkYG/
	 +7EP7wFlVczLw==
Message-ID: <27ebe8f0-78b6-402a-a2e7-4e807251d20a@kernel.org>
Date: Tue, 7 Jul 2026 16:58:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region
 registration
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>, seanjc@google.com,
 pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com,
 dave.hansen@linux.intel.com
Cc: bp@alien8.de, x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
 yangge1116@126.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
References: <20260701144543.39582-1-pankaj.gupta@amd.com>
 <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
 <db303a0c-98e3-4967-9b61-ccb711b776c8@amd.com>
 <46f19bd8-0d43-4b0e-a8ab-0ef9d3b8bd1a@kernel.org>
 <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/7/26 15:45, Gupta, Pankaj wrote:
> 
>>> Hi David,
>>>
>>> Yes, it fails in this path but for file backed mapping, vma_is_fsdax() returns
>>> false because
>>>
>>> vma_is_dax() returns false:
>> Ah, okay, so fsdax is not involved and we really only fail because of the
>> writable_file_mapping_allowed() check.
>>
>> I was for a second thinking in terms of nested virt :)
>>
>>> Host side backend is regular file backed memory (no fsdax).
>> Okay, so we'll end up mapping an ordinary file into VM memory, and expose that
>> to the VM as part of virtio-pmem device.
>>
>> That also means that vfio etc. won't be able to longterm-pin such device memory.
>> So this is not a problem isolated to SEV.
>>
>> Forbidding to longterm pin is actually the right thing to do if the filesystem
>> relies on writenotify, as spelled out by Lorenzo's commit:
>>
>> "
>>      Writing to file-backed mappings which require folio dirty tracking using
>>      GUP is a fundamentally broken operation, as kernel write access to GUP
>>      mappings do not adhere to the semantics expected by a file system.
>>
>>      A GUP caller uses the direct mapping to access the folio, which does not
>>      cause write notify to trigger, nor does it enforce that the caller marks
>>      the folio dirty.
>>
>>      The problem arises when, after an initial write to the folio, writeback
>>      results in the folio being cleaned and then the caller, via the GUP
>>      interface, writes to the folio again.
>> "
>>
>> Hmmm
> 
> Yes. For file based mapping we don't allow long term pinning.
> 
> If we take into account the fragmentation concerns for MIGRATE_CMA and
> ZONE_MOVABLE allocations
> 
> solvable with FOLL_LONGTERM, I can think of two options(tested) to allow file
> based mappings as well:
> 
> 1. Fallback on FOLL_WRITE when FOLL_LONGTERM fails as suggested by Sean.

That is just not acceptable, as it breaks random other stuff (MIGRATE_CMA, as
one example) besides the file-pinning problems that Lorenzo added.

If we're going to hack something in, then that we bypass the file writeback check.
Not that we don't use FOLL_LONGTERM.

I'd hate to use a GUP flag to indicate "this is a legacy hack", but it clearly isolates the
issue (needs a better name obviously):


diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ae9bca4eda5ca..e2c531f914d44 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1912,6 +1912,9 @@ enum {
         */
        FOLL_HONOR_NUMA_FAULT = 1 << 12,
 
+       /* TODO */
+       FOLL_LONGTERM = 1 << 13,
+
        /* See also internal only FOLL flags in mm/internal.h */
 };
 
diff --git a/mm/gup.c b/mm/gup.c
index 0692119b79043..1fa0aa0cdc99d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1186,8 +1186,8 @@ static bool writable_file_mapping_allowed(struct vm_area_struct *vma,
         * If we aren't pinning then no problematic write can occur. A long term
         * pin is the most egregious case so this is the case we disallow.
         */
-       if ((gup_flags & (FOLL_PIN | FOLL_LONGTERM)) !=
-           (FOLL_PIN | FOLL_LONGTERM))
+       if ((gup_flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_LONGTERM_HACK)) !=
+           (FOLL_PIN | FOLL_LONGTERM | FOLL_LONGTERM_HACK))
                return true;
 
        /*
@@ -2746,7 +2746,7 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
         * If we aren't pinning then no problematic write can occur. A long term
         * pin is the most egregious case so this is the one we disallow.
         */
-       if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) ==
+       if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE | FOLL_LONGTERM_HACK)) ==
            (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
                reject_file_backed = true;
 
@@ -3180,7 +3180,7 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
        int locked = 0;
        int ret;
 
-       if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
+       if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM | FOLL_LONGTERM_HACK |
                                       FOLL_FORCE | FOLL_PIN | FOLL_GET |
                                       FOLL_FAST_ONLY | FOLL_NOFAULT |
                                       FOLL_PCI_P2PDMA | FOLL_HONOR_NUMA_FAULT)))


-- 
Cheers,

David
