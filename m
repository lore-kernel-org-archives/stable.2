Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472183;
	b=v3OFupaoCEyL8aJoRfKTfL3uSq9RoKVOGiujn6bp+1N3vZuMjubvH2XTAGxELVZUDo2s
	 pylDeFlNrGDx/K7xQdB/wb4pIULnxve75KVjCBNvxJlh8073r+Iph+28PJ2Q8NcIvVnOP
	 o6gTdmjGsZw262vYl+3K5zCqXx0h3VeMjVkfWEiEUwD3Xi3Vi5bGZ6fyxuJYJ6kzzAHTo
	 pDyJSGWa3f0AGFR2Rn5tYcBd1LrPmpoE3skBNe3bHW1p5XrzfAnhWnaCU4nE5VBWuVy+q
	 h2Fi1mUMqFN8ppUZCT6MLhzfM7PyOzQvlUIL/x0k8iropzr0YVn8oNgBE3bJL3Yzlxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472183;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=LfFnO2mmUljHjiUSB+JHkBBNtfs+CR7s4DuaVxb5rYE=;
	b=P4dzZz/O+IFgMAmP+CHY49ethHLmPZtv5OIW+QUH4JJdMioX4hGkh31xodocVNMg/qSc
	 fc0lm/M55w1nTBxskz67UTIN2pB9QjwRfmq3qv5vLvmqqeW1hqzY2j0W48rDR/NqCY0Pp
	 exvh0oTWYUZzhUasNiYfP5phs6DQhDsLdJ2hpSy/TojeVTxyXqlNmLszCUXBBaRi8FDfN
	 v4rasu31eNqHLXFogoe8cQJU0GFwfhhv4EvvJPvM/W3lWaDjNfXSonr7rpkDkp4amomEU
	 fBW8Jh5onWONH/LepBuQPivAI0oq8WpjboR98TZoxmjgQ6oy6L7Kgb5MSVK+T2J6V8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nB63p4Uq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D343606A31C;
	Thu, 12 Nov 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nB63p4Uq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B3C1F00A05;
	Thu, 12 Nov 2026 08:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472182;
	bh=LfFnO2mmUljHjiUSB+JHkBBNtfs+CR7s4DuaVxb5rYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nB63p4UqxR5h4UfW+jPSLXJ9RSk5E++eyt78k0yGCrFFQubEByGzJJTsvvAIcFmms
	 OTd91A2zREUxuBnSe3GBaBsWFmJch5SNaIrRhdP/xzwh57B8zzy7AfoXpGmI76ENu6
	 oTY55ShnnxhYfEEtLsQZ2AzbAeWVeV+2Q3n8cu5/eNnbVZuJ1NSVreWqdCU2zfKDJH
	 IbBVHqVWbvANm1i2jExZM1aLhezYUoJ/ECUS+v4TESKabMov/y/rV5pRxdbV2GlYxe
	 czituN0+d4ncn6yOw5K51uDdaaGcC8gmRH9qbjHbi9ST1SQF6DLQ4j/0R8yJXvddbB
	 TSIE6DH6AEPnw==
Message-ID: <33b2549e-f033-42e5-82c4-a72cb0f92324@kernel.org>
Date: Thu, 12 Nov 2026 09:29:35 +0100
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
Subject: Re: [PATCH 3/3] mm/rmap: fix PTE table overruns during batched
 reference checks
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Lokesh Gidra <lokeshgidra@google.com>, Barry Song <baohua@kernel.org>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
References: <20261111-pte_table_clamped_end-v1-0-2dbe339c487a@kernel.org>
 <20261111-pte_table_clamped_end-v1-3-2dbe339c487a@kernel.org>
 <c31cc8a0-c098-4784-a843-f13f51914094@linux.alibaba.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <c31cc8a0-c098-4784-a843-f13f51914094@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/26 08:25, Baolin Wang wrote:
> 
> 
> On 11/12/26 6:00 AM, David Hildenbrand (Arm) wrote:
>> With a folded PMD, pmd_addr_end() simply returns the supplied end.
>> folio_referenced_one() can therefore walk past the PTE table when
>> checking references to a large folio.
>>
>> Folded PMDs are uncommon, but can occur even on arm64, for example
>> with 64K pages and a 42-bit virtual address space.
>>
>> Use pte_table_clamped_end() to clamp the range to the PTE table and
>> VMA boundaries.
>>
>> Fixes: 52e054f71840 ("mm: rmap: support batched checks of the references for
>> large folios")
>> Cc: stable@vger.kernel.org
>> Reported-by: Chris Mason <mason@kernel.org>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
> 
> LGTM.
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> BTW, the 'end' calculation for the batch operation in lru_gen_look_around()
> could also use the pte_table_clamped_end() helper. But this can be a follow-up.
> 
> end = min(addr | ~PMD_MASK, vma->vm_end - 1) + 1;

Cool, can you send a cleanup patch? I'd pick it up once these patches are upstream.

I'll move these into core.git today, so you can send against that for-next later
today.

-- 
Cheers,

David
