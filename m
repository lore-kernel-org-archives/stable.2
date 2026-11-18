Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015189;
	b=kRBRY88PtwC2J7z2jnNLz+T3KQtPUhrEV9LiK3uRTszeibv41F+brXlhO7qlkEEL7ThW
	 +vUJRVFssjv1kJF+PlG4XGzMwsk0Uz4rIUMmXGLWlLcoUKHE4LsFsYSYFmoofaTIVEZLG
	 WBKcqk1qw+cbA7U7vI3ehfdIoZgcpAXUyaVR3BiY8MNhCcZL+NqDlibCS+TK0v9lHXvGn
	 Upgw6pDX6KbsnaCHlPoBNVQXOE8YUnw/3UdQvkdZjhbleLPiLOYNs3eUfgYOq7icsdRAY
	 8VIA+pFV/AGVtnKAjEB+Kjsp8lthCbk9Wc3LJn/bPomwhK3PUXz3QVM77J3+dVcMfKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015189;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=LeU/DxXcV0ry5yYe0LgqD+dUS+pwnrp+dk5INqwKWBw=;
	b=HtrjRMf0yy56NpX3Xb2MsiDrzD9ErFuXupFo7FuqSI53FTuTOdg+rKDNbjAhC3EI/gGJ
	 qi40Q9pZ75sPYzBwsMXP7OSg/weaJRYz3bi0LsB3h469L+chwZfXpIi7N0+5CU/Nx11hO
	 918p9bs4jrMmgZxFNDKi+v0IkHC48ZhAm2h8Tb8sHc+Y9YxSdMhWog2W4QLR+FvBHji4o
	 cHL+X/YfqV8cUTbU0yb+lyl7BiNrfVZSXCdpkTTcko2AOy0jY9JdANmGSfQoLwM62K5Q7
	 OkGy5CE5qQeGin25wev8ZmfGPR+qY9pUVa7fZswOIeLKg09jw9by4enj7nNBcwFpOnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhY5kEms;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B360A2622;
	Wed, 18 Nov 2026 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhY5kEms
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AF61F000C4;
	Wed, 18 Nov 2026 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795015188;
	bh=LeU/DxXcV0ry5yYe0LgqD+dUS+pwnrp+dk5INqwKWBw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WhY5kEmsWtbqCPSBFQ2nQaxXboUG96EQPOcrbrxf3sO4BB8Tm19kr7KE+iG4TB6T7
	 PIfvCftf6yhI0z/gSSuVSWelQ+KcojCemjhXmawQHN4M8lm9G59rJWiePg41ZCfjrN
	 PTiXDg0szsr0RvvEzTrfcZRDRdJB+saYvIzHKu+1KiMaphpaZRxL/B8C17nK4lXIND
	 5W5iL5YyG94DwOrXeT6A6n1Sje0lSSyR5xqPs+kpFEYkwTWmDT12f9kXD3kAkufpQI
	 6gnmw6UhyvmYKom5DY7ECNpupaFbP0vtsHy/hz2LwtgAFS8e/x4LMVKaqoN8FbGJ3G
	 dYN3/OHJyRueA==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
 James Houghton <jthoughton@google.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, 
 Michal Hocko <mhocko@suse.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Andrei Vagin <avagin@gmail.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, 
 =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>, 
 Tal Zussman <tz2294@columbia.edu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
Subject: Re: (subset) [PATCH v3 0/9] userfaultfd: assorted fixes (part 1)
Message-Id: <179501517242.13206.4721668826806594112.b4-ty@b4>
Date: Wed, 18 Nov 2026 16:19:32 +0100
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

On Tue, 17 Nov 2026 23:28:40 -0500, Tal Zussman wrote:
> This is a first batch of userfaultfd fixes, with more to come.
> 
> These were found by a mix of regular old LLM review and by having an LLM
> write a TLA+ model of uffd interactions with PTE bits and other state
> and seeing what issues fell out.
> 
> Most of these fix places where mm code loses uffd-wp or RWP protection
> while moving or migrating an entry. Userspace then either misses writes
> and accesses, or gets pages reported that nobody touched.
> There is also a hang in UFFDIO_MOVE, and UFFDIO_ZEROPAGE modifying a
> file through a private mapping.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: migrate-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[4/9] mm/migrate: warn on a writable migration entry with the uffd bit set
      https://git.kernel.org/mm/core/c/ec53fccd

-- 
Cheers,

David

