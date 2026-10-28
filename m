Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204405;
	b=F7FvEgzxefSuiF0MfigRbNPndVCNa8l93Ugv670o8cbZldyognJ3jZIDu9+EyOPylOEs
	 LVwKddjbKw6EayFfnBsbLPGzEUMPxDOu41kBGeGsPsNmSvw+XURita6B/2IarazOEJvfT
	 0Wg4eg3+Bt7A4Ud8HYflVj0gw1AQbHnzqh94XJVlVZEqNE9NExxIn9SouOK/MlsKihzwN
	 nUhnxMsHLcKC1yOv5YQsacqb4wQlKaPmBuQJ3TgPjLhF3rGMW0pjZthHrBfZvW2gjFQSP
	 FyX23BCDDayw2LXHSlNK/rKAQaVjLtEOK2MaCtUymDR8X9vo1KFn6xZ7wtKWcswirfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204405;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0rATnQQTJ72YrBkABg0cEBhwiSsSBn8AUhfECRfpTKo=;
	b=If84rGanyj1RShYMdDSy6rNy+a+iVYwi0h84OQyD4fmczvdWi3kNcpMjMgwpltEJSoDg
	 Aavx434Mv93r/l1bmMRJwqrYyHKvO+GdvIvsE4X+RBK5QYkRSJ6conUSf9hfc6i71DCzf
	 x6GrwWyVSIWOFvIngBYtEdZ4dBprt5y/zyaS/eFw8lxoIzOUwfTGKqltOeSk0Sl7b+yzc
	 bQKFTSkA+4Q5Uf6CD3g6lzLOanVmp1cSpsFrC1fStic8HC4CizkOyFuSeKZHCnTgQsdDE
	 a/lTbP1GaX8of5QjpQdhomAXMeuXlxQNQVq4wfbVKfBxI9Ynfr26QrNszSUSu1SM4OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Od2jCajZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D83606A31D;
	Wed, 28 Oct 2026 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Od2jCajZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24D31F01825;
	Wed, 28 Oct 2026 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204405;
	bh=0rATnQQTJ72YrBkABg0cEBhwiSsSBn8AUhfECRfpTKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Od2jCajZKWKTDmGKxuYQxCznLzK5lE5I82XP6kHR/pVw15VviXOu0f+rBJztE2sWt
	 aHB1YXF7LuPYHU40KtFSmxWKD6wxnYzbFJeWxCtv5kmvj0IwusDwG6I8dKNYl5hbAX
	 qHQic4MJqltiIVHxUe3brboc9KewZxE/aWUva6VSi7IMJ81oP7hTDulOU8yLFxWP4u
	 W3jZr5qZ7IvLut3ypzOXBw5SA0Vx7r0s7K9pRjlpSjQpPHMhmwn5yGGklOO6EJ9nTi
	 wgAJwgkpfhsVSNks3KTWED/hZ081N4N8oDSY/jJ5jMBOtMs1oL4u97xlwL0bgFticW
	 VC7cHA1IM/c3g==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 29073198005A;
	Wed, 28 Oct 2026 12:19:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 12:19:59 -0400
X-ME-Sender: <xms:pCDiapHR5_UfAlK6Y5IwuSd6tG-IN25ti_9qop6y33Mn7A8IfOyH2w>
    <xme:pCDiaolisVVX49paz5DMLbhyfp3Q6L1SCMdynmBx-MO6JItRfQaLAqjheIBSQuP6W
    utF727eX3BINM1KjFyEGeeFcQzdUVht_0jxrDU5lvFsc9Uo93IjJqpd>
X-ME-Received: <xmr:pCDiatI176GX8GobYrpPR5_2HleYubAakxHYnaCbeKCR92Rik7DrWnkMNEI>
X-ME-Proxy-Cause: dmFkZTGclD1JbppB9HJ+wc+PBYUc7y+dixlkOiA2HsCm5bBLjgZcXtU5z4GDtO5noWzmDd
    ORQFP5u9B2gtbQIzAfn62HyoZPZzOaRlPLXMJbRuOKsJfFDAVc93Ms6EaNrHWEq6z6wsvt
    Vwv7YGYHYp1DmH0JFFFqpqagIBWKJjdY8K+9fHquSKFVK4QpWZo3/X+8b1lo1wJj7cOP/0
    UxPerUKzYQfYIPe0+zZpOe+dudiR/ZmyEvfhO+buEi+HLpafl9BeNw9D79/rT5MOLUUGeC
    H20VI38/59YkMmPnP0Lyu8v9OMGay2+0LMnea7uAS3uuq0rtJ908MMUpIuTf0GbHo8UsAY
    ua+t7Qev6BT8kMHCeyM4V1m6u5YQwDA4moRebSE73U9F3vqd/sLjELfF2vONZb+ZcW5TQB
    94GQy7Qy9EYuo6vu61hPJ1VjyjuMJ99xhWVMI+3gZz6H3VQ84mHv5w8TE9tnJChUhoUUP9
    4BpLr6gQs04DR36/rOYGy/+LZjcGIu/GNpIN099cOSZ+EN2zqtR43z7EhAL94X1B/ytyyp
    oo/rRFI886c55KcN4on3qj6HWPCrIJtfc0D4lmBumEi5I8lrnU3HxQLS8Z22AYR9GbRHTz
    75P/PVpblWhTAf4127jPQ1kO6sZzgqCljd55hkW2aMHmD3LDpX4z8/2t8a7Q
X-ME-Proxy: <xmx:pCDiahze4ae2vr6g0xh1CGHOySl6hdDch_bPcHI01gx7Cx5B5_AyJw>
    <xmx:pCDiapp2l8L-56W56KcYVToqHeGQ2dwKvVCsSdlmv3g205bP2Roufw>
    <xmx:pCDiaj3XJkMTDlTUcybqoOOCtsjCPlXp0xH4AP7sKqkLmlew_k_rVA>
    <xmx:pCDiaoL8lIOsfn_CSb0VzXBCgfJe6RSz91C-07dxto8nIE3ph-anSQ>
    <xmx:pCDiaopVBBj5qbjabGhIOaxTeF90y_zQKddqmsT3AwUNkwcLcz8ejdNW>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:19:46 -0400 (EDT)
Date: Wed, 28 Oct 2026 16:19:45 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 02/46] fork: take mmap_lock before copying mm_struct
Message-ID: <auIgkX9zz8TdnLum@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-2-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-2-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:22AM +0100, David Hildenbrand (Arm) wrote:
> dup_mm() copies the parent's mm_struct before dup_mmap() takes the
> mmap_lock. A concurrent brk() can leave the child with a stale mm->brk
> and newer heap mappings, causing later brk() requests to fail.
> 
> Other operations (e.g., PR_SET_MM) on the parent's mm_struct can similarly
> cause inconsistencies.
> 
> As a simple and robust fix, grab the parent's mmap_lock earlier. This
> way we don't need to update individual mm fields in dup_mmap() and
> keep missing ones. Stop updating the 4 existing members (total_vm, data_vm,
> exec_vm, stack_vm), as that is now no longer required.
> 
> Keep releasing the parent's mmap_lock in dup_mmap(), before
> userfaultfd completion, to avoid moving the userfaultfd handling into the
> caller. This should get cleaned up later.
> 
> Move uprobe_start_dup_mmap() to preserve the lock ordering.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
