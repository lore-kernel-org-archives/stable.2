Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365006;
	b=BkUhKMCGHlbyxLVpodv3NzZPvCcYL8upp3vNnUDAgE9RAM0LBayyQrZ3zPb06XphJORq
	 vrj3O27rpIC5KhmHDFlFsp2i9DC18sCq3uJsJOY3NhaQlvTy0L50I+kn9fQUIrnKk/wx+
	 jrKAMLB6GQ1ldDKWCkaiwqUQDa5K/AMMXAtAwox79WvovZMEmdtyWFsQp0i6g3NzvQ/vL
	 CscZ8h3bARnWfuH/6uDIyLITcXcdFU5vvaqUYBKPmQRTB3AJBRZcizE3iZrijofpmyJej
	 pGkA0awsXa/nbUyubiZjeK8MYzVANyv4EBaIyMFcaZPl5HO5lERwH4gQ8bI03PhCfwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6ROIzQbGX1mehYrlfUqbnwc2d2aM6cHrY043etZKlJM=;
	b=w4e2YuCE5a5Vczs2ayTbvm+BkGbrsLT6JaEHpOq0mZKbwlfMarT8T/Zz93+MqL0pVTB9
	 Lf0HFP1lTbIv1Qx66BKUC7bdNaAzKKyHnjaptsbeRBi20Gz3wmM2ipQxjP3NvzkjspBZM
	 y+1u6wlYkq0/0O/th6hmUx6TmzLijIP1AV+qpvn5UFXDElpU1qSUsMazqVg9Uf4lmiUcw
	 OJ4NCyjAKNxFk31R8hF5LsPUVObUsp1NStjSDy4bXDjLrUpQYUQYas75yF6AywjkFlWPD
	 Qkvd38QCU576eQdXKZoivDyvAt/54T1Iwcj/ehtBtttJYsyuaHpjAOf2DhO9Qbf8cYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Go+t1pqy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0F606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Go+t1pqy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14031F0093C;
	Wed, 11 Nov 2026 02:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365006;
	bh=6ROIzQbGX1mehYrlfUqbnwc2d2aM6cHrY043etZKlJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Go+t1pqyHcAdGanqUHIbj5QP/GMD8a/11EEQc36P7N8FlNEqbTV+ujeNcUdrWgD+H
	 Dq6cUCkETLpe7FM0+GnPL/WHVnSsP0iDJMrHGdsPsJY/jJfdgMgCmNTvcWelO5DSUo
	 Vpbs8oP/H1ohLG8QAmTQcjnllpoXZadPeA9y1BVu2zSSp57UE6FzGCmmmy1w7Q5yHZ
	 ukBfyfLIhvFBxGp2abryR3rxNzGskpFf4UuYHtao4xrkQM9c+WfhLsnNOCadQpBRSq
	 EOwnwm2EKrZbBUvsxCiIcBjPvouZfKO7rJZHLEOvBi+brRF7vctjG8WeeE9FiK0+1S
	 X71BmgwrczvaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Durrant <pdurrant@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] KVM: pfncache: include page offset in uhva and use it consistently
Date: Tue, 10 Nov 2026 21:43:21 -0500
Message-ID: <20261111024039.676658-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111024039.676658-1-sashal@kernel.org>
References: <20261107052838-failed-6.6-eacdb76c5f04@kernel.org>
 <20261111024039.676658-1-sashal@kernel.org>
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

From: Paul Durrant <pdurrant@amazon.com>

[ Upstream commit 406c10962a4cbb1e04aa7993ea466db1a4533ae4 ]

Currently the pfncache page offset is sometimes determined using the gpa
and sometimes the khva, whilst the uhva is always page-aligned. After a
subsequent patch is applied the gpa will not always be valid so adjust
the code to include the page offset in the uhva and use it consistently
as the source of truth.

Also, where a page-aligned address is required, use PAGE_ALIGN_DOWN()
for clarity.

No functional change intended.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lore.kernel.org/r/20240215152916.1158-8-paul@xen.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: eacdb76c5f04 ("KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/pfncache.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 00e982e5c90d0..c779aa4c75b56 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -83,10 +83,10 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	if (!gpc->active)
 		return false;
 
-	if (offset_in_page(gpc->gpa) + len > PAGE_SIZE)
+	if (gpc->generation != slots->generation || kvm_is_error_hva(gpc->uhva))
 		return false;
 
-	if (gpc->generation != slots->generation || kvm_is_error_hva(gpc->uhva))
+	if (offset_in_page(gpc->uhva) + len > PAGE_SIZE)
 		return false;
 
 	if (!gpc->valid)
@@ -140,7 +140,7 @@ static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_s
 static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 {
 	/* Note, the new page offset may be different than the old! */
-	void *old_khva = gpc->khva - offset_in_page(gpc->khva);
+	void *old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
 	kvm_pfn_t new_pfn = KVM_PFN_ERR_FAULT;
 	void *new_khva = NULL;
 	unsigned long mmu_seq;
@@ -219,7 +219,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 
 	gpc->valid = true;
 	gpc->pfn = new_pfn;
-	gpc->khva = new_khva + offset_in_page(gpc->gpa);
+	gpc->khva = new_khva + offset_in_page(gpc->uhva);
 
 	/*
 	 * Put the reference to the _new_ pfn.  The pfn is now tracked by the
@@ -244,6 +244,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 	bool unmap_old = false;
 	unsigned long old_uhva;
 	kvm_pfn_t old_pfn;
+	bool hva_change = false;
 	void *old_khva;
 	int ret;
 
@@ -269,10 +270,10 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 	}
 
 	old_pfn = gpc->pfn;
-	old_khva = gpc->khva - offset_in_page(gpc->khva);
-	old_uhva = gpc->uhva;
+	old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
+	old_uhva = PAGE_ALIGN_DOWN(gpc->uhva);
 
-	/* If the userspace HVA is invalid, refresh that first */
+	/* Refresh the userspace HVA if necessary */
 	if (gpc->gpa != gpa || gpc->generation != slots->generation ||
 	    kvm_is_error_hva(gpc->uhva)) {
 		gfn_t gfn = gpa_to_gfn(gpa);
@@ -286,13 +287,25 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 			ret = -EFAULT;
 			goto out;
 		}
+
+		/*
+		 * Even if the GPA and/or the memslot generation changed, the
+		 * HVA may still be the same.
+		 */
+		if (gpc->uhva != old_uhva)
+			hva_change = true;
+	} else {
+		gpc->uhva = old_uhva;
 	}
 
+	/* Note: the offset must be correct before calling hva_to_pfn_retry() */
+	gpc->uhva += page_offset;
+
 	/*
 	 * If the userspace HVA changed or the PFN was already invalid,
 	 * drop the lock and do the HVA to PFN lookup again.
 	 */
-	if (!gpc->valid || old_uhva != gpc->uhva) {
+	if (!gpc->valid || hva_change) {
 		ret = hva_to_pfn_retry(gpc);
 	} else {
 		/*
-- 
2.53.0

