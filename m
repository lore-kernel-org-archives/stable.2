Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047542;
	b=XUIh9NQY7W3AMdiVy9BXt6vVrS6znxf5RQefxfUZHCc4m+NJq8PrelrRWOjLsBrF1ZXf
	 4yrMO+qpFnQQMuZCk3m5EkIgAdeLnVJu9cqnPoWycTJEX/dhPPkoi3aV4r0xt60hP+vGF
	 0EaXaiUTSz4847ZQhlvCIhrcue4TElP6Mj2VEHJRsbYQydTMmQt6EOdm1vxvzT5i9HiWa
	 vrP91pTpmwRsgpDqa0JMfiT4vRm4U+MQ8ytpSnhxVN8HE5RwOocvf5boSU24FE3QVr3sN
	 OvywOag2jnYUSqZW2ZFuD0uZhEoNxU6vOns1CtIbQvB+UokefB8mLC87bNM+MmI3Ibw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047542;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Aek1s51UROiw8c3D0Gtai6+q2C9+EcD9JIPYeKbfdKk=;
	b=FD0F4RTi+gE06x/3VIZg5XmJnagKWmo1eWoLZXJPtgiPKw6uGcOuGp3oEz9NtvdAkeY8
	 GdIeZ/8HDK9dI4TfSSHyyEzY5j2PG4drli9J5XzCrcyOqvAJcZiCH/cmtIbaozpzR5EaE
	 JDXpnkpA/3AFvAsFkoGmTWuTbuykV1AWPZ+A/xrqNVod/iFWovYWh8IhFdt2Lgv7mo6Li
	 aejckM0glRPEHG9tBLiqJtGLXx78JPWS5KESt2y/1Vnw8AXAhNBAbGNwBBq4ngXR2L3nN
	 TblY7fhNbmBmvNaXRhgzZLmR2pPhKGNOnG9oanE9xtIOqIIUbdJ/HAdc945OgNBqVfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhOc3O78;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E1606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhOc3O78
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263581F0089F;
	Sat,  7 Nov 2026 10:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047541;
	bh=Aek1s51UROiw8c3D0Gtai6+q2C9+EcD9JIPYeKbfdKk=;
	h=From:To:Cc:Subject:Date;
	b=NhOc3O78gfofEtMB/GXcPl9ADX8pWdFQbIWWbXlaACwTjm7NnenRdf2L1Y+6oPmUU
	 uH4S4Ik1rPuYgyx9iXd9rtJqfVbazSqkPGjegFVZnB+tfQCY82aLhKKtlvTmuRw6mW
	 zmjLld5BhsC68RKdacpvQZ2/PIpikJAHzdRfTfyQxfyHYMuje0musdYPMXlFfuj2q7
	 h88hRT1F/dy8aHYdBYUB4Yn/P9vacLY8PE1hFxw1KvkjKPgSgHKI2YkuPjYBwXNUj1
	 ifQQnNfBPz9QRBdg7wxdaQ8GmpFuF+8CzBcnW83YK8P9Xn+14gbnLc67ebvXZStEwL
	 EdtImhraZ8xrA==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] raid6: add missing vzeroupper to AVX2 code" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:20 -0500
Message-ID: <20261107053220-failed-6.6-24f1241cdb05@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 24f1241cdb056fd630e6710a916e0f7c8c910a70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053220-failed-6.6-24f1241cdb05@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 24f1241cdb056fd630e6710a916e0f7c8c910a70 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 31 Aug 2026 14:23:08 -0700
Subject: [PATCH] raid6: add missing vzeroupper to AVX2 code

Since the AVX2 optimized RAID6 code uses YMM registers, execute vzeroupper
before returning from it.  This is needed to avoid degrading the
performance of any later SSE code that may happen to be executed.

Link: https://lore.kernel.org/20260831212308.213855-1-ebiggers@kernel.org
Fixes: 2c935842bdb4 ("lib/raid6: Add AVX2 optimized gen_syndrome functions")
Fixes: 7056741fd9fc ("lib/raid6: Add AVX2 optimized recovery functions")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
---
 lib/raid/raid6/x86/avx2.c       | 6 ++++++
 lib/raid/raid6/x86/recov_avx2.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/lib/raid/raid6/x86/avx2.c b/lib/raid/raid6/x86/avx2.c
index 7d829c669ea79..3cc2fe7ac42c5 100644
--- a/lib/raid/raid6/x86/avx2.c
+++ b/lib/raid/raid6/x86/avx2.c
@@ -67,6 +67,7 @@ static void raid6_avx21_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -115,6 +116,7 @@ static void raid6_avx21_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -175,6 +177,7 @@ static void raid6_avx22_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -243,6 +246,7 @@ static void raid6_avx22_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -334,6 +338,7 @@ static void raid6_avx24_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -444,6 +449,7 @@ static void raid6_avx24_xor_syndrome(int disks, int start, int stop,
 		asm volatile("vmovntdq %%ymm14,%0" : "=m" (q[d+96]));
 	}
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
diff --git a/lib/raid/raid6/x86/recov_avx2.c b/lib/raid/raid6/x86/recov_avx2.c
index a714a780a2d8f..820871046e305 100644
--- a/lib/raid/raid6/x86/recov_avx2.c
+++ b/lib/raid/raid6/x86/recov_avx2.c
@@ -176,6 +176,7 @@ static void raid6_2data_recov_avx2(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -293,6 +294,7 @@ static void raid6_datap_recov_avx2(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
-- 
2.53.0




