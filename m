Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880976;
	b=glVBC7Uk5ec0BYz7b2mPmtiLJsJX/WwK3RBLEs4e8rfGu99aom3OHUcECOFpdGqij4lT
	 Mf28CVLW0Rg5JPWrF0urT77RcvxbIGQUCjF1O0cTD0dmw93CH8+VYVDLoyLXpsquW1GRk
	 TUgV8cNQXQdPNh+vVisaLO4qQOgHgszRP11RcMMa/oj8cEaWuN+G87bumqXPDLdzk+vyE
	 nakLfTbPq/c3haZTAO7vxVBvO/3RBokt2FRg2twTLn1KSk+T0sCmeF6LGglNdCLVgW2nb
	 8LFVhj/tOEpIiWnopcjCRkl5Tzgj5IHxGCNGj8Mf1zul17gg1lCqRpK97vJboYNdW2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880976;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xRhIOQP7ycZj3AHtGBmP58IXy1Gmj04WWtW7XPCSAgQ=;
	b=ZC1RD4/6WBH1EeLo391U6FaqzU14WHxfTUtrcGFul+CLGQ2LQ7wpb+pO1G9d3YvkKm0s
	 YDsNI3YOyMxfRYRJVVxqhctbTcnF+0q9d+Ivua4WTK6wgQHnoDQCv7m5J4Gx1TSqY+OtI
	 xBpC4bFrPIYndgwDPAw2U+dPHIbL3XvWs/q429ATSVxK7AQuuEvNpIIK4/q/fUkzlruOd
	 h458Ji4gWz5OJ9c00873HkOFLVOvCAY35e+AkURkRljuyzFMUyk3zt6QlkrgGrbb4jEtv
	 sLi/sH/3OCifzR1mD80eDURhPtiEUKHScn3tRX2SfkdMllPU6Uud5Cu+vSL10vawaMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5weJtFu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F2606A31B;
	Thu,  5 Nov 2026 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5weJtFu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78EF1F000C1;
	Thu,  5 Nov 2026 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793880975;
	bh=xRhIOQP7ycZj3AHtGBmP58IXy1Gmj04WWtW7XPCSAgQ=;
	h=From:Date:Subject:To:Cc;
	b=f5weJtFuhjm0h7M6W8Hs3aNXIE5onxXNv8UIxEfi7uSgLumD+rte7uMoF/tR2ql1T
	 B6dkQ81QmyzVVL8yHNY0PNGv+/MKrcJwZzWAQnuRYFJ5CyhvS57wEvLQLe317l9k3R
	 8j9fPrL+KoXA3M3aWvW5mDu1zcS9hp2TeB9sNYCHFn5XMcnwpP4burhK4FRIQkVLzX
	 kknT9PUK01t4IrFmAQz4ZOtbjEb2eqiXCk2C5HOF0Dbhk0654WgLJc6b0/Ildn5lyb
	 BZyOBIwKtew55wrN6f7J6UcfRB7e8wikcU+xl/KCyWd/qwC41UtqcTFNSHxhgY13Io
	 vNDdsNMRhogxg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 05 Nov 2026 13:16:05 +0100
Subject: [PATCH] mm/khugepaged: free unused page table when setting a huge
 PMD fails
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
Message-Id: <20261105-khugepaged_set_pmd-v1-1-cb79ab117199@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIRz7GoC/yXM0QqCMBSH8VeRc91gG7aiV4mQ5f7OU2RjR0UQ3
 72ll7+L71tJkBlCt2qljJmFv0OBOVXU9n6IUByKyWrrjNFn9e6niOQjQiMYm/QJymmvbXcxV7i
 aSpgyOl726f1xWKbnC+34P9G2/QBjC0WYdgAAAA==
X-Change-ID: 20261105-khugepaged_set_pmd-60a02f718e64
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=david@kernel.org;
 h=from:subject:message-id; bh=x6hsSULERkoUAEHmmThvU0TJPUEgXBgWcpU2wORz2/k=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLeFLfPDkzxz3YPy/rirqUeVJXEeGOG4PHz37dGq63hu
 6SmffdKRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABN5f5eR4YBr6qY7X+58/Lli
 UR+H9sfkqHcLeVvCJSJSxXJnT51wZDHDP8sqHcUfctFmqhW/Pvw+EHbd2Ox19OHm4xlJZi6nGcp
 uMAEA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

do_set_pmd() can allocate vmf.prealloc_pte on architectures that need a
deposited page table, such as PowerPC with the hash MMU. If the PMD is
no longer empty when it takes the PMD lock, it returns VM_FAULT_FALLBACK
without consuming that table.

Since collapse_pte_mapped_thp() uses mmap_read_lock(), a concurrent
userfaultfd operation can install a PTE table before taking the folio
lock. If that races with set_huge_pmd(), the unused preallocated table
is lost when its local vm_fault goes out of scope.

Free vmf.prealloc_pte on failure, as do_fault() already does. Successful
PMD installation consumes the table and clears the pointer.

Having to do this cleanup outside of do_set_pmd() is rather nasty, but
other callers depend on it already having been allocated. This needs a
cleanup at some point.

Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
This isn't super urgent, so it can wait for 7.5.
---
 mm/khugepaged.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8d9f05a39afb3..213c005fa8575 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1826,8 +1826,11 @@ static enum scan_result set_huge_pmd(struct vm_area_struct *vma, unsigned long a
 	}
 
 	vmf.pmd = pmdp;
-	if (do_set_pmd(&vmf, folio, page))
+	if (do_set_pmd(&vmf, folio, page)) {
+		if (vmf.prealloc_pte)
+			pte_free(mm, vmf.prealloc_pte);
 		return SCAN_FAIL;
+	}
 
 	folio_get(folio);
 	return SCAN_SUCCEED;

---

base-commit: 02f72aa35c5e7dff443c62cd9964686396c8b201

change-id: 20261105-khugepaged_set_pmd-60a02f718e64

--

Cheers,

David

