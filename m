Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554F40D57C
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781921639; cv=none; b=EvHVEF1eFVwHh0vq3UrbXSuF+C9NnNArf8/nMFYsqnn6AkjS2P5nbf7Ho5zAHFJ15ZyaJ4eLiIaSMecNAJq8hyDr0uxqCQ5GJtpF6RMmID40L9ODoeJfVWEH9jhj95xVORAsOwDGxqv5W+w1zQO0EP9NFLL2HI5sp40Vdbc3K4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781921639; c=relaxed/simple;
	bh=Ywws/c6lGmoKUtLrCQAYhmxYgLwGGot56t7huhzXZgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Piu+tJGx9SuGq0AcuTx3qsm9ALIJumnhDro5rPPf+l36h5oVbR3YzdI4QqNEL3kHnh1QeUXYTffuysbArRuZ9DrNUJmy0FJJsXKAe+SCFW97E1YAcMyW1gsQ3PUcXvRtlr6Dhzsx97THRH9AVMtmgIhjVzMlsXYLTA+dlp95pNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch3pIZ0J; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch3pIZ0J"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so3885203a12.3
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 19:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781921636; x=1782526436; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzIFxEJgw7O2jE+Y6+ZWgYeDKhaH241gll1Dl1i0MD0=;
        b=ch3pIZ0JX0AW2oMiU7lIioxIO1l3synsJi1YYh1QbClfzqCM6dHuaJO5a2RIZqvkf6
         zEBvKKSQ0ZzHl0p4VfEB0Zkud8LmTi+wqd44orVFbW/OWGLlcDaTdWRCaxX99LdQuw6o
         W7avGJJKtte1G6VeDgo1GMoQJ8y2XBaHzL4xyjtzzAjkkpbZdKRoYbMFcA8dPqNtuxut
         w8WA5rDNrT3OH24L7D56NZYRik5VeAGtyjJD8X2xUTv8IIHV8+5U6zj7eyZHhSo46HhC
         obkk8Cd0PqMdb4irM+qJblRrvm9pMYftYWJYWsM3pm6b3qRrRpQnd6BmnhBRWyHjPotQ
         XN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781921636; x=1782526436;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzIFxEJgw7O2jE+Y6+ZWgYeDKhaH241gll1Dl1i0MD0=;
        b=SBHNe6eXO/SA5ancEl4GIrlKjYuz8NzplCRQb3R53t08QKgrtXverKF2uN66VktgAw
         p8QmEBtPgtyIicy7M5mETQukZcPN4PlDfzcAVvQkM3+11j7NFkPwa4WPi0GiyrshWp0I
         5QyRRe+EMoQzMHqLAcTM9wcHzeCEXxDwVfIvnd1h6BRT7BT5ieZ2DGKM4NHQEtdY21N4
         bEjGusS1IQxk4fAOMTU34mEqBemvxDyMEWyHOi/5A/SR6MB7KaRgq+iOGCU3DzBesEW/
         B3jWB3V3iTYimldFJ/ksLjGXtW41ckbYaXLp9NnW3wLnt04P1e5vsmQ+hFzlZszvXvSq
         E6VA==
X-Forwarded-Encrypted: i=1; AFNElJ/aE1j1J5Ju6SWC+H6tiF2FGPLBV+5h1rohkboQmGZ0BDUxUqqs6WNkPvgC1NkKREMi9h1uKWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjo7Xb2NO/rtzp9ayRGHv8/zaH8Yk+SvuRGAZeOfMTBXHXv9zR
	z0ANeW7w/dhA4gCvK16dOt2Mc5zAgAuQF/kpx+Z0ZNL7QL07nGYaZU0z
X-Gm-Gg: AfdE7cmUWWluM2xjDd0b7ntBF4lVMjlQ1pLsUhjKbLzWWGCpIaAZsh8JCpcXIz1JBGx
	IT3GYAsw1izuJryHZlmV3mh4g401i4R6lhrjhrqfhTGzavX+bBDBhpQEUsSOtG7zf3eKihWC3ge
	2VqkfA0uRSvP9uR8vmxfq/bWP06InbdbdViDCe1xmN0PXsud9Qb50zFW7sUr8RYw8CGAwOWNfTj
	QWr8Xor60DqYvN8d+WS2w7j4QPhTNZ7KRHbuEuF5RDfUx1Ah3tdVY31mv0u8NFY2acTdotBatCu
	pmLfUh62+h/rb+5DHAookbe3NneJcKSvL+TS0KRlJ/I6HDH/e2hvtlOsHBUbNU1s1XDkoudoy5k
	lV2l/1OaHUYtlXBfZUdOeRvAwsO7dDRN45Zt38DmJLnIEH1f25P9XQrrGVt8eR/mhoIkU3yHHbH
	s4wJLPhZEMxNs=
X-Received: by 2002:a17:907:9411:b0:bef:89d9:9f08 with SMTP id a640c23a62f3a-c097ae38023mr306303966b.19.1781921635995;
        Fri, 19 Jun 2026 19:13:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e49aa07sm47766966b.10.2026.06.19.19.13.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jun 2026 19:13:54 -0700 (PDT)
Date: Sat, 20 Jun 2026 02:13:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Wei Yang <richard.weiyang@gmail.com>,
	akpm@linux-foundation.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	balbirs@nvidia.com, ziy@nvidia.com, sj@kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260620021353.nn7xp2ldqachq7gp@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260616063436.20455-1-richard.weiyang@gmail.com>
 <ajUXNjRMraKb6k2n@lucifer>
 <5e7f7fe5-221a-4fca-aa76-297ae19eb80d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7f7fe5-221a-4fca-aa76-297ae19eb80d@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jun 19, 2026 at 12:48:26PM +0200, David Hildenbrand (Arm) wrote:
>On 6/19/26 12:44, Lorenzo Stoakes wrote:
>> -cc wrong email
>> 
>> On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
>>> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
>>> before return the pmd entry:
>>>
>>>   * re-validate pmd entry after PTL
>>>   * check PVMW_MIGRATION
>>>   * check_pmd()
>>>   * handle on pte level if split under us
>>>
>>> But for device-private pmd, we just return after pmd_lock().
>>>
>>> This may return improper entry, e.g. if we are looking for a migration
>>> entry, device-private entry could still be returned, which leads to data
>>> corruption.
>> 
>> I don't thik this is quite clear?
>> 
>> How about:
>> 
>> 	If a softleaf entry is present, the existing code simply acquires the
>> 	PMD lock and returns success even if PVMW_MIGRATION is set (indicating a
>> 	migration entry is sought), meaning that the caller can incorrectly
>> 	interpret the entry as something it is not, causing data corruption.
>> 
>>>
>>> This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
>>> support device-private entries") by following the same pattern as
>>> pmd_trans_huge() and pmd_is_migration_entry() for device private entry.
>>>
>>> While at it, it cleanups the pmd entry handling in page_vma_mapped_walk().
>>>
>>>   * Instead of handling trans huge/migration entry/device private entry
>>>     in a mixed manner, we put each case into its own if condition and
>>>     handle with the same pattern.
>>>   * Also we grab PTL and make sure pmd is not changed under us after
>>>     above check instead of do the check with PTL hold.
>>>   * restart the process if pmd is changed under us
>> 
>> You're doing quite a bit for a fix and you're putting it all in one place.
>> 
>> How about do the fix as 1 patch, and then cleanups as other ones? It helps with
>> review too :)
>> 
>> It's a general rule of thumb that if you do more than one of moving, refactoring
>> or changing code, to do them as separate patches so a reviewer/somebody
>> bisecting can clearly separate each.
>> 
>> Also PLEASE do not add new functionality (this lock recheck) in a fixes
>> patch. We'll end up backporting new logic that way.
>> 
>> Make the fixes bit _minimal_.
>
>To be fair, I asked for this
>
>https://lore.kernel.org/all/2d48ef0d-1110-4a9d-adcb-f701a1ce2cfa@kernel.org/
>
>But given that Wei mostly used my quick draft without properly checking the
>implications, yeah, let's fix it first separately.

Sorry, if I misunderstand your point.

>
>I can then follow up with a proper cleanup.
>

I would like to do a followup cleanup for this, may I have this chance?

-- 
Wei Yang
Help you, Help me
