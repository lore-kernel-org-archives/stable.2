Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950688;
	b=DiskRmTWkAI+67n78sIENLhmqCw1FrCdF3ZeZj831SYaa01RsInM92fM7YrhYY6+MRTQ
	 W8anXK5mqsSN4m8vlXcoyKWNPlaQhTcB24wDnQkT2LAdV2ytCi/Nhh4548g6aa2Ela3IH
	 SyZm7ZIIi7dDzLEIK+OE7fxnhV+U7CJgGnBKfJmFag2QxNscEmKR3PNcuagpAarJ/6U0D
	 hzBVJ+HTtUASC79YtSglGOrqSTVMazlOicb1t6UcdAqdGqBl7tbcTp23Kj8lFhtfbXoae
	 ktGDvlsfJBJ29pR9q6Gwjch6KZPTJeYKy6IifKu+u+phv3r4u4+IMtmshOmsT3VYhEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950688;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=hvH8bxVat9uMPDe9n4hf/lY7kBk2VZsQsFJYCeEIQ48=;
	b=bVCn0FrxSulUZIEVHqc1BCFxSeeHztvCMhEYH/rjNP0T0soM1WahMNyXGlX9WcI5SbvK
	 a3cNUBFDufZtHSIGy+3mhcNft1PhqCCHly/VfpP0llqGQaji+ce63gFqxkZVyW6K2wTO1
	 DLmlAPe20bKsISM0tBfcsf5OVZFuzblqCJPwbKlKHD4dkX03VugH3ioGGLDZW7PHxNveD
	 ZUHHVniN1ouadAUkiJ5fOXfsPNnyikL1q4U74q+w4SEZIfvFD17k7hXP5q5t0gswNBA2N
	 lt/CyGOeLLenXRpEgJGa6kHgFHRnX+k89qrOpTjNoCp9xLoo84OP1nZ2ekAWtugjYEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtsfLFMd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B7606A31C;
	Tue, 17 Nov 2026 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtsfLFMd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300C91F000C4;
	Tue, 17 Nov 2026 21:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794950688;
	bh=hvH8bxVat9uMPDe9n4hf/lY7kBk2VZsQsFJYCeEIQ48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MtsfLFMdLzw9jXBtv+5BOt1KrDAYuS+bDvrTuob6CE3dxLkG9/t78xyItT1dSAr7T
	 MmR1lQ3cWMeKelsvWGIUsloe4B2sp6cn23BXQzEtK9nd0oRQFp2GvjyxESWICF7ebd
	 cUsjmK91CX0Z7TkfZDmB18YZL4wEQEZSfyW0W87uSt8KDCe+EiKVwrF0AkzZ96yDYT
	 Sj5ZbKPK5mEo7jwpYUX/MGFrDDDmKx+QaqaIoZ/YWDP3TQFwhGTYSx8lvn/QHDbvj0
	 9gALozEay7jOBr+SMc3uFNCyUZla33mjC7fTCOahNL6WINrBt+pUXMG+eIVkMeuec+
	 LBy6xpMjWXZ9g==
From: David Hildenbrand <david@kernel.org>
To: David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Daniel Wade <danjwade95@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R . Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 stable@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261117100622.807-1-danjwade95@gmail.com>
References: <20261117100622.807-1-danjwade95@gmail.com>
Subject: Re: [PATCH v2] mm/memory: mark unshare copies dirty to fix
 MADV_FREE data loss
Message-Id: <179495068490.3690.332778202915534478.b4-ty@b4>
Date: Tue, 17 Nov 2026 22:24:44 +0100
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

On Tue, 17 Nov 2026 20:36:22 +1030, Daniel Wade wrote:
> wp_page_copy() only calls pte_mkdirty() for write faults, so the copy it
> makes for FAULT_FLAG_UNSHARE comes out clean. Nothing marks the folio
> dirty either and there is no swap entry.
> 
> Unshare faults come from R/O GUP pins, like process_vm_readv() on a page
> shared with a child. If the process forks after the pin is gone,
> MADV_FREE in one of them marks the folio lazyfree and reclaim frees it.
> The other process then reads zeroes.
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

[1/1] mm/memory: mark unshare copies dirty to fix MADV_FREE data loss
      https://git.kernel.org/mm/core/c/1000fb7d

-- 
Cheers,

David

