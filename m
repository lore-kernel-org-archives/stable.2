Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783492;
	b=fRZXoheOCRvhYj9b/t/d7vQOWskxL87xJ4z7PgZCrOeXpDYGnFFPEzUEDuf/HsOOFc5M
	 jCVAysWsF4zcZA8Aw1+cj8m3S4HRkbB5KIeA1lV4bRONPUnurfl9t4gVKiQ+QEz+5UCwm
	 Ny/5CXI3JbvU18NJjN2WHJ8q2D9R+5BK2klRsSslZhgPpA8mzxv54LfMxyCNliVo9njbh
	 TUmhKWECVMEoGdWOfZ+WEi142ANIqfgtbE1BWG1t+LU4qPYymu/GuSuu8M2uio1tY/npv
	 nt/yQhUS3m53VnkaBBC7m+ewkba6g72xnuqNOwqgZ4t+T13xNoZjGxyoBt+q7MPq8Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783492;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=+BWGMpp+CGdBx3er7fkKiPSgFKGZi9UN3j89ZX4ZK/I=;
	b=Joq1/chdARA1ty3rD8etgIYg6mYecRUhWn1aPZZxhAKiOkVuasJpM7CGZPkZUaKK01br
	 giD+tW2aCy85xf4Z8R3fXE584NifvFgZ6WJr31uMILCaW0WVjCrIBvIv+7sORyI/1qW39
	 5Afm9yffyLIH33Dd5DNUxS7QMEdOuEh6kx6LUOuMlJYwJ1ivxXnU623fpjeMShORDSYLq
	 yQe+mlcEIkMK7CfoKE1MUeayaN549OnF3zQIGXuX7CykaezNWLx/du1Gj3ZFGo9n+IjPg
	 hGov1DZuahEyz/6SJvxJeiYmyFqNogyAkcIaGL75izERgGcslgnBD1TRI1rdnVbV7sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPUGyJe8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFFC606A33D;
	Wed,  4 Nov 2026 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPUGyJe8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4141F00A16;
	Wed,  4 Nov 2026 09:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793783492;
	bh=+BWGMpp+CGdBx3er7fkKiPSgFKGZi9UN3j89ZX4ZK/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bPUGyJe8jTsIlbF1xVTN5nX4l/yeQqqr6KUSLqOk5CwA8zaane6up/uXHy/A6ETFN
	 8GMdYQkC/9pvmhBP2zcSqtRvRTHOksDMwvx7gtNR3V/dSa5XbcrFjusMb5bbHlPAqY
	 FtbHm8MMjkmKP//Sey/LKddohMLPyRf4C7s+5IntPmGQ+G5m0rp18ZxLjCBmoTbsqX
	 6+sBf9cofe3crMJ9E65oq/xyI3vlQ9WK8JdqiYXb7nE+wHWgrx4QfKgjh+C53e4xEw
	 hQtZGro3VXx5kNioH4KUnh6d9IwsWjAmh0kD1m7YN8VI3LyBQcu4wnCHz5d6QOS+Jm
	 8qsGDtkKaCKQw==
Message-ID: <45508a75-7549-40e2-a71a-807a824ea026@kernel.org>
Date: Wed, 4 Nov 2026 10:11:14 +0100
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
Subject: Re: [PATCH v3 43/47] mm/huge_memory: split huge PUDs when adjusting
 VMA boundaries
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org,
 kasong@tencent.com, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 baolin.wang@linux.alibaba.com, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org,
 peterz@infradead.org, jannh@google.com, pfalcato@suse.de, hughd@google.com,
 pasha.tatashin@soleen.com, pratyush@kernel.org, willy@infradead.org,
 jack@suse.cz, ziy@nvidia.com, riel@surriel.com, harry@kernel.org,
 apopple@nvidia.com, nico.pache@linux.dev, ryan.roberts@arm.com,
 dev.jain@arm.com, usama.arif@linux.dev, kas@kernel.org,
 matthew.brost@intel.com, jhubbard@nvidia.com, peterx@redhat.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 osalvador@suse.de, minchan@kernel.org, muchun.song@linux.dev,
 xu.xin@linux.dev, chengming.zhou@linux.dev, chrisl@kernel.org,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, youngjun.park@lge.com,
 gourry@gourry.net, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, jgg@ziepe.ca, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org, stable@vger.kernel.org, usama.anjum@arm.com
References: <20261031-fixes_core-v3-43-d6437171ecc3@kernel.org>
 <20261104031245.9524-1-lance.yang@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261104031245.9524-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 04:12, Lance Yang wrote:
> 
> On Sat, Oct 31, 2026 at 10:40:12AM +0100, David Hildenbrand (Arm) wrote:
>> PFN mappings such as VFIO PCI BAR mappings can use PUD leaves while
>> allowing VMA splits at page granularity. However, vma_adjust_trans_huge()
>> only handles PMDs.
>>
>> After faulting a writable PUD-sized VFIO BAR mapping, changing its first
>> page to read-only with mprotect() makes the PMD walk treat the PUD leaf
>> as a PMD table. Applying MADV_DONTFORK to the first PMD-sized chunk leaves
>> the PUD spanning two VMAs: the PMD-aligned boundary skips splitting.
>>
>> Walk the page tables once at each adjusted boundary and split a huge
>> PUD or PMD leaf as needed. Handle PUD leaves even when the boundary is
>> PMD-aligned.
>>
>> Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
>> Cc: stable@vger.kernel.org
>> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
> 
> Nice work!
> 
> Reviewed-by: Lance Yang <lance.yang@linux.dev>

Thanks for the review! Please do keep reviewing, but note that more trailers
(including this one) will likely not make it upstream as I am about to prepare
the PR to get most of these things here upstream.

-- 
Cheers,

David
