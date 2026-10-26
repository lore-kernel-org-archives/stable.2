Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057162;
	b=u9EdEO537boy1p2XyR+dXtJN1/UQ8VlG7gcnqA04Onfe78GynbjtnkwODTzLFCqYO4XD
	 pVJ9UFYdOGZxjTyqgC5wOKkE+SKFbCpdfxqW9JcJPdjR9gOk3sIU0jp6Hb5VU0r2J9Hyu
	 ExP5c6DHQB8IgynC3FpTwALP7jqwN8rh0fhpDHQDbT9yO+8Gk0KIRQWXzuJ6tR76Xz3ub
	 I10bzk/z87osIZikAQFlH+XN99ml5BRiKhNK8SL8TvTXy5o3Vg+AHroy0+/RcII760Scq
	 DebBh8X2AxYcjRdqSvIywUbDFWjJzTKwsLlRykT9jePDs3ZbEHsGAa2p+Za9uVsX6wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057162;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pd6OfqmpOChanyaBg9muCovOqLNLeBHLddsioXEL2d8=;
	b=s4PuE63GS3g/nprLOonPebVPmdaZBFElpgE9wJWBWt5mKo7+ykY0Lx0HbE2ABj7JOFDu
	 uvLxyVW7zxih/JKYvL/4/hX8jEJr6+b5eOwP0JPGlESdG1GjKNiUEYdz2S7NDsI7CnaR8
	 INVOegmLyNN01UJUIw1i+ijHEQyOtf48zPJq0rnktN/wwRdPsHdd1WxLgRqOjG8bU7z8l
	 Sng1evbK7Uow/Bc0aZ4EO1yXISa/0fqI67qHVPzRrbC2f67y7I1i5kUuqUSWpphUyxLui
	 R25ehg1GMJspVtt+hFgmOOiwz7u4P0XvZkekmA9z47Mmujnm9Ph159/nA4SmdcyqsZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OenGcW7s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298F606A322;
	Mon, 26 Oct 2026 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OenGcW7s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82AA1F01828;
	Mon, 26 Oct 2026 23:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057161;
	bh=pd6OfqmpOChanyaBg9muCovOqLNLeBHLddsioXEL2d8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OenGcW7sFoZGtv1gaXQpArBMVVnJOhx+l+0ykN84+ptoXAervg2MfMkka6s9HSVYt
	 tgcVqLUGEeLeqEoFYRQ9jzW6NyFKFNuyEYv4ZWrG0aKe85MpelQ3jS81Hv84bvTKJ/
	 jwAyd5xVDT1L5VfHo4kHUml4LJ4183wu2xwgQzh/EgzXIIFIajoE5bBmtTlNWt7JWp
	 gCu64lDRoEk2GNJoKmSfar44UgKDAIq/GF3c/idb4eUGQgJVmbOoDavw0xuvlJ+xx4
	 xw62M57+bReRfFtktYO4uLFMd7NCesCYhsca/BQIPApEutsj01S4PN9uTgwYKPFOjH
	 75BU22gCY+JxA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:46 +0100
Subject: [PATCH 26/46] mm/mmu_gather: fix flushing ranges with 4 GiB or
 larger
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
Message-Id: <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=david@kernel.org;
 h=from:subject:message-id; bh=vZJ6VSoQXMdFgpkoHzKAC0N6aJn0tSkxLvHpOmbVOwQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/2tcJn9u2pedVh2kaKzXubJ26ytvuerLI1/PZTd
 5aXS3U/dpSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRgnZGho98yTLy/Kv6Anbt
 tX6T+fSrkcfObflNKQvkEm0CRKusnzMyPN/TNOFSidoD7sC7deuShCurFjokHp1+fqsd09ZXLCf
 amQE=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

__tlb_adjust_range() takes the size of the range which has to be flushed
as an unsigned int. Its callers, tlb_flush_{pte,pmd,pud,p4d}_range(), get
and pass an unsigned long. Consequently, a range that is 4 GiB or larger
gets truncated, possibly to 0.

On arm64 with hugetlb, a 64k kernel can flush 16 GiB hugetlb PMDs, and a
16k kernel can flush 64 GiB PUDs through tlb_unshare_pmd_ptdesc(). So
at least these two scenarios are affected.

Fix it by flushing the proper range instead of the truncated one.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: b528e4b6405b ("mm/hugetlb: add tlb_remove_hugetlb_entry for handling hugetlb pages")
Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ david: use two-tab indent, simplify description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/asm-generic/tlb.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index fbe1114e9a443..3f4a180b48f3c 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -350,8 +350,7 @@ struct mmu_gather {
 void tlb_flush_mmu(struct mmu_gather *tlb);
 
 static inline void __tlb_adjust_range(struct mmu_gather *tlb,
-				      unsigned long address,
-				      unsigned int range_size)
+		unsigned long address, unsigned long range_size)
 {
 	tlb->start = min(tlb->start, address);
 	tlb->end = max(tlb->end, address + range_size);

-- 
2.43.0

