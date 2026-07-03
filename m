Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D125228D
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047220; cv=none; b=ms0qZLq0mlDcTE+ByExid5/k+amUEjDKunU4s9UIc9POJIfrqmbIqog22irlN5D53AR7Sk750KtKmxOPwSG3TQ1CRYHEg3GRJN6w5h/0DLEo0b3ufcBZRo+fX0Z072TIZdAyu3fxlcNIAK2APi7sj+1o+pKrkMyEQj5r7XdieeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047220; c=relaxed/simple;
	bh=nP5hD1SwsOP3aNiLxhpn5TxWp22qeFxDQPceHF0SoVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQcUw2H5+XkOeKROH6vRl1ee23h2mfzHT7KHt/f4Hwbo25JAVHPrxl0utHkOe+XRXs+dGGEcCIEi/W0y9ahmOVyRf4IZdctkLxjMJlFPLVBHk2vfRpjyN8fwKwRj+PLLXI6cNwAAcrHbShYJKub65BNpXYkcxkriwC6aFXk/n3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DBXgN7QK; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DBXgN7QK"
Message-ID: <d38263c7-b1ea-4709-8d75-2f2355ca38a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783047216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvxaaOeMrCU2lWQVKAZ3wsLKjHq/cc0kdYy6Bt76nnw=;
	b=DBXgN7QKlULmpihfVgbSTPhw1UekcupRyz0tFrKWObdxrsUClw4DMFYnLpf1Rycp9oYv5X
	XQeZtwGX58b65D62s/ZV8rZBsurIxExQ5tp1eVpN19KW86iJsFQdbjWJgseF2UWX4B4Ao3
	OyqU3/6bA7dIEONEN6KlUnG4t3gT5J8=
Date: Fri, 3 Jul 2026 10:53:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when
 collapsing
To: Zi Yan <ziy@nvidia.com>, Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Song Liu <song@kernel.org>,
 Eric Hagberg <ehagberg@janestreet.com>,
 Gregg Leventhal <gleventhal@janestreet.com>
References: <20260702165409.164568-1-pfalcato@suse.de>
 <2DA84662-F9E4-4ED3-A225-71054FEC3849@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <2DA84662-F9E4-4ED3-A225-71054FEC3849@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/7/3 01:24, Zi Yan wrote:
> On 2 Jul 2026, at 12:54, Pedro Falcato wrote:
> 
>> As-is, khugepaged and writable-file opening exclude each other. A file
>> cannot be open writeable and have THPs (because the filesystem is not aware
>> of them). khugepaged will never collapse file pages for files that are
>> opened writeable. On an open(O_RDWR/O_WRONLY), the page cache for that
>> particular file is dropped. This is fine because nothing could've been
>> dirtied.
>>
>> However, there is an edge-case: collapse_file() might not be able to
>> coexist with concurrent writers, but it can coexist with dirty folios
>> (from previous writers). Therefore, the following can happen:
>>
>> open(file, O_RDWR)
>> write(file)
>> close(file)
>> madvise(file_mapping, MADV_COLLAPSE, some non-dirty range)
>> open(file, O_RDWR)
>>   nr_thps > 0
>>    truncate_inode_pages()
>>      /* THPs are cleared out, but so are the dirty folios */
>>
>> When this edge-case happens, there is data loss, as the dirty folios are
>> fully discarded.
>>
>> Fix it by fully writing back the page cache (and waiting) when collapsing
>> file THPs. Doing so provides the guarantee that no dirty folio will be
>> observed while there are active THPs. To fully ensure this is safe, the
>> invalidate_lock needs to be held while doing the writeout, so that
>> do_dentry_open()'s page cache truncation excludes this write-and-wait.
>>
>> Cc: stable@vger.kernel.org
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Song Liu <song@kernel.org>
>> Cc: Eric Hagberg <ehagberg@janestreet.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>> Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
>> Closes: https://lore.kernel.org/linux-mm/CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
>> Tested-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>> ---
>> This patch is written against 7.1.0 (because the code no longer exists in mainline).
>>
>> Zi, I kept your Tested-by, but I had to move some things around and
>> use the invalidate lock. Please re-test if you can.
> 
> Tested it again on top of v6.12 (the patch applied cleanly) and the issue
> is gone. My Tested-by still holds. :)

Since READ_ONLY_THP_FOR_FS is gone from mainline, just to confirm: does this
only affect stable kernels, right?
