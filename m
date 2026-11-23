Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451273;
	b=A2A6I+TA6NwvsHpF5246ADC2wbDZeteuk4m0rj16k5GlKwDoJfN/ticDBxHJCBB1co/d
	 CSDS/yvdcx6mxAJi9y49mQHx9jA9QbJrYtq1VL7EBIfvtlvJ8DhpRoKbPiTVRtHEZUN/5
	 kBvjXEWkIMP1/gubDREGm32kxsW5S15liNAyDFVYZcihDTQHDTatw5PKSjJQD+VHYTOPS
	 TiX8qF23kfH7m9cxt+WOLuAYrr5nPqmFID+aC15ccJkJTNv47HkQZAStkUDR5fAqE+wz3
	 JYT3166cydUoIp5xwIdZ84YgFv226qHbJ2pCHrCieeWoU3xBP/3FhGAj1AJYjVKM2/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451273;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=v/edZpvtocFnokGsp1EbOcZhOe9y7g0/5yjPiAkc0Xs=;
	b=r8tGh+YGDhWP21Jy6MoO21vRD8S/UffXo/7s36+YXRyWQa7odnGVsyS2L7qZGwEcc5Ld
	 PLMttiOyzxYmMuBRm3VJng0wg8FhBQ8Ff13GyFj4y3oi02EiWPNp+RGv/1kYjPdNxS8XX
	 xLW+Y5r1B31hSfDKbM2/xG1E0qO838RXM9ANKKkH25Gnmbz7V+T077JhqT2UV1t6AJ0s3
	 NlfWgGQXwPIgF/mXzqK6xh4aZWpBjry0Pj4JiIwILAypLClgblD0f9PBINA3SEk9fbxwl
	 OeRzXG8HexBGZSVnqoichUmiHv1Ngo5y6GpU2na6v+Ig+v7vDsDG3l4y+Ey4Dudvd+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRt1pSJk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79B606A31E;
	Mon, 23 Nov 2026 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRt1pSJk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F7A1F000EE;
	Mon, 23 Nov 2026 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795451273;
	bh=v/edZpvtocFnokGsp1EbOcZhOe9y7g0/5yjPiAkc0Xs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dRt1pSJkg3WkBlKowWpBq/jbTKfBWyj9XEnrUs3NKtR+jz+Bpv6GF/MuOL6vSsTiI
	 HBlYqvgoKt5JamaQhQFerxmPkO5Xw/A9rCd7hD6IwGmiYkKY0E6ausvzsUUZvRf9qU
	 gy3uKYujnbjOpNsn1n1WTvKjE41EBJxYpbH7BHeXtY5TdUpLFY9YA5QYl9o/mvM+XL
	 EJQMWDEG9VBOn7uQiqAk0dRewbRobG9rY1Cl7kqz1lKwoUUTjg3cftmUKTe8riaKHy
	 IGe2sBKcZggb2llkwny5HUWn8w8rLcM5OObj1VZy1nKrY4i5TknPy/9hWcf2D6U0Mj
	 mVzK0ScV1yaxQ==
From: David Hildenbrand <david@kernel.org>
To: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Heiko Carstens <hca@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
In-Reply-To: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
Subject: Re: [PATCH 0/2] mm: fix deadlock on the folio lock due to inode
 eviction
Message-Id: <179545126490.4660.6368553899167259961.b4-ty@b4>
Date: Mon, 23 Nov 2026 17:27:44 +0100
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

On Sun, 22 Nov 2026 13:42:16 +0100, David Hildenbrand (Arm) wrote:
> Whenever we allocate memory with folio locks held and trigger direct
> reclaim, we might end up trying to evict an unused inode. Evicting
> inodes with a populated page cache takes folio locks, and if we happen
> to need one of the folio locks we already hold, we'll deadlock.
> 
> This can, in general, not happen if we also pin the folio's inode: for
> example, through a VMA that cannot go away concurrently. However, we
> have some scenarios where we hold folio locks without pinning inodes.
> Examples include page migration and some folio split users.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: for-next-fixes

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/2] mm/huge_memory: use NOFS when allocating while splitting folios
      https://git.kernel.org/mm/core/c/acc29031
[2/2] mm/migrate: allocate destination folios before locking a batch
      https://git.kernel.org/mm/core/c/15f32855

-- 
Cheers,

David

