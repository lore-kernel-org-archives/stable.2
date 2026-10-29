Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307060;
	b=XUUxGnC/wfvgqehvoCDU+0FKEzsLHjlyH4oKmdt7GOgKtleerAq2kNlRoi45OC7Zs/Pa
	 rk0P1fWYnqtySNA8gbeQj5iiBggXIpHK08yXyLBApZ5ZI9hfNeboAOYGtmPzft/UPa/PO
	 Zh3nQaVvkvoEK2uts3CinTQN2XGxBcCuY20NUwkJofZ+1sEDGONqrjP/MxS7Lvo9pxOMs
	 hPtiYVvnXrOIC/DXZ4vE7AS8PEXeNKAK8DcfwZVROz1yvtpecpb3BvyE5vQ0BOiKu7IYw
	 vg11+lWcP2R+IE4Jav6RO0zx5dxp5ku9nabxLc4DDDfZn/Bfowr67fbkxltpKcQYHoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307060;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=f99FBG9cmwfw/aEnFPXgwYaEgH0mqzP7LaMxLWErvlM=;
	b=hj6JeJuXR92R9/CgoeKmh/lECYo5Tw+Cqg2jxyveCzDCdPMZQhBXH6a2sEMCSSQh2QNt
	 Pi2WJaOA5zCsoSfN3epJoBX7FbNjb1wzKEf4WZ6YjqFLL0YiXZEWTcT2Ymw0rXzvUOJJV
	 hGsu4NYcjlEYgfs/Vez0J3+2ja6Ywj/L2Yyy9wiexBQ+gixqb2wguUqN9rYNfPqLP/s99
	 a9wfxhQvqkXmYdeTjDAM7798/RFdM/UnK4IKAapqXXYJhNavKmh0DCsRU64dsxZr3+Uh1
	 QNdwNuN6gOmGxjnIimhnOlxiMmKxcM+T1OdGFaEPnupaEYvvouRwXLdoJrHBeDUUIDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISvCpW1n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52920606A339;
	Thu, 29 Oct 2026 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISvCpW1n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EBC1F01816;
	Thu, 29 Oct 2026 20:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306660;
	bh=f99FBG9cmwfw/aEnFPXgwYaEgH0mqzP7LaMxLWErvlM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ISvCpW1noMZ/QA9Jr4U4ciYvPBlggN3Z+6JfPPsgt7+DBM//0I+sSMG7BKDe4mOYJ
	 0LzS18/0vo2MIyIc1gbIO4QitWdoMYUlqgluemT6WVI5mMdz1prqImIRZLHagRYJPl
	 APjbqHJGcwwUeuXSaijEVSo7Ic8ccUPMCoJrbjRImpYt3b1GIpeOsoLwSbcKWxWMBE
	 ImzDkrq/DeJ6vMi5OW4WJWRj+jRdW1Nm5Ct5iDGzqfdhTgeO72u6sQV4AW0hawlICs
	 itcUaU3Clq0Apdq2pQxRfxTHxoFtftXWanHxoliGkrRBX9nEQXTMchpzwz3AWsjlCH
	 Kcs9Gjc6eZC6w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:39 +0100
Subject: [PATCH v2 44/47] mm/vma: don't leak the charge for stack growth
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
Message-Id: <20261029-fixes_core-v2-44-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=david@kernel.org;
 h=from:subject:message-id; bh=o0mheINR978z1uD1ZHGsTx1VSvH13fE2UEr82UlnsHQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer+36aHqh4IJVheeK896X0nMzPQ/Pi5JZtIppO0NnM
 HNBz/a2jlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACYi68XI8EL/YelpBxn2YMEy
 +RgRwdSk2d/+utfpP5UtN9XV+bL/IMP/sMpy4djuF7d6rH8c1XGs5FY9Uao3xdh947d5D4VsGSb
 xAQA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

acct_stack_growth() charges stack expansion even without VM_ACCOUNT.
This can happen for read-only or MAP_NORESERVE mappings created with
MAP_GROWSDOWN. Unmapping these VMAs does not release the charge, leaking
Committed_AS.

Only check and charge growth for VM_ACCOUNT VMAs, matching mremap().
Unaccounted growth skips the overcommit check while remaining subject
to the other stack-growth limits.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/vma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index acdf00346cda..695d0be85ac8 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3391,7 +3391,8 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 	 * Overcommit..  This must be the final test, as it will
 	 * update security statistics.
 	 */
-	if (security_vm_enough_memory_mm(mm, grow))
+	if (vma_test(vma, VMA_ACCOUNT_BIT) &&
+	    security_vm_enough_memory_mm(mm, grow))
 		return -ENOMEM;
 
 	return 0;

-- 
2.43.0

