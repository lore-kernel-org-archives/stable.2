Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737290;
	b=ZlgoHM73zKR3SAPTfdUe4xTo9D1c4ckdD0arifzfV2F2xWpTxn7XDAaWX0N0LdwX0WbZ
	 47+Gh1+Xc714W6BgyvvlD7h279VjM7XG0198BHIKZ9heaBx6Cy+pv3ujL7VT3MItgQOBD
	 6tH2+1j4+ZeAwyx6/X87EMoekPcEZzJ4fTfe4dqpQk/96UpvKqMPAVT/QmST0CpJfj/t0
	 2zrCWfzNAzeVvxfOrq3vT3V50sArGEUCxbHlD1EyKp79bvI1inOK9HwTQVMSDH0mcQE7x
	 qPw+OA44ToWLqeKD6XAoxg6jPtN1hwsr1coK38a53uhLRcP5GuFJZkbxRb8WreMCUAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=db1iEGMFzAz69F0Qd2NIWb14nn5dPV9u5Dz96tL5APM=;
	b=tZf86w2pYk1RBc5cMxmIUYwYLdwUW1h2wyXEy18dlw8mlITN1grVDxXPu2fIWYkTlLQr
	 zBHoM0WKfbpnhBAKe6t34sVo3d4yrjh+OMmtF7geohFMh9/d6wKRGbaoZT0VNvLk3npP4
	 vC3uO5SYXJLucz+inUl6McwyRJ9XoXRMLLk62dAFKsjA5DQJKXZgzlTxCJOlgLOEZoQpB
	 ucsUttkUnFX+QvwlMBqgZr2yeStvUMtfd2YlACGtyRjnaZoxBybELnGzxwEI78e2Bir5R
	 AQ3ji8n9h2M/dzzAgsZvZFodqG0XZ44DKbntf86BMzHwgd0JzHn+6kzY9pEyxPkL9LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PbMITDUr;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CA606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C8CA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PbMITDUr
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e977109392so2739015ad.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 23:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792737290; x=1793342090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=db1iEGMFzAz69F0Qd2NIWb14nn5dPV9u5Dz96tL5APM=;
        b=PbMITDUrlzuPYQZwWvu5gVWlVyF8/NJ2U6rjUZqOnSVO1PD+/VYs2jwpQlNtiJ8Mm/
         Gl24xS11LOM2CwGcm72oRKAAXD7YkeQHH8tQlRL4QCFiUu+Zjq33lHrHwUbFXwxeRps6
         yI0ah83afcEea0r6ms28obFi9Ic5SLy1pZuWck+mn9vAU5bmu3C1eO0tzxJU3jXPGSkI
         WMjp2nxUakD3/rMliPwdoDoFvUXftVvkTy75pYrjAmR7e2A5yqyxqk7/cb+E3g8+WPqq
         n0A7lF0Oh8SlcWop/Yu5U0ujD9AtytQ/ozzN2554hzgV35RmeCyPIv0s3aU+4nP7wdy7
         AnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792737290; x=1793342090;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=db1iEGMFzAz69F0Qd2NIWb14nn5dPV9u5Dz96tL5APM=;
        b=Y4HchztN6XJKQDc2tLCrkc603Zuxlewy4G9xAHyAGIDo7jAZIBxAgH6mh4qmRNyTTj
         FalFQ2ND66z5/zY5ZKq2xKEjbXQik52Zk3Ct6hPB8xFJcl7I/LR3rsof+NUgjOlmUPfi
         OuD/qZE1AjoeszyvP/wC34RN3lz/ui5kvW+UGLhFabmXiyDgSSZY2WMqxQkZMtHSd3r9
         jo3VJBVU5j52QDWhNzfpuwFj2x/1MnFQS7PU73Qudnbz53w7awTmUufO5M4Y7g/WQ8Kk
         dK5CacBWcA2Rs06ZPIgIfUfKnsJkX/ratY5dXr0Lwi/frbfzwaTGWEUCURQY1bhFqpwo
         4uTA==
X-Forwarded-Encrypted: i=1; AKwUvByUXXI+x3eEX8q9omL+nJ4Mqbs4WU0gjAxT8+9wzwvhOW7jiiJHTh04khuZfEqfPKaf+K7/e0A=@vger.kernel.org
X-Gm-Message-State: AFq9FYISQUTAg2WsCMOSZXRkJvCfCPxAQoPwr4TAw0GSD2TqLWZMC658
	Y67k+GhDBo5UQzXbomqz7OOOxfjUz3K6l3Bcwx3NdgBHTINNDqOnk/BIX9o9x6QSiUI=
X-Gm-Gg: AYBFou167Te6EVG9wQQmBQbWkotv0aBmpixgfVABFM29GZQ0MmB2L0TPeKBXfiLpC5x
	Px+Rf71iOV50Cx+uwpYOMZhAxPGbV5EDQt/4BfJOMbBV7RyDIOidA4b9gLAzrnmk3T6x0pwFDnr
	9rbYbvoqz+Tq5qgR9RUkcG6JTFxKBVKXjqMq+9p1IpH0UcxA+RFchI4yFCYi7SWS/5AqmbS3KdS
	R7874ZQjq6vQzIDLhb6SgeLiSsDsw/+Ddttd1pxn5caAFDhYe4ozwNckBanZH7nuemYyaR5oA5K
	8hL7j5vQWnlm+VRdkMCmZVSVV78PNZVMNm3ZVGtVcw+QghldT8rZGBle6JXKzwmVqk0GDI9DrFj
	tpRPs45V/5qefrz43zJILFVGGq1bq77de8AJQ1BFc2yaLfZXoKYvvbWzgbOa2ZZj08/UgfWETQG
	zCiiWEj2JJZ9JY3V9PmAAdhCefOWk32IThe2Bx2L5JVHYh1nPauDLgJW0gYuk+sh5hBAPp8be4B
	tr4q2SzhMbvzdwaYPKsqmwN69b1yrVFuPDZquI6jp0yvFxH/RBHwXzeKYKzuAinxFa7H1UId0wl
	nA==
X-Received: by 2002:a17:90b:3b44:b0:3ac:c005:cf07 with SMTP id 98e67ed59e1d1-3adce08329dmr1117038a91.42.1792737289490;
        Thu, 22 Oct 2026 23:34:49 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3add246f308sm575202a91.0.2026.10.22.23.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:34:48 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 2/4] riscv/mm: fix hotplug page-table destructor handling
Date: Fri, 23 Oct 2026 14:34:26 +0800
Message-ID: <20261023063428.3658761-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023063428.3658761-1-songmuchun@bytedance.com>
References: <20261023063428.3658761-1-songmuchun@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

RISC-V uses the same memory-hotplug teardown code for linear-map and
vmemmap page tables. Late linear-map allocations run page-table
constructors, while vmemmap and early allocations may not.

free_pte_table() unconditionally calls pagetable_dtor(), corrupting
NR_PAGETABLE accounting for constructor-free tables. free_pmd_table()
avoids that for vmemmap using is_vmemmap, but mapping type is not a
reliable proxy for constructor state. In particular, it becomes invalid
once runtime vmemmap tables use the normal pgalloc helpers.

Introduce free_pgtable_page() to select free_reserved_page() for reserved
pages and pagetable_free() otherwise. The latter runs the destructor only
when PageTable() is set, handling both constructor-backed and
constructor-free tables.

Fixes: c75a74f4ba19 ("riscv: mm: Add memory hotplugging support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v3:
- Collect Acked-by from David Hildenbrand
- Collect Reviewed-by from Björn Töpel and Kevin Brodsky

v2:
- Use pagetable_free() for non-reserved tables (suggested by David
  Hildenbrand)
- Simplify reserved-page handling
---
 arch/riscv/mm/init.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fb37b0b67efe..e111d25e18e1 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1485,10 +1485,17 @@ struct execmem_info __init *execmem_arch_setup(void)
 #endif /* CONFIG_EXECMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+static void __meminit free_pgtable_page(struct page *page)
+{
+	if (PageReserved(page))
+		free_reserved_page(page);
+	else
+		pagetable_free(page_ptdesc(page));
+}
+
 static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 {
 	struct page *page = pmd_page(*pmd);
-	struct ptdesc *ptdesc = page_ptdesc(page);
 	pte_t *pte;
 	int i;
 
@@ -1498,18 +1505,13 @@ static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 			return;
 	}
 
-	pagetable_dtor(ptdesc);
-	if (PageReserved(page))
-		free_reserved_page(page);
-	else
-		pagetable_free(ptdesc);
+	free_pgtable_page(page);
 	pmd_clear(pmd);
 }
 
-static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud, bool is_vmemmap)
+static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 {
 	struct page *page = pud_page(*pud);
-	struct ptdesc *ptdesc = page_ptdesc(page);
 	pmd_t *pmd;
 	int i;
 
@@ -1519,12 +1521,7 @@ static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud, bool is_vmemm
 			return;
 	}
 
-	if (!is_vmemmap)
-		pagetable_dtor(ptdesc);
-	if (PageReserved(page))
-		free_reserved_page(page);
-	else
-		pagetable_free(ptdesc);
+	free_pgtable_page(page);
 	pud_clear(pud);
 }
 
@@ -1644,7 +1641,7 @@ static void __meminit remove_pud_mapping(pud_t *pud_base, unsigned long addr, un
 		remove_pmd_mapping(pmd_base, addr, next, is_vmemmap, altmap);
 
 		if (pgtable_l4_enabled)
-			free_pmd_table(pmd_base, pudp, is_vmemmap);
+			free_pmd_table(pmd_base, pudp);
 	}
 }
 
-- 
2.54.0

