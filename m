Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873666;
	b=O6UWhVuvbf3yHiWpcwBFWWOoBakSZSvIQ1Z2CwjsKFBVeZWbuSXIZgiXEzur1r4rE+GA
	 Xu3BtNARvKrfo/AMEQIp8+lB+uyrlwBLgIt7QDe5321mtNnIoQPZlFNoR0LnwtDaAZnUm
	 fhdgNxSW2K3KvmMgQmDNZaZJvDHS+aKU8QOjQ2y7nY5tgK7RnKvjx3Hi64PgoILfDFb+u
	 814JqBs9XJek6GHVuUFnQVV040JjgXBTthN2JVi7puNkW3AbhPFb4h6nNGjwfYYK7Wvr3
	 tcINnCG/Pt451vdqkaFOPGaPHSPN9bUEKbqkTyIID5hhJedRroO5MgBLRSis3vQkl+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873666;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=cJgR5aeVC9lcVT/bd47FaWkr+JwpenNCqv7QqD2q5Bs=;
	b=DSNEKPPk6+yZxjG3Uvu5QbFtsrL0vZ3mbS/H/4mdI9PMZU5aTfx1DBKP+EPtq05SDQkq
	 UGNQ5Lfyzvp/YXRjC/TPZmbqNMiteiDRk5oOOENjkl6ipmAUH+rHMlfmMcyEcqj8cVJjK
	 +2aBppk+D30oct7/OlZ/MaaK/yiJg8llcM8zcyM/sOb/IanApj0vL6CdnXC1RPSGMC+FN
	 UtjoVB0jkdQfkbVPEIishBTzuUJzwAaWML16McIg/YV5L2uIRGJaNKlhLsBfiyEiI+z4O
	 grAiMkKneZrJfuGS623UA+favCDnfb/pcbcMWPK7VWJsSj+VwH7KZC0ZkAQ2BIs7Gug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Op6BjMZv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85084606AA41;
	Thu,  5 Nov 2026 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Op6BjMZv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1671F000C1;
	Thu,  5 Nov 2026 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793873666;
	bh=cJgR5aeVC9lcVT/bd47FaWkr+JwpenNCqv7QqD2q5Bs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Op6BjMZvEwsjuxoAUkC8Ls8ldus0yPgt/yQbWwZwQRMcFlVeybfv/RTgIihY90P0o
	 6hwtujh/xZC3KmXw8CKUVrH9CgBmz87hYk08c0RXE0JnYvLXt0neFtGpI3S1z9ihsG
	 tzfUumbxad+dX5WnRj5f9R1oN3EshlfEIH7griODZMkD0lhOWJTKO5QoQW3rbHExTi
	 7Y5Qe2uzFx4yjZmy+DYdTLx+ZWG1Hgk2KelHad79uAVveo8dALagy/j5GnNTUM+SKy
	 8J/nk4KICNKN3ZUxYzliP+GCsZaZ3nUW6vJ3vTG8JfWfH4DjMnnK3+i+QoLVHbSFz/
	 aWp+hd3ruMhdw==
Message-ID: <fc197480-ef57-4279-a48d-101f5f41f8d3@kernel.org>
Date: Thu, 5 Nov 2026 11:14:19 +0100
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
Subject: Re: [PATCH 0/2] mm/memfd: handle GUP references reliably when
 write-sealing
To: Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Rheinsberg <david@readahead.eu>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
References: <20261103-fixes_core_2-v1-0-f332954f1df4@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261103-fixes_core_2-v1-0-f332954f1df4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 19:31, David Hildenbrand (Arm) wrote:
> I spent way too much time on this, looking for better options. I think
> patch #1 fixes the most immediate issues but something like patch #2 is
> needed.
> 
> Long story short: someone can trigger a race such that we don't detect
> GUP references when write-sealing, allowing to modify content later.
> 
> Patch #1 handles pins reliably for folios with a pincount. Patch #2
> handles the remaining references, but can reject write-sealing with
> populated file mappings. vm.memfd_write_seal_mapped allows restoring the
> legacy behavior if needed.
> 
> All alternatives to patch #2 I tried ended up too complicated and nasty
> in corner cases. We should never have allowed write-sealing with
> existing file mappings.
> 
> Plenty of details in patch #2.
> 
> Did some testing on x86-64 without any surprises.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> David Hildenbrand (Arm) (2):
>       mm/memfd: handle GUP pins more reliably when write-sealing
>       mm/memfd: handle GUP references reliably when write-sealing
> 
>  Documentation/admin-guide/sysctl/vm.rst | 21 +++++++++++++++
>  mm/memfd.c                              | 45 ++++++++++++++++++++++++++++++++-
>  2 files changed, 65 insertions(+), 1 deletion(-)

I think patch #1 is uncontroversial. It would be good to get some options on #2.
With the current infrastructure we have, I don't really see a good way to tackle
this differently.

I'd assume CRIU+write-sealed-memfd+mlock is rather the corner case ... :)

-- 
Cheers,

David
