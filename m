Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857333F8891
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149776; cv=none; b=ZEbLF0hnbuIuAlC7DY+eb5rMVhSPUR5XiOziaZiJUtjVtyzKvY8XNLAfnGa9un+HAdST5GoiNVdFvw7a7NM84HXIfsStGLKnJR7FLBk/52hW9bofyTWxN9ZI9+38mW3QkQgCpkXbf2alHQXmLv9j5Bo0HSSPIRywqMlKYYYdCcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149776; c=relaxed/simple;
	bh=+04112kTHUQJIRhYvIFT4YS3J8Q0rIZz1/VifZBexGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOgw5AYtHuy91kG+wOMrLoy/S8N6JusfgGuJp66+ytJbKZFXG5OrpaDwKef+5nMzF4XizYuN3onmErcFn4O9W6ta50PXX9CwH8/hu0XeIOPPMAGHkLn20wy3zLM75WJanGxy2HFDtWljiWNdxYrFkuV/OJeIElZMHSbkFBHBWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9HepF9m; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9HepF9m"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f560398so73053866b.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 00:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790149772; x=1790754572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MsOK/pzJnBs2oTufvss/w9gLbBRsoXKUrgXrSYtYXXc=;
        b=Y9HepF9mxOxG9yiV88/yYmdUldYp1PlDXj/qvsRLG3veyWAHu5cEfDrL01wYQ11KXo
         n7OIVgsUhCkY+kDzqk7fH/DE8qtmA2krpPkfKzLi74vGoFZPfTc4VUTsmXhZU5iI6Wf9
         +p62Uhoav4Q42BS4mDtPY27OvwAtw+BAVATmt984oNU6Z71Q3N+IGR89wN1qkqZXT3pA
         FulV2XFhPmWTRq1CWsb5c7jYxgwkGHixGAmqgGmu2fWPFyezd1+Pja+Aoi1P18yVBt39
         AseBaIVSmcK+IfuJtlIyjFyPJ8ZhdCIVlw0/XSncuzmxij26WOQHilsTJmL6rYsm4Mpq
         3JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149772; x=1790754572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MsOK/pzJnBs2oTufvss/w9gLbBRsoXKUrgXrSYtYXXc=;
        b=oA55qDFqOTxAvuRW2G4O3ozI9nur5Fh5OzwZWheaYhCaB+g9ZTM5B5Fz/LoIlxrN1a
         SdQRtcRMaTdKPirHJAMvdEN6gQQDGEdAYQ1G8DK8qwgdZMATwRc7K5s0uJ1dC5AThfzO
         ihoqjzoUJ6KMOTtfWzdlctfZ/93tx9IkYzE/QLGtEH1rVBMrVjd/5ceEPf+elyRegm49
         +mB7W6uw+cgiM4z5okpapirbqTT/0SSYJ5iUfse4gBr9cqQoTiINj51sFdjNRzNOP7AA
         D+dMqXM+4Jm+3vRziMiyqpoFxDdOXadB/W0mGo/zmwwdX7WpTnBPJCCvE0ppJ1ccM8mQ
         Himw==
X-Forwarded-Encrypted: i=1; AKwUvBxDeWxouJNGlVTrwMLeLgXA4thclG95wloRVH3Wxq42b+EDLh4c6oHGYGXpMGPrFnoBw184MSk=@vger.kernel.org
X-Gm-Message-State: AFuF++mtQa+U2STdko5lm6a5zEDA7i7eNyurUfZzVHOGffN+bUBYV6zy
	DADBLVUPp+5bIjqx1q0qmdsKjv0TEkIxrwKx6XQJTWSZg3Qhn71G3394IiKWkYnZ
X-Gm-Gg: AYBFou3tMf8ux85Aqi/xcrgCakABWeferIjzQrshhCVcO4deMDrgvPW64ts4A52qmqq
	eh/2Yh2DBJqpT9aUQIVU4Ie50M+N1qdEYg0DJLyrevd5NDudqNkbCxf8sABggemJkCO401J6orH
	KZb/M1EJhSum7A3SSdsW8GC9Juyf+ctdPvoqdHa4n1UWqI8yNB5pjccdOpMm1HbJvCB/ZwG/YpM
	iG9l4TXbuPwNGv+NoSTQgO8qDxGzHurEh5T+ByeDuUx6kjohZXqxw1KMsCtq7NuH+2MNWSE1oPh
	To4e3BJgIV5524tAagbgsXg/lAGhFPq7PeCaCjyyW+8bhsSFeCtZ6NTAPVcVFy0JYTzz1EHWE6l
	Uztby5EA+YVI/dCrRbthFB05tysNQ/y1r0LEVcbCZavFg201WF15eMycnfJoppza7vJ1TyuIQ42
	3mRBreSOnt5/Nhi9agYDo4zL3UpU6jBDFhiAkW7dnAy+9BhTFW6oRw3t01r1mBR2Qls4oXRkPvw
	WKxty80KK702YtPPgYqOltNU0qVZ+G3PSGU3b2KuTDvgvuqjXU=
X-Received: by 2002:a17:907:94d4:b0:c26:19de:913a with SMTP id a640c23a62f3a-c2aae30e60emr130479766b.45.1790149771691;
        Wed, 23 Sep 2026 00:49:31 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f5asm64951366b.15.2026.09.23.00.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:49:31 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 3/7] alpha: fix the local TLB invalidate in flush_tlb_page()
Date: Wed, 23 Sep 2026 09:47:46 +0200
Message-ID: <20260923074903.862898-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923074903.862898-1-linmag7@gmail.com>
References: <20260923074903.862898-1-linmag7@gmail.com>
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

Test current->mm instead. The calling CPU then has no local invalidate
at all when the mm is only lazily borrowed; the next patch adds it.

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
2.43.0

