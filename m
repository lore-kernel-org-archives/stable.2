Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E747CA91
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326862; cv=none; b=Ztuv+fMalhbb0RreaamcA8RXdhvFQZwdlAP+IiokngDEXSQMcSLxPIj8HzpMAiDTlOytX/5mSRaXl/AMa5KoEFjize8REMW3E0f35vtMw5xH1/w0u/ZzjgRFbcGmNGxTFr6Cym5jun8OTn9ic/VXVNmhi3MyE4hDrw0179Jc730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326862; c=relaxed/simple;
	bh=iUKsISx97Eyt6gD0CUDPFNVPi3iaca7Phiogt4QFNmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgLe+ayEcKThgh+TTKqbnFNjJIRFKAGwUbdF7RkLZGK56yUaMsetOGt/KCws3ig5Je0qPTrWwvaqOLEayiAulcryluVQ9rbCoxUdnqtesq1q9/AxNxXYiKkKiZ9JJexm3IVBmpOF03kSE3y51blEqJt76WiXJwOhhzvonftKVt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMOM4E4H; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMOM4E4H"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca034c989e2so366255a12.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 05:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326860; x=1785931660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qLMnpNtLpsL2XHYkd+z33mKUcr79GQx5LDeNnSKUE6Y=;
        b=NMOM4E4H/Es5UZqsV9fPFVl0rVJEPPG+A/3VXI5E+ZjCgQUp+XE4wgRo/koFtjBs4j
         KWuuQ2ZyVK9sC98XdVaFqiCbpyw0YyDlUa28uzlmcUkocpUMEyInSH5dLdWfLcnhSGs/
         Y+rmyFOCWxwLRORacSUXNffta963yjVqvEAp21kMiKs0ATknKcDLnkEF6adQ62do3+kF
         sKuu6al9k/lbrowXY/FELO3SjYxZmQXFgdqjcZ2U3Bq0sX95YyHsq/SZholOzwOnlTSK
         uydapEO/B04YyLKlvGdg30jXX4wWfzC3lqqcYfbhm/ng+ephKzKI58hUrKB2FsOGidF4
         wkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326860; x=1785931660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qLMnpNtLpsL2XHYkd+z33mKUcr79GQx5LDeNnSKUE6Y=;
        b=rm9KJTWRyt+4NviZg+8fCSNPFmdnpsr8qQSVt+F8wUQDJ1msvlC1XIw0kRbYpW8j7J
         NO6cy4uvipZvXM8lJqrSb3ebgm0dezM9gqjDQgdD7Py3j9AfBvSQQ40vw/owhsK1ie0a
         GYxSeyvemcq5X2XZyjV3hOkkP5pCsmKZY9+WMQSHrycwULy+u0HT2Ti6PI6iD6xqxaZC
         JEw6nT3ri0xH26SaoVpQ0XmPz/BHwHR2XcgxIFFuoqEw5FXiZieHnS+MUOszwjfbeRG4
         d/lJab8QW9s5glVVtf2yfBREgI7w6s+pcjij1O0xH/ybPqYk2ouu20foF3ytK1ljNnRZ
         i2ag==
X-Forwarded-Encrypted: i=1; AHgh+RqQavLRoCYNS3uTJwkFO4iRxD7Nv9co60EMxOFcn6E17u8Z5FdNrAyt5tB6bpwt2ip+FkXr5OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHROTytu/5E6ntnBkXQJi5cjbfgMGtcexyKWSjiNA/IOHCGh9z
	telyuPmBmlFxenDnaNtREeEvZJUtRV0IoTF+PrIuIxzYEX239VyWl9mC
X-Gm-Gg: AR+sD110ap+yUtGBe/+Zo2H5cY0tAIT5GTdA8JvgufSzszlZ6ZIVk8UJ9OCxks/7cIZ
	V2cWrKM3pTFQMVNTFqz/mCUt6hLJPKUkmHDTtDskQYb8hp3Piw3OiJSRioBpSsoegAUB/Xub2Pb
	6+UwUefsCCb4tfeUrfFoW6rsHLiZSSydp8EqoY7XfEvMq5L+I3lIBGMoBO/az/8rx2QhusyVwsV
	Lvh1ZDHT5HrLxh94yPd5jAe1VBLx/YLizmJJAlZRG6lCjpWKrrGUlb/WjcH48yFZ3rjpPnIrDc+
	UfPCuEAjyd5/weuJCf3hOe+CCE1rQ2rOGVOvUp1uGrGuJYC6JalG0sO4GFa8ZDqloXnFJQ5pkMv
	6ztnQVRY4mgn9VObMoGJZ9PHkPlHH7elIIcG9UdQmr7QKYUzW7UwEUjG8FmCwK3Mkf5u3cruDM2
	TCnmvXQSXImErKSaDnkPxMcKi0cBnj3V5ofuLPrl9Nujd7zWrw+Cm1hq7VuAEF7sYP+mdd0o6sW
	T5/hfbkohiaXzw=
X-Received: by 2002:a05:6a00:ab8b:b0:84e:165:da58 with SMTP id d2e1a72fcca58-84e933cefd6mr6852509b3a.52.1785326859904;
        Wed, 29 Jul 2026 05:07:39 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055133sm1309570b3a.18.2026.07.29.05.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:07:39 -0700 (PDT)
From: "Bingyu.Xian" <shanbeeyoo@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3 0/3] RISC-V: KVM: G-stage fault path fix and cleanup
Date: Wed, 29 Jul 2026 20:07:30 +0800
Message-ID: <20260729120733.829457-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729075230.743030-1-shanbeeyoo@gmail.com>
References: <20260729075230.743030-1-shanbeeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three small changes to the RISC-V G-stage page fault path, sent as
separate patches per review feedback.

  1/3: Treat -EEXIST from kvm_riscv_gstage_map_page() as a quiet
       success, aligning RISC-V with x86 and arm64.  Real bug fix;
       Fixes: 9d05c1fee837, Cc: stable.

  2/3: vma_pageshift: short -> unsigned int.  No-functional-change
       type cleanup in preparation for sharing a common
       struct kvm_page_fault across architectures.

  3/3: Widen the G-stage fault address to gpa_t end to end -- the
       local in gstage_page_fault(), the (gpa_t) cast before the <<2
       shift, and the fault_addr parameters of kvm_riscv_vcpu_mmio_load/
       store().  This completes the RV32 34-bit GPA fix that v2 only
       half-addressed: v2 widened the local and cast the shift, but the
       address was still narrowed to 32 bits at the MMIO handler call
       (unsigned long parameter), aliasing accesses above 4 GB into the
       low 4 GB.  The handlers' internal uses (run->mmio.phys_addr is
       __u64, kvm_io_bus_read/write() take gpa_t) are already 64-bit.
       Also in preparation for sharing a common struct kvm_page_fault.
       No functional change on RV64.  Not Cc'd to stable: RV32 KVM is
       unsupported and this is untested at runtime.

Changes since v2 [1]:
  - Split into separate patches per feedback.
  - Completed the fault_addr widening v2 left half-done: widened the
    kvm_riscv_vcpu_mmio_load/store() fault_addr parameters to gpa_t so
    the 34-bit address is not truncated at the MMIO handler call.

The KVM_MEM_USERFAULT port that motivated this cleanup will follow as a
separate RFC.

[1] https://lore.kernel.org/kvm/20260729075230.743030-1-shanbeeyoo@gmail.com/

Bingyu.Xian (3):
  RISC-V: KVM: Treat -EEXIST from G-stage map as success
  RISC-V: KVM: Use unsigned int for vma_pageshift
  RISC-V: KVM: Widen G-stage fault address to gpa_t

 arch/riscv/include/asm/kvm_vcpu_insn.h | 4 ++--
 arch/riscv/kvm/mmu.c                   | 8 +++++---
 arch/riscv/kvm/vcpu_exit.c             | 5 +++--
 arch/riscv/kvm/vcpu_insn.c             | 4 ++--
 4 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.54.0

