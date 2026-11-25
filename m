Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602671;
	b=vswOQEkpN6r5NueklkVd1vtxgVCVeZ7yFLFyD04HVS1YXxWiJBvEcKj6FoXD34uf9rmS
	 17pLwOzk+wIoYL13GYqruh8GWTwP7XPVc9SFDyePzCVZfGQA9NigrkNDEELlpsCIBN8Nl
	 0Xt3jVttxl5ALncDy8naa06QRTK1fCk/yrwFC+KCFxN/mjEpHoErUMBnJvYXBRjZIuHEd
	 Spgznsz/xMXPwfxhix4efEc1Xl9EZ/VRJgl24Llir9VnlWoYypQPCmVF0hcgxghwu34JW
	 IK8JbObDi2D5R1XLe+qY9Jxy3nGUSoQBQu005U36V2Rry3YTbOg2DYvUVFctT66pY+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602671;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=fDmos8Vna2SN/uNWyI2u7cpxgaVth0M1BKouMEUDkY0=;
	b=1qBIKqJtBwghi4SUyVGkrC/MABrvEac0foW3bgokft1jpJQwaiJ3ACHX6v6lDH/DLrsE
	 fCBdeoQY2GKNcvQt8jZHN/Cvea9kAAonDkSSNzZaOE6tl6100+7Eh01BGDFlOPU+E11Ya
	 YIu2uuWa1l7f/X7rFqqoFcI3+/gVwAstzFOWl1o+JrVFj5gtEM1QIWQlyZqnA6tXAqto7
	 oipVOthelfEW8WnsLaU7c4nRPlz8SzV6FkHybrqkR/N7naheKkdgRhA5a5UGrYQndrix0
	 0ggwP8YH0AzKDX3uOEMRTsXtdHdLJ1vgP9/3g//XH4sNQvmf7ogM37fTkfEDSmajJIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQ6L+uHU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4A606A330;
	Wed, 25 Nov 2026 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQ6L+uHU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9DD1F000EC;
	Wed, 25 Nov 2026 10:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795602670;
	bh=fDmos8Vna2SN/uNWyI2u7cpxgaVth0M1BKouMEUDkY0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EQ6L+uHUmjexoUrsV8WJNJv0NDxdt9hlsXM5FujgrvKem2xH1SjtDMUjR71QA6zrk
	 FvzaejGEncx87/TmZrfEHFoi6KHCtHwf/TtgNlW6ZLHrJW7Lz705cBDxGRlzsVJ+se
	 LgFEJUl+nD2oEKOOAn8BtjMUfqqrscUl+hqVxfgEyT/5u5OTIV1gq8K9AoUIB3GLbH
	 bWJkb0QViqnahkP1pZfAfgaq/FCEZ4ML+4wpf/eo6ybzWD4Eq+/pM+n43VmXrlNnAQ
	 SRSvQHm/BGdkL/6RCZ55Oe4d4CZnelXmGQnIaIgAfsCC6cAaG0iBqgcRiy4jVDkhcN
	 vX6ffd38sGjSA==
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
 Chris Mason <mason@kernel.org>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Chris Down <chris@chrisdown.name>
In-Reply-To: <20261124-migrate_reclaim_deadlock-v2-0-03cc147e1e36@kernel.org>
References: <20261124-migrate_reclaim_deadlock-v2-0-03cc147e1e36@kernel.org>
Subject: Re: [PATCH v2 0/2] mm: fix deadlock on the folio lock when
 migrating and splitting folios
Message-Id: <179560265875.4197.7576246208223051275.b4-ty@b4>
Date: Wed, 25 Nov 2026 11:30:58 +0100
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

On Tue, 24 Nov 2026 08:56:42 +0100, David Hildenbrand (Arm) wrote:
> Whenever we allocate memory with __GFP_FS while holding folio locks, we
> can deadlock on the folio lock when triggering direct reclaim or
> compaction.
> 
> For example, evicting inodes with a populated page cache takes folio
> locks, and if we happen to need one of the folio locks we already hold,
> we'll deadlock.
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
      https://git.kernel.org/mm/core/c/b4f63023
[2/2] mm/migrate: allocate destination folios before locking a batch
      https://git.kernel.org/mm/core/c/51fdc28d

-- 
Cheers,

David

