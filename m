Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794004951;
	b=AJndQ1AVg2+rQuHphZd3o6EN9i70ZXNV1Oh7gN6003gODNVlVhpcji8hMNXl6np0LgKI
	 lXbYP0b+mr9QqUr7WcUDCEykxg5ou0gZw90sev8nQQxxGcHEhcuUrzK1OP7ED4yLgwcWw
	 qh+C+Z1s+BSmhMUYwQbOD8wLhZMBM6Y1H0orEPP6IB1DxOZCxflw4CW/EMrD3ur6wS0Nh
	 Hk2idKvRyDvFD2IaSYPp3h54ZfMJJ6AKMLoc8+IWBL5eks6K2fCz75V4KDiwr973xLr/6
	 8k5Cec1Bra7kagW2s+YUwIANMWl7VRN4HVJeM/tgETMAMthrLngAnI9a/bGBxcZ8z5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794004951;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=r9kJmn9kMaUsIxseYi41rabItJ7bLsBpd/nnhZbIok0=;
	b=wl+naWoc/ZGoVulWdQX5fNPE3GMrIrP++lekwLltWKsbpISdt8+TST68jM5KEDW34y35
	 kEwj35rVcvMoAVuv86AdCc50p4qw0oLh6nA/ZW83BhhGbXbzn4GmL7pP//bau/4UnTNVx
	 VYfYfQ+L2xiD35IXKh94fYQstdqvhm3zC+zCkx4hDgkfpo+yoaH170/TMVV3vLXbtgTO/
	 sDpO3A6TiyOhodyb7EVqf3Px5N85qn9CZWxNiVqcBqEGY68yG5Zc9jQGlZ0UyJ11V47ST
	 cqgFvdDvqjtx8f8ziqzChSYbAlSnqnIV8eCgntWSZfNnROowXcTV0PO0fnK3nr7UecA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcQjhvE3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B42606A326;
	Fri,  6 Nov 2026 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcQjhvE3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461341F0089F;
	Fri,  6 Nov 2026 22:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794004950;
	bh=r9kJmn9kMaUsIxseYi41rabItJ7bLsBpd/nnhZbIok0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CcQjhvE3LihkZTfRpe4GaGxaNniXCyBTPnv6vcJX3sBVZApH/MsbvbydsSZ81zFxR
	 NSKD4z99+2BdoVaotgWuzYmPU8/Er/qPZuRp+cR9arHo9nWwaJZsFTQfzKjEiuudWe
	 GfkE+8H9wzKx47fQqMgmGvK5vqVukLysoqIE04NdjiWlapD5RSVtbBjw220dY6v/XR
	 2S0LJ0WX1+Re7Cb9Gp4E1HSpQnf+y3V6McY5i1ZNbYXDBfYl2js6+Ip5zOiSar4N8O
	 X7W9UXU9bMPkJA1+c2nsq9IZoYHe8ZCDYLfGNeNFjembLaMhHYk4LCktt1+0S25TrV
	 d13VE0RJJZy0Q==
Message-ID: <20e54cbc-dd5b-4094-856f-2e63f8e19001@kernel.org>
Date: Fri, 6 Nov 2026 22:23:26 +0100
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
Subject: Re: [PATCH 1/5] mm: limit pagecache folio refcount when mapping pages
To: Lance Yang <lance.yang@linux.dev>, azpijr@gmail.com
Cc: akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 willy@infradead.org, jack@suse.cz, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, nico.pache@linux.dev, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 peterx@redhat.com, hannes@cmpxchg.org, songliubraving@fb.com,
 riel@surriel.com, hughd@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 jgg@ziepe.ca, kevin.tian@intel.com, joro@8bytes.org, robin.murphy@arm.com,
 steven.sistare@oracle.com, jhubbard@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, mason@kernel.org,
 stable@vger.kernel.org
References: <528e3a0e-04fb-427f-88c7-63a7f4bbc505@gmail.com>
 <20261106100645.77296-1-lance.yang@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261106100645.77296-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 11:06, Lance Yang wrote:
> 
> On Fri, Nov 06, 2026 at 10:42:17AM +0100, Jose A. Perez de Azpillaga wrote:
>> On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
>>> With large file folios, overflowing the folio mapcount and refcount
>>> became possible. For anon folios it is currently not really an issue:
>>> each large anon folio can only be mapped once into a process.
>>>
>>> That's not really big news, but it's about time that we do something
>>> about it because some modern technology might find ways to abuse it :)
>>>
>>> One of the enablers for that was commit ddc58f27f9ee ("mm: drop tail page
>>> refcounting"), however, file thp support was added later.
>>>
>>> File folios can be mapped multiple times into the same process, allowing
>>> for processes to hold many references to the same folio.
>>>
>>> As a short-term solution, let's introduce two folio refcount limits:
>>> one for ordinary consumers and one for admins. Leave some headroom
>>> before the refcount goes negative, which we really don't want (having
>>> the mapcount go negative is also not expected).
>>>
>>> Start reporting SIGBUS if we run into limits. When restoring mappings
>>> from migration entries, instead zap the pte/pmd entry. We allow for
>>> slightly exceeding the limit to keep things simpler.
>>>
>>> This is far from ideal, but better than all easy alternatives we can
>>> backport comfortably. For now it fixes the big problem: letting
>>> the refcount (+mapcount) go negative and cause trouble.
>>>
>>> This is only a temporary fix, we'll follow up with something better.
>>>
>>> While the refcount checks are not required for order 0 folios, let's
>>> just add them for consistency: each folio_add_file_rmap*() and
>>> folio_dup_file_rmap*() needs a prior check.
>> in mm-new copy_huge_pmd() now does a folio_dup_file_rmap_pmd() at fork,
>> since Konstantin's "mm/huge_memory: copy file THPs at fork like
>> copy_present_ptes() does". doesn't that one need the check too?
> 
> Ah, good catch! My local tree didn't have Konstantin's series [1] yet. And
> right, that path needs a check too I guess :)

So, likely my series will go in first, it fixes a way older problem. I'll tell
Andrew to hold that one off and let me handle it.

-- 
Cheers,

David
