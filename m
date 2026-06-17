Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C362E739F
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 04:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781669375; cv=none; b=rRq7lSiQaS1js5YMZzBO5cY6E/W2DjnAM0B3ODHBTi3+RnVBqgeR/jQM1B9u/L9yESbcBECFAvApdijIgyf42r2j9MS+sQq62LGL/zey4d16Adus9R1tkZBqdOBPQu2IyWFFgo9rmxGXkJ6/5ZfdeUlB5I6sHlnBI7bprudd1Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781669375; c=relaxed/simple;
	bh=/6xxecaOWZzTQ5/0GeYO82zesW0Cwb3wqf9P1ox/pdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRcobsYBvZ5hFK2apk6s66VQjH8NZRtyKkdprdl3sHhU1u58n0KrPRXyB0NhTeRA/sAKvzdoIvdDzGUVO79eVZbgnldmQXVG2VhdtUToMfar+Llids0H4BtTcRJz762mOdoCSdLqbJncVT/mRqFJG6vFg5pnFronhDFOUJm6W9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elkY8rZz; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elkY8rZz"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c85d4b4245aso3879403a12.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 21:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781669373; x=1782274173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XvRbhAm/yfnFmldgaCcQBZ+NPrwKkILyesuk0P8fZn4=;
        b=elkY8rZzIViHh2YCUa0YX2fmDhn/lWyz21ygYBUy6/rI4QwLYj8EfIlINXFM5vVgaZ
         CSFQgHCw+Gw2Rh8zKQQt/KOAFjPbOfNO/Nqmtk5bjz43wX2MWIqLlFzW50giwwV8hgfn
         aLUyRJeU71J3Or1dvRtIhgwq7gDacpUhq7pXDBUgDFMrtLs7FEp0wgQZeCa5Mz7+JVem
         ZRj8uFELaxqb/cdw3B3GsxNtfQFWFlKGki2VAtrkjBS9RVUDcDbMfuNP6y/qzEu2J+Rr
         ptqllIdMIyshLCuhD2AejrOz+ExPqtsm/6FJQ+nnD37+s0hPWJn3dV0+Q/zTxNr4BDxI
         4Jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781669373; x=1782274173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvRbhAm/yfnFmldgaCcQBZ+NPrwKkILyesuk0P8fZn4=;
        b=FgozvDJWYz8quO8MNrLdE7OZdAPI+pzw3N+l0w3p+PeQnzcWdIBU3xbzQHB7qFs2RD
         +eqc6WKbGwsRTfrGaYuLbBmfmRfueQFwds1v52G5Accdg2HctkllyugLy7bVKaU+vjzu
         aMJMfcSfc7WDSqA2TtpquK2iNb7VH/NHHuwAGbmXHn5rAo4xvGDNXEHBGIkyt/LVcBya
         nKv9bMWbnfAQZYZdmQdVZF7GwRgJ/7eGixBUVWSs9VVzPt1gG2IyLcA82MaL2Ta2npMC
         /8GGZXPv7AG/GRYLB5OuITnKM5Ujesb0Xnbs+yr+aR57KthBaxc9NVotuqhnmNMbzIt1
         gx8w==
X-Forwarded-Encrypted: i=1; AFNElJ+XEpoTAYdkcIy6rsLywmRUvVeshOvNMByfPxnxT0VnX7ncbW1a8WLUfkNAme4iK2orstsg/As=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55t/o9wB/Cyg+E2p9gUiLyLaItDualG3+3LFXq13hIKeqtugg
	vqE4bRyStIRx0b0icbvp6GGNr/t2mpYz9Z47xhCP4I8iFWE82ysEQFL6
X-Gm-Gg: Acq92OEkBgLp/QOu4SqE0k/3rTw0cYgge8Ijy8YKszI8H9n5REfflKlo7mXkKY51FX0
	oHUZQi7wdH/JVZvqecR5+zG4I7mAHFluMfEq2c/nX8rvr6dIIRPheIY3WNHoHLOK50iYwYgOCy+
	aYa0EolCn6E1HAALZmAuwTOxyUTaQObdM606P9RuN8skqvX2wrXCOA0fnaRoVb7+phgSO0nNIVi
	28BdfxF8VOqI6qZ43eMIZXEn9fz+JuArqvX2KIRs2FEJwUU1Nq3S7r9vWnlhmIlHtYtrsoRqq76
	aOaxxcUiZY8fpZmbaBkFt7jtN1GBI3y0+YCsSAKb+mOgv5GTDsEs2mKMrXrjT6BJqjyF1FMsyoU
	Ag38QuXfnUldxdw+2KV8nUgqBifX1W9Evc4JHpYgG72rkvlhdkxx1zAde1znNpIvV4R1BQT+r7U
	VoOLuURb+bn6YebsuSOlOqbqG3liq0+ZWbZeC6RGXT2T8yDWNVjo1CSD88w/+Mu2qM6qrf9KM2b
	A==
X-Received: by 2002:a05:6a20:a111:b0:3b4:85db:1bed with SMTP id adf61e73a8af0-3b8b7fee5e5mr2481246637.45.1781669373125;
        Tue, 16 Jun 2026 21:09:33 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b0112edsm13181161b3a.45.2026.06.16.21.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 21:09:32 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Zhong Wang <wangzhong.c0ss4ck@bytedance.com>,
	Xuanqing Shi <shixuanqing.11@bytedance.com>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] KVM: arm64: nv: Fix SPSR_EL2 restore in kvm_hyp_handle_mops()
Date: Wed, 17 Jun 2026 12:08:21 +0800
Message-ID: <20260617040820.2194831-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_hyp_handle_mops() resets the single-step state machine as part of
rewinding state for a MOPS exception by modifying vcpu_cpsr() and
writing the result directly into hardware.

In the case of nested virtualization, vcpu_cpsr() is a synthetic value
such that the rest of KVM can deal with vEL2 cleanly. That means the
value requires translation before being written into hardware, which is
unfortunately missing from the MOPS handler.

Fix it by directly modifying SPSR_EL2 and avoiding the synthetic state
altogether, which will be resynchronized on the next 'full' exit back
to KVM.

Fixes: 2de451a329cf ("KVM: arm64: Add handler for MOPS exceptions")
Reported-by: Zhong Wang <wangzhong.c0ss4ck@bytedance.com>
Reported-by: Xuanqing Shi <shixuanqing.11@bytedance.com>
Link: https://lore.kernel.org/all/ajE4lHQevXNHpl1M@Air.local/
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
- Reword the changelog (Oliver Upton).
- Modify the hardware SPSR_EL2 directly instead of translating the
  synthetic vcpu_cpsr(), per review (Oliver Upton).

 arch/arm64/kvm/hyp/include/hyp/switch.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index e9b36a3b27bbc..0995e34aa3c54 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -448,16 +448,19 @@ static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
 
 static inline bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
+	u64 spsr;
+
 	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
 	arm64_mops_reset_regs(vcpu_gp_regs(vcpu), vcpu->arch.fault.esr_el2);
 	write_sysreg_el2(*vcpu_pc(vcpu), SYS_ELR);
 
 	/*
 	 * Finish potential single step before executing the prologue
-	 * instruction.
+	 * instruction. Modify the hardware SPSR_EL2 directly, as vcpu_cpsr()
+	 * may hold a synthetic (vEL2) value for a guest hypervisor.
 	 */
-	*vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
-	write_sysreg_el2(*vcpu_cpsr(vcpu), SYS_SPSR);
+	spsr = read_sysreg_el2(SYS_SPSR);
+	write_sysreg_el2(spsr & ~DBG_SPSR_SS, SYS_SPSR);
 
 	return true;
 }
-- 
2.43.0

