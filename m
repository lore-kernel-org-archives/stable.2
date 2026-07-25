Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8443290B9
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994032; cv=none; b=nIRKZht+zYYS8vQkWVvOfmau3OkQF7TD8I5xFw96Z83h2vJ85cepsNsKie3b7cDnqFUqOPUzsXRoDK13m9vMjgvW1SlqaqTlCEcCuAHeMZ/twP5ooojW6YN6SMj97YyMHpgwf1CPiRXQ6s0qMLTnI/Ca90+lSooe+oSQyLrxhBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994032; c=relaxed/simple;
	bh=RSNSQ0hf/1ip6FWJhT1UeiihfSgLDoIxgXqaDzmOAho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n+dKLcaiACHMkHQvG8LlGOc80BzaYlp1Qpmdkwku/pm2oc3lZAEjh0+vyeyrb50I9Uf723rDNSLddKr5RnDuiwUBEo0WxTIM4SJ2HtebXtOzdNuYYiG6FDa2xGx6Zdk2FBZJYBu/YYCKqXNJYyrFMWTE1C3K1px4o+pJecWh+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2oTrqQU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2oTrqQU"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-476a130c138so1394716f8f.0
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784994029; x=1785598829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KkXToa/E/TO7BNSgNTLBSgT6W89C2l7j03X9R0LWBpE=;
        b=N2oTrqQU+kDOdnDC2I3WCL5cILu5FDE1rj6DSiRERIjCZZXcOySFaldW0i3uk187ln
         tjHcs0zz4PoW6lWI4vbTfkeJmvaIz1Q2bqUe8LCKbbP9AuElWLel5NgIMjsDHBHPM8mo
         cr8bKHeVczk0VV3jb3iTiIUbp/mTlsEmdIrXeJGnz/MuNdSk25RpsHtCJ/k5SAbs8Nf4
         n4+UtqC0rCHCn3zbIJMhVpFJ1UoUowHByw1ihZKdlL43iFA6pwlxrPtF3xmPKJYJfsLf
         PvFyiri8bHEmupyDmwr7aoPHUgIKRkWQoD/sgNT/4sJHVB5gZT5InX8W9cruB+K0L32Q
         i+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784994029; x=1785598829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkXToa/E/TO7BNSgNTLBSgT6W89C2l7j03X9R0LWBpE=;
        b=cIKAVByUK8ZqfIijfTJ7wtdunDHKI7ORq13/vWflDJO1AjUlaekErhOCFdfxxtqp0Q
         xPSwftyqjcZE4uWL189df0YyriTZJAqlNO+JnauolKeWVfmkbW3eV23FviW7Xp36UMXX
         FuFY/XJ7sXIL3UZZsMVWQ0tTtZEYpFweSUfdqWmMLfAu61nzm7rjCGgFJzhjVTGhbSTq
         4e7UVFc8G/bGmy7LttBUICc8mmSEQZHp6XzyjTDbVNgk1HivHzGF9xoF9LnyiQxeAztM
         APsbkdqkfRJcmQtioWXe5mDZs0GSjc4Mdj6RKm7dzPZfX/TgSa8BnBZOZ925+fxesgVM
         avmA==
X-Forwarded-Encrypted: i=1; AHgh+RpGKrJlfSJsgKvd4QeC21G6zncLeNxiu4Ce/knh0h+LCPVA8Dqxu43VAplq1RtlLIbUeiDDtGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWY8kk2o1RFIcRr7/QW9o3c6KqqvFnknakJeJWRU39gtqHNIRE
	rKipfPurkLF9fZUhEfUAJdpHnO6fGae5hWrfmMzKjL+iu3X6b8xghMT9
X-Gm-Gg: AR+sD11bUO79B30dgjlJ1xN3xVWp0OcM/iJ7a0YU/kMjdpEr/aL5z603pn0Rxh8wMCw
	T4CzRgMapg8qZYzqEBDb2RZJMuLzasDvXI1hWmHON09D32WtZnRvJaZrjJa8TYEfb5qkM7Yareq
	i3q2OYW65feA4138LhpjiDyEkQVC7ygpxP9GITD4auSkLqHoAJ7a+OO3K7z+1puwagFl0GGnuSo
	rdDe0BNaDXfGhGGbtrvI7MmjGzByEnt89jr/oPGTmp7x6+0q9/Q1Lz+05W6LdydWbvJk0KuXGyS
	ULzh5o5p+RMVgSYdNdrBD7xjJh0ozz0aCtes23bHQlAJ4xzySAuzaje0rid4YPelzDZworW+bwD
	jdj9lDzFE6nstTpACj+6IwGqUuO1osku3RdD2441/yN1KS8oGl48LIGO/YpXSFuvQaBJ9tTQser
	sjsm4yM7oI/ftHgDdFFwIaMY5CSvba27B7Ojq8zF57o/6Zrryq1fU4zbE1kpebK69/+o0s9yuMJ
	uWQ6i1zipDs4yovhq8TzBjtfr+/IOUBrdLWbFArEeWVyKBkwPWrYmrlsnh6S4TnbGmu+J8BlJPJ
	LfVXk/a8ErnpTEoNMooC
X-Received: by 2002:a05:6000:1ac6:b0:47f:9557:8d77 with SMTP id ffacd0b85a97d-47f9fc82ceamr3194678f8f.10.1784994028285;
        Sat, 25 Jul 2026 08:40:28 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b344-be01-c902-8e3f-9491-60c2.310.pool.telefonica.de. [2a02:3100:b344:be01:c902:8e3f:9491:60c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85a2573csm32832468f8f.0.2026.07.25.08.40.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 08:40:27 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] KVM: arm64: GICv2: Bound the INTID in vgic_v2_deactivate()
Date: Sat, 25 Jul 2026 17:40:20 +0200
Message-Id: <20260725154020.37305-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vgic_v2_deactivate() passes the INTID from a trapped GICV_DIR write to
vgic_get_vcpu_irq() without checking it against the number of
implemented interrupts. An out-of-range INTID makes the lookup return
NULL and triggers WARN_ON_ONCE(!irq).

A guest using EOImode=1 can therefore raise a host warning, or panic a
host with panic_on_warn=1.

The GICv3 counterpart rejects INTIDs outside the configured SGI, PPI and
SPI range before performing the lookup. Add the same check to the GICv2
path.

Fixes: 255de897e7fb ("KVM: arm64: GICv2: Handle deactivation via GICV_DIR traps")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-v2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index cafa3cb32bda..42430c0fee07 100644
--- a/arch/arm64/kvm/vgic/vgic-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-v2.c
@@ -163,8 +163,12 @@ void vgic_v2_deactivate(struct kvm_vcpu *vcpu, u32 val)
 	cpuid = FIELD_GET(GENMASK_ULL(12, 10), val);
 	val &= ~GENMASK_ULL(12, 10);
 
-	/* We only deal with DIR when EOIMode==1 */
-	if (!(cpuif->vgic_vmcr & GICH_VMCR_EOI_MODE_MASK))
+	/*
+	 * We only deal with DIR when EOIMode==1, and only for SGI,
+	 * PPI or SPI.
+	 */
+	if (!(cpuif->vgic_vmcr & GICH_VMCR_EOI_MODE_MASK) ||
+	    val >= vcpu->kvm->arch.vgic.nr_spis + VGIC_NR_PRIVATE_IRQS)
 		return;
 
 	/* Make sure we're in the same context as LR handling */
-- 
2.39.5 (Apple Git-154)

