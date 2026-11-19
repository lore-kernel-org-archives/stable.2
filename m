Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094773;
	b=nIGnx6ZciF+Ow6iSTzlzuIMU8SYfiY+cxd0KhxFvAII1wG+YMAAEcjSkL77IBDmYpE/Z
	 8gtRPqkbM2Vln4f9SZAINQmFcQFeNu5MTnTpMzM8hBRKHqk8PoNARoPGAs7I7q85tw2dC
	 dJ7ULYsr12uPPTdEIaDIzyD4f8zjuqhpGD/+VPEUvf/j5PyKsHHUf6MODLtJuqlqBS6GY
	 TXD61li8MxOWgZJrk0C1a/UdCq3QsG0Kozv8xzrGGiIzFf+X0KLY9chyp1aVC+iyKcy+I
	 sfT6PdEWPPPjtlRVaJ0b7A8jSACTjJTOMGhGUtuipi/lVYEc8L50WQAxcQd6EQubYkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+KzwTxyJe1Er1zgZJn5wO+VPIKKM9MReJr20XBLcIEA=;
	b=d8iWevhUMLVU5twkDSW7amDPpY7lXAIITwzQXgSxNzLmzGIcRwD8bB4V/3Ls1tQBgbwP
	 N7V42HJT5OzLOVdLpBWHJ2IIi1ELSAOlzmPbx0gJDGIc9WgG98/24TXx3NQYI5SNffRfb
	 OYnANnuLzr05IUnNcFxYYsO9vrtpnnFAmWgJC60DMu+yrwbX9VcGVi17d/ZRPE8xkfKEx
	 8Ql/B6z6dFq3lDJMDKh/EGG0U81VI1MAiHDpLlwxG53AT9Ss/w9vL9OVOgts57ppY6RD9
	 4qCSN4SWX+1R9gBraTS6PU6BbZKMtRoT7mgaLl4/Sqi4m5FA9ZOP2G2a+pmtVyK0xLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=EsZCHp0D;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561F606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C561F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=EsZCHp0D
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-491971ac844so2222209f8f.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795094771; x=1795699571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+KzwTxyJe1Er1zgZJn5wO+VPIKKM9MReJr20XBLcIEA=;
        b=EsZCHp0DKodi6O1JJL5dmdEc5iDSiFJkrKh0WVRfGOt4oKQm0uO8wvZ9W7ELYCU9ll
         6p00AvTWk+MS8QibQPW2g9NYPZdYuCfROCap0c9kczlFJCng/ZryjwhRLu6JPBXNFvLK
         tVt5iKJNHHKkklhovOlwft1ELHdHhLH0uXsYJHX1vwsUCzhvVl+LVNJNdcSadriZekEV
         uYPeETDTmcG3spbqIHu5oS4fALkEfU3vndNa4sRDKahpU9+sCn8fWyXoTEj9/c2sVsIx
         t4WKxg0bXd0ZH30/PmetT0MNQyS8s4UZdb38En2D7UMBvHkyE3zs3hkwkExXVn6FDbip
         yN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795094771; x=1795699571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+KzwTxyJe1Er1zgZJn5wO+VPIKKM9MReJr20XBLcIEA=;
        b=jNkfIMBk9sHmseiZuQ5ZFu6B2O8m5IC1clNZbdahZ1M4g50wddj7ur+p9aBKx3TIZV
         ugO6hxJvSbl1cx3wQzVi7sN+ZltYvggW9q1IR5LGwbb1a8NxLM+xZoOLjS6Dk7OW+DvO
         2Z3+ZVQTxI5ZQ0OCfomcDmYrn7k2obqqZBIINKWtka7pp04nXdRJqg/iUL/AnxkRmrL9
         6RVNHU+dM8fQ+vEjh+J+vlmByBAkKs8npsLc8mzhhwxcLOvJBeKQD9Qiuy/VCstmxlZs
         IdPbeUvq1WXugQhXtdD6t5az+eGFXcm6Y0j4N1Z8UPDCl2yWnbrj6cIqZW8K2mzoxNkA
         T1Ww==
X-Forwarded-Encrypted: i=1; AL+hErEJJ8SQnTuzexNfpffk3ttbmqX/2jlpAXV2jlpaHZN+bpYd5XYZawq57Ca3fy08nS3z+Mzmjmg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TUtjZyNnHrsoazd8n8edR/4XDDesHEd/Y2fKwzqYbvjVZOrDd
	NDF0dhzVOfleClGE72WOjeEuclfWbPVBwRbhFTrpGAejHFxP4B0JteJRbIOf+cdvzDM=
X-Gm-Gg: AZFdTZcMMQ3l4OCNwN0MSbHoFg6lALbNcNbtbEA4yPQ8Bef1IUY76N7y+q6iZNoyadi
	nnVARJSzURs/aFPBS0fTZYmWobcHpfc+Pgf2JLTZrBrCiLXfg5k3rxJCZp39a15nUOeQcW+DAFp
	22eX+CVoSrYG8hc8J+IDPyVwC3PwrI2s7RonSChsbnVd0YJH1+QLgQ/O2wjE4PHkPr3CY/FPPgJ
	tX1nO6XwxF9oZ0z+qPrxZsja47+YCG50iPNabm1sP37vL4q50X7xPo5cNHr4mm0zx0ujcy0sYGu
	Wx3xj8RMYM0kUiTz2GlUEIYkoDbtGEMIc6Djdg1kPx5G3oKtaaM13XnwL69UDTD/2InFjiSTLxD
	pW8IZUrXluk9ociYvRd38/GTWlFTgf6bjMHqbgY6htspjAnEfOyondOqU/P50C9cbDS5x4Ee3bk
	wnoYfePWIRWv+k33GLpKcAjPmqBsIjAVfW8ZDA6xCaWjXqGLCRTBn1gWG2LGPwVu7H4I/6zM7P7
	JOudZT4gDRcMJue4iiS9RcktMzhGemzqHZuVMSlAeNd/wUv1CJF6H4DSiFSa1bnKKgkEtM3OLal
	W4sWywAUTdFFQE1I214=
X-Received: by 2002:a05:6000:4555:b0:4a4:7328:21f1 with SMTP id ffacd0b85a97d-4a63ac6be9fmr8858836f8f.24.1795094771068;
        Thu, 19 Nov 2026 05:26:11 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a6573bccb0sm10584515f8f.55.2026.11.19.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:26:10 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Thu, 19 Nov 2026 16:25:37 +0300
Subject: [PATCH v2 4/4] KVM: arm64: nv: Update the shadow MMU's VMID for AT
 emulation
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-nv-tcr2-v2-4-3deb1a6cdba8@pereq.eu>
References: <20261119-nv-tcr2-v2-0-3deb1a6cdba8@pereq.eu>
In-Reply-To: <20261119-nv-tcr2-v2-0-3deb1a6cdba8@pereq.eu>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jintack Lim <jintack.lim@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Dan Carpenter <dan@pereq.eu>, Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0

There is a missing kvm_arm_vmid_update() before the __load_stage2()
in __kvm_at_s1e01_fast().  The bug affects nested virtualization on
arm64.

In KVM a "stage 2" refers to the VM's page table mappings. The
__kvm_at_s1e01_fast() function emulates the AT instruction, which
translates a virtual address the way the MMU would and returns the
result.

Each stage 2 has a VMID, which the hardware uses to tag TLB and
walk-cache entries, so that one VM never uses another's entries.  There
are only 2^8 or 2^16 VMIDs, which is quite limited, so vmid.c hands
them out by generation.  When they run out, a rollover starts a new
generation and flushes the TLBs: the VMIDs active on a CPU at that
moment are kept, and every other VMID can be given to another VM.

The kvm_arm_vmid_update() function checks the VMID's generation, takes
a new VMID if it is from an old generation, and marks it as active on
this CPU.  Without this, the shadow MMU's VMID could be an old one that
now belongs to another VM, or a rollover on another CPU could hand it
to another VM while we are using it.  Either way the AT fills TLB entries
tagged with another VM's VMID.

To fix this, call kvm_arm_vmid_update() to update the VMID before loading
the shadow stage 2.  That marks it as active on the CPU.  Then at the end
of the function, undo that.  Restore the original VMID as active while
checking for and handling rollover.

Fixes: 477e89cabb14 ("KVM: arm64: nv: Add basic emulation of AT S1E{0,1}{R,W}")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v2: Unchanged
---
 arch/arm64/kvm/at.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index 9dfabd0586e2..5924cfa01bd4 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -1476,6 +1476,7 @@ static u64 __kvm_at_s1e01_fast(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 		}
 	}
 	write_sysreg_el1(vcpu_read_sys_reg(vcpu, SCTLR_EL1),	SYS_SCTLR);
+	kvm_arm_vmid_update(&mmu->vmid);
 	__load_stage2(mmu);
 
 skip_mmu_switch:
@@ -1523,8 +1524,11 @@ static u64 __kvm_at_s1e01_fast(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 
 	write_sysreg_hcr(HCR_HOST_VHE_FLAGS);
 
-	if (mmu_cs)
+	if (mmu_cs) {
+		kvm_arm_vmid_update(&vcpu->arch.hw_mmu->vmid);
+		config.vttbr = kvm_get_vttbr(vcpu->arch.hw_mmu);
 		__mmu_config_restore(&config);
+	}
 
 	return par;
 }

-- 
2.53.0

