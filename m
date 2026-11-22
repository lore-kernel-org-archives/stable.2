Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362925;
	b=1rBMNUfVs+5+rtl3FK7/UJoYMIMXET5eTMLsLpb1EpqoKRAHqwFhu+ldTQ/eHbEzyr89
	 nhrZVryHXchXXMsENpRPMhtGO1NK+jlddDDqqEZ+aMoXSuR9lqmHcmybMw0uyAvqW6NUY
	 o/xh7jjyL/HMP3qSmSF/yYzBphoLBc2vXW8rFNLa2N7mNKmYkMJf9kdsrdEEXQlht+VEn
	 2t+2A8Zd6Puc4Dd+j+h3Suhh2oo+JqlNNVoIfpEUn42yBb5F2lSoy3PLLtMkFVbvrLwKe
	 0tQNDlbuD5j9/h8riSaT0gL79FtarpyeyKjOxrFV7tre1Trs3H3wdFoFdzVkDSTxWtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362925;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=8uB9TUoaK0EwcPdykqZJN2k18gBtw3+WNOXzc7jc1Ow=;
	b=VNmW7bAC/IfTNMZiJxdFVsxmDpWSYdFLPACFH85KlJo5fah3h3hxWR4xCi0yiL15g0g8
	 iHmssLYua6WwgiFVKdjv/uZ9n7adoKY5Vvly51xS01MW/xIjTvdl4ueSWQLVJJepWW8R1
	 J3PvvGV7vQOz8MP8n+FCGM9h/RQ1mntvhwwLpCJzVFSwM1X6H/nkqgh51KFrDV4CYXYka
	 5TTwxWceJcAfaZ1cEZwpqU6/uF6vGPp0FkpC9kn6IZ311/5D9VQsBf6wwAZMgwFo3ravJ
	 OIG9CI4RGUVGIou+NER5Zo6pnz0Rbw1mEezVI8MEVJ7SadX1loEu61X4jQpibNgd06w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kP2ZwKLJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927BF606A332
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kP2ZwKLJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932401F000D3;
	Sun, 22 Nov 2026 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795362924;
	bh=8uB9TUoaK0EwcPdykqZJN2k18gBtw3+WNOXzc7jc1Ow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kP2ZwKLJeJwsViHkCX55ky7IhiP+3smbuMwEBInHWWEEeV0ZYBqcpyzNJsHW0A8Ud
	 dbFSRCYH+rmB9iQO/qK8BRRXxxLwuT8E+geJ3YT96hQM2XC3Fjtep4GLnOB0/68u3u
	 T6C4MaYFNMXm6sJ8L5+3WINBpSQ7t4huLi5QujFMpxNG0H2chHfkOAI+2ldb3weOYQ
	 UlnSGFKGNIIaXFMmJiP9PVZ/1MPe3bdvYvG176oICuUDESTclpsAv1VcM3mw+58NrK
	 YWVrUOSzuQ4gTQ1MGe3nmHDuW3rqdivJ1gqgZbE83diZwGVNEGLSUOBb+efHS4q3NM
	 BbNj1+gez26JA==
From: David Hildenbrand <david@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, 
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, Chris Mason <mason@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
In-Reply-To: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
Subject: Re: (subset) [PATCH 0/7] mm: reworked AI-generated VMA and mremap
 fixes
Message-Id: <179536291830.3243.152389320315927715.b4-ty@b4>
Date: Sun, 22 Nov 2026 16:55:18 +0100
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

On Sat, 21 Nov 2026 16:02:26 +0000, Lorenzo Stoakes (ARM) wrote:
> I have reordered the patches here by priority, David - the first 2 should
> be prioritised as hotfixes, the rest can go in 7.5:
> 
> == Critical ==
> 
> 1. unmapped_area_topdown() invalid bounds - possible memory corruption,
>    triggerable by any local user.
> 2. Lock VMAs before mm_all_locks_mutex - system-wide unkillable hang,
>    triggerable by a local user with FUSE.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: ksm-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[3/7] mm/ksm: only interrupt unmerging on a fatal signal
      https://git.kernel.org/mm/core/c/d90efc5d

-- 
Cheers,

David

