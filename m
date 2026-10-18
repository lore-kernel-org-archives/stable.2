Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2643D9DC9;
	Sun, 18 Oct 2026 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792326469; cv=none; b=IkMsraHbuWS4bINNZo9Vw+nFqSFdNf4CMLxh8T7kDIcOhUPfNd7dPu2T3Fe4wSkZYZn/gXh+NJ41hbd6nRfmWSOVvwNRW4YNMQYNdi5jxELjGRMmiTsbkfIubVK8X+XA+IwT+xmNfH1g6NeXYNR4V8ApnPZ69lGzI7/XQQyerVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792326469; c=relaxed/simple;
	bh=G3oRcAyqCWJLUPZrTXaemgw6ulU+3gWMQbCpSSN+rjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqCKgrKklzZRZ6yxM0mu770JmktIQzbmkvdCOupuuKELle4uVmop3+bVwu/kkcKK5xgDkIPoGEOhogpdboWBN9ksYDkdrvcHmzP/6W3c5Nhel+yHsSQTe2JbBfc9pLN33agNfluPm7nh+zNMiigLlyXO5YrjsDl5sEiTpk0rwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=kKTmP4PH; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="kKTmP4PH"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1792326465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwubdLAMCHJgPaLvh4kT6SepriqCMUENEcVtSCeajdM=;
	b=kKTmP4PHBl6CsmbdA2yRaFZ4+/bgvzMOj+4PdXDahnortKYSQAzKSJmZVGm5Q3DJcOjdJC
	yZ1D2fvx4+pDowUiGnqPod7Yr+dKrlqnDmHizuwaiRY9ZTRzLXf4IvBx61JbTB8juUOMuu
	acMvRY6mz/qfaVphD/2VcKDnILenN84=
To: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>,
	Michel Lespinasse <michel@lespinasse.org>,
	Jan Engelhardt <jengelh@inai.de>,
	sparclinux@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] sparc64: Start bottom-up mmap searches at mm->mmap_base
Date: Sun, 18 Oct 2026 14:27:32 +0200
Message-ID: <20261018122734.2594904-2-stian@itx.no>
In-Reply-To: <20261018122734.2594904-1-stian@itx.no>
References: <20261018122734.2594904-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_pick_mmap_layout() randomizes mm->mmap_base for the bottom-up
layout, which every 64-bit task uses, but arch_get_unmapped_area()
starts its search at TASK_UNMAPPED_BASE and never looks at it. Shared
libraries and anonymous mappings of 64-bit tasks therefore land at the
same address on every run; only the stack is randomized.

Before the conversion to vm_unmapped_area() the search started at
mm->free_area_cache, which binfmt_elf set to mm->mmap_base. Use
mm->mmap_base as the low limit again, as generic_get_unmapped_area()
does.

Fixes: bb64f55019c7 ("mm: use vm_unmapped_area() on sparc64 architecture")
Link: https://github.com/sparclinux/issues/issues/119
Cc: stable@vger.kernel.org
Tested-by: Jan Engelhardt <jengelh@inai.de>
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/kernel/sys_sparc_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index ecefcffcf7b10..087595fa43081 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -142,7 +142,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	}
 
 	info.length = len;
-	info.low_limit = TASK_UNMAPPED_BASE;
+	info.low_limit = mm->mmap_base;
 	info.high_limit = min(task_size, VA_EXCLUDE_START);
 	info.align_mask = get_align_mask(filp, flags);
 	if (!file_hugepage)
@@ -151,7 +151,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 
 	if ((addr & ~PAGE_MASK) && task_size > VA_EXCLUDE_END) {
 		VM_BUG_ON(addr != -ENOMEM);
-		info.low_limit = VA_EXCLUDE_END;
+		info.low_limit = max(mm->mmap_base, VA_EXCLUDE_END);
 		info.high_limit = task_size;
 		addr = vm_unmapped_area(&info);
 	}
-- 
2.43.0

