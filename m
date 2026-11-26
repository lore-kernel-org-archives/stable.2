Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704163;
	b=W1DK3QIL4AnzWcquxf88AlLXosOOahxathcorrbPSwd1gVQ+/NNP7vWuEELZO/RbdpCv
	 FIE5u8M7W+N0H293INjuQ+TKzgLeZoe0HNnzhmbtp5j616FNR35xm0PFZZm2Dg5QpbG39
	 DA7Ya1uq5VCxn06mcb4619bLUySKalI7gqx2yJG3Lu4guxerUVBoC13prCUkSWYT8GiCm
	 5MTtOuaKn+ODNlUIvUPb1FNE+b/WCt6cPpg1nCclLGcWUFxXOvKhC4cptYxwMeynLr/Q5
	 +z9P43s91E8KjKj66cSZso7xFdvn4bMd5pRacjkENpfRrkgWghRWSdoVTfZ+tvePyAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704163;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=s9SXJJ3n4l71fdNJUMFik/3jjqPXo5ZSg4MfSGRKAYU=;
	b=mT72EYeJKkvIu8qW3wN9Ujo9tqx55f4x7ybFBa8wc7oT+50hIVhyajzY82vjrR+ZAZje
	 6uBMVBx9utYCfa9H/570QESEfVLEy+2ZRXqWkoEyswBUZlPkJn8qd9AUchT836CbT++YZ
	 4eiB9TxJSSMHk44Qvp/10A3/Z1FnCoexHoZfORq+fsSWYg6beExGxJVqp/vAblbPOplS1
	 RI/gLXA7Y3mBmVmFUcntubRp043tKCX4/x54X5h3uyRxUfTfCSbZKHQ9/JrV5q1wrbwVi
	 aqmwnkMfRr9hptkoj4FgVf27GBY0uBSwJl1mu+KIrFhmfR/qjCChTrG/IRYoKlThQ8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ismlXzL2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F1606A31E;
	Thu, 26 Nov 2026 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ismlXzL2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0FC1F000CF;
	Thu, 26 Nov 2026 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704162;
	bh=s9SXJJ3n4l71fdNJUMFik/3jjqPXo5ZSg4MfSGRKAYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ismlXzL2MQN40zx4eCBcrBBXt+d/BQHC+95H+VLAMxQ5pP+VeoftVgpV4UVKvsFrT
	 0Ut6jvmTISqzBtaWpHOddSFEXKhEtvDixoXMVrLc4nPn0w9eenG8DD5tfNwUiPz/aa
	 vquvt+2GGJ4o1Ht63bNze74e+sEB+zxkIfarGeeomocSg4+JJeXVSFfZ3zXr3KzTHH
	 eLNJUkJXDTRrkKhs1c2eT79PpVOj7o0p7So4rV47Q64nEaiH+Aa+dwWeXqQiyIOwO1
	 uN6RiSwnQ/cexnBHcXTuI4CdouWB6J7bhfE1bAvGkgtSW4KLfzb21hKSCCIbJay22f
	 NHSmjRBdr0KlQ==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
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
 Michael Kelley <mhklinux@outlook.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 "T.J. Mercier" <tjmercier@google.com>, Eliav Farber <farbere@amazon.com>, 
 "Gregory Price (Meta)" <gourry@gourry.net>
In-Reply-To: <20261126-huge-pfnmap-fault-races-v4-0-feecd58bb14f@kernel.org>
References: <20261126-huge-pfnmap-fault-races-v4-0-feecd58bb14f@kernel.org>
Subject: Re: [PATCH v4 0/4] mm: fix races between huge and non-huge faults
 in PFN mappings
Message-Id: <179570415481.24306.17551371198022216043.b4-ty@b4>
Date: Thu, 26 Nov 2026 15:42:34 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Thu, 26 Nov 2026 14:36:18 +0000, Lorenzo Stoakes (ARM) wrote:
> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
> 
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: core-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/4] mm: update walk_to_pmd() to explicitly return an error
      https://git.kernel.org/mm/core/c/0ad3f82c
[2/4] mm/memory: remove racy huge PMD assertion from walk_to_pmd()
      https://git.kernel.org/mm/core/c/71a45211
[3/4] mm/memory: do not report OOM if insert_pfn() races a huge fault
      https://git.kernel.org/mm/core/c/125a4415
[4/4] mm/huge_memory: only compare PFNs of huge entries on huge fault insert
      https://git.kernel.org/mm/core/c/36363864

-- 
Cheers,

David

