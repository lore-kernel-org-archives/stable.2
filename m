Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602877;
	b=Vgsb1Rt2qJk7svrfKHWoU49m8bZkdAeEMNBnQ3RGYp7b13MsbbM0fMx8KN7l9jvS0TXp
	 j1eXCecZgfaIPPIKcHSuEBW4sz8kTtaKSaA7V7TJPMeq50V8x7g7NOQ8C3MZX7Z+ZHDMr
	 xmIyS7v9ZFRyOY0JPbprX4x19C0fRWXEZaDsrRyq2ZKLoFQc5074hXgu+11+yNtjPoEYX
	 H5e9nQE0pfbhzp4wGpN6BYglccF+N0GBYDnCAQZD4bqQLad8RgMedM6BaPTnOgnVsHW9l
	 8UM0vJBcZnaC1XCBSo+C01HsqIeyJBMTFI/A7CbJ46LtHKVKz/wpMpvN8XgDcJFmkZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602877;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8jY8XpaYgmA53HXY22kW+XbJRfVwUAnog+5j0SSxl6A=;
	b=JGcOXJQE7z4+uVqeLnzyxzj6xnxhUPtLAf+QVF1K3ezxvzs2NuUwZoHjIlTIYsMWOKkz
	 e/JmZzwS8VMJJqLOVMNrnzcx57P1fOOSIuexBCCeq4sHe+assKN8a8yL7D/ZOjnU9n/02
	 DKC5DmDR+tSAMU6nH+r7hJaEbcM2hy42xlKAIYgxAt9Jwmn98SceU4a8xRIhnHudxeasE
	 PYW0hk5Rhj2gJPju68I3lZLVQTSkD/0bGMVw+3hko0bJAHDFNPLPYrsOI3eRTZ3s5HliF
	 6HWgr50hsAm9mqtfc+af+hXUdGXwd90p/bnmSrcDxMrcT6fjfXGwt6SjU7yBM+49wHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayLpLZrD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92E8606A324;
	Mon,  2 Nov 2026 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayLpLZrD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1BF1F000C1;
	Mon,  2 Nov 2026 07:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602876;
	bh=8jY8XpaYgmA53HXY22kW+XbJRfVwUAnog+5j0SSxl6A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ayLpLZrD91MV+ICG3Fack6rUmwXp0VVRmmG7WDL665UIqgU6aQAHE2cfgeEAFj2w6
	 3OfRdFnV9rNSF40NFSb/mC7TU6W9P2pqYZw4O6X9nx89FPsUKVy5Zk0oPjTnzja2CE
	 j8zI7LfbKJL0GiikRYKCKlGArzfqQhnKzWAcab4bLDfFSLiajTkI7Hc1ePyxAzfG+h
	 2J+mqjiI3fgSphgmWft6k46KLM666AovCEVi+NwBQC9jRIKlAGgE1aTdGYQiylbMe7
	 2cq8J8kxXVr0UzQQa3PkEJUvDn1u51KL6XA2qoDuRecvHG2QH68KeiI0YA+ufzhGNA
	 zQKGG44cskMxQ==
Message-ID: <6b69aa22-f392-4cc8-9f7e-d9077e951cc4@kernel.org>
Date: Mon, 2 Nov 2026 08:01:11 +0100
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
Subject: Re: [PATCH] fs/proc/task_mmu: check THP exclusivity for each subpage
To: Andrew Morton <akpm@linux-foundation.org>,
 Kelvin Zhang <zhangxp1998@gmail.com>
Cc: linux-mm@kvack.org, "Liam R . Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <4c1b393a4b04bd94e4f1c7879ae04e1793eb0931.1793552446.git.zhangxp1998@gmail.com>
 <20261101110247.95a03a5601f235ffb39c54c1@linux-foundation.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261101110247.95a03a5601f235ffb39c54c1@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/26 20:02, Andrew Morton wrote:
> On Sun,  1 Nov 2026 09:01:00 -0800 Kelvin Zhang <zhangxp1998@gmail.com> wrote:
> 
>> A PMD-mapped THP can contain subpages with different mapcounts. For
>> example, after fork(), the child can unmap only part of the THP. The
>> parent retains its PMD mapping, while the remaining child mappings
>> are PTE mappings.
>>
>> pagemap_pmd_range_thp() passes the same initial page to
>> __folio_page_mapped_exclusively() for every pagemap entry. With
>> CONFIG_PAGE_MAPCOUNT=y, this applies the first subpage's exclusivity
>> to all entries, falsely setting or clearing PM_MMAP_EXCLUSIVE for
>> subpages with different sharing.
>>
>> Pass page + idx to check the subpage corresponding to each entry, as
>> was done before converting to __folio_page_mapped_exclusively(). The
>> index already accounts for reads starting partway through the PMD.
>> The conservative whole-folio check without CONFIG_PAGE_MAPCOUNT is
>> unchanged.
> 
> Thanks.
> 
> I don't want to pick on you at all, but this is a classic changelog - I
> see this pattern so often.
> 
> 	a) here's what the code does
> 
> 	b) here's why that's wrong
> 
> 	c) here's how I fixed it.
> 
> But that's missing a very important bullet point:
> 
> 	a) here's what the code does
> 
> 	b) here's why that's wrong
> 
> 	c) here's how this affects users
> 
> 	d) here's how I fixed it.
> 
> see?  This omission is so common!  And I might have sent one or two
> emails asking people for the missing info.
> 
> For the missing c), how does this sound?
> 
> : With transparent huge pages, /proc/PID/pagemap can incorrectly
> : report shared pages as exclusive, or vice versa, after fork() and
> : partial unmapping.  This can mislead memory-analysis and
> : checkpoint/restore tools.  Actual mappings and copy-on-write behavior
> : are unaffected.
> 
> And now that we have our statement of userspace impact, busy non-mm
> downstream readers of this patch can easily see why your proposed
> cc:stable is justified.
> 
> 
> Also, it would be helpful to show brief before-and-after excerpts from
> /proc/PID/pagemap to help others understand the impact of the change. 
> But I don't think we need a v2 just for this.

See my reply. I'm not sure what to best do here, but I want to use this as an
opportunity to say "see, nobody noticed in 1.5 years; and it was found be code
analysis then, so let's simplify it".

So it's either straight to [1] or a "let's do i first the old way" followed by
[1]. I would just do [1] immediately.

Because nobody cares about that flag.


[1] https://lore.kernel.org/linux-mm/20260412-mapcount-v1-4-05e8dfab52e0@kernel.org/

-- 
Cheers,

David
