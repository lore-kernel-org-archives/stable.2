Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171259;
	b=viCSuTkdhkf2mhSFVlUtgZOqdaUqU+XABahpCUo8xuA2xfADFszFsIMafWL3ENLNkp6+
	 DclQa0T0vNRY6Sx6qj2+w5t7+ISuwkNm3NyaHKZayR69Jkavr+r5JLfEzz+hRzWJuw4Q5
	 J6q+v77KhCmUMaAn3Yuc90SU4H60plUsI8/Mfz0xRDujawXImHclZBhkrtjBdBuiuFUFk
	 dr6J6lX1I7lBVshuHhFpG7h4GqeEzXfgbvPOvKTnvzhLMma0S51nA9mjVMdz8KLaUAW7z
	 YUaWnU7NG/wghv0cmI9ubHjbeSIW4fA+CNReodCJgL2U3iI2ZRiTLiUwFTu/040Tllg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171259;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wuF3voKG3KiMsxJLfQZCJijkDisSiEB0JzslwfKJP50=;
	b=EaLv22btgObUPMIlu2Al6HzbpacdrqTkZJFobNkhSMgnfZJNfQXVkkgazikLpIgE/Zxl
	 yNzLPKRPSklKpPS0KdG74tl3L3vena5LKNyk32WoEOv3tvGVmvStO9b+eB5j/FzxqUPIh
	 ZFOoaWVHOWjN4TjtWSdWJ+NMcpiFWpthwX2+LsmTzB6U6g0rDSfqi/9Keomgc+t1Qcl4a
	 wKDIyDBPxVMQq+FqiefXiieuFTETw45vcTZ2qdZlgJIA9tOj9Z9IksXTNghOxAC24Ae2C
	 YQBvWiEfS+42c3RBY+xhIYpkoYaKxGzW2khwkoUi5wvj5vwo0gjnjC4yl37IxFwp4rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjyawddn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D150606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjyawddn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6403D1F000EB;
	Fri, 20 Nov 2026 10:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795171258;
	bh=wuF3voKG3KiMsxJLfQZCJijkDisSiEB0JzslwfKJP50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bjyawddnWiPtZYcrrH/VNFTmoOnGihjVjMZtQYVGsg4PsDddn4HQL26RBf+uD2Dqz
	 OlWv5iNZz9ivXgBWpweKGQs1X6mIoUbkMcFyqcluFNFtSngw57ZU9M+WnO4jtB3JBT
	 kmlPWaR0mW3D8f26oCjtZjBznicmVSatGMNRpvi1KfPeG+e5HTFBGIykhoDwKky4yZ
	 kp5c2N0sxSR/+LJW/SrJHOxNW6dw8TNaJm5RqaY0hHjHg60wu8NjDAYmvnrSIkCcxI
	 mBcKJzgukxs0OE1NxKslLElUXvL+JqI02fq1fnwPeuw7W+dblIWzqzDmS+uJxDRs7a
	 rbZXtkS1Og7XA==
Message-ID: <a9fda4ff-1758-4ee5-ae43-9a951eaf44e1@kernel.org>
Date: Fri, 20 Nov 2026 11:40:53 +0100
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
Subject: Re: [PATCH 0/3] alloc_tag: two fixes and one cleanup
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Usama Arif <usamaarif642@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, stable@vger.kernel.org, Chris Mason <mason@kernel.org>
References: <20261119-alloc_tag-v1-0-efcccfd3a9c9@kernel.org>
 <1f12c78f-782d-4d03-ac3b-7321520f02ed@kernel.org>
 <a0a5c3e0-ef9f-49ab-9f2a-d1a2e1e1934f@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <a0a5c3e0-ef9f-49ab-9f2a-d1a2e1e1934f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 11:08, David Hildenbrand (Arm) wrote:
> On 11/20/26 11:02, Vlastimil Babka (SUSE) wrote:
>> On 11/19/26 09:52, David Hildenbrand (Arm) wrote:
>>> Hi,
>>>
>>> two fixes (one for alloc_tag as triggered by slab, one for mempool) and
>>> one related cleanup to make things consistent.
>>>
>>> Quickly reproduced and tested the warnings in a x86-64 VM.
>>>
>>> This should go through Andrew's tree. No need to rush, it can wait until
>>> the next merge window.
>> 
>> mempool is part of slab section and the first fix while in page_alloc.c is
>> also for slab, so we'll take it :)
> 
> Thanks! :)

Actually, let's separate to minimize conflict potential

patch 1 merged to: page_alloc/for-7.5/misc
patches 2+3 merged to: slab/for-7.5/misc

Thanks!
