Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794952316;
	b=lZbHBO5YRzl9MIdcPPdsXYQH3U2r/JymZI5Q1yKzVVBabxWEhfBaJ6YscFmGK5Q+xjJ1
	 1KCm6Wb19KpYZhvHtawVttodW6HSdxcirfuUI78fAlg7UbHPuPuHDbi0l2rlZ12MPzG8m
	 w1ppr0xelgWZULDctHUf/UuYs6Qh2bEljIhqNrPFkKCvWR1Ra2d7jF2ST2oRJl/NKJ8ch
	 SS4FZ3kFGzzsUL+azOskOaA07/ue5EKaCMOB+F3iZMYyRZdviHU+4LQoe0t590XjTebCj
	 9kiB0wXfLGUUnbjn2Gwj346hQqVWkRg/ELkGRan2MfRYjbUlyT0K/r9MnomX4mG/VMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794952316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=od7whLjYp5CgaE7fiVH0EHWEg2I7Xd9uLKWSaqIJaMI=;
	b=0o1VXTxcd7ZOWHJ1Voyei4+t3++dMYA+NDx/yanBiP8Rn6DovtpenaF9A5wdz4j2ZMCi
	 qF+ZWvBY8oPjz1qEBM6ykwqFgCO1Th+cP/XStQLCIS+/sRjsb4LqKU+ikTaP/DmSdpqSQ
	 Mj1+DnBJpP9Drv2d35aycJV9nxbgP4seWtScOrKKxmzgRRriwxRkxkiwZsUWBpDTZ5Ff8
	 Vxhk42CDTOggeSHlns2RIszeDvq3nb4Lf+XJRR0twTIrUsgZocJbZp3x5znhsxBw2ueft
	 KN3HM5zEtMDQIxYGwVICVGb7dhfKKgUAB6pie4Glsb8LGsO0OkresfcwI8Z5Yi1yGsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vyPRIsbv;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A01606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 21:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82A01606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vyPRIsbv
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so1697545e9.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 13:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794952315; x=1795557115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=od7whLjYp5CgaE7fiVH0EHWEg2I7Xd9uLKWSaqIJaMI=;
        b=vyPRIsbv/m0RBukdtMXOPGZeyUhMweLxcCjziu/fW2S1RdvGfR/z0u0PDceojIEwD0
         FfTwrFQ8/GAXqBGxwG80ywbRpqj3huoIhcqxtrjnECZfy+EuzG+/weUZWWb8v6MkSlFV
         PVxtH7z4HvtjASPNNqmBUYWiBkCT6D6FJqXBztCjpoDdVdNmBHvoT+l4LWaM34z4poTR
         4MhAAzDjn/InfZo85lhNoFUwFh/zoClp+FnzCE7FE5PQ1j8CkPJNFqWRF//BmITxbbWg
         jQQFugy3GoNBm79MJOOZ6Y+ugqnUXzU0dIf7LAjbxFo0OHXxQzVPxEixpxeaaMkjlzwK
         u+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794952315; x=1795557115;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=od7whLjYp5CgaE7fiVH0EHWEg2I7Xd9uLKWSaqIJaMI=;
        b=Cvoc+5N+IfB7AjIkn7KW/Z1WoMVz4eVSGSYiuaGXbH0JDuI0ZE7r0BF6n5A0ZPDzMO
         qhEerDm9kvmJoxDob8vUEehc0myE0AIFCRgK7XTWbsQbZzKlUg7s3uuEGCB3Z75hH+mU
         RlHv1IR9cwTJ3630FW2qyrXmQM+gGJWi+tz8v31NU3PPi1BDgA4xj72hxaTKnZNIPcWJ
         AnPu200bYvD29WHN8gAc5yuyfS82vV6Ilo4pKDEDRLzlft4a7a4t/mnHBmyQJIh8fTW6
         uMyPkXquHHhoaoirXksu7QbVyOR+zUnoDG13xqL2zZhohaToClEUHPINKQIiJI/AzpCJ
         UodQ==
X-Forwarded-Encrypted: i=1; AL+hErHMDhqOmHzW0uLEPoHlvrWOSkdVIzNs/fNAapRFmlisjCb79+ca+7GyVQMYl2WFXN8nlcLnjNw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cU8AWtyaC1Q1vKc7cPeJome3ktnb5RSdRJdDVxsA363oMcQ8c
	PuZR64t/t2aDHZZMvNzI3OwOY1hGAZG2cwLfqXF6nbexHmz/sNzHkfBJ
X-Gm-Gg: AYBFou336RPSsqnTB0DYHhGqjxU4G2myI2UGT8O79WNMW63fNdr9+7JyXTWwfi9IzES
	+mHnUfKiwMkHLdlGRdi12o+MKqBs9/8Vr6N+BPTt+HEkHUYGj84LJxilEch7Fqmlhah1XCvLhye
	kYpZL71GWAD9RsvzLHQWdjWBVZktNZYXzTHHWz3nlCJ5l59/2hR5vg1197qicXTsFkl3ZLWxvLX
	sF5G7/6oB1HzzVfGNUFj4rZgEwK4FA93PArQ3rrWfnszM7b6TKzcOjs8qvWpxgGAWBH48SekpuI
	pWhCc0ApZU5dtrM9aea4a9PG+2UlEb/WS4HK//Xp7iBzICCx2yfcVJMAVpnUZJuqXLYLkx3G32A
	ZC8ZTA6isODvzgiXmuH2Df4eL0Mbgv5JpEt5mZC+Z8lqVZQq9Nk/u/iCnApdO5u6vFTUJShcuS3
	J6Z+wbIESInxaBGrK8O8EE114WRHrkjBhuZGZDtAAZdmnFvzOVfnQQyh9d7ZNsb1fWq8OnnsgBH
	FQpFRiYFv6BIlFlcxItRkgOVEdtj5dcr4+L1Qx+QUksBTObt3R2J8XMxyXtcMHVMmlPsCZgkPjs
	RMwoQOSamMdztbCcs9dTi+6I
X-Received: by 2002:a05:600c:a54:b0:4bb:5fd1:92aa with SMTP id 5b1f17b1804b1-4bb7da30033mr11230145e9.15.1794952314685;
        Tue, 17 Nov 2026 13:51:54 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d256f64sm14627035e9.1.2026.11.17.13.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 13:51:54 -0800 (PST)
Message-ID: <817544cd-8b7e-4193-bd3a-c270284f6c8b@gmail.com>
Date: Tue, 17 Nov 2026 22:51:52 +0100
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
Subject: Re: [PATCH v2 3/4] mm/memory: do not report OOM if insert_pfn() races
 a huge fault
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
 <20261117-huge-pfnmap-fault-races-v2-3-276007e73bcb@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261117-huge-pfnmap-fault-races-v2-3-276007e73bcb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 7:31 PM, Lorenzo Stoakes (ARM) wrote:
> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
> 
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
> 
> This is not currently safely handled by insert_pfn(), however, which
> obtains its PTE entry via get_locked_pte(), and treats a NULL return value
> as an allocation failure, returning VM_FAULT_OOM.
> 
> The issue is that get_locked_pte() also returns NULL if the PMD entry is
> not a page table which can happen if a concurrent huge fault installs a
> huge PMD entry between __handle_mm_fault() observing the PMD entry to be
> empty and insert_pfn() being invoked.
> 
> This can result in VM_FAULT_OOM being reported incorrectly.
> 
> Fix this by introducing and using __get_locked_pte() which returns -ENOMEM
> if a page table allocation fails or -EFAULT if raced.
> 
> This allows insert_pfn() to return VM_FAULT_OOM only when an allocation
> fails and VM_FAULT_NOPAGE otherwise so the fault is retried.
> 
> The same change is applied to insert_page(), which only impacts DAX (which
> has its own locking).
> 
> This means that insert_page() now propagates the returned error, so -EFAULT
> in the case of a race. It's not possible currently, but guards against that
> changing in future.
> 
> Similarly, update walk_to_pmd() to return -EFAULT if it encounters a huge
> PUD leaf.
> 
> Target the commit introducing the first driver able to do this.
> 
> Reported-by: Eliav Farber <farbere@amazon.com>
> Closes: https://lore.kernel.org/all/20261112051440.16140-3-farbere@amazon.com/
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Suggested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
