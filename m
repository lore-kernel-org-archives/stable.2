Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4023B38A4;
	Fri,  3 Jul 2026 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070467; cv=none; b=fMlCaFiRUryPBcuaAZ/Z1TOWXbwXLpJe/s6C/LhVPuxEw1JnJmFjwQ1a8x3bufv7VWshWJuCCl67+Y4fvAlwdCzjSX9AjMz8cF5tE8BW3AhcYA7mgWgd1KHSd3yj35RaRUsEtHKc40xPzoMdAlp5ZrebGiq2C9jcya7uKrSS9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070467; c=relaxed/simple;
	bh=gzKi9PH1R+HQcTu5RKXmQhc5+Eb57u8CioYtKB7ccfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQbvVLDg3z2HuYL2nmd1yLd+aV1wch2cHcyZ1mbOdrTcL5hFb6j+6XHmsdJ+bTG2tFK5B/0grmrJCoCwb+XEa3E/rGYNugZb6Om1Jz84reb+YAUELFcmBtI6jOrsKuAC5F1qBQUW/UidoroSeB+kREgsGBXRoIv9k4Fu1Pox5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=er20X6E4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="er20X6E4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97931F000E9;
	Fri,  3 Jul 2026 09:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783070463;
	bh=LRHs68uZvA9um2gm65aY4M4ReG5L7r5Gco47C8yFhfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=er20X6E4CCctj3eE7ZkCYz1M034Z/dOeLXhhW4SXSHRXrNAdk8ORvRd78IdzAbnlx
	 1XwS/Sj4Qy41VCSnWZTXn/Ueyhi9Hkl3GhMZyM02Pf2XRW4AoSTrJv/HwmO3VIFhpy
	 H3E9Rxi9sFJ0olWtSmlvlQkcSPXm/DiXePmcUSydvdHxi2IOPNM2VvUO+xmofYmgaG
	 KOBXjNOGM7D4+q538hTKSTBVko3mqvABUa1ZQvMRGWR03r2nnoKNTz6I+m27A6wdZN
	 J7hUAsQXmzayViW3Mv1ZEg2RwRb/9a6JbeIudqEvgrciOYFi/iOHW6gWmPUAqtm8Ly
	 2Ksvsni8s0uIw==
Message-ID: <474e7222-7589-4e8b-8a3c-f85ec2335f19@kernel.org>
Date: Fri, 3 Jul 2026 11:20:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when
 collapsing
To: Lance Yang <lance.yang@linux.dev>
Cc: pfalcato@suse.de, akpm@linux-foundation.org, ljs@kernel.org,
 baolin.wang@linux.alibaba.com, liam@infradead.org, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 willy@infradead.org, song@kernel.org, ehagberg@janestreet.com,
 ziy@nvidia.com, gleventhal@janestreet.com
References: <e924bed9-4c46-4fe3-b6cd-7c77fd9e25c8@kernel.org>
 <20260703090232.26261-1-lance.yang@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260703090232.26261-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/26 11:02, Lance Yang wrote:
> 
> On Fri, Jul 03, 2026 at 10:55:42AM +0200, David Hildenbrand (Arm) wrote:
>> On 7/2/26 18:54, Pedro Falcato wrote:
>>> As-is, khugepaged and writable-file opening exclude each other. A file
>>> cannot be open writeable and have THPs (because the filesystem is not aware
>>> of them). khugepaged will never collapse file pages for files that are
>>> opened writeable. On an open(O_RDWR/O_WRONLY), the page cache for that
>>> particular file is dropped. This is fine because nothing could've been
>>> dirtied.
>>>
>>> However, there is an edge-case: collapse_file() might not be able to
>>> coexist with concurrent writers, but it can coexist with dirty folios
>>> (from previous writers). Therefore, the following can happen:
>>>
>>> open(file, O_RDWR)
>>> write(file)
>>> close(file)
>>
>> Okay, folios are dirty.
>>
>>> madvise(file_mapping, MADV_COLLAPSE, some non-dirty range)
>>
>> collapse_file() has
>>
>> 	if (!is_shmem && (folio_test_dirty(folio) ||
>> 			  folio_test_writeback(folio))) {
>> 		...
>> 		result = SCAN_PAGE_DIRTY_OR_WRITEBACK;
>> 		goto out_unlock;
>> 	}
>>
>> Making us abort collapse.
>>
>> What am I missing?
> 
> Hmm ... dirty folios can be outside the range being collapsed ...
> 
> For example:
> 
>   write/dirty:      [6M, 8M)
>   MADV_COLLAPSE:    [0M, 2M)
> 
> collapse_file() only checks the folios in the collapse range, so the
> dirty/writeback check passes for [0M, 2M). But after that, for the old
> READ_ONLY_THP_FOR_FS case, nr_thps gets bumped for the mapping.

Ahh, so it's unrelated folios, thanks for clarifying that.

("some non-dirty range" documents that)

All makes sense to me, thanks!

-- 
Cheers,

David
