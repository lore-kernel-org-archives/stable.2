Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306526;
	b=OQFomdWVcBbMn7aYvqiRzr7q0BNIHiheh65eNYdjx+pEwyTqpljTFsrfTs+ZHaabLJNs
	 ZYsCjt7ufbNn/PDP9Nbu9f3bd/SyRIuVlWdQvtW18eIiF+XOI48C3dkyu8Q1g6AAl3euB
	 LuDNSY5XKoXl+b5mox/diSUMJRLw+Q64koZ2MPRj5o/NJC7oxXQ8EYl7ozxGoNE1YH8bY
	 ErYVOmZ0A+DJxCqNmCs99xtSb9OKdatFkZfTKvofLvygl1k57cqJ9Cs428X3G2tnAtImV
	 IJkkbZq5VxOBVv/UpbujEMB4IlWp6XauhBcv05kXpr8Ok5viITPZT1JNrGcid1NKgog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306526;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=EmFFeOpTju++ba/4+xeyEk8Axf+jyt6U1SaWbXoiuJ4=;
	b=2nQ2uctEWa6iWK8E52vd5A2tEaTUFRgd4PJHy6dJIYqZTZp1DiVWCZSSkAl7MjYE2Vem
	 nx9OStbHZxbmsWjXe1YssEQ06O8n5ph1B7+AUA/zMpztMj07Qu1TkScADfcSGgnxLEFQy
	 Ql3b8VeLzhZ6iRFbJNR/slQTcc7UL6LP7aUSc72sqI07QvqNkokU0JVpKAxlryNufL2TE
	 OjZ3tTDEBiQy6NB2SxPDKHjsD+D/BujnOrVqUVfX6KDmyj2wnbO4s8hn9GFPuXAN9Ij3h
	 tnztkKfEHUHVZ4PjZgYGxcfwh61/EmKxU/eJwyEvVGPCbB3W0oHrSr182YYbTVLGdrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aupcWAQV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB2D606A31A;
	Thu, 29 Oct 2026 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aupcWAQV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823091F01816;
	Thu, 29 Oct 2026 20:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306525;
	bh=EmFFeOpTju++ba/4+xeyEk8Axf+jyt6U1SaWbXoiuJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aupcWAQVBJTU5Efp9WaPPRXHokXcM9AJqzyLpqG83aXFjxFt7JZ/KxBuLj5XfBFcl
	 8A1HXSJpx0v2mV8OmFjFfgEiQrctA7BiCWa2AjsSS8WoRaQRyd0aCK6rU84MfjOd2h
	 LKtHqaFV52W+DJFd2Zu10Gt0mzqUxMT2JZ2/clGN6CTEFYixvBfaHqCMg3UMkkr9mW
	 immrEuLeds/yA/5o0Dxsl1l87L5TafFkI2LWsR/jcIjDLTDVfs/jSTM9WABHdLUIfG
	 znmWD6Nyo5Mf5P7bc2R5bVFgPnZPyLmvRlzxgwlFeWU+xfv1JehQcmxcXuSeVhYFQM
	 TWNhKtkgz6Mgw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:30 +0100
Subject: [PATCH v2 35/47] mm/memory: reject remote COW faults on PFN
 mappings
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
Message-Id: <20261029-fixes_core-v2-35-a64ce7f83abb@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2247; i=david@kernel.org;
 h=from:subject:message-id; bh=NZgsSdEHxnbgHjPXcrsPLj969BYYYgAtMd+ESFDEtdw=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer+0oO21x57rIvu0fshoW9U9UFeH7v3SBKt+E3TK5e
 07veWrG0FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEAjMYGfbvP1TLKbb2+ymZ
 M607Djdul16prRrWU53vWcS73WVt2yqGvyK2ZcrruRZEXiv69mWViZnE/EkPxE7f+vuSLeDilpC
 UR+wA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

When handling a COW fault without a normal source page (PFN mappings),
__wp_page_copy_user() copies from the faulting user address. For remote
faults, this accesses the wrong address space, resulting in wrong data
getting copied.

For example, user_events updates an enable bit in the registering
process's memory. If that memory needs to be faulted in,
user_event_enabler_fault_fixup() calls fixup_user_fault() from a work
item. Placing the enable bit in a private PFN mapping can trigger this
remote COW path.

Reject these faults with VM_FAULT_SIGBUS when the target mm differs from
current->mm: remote faults. Ordinary (non-PFN) mappings are not affected.

The user-address copy dates back to commit 6aab341e0a28 ("mm: re-architect
the VM_UNPAGED logic"); likely, actual ways to get remote faults in
there on COW PFN mappings appeared afterwards. But the fix is simple and
straight forward.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 6aab341e0a28 ("mm: re-architect the VM_UNPAGED logic")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ david: simplify comment and description ]
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 5392bcb1d24d..ae8d567bc6ba 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3761,6 +3761,13 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 		return 0;
 	}
 
+	/*
+	 * __copy_from_user_inatomic() only works as expected for local faults.
+	 * Reject remote faults.
+	 */
+	if (unlikely(mm != current->mm))
+		return -EFAULT;
+
 	/*
 	 * If the source page was a PFN mapping, we don't have
 	 * a "struct page" for it. We do a best-effort copy by
@@ -4086,6 +4093,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 				folio_put(old_folio);
 
 			delayacct_wpcopy_end();
+			if (err == -EFAULT)
+				return VM_FAULT_SIGBUS;
 			return err == -EHWPOISON ? VM_FAULT_HWPOISON : 0;
 		}
 		kmsan_copy_page_meta(&new_folio->page, vmf->page);

-- 
2.43.0

