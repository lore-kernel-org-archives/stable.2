Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A043542D4
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791285946; cv=none; b=Duf612kORwzU/C9lJXGFbMIHPwI97xjPZmxqPJYgRD2nf3T0h/S1oKLxHOt7zi0qdvjsPFsNVKhmiazbSICsFmlwBZZ/qSkBknEqlTi1SVbWoYjTy1Dp4iCRPI0EkkpdVE9do33gRGmRmAA/1lEykt+5NS7tk29UrU/XqO52STw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791285946; c=relaxed/simple;
	bh=yMUYGKxKuzdqt2vSqxN3X7fxNGC1DXLVo466TPmKpd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZplMSboVqLk9L1qY58SO2VH5SQ2FvuHfaAyeKV/4IIhtUgrwhIrzbMq33yUEFd/Hc5jTHMkYS5lwKAY4x7IxKKXdE/pQjfQEoHcyBS3qGjpRLIFSWsX2IqapGRNyiiTwHdb0INahZ4uHBHILUDVCkyFNAk8FQ+jRVouyv37UYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTKXgimo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTKXgimo"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8899a204034so298463b3a.2
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791285944; x=1791890744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CjcMla2/FYvjpfqQRk49JvWHnA7u7cWllcGDFw7MAUo=;
        b=MTKXgimocW/5S74YGxJtJ+71LtI8TeMgR12ftqgzD3mT9Cq5W2wvGZDfLGdInlBjEo
         XcIc2YnoOhxhZPiDtgT68ncGJtp2aZv1nXmY6WVGYeGZjEXKMywCW3n0LzrPn3nVtEnN
         u3eD2JfD9D6JFmGLVWg9soVNcOndiuQ6EiSWvhpTfqA7/DxIhzJvvH1mde7sJla/9n16
         fAD6asVE5o3flN+CtWkQNWTY13L4Oi3jIIBG93y4RFlqjtq5sg2hrBD9RQXV0G48IrGv
         NCQLl3su8qG4hXxbWeRt9/iEFvOmJhDNOulHuTWRw4werUqMs7NU4PoFQgBpRN0kiIVK
         +ZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791285944; x=1791890744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjcMla2/FYvjpfqQRk49JvWHnA7u7cWllcGDFw7MAUo=;
        b=B2wWfAk3Yp30zZMwD1aCoLRkAK4qEOiCMnY656N3D0lYDxVO6Icdd08vS6OCzOajq1
         pDZVtph0vLegeCM5+NNAWfp+6fV6YSga9R5IVBCI6hj7ZHyQgl8+RdNQljL/66njJYE1
         mgknDDiPSCw3z/sSfvWLEHe53ultykjvX6RJzKYqaETKm+NJ+Rszfri2TKNOhRkkyHXs
         NlwAySfSMx2Yf1FmqMv1X4s0Y+7aJgJLhZxTm0EZwLJzXStKWBZ6JkM976EjRypzzv+z
         pua10T4DPgMxE8zPgrolynO6D5EeLYWIO5+OHGWwsYRgCMC29TmGliK8MTg8ndJMDt3T
         z5TA==
X-Forwarded-Encrypted: i=1; AKwUvBwR9lHTBI/BYnG85RnrXYmXOfR3HhtBji1J+ZFxNkzPnui3OfS/J4ELGeSG4eb54VAyJCEVJ2E=@vger.kernel.org
X-Gm-Message-State: AFuF++nsEXPQBKGSEoz+ZoJ9m4VhkF+0vSmPOTDxDAodO3AVS/uYnC5u
	wZa1HJCO0n25eBNiwvaENzQDsfPe7c+6qmL9sD8QOYRPyKgoEl8b/Hhc
X-Gm-Gg: AYBFou24+7pLYKDz7VDQe1RuaG0BkRa/TB9PTVd4hHeAxqz/uepZc9KPeK0UsJrK+0k
	NYndXWpyohtfmgEzISeiGmlBp/PCFPZiZpa28TY+TmMXCXl7h3BAjPGX4EhpmP44DVEMAaMisWC
	1txW0yaLSWrrAsD8uNN/OOi++zE6mqPwGWSSOt2V2wIaKxFmtzsHJ02W3oUGYl3Q+o3y2YJS+H2
	nE9uL5SxBizcAEfs0pAbAhp9CkLoMRsKlN3xuRFxxu2VdfsXDyRgist7bPboq1iqTfP+inj6NT0
	6j+92o5MGfOAd8JLUiJU2a0oTp2XjUQ6yvskkktgvKeW39X9rFl+3annBgGEK4DuwSV3G1NmKmy
	RPBs4oJAklJwXAeLxAUaOAbKZskDYAxViVZ8YN3wQ3LUlpip4lp+ca12zSHwX9SO3KVlLJFp9d6
	K7GmY5rJ3OBOFpBJQs2tdg+UG/u2vBpFza0YV5Y9oXzd/ME7KQicIvJdewZfO5LBWfqiNJrvLiD
	+XrGmApMjW8AKM/3GZImqrZKYM11d0szxcgK4dw6N4kGjQ=
X-Received: by 2002:aa7:88ca:0:b0:874:705d:f63d with SMTP id d2e1a72fcca58-890de4e7847mr888030b3a.31.1791285944290;
        Tue, 06 Oct 2026 04:25:44 -0700 (PDT)
Received: from DESKTOP-M211L3D.tail-lite.iloventr.top ([2409:8a00:1832:c00:803:42a3:368d:de3e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0968d43fsm4663369b3a.3.2026.10.06.04.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:25:43 -0700 (PDT)
From: pwhMass <a203865235@gmail.com>
To: x86@kernel.org
Cc: pwhMass <a203865235@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] x86/apic: Use the physical address for the LAPIC resource
Date: Tue,  6 Oct 2026 19:25:25 +0800
Message-ID: <20261006112527.26409-1-a203865235@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apic_mmio_base holds the fixmap virtual address used to access the local
APIC. Using it as lapic_resource.start passes a virtual address to the
physical iomem resource tree. On x86-64, the resulting range exceeds the
physical address limit of iomem_resource, so insert_resource() fails and
the Local APIC entry is missing from /proc/iomem.

Commit 81287ad65da5 ("x86/apic: Sanitize APIC address setup") replaced the
assignment of mp_lapic_addr to apic_phys with the fixmap virtual address.
The later removal of apic_phys retained that virtual address for the
resource.

Use mp_lapic_addr, which is the physical address passed to
set_fixmap_nocache(), as the resource start. Keep the apic_mmio_base guard
so that the resource is only registered when the MMIO mapping exists.

On an unmodified v7.3-rc2 x86-64 kernel under QEMU/KVM with nox2apic,
/proc/iomem has no Local APIC entry. With this change and the same kernel
configuration and VM parameters, it contains:

  fee00000-fee00fff : Local APIC

Fixes: 81287ad65da5 ("x86/apic: Sanitize APIC address setup")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: pwhMass <a203865235@gmail.com>
---
AI assistance was used to trace the missing /proc/iomem entry, prepare
this one-line fix and description, and execute the comparison tests.

Tested with clang/LLD 18.1.3, a virtme-ng generated configuration,
Q35/KVM, 1 GiB RAM, two vCPUs and nox2apic nokaslr. Both kernels built
and booted successfully. No HyperEnclave patches or modules were used
for this upstream reproduction.

Reproducer (run as root in the guest):
  grep -F 'Local APIC' /proc/iomem

Before: no match (exit 1).
After:  fee00000-fee00fff : Local APIC (exit 0).

 arch/x86/kernel/apic/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2667,7 +2667,7 @@
 		return -1;
 
 	/* Put local APIC into the resource map. */
-	lapic_resource.start = apic_mmio_base;
+	lapic_resource.start = mp_lapic_addr;
 	lapic_resource.end = lapic_resource.start + PAGE_SIZE - 1;
 	insert_resource(&iomem_resource, &lapic_resource);
 
