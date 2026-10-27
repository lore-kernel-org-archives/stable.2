Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133150;
	b=JJMv+meN9ASG/huP8uIHVsj/nLrB4aiwTCnHcfQlyQGQXe27wpo8J5JMTqWvhmkiiENy
	 jeCoNzx9LuS1pQ5Vs7WBjJXYFxu8QnnldfKxLMOa7MXzA1RhtW6XRsdHlgvbIix3taGt+
	 QveqIIw3tYtBVTe2hbwHgr+vKJ9b3Hgx+wDdbSbC52Kfgijps9RPxQIok6VOsVoRORHAW
	 k+m0r1C0XmECIPq9ouTWPVW9iA+vQSx2yD+RACvSs2TwAxgk8dDo3QsXuIokqim3SJW1c
	 ZPmciiT8MA/gHuDgJxLXO0qL4azbM2jjKAI82xFuQ3uNT8g2GZPgEiLPViEJBk6xYCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133150;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=86fhQATGDo+8MDnZqTEUILQavbmG5W/eLVJguZT8p6Y=;
	b=xXc3tnUoUNa0+9LYCBcEGClOaxVnFwXiLy35NfGhny8ocK4xcxEqKDUqBNdm6pWjZDzy
	 3ohB9QjSyVvRQvjifBQ7wz69PVIOGzxZ8MUuwqQ0orfLYsjwekh5gPnNPohXQJIthyhtF
	 WpDJpcsHqdb3RlD8D7zNn99ZNKuYNDV1BbwBoxAqqqDN9Gm806vlVZjiGMFbmZ6uVaF2e
	 xHuL+gi8GHjsR10bCbI+um5iNxb8JOCsQBKegLFY5vN9VBd8O1wWZVCtjP9kovpbkOfjd
	 buZ9vVGBQa/mqKmLfjk3y+48KVmbgyCXjQEWVolnyva2kPrO7SXKGWysrDO6czP5ouQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUUj8rbd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C03606A31D;
	Tue, 27 Oct 2026 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUUj8rbd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5A11F01825;
	Tue, 27 Oct 2026 20:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133150;
	bh=86fhQATGDo+8MDnZqTEUILQavbmG5W/eLVJguZT8p6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cUUj8rbdB8sxeJkMuDL4RCOdrYbrRplzvevKwnxFuwaEcH7HP+ENffudf2T0mpEpv
	 5IgYZPx4U8OILjqSgrQVM2ZVtEuU+s+iUCRqr37O0SlFEfCwYP6WH8sUr54mzsCt1s
	 iMf6J0wk9xYuuAD3vV+C40mhUS8iHT1njIORZz73KfNOXA2HaiIMPxjzwaUpjzGq0a
	 +HDzAe6Y83Ik9oMrM+EDzTEENc7lTwdaNWApON+amLO666KTk6vgqAwdt/I26Z5K2e
	 tnFRDkmrRt4vDlqitIfQMOzf4AtEOnF0EKCtlUHfO8gpTP2ZD2//SXJTbcFDzwJNgN
	 ttZ0nsquNOB0g==
Date: Tue, 27 Oct 2026 20:32:28 +0000
From: Harry Yoo <harry@kernel.org>
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
	Rik van Riel <riel@surriel.com>, Alistair Popple <apopple@nvidia.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
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
Subject: Re: [PATCH 43/46] mm/vma: don't leak the charge for stack growth
Message-ID: <auEJGq46amG5oPVQ@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-43-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-43-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:18:03AM +0100, David Hildenbrand (Arm) wrote:
> acct_stack_growth() charges stack expansion even without VM_ACCOUNT.
> This can happen for read-only or MAP_NORESERVE mappings created with
> MAP_GROWSDOWN. Unmapping these VMAs does not release the charge, leaking
> Committed_AS.
> 
> Only check and charge growth for VM_ACCOUNT VMAs, matching mremap().
> Unaccounted growth skips the overcommit check while remaining subject
> to the other stack-growth limits.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>

Maybe worth having a warning when it's accounting w/o VMA_ACCOUNT_BIT
or let those helpers skip when there's no VMA_ACCOUNT_BIT set... 

-- 
Cheers,
Harry / Hyeonggon
