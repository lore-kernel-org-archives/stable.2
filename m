Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2964D47CC8C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326867; cv=none; b=U2jftKnSLWoNw62vd3QLIt1SwChLA2eSfoh7pM+PiuFvE+wKOP8m4mxcwfzLTWLBZ7xC+nSsCv7UQIqJ6j73Qr9pVNLnMEy9cDcNJS1kW4uN04lNbl28zQBmK++MPEKIepbSBkPhfOUKWol74z4KbnOEjTYonikNooRdDKtFTpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326867; c=relaxed/simple;
	bh=ygPgZoMqXOC3wZUcyQcGEydn+a2bqNHY9YgXlHDuSpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG6X/OaM2aaGGNh1DpsH5T2YKZ6+t9Xpw2/SmPuzXtosxkNr8kQCsrWp60ayRMAuyXX3TKCFUULniyGYxMT5PIJYHlDSiuhPnhrysZhQVdi+LnGEXC8OwPdsdWw2/dnzk3y+2/lPH3n/8Pw3kM87UqVU4VnrnNTSfj0ztTTg3mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekd1O/QT; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekd1O/QT"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca7fcfe1669so345052a12.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326865; x=1785931665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Reyg7Uf6tDZ8+7RMN+GpyxgR6kpVXfUwi59Uf40QnCY=;
        b=ekd1O/QTrHbkba9BHBYgvzooYKoWAf/hDBOoVbelL63EUMNU1a2oRaIUyQiSphbyYg
         lMiiJE2NZJhu6fYTK4t5EmdSjADnspB8ojCCSdLbSQ4ld5NvjkmoELF7cSRiFn6zvFo0
         jZOR/Eehaj832a732BR726fkGX6O/hkKv5BzgXKRAQ9UqbCqXIR6lI5Cz2XDJTGPCXgs
         oiPqn/H2oMYyDr/SezHYq/TTjXrIeIqnSQNQN6+agYDaF+uFtYFDROs2y2J6d3VZWnkT
         bGmNdVHguuy1hrNne7IuC0ZU+Sqt+/SAv9ESmaOJWA6NwvmY7Nh0NC8pnxlvSM9iOP6i
         jN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326865; x=1785931665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Reyg7Uf6tDZ8+7RMN+GpyxgR6kpVXfUwi59Uf40QnCY=;
        b=Msd5OpVVG6kNGYGwTOTzKkBj5axOb6IuM4lpR/OPpVdOvnpgpk+UJbRDuvAsjiUUJQ
         f2UiUDGt1StTp8kPbXWx/IJLM3QjnV49E6vy1sE1cLi22PgXlT6+6t5k4dSsmr0Nb3ox
         tCfHlIMH6J9mKe8GKoQo9TtSuP/GY9NzeAYzIygSn3bCN60fi13lrmUZSounNzhhY7Hj
         OEWzcjK/yxQXugwcNvOazK48bquyAqQIpFiJPjGFSHRBD0S59xU70KZ6zQyDEYqqAlzg
         bkoMeZRYadVMIJGf5BuxvKM5QO+VGvaQSpJ+qXOPG7BDQ9n66aDJhYpjTEgivQ56tm1E
         fJ6A==
X-Forwarded-Encrypted: i=1; AHgh+RoC9RyR6FWJ9CmKg8hqeEWB/OXXXfJMYnCI1XfW2ovygfsX+EBfx/zPJ/KdbRT+uY0aDo5imSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Vu4Ub2BrZWQzqrMrQiiWvKrrJtGoLt1WZsQPt7s2Ij0Y/J/h
	dD9gVhtYKaOr3vyyAD/9coepjtBDHuSyHhq9+RYpgwiDD43gn1yndCl4
X-Gm-Gg: AR+sD11526NIAAViGd/A1tTKA4/VxP1Z4eIbxG88Seh1tSn3CUiuaQKVVhxn1sxAX4R
	yz1QOmnVxoGBrjBqLfJCnGnp7JNswvX2gk/yT1O9Dd8xoDWbmehZn7Y/CC8BTVcrNUHYR9ikuYb
	+eLRgkUzkDlHienUnI6zBoM0cTc9LOI3ovKsNh5TrOF6KZGx3Jc6adLMdCZbgpmh5nwHuqASyJz
	u/uOrOGlKYZKCLZVJYVs6HrgpWr560qHu1/Q+NP4DhNim7TcVKCcexZHg2dDTfBa8yDZ1+P6FkK
	X4l06iKWZzqVFz10SFaI42yWW6pcmq87zcF9ojPeIuCDf7aJjLagwIwm7ww4yowaows7vxeESWc
	M3AMhT9AQhtKW8i2z7fPdxMQUFQCnrP3KrZFvCntT8N+XUz1BLi/9VkBBLuCIIcCMBdOCifx/Fb
	984zCSM4EFFZBRSn3NHvXyFa4dIFeRnYO2TWVpv/6bYQdvCCLKoHE3kLTa+zKMV+JIkWzM8uLNJ
	TQ2n/pGEYf6jVAuGQSHBwH5AQ==
X-Received: by 2002:a05:6a00:4f83:b0:845:c7f1:29fa with SMTP id d2e1a72fcca58-84e93250f57mr6434871b3a.30.1785326865329;
        Wed, 29 Jul 2026 05:07:45 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055133sm1309570b3a.18.2026.07.29.05.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:07:45 -0700 (PDT)
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
	stable@vger.kernel.org,
	Bingyu Xian <shanbeeyoo@gmail.com>
Subject: [PATCH v3 2/3] RISC-V: KVM: Use unsigned int for vma_pageshift
Date: Wed, 29 Jul 2026 20:07:32 +0800
Message-ID: <20260729120733.829457-3-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729120733.829457-1-shanbeeyoo@gmail.com>
References: <20260729075230.743030-1-shanbeeyoo@gmail.com>
 <20260729120733.829457-1-shanbeeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vma_pageshift in kvm_riscv_mmu_map() was declared short.  Use unsigned
int, the conventional kernel type for bit widths and shift counts, in
preparation for sharing a common struct kvm_page_fault across
architectures.  No functional change.

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>
---
 arch/riscv/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 943d8dc72105..d2a06a54be17 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -541,7 +541,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	kvm_pfn_t hfn;
 	bool is_hugetlb;
 	bool writable;
-	short vma_pageshift;
+	unsigned int vma_pageshift;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	struct vm_area_struct *vma;
 	struct kvm *kvm = vcpu->kvm;
-- 
2.54.0

