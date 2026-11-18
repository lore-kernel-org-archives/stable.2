Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012435;
	b=JQ0kORTjginTLYSxK1wXz+ym/HsU+PgJNeHP5B0JDAlIXMmKp/zE73RxB9BNQTzvN/WZ
	 QhlkGVmai5t8XoQt4mydQ52gIDf3cLgFq+nV7jaAU57Q+6hZNX7WJwe9c/iw9DcaBYL6W
	 2+2woOrfslbAAJxt2+NMtRZnV4PjPbOD9geCNF4GNBiMD47tTlFC5x0A2m/O03KstTDpC
	 lPRXE9AVFoLNWgBnEwdQKW9m0rcNTiyRvrIZE+CFSIdzD/MDCpR8wUTBs1dGG8LlU6etQ
	 bK6mx8dczi3IXULCGYd818mci717o7BWKgInb7CVQhYoTfEPcG92dSgjg7e5A+KhK0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012435;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r0M7bUtZEofsoW8E6XLzL0ND8blGJ4WCG6thjd+0hTw=;
	b=ESHZhkFOEBVEWho2o+4M9AJyhAT76DcMv07dGDRlQMyRRI2dCQyYQkT32Wm4kJ0xEU/K
	 AvDA4UUo4p782Y4Ypt3+nzYFjOSVE76OgkN9VYUYF1JO02v1dBkImZVw5LDEU7+2VOhBW
	 nX9XNreAwSxkzWj0KluUVeslfXoS5a11mWU8VOtnv+jUZ7c6HDe0GCslAXSXc3Laocw0G
	 4Sxt29tJuqXGMiiMwLqQncyOWo2TB+C8W7yOXqn0vIHPgLXbM69a2XsIGnOVjdDOdfm/4
	 chdnsAlJ55/0zdN8o+H/rDiiR6+iiSE1QZtktR7aNbFi9VSPl+IuCOVTiJtEIuXNmFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kp9aWV9V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B2606A31C;
	Wed, 18 Nov 2026 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kp9aWV9V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D43D1F000C4;
	Wed, 18 Nov 2026 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012434;
	bh=r0M7bUtZEofsoW8E6XLzL0ND8blGJ4WCG6thjd+0hTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kp9aWV9VMOCglS7T1p8dI1UFHOj3QgFUQWE27OP4HKp8U3+jjxoxZ5MiJj4la/XvM
	 5g271rkeXZHxD1RQZeYy9sJtGReqx/Wu2njRPkXusfpMZXxCGIR5ZzMv8YoTGpm6hg
	 Z6tgqCBkZgIcFlZSz6035WSZxIeGPy+JrC1PJGNpvJDd48S1qhJk/hFuZsiCPChbpz
	 cbipzUh3C8OOrW/AvXUuXYqzav1/ZSNl5r9u80mpnTju6Ee+vMAghVK8OCjuuDA05S
	 HY68vn5JPr7XXFHUq32yMMFYFnOyzSscbzp0r5NSgcm81ZAyPEr+jLZrZyeSuycfOU
	 fAGNDFU01uI8Q==
Date: Wed, 18 Nov 2026 16:33:41 +0200
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
Subject: Re: [PATCH v3 2/9] userfaultfd: refuse UFFDIO_MOVE into a
 non-present huge destination PMD
Message-ID: <av23RfHuKjWeeEnN@kernel.org>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <20261117-uffd-state-fixes-v3-2-b617009d1a4a@columbia.edu>
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
In-Reply-To: <20261117-uffd-state-fixes-v3-2-b617009d1a4a@columbia.edu>

On Tue, Nov 17, 2026 at 11:28:42PM -0500, Tal Zussman wrote:
> move_pages() refuses to move into a destination PMD that already maps a
> THP, but checks for that with pmd_trans_huge(), which is only true for a
> present THP. A device-private THP or a THP under migration is a PMD
> softleaf entry and is not refused.
> 
> The destination PMD is then treated as if it pointed to a PTE table. It
> is not empty, so pte_alloc() leaves it alone, and move_pages_ptes()
> fails to map a PTE table from it and returns -EAGAIN. move_pages()
> retries on -EAGAIN, with both VMA read locks held. If the source is a
> THP, it is split first for nothing.
> 
> For a THP under migration, the loop ends once the migration finishes.
> A device-private THP can remain in device memory indefinitely, so the
> caller of UFFDIO_MOVE hangs until it receives a fatal signal, and
> anything in the mm that needs to write-lock one of the VMAs blocks along
> with it. This requires a driver that migrates THPs to device memory.
> 
> To fix it, check the destination with pmd_is_huge(), which is true for
> a present THP and for a PMD softleaf entry. UFFDIO_MOVE now fails with
> -EEXIST in these cases, as it already does for a present THP.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/userfaultfd.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

-- 
Sincerely yours,
Mike.
