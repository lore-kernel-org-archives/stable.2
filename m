Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702570;
	b=ZERzHarSgumufXEDSyEd3Kfj1dFtLwjFs+Ty83HgO+vW/0pcf2ZK39fOWTdSFEwUHPyD
	 TxUG89O4nngzyiw7O0Lvu9zWEuEmuV+fhyHiDRFezii7P3f/hIifUqGRBs74b36vLzdvf
	 6dNBspNlxss4Fjq8jSG903cWxnTsNJNvbW6n7PK9PXShuujmQuce5CPH5NrLoSNmPuU7d
	 oba43NpxP62m3qILyxRo/Ke1CNCtwoMZjkAP0z7lI7rO92s0L/G4QSewnBhswhIu6yYJ9
	 bNfOMoDsSi37Hl7HNyt7FIiVdoZLVWEfIrnSeXfJos8xSKp+FIyJpUAvqC3EEmRS2jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702570;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=YnCo+84HPbdfaoZM7mfzyjHraX5NXelYJI4pMXrMFno=;
	b=Gk1ZyR/ZI39sedh+c0bmxg1vL4Cc6X0bi4rAoPVrH92XvPMn2VvM1gQdY3EUQ8ypPx/8
	 UsurvnzauURV3USDBSEWVZ0Og8L9DjW0X6W6t8pkTnBedsOXc2FQY2OKQnye3ojCHXy6F
	 m3vPp0EhFHFn8UcJqTd5gF/TUbFKqp9vcomQDYXJxoEEPweSoNYxcbzxLFErqWk6yI44X
	 0CgFOnwWCu8YrI4PE2RvdTzvx8S7KX6F2SoKInmV4okiIH/CTEf66OTRtRdndWj0SkYTo
	 1GlU34aymu5ziITFx1KUygO/O+JnP3Qu9MDlb7zZ8FXYccDhIThP2JFq9G2eokFq8hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mR7PlcQy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048C1606A31C;
	Thu, 26 Nov 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mR7PlcQy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF54F1F000D0;
	Thu, 26 Nov 2026 14:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702569;
	bh=YnCo+84HPbdfaoZM7mfzyjHraX5NXelYJI4pMXrMFno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mR7PlcQyhsbtlsHJdpoW6Zwy8CKjOZohbSPfFUS3bHKqDidmkM1zZPGMiYA3AVIkM
	 Q7fHBiVeD3WPWF9YM52DVa2I1jMO7+X1A32bvjKpTS76hjFOEOE/zifl0QzsXtiOKU
	 Sx5wDu6XboyQ9Z7qDhtForDfkaiFAOo4WgQxeBcbbzJ8Wr294VxGdSq5CPe0LxbJlV
	 8cah9IVQxrzDBCYB6JWkDIS68OUg0z1KwNkMsZMtJUjArFRPivbpvcKcOSr3KLBcCE
	 ty3fmaZsXtsJiQauG0IKe5BSDgT9jR6B8TFnJFRPlgMF330IStuvkRywkpioBAcsbU
	 +OkvQAnXkQwzQ==
Message-ID: <e60ef611-5e67-41b3-9c5a-ade4d183c492@kernel.org>
Date: Thu, 26 Nov 2026 15:15:57 +0100
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
Subject: Re: [PATCH v3 0/4] mm: fix races between huge and non-huge faults in
 PFN mappings
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
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
 Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 "T.J. Mercier" <tjmercier@google.com>, Eliav Farber <farbere@amazon.com>,
 "Gregory Price (Meta)" <gourry@gourry.net>
References: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
 <dc62bf2a-9188-4cc6-9850-14ab3a2e5274@kernel.org> <awg3r1kVqhQy7wlZ@gremlin>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <awg3r1kVqhQy7wlZ@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 15:01, Lorenzo Stoakes (ARM) wrote:
> On Thu, Nov 26, 2026 at 02:26:37PM +0100, David Hildenbrand (Arm) wrote:
>> Dropped v2, tried to apply v3, doesn't apply.
>>
>> Against which branch was it based? mm/hotfixes-stable?
> 
> mm-new. I can resend against mm-core for-next-fixes if that helps?
> 
> Only one patch is changed anyway - patch 3/4 'mm/memory: do not report OOM if
> insert_pfn() races a huge fault'.
> 
> Let me know if you want a resend!

Can you resent against mm-core/for-next? That would help a lot.

> 
>>
>> I this really urgent stuff or can this wait until the next merge window?
>>
>> I had v2 staged for the next merge window.
> 
> It's currently broken in linux-next so you probably want to fix _that_ next
> sooner rather than later to avoid further reports :)

I dropped the series from mm-core/for-next and pushed the branches.

If you're fast I can apply it there again even before I merge -next this evening ;)

> 
> As to the urgency stuff, as far as I + claude can tell nothing crazy here, so
> can wait for 7.5.

Ok, good, thanks.

> 
> OTOH I'm not sure how I feel about the triaging for hotfixes stuff, it feels
> like it makes it random what gets taken for that/not (if you sent a hotfix early
> more likely > late).
> 
> Also meanwhile Linus moans about that but then took a 41k line 'hotfix' PR
> from ext4 ;) https://lore.kernel.org/all/awW86EI5fYafQx-o@mit.edu/.

;)

-- 
Cheers,

David
