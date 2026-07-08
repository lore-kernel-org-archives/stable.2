Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EEC38D3EF
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551132; cv=none; b=Tgw/a//Yopxzfiq90wFUkvHH55LkUkekirFS5jjbM199ex83MkH10NaKVBkUroGQeBYfWztvLVszv9HuEkC/qLB/nFHxQSYm1PADWDh9NQqMinESw9glTKIdLDn6bJbmWMiX2cb8V74/sR3fYTQykJHL09cKOF//VNv8WYkOzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551132; c=relaxed/simple;
	bh=e1QBSxc/Yh7FOkNKih8p3yMQhq4Djozfjn76t2aVd98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bbWsvqtBbXQXgxxBeqwkwO2a1n8YXBB9dbJqG948vGu2WaDbgp8lohMgL93jfXc13NE08YutHLU5J+MKo+E6Of1VbtDG6NhT2GGNrz+unHvt5R0La8hWBpIYoiyh57XIiT6kXuqYSKfCFnc2Qtl3RV67iqd/iX3wccmWkfWM/W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TbCFlY9x; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbCFlY9x"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7e9ee20bde0so226315a34.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783551130; x=1784155930; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FPSpGPhYj+nCWbyX4YSYp8uqE5DTFDcur5HhjhyAr24=;
        b=TbCFlY9x5KKqpO86OvDBWIvJF0cwTgYkjO7x7ZqpMavFdPX3CM8fdjk7snNDlzIqQ6
         3Lfh/j8DmzxiHRwid30gR5tei/xtSmUPAvUZ7iL1absNLD45kAvIpSk7WwklxnV5Nr8n
         B/o6ym2SpOSMGo5Zx/IPlewV2V17WyhENUdzVzSfl6hzX7yfqEESAyUkBctXb1H5Cp5l
         430qgRWgqQrz24Vc9f+c/noIikr24VG1hnvcnPZts2AP4S9/Z+2WQYRVONH6IN/gdk+1
         x2RWdN46nJV5m4U8WmhFTNguGRTB5E6zY5IfUaSsAEY2d4Sox5/om6TmbNIU+Xdt+Sgs
         Xrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783551130; x=1784155930;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FPSpGPhYj+nCWbyX4YSYp8uqE5DTFDcur5HhjhyAr24=;
        b=SNUutBzIBe9bK2zDXLdb15p33CL3Yx3LP3P3PgiIYcb7j6rcF0ndV6kppR5rGpLY8y
         HcduIpK1521bxV5Csq7854TOGjjunC+e25zChetvh9uHxrakdYtk3O/Dd9Nb2mvTU/f6
         5GJ+oae7mB74uZ/EvJJ4ekWgIbvr4awe6ONwXlEsMcNiePfKhJ95IU+3p+qkTvjk16AQ
         Lbvuz2WNpwWfl648zgacdhDMWiYuPaukmfuiDifjhHvZDC1ImYyKR3TOymPo660NUQu/
         RFfAFsJgBoY73MDR0Or23IuXk42D01IkxDcPBQR1qJZX26I1Z4fDnQKpBK8zC4PlIwyF
         GftA==
X-Gm-Message-State: AOJu0YztyU4Es1/n6lBrIMJwjs7Ddc63o+I+8gEx2InNRid4dxl948tb
	6aYgI2P001xTCmziXqE6H9JPx+fuzME8fQt0emDIsJ5FcK4z67gPHp2Mi//ed57dADzvhqXt5x6
	1EWI9mPXdr+w4zkoZHN0J0LpZnjqWyihZ2TMq6+YoMLNyTYDJ44mRUFcgZ+dBEgPbhIRemTQhth
	8Q8xr6g8GiLXojLDcHNQfMaqo2H4ku2E+i7HKLIVNIcJzxvN07UwsTZyLlgGEH6mM=
X-Received: from iobp6-n1.prod.google.com ([2002:a05:6602:8686:10b0:9a8:30d:4dd8])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:202:b0:6a1:5acb:e954 with SMTP id 006d021491bc7-6a36d972ba9mr3178365eaf.19.1783551129511;
 Wed, 08 Jul 2026 15:52:09 -0700 (PDT)
Date: Wed,  8 Jul 2026 22:51:20 +0000
In-Reply-To: <20260708225124.4130846-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708225124.4130846-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708225124.4130846-3-coltonlewis@google.com>
Subject: [PATCH 6.6 v2 2/6] arm64: Treat HCR_EL2.E2H as RES1 when
 ID_AA64MMFR4_EL1.E2H0 is negative
From: Colton Lewis <coltonlewis@google.com>
To: stable@vger.kernel.org
Cc: oliver.upton@linux.dev, sashal@kernel.org, gregkh@linuxfoundation.org, 
	mizhang@google.com, catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, ahmed.genidi@arm.com, leo.yan@arm.com, 
	miguel.luis@oracle.com, dbrazdil@google.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 3944382fa6f22b54fd399632b1af92c28123979b ]

For CPUs that have ID_AA64MMFR4_EL1.E2H0 as negative, it is important
to avoid the boot path that sets HCR_EL2.E2H=0. Fortunately, we
already have this path to cope with fruity CPUs.

Tweak init_el2 to look at ID_AA64MMFR4_EL1.E2H0 first.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20240122181344.258974-8-maz@kernel.org
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kernel/head.S | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 6517bf2644a08..e32c8dd0b17a7 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -589,25 +589,32 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	mov_q	x1, INIT_SCTLR_EL1_MMU_OFF
 
 	/*
-	 * Fruity CPUs seem to have HCR_EL2.E2H set to RES1,
-	 * making it impossible to start in nVHE mode. Is that
-	 * compliant with the architecture? Absolutely not!
+	 * Compliant CPUs advertise their VHE-onlyness with
+	 * ID_AA64MMFR4_EL1.E2H0 < 0. HCR_EL2.E2H can be
+	 * RES1 in that case.
+	 *
+	 * Fruity CPUs seem to have HCR_EL2.E2H set to RES1, but
+	 * don't advertise it (they predate this relaxation).
 	 */
+	mrs_s	x0, SYS_ID_AA64MMFR4_EL1
+	ubfx	x0, x0, #ID_AA64MMFR4_EL1_E2H0_SHIFT, #ID_AA64MMFR4_EL1_E2H0_WIDTH
+	tbnz	x0, #(ID_AA64MMFR4_EL1_E2H0_SHIFT + ID_AA64MMFR4_EL1_E2H0_WIDTH - 1), 1f
+
 	mrs	x0, hcr_el2
 	and	x0, x0, #HCR_E2H
-	cbz	x0, 1f
-
+	cbz	x0, 2f
+1:
 	/* Set a sane SCTLR_EL1, the VHE way */
 	pre_disable_mmu_workaround
 	msr_s	SYS_SCTLR_EL12, x1
 	mov	x2, #BOOT_CPU_FLAG_E2H
-	b	2f
+	b	3f
 
-1:
+2:
 	pre_disable_mmu_workaround
 	msr	sctlr_el1, x1
 	mov	x2, xzr
-2:
+3:
 	__init_el2_nvhe_prepare_eret
 
 	mov	w0, #BOOT_CPU_MODE_EL2
-- 
2.55.0.795.g602f6c329a-goog

