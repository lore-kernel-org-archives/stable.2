Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B13442FBC
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390834; cv=none; b=k9KU5JS4OGxvdTb8qbeLSOBWx1wQs+2tq9PMAT1EWXWbdZnUQwMWkFPcIebgedlU6Mw1/xiCw8lJyhhALW+KHmfiRjJLELTfaDqzp7iA8xxvSmB2U4DRE2GU789ScVCQdziNSbWLzX6qhOEOQRqA8jjc+GcHLmZa1kNBSoLgEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390834; c=relaxed/simple;
	bh=fkhO9HAymugVq4OmMKfG9p3rUYCS/g1mLTnUWI2PGI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMkkwgXgMHCTSy3jUm3hgGclAzmRPcnljy5pJc+E8U/cKCKNaUbpOfmBQ8JwfleWUUZ8cJmCZA2fBynA2DLN3HOHyQffgJTZWARcA5R8i1unLS8joTcBv9L2ay0AmmH26pU8ubNZf/LrRgWAugpDce56vR3RmqVUZEM+RxIOEb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwWxG+ev; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwWxG+ev"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1712a04ddaso354575666b.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390816; x=1786995616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NFDzrFtlZRT9MfM2jyoJYH75f+Nc89HfWr6+v0kWxgs=;
        b=IwWxG+ev8YDZEsCEDXJBnR5/l6cz4mbv74B/iq98c3ZcAuoiP00/PA5BOLg7BQn4Tn
         qPddw/Ix2PaZt074WVfsmR2fksdDCQ8yDbirZxyVEw+i2RZA15DqL68YTEHJpeItuFul
         XH2dC6Yr69uIYQUP8KOKij21Z46aIzhTcM748+yOPmgc4vda1UIxZI5IxpmqQktDHOfG
         Gs/i5vO5xl4jy6byUqSXaHQFCtpUCrwjVGcxgpsf9xWNPbWfE+3LB03N6dWAAGZAnXh+
         CTUOg054XnOfwzaySoibLU90b6eH/P7esVC1EoOwOQCqg5Rl1lSbMVqJSgwnqsM964/G
         aJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390816; x=1786995616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NFDzrFtlZRT9MfM2jyoJYH75f+Nc89HfWr6+v0kWxgs=;
        b=aSn+AIMSamy00V6aRcF5UkGxcY5V8h5BlVsMgYx0G3c0S0qhCZJZp/6OSWN2ozRlEe
         rYYHbyW9MFBbk2ezXIES+I2dpx2vp3HNi9nSLoT8mgTKhVq9plD3Q7KP9SaS5LUx9ckA
         aryAwp5CUoD859zfFfsVRos1/2TUPtTQfwfzTRHVO/bP0RGhgvgR7+lXshUChCG4Cdl9
         LOXAFO5tvN6fHma3XZxkspo8a7DU2SJ8wWenFH7P2+xDNrXfRMvCML+s8WdLQT/uHFVt
         KNT3OB48dJfjjNB60PZPMYeFS7DtzZtJPEqoL0rRR349+IT+Y/dGv3fO+TaZxpUW2cho
         Mc9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqKjYwFVmy0WjKERLgRwfmYxbJPhK/sXEOGr1a0UNcOsyCjpP/qg+JB+FDvb27VQ6Yoqa0vsKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqy9tDn/5BlVWVybgz683yY2hDg0+tfgiJL32m5paZrMrnGWKf
	rMCOHCQaxknMoAP6RhJRvrMLnjZXO0qEzRhNLhzZiNZINIDG8mdF+XvY
X-Gm-Gg: AR+sD130ZSaCtQr+32b1VlwoDz9AbUMKXZ8y8F8BXsVWkP5RhsPVKktpFqXbFVFelbA
	NAEkWe2LxJNh2iwsDHwlIyiXDyw+Fc2Wj2eszZ9zb5LUC9KcXZaAbaDBb5MxJB17t5wxacYvdKT
	WIX2h9ZCgN2EUaTHrqJojsoY6a5cmaL+H08O5kI4+pa1K1SkgYNwXBh0Y5oRaVsyeDc9a+rHKso
	6A65APQvTucwR98xWPH9wbmwoJFdAtX8TLZnA1fssodTlgdU/piZpQDjYrqju3N13ye2WHK0wOJ
	NroWHLzfj7MsPySV7NRFyhrO0QMQrl91Sat/4QY+uyelisMiphEPyLLxqxEZcAt5j930tI3WiQP
	Hk93mcekGgxQdsa6SiYdZwn90ZoXWgU5j17bOC97DdGWpnFe3ZOz/A6+WQgGqC5hXNV4AT5KWCC
	njltY5aN+l5L1ffTziDwe+C1j8qW7G1sRzdB/WJMcMSbDL6mVUwW0/4vzEq8MFos9vT1aiD0ajB
	LwoaQzJalcUwsagCfILhaI9Yrxvl6c=
X-Received: by 2002:a17:907:7245:b0:c20:899:b8bc with SMTP id a640c23a62f3a-c20c672433dmr236286366b.6.1786390815810;
        Mon, 10 Aug 2026 12:40:15 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a29a84sm449928966b.3.2026.08.10.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:15 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de,
	mcree@orcon.net.nz,
	ink@unseen.parts,
	macro@orcam.me.uk,
	Magnus Lindholm <linmag7@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/7] alpha: fix the local TLB invalidate in flush_tlb_page()
Date: Mon, 10 Aug 2026 21:34:54 +0200
Message-ID: <20260810193902.3286353-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810193902.3286353-1-linmag7@gmail.com>
References: <20260810193902.3286353-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flush_tlb_page() invalidates the calling CPU itself before asking the
others, and gates that on current->active_mm. For a non-executable vma
that means a targeted tbi(2, addr), which acts on the context currently
loaded, so as in ipi_flush_tlb_page() it reaches nothing when only
active_mm names the mm, and nothing forces the old ASN to be retired
afterwards.

Test current->mm instead.

Reached in practice by folio_mkclean() from the writeback flusher kworker,
which has no mm of its own: about half the calls during writeback of a
shared mapping, and none at all on anonymous memory.

The caller-CPU omission in the same function is fixed in the next patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 1ad448105201..7856d23b3384 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -684,7 +684,8 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 
 	preempt_disable();
 
-	if (mm == current->active_mm) {
+	/* As in ipi_flush_tlb_page(): a targeted tbi() needs MM current.  */
+	if (mm == current->mm) {
 		flush_tlb_current_page(mm, vma, addr);
 		if (atomic_read(&mm->mm_users) <= 1) {
 			int cpu, this_cpu = smp_processor_id();
-- 
2.53.0

