Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794776396;
	b=NhzTOLuCKvHyNUGzD5NTONHeNFwoZX/JzMEGbkQyyONIDAt638wYAfi2h6ZKoCe+xs83
	 FkSTWCZcCazs/mZZQ33HIqDsgowHwPFbLvRU8/MIF9ERgeQZS96cfmuK+J0zmgi26tkFY
	 dHS4BFRE5qX25ADEmiLx1S3WS9s9kcCDSniUSqnyGOkPgLjUv009QN4At+aV8wRb98UJU
	 Mz8cUAe+mGDNEZMHOpBOnZPEDNU8G1KMG/3ljKC7+UljOJCUP+iQfl/OE79Me5/bAShJA
	 X8uQEUk5aSafACkYtrTlS3AwMBO1JVMv1eIuKtuSg467RoYF8fe6htATDP116HV7qLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794776396;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2/WlrLv3rx637/xLB2mJR6zPnrKBFs2t8412/Tv2urE=;
	b=xkDKIYlPHFTyG4q74E2MGo6k1gIMo1coeEU7yrol5DN7MLGRVvJxPraMhs06DiEn+TTL
	 EIVQYZlNoRqc4zeov7qDWSy3mKdFt1sdhYT131WYCWE59pDpeTWyDo//VxRo5biVg4HEs
	 ekBmeH3Bz+xadVtVUwBymoPr+Nso9slXy2Kf7CrK0u462ztW97EaDugryFM+YFelF/ujZ
	 W+N03usYdVk//q1LpDnXN9TjLxoV20bTPORIdLwuPodPjTNE9NPQva1yOPx1XihV+VKJg
	 cnY+/1xsxcbAoYWFVKKLQ6Py10uAcKnDU+y8BboJk3GvKz3PjA/cype3uLWkRSKfr8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmoMRSyn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E575606A329;
	Sun, 15 Nov 2026 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmoMRSyn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7751F000CA;
	Sun, 15 Nov 2026 20:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794776395;
	bh=2/WlrLv3rx637/xLB2mJR6zPnrKBFs2t8412/Tv2urE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FmoMRSyn036wQYRqY5I+q4VSwo4/lBASPt41y6c/GBJQUlqh07IoWYwCn9X4nxXI/
	 qTaMQRml85ZoyJcTubYBZfcA0o6XZpkS+dhfd7n6xRfrTdT4C3b6n9PnJYiwpGg3ed
	 gQIwHwnsR+eOlfKO6Isx/4vkrhVZBnwXLiVrttByb/bcev5Q6UewDo/FTJaS9JfoUd
	 gjxC9yC/CUn209JAXsxVPBVb9Eg6mk0ZBptQbm2t8iG3/nPkyu/ThcM6lihl2kHYp4
	 Y0b+1tr7u6WhWEQeedg+HoFehDV1uV7CqM/Ju1qk+q+sXkk9WpkQ8/dMdUAoOKZ4BE
	 1WrBcEWXtH6bA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sun, 15 Nov 2026 20:58:20 +0000
Subject: [PATCH 1/3] mm/memory: remove racy huge PMD assertion from
 walk_to_pmd()
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
Message-Id: <20261115-huge-pfnmap-fault-races-v1-1-537605643f6f@kernel.org>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
 Roman Kisel <romank@linux.microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Naman Jain <namjain@linux.microsoft.com>, 
 Michael Kelley <mhklinux@outlook.com>
Cc: ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1634; i=ljs@kernel.org;
 h=from:subject:message-id; bh=thuYM+ra89Xe+thgF7+RwlppoUyXwhIzMtQWcpO6kLg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJ+yTqJv/r0hfu0/9+HsxgMt5kf+MRadqeo5bl7Ylamz
 yO5JZ+5O0pZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRLZMZGRrkfHaIz+9aJNFV
 +O9cePA58WabQwH1Xb55J6Uv1l7K+M/I8MNu2xO9BQxCPzIXON19sDigaKbytjf/r+xeUT1ZKyr
 jHQ8A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Eliav Farber <farbere@amazon.com>

walk_to_pmd() asserts that the PMD entry it returns is not huge, but does
so without holding the PMD lock, so the assertion is only valid if nothing
can concurrently install a huge PMD entry in the range.

This is not the case for a VMA whose driver implements both ->fault and
->huge_fault and which invokes vmf_insert_pfn() from the former.

The existence of prctl(PR_SET_THP_DISABLE) is problematic here, as it only
takes the mmap write lock and faults taken under the VMA lock are
unaffected by this.

This can result in two concurrent threads faulting the same thing
disagreeing as to whether to attempt a huge fault and thus ->fault and
->huge_fault running at the same time and triggering this assertion.

So just remove the assert.

Target the commit which introduced the first driver able to do this for the
fix - vfio-pci. DAX also mixes fault orders within a VMA, but serialises
them using its own mapping entry lock.

Link: https://lore.kernel.org/all/20261112051440.16140-2-farbere@amazon.com/
Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
Cc: stable@vger.kernel.org
Signed-off-by: Eliav Farber <farbere@amazon.com>
[ ljs: rewrote commit message ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3a20d64fd276..e03110906aa8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2384,7 +2384,6 @@ static pmd_t *walk_to_pmd(struct mm_struct *mm, unsigned long addr)
 	if (!pmd)
 		return NULL;
 
-	VM_BUG_ON(pmd_trans_huge(*pmd));
 	return pmd;
 }
 

-- 
2.56.1

