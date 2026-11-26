Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700097;
	b=TDR4vTiZ89IpXEIdK4We4WVZcDvGOrVZnl1qDox4wVBaWlEapIDfm1ukvA08rahL3/NH
	 UHNneZNAOCH4ljyA7rgnM2zX+UpNSuZ2c0zZ9PQXkTXup9EACoEeV52L+1vFd65F2CA9C
	 eqtqCmPZzBKRfAxE34/ILGX1HzZcYkphk5kjCoFtRHorGs303iLP/V3lq1W6p0n4gGF+Z
	 dJsGXnR7uC8AiS3dP3IfMn7qKsGHBmUfcOH6+tUjw69vxgvWN/l4pgMK00frVuEHmSJDH
	 fExPvcuo4vUYkhR0hf2V0XGxaMIzsVznL29LrznbvCdXrp2+ak1Ri2i3NHtvqzEILWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700097;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=DOZLBVC8e5T2seSjbwKw7gp2SlRqgI2Mm69LObxIeMM=;
	b=OIiXkzhT6hsEo78duCAq8twddq81m+je6w5NZZX94s0UZHWhU+oYFmwCBFVkfa5v/tWF
	 NPlQUdmUKSWAlpRjA5VWiUbtHQRV4R5hi/lcw7DAN6kx0uQsdan9tAz5k49KgpvRbcBEx
	 wckPyFyKeuK8GvrYl6TPjzKXDgOSiUQInltXyMtPw0Gkpcst6IwPGPKD43mZPTwLnxcQs
	 ij32GZBZbVGmVkCErZh7qFif43yODiynl3fNsFG8GnRSPKORL3kEhNFHvchnJJpr5Kgl7
	 W9lpIQNQpswyJMNG4syzIeHF/tdUZLaXTfB5iqmLj8GYKqyGD8+wksBczd3p1jzeRsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPk2Chlf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C4606A31C;
	Thu, 26 Nov 2026 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPk2Chlf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4DD1F000CF;
	Thu, 26 Nov 2026 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795700097;
	bh=DOZLBVC8e5T2seSjbwKw7gp2SlRqgI2Mm69LObxIeMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jPk2Chlfcc+IlMa6Se9qcdVl2MRCZbIG269JsvJ0CbIPZDz1JU66TuQAA+AdJsV1l
	 EGBJzAt2tG/NXMaeDYV5+L1mbNwUYHX79mfAL7PFBE1yOI9FXZMu5ZnJpALpNFlspo
	 PhQElUGVk9bMqYQYZNxJfEMMT/u+h/gDiw4JtJEB9uyQ9SLhjcjEiS/69Nk/tBchK4
	 CeMAzFSbcQhGowxJ3XYiefjwuQBdtmlXkn2cSgsGEv047zb/vAEEySltSxicUCiGFv
	 H2dljJBG7iaK6A798ZvQHvmgTXoD6t+GSL1+JrBDQiahVEzAdecunEzQXBcnCrgfWH
	 2ee3yQ7ER6sGA==
From: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Willy Tarreau <w@1wt.eu>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Rik van Riel <riel@redhat.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linuxppc-dev@lists.ozlabs.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
References: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
Subject: Re: [PATCH v2 0/4] mm,drm/i915,powerpc/spufs: vm_ops->access
 related fixes
Message-Id: <179570008611.16270.17870262980565551144.b4-ty@b4>
Date: Thu, 26 Nov 2026 14:34:46 +0100
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

On Sun, 22 Nov 2026 18:55:17 +0100, David Hildenbrand (Arm) wrote:
> While working on vm_ops->access related fixes in core code for FOLL_ANON
> and VMA access permission + size handling, I stumbled over two driver
> issues.
> 
> Fixing it all in this series, because it's all intertwined. Only allow
> FOLL_FORCE to bypass VMA permissions, similar to what GUP does for other
> VMAs.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: core-7.5.access

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/4] mm: do not call vm_ops->access with FOLL_ANON
      https://git.kernel.org/mm/core/c/775abaa4
[2/4] drm/i915: consider vm_pgoff in vm_access()
      https://git.kernel.org/mm/core/c/95553038
[3/4] powerpc/spufs: consider vm_pgoff in spufs_mem_mmap_access()
      https://git.kernel.org/mm/core/c/50df2688
[4/4] mm: check permissions and bounds for vm_ops->access
      https://git.kernel.org/mm/core/c/8ef1926a

-- 
Cheers,

David

