Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165326;
	b=FmBns6KVZfN+XV94RWxnNsiWUN8lflh3w9hVMVRjoIl6GLzf1qhWG4M1ZYp3AU8rB84w
	 UJeifBRSaQ5MNfSOOv7RHSPxF6J13rpHQ/0Dzzku6RDrKCpMIovrysjGFnyIdTGFsVk2t
	 csgud8vit955hrm6ZhgCEVMEpYwjCnXNp4jHonWZYCQOmRhXKLeo0TzzV68K03QcH8cQf
	 Rkr1MSi5u2iyHZABxX9NAozQqsZptef8jv3uThvHz74zxDQ/n617P74N/G0Z2kGFyWjuu
	 0rR88L1lZsPhvt3w0hVh685ZvkwpL299pH7EOCqTbYpbUZ9t/S8dr6QR4TfZNI9EwuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165326;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=SO4taNSoFWvfzpQNg247sizb7f95ixN+wBWNxJFGHeE=;
	b=cKlSENa7WuVBlMJa1Y7ohtl6YEe+STC+mxyxoAC26+3mV4uvgbxD7AiKCG+ywzHGKpv9
	 Jnd6av5CIhIMEJwWyc+VsDA+YeO0Ches0P76jo8xHHEGK6jLc0GDaDxGTMeHoevBKNko4
	 eMygAb+x2BPitARlyCGhmY5RDHvgy6jLNijuDlhp6YqFkRdevMxkbu9wmmlLx85zl0qkN
	 j+w+7b+0CvJij+QXDqw/QpCbGa3Qfdjf5n2MaAjaOt7BQEWxdLNUD1QRp6X0hdYSo4ckX
	 8tcHj+b7rkiV9CZJ+IsPoEzixhv/tLWHOeT82IEfkoZr/kCYcoIJnhX5nwJ/KRgCSHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQeZfwg1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB2606A320;
	Fri, 20 Nov 2026 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQeZfwg1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84481F000C6;
	Fri, 20 Nov 2026 09:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795165326;
	bh=SO4taNSoFWvfzpQNg247sizb7f95ixN+wBWNxJFGHeE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cQeZfwg1AQaM9+g+ZoOKOqTcPDPhUkTiRut3nuD0MYet9vo1DHSjUYUKOvGyZ/lMZ
	 bdKNfGyEmcjPBORO2M3AKpNBgY6M1ZAk8CxlueoNizE1bvfxP2g77TD55706V566Os
	 XVP92ksQ2WrH1AXNCzKWB58iqA0tLp8VFDxb+MGHp16fvV8jyeRYijIERnEFOed/d6
	 eXmkXDYDMMUwzKP55Z2w1viMbecEbCHI2pp1wHVl6Ml56hEU9LAYdGDRcTgOo7udhw
	 tsbdg/h1F13HLAETPurF73/cNsgQXW2ox/j9YKlQNkd9V7tPfS9vz3dxaFFS2tiMwq
	 mJWkJfhoM6cyQ==
From: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, 
 =?utf-8?q?Cenk_Y=C4=B1lmaz?= <cenk@deepfinresearch.com>, 
 Zhang Peng <zippermonkey@icloud.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
 Mel Gorman <mgorman@suse.de>, Sasha Levin <sasha.levin@oracle.com>, 
 Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
 Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>, 
 Axel Rasmussen <axelrasmussen@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
References: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
Subject: Re: (subset) [PATCH 0/4] mm: fixes for stale TLB entries due to
 delayed/batched TLB flushes
Message-Id: <179516531551.3851.12254028800691398682.b4-ty@b4>
Date: Fri, 20 Nov 2026 10:01:55 +0100
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

On Wed, 18 Nov 2026 10:20:35 +0100, David Hildenbrand (Arm) wrote:
> David, what keeps you up at night? Well, the last 3 nights, TLB flushes.
> 
> We have two mechanisms that can delay/batch TLB flushes and cause
> problems:
> 
>  (A) mmu_gather zap: we can delay TLB flushes until after dropping the
>      PT lock, after having zapped PTEs and adjusted the mapcounts.
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

[1/4] mm: flush stale TLB entries before installing a CoW'ed folio
      https://git.kernel.org/mm/core/c/5e65fb33
[2/4] mm/vmscan: flush deferred writable TLB entries before unlocking the folio
      https://git.kernel.org/mm/core/c/15d1795f

-- 
Cheers,

David

