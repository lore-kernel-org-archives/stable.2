Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794951512;
	b=2K+nfdhcO11+Rm80t/bDyKQ9e5Z9eexLjzIDrwebI8PBGcGDW/OVokqxeGGfH+LhM8HJ
	 it+wRxBzoUcSYdmIxvltbK+8XRvtPptWEKYpR0rssc6lDBhJv7hUNZtPJbmKJYuxouyhi
	 B/Zymt2oPlrN+3BGhMsjOgx23T88GbK6cuOgyDJQfvW3zgjbV7NB/IU79MFkMx/4guwW0
	 XTBMJ014bwmmtDAF/7w7ejFHp4gzy/f0iKnxhZVIUVcLpM/cezGYITVkpw0c14JtrsFhQ
	 FIEl+YFcnI7sXmHR1lpebgJU35JoUVcL9ZwbBmz0i6H6LEOC3Oxvcc8YhqryyWW4BmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951512;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=iXopMQoBtcGz358w9N9nrAJff3scf+1pEvqdTdRCoP0=;
	b=O3ZkxpuOv3FSRS/zicoXVCHEzVMGU0VndCHL2e5+Q10cgpSRHlSoeyCEIzFw/iPHlweZ
	 +5+4HtiAXFuhVS1NTAwTfd/0TuPe2N9AxlF/a7K5B5G16g7h6ntvJbEIdU6eSIjRw28vd
	 muxQTUajYzthFImj0EFMd6/Kz5BkoBXKtVHElW8azRbnIWpY5wv7igeOOGT78sUVWpb37
	 J3vKSZSg//tXdZfxVHua21BDYvJSxZ8j+R1+yFypTFBjPrfiSXpEZsDCTVBO3X3Hd928Z
	 HXLwhw2/xpj6dfZL36f8X59e6ZqV6EGXx+DTz2YawTdc3zS4eklu/GdSpbFaAJxL/Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TU0WQ2xQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD5606A31C;
	Tue, 17 Nov 2026 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TU0WQ2xQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2FF1F000C4;
	Tue, 17 Nov 2026 21:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794951512;
	bh=iXopMQoBtcGz358w9N9nrAJff3scf+1pEvqdTdRCoP0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TU0WQ2xQUMV6milbx0O6Ta2jGZgdBz6gPeO6FBMhhUIo744+53WpaV7L/CgZSomN2
	 zIUWBItGYo/1F1AmPBP18Kf8nJAmdVZATpzBzzIjc67Xg60UcYy0/61iZA9f7LKP81
	 slEGik5OnWmzZnNjy//vaY5sX7JyLqLfV6wdKLD5glHpHwEirtxBPW9YWWw24IToRD
	 ZoW6cMzpW8srAp5BKcQJ5PIn1RWPdajuoIZg3y18bBeWDJslA+mC+7eDwJ++ABLvmX
	 zsYoqBgKAioTA5mWnschkaCzUMJ0wrFa56Z8OV1MA+KteqA6rhZJIv8/bzYozu3M0e
	 4kLOnmHVHvkYQ==
From: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Nico Pache <nico.pache@linux.dev>, Lance Yang <lance.yang@linux.dev>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 Daniel Wade <danjwade95@gmail.com>
In-Reply-To: <20261117-khugepaged_mthp_dirty-v1-1-024e4a12c2fa@kernel.org>
References: <20261117-khugepaged_mthp_dirty-v1-1-024e4a12c2fa@kernel.org>
Subject: Re: [PATCH] mm/khugepaged: mark ptes dirty and soft-dirty on mTHP
 collapse
Message-Id: <179495150847.5194.3491297223521480619.b4-ty@b4>
Date: Tue, 17 Nov 2026 22:38:28 +0100
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

On Tue, 17 Nov 2026 10:28:18 +0100, David Hildenbrand (Arm) wrote:
> An mTHP collapse can lose soft-dirty PTE bits if pages were written and
> the VMA was then made read-only, and not setting the PTE dirty in
> VMAs without VM_WRITE can interact with a later MADV_FREE on a COW-shared
> page such that all processes lose the data even though a single process
> MADV_FREE'ed it.
> 
> Collapse does not preserve the soft-dirty bits of the old PTEs, so the
> new entries must be marked soft-dirty. map_anon_folio_pte_nopf() relies
> on pte_mkdirty() to do that, but only calls it if the VMA has VM_WRITE.
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

[1/1] mm/khugepaged: mark ptes dirty and soft-dirty on mTHP collapse
      https://git.kernel.org/mm/core/c/5e600d79

-- 
Cheers,

David

