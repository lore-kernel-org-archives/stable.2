Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940319;
	b=E1yl3c4vwBWiXou5LsVbljtH9WcCotxK0GCLlOj66eLa/wUQPdh8zC+O7uLIqrnmjleA
	 fMZ4BPTBjd6+fMGpS8hU+QjxbUdSmaO7e4Co8HjFdACeUdbx1McHi7ptsgDeUMPjG2j+C
	 PwB0lxkP5fNBIe4XkKqnPLWwCP/4974GszObddSwfWS0gjVD/wROAajgAtrLNCTa6cNhk
	 OWQVWZ+qw625ao7fk+myfY/NVXUJekzwj2cCzf04hO/btA70S3AuCVI1EpbaXudzfxfzC
	 j8Kjlt6Lt9Xci+wJWa+88dVO9Pe9o5MAQgRDO9mBaoF0nmYOW/nliUn5KH5Z51fG2LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940319;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=RRbvW+En8y/uPg9IrKAVHkS4LhSJjr7+sUjmz3rl2DI=;
	b=cm6eBfbJwqZZfLsX0vdCz2vxOJOqaQjVNM8gWuuNNegWwiAkTVpF5r8G7iYou3Uuho+Z
	 Mk4gv3FTRkb7CCaJyDk6ktZPsVrlEv0zYoow/m9TFqofU1ktXDpZrUgnndfIOyLXz9zzL
	 61QMqEiGsX9Te+fAi/vUKLafD5gOn7sBA0QuiVGeqodlDx6VmFUp2b8mzM5aMy58mOfGu
	 f+MyZ0zSyPUB5zoI3xVY8I1ZJbtjVCUXj5RION2LZ+AkadqRuAUiIDSeb981r9ZApF35T
	 ydkz1UXgJaQjWT7moShxtCbcMehKdlInMDQ7IRZFIaFzroMrrwF9IufzMfPRfZ2OVNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAHiLR06;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFB6606A8A8;
	Tue, 17 Nov 2026 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAHiLR06
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D1F1F00936;
	Tue, 17 Nov 2026 18:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794940318;
	bh=RRbvW+En8y/uPg9IrKAVHkS4LhSJjr7+sUjmz3rl2DI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eAHiLR06tgjlgjgfkL4t2wBT3yuUbnJ8sClIljEQQtmABPTri5WuDQ6dIsOSllGR/
	 DX0dqdRvMK5S63Ih4qsevJk8BwsD4ymviM00JiP74qTb7pSLvKBEuzGiYp7+vcN2xr
	 Xdrc/yRk0Cg7E4oPtfrqMtPVwroL2O9swItWtL/VR7W4bDnuHoOecB8sonBLnM/+lV
	 SGwka9t+YU+ESE6bAI4LA331gsHrAMBo9yPOytX7TJSjkufVitjVVkLruVynWZq0r5
	 HS8ydMICLG9G/hQ14WcejdPt/in6OsNsZZMJI66WkdCFPBv5Uv25pc74nYcoQ4ZIM9
	 G3IHQvO6VDVyA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 17 Nov 2026 18:31:33 +0000
Subject: [PATCH v2 2/4] mm/memory: remove racy huge PMD assertion from
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
Message-Id: <20261117-huge-pfnmap-fault-races-v2-2-276007e73bcb@kernel.org>
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
In-Reply-To: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
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
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 "Gregory Price (Meta)" <gourry@gourry.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=ljs@kernel.org;
 h=from:subject:message-id; bh=WGAuQKhWD2k/xkBNSx2QPxX6QrPPQa9SF/mJgcd+rzQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLL+zO0OCLj8337z7LMs3MEdH786b/tTuGaB1M4u1glKt
 48el1h8t6OUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATubGG4b/vxYvKF5byHZH9
 VP7qFEdr0OxFr6bO8KvI4LrnNlOl4lcqw//qa/e5IhvTTbomrt6j/LpHJ1T6TU7HnirF2pP2/3f
 83McOAA==
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
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 67ee25215ca5..20b818bcdfbc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2384,7 +2384,6 @@ static int walk_to_pmd(struct mm_struct *mm, unsigned long addr, pmd_t **pmdp)
 	if (!pmd)
 		return -ENOMEM;
 
-	VM_BUG_ON(pmd_trans_huge(*pmd));
 	*pmdp = pmd;
 	return 0;
 }

-- 
2.56.0

