Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361215;
	b=2wknTr5kT5XYjDqP4HDkQiln9xXjP5hJG99I04zKTK46BTSNCFt4XCxUpK+eCrO7njo2
	 D91MnJHs3dUqYJrOJdCeBhWf48+q2SkQeSPdllTX+epDvb2+J9hYCYlqSmyAv91L0jELY
	 dBkJ1Mu1B/c66uByuYzX76P18HDQnO15PJV/Cp4k3w/WPZZkQZZ3ffQ8ebhFZl6/xtndN
	 vHoT7/nu1xKWaXAAkA4dOeHoUfuL9q3axh5T0VZ5O2IHxEK+o4zBihMCnbpg2bDoWexVc
	 XsIEQ2LB23XrMPCeAlhJi+vHDdvKNx0SFNzHE340y/UDGAY95Ed8Ky/2eIJ45NLLCSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ruvz+vAepzPKRTBn1LAj+/ZsyRqQngmycGqMeNBfwOQ=;
	b=2Q3lMoSC493tncifG4CdJVGsqtRZjcMxxgN5Qf7VYqcFia9/DXCXdcX58xscpC7uCR5H
	 q44BaPWwSSgQgYJvt8vn+n7OfdIGNfEUSH5NsQScFjpynKLc5kA6CM3VmeKBL+fxtZr5d
	 jGjczksLWgsMgZNMNkpj9QRN/gsJdX8/De46tXev83Yy/VUv/qsWSElUEN1QDLnc/wW5+
	 DNKLXn/xK/1ZjtD2WrZZLK18IKDB181e/Y7jnbAKRH7b/P6p3YXcuzvhHyzeKLouNjYhb
	 Gbv5bURJngL//x5HLSfFAIr3cnbeziW6aXl+WgD2UEZTOR9hcTfcMO0wbjPzG0rDzFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MEoYVxn4;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB5606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41CB5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MEoYVxn4
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-89f639ba307so212054b3a.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793361215; x=1793966015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ruvz+vAepzPKRTBn1LAj+/ZsyRqQngmycGqMeNBfwOQ=;
        b=MEoYVxn4L5CaXO99YH+mCtmyBcNOFLpgYG8yCF/4jcoijyYfA6D2lw7Qj7dC02bl5D
         Nnx0FKoyG4VQQwM6BO6xJLYQ68jh/d/q3fB79HrAENGShZXG3Kr+V9J7YtK40N4iXcEZ
         nM0LRJ5qKNnCDCSdkrtNV3b//7VzBmK9MaEBLU8ohiW2A8vpEPp7CVw8tssW7dcHLAaL
         e2RppU66wgfbf43tU0czgSBqIGf0IWfLU2ahlG6ewWfVxneh61e+ahCoYb8drBbF9dLV
         Z7FZiagmVIBehM6aUaybRgj2ZqMI3tdZ+JWA4AFGfiNJfr5bVuDfGKmVgMytuQCe6OKd
         p2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361215; x=1793966015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ruvz+vAepzPKRTBn1LAj+/ZsyRqQngmycGqMeNBfwOQ=;
        b=SLN7c/ie2d55FiosqtEp72s5tfmv3gR9QZ4z5Sh0EIS6A+/z0HDxfk8SZyjRvkYvtP
         s/1MXfVgRw9vGGEk7iTc3aLdHGx3ccJyJIly2GhLeApKkkqaspNy1+h2jFqBo+xM4jJF
         6iXGqjP1AjhjVgvz418AQtaACOC9VQwbFVQ3JQAx04rUMZZMG9aWhyiBFDEHA9od8fm0
         s4mEph8VXjGVaFScrBmTthOhgPmIzX9khSosogxav+mcwuMjXwROyKIRlhU8tS3n+9Ly
         X+TkN5cmLXUYwUdd4f1ds02fT9SLlj+QdMBxuPXphrOhzaB5yuzuKFe7Y+sH6Ym+BQJY
         zu6w==
X-Forwarded-Encrypted: i=1; AKwUvBz/34IIV+9mxrrvofI/uT5rdSLTiMwgGFMYaPGQvO1pXzdxgriVCawW+RFivQvwz0wooPxFhGA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTPE2XRbN09WKQk1DUREHDSdUYr8WWZFalrmvbXrUZg5ST2oAy
	F4H3yYOLWZGPD9jY0qK3Z0wrzU5FFLR7cM78aeXmbb/V781lIFgqI4JUbmF8/6Z7UOY=
X-Gm-Gg: AYBFou2PypFWDW7iKxOcij9+1DL3cnsDQxBl0nTTYTfqsFyIcJHP/UlLoE4+EeOXbXv
	T68EqUa+eF4C2aiSvD5goK0dLL0Mk3+CVpJ39exJJ2sE0xHvM4E+hHF+fgJcF5CucKPrYfZx9v1
	leODZyz4FdV1Ky8FIKjRBLAQWq9OKt28CSxMf45wXJp8UKozM31mC3LYaaorDcSyAidn6DrOFv0
	jjWyrAPbCa4iWRyr8wMZFR1oPNZbhQp1/gEwzWAL3MklE7cq6r8hPI/DNYAdp82Cdjm+QgJU4Wu
	kv3PiGoSh/Zap0KwYtq6vt02Z/6ZvgWFgG3FV9k94CEEOY+tmut529neJS83RhiHopWaakGJRzu
	oNgUA4XQVeYuR/IV1uicA8yHEVLWLnhniNsJSufZ/XlW66p2/6EYSkIhd5q0wdJHzqYwfQfaxVE
	Vkiprglbo8C3NOtxyyyby9yZVuGFEggWFbgsaj/Qhn1bjKRW2pOQQdQnClxblSzePuYSTobbSCa
	hs0At+ngAccyjiwOUmwzW82LMDrTCNWjb/677rknbxCKzqYTDx6R0V7R2LfgEv39/k+a9hOr0Gk
	G3+Ug8eMg3ul6dU8XM3LYMf2Ct5A3uDwYB5KKmpE/dvfVFASuAo=
X-Received: by 2002:a05:6a00:3a21:b0:881:7ff5:606f with SMTP id d2e1a72fcca58-8a9bf71bbb0mr1772756b3a.43.1793361214559;
        Fri, 30 Oct 2026 04:53:34 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eff2684csm663223b3a.48.2026.10.30.04.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:53:33 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Pavithra <pavrampu@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] powerpc/mm: fix uninitialized ZONE_DEVICE struct pages with PMDs
Date: Fri, 30 Oct 2026 19:53:25 +0800
Message-ID: <20261030115326.1005755-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PowerPC radix vmemmap population can reuse an existing PMD mapping for
a device DAX range marked HVO-enabled. The reused mapping is ordinary:
its tail struct pages are not remapped to the shared tail page.

Leaving the section marked HVO-enabled makes memmap_init_zone_device()
treat the range as optimized and skip initializing real tail struct pages
that remain in use. This first triggers a zone mismatch warning, then
faults while initializing the pageblock flags:

  WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
  Call Trace:
    memmap_init_zone_device+0x164/0x430
    memremap_pages+0x43c/0x93c
    devm_memremap_pages+0x3c/0xa4
    dev_dax_probe+0x264/0x3d0
    dax_bus_probe+0x140/0x1c8

  BUG: Kernel NULL pointer dereference on read at 0x00001400
    __set_pfnblock_flags_mask.constprop.0+0x34/0x160
    memmap_init_zone_device+0x358/0x430

Without these diagnostics, the uninitialized metadata remains latent until
userspace accesses the device DAX range and triggers a later panic.

Mark the section non-HVO when reusing a PMD mapping so its state matches
the actual vmemmap layout and core ZONE_DEVICE code initializes all real
struct pages.

The Fixes target predates the section-based vmemmap optimization
infrastructure, so this patch cannot be applied directly to some older
kernels. Older kernels instead need to pass the vmemmap bounds to a
range-aware vmemmap_can_optimize() and reject optimization on PowerPC if
a PMD leaf overlaps the range. This reuses the existing mapping normally
and makes core ZONE_DEVICE code initialize all real tail entries.

Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
Cc: <stable@vger.kernel.org> # see patch description, needs a different fix for <= 7.3
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reported-by: Pavithra <pavrampu@linux.ibm.com>
Closes: https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Tested-by: Pavithra Prakash <pavrampu@linux.ibm.com>
---
v2:
- Rewrite the commit message.
- Describe the range-aware vmemmap_can_optimize() fix for older kernels
- Note that kernels through v7.3 require a different stable fix
  (suggested by Ritesh Harjani)
- Collect Tested-by from Pavithra Prakash
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 44868b62b14e..4f75f10ed68f 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1261,7 +1261,16 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			return -ENOMEM;
 
 		if (pmd_leaf(READ_ONCE(*pmd))) {
-			/* existing huge mapping. Skip the range */
+			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
+			struct mem_section *ms = __pfn_to_section(addr_pfn);
+
+			/*
+			 * Existing PMD mappings can cover the edges of a valid
+			 * HVO populate range. They are ordinary vmemmap mappings,
+			 * so the current section must not be treated as HVO-backed
+			 * when its struct pages are initialized later.
+			 */
+			section_set_compound_order(ms, 0);
 			next = pmd_addr_end(addr, end);
 			continue;
 		}

base-commit: d865f2677c44cb2171b833d6775cf692756fa8be
-- 
2.54.0

