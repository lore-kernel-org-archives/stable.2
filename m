Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99042BDC0B
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020739; cv=none; b=PYb/Zw32oGux2L+pDD0uPTZQLQWi4/TrOBO5+ZtIsfLoEPFwe+Yp+Ugcm0LHY5elcRLjMWLFCL+nhOunQVBl3v8YEp4yu58gXXymw9SPoaG/bqBkz+T+2wtffyrdcCfGkKjOmmRfx7Xk73nSKoec+CoGiWf+UzU+gcrflHQ6oW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020739; c=relaxed/simple;
	bh=lc+lpXKqnBUV2bkQjOM5id5uFQUQUeWwb4hNfmp/ibI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UEm8MJMtifzJo7jhMLHDHqySnXQP7GTurzcow00mKTP8DHOXjCDBY0okFsHgPfCLAttbIOgZYXBFAt3Kbe9xZFq1AYlpaIMYsNysMPQveSbD/up0TkJGR4sGbarDw+Cbcv6uyZOjQv32XXMDwx7C0hHImWL1P1X1GwF937L7qc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rnv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ngGqjfXT; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rnv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngGqjfXT"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso9877180eec.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792020737; x=1792625537; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1vyxJK5dhp3E9yMYQ+C02WBZZsNXKqmgC5RjWaB1Qsw=;
        b=ngGqjfXTQ2VncBuIsthPyp4G3nQQ+7qdI0jkutuk/EjSjotvQ/7gxuMYmKcYWkYfJY
         r0Pwb7Uzkx9Q+aPtfRkRPiWPAP/FxWp9gn+dHph5EClxn+i9bTVf2tVW0ivebrTylkjZ
         ge5x2PwsJwYuJLi/YnsNyI4+vm78USgtRufvb199Q8MH4hL8LOp79T1V2X6gtxR9EHB8
         osqp9tmoT7gX0njTtHp0z9+3ppOdLGkGNrRJqyNX2KcBVh3BknMrerW7GkBSH6+0oWbC
         E2sMYj7CB6N6IVM/OCYap0wXXNLPoPARgku05YJQ9mkEQX78Hbr5sn7TcReq1wmp68l7
         NLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020737; x=1792625537;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1vyxJK5dhp3E9yMYQ+C02WBZZsNXKqmgC5RjWaB1Qsw=;
        b=q5a6vgQkF3PNEtcYz3Ma1gM1eNAsmGbWM5D3XIM9AP9qCUWvs/SWfAVRfvNthBoVkV
         dLEB9heJDG0eLhb4wzzETMQ+EdAGfsqBYWTYQtC5yZvHw/Tl3ishe2vq03k5XXxrJrF/
         81Fn56Cbap/yR7BzYnIXPp4W6c5B4KbPwnPbECQQHzSwbmFd9xcwozJJ3dOyeWlAu2c8
         Nb8lfH5gKfic+dx1dZ9eFrTlhVgyLyDJemg/ZG9sVSH7wAcK7tYYNfG3anCszD4pWoyf
         sTWg4Ymxwn2JX0168vbpLo7+a8bi6C4pslhTn4YoMjgaOljual8kk9EnNbyiHqhIoWwT
         XBiA==
X-Forwarded-Encrypted: i=1; AKwUvBwplR09jgnuMK39MqSA3xFU3zWOtd+O3mhACUill59JZNZUP24CrGA7clxOVxtSPiUiOiJmH9U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPXp9mGZq95eC5iTziYXzqIyrkziTAucSG+Q7rj4RPJ1GurYnF
	8dOCad5yYVhGhbFIF4w4oY40NqVZ17ViANC0ffjMnbDaSXQ3Ug+OcisKw4nVNCkxrszEkA==
X-Received: from dybgo34.prod.google.com ([2002:a05:7301:25a2:b0:35a:12b0:9f72])
 (user=rnv job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fc0a:b0:351:7ec1:a92c
 with SMTP id 5a478bee46e88-3537e11c9c5mr24624253eec.28.1792020736275; Wed, 14
 Oct 2026 16:32:16 -0700 (PDT)
Date: Wed, 14 Oct 2026 16:30:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014233058.1410692-1-rnv@google.com>
Subject: [PATCH] mm/execmem: only free ROX cache vm_struct when fully unused
From: Arnav Kansal <rnv@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Arnav Kansal <rnv@google.com>, stable@vger.kernel.org, Rohan Kumar <rohakum@google.com>
Content-Type: text/plain; charset="UTF-8"

execmem_cache_clean() currently uses:

    IS_ALIGNED(size, PMD_SIZE) && IS_ALIGNED(mas.index, PMD_SIZE)

as a proxy to determine whether a free range in execmem_cache.free_areas
spans an entire unused vm_struct that can be returned to vmalloc.

This heuristic is broken in both directions:

1. Premature vfree() of multi-PMD vm_structs (Use-After-Free):
   When execmem_cache_populate_alloc() services a request larger than
   PMD_SIZE (for example, a module with > 6 MiB of .text),
   alloc_size = round_up(size, PMD_SIZE) creates a single multi-PMD
   vm_struct (e.g., 8 MiB) whose remaining tail space is handed out to
   subsequent module allocations (e.g., kvm.ko). When a module inside
   that vm_struct unloads and leaves a PMD_SIZE-aligned free sub-range
   (such as a 2 MiB or 4 MiB chunk at the start of the 8 MiB vm_struct),
   execmem_cache_clean() passes the IS_ALIGNED() check and calls
   vfree(area), which unmaps and frees the entire enclosing multi-PMD
   vm_struct while sibling modules are still live:

     BUG: unable to handle page fault for address: ffffffffc07dc030
     #PF: supervisor instruction fetch in kernel mode
     #PF: error_code(0x0010) - not-present page
     PGD 2c33067 P4D 2c33067 PUD 2c35067 PMD 0
     Oops: Oops: 0010 [#1] SMP NOPTI
     RIP: 0010:dummy_exit+0x0/0xfd0 [tailm]

2. Failure to reclaim fallback vm_structs:
   After commit 3bd4e0ac61b2 ("execmem: add fallback for failures in
   vmalloc(VM_ALLOW_HUGE_VMAP)") and commit 4afb85f5e359 ("mm: remove
   PMD alignment constraint in execmem_vmalloc()"), ROX cache vm_structs
   allocated via the base-page or exact-size fallback paths are only
   PAGE_SIZE-aligned in address and/or size, so they never satisfy the
   PMD_SIZE alignment check even when completely unused.

Because vmalloc allocations include a trailing guard page, separate
vm_struct allocations can never coalesce into a single contiguous entry
in execmem_cache.free_areas. Replace the PMD_SIZE alignment check with
an explicit check that the free range starts at vm->addr and spans the
entire get_vm_area_size(vm).

Fixes: 2e45474ab14f ("execmem: add support for cache of large ROX pages")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Rohan Kumar <rohakum@google.com>
Signed-off-by: Rohan Kumar <rohakum@google.com>
Signed-off-by: Arnav Kansal <rnv@google.com>
---
 mm/execmem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 74a178a87e75..3a1da0498fe2 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -166,11 +166,9 @@ static void execmem_cache_clean(struct work_struct *work)
 	mutex_lock(mutex);
 	mas_for_each(&mas, area, ULONG_MAX) {
 		size_t size = mas_range_len(&mas);
+		struct vm_struct *vm = find_vm_area(area);
 
-		if (IS_ALIGNED(size, PMD_SIZE) &&
-		    IS_ALIGNED(mas.index, PMD_SIZE)) {
-			struct vm_struct *vm = find_vm_area(area);
-
+		if (vm->addr == area && get_vm_area_size(vm) == size) {
 			execmem_set_direct_map_valid(vm, true);
 			mas_store_gfp(&mas, NULL, GFP_KERNEL);
 			vfree(area);
-- 
2.47.0
