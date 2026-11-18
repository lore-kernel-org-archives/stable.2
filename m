Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012288;
	b=yAZ3p/bqqe6MCR+7dQHsUjOJ9034v7A0sLCoNc53kSXjcF2tNH9BT7JkmBAfDxHyyqHi
	 UnricghSqNNTukyQ8m7FNHoRafU+D7ZwWVQnurCKb6X2UI+q5EIDXbqHr9izNy7+RciBo
	 1klKWwnB1dQB1NR/MraOcQvEPKvjMOGbmnH9jSi8+wUJsswFgvKwMbScjcuFNzB0FVnR5
	 YyB/bCpChlJAclagWQUUj7tJ0mUX86KtQuxvyvt/73bOxw72mQUeDAiGNnLhtSouRHbYb
	 J2zl+8taEx3bKQ7HQMilKNro+putXEUatJ5cBxH8Swnv5aUNn7wHDgMWVff4KYEpE0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012288;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y3zZObu6o92GT6lamZ/7p0SEfuKu0JfAlZFdmlt2sKA=;
	b=eQQw/jM41LaUXA7JNfARtBGj8Og3j0OKAsBQ4Soff+B0H4IKa1Niv4exQGWAOsvvo3l9
	 Hd0aVYtVCxdOa4KdyhfgtYxJjSBSVedF56SU2N8mdMwVzZrxYZIbGy1BB31noii6KdpnZ
	 MjIBhvOZIZcHcw8BLF99hazVDVwYoWMYXcxI3L/3G/y6aUEafnUMXXzdmPygHXT10ZjT/
	 ywR9PjEIE/pxKxBgYjx1YSgQmSDhq15GgUhDMBfALpKNyFc39sHia5nwXx7OMB2jMg9o7
	 7IjpUZIXHS5b7LS49IA1XljOo/tn/puvgPTQcl1pd7r5B2EsA+kJBSHNKSY0DMHZytQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UeFU53aC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB8F606A31C;
	Wed, 18 Nov 2026 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UeFU53aC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB7F1F000C4;
	Wed, 18 Nov 2026 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012288;
	bh=y3zZObu6o92GT6lamZ/7p0SEfuKu0JfAlZFdmlt2sKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UeFU53aCnNhyEdyIq6jrkxoaaJProjQHDJST+jpds+OI82fNA8OLU0giXgssuSVH4
	 o1bRt91wqx+adkh6d3OvmeEyv1qwGDImL8MPa4WxCXCX1zfy77AGOY8zgnDBqWDmun
	 CZISpz9AiTZ308Xa4COSNYLn2yUxRL9hBv+8aRlyBa5xISFhlVD4oBTL9UQ1v2hVzo
	 EnzxgWHVEAx26oqN81zmpyj1BKk78HRd4U4gVzV0SiZuFQd3VrF55tpLao9RV7BXV9
	 BoymtEkUC7lpNuf47TXCJqdaf1TCXUA9HL7SEQD2jvdkoA51zPtn3b2Djx47jDtNlW
	 KfRgNrhOXqi3g==
Date: Wed, 18 Nov 2026 16:31:15 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	James Houghton <jthoughton@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Andrei Vagin <avagin@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/9] userfaultfd: use anonymous memory for
 UFFDIO_ZEROPAGE on private file mappings
Message-ID: <av22s6nXWhWxog8l@kernel.org>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <20261117-uffd-state-fixes-v3-1-b617009d1a4a@columbia.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-uffd-state-fixes-v3-1-b617009d1a4a@columbia.edu>

On Tue, Nov 17, 2026 at 11:28:41PM -0500, Tal Zussman wrote:
> If the mm cannot map the shared zero page, UFFDIO_ZEROPAGE falls back to
> mfill_atomic_pte_zeroed_folio(), which allocates a zeroed folio and
> installs it through vma_uffd_ops(), no matter what kind of mapping it
> is. An s390 KVM guest with storage keys or protected virtualization is
> such an mm.
> 
> For a MAP_PRIVATE shmem mapping, that adds the zeroed folio to the page
> cache of the file. That is wrong: a private mapping must never modify
> the file it maps, and the file might even be mapped from a read-only fd.
> 
> The ioctl can also fail where it should succeed. A missing fault is only
> delivered for a hole in the file, but UFFDIO_ZEROPAGE can be called on
> an address that did not fault, or can race with a write to the file. If
> the file has a page at that offset by then, inserting the zeroed folio
> fails and the ioctl returns -EEXIST although nothing is mapped at the
> destination address.
> 
> What we want is what UFFDIO_ZEROPAGE does on a private mapping when the
> shared zero page can be used, and what UFFDIO_COPY does: only check that
> nothing is mapped at the destination address, map zeroed memory there,
> and leave the page cache alone. The zeroed folio path did that before it
> was moved to vm_uffd_ops.
> 
> To fix it, pick the ops in the common folio path, as
> mfill_atomic_pte_copy() did for UFFDIO_COPY: anon_uffd_ops for a private
> mapping, the ops of the VMA otherwise. That makes
> mfill_atomic_pte_copy() and mfill_atomic_pte_zeroed_folio() redundant,
> so remove them and rename __mfill_atomic_pte() to
> mfill_atomic_pte_folio().
> 
> While at it, use vma_is_cow_mapping() to check for a private mapping.
> 
> UFFDIO_ZEROPAGE no longer modifies the file, and only fails with -EEXIST
> if something is already mapped at the destination address.
> 
> Fixes: f74991b4e383 ("shmem, userfaultfd: implement shmem uffd operations using vm_uffd_ops")
> Cc: stable@vger.kernel.org
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/userfaultfd.c | 46 ++++++++++++++++------------------------------
>  1 file changed, 16 insertions(+), 30 deletions(-)

-- 
Sincerely yours,
Mike.
