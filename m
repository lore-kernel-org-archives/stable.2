Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560617;
	b=q0Eg0M0BN5Y5Ci6q93daPwlkJWqyddzI+jd+/6MdFOpd8pwVThuxMQJ6hTrKHBsS5egj
	 nZQUqfc9aIs537uxx9QQHcH1SB6RE7SM0kkp+5/bpBkuMX3kZSf9UkhSUUYLYwxQ0odbN
	 wYRwZWpOYTtPO48ji88eZqh8G3+Kp0K7JdwQqg6pAbmxIVl5VHa1abYeb+0ttP/+HBAf3
	 vLqAtVwfkLCRYAS68WcTjZtfsdxKCOMeVS39GEsBLODXtnixZhxMV4HOxR13mcco/vnEp
	 wgqfGezVZdFIWvBrZ3ihS/vrr1R2NbtHxYhBsQPU1KmlAPjaGPXVPdjEibIh37BfznQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sVZKaVNqfINKaLZaT1Y8yFr4I/GfwQE92cCdjha8+PA=;
	b=QHqv711W2XH9nL5YlB56HiQpHFaQQOeh3ZB7H5u97eHEKLl/Z0xsR529JxtFwN/QwIA4
	 TarNODClprF/W9G23Lu8Xdx+g6Bz/W1ohHE1TQr660h/1DaQpn3DfmgS8fS97NsX7woXl
	 HHbjhkCpfmzscrGmn4wXIvO7/3nG1Z1qmbndVd32FiBTW8OQtMKoB7EruawBM8YvQO3k5
	 x81q8ETt/0DLZCw7UWSmviiFjCD0tYJSguW1p+KAwdsyTadeW+yDGXB4mTR09PnoFxTR6
	 nJqthSzO2Ir3C6H2PSDGQIJjhD4tTixLUlI24gkQZFhAE9UFhe+Pzz+LDeIi6OV7D1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=aashishsharma.net;
	spf=pass smtp.mailfrom=aashishsharma.net;
	dkim=pass header.d=aashishsharma.net header.i=@aashishsharma.net header.a=rsa-sha256 header.s=google header.b=aVUWoElJ;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F68606A681
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82F68606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aashishsharma.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.a=rsa-sha256 header.s=google header.b=aVUWoElJ
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso10879097eec.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aashishsharma.net; s=google; t=1795560615; x=1796165415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sVZKaVNqfINKaLZaT1Y8yFr4I/GfwQE92cCdjha8+PA=;
        b=aVUWoElJj78v3+cYk+/3s+L00/mDHFKaIVKFnOb6pGQHIErfQzMApeLyGSqPDwtQkh
         SLPcrFLfGNmLIb9e7Tm1/7uCNefNK+TmZHTzBMgno0zgvrOS15VmpaPouj9AD1sWI/hE
         BiQbuf0rQtwz/ReL3PcsZk2e4QznLqEGq+j9HiXz6fdbT/93iYNLPTUNbV+gk5ZqggJk
         b2KfCJOX/ayBdJS1BHxi+JDqRi8HANVwb/pjuhfk/4Rv89fUVrdmUOlpkHaNWloMRZC2
         /4KDbWaAcoyJiewntWezo+W6RLS6FMbIyelj6cIzbH4GCGw6sQFtPfUOYCXL2VNjyAcb
         c/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560615; x=1796165415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sVZKaVNqfINKaLZaT1Y8yFr4I/GfwQE92cCdjha8+PA=;
        b=K8wk5+HsquyJ8kBkpnGv7AbIp0qcJbNTft4rJD8ggsHNNFy3B1EQlwMvPVFwGfaAjy
         LC5wlCG72Ij9qeInxZ1g1s523AytXXCwRWgkt28p7YLwp+VOg/bhrtIHAlyq35O+EIPu
         yHHLqpH/VCe5nh36Msawc4jbbKH6Mqkv9t6j8aXC/o6teRGOddTCPM8bD2HelEqcYIAM
         9JdNzhbTAm76U0sW0idIJtNVH+241b4atnWYCXpTmH6GX0w5ZiWCYSj0gQPsI0NRGbPS
         NI9d92Gc3R62T3BYIBvu6z7iTRkqbFxuRoqZ2QoZtt5pHoQ1fNkX29gb/LicntmT50Ze
         Xe3g==
X-Forwarded-Encrypted: i=1; AL+hErHz3BmCj5iWnDIzEg7BqORS6yuaSukHGb550d45MkkgAFF/4lE01pgJw1HctygSQaNUbvC3pyA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9l9k9fK8Uh9bEukOu5eskRwsII44N1BNu8Bq3r+AFQSQf178av
	7pE4EQNnm1tRALJvACXA5bvtL0P/pIMpYiM0pFtrDvr5xHhMr1ncoXq/wgRmlMtiVZs=
X-Gm-Gg: AZFdTZcX9M5ASGh4pjUHuBxRZs9KHbdH/HwCyMF4bm1In0KekM/CEeLZWmpuB6P7fWJ
	7qsd7OIhQxRVVuGmeRGy0Jf90leJEbhc1cBKUP9idtTNLFHaA5RoXJiZDtdu5khT4TWRHYrsLJU
	hdIaMA54n29QopgVRLJGRd8D+bUNv01ALFAi95O1GDVs9tVvbKJ2BEwqwU42coRX+GDqKJhUd4o
	h2CmapEKB4EN/Kc8xKDgwHIPkLyF0RJ5mGFbRv8BKW/kjuZzIoJdM8svQ/wBwLzgHmlG7Ut93Yp
	+fHWUGM31gvRrKLzc6ZvfN/Mwa0yIY2EaE0MiE6fzqfEqo/A/q+50n8G1ejk8cu+u2BAX0CJpNG
	3L2hmUCHplUAYNNqJ9UoOSF4mpYuoD5CU2/IhtFd+QkRBegVmK3lf4FuoRTDxT+TWoKGDJYPt9y
	1QMD37LFZZmytVN5sVvNAebGB90fmJZveDw56fr0qvGwgORdcRKGZkJF4kSJdtSlicFQ3tPYuzA
	Bkw3muF6gS/CkkS5RUHUHVE0+TSGuGs7xR8pOR0WodWIY5Gn2ldnVTardMRE4BK6GgvAL7OS13z
	wCJ7u0mZqw7V3dx2ufecswxl+FM5tc7wY0DEDHuhPZSF8OqoKRe1xN4vV6SzdpBKp/2IrAZSxTu
	wCvDbQLhwMpphQao+aPT5l/ekkGhXpm7bbh9h2yw=
X-Received: by 2002:a05:7301:4284:b0:382:1aea:c21d with SMTP id 5a478bee46e88-3857191bcf7mr17176831eec.41.1795560615370;
        Tue, 24 Nov 2026 14:50:15 -0800 (PST)
Received: from shraash.sjc.corp.google.com ([2a00:79e0:2ebe:8:be5d:9202:acae:6527])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm58294406eec.11.2026.11.24.14.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 14:50:14 -0800 (PST)
From: Aashish Sharma <aashish@aashishsharma.net>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ricardo Koller <ricarkol@google.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Aashish Sharma <aashish@aashishsharma.net>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: arm64: Do not free split_page_cache in kvm_arch_flush_shadow_all()
Date: Tue, 24 Nov 2026 14:49:59 -0800
Message-ID: <20261124224959.685002-1-aashish@aashishsharma.net>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
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

kvm_arch_flush_shadow_all() is called from the MMU notifier ->release()
callback, which can run concurrently from __mmu_notifier_release() and
mmu_notifier_unregister(), as well as concurrently with VM ioctls
accessing split_page_cache under kvm->slots_lock. Calling
kvm_uninit_stage2_mmu() there invokes kvm_mmu_free_memory_cache()
without locking, which is not thread-safe and can double-free
split_page_cache.

Call kvm_free_stage2_pgd(&kvm->arch.mmu) directly instead.
kvm_arch_destroy_vm() already calls kvm_uninit_stage2_mmu() once after
mmu_notifier_unregister() completes and all VM references are gone
(see commit a3ca3bfd01b7 ("KVM: arm64: Destroy stage-2 page-table in
kvm_arch_destroy_vm()")).

Fixes: e7bf7a490c68 ("KVM: arm64: Split huge pages when dirty logging is enabled")
Cc: <stable@vger.kernel.org> # 6.6.x: a3ca3bfd01b7: KVM: arm64: Destroy stage-2 page-table in kvm_arch_destroy_vm()
Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: Aashish Sharma <aashish@aashishsharma.net>
---
 arch/arm64/kvm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 4d83281a7a28..2440ad9fed87 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1472,7 +1472,7 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
 		if (!WARN_ON(atomic_read(&mmu->refcnt)))
 			kvm_free_stage2_pgd(mmu);
 	}
-	kvm_uninit_stage2_mmu(kvm);
+	kvm_free_stage2_pgd(&kvm->arch.mmu);
 }
 
 /*

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1.831.g720f3f5937-goog

