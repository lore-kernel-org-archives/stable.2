Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365005;
	b=hzZ/byHQvu4zCCmMQA1gJYH4XE8rCmLycwAkTtcq2mY+dARRhXD7ukNAoaWSmDYNqOAP
	 NPxTmvVX6l0PDxhZ6Mwcs4+Sp6d23nXGdm7V3L+izHmYVbWlBQvp3juW0aPriCHNUO6iS
	 6TNHKRn1Z0IKenFsQnGYvjsaLGAGk3WKv1knAA7fBerRZjccmstu7P7tEYKxlASU9Nws0
	 c//VDAJp3rknZO034nvhDOVL2Ph0/aqRlzy/ML94l5mGgKGuGKP/AydPVPZS5wrkjyy65
	 fJmEceX5jYbGNvN1jJlcwxHlb78vouY0YfvVsEHkm2yuJGiLAM+CvvsN7AYK2VpDBDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Lr1RklU5dQ8cTBk5lxjxMgrNWW53BF9pgR3203hoNyA=;
	b=RIlHk3T1Y9JcqGjqHdFkzFLz2uRwVlRQl6GFjn6nvL3G3jjRzkxxeQSC/AZLzlif23Fo
	 66BFk1sYwdGUTONUg69jdaP0wooevMdSGCs/SealJ50jioZtaFLyxLs84uQHiGlM3mEkF
	 K56MIfC39gWgcpOlf+tWViZLFYtgiSrdpxWs3fHWu0d9IIFU52YNODkAOZ6e50G2bMvd2
	 fuHtFj37NAxmtGXdSm9qVGzQUHqQ/LKDPO70f+lAhNKkTg6E9NXmtQpNWB3q06tneTsqq
	 BM6c43wdGHVopHc1/doYpLpwTZ3J0v1GhYnRxNeo7Ty53qGbD/jKg80VlhnkeVsfQng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kiUjpJI4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C0606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kiUjpJI4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02FF1F00A00;
	Wed, 11 Nov 2026 02:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365005;
	bh=Lr1RklU5dQ8cTBk5lxjxMgrNWW53BF9pgR3203hoNyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kiUjpJI4guR7EcQDRfBljfNN03/jGv1K0fNlm7p6wBJSKzPLr0AvAvkUzWK3FWMSh
	 NTGHy2Hgecvv4HavZDQb7OPM+sU/vVneDa/zozI9A9BB4Zq/+hkq81cTmvrZlaq/kG
	 84FbZgq1Ht4UVknsP43Sm1R9RefGi0P9mMrUAzau5gipcwcdpiBM30A0VI35c2Np93
	 P0SSJFcTKeuPRIfVw9yQvt5OA7mi1ZO61d66STR12vBE1k0zz+Gr3nR8FVCD+jmKBC
	 O5dkdl1LWhEQe+aW4NZH9bLLs/mAnzu5uySBpUdGzfl+Aj4EwzlrcF1GYkqCczRjHN
	 nWgyizn5M9qDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Durrant <pdurrant@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] KVM: pfncache: stop open-coding offset_in_page()
Date: Tue, 10 Nov 2026 21:43:20 -0500
Message-ID: <20261111024039.676658-2-sashal@kernel.org>
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

[ Upstream commit 53e63e953e14a66b7d0d7e9c616cd602f3da9291 ]

Some code in pfncache uses offset_in_page() but in other places it is open-
coded. Use offset_in_page() consistently everywhere.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lore.kernel.org/r/20240215152916.1158-7-paul@xen.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: eacdb76c5f04 ("KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/pfncache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 2d6aba6778307..00e982e5c90d0 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -83,7 +83,7 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	if (!gpc->active)
 		return false;
 
-	if ((gpc->gpa & ~PAGE_MASK) + len > PAGE_SIZE)
+	if (offset_in_page(gpc->gpa) + len > PAGE_SIZE)
 		return false;
 
 	if (gpc->generation != slots->generation || kvm_is_error_hva(gpc->uhva))
@@ -219,7 +219,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 
 	gpc->valid = true;
 	gpc->pfn = new_pfn;
-	gpc->khva = new_khva + (gpc->gpa & ~PAGE_MASK);
+	gpc->khva = new_khva + offset_in_page(gpc->gpa);
 
 	/*
 	 * Put the reference to the _new_ pfn.  The pfn is now tracked by the
@@ -240,7 +240,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 			     unsigned long len)
 {
 	struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
-	unsigned long page_offset = gpa & ~PAGE_MASK;
+	unsigned long page_offset = offset_in_page(gpa);
 	bool unmap_old = false;
 	unsigned long old_uhva;
 	kvm_pfn_t old_pfn;
-- 
2.53.0

