Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98E18E025;
	Sat, 17 Oct 2026 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792231516; cv=none; b=tkD4dI6D9fcn09GS/fo/eNJhXxVpgRlGkgh1Qrpfgc74j8+uIWA4gqiuDf3vpkGrr4hLxYsPSsJMpytFOWoCU/5So1agz6f7YFX6+U5GvL5DeHL7IHNKNa1u4vm5pQ30YuZ69BbhI+9F5wKLvVeaQ1c0Nn0cjcSbIhErgFQ2cSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792231516; c=relaxed/simple;
	bh=91HBGVJ05AtflliIqD96I6sBfC5U5s/ZEcWdncabeZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m02VOdpAL1G498gFqWbmyYSr1NnsaDHHoXBW7zdF3mb1haXY0OMrkjXikdSUBsryHAeT9QFwsjDZq7f3dKhG+wIqFbdieKgp1Wb5wl8coJirrKUU7YbeabzyXiroD2jE8h54eWY2fwH9CDoTrL7x+VqoY/ya9rTtU0SPzI1ZmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=fkNO9mgm; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="fkNO9mgm"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1792231506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rT54bwXR0RkT/QOli/8iX9p1hf/Ll8/Tyy05zQ30IMw=;
	b=fkNO9mgm5puVGBeVviBnR8oced7WC6Sl5MiuLui8A8qLs7wXeGPAaU5R7EHrPhOefcJLOO
	rnhHPh3yLTbgOmOdjQgjpo2SFTO+8j/UO/A4LP3NVarvaQWxkMma42cnFjO003on18sZTu
	ssjOw6xQtQ8yFzM0is8KC2gG++H9yE0=
To: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>,
	Michel Lespinasse <michel@lespinasse.org>,
	sparclinux@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] sparc64: Start bottom-up mmap searches at mm->mmap_base
Date: Sat, 17 Oct 2026 12:04:50 +0200
Message-ID: <20261017100451.2266781-2-stian@itx.no>
In-Reply-To: <20261017100451.2266781-1-stian@itx.no>
References: <20261017100451.2266781-1-stian@itx.no>
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

