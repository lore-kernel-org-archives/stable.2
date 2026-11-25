Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621760;
	b=df9GfuxyIW05jCEIiWfKqN2jJGnwbDi3y2fADUPUR8mbwoc7S5dvdHj8K9yLVJ9xwLYJ
	 iQjGH0jJp7XlcNSK4iDQmh6tv8z7zdYzCpXjxc5x/d9h4BCAaImn4F1nFykFZnnNNv6aF
	 77gL9RlGJQsJttXv6ThWCGzdJvF/0XGakiP9TY1EGikkv6KOf+AJlt7jBIIdx00Uc3uRH
	 rm8waHNZzLBv+9Q0HxdqSGzsYRhQS6Cn43tuXFHQb5BSVuJXUogFAGs1gm2kskC0nPvMG
	 tfybTlSakZiSd2uD3Z8S7xnxnfb2kuRmWVJNsOF8WVxgLLg1mDRv0Y97CKfSv7HEywQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621760;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sDx1EaCG9SAUlKmWDDkbKWTFEgseySI6tJV6lu+7Y9c=;
	b=4csDB/iKs8I2Z+39HIynXhQo4mYOAx2/MKPs9q7JQUbXkuf0VMU1VoPIzxJqzTOQjxGn
	 +ZDCbL5uBVoAuRXlhzlYuAVIghPc/JrU8n42HBuVrq1mw74xdeQrzh2Pczv1c8MK9zyZz
	 S/hx6kmtZHlvE4OWDv2CHXVDA8a+8IMtmkxgEVT6eYwL7R62YXE4/RJffz8XRMYELUGTB
	 9o2xyIS3SX4Y9g3B5m7A92k9wFZCzAaTl06aViX+32IgvKeLmkoa2q5b7L+mW+sExRPHb
	 B0HwAsDG2hfaWCDmRivWrNTErOUKsbwlRioF3M6czM6bLzOS9DBIc9eqJcY/gWlEZUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BI6lcMAJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730A606A32C;
	Wed, 25 Nov 2026 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BI6lcMAJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5671F000C4;
	Wed, 25 Nov 2026 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621760;
	bh=sDx1EaCG9SAUlKmWDDkbKWTFEgseySI6tJV6lu+7Y9c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BI6lcMAJK+z4+jOwnc56rOoUO8jBakLT/7PUogwG0V3yAY2G/K7WTUfHorsUEh67z
	 zc5x8PIDs/F3kpWCgchS7hG6/ga92X0LA8WvdWZtLMjoaZm+3113BD6Q0xmg1S0PvU
	 K6IgP2eSUZgP3jkr3gI/aj23MjDnMBMD/UseiUdatf0/Whpf4jeI6e9foZCEmR/pNp
	 rwCEHivjxYBwXbl5dM+rliS13kQGjNFhoOk8iIU9rDzkddTe8GVrP5z6juqv9Gyw1m
	 Rv4GlQqG7dEjJXJW89ooZhubnQggEw5C/fLJDPcSjwvTrIWkiSNExGLpaG8XgUc0SS
	 oLTY3dKadO8xw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 25 Nov 2026 15:48:50 +0000
Subject: [PATCH v3 2/4] mm/memory: remove racy huge PMD assertion from
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
Message-Id: <20261125-huge-pfnmap-fault-races-v3-2-bbc44489341b@kernel.org>
References: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
In-Reply-To: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
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
 "Gregory Price (Meta)" <gourry@gourry.net>, 
 "T.J. Mercier" <tjmercier@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1972; i=ljs@kernel.org;
 h=from:subject:message-id; bh=R1bkWj/29/9Nl0sxgBuwqKyQpRPzTms8rnWDR6qzfWc=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLZmTNr2OKuZ1QoZzslB1R/KXi5Kupy656bL5m+5rzaN
 Isj4a90RykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACbyX4PhD0/g/c8bDN6KbDg0
 r+0Yk4zh/IUdUx/3nd0qNmP2VHlrVgOGf2pXhNiFV61hONYidF9KzeF/aea1xb4bv4tGb/w8u/J
 iGwMA
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
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
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
2.56.1

