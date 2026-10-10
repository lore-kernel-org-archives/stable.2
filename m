Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1949E124
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642357; cv=none; b=Dg+IvEKbVwIN0hCxcoiFLGC3U4UE9vIR5n1O7zpxUN0Pb3vq5jzwB737a57A/4WSdEzDLV43lP6j0W7QW40kMwotEefgdfNKovJae0LFL+K5AhnD3bs47rK8pJj01n50p0guSCAiRqkyeEzHiWzEX3ig563jIGdWTnjzM+Lie28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642357; c=relaxed/simple;
	bh=pE164w/gdv8iodYSvxBPesPyzC6AXZP8aQq7i2DjZoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7JBmEVSeJsn+mbyI2NZXupzg/mBUeX7FzP9olv2FtERX+4hDdVk84Lsn3lK7KQFKT8ltjJF+fpBA4oywqVjxhKUTWr6ihbvX4tn7MZio/0fizBLBbzl95MVFLaUqkdUJ1X2Pe06GcG9FufmWsEO6wGrjJGAMAptru9kX334U8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW8OSGhK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW8OSGhK"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so960679a12.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642354; x=1792247154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bQvHYHFcEQon4GczfaeGOgr1btQ5iYy/c5jwHC6xQwE=;
        b=aW8OSGhKnP2Y2wa4y2MTRy3kaXZIv9jBOWTw8cQ1b3ABhCcUVgrt+0YCDy5/nApIbK
         g4RbRZ9IS4YQ/QT5dWS9fzkxYFHgZ/NeN0CbdgW+y3kRAaRYoB+YI1KehQDlmiFmgh+X
         vmxoCOO2+1VG8L4pURSQ+/7MZ4Ifw9sMBdvcfqYX+we+R2kKE2OA2Zi69YyF8utEaFin
         mErEPPSziLkwjRDEDiBMUwobcD1zqvHr68Zwuu87mdYVPHD8CaMYdsuzyUz5fKnSMgFI
         8EzLAenjVy9wTCuoBAplwdMnTAaDuBSHmFi2sNQaNyDqdb/oAaeEt3Ztp+nP4Ceex5AZ
         fJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642354; x=1792247154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bQvHYHFcEQon4GczfaeGOgr1btQ5iYy/c5jwHC6xQwE=;
        b=Wevu6XrPDRAwPMroSnkxjht5zYcMDYgF6N/BGxe2yqwU4o7aqXyWyOvJ73zpvk4aiC
         nIDpzAIMR3PV+Nc/bNeT/ux7PqK9qcbCzwyYgyDjpo7MLYilZeGUqrO1vif7W6tLZy/X
         gdSfH9OP8OCSsvgtbsPDvFGmO7eOU1u5+ryiKQcr6XA9a1U9MT99NgAnVby53cmmmtgU
         WTg/Rxk/FV/A7klLYUwkFj+gLYF5LsBURBiuhgnsw6/3xw6KumOcxkIGVx5h1SP9lRAq
         khl/PNi0HLBahKbWWYLuNwjondHu8KP/ttLlE7ZWoiiOUb0lRlZvjng+BLW75/fipCRL
         Fx7A==
X-Forwarded-Encrypted: i=1; AKwUvBwHzOs8pKkHeK4eI9+Vas0nBEY+cEvpAzmN9QbAoVO2udgrCnulj5fhgJ4IuAvCtt5/GccPD4A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPcMtDldJU/TjUfvBZOcR3dR28ZNRzsxCe5g1THTc4K1NYa3z7
	yQh/zMdOSMGFEonDO/d8VhVApdskZA3xhGNyt4ItsQRBmUBB+zh5+MMm
X-Gm-Gg: AYBFou2N3f2ew5mhNc0q2WmxBuCQkJWjs64Z6a9Gb1EPTjPW7yZBSFaCAtGmhayiFer
	A2Ydjv3fZCzD8txd87WJT95sje2j5zAlLpFIxrzaNj9mFIEP8dgydm5xvvfFnZC23bwuyWQ4yD7
	q5f3/5oexjVEqZEO5NJia/jBcjsE2fhtak1UeTXUFoyy0SCmXCO6+nSzHGxAgvt7GIoe8ZepCGh
	fT5UF/eVjjbopT+TSrDVbLSTcWVPOU9EeptPZIgX7gweiUh6svLZ+l2+r9GoDEJdnu9UyR5/kU1
	e5eXUx6RvKlnoYrlkBowNXP2Dw/TJ5ulq/NxgJoGGYhuFoNpr5PsU0pXTM0QnHxsI8L5iS8sfsr
	hthyiSdBvS2j3ib5ENh/RkEKVfIdk/BPBxi3XHnyXAZtcmSi4l2kt2wmyaD7/dG8nOF/PmB6+YI
	mxYxnj3Z4JfzEWS7j8NFN82kRApc1tedt1NF+aejU9wVgHhm2FfwvqH3QwnIvEHijcjktM1ug2Q
	7Hg7cIsKYZRo1vDdkJD5ho1SU77g9B385qpf/P972ntrXKsKTw=
X-Received: by 2002:a05:6402:2498:b0:6ab:1e8:8b7e with SMTP id 4fb4d7f45d1cf-6b17c27bf79mr4614556a12.32.1791642354223;
        Sat, 10 Oct 2026 07:25:54 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b179dfff40sm2635586a12.34.2026.10.10.07.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:25:52 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v5 5/8] alpha: fix the local TLB invalidate in flush_tlb_page()
Date: Sat, 10 Oct 2026 16:24:31 +0200
Message-ID: <20261010142533.974797-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010142533.974797-1-linmag7@gmail.com>
References: <20261010142533.974797-1-linmag7@gmail.com>
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

