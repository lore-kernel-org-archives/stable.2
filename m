Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435B13D9537;
	Tue,  7 Jul 2026 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418703; cv=none; b=QOhuYZvNMRYugsn5WI+XVG92jGUwCD5N2CfBFaVwERTF3L9BMlITFdnkH7uyfD1XVuILl4JqiTIYRgEj4lPVOlQfug/AW/dtRNy4FnXUPdi3EyFMrTJhurnboDJUBSjhu8SR6A+zqu9CZZB4F0/abGdH1xQaaoRSJW3D1uTxM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418703; c=relaxed/simple;
	bh=yS1p1GgnLNglDbY+Cald4eYjVfgbtQM1+QAy2qJbhE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvqP6GfSDBRI/Zw9zXpTHPv8RwYvdrFQ1a7+rIY4sXp3bHQi+U08FBnuWEG7Y+7RF/gRpWaof5xEAv4oTzWdbgAHbE+MJtj1wMuJdFZjZDELuVB5Qw8g3f40lTVU4GelzvuJjWcBH8bz/ISQ5IYS0Sryq4v7sOhOcer9MlZBqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcT2P/9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcT2P/9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E901F000E9;
	Tue,  7 Jul 2026 10:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783418701;
	bh=lGAXp534qO+aEHvoJU2Le4YyK+vteXPcUM4ADe9Bnec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mcT2P/9kADnHwJJkq/9nQjRjZy5SmS6AXmDky7rUuAc9OuhAY3cOEreJfYv1q31E+
	 swPi7fWld4l48AL3dvbVX5YOOMrVWk6RHtYCTxflhuwQci5bA14gF4N0fQ+5QKsn4w
	 PhS2tH2+kvjS9FTCLm6G5tc4ojo2qtYqK9vokcIYGHZJb7vd24JVGzOpr9AF1gA4ys
	 xxMDmy+asCliCA6nh2jF8jcSsBJSKEE4EE8AV4tJ5KCFIPjo4daFZftcb/vjX0Y2yC
	 9seNr+T2qomG5mmJCHw1UN2/0J0/RrAt0cbOTDnHfmqnQHEh8CbjsaDj0wXvHCZJnk
	 F0QYKs43CCmOg==
Message-ID: <46f19bd8-0d43-4b0e-a8ab-0ef9d3b8bd1a@kernel.org>
Date: Tue, 7 Jul 2026 12:04:56 +0200
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
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <db303a0c-98e3-4967-9b61-ccb711b776c8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/6/26 14:03, Gupta, Pankaj wrote:
> Hi David,
> 
>>> commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering encrypted
>>> memory regions")
>>> added FOLL_LONGTERM to sev_mem_enc_register_region() so anonymous guest RAM is
>>> migrated out of MIGRATE_CMA/ZONE_MOVABLE before a long term pin. This breaks
>>> virtio-pmem which has file backed (MAP_SHARED) host mapping where GUP rejects
>>> FOLL_WRITE | FOLL_LONGTERM since:
>>>
>>> commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to
>>> file-backed mappings")
>>> commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
>>> file-backed mappings").
>>>
>>> Drop FOLL_LONGTERM when registering encrypted memory regions and restore
>>> the previous behavior.
>> But that breaks the original issue of breaking ZONE_MOVABLE/CMA?
>>
>> If it is a longterm pin, it must use FOLL_LONGTERM. :/
>>
>> I assume we fail in check_vma_flags()
>>
>>     if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
>>         return -EOPNOTSUPP;
> 
> Yes, it fails in this path but for file backed mapping, vma_is_fsdax() returns
> false because
> 
> vma_is_dax() returns false:

Ah, okay, so fsdax is not involved and we really only fail because of the
writable_file_mapping_allowed() check.

I was for a second thinking in terms of nested virt :)

> 
>>
>> IIRC, fsdax cannot tolerate unbounded pins. Is that the case we are running into?
> 
> Host side backend is regular file backed memory (no fsdax).

Okay, so we'll end up mapping an ordinary file into VM memory, and expose that
to the VM as part of virtio-pmem device.

That also means that vfio etc. won't be able to longterm-pin such device memory.
So this is not a problem isolated to SEV.

Forbidding to longterm pin is actually the right thing to do if the filesystem
relies on writenotify, as spelled out by Lorenzo's commit:

"
    Writing to file-backed mappings which require folio dirty tracking using
    GUP is a fundamentally broken operation, as kernel write access to GUP
    mappings do not adhere to the semantics expected by a file system.

    A GUP caller uses the direct mapping to access the folio, which does not
    cause write notify to trigger, nor does it enforce that the caller marks
    the folio dirty.

    The problem arises when, after an initial write to the folio, writeback
    results in the folio being cleaned and then the caller, via the GUP
    interface, writes to the folio again.
"

Hmmm

-- 
Cheers,

David
