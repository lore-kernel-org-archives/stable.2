Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793516;
	b=UbCgpimx3OMTN/PPt43w2SSPFgw4ObICZU3d1u/VrsAbDEA4zJIbFHfmvDAzhSucC63d
	 RyRij/meg9iqeiopzwkQ+mihYZhUEn/bqlHi6M0RerfYKFyMcCZISUFMZUBt+ouMxc0si
	 EF7XOf/ei9BGn7S5uVIa4iINwp3fy1bSz98iGcHKQl3t/UaXRutoMby2srLX6V7jW8kk2
	 uJ2k9CSx+Fl6e1n574naEAS+WE7qEDM2D/X7Bu5FYlPxXIR4e0FzLgrxwJxPfahiZk84v
	 8x6jqKwWOh9w07/UFomLdRxDFlC1QJAFE/CtmaNMlD7+gsiQCgijBVG0C69gt4jeWFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=eJH1nUsnbixxIHEWvpIRBGng9yzgxFYLz8dPDZYEZSU=;
	b=we4Oaz5KBAqeThjOGj/CMj8UsfFfheiiu4//zNu7wjoO6qWYSSk4huYB72/VdljsuWAa
	 XXF7tded03hTvXWej4rUqXCAkyvUoCESf1jTapTRGQAM8DhjXo3mU/yeGBYaf3cCDozPe
	 DvM1OJwjYo3kHBPz0EKvDSSN4xIlhpk/soPsfIKSvy7USSe+2Y8lRrY/UF6JxXI0/jTu0
	 8B23c+0T8vTLT+LVabHZGYU9pmWXH/PqsiWMUlV22B0ikX4bpJkFm7taaD6C+yVbooLwK
	 azSjIUxFXd4yyUqdiRrgrIKZyV3nxthN/nIT6x5rOp53OkcSI5l4MX9L49lbOxkr2eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=Pbbt4oh7;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F1606A31F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 15:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF2F1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=Pbbt4oh7
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a9be758734so5208388f8f.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 07:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795793514; x=1796398314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eJH1nUsnbixxIHEWvpIRBGng9yzgxFYLz8dPDZYEZSU=;
        b=Pbbt4oh7brRPqcW/MWBvnSD2kmEOchOFxAoqQKBlYY2Y41+NcOD+tw+DSG1IxI1N9C
         IXNCzwri7OrcNibVVRO61Boh0eTyQ9V/x/9B/JCGhZVejpz8zETvoksQS9WgI9SGHxOi
         IvR8xxOLmDnxJtuU6+R/BAu/UzYULOQzn90ukJNzCSe8RmJRYoYbGBAmgwILTVXsaZgd
         8mLJk7b7KTcAXiOu6VN/h3r1BWx+V/XmW7Lfhyzp5QI5ZzEelKcFkpCLJc13koZ7GM65
         cMo6llN7sqbgURJMBZZTDD9Jrt9ml1kxC7BkWKZ5Nw97c43uT6roWzmEfpW6R0YJRNYz
         iSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795793514; x=1796398314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJH1nUsnbixxIHEWvpIRBGng9yzgxFYLz8dPDZYEZSU=;
        b=2HiybNytpeQJY1THcRboFl8PrwzTWPmRfiWvwZD3cRr3shTJ3gVsvc1S9WqYS4a2Rs
         cLMmBQoYC2nBIiSRoGTDTotg8K/Ay02HW0EgQXmKWbUJXd8IIqrKdGHDPpzfnOMfwdB8
         XljakAQpaWUTUcMt6vPnRhch4icZPIBfu+WsIiYnfZGxiyAbWASNORakhaSGe6az+0TV
         t8ST1sfjHPAkJKjuiIn329xIUJhcpRpvkNUH4j8Jm8BquXVHlej2MFevPuetXy/KfZV6
         yLP+Y5taAaT99hlCQDS1Sb+Flc9Krt3aW02RT5T1UNLX2l3+I1uGeyttuPIGq38GiJbI
         DWmQ==
X-Forwarded-Encrypted: i=1; AL+hErHFzgY4gAv8cxdtdLDQ9Ir6i/7sz3BQIR2RX1QjW8f2i9fX+dR8BO51Agkhi1nz3EjO6XfD15Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wbK7x4VjR8+FROJ+lwutruiESHO11DvSKhgO7AD5FgC9SEMqH
	g4eRYW5jCDepCplagOj1BneU7Ktr8AkRWedy9NcLd48Md+UzunjBm1WYTJ6TA4YO0BE=
X-Gm-Gg: AZFdTZfmfvCH6vD4kz1iTJ9MEDYiHHiNzUStMLgKy11COIVGaZNCjwaEVQRlTt+quA/
	9X9K+bL03shZkdLQ0OaMKMYSA2ikjIW7AbchDhluHpJOPluGib45EZrHthSqn+arNfZCQz+cfdU
	J1Hkrldq+AE2HtrkE1j9Y/KCUMPuEsHoDOuG2va09zRjS/mLYIszKH+Hym4NqWY3Y47gfKq2I7I
	q3cJmMi7wHVN88MbICPffMKc2dezLAze0zPO0QoCNFm2AfpyKHa/bIEeh8558sM8GBG+3qJ7zXm
	AJfjKyisUHfOgHd90y19nOxjuQ7Fxtwx/fe51ej8X+szQAr6VEats6EweG2qSHx7moW2FfrpZjh
	U63pr5+/eJ+WOLK/C4euI4DB0fPOjqLtXBy8TM0DAEcU8b5e2FY9IX4nsVLyjLaNBy9pDFipNDB
	YBimVbcXWLmin21RRHZkcIjPP3sPx7gINzDEeLYuNo+2jSSuuJbBMINs3L/Pztt6W2SjNY1wu7I
	+hVrhymrHiFor8TiruFjJijNZqNNY3+kqy33rjXAEXlZXBM3ThiLXqZFxHgep7ejvToZUsGUXEp
	RJmjJhc+RxgQEmVmTxOLWbvKkdrTd145smfMUumM
X-Received: by 2002:a05:6000:25ca:b0:4ac:7595:6f67 with SMTP id ffacd0b85a97d-4ac7595721cmr44357884f8f.40.1795793514001;
        Fri, 27 Nov 2026 07:31:54 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d55sm47510901f8f.5.2026.11.27.07.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 07:31:53 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Fri, 27 Nov 2026 18:31:40 +0300
Subject: [PATCH 3/3] KVM: arm64: nv: Update the shadow MMU's VMID for AT
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
Message-Id: <20261127-nv-tcr2-v3-v1-3-9c15c1cabe01@pereq.eu>
References: <20261127-nv-tcr2-v3-v1-0-9c15c1cabe01@pereq.eu>
In-Reply-To: <20261127-nv-tcr2-v3-v1-0-9c15c1cabe01@pereq.eu>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
Cc: Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Dan Carpenter <dan@pereq.eu>, stable@vger.kernel.org
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
v3: Unchanged
---
 arch/arm64/kvm/at.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index 893bf88f2f75..4a1767704d22 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -1476,6 +1476,7 @@ static u64 __kvm_at_s1e01_fast(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 		}
 	}
 	write_sysreg_el1(vcpu_read_sys_reg(vcpu, SCTLR_EL1),	SYS_SCTLR);
+	kvm_arm_vmid_update(&mmu->vmid);
 	__load_stage2(mmu);
 
 skip_mmu_switch:
@@ -1530,8 +1531,11 @@ static u64 __kvm_at_s1e01_fast(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 
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

