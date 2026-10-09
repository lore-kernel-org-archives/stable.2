Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28453D25CC
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579913; cv=none; b=Z0bqIpJNrHYZ6+lRMB2YChOUKvGIn1L3V6V5uVUbyQR7AdY9kg+v/szGQcR7Btlx+l5vSN0u5Vmn2BrZnJW3mlf8HMTtmmimBi7m7oJTGVSfsdJA5uv/POIpyOl1R8+wuWLtWXp3UBeGk3tVNgN/0onNnNAPLOyQAvxor6YE+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579913; c=relaxed/simple;
	bh=5toHAWoa9RZfe3NwUtwkxm431ePYX6KMOn7h4lFo+DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouwVazGbi8nwlF8zlaieJtDpJbiObd7GlfoNmQEcJbU9rPHaxZvWcN6tV5uVNYkx6E2S6V3lJMn6y01+DzWPyROLya7hfrxthBJwEAXUBAJvr2O0HTsPu9hdPeLdi4sZ5d3nrtTRUEZAzRhN9LnDNbpp6aEPCnUM08Fdi5tOC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqW4JEO0; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqW4JEO0"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a9bd4db6ccso176643a12.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791579907; x=1792184707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hkd0Kv48QkL3NWd7Acj/unZYgr+JarMkSbQu09jWeXs=;
        b=VqW4JEO0sYvBYL5t1v31+UvdOUtHAjfMKhui9mCQlPRT67NsJ9cpPlRxWegGkjDgyH
         AJhy9E/IrLkMf92vGWB7B0BcoMANC804Dq50Psuuch9UUk5fR8oAzK8WOGKjkxIWYBL+
         33fdnbBJ37VY3pScvSCOF/9qK9kFi+NtTx8y3oKqinC2ZQ/1rDapZE1LKtgyD12eSXLy
         oEw9y+nR3WnDwbtYh69EaYYrzbeHDh92ljjjhxz0xCLth62JvhqsbLu67ESZaKDKgjg3
         5ADd4rc9VPNLenH4NUSRkx+91VHAR6pL+xbthyVXnO2s0mVxb4FxYgoL/Khu3J9afzQR
         EVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791579907; x=1792184707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hkd0Kv48QkL3NWd7Acj/unZYgr+JarMkSbQu09jWeXs=;
        b=KBvNdNcMoLMFgrgT0cAy01W82ymxYc7a3UWhsaaD0kbj2F9eZObAv0r3D9HKzG5cSa
         fmrVqCihLvuTZqoR4YnASLkHwThOweto5evozozwxqdbZzqiHtLrYrnzzAwIes0l6TxW
         R28OUuZkpaZjyZ1+D2Qy2MZdU16c9BeldpQoyQhwCnmTUYVMXZPWuxyrzu/gufk0puwB
         qdOEKPUv94e2EAcsk2ktbaa6naIzcXbrDvzCMcS+ROVPwXkd4C7vpTpwZvJ4INsxtxl9
         SeRVobOMXvOZQr+0kQB0tYdZ5HVyQQpQFmyJAf/fODPjFqYjK2cWl9g5vEVZPPmQu0Bn
         Ai+g==
X-Forwarded-Encrypted: i=1; AKwUvByLpgTKp+ajx/NTxIxmBTjI5pUMsx+OpVCe3AAB/fM3f98d0v/Wkq14jwFJZh+RuT0TNU9BTRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7dw9nNkWOW2Hr96rGFGpabUwIhzC6V4GeaxYcD0Iv08QICMln
	qkQ2Q5GTej7Vp2JnaVWPrPHWEbvXmd5N9f5jnJ34H8h+y6gKyKtT5359
X-Gm-Gg: AYBFou2GzHEMOUXg365WlCr/vSBt7Epd48UxDfFwKcQHhJuWgfM8ktuS9eElwabv/C0
	+VI9Is4XqPGackc5edQ/UMQt1nFZj5WCBKwiRL6zhuz4FhCepg+RVrxagK4a6cLOTI4a2X/bz7q
	vUGom8yBKyJTAE+mxHi22SrhpfPNwmTYm2pNNx/dFFPaHO49kX53nn3pujPJnmixf7EVTpVFxt5
	ul4aKby4t2OZfwV3cb+1qR5jpYRVitkuyv/ufq2uI+BS9NTE6/SZbypBxxol00WkYOQbTiK2loq
	nCIkHGu+eifoowMjd8fyIwydAY0MnfWseQq4dMl/KQ3IlQPnEfZTl9Wq6LA7BX5q0CBB/jyzpZk
	wRWezZvCONItw+5cWA9y4rExWu9GVHEhwwdUHcDlChEtV3GU+szrmwUFCyQlsy7psa8HKEw+Wg7
	Xq07TjrL58iEZeBEMYEhVpg6i+7EIuQ7fURCClWojTT1Mw02mAG3SI4L7A0d7PxGODhOVXKLXJZ
	b40gOdZpi4JhBKn4NFM4IeSfZM2II29MriAXsGL
X-Received: by 2002:a17:907:2d21:b0:c2b:7686:4d7 with SMTP id a640c23a62f3a-c31a9ff6976mr305989166b.39.1791579906531;
        Fri, 09 Oct 2026 14:05:06 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9765d1asm142141266b.8.2026.10.09.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:05:06 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 5/8] alpha: fix the local TLB invalidate in flush_tlb_page()
Date: Fri,  9 Oct 2026 23:03:50 +0200
Message-ID: <20261009210449.971057-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009210449.971057-1-linmag7@gmail.com>
References: <20261009210449.971057-1-linmag7@gmail.com>
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
loaded and is only guaranteed to invalidate the intended translations
when the target mm's context is the loaded one. A lazy active_mm does
not establish that, so as in ipi_flush_tlb_page() the target mm's stale
translations can survive, and nothing forces the old ASN to be retired
afterwards.

Test current->mm instead. A lazy caller then takes the flush_tlb_other()
branch added by the previous patch, retiring its local context. Adding
that branch first preserves the local invalidate at every step, including
on EV7 where a targeted tbi() against a foreign ASN appeared to work.

Which callers reach here with a foreign mm depends on the configuration.
folio_mkclean(), from the writeback flusher kworker that has no mm of its
own, accounted for about half the calls during writeback of a shared
mapping and none at all on anonymous memory. Those counts were measured
with CONFIG_COMPACTION=n: with COMPACTION=y, asm/pgtable.h overrides
ptep_clear_flush() to call migrate_flush_tlb_page(), which rendezvouses
with every CPU and handles the context itself, so folio_mkclean() does
not reach this function.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Message-ID: <20260923074903.862898-4-linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index e4ba0aab8a66..a5a42ae4a7d8 100644
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
2.43.0

