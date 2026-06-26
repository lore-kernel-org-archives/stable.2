Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A693F5BF3
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473224; cv=none; b=MR8YtjI3htEqkJgT9V+solRMQ5P7tPuPp7F0KQ2vurOpKZbg8d0RtwWZCvuXDznJgQgh9Fm6Mryz7CFTp9h0BMHbzqhd4D7zL+qm7wjTswTjFX2RsdmuZUyis1+09mhTlknOlC55CFrEwzvRD/81RlTePn020kEMZJUVCAcpn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473224; c=relaxed/simple;
	bh=WXl9yLoUo76hOiTJglihhCL7gCr4ibYOhM31n/ceHRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsuoN3MbCdPon8GE5ANIrTAxLnTSXzCPnLhaObzCO9lzvcn/xqp5mK9jYdv7fza+3+aQnxq2T7vF4wb65XsutO7y9TCpPM8qZJAkzuXLrPFAW2olMaYgUu4LYaJSJDvkTTrq5bT1HL1DEz3h4AgtiG0+8k4zSEMfLVNmPbMYqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4KwDw84; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ABwRMjnO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4KwDw84";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABwRMjnO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNsphw/JwWnRotYMp01A5Ccsyrc1xSlMCc+z3bGtV58=;
	b=G4KwDw84hCB0+3FEGWKK6MtdH9t1qfyPObQLkkwELVrbMJJltfRF33cD1E+gHKfTJa42eB
	4U/wHrvnaldRX58Y+zmiJwK6ObT3dph5LBAYQy6zl2EXi2pXJZN1vBf4iXnwpiURlWM4vX
	3COn5lpF7VsyhX7+JpHsUuUAVugJuDA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-2trKnzNrMm6wVYaLO3Ax5w-1; Fri, 26 Jun 2026 07:26:58 -0400
X-MC-Unique: 2trKnzNrMm6wVYaLO3Ax5w-1
X-Mimecast-MFC-AGG-ID: 2trKnzNrMm6wVYaLO3Ax5w_1782473217
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4924207e640so6511385e9.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473217; x=1783078017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNsphw/JwWnRotYMp01A5Ccsyrc1xSlMCc+z3bGtV58=;
        b=ABwRMjnONJ9O6ESb8b+BYczP0lpaLN1pdVfqJBxitDqlNlw5XCbatLcvbo9yQs83vo
         nWojnx635WNy8n01q77/BzHSEqZShh3FbGrdJhFOjxEOGnA+A9gw/45scI+sK4ytrIyz
         jPtE6/hLmw4FFi1SrX/TTRMmu8rjiBWvGXiuk44ERlxOekiiRBSOYpfxpomY76i0xWrZ
         wKJgJYLN+SdKpbr5pyfyL2auy1CHZyCb8q4sJRk1MD4ah1j6A4SnBDpoJufkWpctUUIH
         btZq/zVDV6hwfRrGPU/JOHfXXrNrSxdruOqML8oYtlCI/eqBGJYDv2iWJ1QnuVfcKRoQ
         ZYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473217; x=1783078017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNsphw/JwWnRotYMp01A5Ccsyrc1xSlMCc+z3bGtV58=;
        b=ob5d3tOQzZ+cSEUVcfFEN9//b9l7xNXUVl9m3hcj7rk3C/+E0Sw0ZDM/zTyIYIMgTl
         Y20k1dQJSzSEJ7fCaIvZqjUlYMoUnfMB1a0qNWFDWprqD1d5ZENYAval31P1E4me2HHv
         P4sdoLVH73Gkc/wxuW4r6s8bh37mnGQCaRVU36S9773ANKYxGVfyS0x8kexE1kbgzJVp
         PMGfAMPFkb7biL5QhJ+yztau2/y3LVBsjPIH40YkBg/0WUYedlezDCEOv05FuDi7FQ5v
         pA5m6JZMtWhxb+9JSxDMfhnsYoDCZj7S/kdOAsXsmxlGFBdnix8WaBW3nj2wop/g4bte
         zJ1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+O5mOTFRyMAsou9A5We3fqEavw92s1gc21PwarKGaj43uQVcikFtTEZ6VHtkrqfX/HZtjcvZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxoDjmKEGpOvUE/zVvNEiHYIMQE3CcapHlyZGFdJ0J9DxeYlCD
	/kw/tN/LnnrCvntMG2OMRJBB07wU9/XHr7E+bXTdtj3tsrPSw3MS9LAAPn88mVt/2GZRXV3cufJ
	nbntBbXzyzbrM8r/qHtMlnksk/I8yCdPt+TIpJWRc8GcbezELK97vVgRZkA==
X-Gm-Gg: AfdE7cnZa9KbfArwdc7SMZI2jgYMr6+3iM8dyLm+GIeQiVH27julxTEu+Ixy3NAyL7k
	ccW9w/75RGa9Gx2rBQcc9wdCIr8y3Yw4fhUpDSoOVcQ6VmUWriwHPwC9lQnKiTtAvssC0CmTwWE
	6xOuGcP2sIu2eP0gcLaxdysUMwolno7FYX9SzLWPGPpneQrY0iHS8twd0VTaNhiG4u9iJim4IZ7
	I1lmaPbFpVj2bdlgRr1TFVAPHqG63esvu4UAysvuxuH+NZTJekbVcJaHPOQ4faRZQFXD/kLwteM
	qzVNqX+sgfZNLoQCnDbDXGlN03fHJpV8btRCcogILhBtVh9kAnkSlWSL/w2JazbPWLcIrEi+d8p
	raS0su9cI0c2C/suTiMIxUUDjA1s8xZ/1VWHh1tO6iemL1W/tQZLiyC1UiDz+RQVPfwNmLo4flL
	pe1sEQuFpnXLhLzn8u
X-Received: by 2002:a05:600c:c4a3:b0:490:d354:bd00 with SMTP id 5b1f17b1804b1-4926fc8822cmr5708295e9.25.1782473216988;
        Fri, 26 Jun 2026 04:26:56 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a3:b0:490:d354:bd00 with SMTP id 5b1f17b1804b1-4926fc8822cmr5707695e9.25.1782473216411;
        Fri, 26 Jun 2026 04:26:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492692d5149sm72533015e9.9.2026.06.26.04.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 5.10.y 08/17] KVM: X86: Fix missed remote tlb flush in rmap_write_protect()
Date: Fri, 26 Jun 2026 13:26:25 +0200
Message-ID: <20260626112634.1778506-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112634.1778506-1-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <laijs@linux.alibaba.com>

commit f81602958c115fc7c87b985f71574042a20ff858 upstream.

When kvm->tlbs_dirty > 0, some rmaps might have been deleted
without flushing tlb remotely after kvm_sync_page().  If @gfn
was writable before and it's rmaps was deleted in kvm_sync_page(),
and if the tlb entry is still in a remote running VCPU,  the @gfn
is not safely protected.

To fix the problem, kvm_sync_page() does the remote flush when
needed to avoid the problem.

Fixes: a4ee1ca4a36e ("KVM: MMU: delay flush all tlbs on sync_page path")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20210918005636.3675-2-jiangshanlai@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index c6daeeff1d9c..1500fc877aec 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -1007,14 +1007,6 @@ static gpa_t FNAME(gva_to_gpa_nested)(struct kvm_vcpu *vcpu, gpa_t vaddr,
  * Using the cached information from sp->gfns is safe because:
  * - The spte has a reference to the struct page, so the pfn for a given gfn
  *   can't change unless all sptes pointing to it are nuked first.
- *
- * Note:
- *   We should flush all tlbs if spte is dropped even though guest is
- *   responsible for it. Since if we don't, kvm_mmu_notifier_invalidate_page
- *   and kvm_mmu_notifier_invalidate_range_start detect the mapping page isn't
- *   used by guest then tlbs are not flushed, so guest is allowed to access the
- *   freed pages.
- *   And we increase kvm->tlbs_dirty to delay tlbs flush in this case.
  */
 static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 {
@@ -1044,13 +1036,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 			return 0;
 
 		if (FNAME(prefetch_invalid_gpte)(vcpu, sp, &sp->spt[i], gpte)) {
-			/*
-			 * Update spte before increasing tlbs_dirty to make
-			 * sure no tlb flush is lost after spte is zapped; see
-			 * the comments in kvm_flush_remote_tlbs().
-			 */
-			smp_wmb();
-			vcpu->kvm->tlbs_dirty++;
+			set_spte_ret |= SET_SPTE_NEED_REMOTE_TLB_FLUSH;
 			continue;
 		}
 
@@ -1065,12 +1051,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 
 		if (gfn != sp->gfns[i]) {
 			drop_spte(vcpu->kvm, &sp->spt[i]);
-			/*
-			 * The same as above where we are doing
-			 * prefetch_invalid_gpte().
-			 */
-			smp_wmb();
-			vcpu->kvm->tlbs_dirty++;
+			set_spte_ret |= SET_SPTE_NEED_REMOTE_TLB_FLUSH;
 			continue;
 		}
 
-- 
2.54.0

