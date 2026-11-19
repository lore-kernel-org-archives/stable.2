Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108256;
	b=BEoyFpQUKsWD5J0Hide6BC2TQLKgjRuLVPFdOBwG4fANCJRHp7wOXqhX22aRNdICZJQQ
	 XrWB6oPMq3x92kmk23O7NQSXRMQH4lGDG+AgTFHUSn3xyA+EbNHT7yfNuXYyLn58GzYZ/
	 u6o7HB4W/f1JNsqvIVdaoLnLyH9WhpDnmchbwj+eLQjhtQcs9w/zBWonaljT2QhdJgSQA
	 1TTr2JTzwBWgaxPgehFvQm/0RNYph6gqHv1fhNAGXEZNaOr5bQy/hd319BfyXee2UbTst
	 xN9q6KYVMjrU1XKR0CNADU8PtLr1VWeRfUI45YtiUQ7axfS+lRA2dOA8wmSJhHO8gzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108256;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=NE1INRl0OWxnNGr8U70vlE+S1wMHUVyOCaS5QMEsf7M=;
	b=uZ8gFrTnDUmK8xaktOM/UxxgyE32Wyo4Cq++5u06+tY6uj9ac1oOyDBfwKoHr3V0iDPk
	 ifRh7PQ77J276ZW9SZbKK/CrEbjso9fjff3xUt/h5QImB1UEVnBCw4oOhLmeZVa5P8/Nx
	 r9BeE1tnSeU4LbF5ZobV6Z6Ic2DRcu5JCxB1hH6iSvKoSF8la4jUUBI8+OHeStc+Ad9Ln
	 1mgmmm/KgRyws0Tv55uoQcgczHoovPNatR8og5AbJx4LgHjLoJP14Or+ybr+N0XSdVNzq
	 k6UjqTyvOi9m/XMYLjRZuGC7o1iGCUkSlgmuc29wjsXB6UxxUZAnSFX2xJ67xTh602A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ltpszXxF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81597606A633;
	Thu, 19 Nov 2026 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ltpszXxF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866931F000C5;
	Thu, 19 Nov 2026 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795108256;
	bh=NE1INRl0OWxnNGr8U70vlE+S1wMHUVyOCaS5QMEsf7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ltpszXxFqV0AAQqTyrnIS0Id3IfThC9AIODIr8UqR376J1BiffWgOtqMu0oXLbqhu
	 /OjZ+P+fR8DCvcgViGavzX019M1Myv96jTmpVUOHNlTSdYZ2sPSoK7E46MZyY/vQ80
	 yHEI1wyXTkexOkE++mB7R2HOJNQbIdCF6xaIZfsxwkWDwdY8SxNKZZTx9wyZ6qpVrx
	 CDfEwcz3yrRVRF+QX5HjKleBXp6DZnOXPebaztPYhsf08IDYeH6hYMUu/rFlRPENiG
	 59CioBBEOPdfUCy9tGWOCjKdtq0s9Yr8U7fNgzPhoteVDfi7EO9sBg2V8qi8pBmuJn
	 SG7UNKN8fwkmw==
From: David Hildenbrand <david@kernel.org>
To: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
 Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
Subject: Re: (subset) [PATCH v2 00/13] mm: batch of (urgentish?) fixes in
 oomk, cachestat, dev-migrate, percpu
Message-Id: <179510824418.6720.13392203778507016783.b4-ty@b4>
Date: Thu, 19 Nov 2026 18:10:44 +0100
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

On Fri, 13 Nov 2026 21:45:18 +0000, Lorenzo Stoakes (ARM) wrote:
> A bunch of fixes for oomk, cachestat, device migration and the per-CPU
> allocator.
> 
> These patches were originally AI-generated, tamed into upstreamable state.
> 
> Some are more reworked than others. Those which needed a significant
> rethink are submitted as mine and marked as Reported-by the relevant
> original author, others are smaller edits which are annotated as such in
> the usual fashion.
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

[04/13] mm/migrate_device: allocate THP deferred split heads
        https://git.kernel.org/mm/core/c/dd3f0a40
[05/13] mm/migrate_device: don't collect a range twice
        https://git.kernel.org/mm/core/c/bedd0a3a
[06/13] mm/migrate_device: don't let go of the fault page
        https://git.kernel.org/mm/core/c/34f3affb
[07/13] mm/migrate_device: look up fault folio after a split
        https://git.kernel.org/mm/core/c/00cd1f21
[08/13] mm/migrate_device: fix ksmd oops on a migrated KSM page
        https://git.kernel.org/mm/core/c/e0a839b2
[09/13] mm/migrate_device: fix use-after-free of the anon rmap
        https://git.kernel.org/mm/core/c/9663aa0d

-- 
Cheers,

David

