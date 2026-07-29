Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491A47CC7A
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326864; cv=none; b=szkwESbVGPQstZGBrrP8tH81fVBMuu+A8aVwq27xM+AECH9+024JIiZG2DXpIiiB/HBrMOyZ9Vgh6nBD2mSaG2S60wMJVHV1vnmMuuqGYACJ6JDxoSWS2kEKEfRqnqQQozlKEyJeAy6RL4S0p5aqPMGOG1IZAeU3YiGh9gUPGmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326864; c=relaxed/simple;
	bh=CB/kmte7e6VY+VaJOPegkGtB3qVnaYWtkgn+D4/w8Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R02hDtYp5IY0hLTN0EBaTBPxDrYvYB1s6Y8AI4jLC61IIdRDZCMQ5qEox34lPHr+WRD9vc/DJ0qT6G2Eiqt2jTdDo7PVazKlgGnBo7qYoG79/TmPv5EmuQjIqARwAv8YjJJlc4oyFWdyHx9d/56cTtBLZsqtSQCQpCURx23RYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc7jkpv8; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc7jkpv8"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca00ea47337so288983a12.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326863; x=1785931663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KyJMaQ1sYDuVfSZMuwHiwzVH9paIzHnqdE6/bJyXJ+M=;
        b=Qc7jkpv8uT8etdfvn9vw8LcDpgHD88XqFpL3JE+GFHbQsQGmLPI0jI1WS/LpyLaiCr
         tKxHfkq0B8kmh7pgGX8MYCE1yYdyrduzCiSy/aUiF8dYQfZCiMkk6mi7Cglrj+5UrN4X
         VGfh1ce6sCzc2iZXwGCRSuefWClKllx1IXwTtJwCMbQKrfDh0vmyclkCU99vWva423B8
         5HZQRNDMgB3ordFIBAsPvAhPqOgWqHNC/9qn6a/p7p1zTuID24xXI8qTrWkJnZF649DP
         sT83O1Ke2Jqk25ZfqSSxaHLeVep2JGpdm9g/+RxF+yWnYQHV4c//KQy6+y8oh/4biqDK
         0HsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326863; x=1785931663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KyJMaQ1sYDuVfSZMuwHiwzVH9paIzHnqdE6/bJyXJ+M=;
        b=F3T3BpNoJR5fXvtTThgsmL8y7iePKxCl1jSxVoN0gwfpQKs3gmvHQnKEw5De9jv81v
         VRO9yLxF8/15AVFsvBquf0hDcFfWbfnSgEb+WA1yQxCPNM2XjTqBVCMnX/78LDzDWcRT
         FLEwwsVY/fpwdnOT59HpLTODbPIfQ24cLtVC3c8h/tmcRG4KMQLB4JtdO9T4ZBDKcvRT
         n2oTfViMt7cXdSYqy89q9wBlIQc03z9/BA7q6UNP60/aBWpSHJ4B2lvC0dSnSCbAtMdL
         lcVT18MigKCQEPUG02YBGb+bi4WpQkmIqrKC2vQqw6/x8TU8keGIFHp3W/OlI4QCuP90
         tf3g==
X-Forwarded-Encrypted: i=1; AHgh+RrzVyvKMcBMpshdM8I1Gb72xeV1IwTYYmRa3C/rIWdhA5/8oklsoZkYGMjycIPtnFhUZDaeGFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyYVm9t2Zk/xFHBZIZNcRFS4sqHjf5XFLRSkNI1TCAto/KharG
	C7RLd9kmhn5Pm8hRsO7XFe7nEbssxPssQaUga+521gehcJSrhhwJkJIM
X-Gm-Gg: AR+sD109/dURiTEvgKqQSYI2q42xyQoo+7mIMqSRzd9pe6hej9qmuJ1FqJb+AplEue7
	lBUHoWOZeApttvvTqUvZ9VS0lUkBlTFBCe/myvnb7FO0Rx8hZ1RBDHajIKtDKw8v7mBzOIF7ukg
	9HcnPckFT2F9oTaSGLy5E6bargRiqFEtwVOPd+klVbOeNWcoc6daVf7S7h+olHQEjQXu+C25bSZ
	jVgr9MoPy6YWfXlFIqnyl0YDWeBHTkh/NPaioE0P2eZcGKr9AE/Rw9RatBOJX/BfTqry/kYyqlK
	kP04t6ckWazsAkNtZ9b5fFCOAgsYQDGq4dcaUvxB0C4KkYmYJtkcExpNYsftu2Cj3+fYOlxTTdO
	MlUay6yDJWrELdplT6Eu0bP3oIBomMFbhJiehB2wmCNdGNjIogb0BLRshATUJ/ggORoGKzKObP6
	3Ubgo5EUgw4ITnOkAyYcqHVBcUS+zg9na4xu3H72Q8E8xjRBnbG7PL2bgcotWvbBdUABJ8YYre4
	PZf88L5WAyIow==
X-Received: by 2002:a05:6a00:b4e:b0:84c:1cd2:142b with SMTP id d2e1a72fcca58-84e932ca245mr6604434b3a.9.1785326862618;
        Wed, 29 Jul 2026 05:07:42 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055133sm1309570b3a.18.2026.07.29.05.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:07:42 -0700 (PDT)
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
Subject: [PATCH v3 1/3] RISC-V: KVM: Treat -EEXIST from G-stage map as success
Date: Wed, 29 Jul 2026 20:07:31 +0800
Message-ID: <20260729120733.829457-2-shanbeeyoo@gmail.com>
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

When a concurrent vCPU installs the same G-stage mapping while we are
waiting for mmu_lock, kvm_riscv_gstage_map_page() returns -EEXIST.
This is not an error -- the page is correctly mapped and the faulting
vCPU can simply retry the guest instruction -- but KVM was treating it
as one: printing "Failed to map in G-stage" to dmesg and propagating
-EEXIST all the way to userspace.

Align RISC-V with x86 and arm64, which already swallow -EEXIST in
their respective fault handlers.  This also lets kvm_release_faultin_page()
drop its "ret && ret != -EEXIST" special case: with ret normalized to 0
the regular release path is correct.

Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
Cc: stable@vger.kernel.org
Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>
---
 arch/riscv/kvm/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 8a0aa5e0e216..943d8dc72105 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -652,11 +652,13 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 						vma_pagesize, true, true, out_map);
 	}
 
-	if (ret)
+	if (ret == -EEXIST)
+		ret = 0;
+	else if (ret)
 		kvm_err("Failed to map in G-stage\n");
 
 out_unlock:
-	kvm_release_faultin_page(kvm, page, ret && ret != -EEXIST, writable);
+	kvm_release_faultin_page(kvm, page, ret, writable);
 	write_unlock(&kvm->mmu_lock);
 	return ret;
 }
-- 
2.54.0

