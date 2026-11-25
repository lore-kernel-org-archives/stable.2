Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645497;
	b=tRqNWz3ybWYmazWpkksgZmTVlpJNOC7EN9UiV5p8pAQyYgS5PMAnOLH9saxMz8tPjDCH
	 52Y8zSVN/bPMCyOOxiOvfEB/xTnY5DiyjkXujvP5TxR2wT048q3B1FoXHbEiCPSTgZyQP
	 eeeVsi3rNIzZARkfGEf6cX62OiauEEQy2kyN3PyM/0yJJA3UJHynPt0lYeJdywqcKrWsf
	 SGq6wj4K2ZLCpgVH7lWAb8FhwUo+Afq4TSN7Vw6NRGdnZOENuLplwCTcNUSN9G54pqvnl
	 PBjKvhR8glfIZ3NjjwGwfAF2A3v2Hek24f+DGpVZcoP3ncglSqy5vMnlzu9+EOJwpQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=StPN5XiJsDNFXskzUTREunGJkezS8LFSBeJOfH/7nFE=;
	b=A+rNAxT9BcYpjziWTz/wgRuEpO2Z8LS+GdjNqDlh55Od3pW+v65ojWPiq7Z5oDM+JaAO
	 xgMAW3oEdJXO8VbD41w3NWkKK8qQgSk63wM94fvnuwmgD5v+TJf6aDCPHmMn9Zm0AgVtD
	 xETGaQYb/2c/YBpV4quKxLbTvenp2VfQqwCjUYKajzE+c/WIma0OW0UzBk5vLvlgc+RjQ
	 ovc0Hu8Isp3wX49nH3latebj/jaTt+4hDNZXRqh21TzLZDUvJXBtiZXuhAAxLFC1w1Lup
	 uvc3ULC6Uw67qCgdXcHNvohyyO69GZNEG9VDt+ZkeS29GOfgMyhspwNzFWioWBLXISg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F+eElF2E;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3EA606A693
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D3EA606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F+eElF2E
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso10352292eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645495; x=1796250295; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=StPN5XiJsDNFXskzUTREunGJkezS8LFSBeJOfH/7nFE=;
        b=F+eElF2EclGDEmxecz7yQqtdiXMxmJTI3NZBJXwafwjYKooxYToDdgnbrendVLm/MO
         5l6qdkdZpEh729y5gvRuJNCgA/nbt9oyQmc67XHkuuhXRXGigh59fm2Rnjmq3Or+jd4m
         5SLuWydrhpvTA75Tz4n5LHKAo6h+OoW0zrR/AlF4Y0L1cO2IyEFIWvE2MFocifxElD5L
         +RlM7A9EOEePUTNsZJISgfOyAIDMmLO7DYeAny+99wUMtpKKZGrBQz753DjiVSbledBE
         1GAY8dcqMexRpM2JJb98gH9kiRk+SDO53gSbWASoiC54G65to9thZDrz5Gt8IEIVOw/i
         WomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645495; x=1796250295;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=StPN5XiJsDNFXskzUTREunGJkezS8LFSBeJOfH/7nFE=;
        b=TtKVY5gbQC/kb8SbM8ENdxwz7eYC6ljF9e6s/+W4c03M3Zpo70X9tmTtmeu7x4ixZk
         g2d0Q6NIztVA8uwDFwHOMfw2TlfBwFOqV0PfuT+qls4pKQYqINPgsBFtiT1Zq/+CjOcY
         tBchLXHWqY65YS6UsCIj8gQo854U8cmtTynfHxhZ0zEq0tTt2Qrra3noWoba5tNnOUeL
         SYlMseBLQZ1gvUxcjc0Iwjd4AlVSF52f4e0U6WvOV1OSunIEBf8+nEPuTnryY4GArXO/
         Z7fPZpfP5qGyiAydb+dVwdt2QoLnFhaz1ERoYFmN9QF3Jf/qFGR1kXcDwJHek1Ut1Ukj
         BqHQ==
X-Forwarded-Encrypted: i=1; AL+hErGalMIZs22Y5+NDEFMici0HqhC7V9/smIyBSe+fABLsIukIab8jFcFQ3rJAbYr9Q20saUC2XD0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GTrYmOvyioqfZPsXxuE1gyMiwGdC3zkPP3eLCBvSEFdxX3i88
	T0lMpvE0f/08ZzPKRd0dTJBuDvSdTkVJz7BYZN5OL2eO1p1Xl0eNWx+EKUa2pLcLn1J02I6W+9O
	DjQ==
X-Received: from dldz13-n2.prod.google.com ([2002:a05:701b:418d:20b0:1a7:3390:92b0])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1708:b0:1b2:3742:828e
 with SMTP id a92af1059eb24-1b5567b21c1mr17035858c88.3.1795645494904; Wed, 25
 Nov 2026 14:24:54 -0800 (PST)
Date: Wed, 25 Nov 2026 22:24:42 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222442.1443878-1-elkin@google.com>
Subject: [PATCH] iommu/vt-d: Initialize prq_complete before requesting PRQ IRQ
From: Elkin Cruz <elkin@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, irogers@google.com, 
	Elkin Cruz <elkin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In intel_iommu_enable_prq(), request_threaded_irq() is called before
init_completion(&iommu->prq_complete). The interrupt thread
prq_event_thread() invokes complete(&iommu->prq_complete) upon receiving
events. If an interrupt fires immediately upon registration or after
enabling PRQ in DMAR_PQA_REG, the thread can access an uninitialized
completion structure.

Move init_completion(&iommu->prq_complete) before requesting the IRQ.

Fixes: 66ac4db36f4c ("iommu/vt-d: Add page request draining support")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 drivers/iommu/intel/prq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index dddd3b51b657..7bf22ce7978d 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -318,6 +318,8 @@ int intel_iommu_enable_prq(struct intel_iommu *iommu)
 
 	snprintf(iommu->prq_name, sizeof(iommu->prq_name), "dmar%d-prq", iommu->seq_id);
 
+	init_completion(&iommu->prq_complete);
+
 	ret = request_threaded_irq(irq, NULL, prq_event_thread, IRQF_ONESHOT,
 				   iommu->prq_name, iommu);
 	if (ret) {
@@ -329,8 +331,6 @@ int intel_iommu_enable_prq(struct intel_iommu *iommu)
 	writeq(0ULL, iommu->reg + DMAR_PQT_REG);
 	writeq(virt_to_phys(iommu->prq) | PRQ_ORDER, iommu->reg + DMAR_PQA_REG);
 
-	init_completion(&iommu->prq_complete);
-
 	return 0;
 
 free_iopfq:
-- 
2.56.1.839.g22a8290db9-goog

