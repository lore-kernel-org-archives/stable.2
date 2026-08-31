Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB83A7820;
	Mon, 31 Aug 2026 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211394; cv=none; b=n/EZPkpMUV+8z03YAKodK5jZ84ULKcRzPf1Vp0sqqt7dxYINmO+wiJ0ZcwG9sbVr78iH8aFavTyJqeQkzm0v4tvymzBKS/WZJSkY285LCUTN1gaiwVHxLCBccholEPUGi3+CRA54XibwM/aiWFLM14YInOto58NllBv+CJyHCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211394; c=relaxed/simple;
	bh=3ABV5KcEfFa2ZdOhHx8K14Lh7h5cAr9u8by4VIcYCMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcqevqgQ5ZlYyjk/CDMi8sHONdEjZMWvUjz6UyaBZD/RyPdrAscdDQcCbX+5/VriO5yseDe8ApNXMLkQkk3tyxShv1aoovp4UO2JN068nN280jpOiFaPUhGf/O+BnNkCabY8gdUjq9grnEEcZb3npP8gSOWajRF5PQ2SIUfH0wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjkyHJXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjkyHJXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE8C1F000E9;
	Mon, 31 Aug 2026 21:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211393;
	bh=y9PqaJ5DVVcgmOYCx46GRAI8694oBDYtVILplF7R5I4=;
	h=From:To:Cc:Subject:Date;
	b=TjkyHJXw0oPPnn7uxpHVcSaLOqPwbsysf/jsMDaCnn7KCwrx544M02vBdqmiRsne1
	 P+9I/i/hAif3RUdx5eftrCDiJLx/QvGHYHVbN/FJWZiy67CF2LS7JWuJRuinuFtTWx
	 /rA0s6jHdWyPYU2DtpBIJ3wrADGlwiT7DbFbEuDRtuAlX39fDFzvvc2ljqVvi7aWSC
	 rS/UlwaYwwbxbTt5n5uubuh50e9Pehq7SYEMVtjH4dGGVOA1bMGp3nqW/6Du8JbpOt
	 yxVLOMGtN8grSWj9minqr+GFKM8VYmBsIXnC1GVXwZcSPsiF7UfRyHLP4jmhPWpCb9
	 4EbZYNbyMibFg==
From: Eric Biggers <ebiggers@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-raid@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] raid6: add missing vzeroupper to AVX2 code
Date: Mon, 31 Aug 2026 14:23:08 -0700
Message-ID: <20260831212308.213855-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the AVX2 optimized RAID6 code uses YMM registers, execute
vzeroupper before returning from it.  This is needed to avoid degrading
the performance of any later SSE code that may happen to be executed.

Fixes: 2c935842bdb4 ("lib/raid6: Add AVX2 optimized gen_syndrome functions")
Fixes: 7056741fd9fc ("lib/raid6: Add AVX2 optimized recovery functions")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

This didn't get taken through the x86 tree.  Andrew, it seems you're
taking patches to lib/raid/.  Can you apply this one?

 lib/raid/raid6/x86/avx2.c       | 6 ++++++
 lib/raid/raid6/x86/recov_avx2.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/lib/raid/raid6/x86/avx2.c b/lib/raid/raid6/x86/avx2.c
index 7d829c669ea7..3cc2fe7ac42c 100644
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
index a714a780a2d8..820871046e30 100644
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
 

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
prerequisite-patch-id: ebf41d9b9e92708245f6ae0657896ff3f8ef7d0d
-- 
2.55.0

