Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082355;
	b=0MNicc8BZVqB22AilClsAm0Xik9jKVGQ1zQGcvv1/39Fb/Ks2logLT3vK/HDfvEBC7tF
	 ni/tEwpPu9/1YPRzkiXk6PDMGUC5KHgG27Qa0SE2LDYBEu9Jn0WAhzGRT/Nh5Dr09rnEm
	 gJwRJ3eBzHqKuFBKBhI21ZjQPzRXlSCWZb/7EcFH93f+W+HJYim0JHlcWXueiN3g6WeVL
	 nCPrw5w52k4b6klRR2nfyu3bdc0VyGwYibuzRiM69MahI70WEdTveR+tjIucZCMNmfOKQ
	 8vkdYKSeEZLjwASaTUeADZRF0IjgPReG8nSv+5SMo4LbgWp3nbMYphRDPn/pzgXDTNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082355;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GWkY/j/oWxIPN/LWAzYIZzpoFxbU/tyVjsd2fonx3Ks=;
	b=S8vodTtRoeNpfQkdyS71qcGulvUh+UcY34y9510tMbAp9tq1BZap/dOugurPdigJydfk
	 MP6SbP1FI5W3qICtKCnCZyJ3XSobW7e3K3wA8sXNu6dxRvwoThiCsKJfxa3B3SdGj+icK
	 Lpr1Nss1Yf0KlxI2MvldoT1Ne9/EjZDla8OMiszq+VBGCGYMDSsqiXNSTYbutP6rpXcms
	 8q1wCEs6gZUia/hbKIirMeOYuyfbENVVaY50PEdUkJtBe4SP46zV77C/PmZvOydyfBOvm
	 wGhi/gs5tUXEDtwNHe/WVUcwivuni71LhsJgTKpvFwDEAY+pdzSWg+reCA+uQI/A7lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPM53Fhn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F9606A334;
	Sat,  7 Nov 2026 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPM53Fhn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2791F008A5;
	Sat,  7 Nov 2026 20:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082354;
	bh=GWkY/j/oWxIPN/LWAzYIZzpoFxbU/tyVjsd2fonx3Ks=;
	h=From:To:Cc:Subject:Date;
	b=bPM53Fhnn5XJoKa+tvxFqh8pHNRPMDrOcwEupmXrJ61oTGyUPaYBeslFz5ECNvdkS
	 n/C5OzSpVNgkrxSxWWDGqiOj/a+5oZ7DLK+9qUD0WW8RXXEeHVV8N/5z4yRLr0UWRc
	 oZDF1u2yIC0MdmaRhudcRoSF1Gtz94kF5Kw0hE2lwAXQx3Oh676Ft/gwblidQj3xk0
	 FjNKPnoguXePiOjVRqeCv+oSZLDC5feAo8S6lssZorTnv/ZSb1TthE9+2DEq//Gphj
	 xdHlyZSiHXJHd2VgyuYv708iN0LpP5A1/qFPmxduhXHIp0QgC3ngfcFj6FWyhf11uq
	 2WTXRHAuzdCCg==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.10] raid6: add missing vzeroupper to AVX2 code
Date: Sat,  7 Nov 2026 12:12:11 -0800
Message-ID: <20261107201211.117439-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 24f1241cdb056fd630e6710a916e0f7c8c910a70 upstream.

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
 lib/raid6/avx2.c       | 6 ++++++
 lib/raid6/recov_avx2.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/lib/raid6/avx2.c b/lib/raid6/avx2.c
index f299476e1d764..10f2b1b4d6a69 100644
--- a/lib/raid6/avx2.c
+++ b/lib/raid6/avx2.c
@@ -76,6 +76,7 @@ static void raid6_avx21_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -124,6 +125,7 @@ static void raid6_avx21_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -186,6 +188,7 @@ static void raid6_avx22_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -254,6 +257,7 @@ static void raid6_avx22_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -347,6 +351,7 @@ static void raid6_avx24_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -457,6 +462,7 @@ static void raid6_avx24_xor_syndrome(int disks, int start, int stop,
 		asm volatile("vmovntdq %%ymm14,%0" : "=m" (q[d+96]));
 	}
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
diff --git a/lib/raid6/recov_avx2.c b/lib/raid6/recov_avx2.c
index 4e8095403ee28..a7fd1ba177f1b 100644
--- a/lib/raid6/recov_avx2.c
+++ b/lib/raid6/recov_avx2.c
@@ -180,6 +180,7 @@ static void raid6_2data_recov_avx2(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -297,6 +298,7 @@ static void raid6_datap_recov_avx2(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 

base-commit: 3a323bc22b881a5bdc1646080f93f5ecb22850bf
-- 
2.56.0

