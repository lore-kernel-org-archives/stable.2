Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699608;
	b=sH9GBTvKo6z0Svw0e+59beHhliaFEFAuibiWXvDCJ9f2ahq4rJezX9fdcDe+0vHCCRQw
	 HPtsr/PC1B2mZJCrIEpCb+cfk0eo8NrMvW9mXnzZqKHIYJJKGdJJ4zsz2z41Nnjvd4IL9
	 rniN3Zoz7WqBdY9Y8kviePHdh7nGpK21POVufPybANYBMGC5Lo1YT807KdW7trdL0bFo/
	 PybfPYV6MgZZ6+KsTEAeT2xNackYV+GPcI8fEUwQeHQ6CRkFqiVgVYBTQO0aWSB/a0cVe
	 df6lDtnG5rV+8L087zWvodK/AkVjwLarawJ+VfFCGRryKfkloeOF5jmfpTA5XBhJcWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699608;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=44YcTNEv0pQgCbvisYqDB6TZpb73ujBffN6Vnl7ST18=;
	b=5IZj6c/1yfl52d48K6T+bo8r5ckFV0k9BG1i/R8M2RQhBpyQhZoGa9ZwJaJY/XyWh29J
	 NLsd6GUGjM8kFoQZ2k4l6TnlLWnhTLv1ih+Fh9hm0V072wNoKLKGjm/p+gdZ/wGAqKwjr
	 2QR4R8v+rPQTCHvnf47c+W2tkcaHICTiZsgoTBi1oVr2O9YvX41lZ7Dsuv4lBXjxvyWFq
	 KP+i+F1wrh9L+M3nBXewjNvO57GaS7iA785yodNajxCw13CiOAO2Au9UFkszlbdVy/aJ2
	 Qhndv2wtaG0i7ahO/bwE87UI3jqcpapi/JhBK4f7TINkHGQ/HXfhIsXJ9FiT8D47Vmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JKa/u5d3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843B606A31C;
	Thu, 26 Nov 2026 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKa/u5d3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372651F000C0;
	Thu, 26 Nov 2026 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699607;
	bh=44YcTNEv0pQgCbvisYqDB6TZpb73ujBffN6Vnl7ST18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JKa/u5d3QpYiV7XdwPVy7nnF+pPoRyyOucSSqu5763e+IdqOlCfDJh0HciBgZPD3t
	 jS8+BlBL4X+nwzTuCnCCLp6oOCHclFcP62Xpwa2CsI497QpWnlaZHrWM4MyoTFcrBu
	 sWfw+D9N9NPJ1HB4MGNauuvH6v6mLBiDjNldqbWWpNGbt277HkVowpwXir1cb+SJWF
	 hDUHFg/5coZTiClO382cj1NLD2w02la1n3czbRvGXtOWtlMuKCe8wESu55cpuXm8Os
	 k2x9ABH7fNAicFWDl/U0DXIOVaSqiNRqGfM0ebdPmx5535XGnm4D8KFBGcGZ+DCwfB
	 LgGWWrTCUWqcg==
Message-ID: <dc62bf2a-9188-4cc6-9850-14ab3a2e5274@kernel.org>
Date: Thu, 26 Nov 2026 14:26:37 +0100
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
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Michael Kelley <mhklinux@outlook.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 "T.J. Mercier" <tjmercier@google.com>, Eliav Farber <farbere@amazon.com>,
 "Gregory Price (Meta)" <gourry@gourry.net>
References: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 16:48, Lorenzo Stoakes (ARM) wrote:
> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
> 
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
> 
> A number of places in the code that implements huge PFN support fail to
> take this into account correctly, which this series aims to address.
> 
> Generally the shape of the issue is that faulting the same empty page table
> entry can result in the ->fault and ->huge_fault handlers racing and the
> loser finding something they didn't expect.
> 
> The fault code must tolerate this, but fails to in 3 places:
> 
> 1. walk_to_pmd() asserts, without the PMD lock, that the PMD entry is not
>    huge, so a VM_BUG_ON() triggers. [ vfio-pci, nvgrace-gpu ]
> 
> 2. insert_pfn() treats a failure to map the PTE table as an allocation
>    failure and reports OOM, causing kernel accesses to the range to
>    spuriously fail with -EFAULT. [ vfio-pci, nvgrace-gpu ]
> 
> 3. insert_pmd() and insert_pud() assume a populated entry is huge and
>    compare its PFN on write fault, warning when that of a page table does
>    not match. [ mshv_vtl, drm_gem_shmem, panthor ]
> 
> This was originally reported and fixed by Eliav Farber in [0], this series
> reworks patches 1-3 of that one.
> 
> Patch 4 of that series (x86 PAT encoding of huge PFN mappings) is dropped -
> it is unrelated to the above, no in-tree driver is affected by it, and it
> needs a different approach which is better pursued separately with the x86
> maintainers.
> 
> All three issues were reproduced on x86-64 under QEMU using vfio-pci in
> no-IOMMU mode on an ivshmem BAR, with 6 threads faulting the same address
> in each PMD or PUD aligned range of the mapping while another toggles
> PR_SET_THP_DISABLE (note that vfio-pci had to be modified to pass the write
> flag to reproduce the third issue).
> 
> Without this series the BUG is hit immediately, with only patches 1 and 2
> applied tens of thousands of -EFAULTs are observed within seconds, and with
> patches 1-3 (and the vfio-pci modification) both warnings fire immediately.
> 
> With the series applied 30 second runs at each of PMD and PUD size complete
> with none of the above, with or without the vfio-pci modification.
> 
> [0]: https://lore.kernel.org/all/20261112051440.16140-1-farbere@amazon.com/
> 

Dropped v2, tried to apply v3, doesn't apply.

Against which branch was it based? mm/hotfixes-stable?

I this really urgent stuff or can this wait until the next merge window?

I had v2 staged for the next merge window.

-- 
Cheers,

David
