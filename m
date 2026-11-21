Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795277015;
	b=PTlh9N5+MVvilkH2Nc9WGP9GQJwV3nLvDT2uxTvnZkHQ8yroomRlxnOZEe/PHqpwyhUt
	 NTAQg2Pt1qeIB9AAajFUogHpmUJ88rluAuR0wCKJkqSRGdpcns6TxJtukwm52jpDGDQXd
	 DzRpgFVw7RbH8dp4R2NYjjcGcrKWeZvMGZEc09kuDmvzfcu5tN/yS3xrMbluzeUm82xkl
	 nzH1jcbPT/fkTaGORkmpy8gIesFezaF/qfZyUv/hfQq4CiZT12wjKnP0jrYORY+loJaGd
	 Ao1TXKgNStXHcqNmP4eDbH8zzQQW1JteXzE/dXVJ7p41Mqk9P7jqy/sL4dKjrntWtjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795277015;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fjtW3tWTyT2H196OmI5oHGMlahZwHiXtTvIY2ftsbT4=;
	b=4lXcros3ed0naOoL0kTY6bGFSVyyCyP4GiA8kKILxXx/XwrqHHwn9oQg6Bp9bUnJ0r3S
	 PD8DXtRX5CF0euzyUIBufzoUrqHr9pJT3Q5hosPipjAiWGk6VTrtSjrMZyjllvT2Bz6vg
	 6wUsRyagrH8ARDWyKQop1A7har9RdQ3TFnMGiHHeLMfLSXHFSJiuIHr3dRis1yjL4YPBZ
	 RFVHTfwBHZvCutKm+lDcLiApKphlADKFClOrzPgAU044tYd1TXvf4vvAmQ0dFwtdhlcjJ
	 ZE60v3O4Hxe5nihjBTisjJz4FZT8QgeBsKYb2CpDv5wcSv9r0GKSPsyEByMWUqDSzwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AM5vyY5c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E4606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AM5vyY5c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7DE1F000C4;
	Sat, 21 Nov 2026 16:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795277015;
	bh=fjtW3tWTyT2H196OmI5oHGMlahZwHiXtTvIY2ftsbT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AM5vyY5cH1h8CNycg8kMNZ88A5BtN4ZaCO+c8FK8uYi89pGcHUiG+1K6TVsaUJ/r4
	 5vNhLxRNRqRcMLAyfSLSpHCbR48SqHTMOSwkUzk/UvMcRgpEVXNHqu0Y4L8C+VxUiQ
	 cUKYsBeiVKPtKMzCurl5U/+sY2ho0AKvFLn2lHK5as4BKL8m/OxsroGYnqZr20v/EP
	 UnOGMwsamBqTugTZChTFjwKxQ8o/K9mxnfTjLD/uneDFB16IUKeUzpOS2fVWD/lR9D
	 QO0W4+lGI20OOQDSjkp1Q9tBMeYFMvO71mcYD1C7Y5CpMMRhvw0PgbjWMYHYTZMRPk
	 EnPBajbz/NLiQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 21 Nov 2026 16:02:30 +0000
Subject: [PATCH 4/7] mm/vma: fix uncharge after failed stack relocation
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
Message-Id: <20261121-some-more-ai-fixes-v1-4-236e925d9b64@kernel.org>
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
In-Reply-To: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
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
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Chris Mason <mason@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2955; i=ljs@kernel.org;
 h=from:subject:message-id; bh=jvGf/uqdCmatWvRece4f6kn/YJqJuQMD/ohnWFCk+Y4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIZD2zn3pJ7OiDo14erch31uQuPv7HSSc7u3nX56s3o6
 J3betzlO0pZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRaSYMv5ieN35gtAu9cL/U
 8rPWvRuXAuqNnsxS3sJw8Z5N4vczB18zMhzW3qbz97v6SmUds4OzpL2eH5Dtqk3yXzwj4d6vmNu
 P1rMCAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Chris Mason <mason@kernel.org>

An execve() that fails to relocate its stack can underflow
vm_committed_as, and the commit limit of vm.overcommit_memory=2 then no
longer holds.

exit_mmap() uncharges vma_pages() of each VMA with VMA_ACCOUNT_BIT, so
the charge has to match the size of the VMA. relocate_vma_down() expands
the stack VMA by the relocation distance without a charge, and relies on
its vma_shrink() to make the two match again. But it returns with the
VMA still expanded if move_page_tables() can't allocate a page table,
for example at the memory cgroup limit, or if vma_shrink() fails:

    relocate_vma_down()             charged    vma_pages()
    ===================             =======    ===========
                                    L          L
    vma_expand()                    L          L + shift
    move_page_tables() fails
      return -ENOMEM

    exit_mmap()
      tear_down_vmas()
      vm_unacct_memory(L + shift)   -shift

On x86-64 with 4-level page tables, the distance is up to 16 GiB for a
64-bit program, and about 128 TiB for a 32-bit one.

Fix the issue by giving back the charge of the stack VMA where its
relocation fails, and excluding the VMA from what exit_mmap() uncharges.
The argument pages of the dying task are then outside the commit charge
until exit_mmap() frees them.

Fixes: b6a2fea39318 ("mm: variable length argument support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/vma_exec.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/vma_exec.c b/mm/vma_exec.c
index 586c52155942..84b98f1a201d 100644
--- a/mm/vma_exec.c
+++ b/mm/vma_exec.c
@@ -45,6 +45,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	struct vm_area_struct *next;
 	struct mmu_gather tlb;
 	PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
+	int err;
 
 	BUG_ON(new_start > new_end);
 
@@ -68,8 +69,10 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	 * process cleanup to remove whatever mess we made.
 	 */
 	pmc.for_stack = true;
-	if (length != move_page_tables(&pmc))
-		return -ENOMEM;
+	if (length != move_page_tables(&pmc)) {
+		err = -ENOMEM;
+		goto err_unacct;
+	}
 
 	tlb_gather_mmu(&tlb, mm);
 	next = vma_next(&vmi);
@@ -93,7 +96,20 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 
 	vma_prev(&vmi);
 	/* Shrink the vma to just the new range */
-	return vma_shrink(&vmi, vma, new_end);
+	err = vma_shrink(&vmi, vma, new_end);
+	if (err)
+		goto err_unacct;
+
+	return 0;
+
+err_unacct:
+	/*
+	 * The vma now spans more than was charged, so exit_mmap() must not
+	 * derive the uncharge from its size.
+	 */
+	vm_unacct_memory(length >> PAGE_SHIFT);
+	vma_clear_flags(vma, VMA_ACCOUNT_BIT);
+	return err;
 }
 
 /*

-- 
2.56.0

