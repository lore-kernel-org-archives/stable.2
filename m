Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474915;
	b=TPZ01Ny0jeQxf3JTDJAIg6Q3SienClzwte9dmRoWI6+BBKso76sP0sF3C71ZhWZwbK67
	 eVGPDN3r5zYHg7PH26/UKCF9vZeXi+PFxAbe1bhog7DxljTvSUDRTK6U1royvOJ4qSB06
	 RykqOdnDPT1gY3UOzjevmcgkYEYHH8vz1a6+ODLxtNTL6231quGvdBJyUQ8Fx2LbCQchE
	 shyTO7rW4CVG+2wsTh8MDx0jxkNKOtXOVSQcnLQCYeKkYcxkXin/chu49I8FIUYWyA7Vp
	 lJoeJzQQ702J76bQTro7cCLWJJ/1KDa7znXkq417D1Dz86P2Uaiym8OLpEv9bvQjLvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474915;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=JBGlhgfSSYlipgOYHctRRtvyjsaynUhxyDWcaL7Szfg=;
	b=USMh7wbVrPKS+W7NO7Y+WTmZGcsgvBmPeUi9A5EPuu9OyLng1bhcqw0h0FG7QrKlOAw9
	 lCPmDcWcFFWhf1v5PFv/Oj+1HzIYq1Z/LMNJp4XR7IQP2VQ+fPDm8iUzz9tvvxPNfaKbm
	 dbcM01RLJGMhhpb5DjFSYBaXxYyF+jtcEQoKN0aAWNv6KPqEQ+hcFQzzZa25OJ0Vi0hTw
	 KR05BSPzRgxSGHWPTDsFQY8ja6d6FASTToAtj1HpQGm1l1zDKiT3AWWqqA9VHOiYFqbec
	 a7Sm9jAx3Oni80TPhDowuh8+bxsNx5cbibrYaoyGkm3BIiiBgc1YeSF7fFV+0DEGjUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="ImqsFj/3";
	arc=none smtp.remote-ip=115.124.30.100
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B829606A889;
	Thu, 12 Nov 2026 09:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B829606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ImqsFj/3
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794474910; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JBGlhgfSSYlipgOYHctRRtvyjsaynUhxyDWcaL7Szfg=;
	b=ImqsFj/32X6jvyzSeRmlkMWJUNDIa6EZV5+1YEFBQLTrClSY7T1tp9aw5TfXDIlkWM/DiTET8gafLdlKRBr7fbtO/r0QehffKyouuTR3Uoq0NPSYLEoeslk8vnxfRhmx0NfyW+Zp00tg3k8SVJqd6OKXlhrB1g4R4A2zqmfmQt4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XEbbjop_1794474907;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEbbjop_1794474907 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 17:15:08 +0800
Message-ID: <2cd723d4-742e-46b1-8a8a-47a4db1ff8d2@linux.alibaba.com>
Date: Thu, 12 Nov 2026 17:15:06 +0800
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
To: "David Hildenbrand (Arm)" <david@kernel.org>,
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
 <33b2549e-f033-42e5-82c4-a72cb0f92324@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <33b2549e-f033-42e5-82c4-a72cb0f92324@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/26 4:29 PM, David Hildenbrand (Arm) wrote:
> On 11/12/26 08:25, Baolin Wang wrote:
>>
>>
>> On 11/12/26 6:00 AM, David Hildenbrand (Arm) wrote:
>>> With a folded PMD, pmd_addr_end() simply returns the supplied end.
>>> folio_referenced_one() can therefore walk past the PTE table when
>>> checking references to a large folio.
>>>
>>> Folded PMDs are uncommon, but can occur even on arm64, for example
>>> with 64K pages and a 42-bit virtual address space.
>>>
>>> Use pte_table_clamped_end() to clamp the range to the PTE table and
>>> VMA boundaries.
>>>
>>> Fixes: 52e054f71840 ("mm: rmap: support batched checks of the references for
>>> large folios")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Chris Mason <mason@kernel.org>
>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>> ---
>>
>> LGTM.
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> BTW, the 'end' calculation for the batch operation in lru_gen_look_around()
>> could also use the pte_table_clamped_end() helper. But this can be a follow-up.
>>
>> end = min(addr | ~PMD_MASK, vma->vm_end - 1) + 1;
> 
> Cool, can you send a cleanup patch? I'd pick it up once these patches are upstream.
> 
> I'll move these into core.git today, so you can send against that for-next later
> today.

Sure.
