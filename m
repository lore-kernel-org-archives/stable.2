Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082106;
	b=FDttXtsJ8iDPdcjvFO4JtxeTfcj8UvAgXA7G+Xfam5jcUD62UYEcS8olPb1cD4JROpf1
	 s3flSmhcXJTjd/w3t2WJaLn/WivhF2ys/VgCIDia9F0U7u9p5GN9VrxP7nlLKDiAvR/yX
	 zbGKZb9KQbjcDWcB+sJMLIOPo42rHlxLWokkWebTg4PY+7Pb951moMCWiqohe3GShNNFy
	 IzWuCsBQDC5tZQNcTeWXY9c7CkSBTltWwuOAS8wB7A4XKIMVXPxw8NtFgfEUvFEYpKbcr
	 jsToCXe3Fhq69DUQbBpYwdrtLKToAd0kp5J4S69RYxUofqNkezjU4NvCRIRcRUlVlIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7fhKC7QdQD85zDoJZvcbZPdVm4wSRgtCvFZ7qhJbAl8=;
	b=PthpKKIIT5ZltYstGZQwZqz+IfdqwkbaWWuytWKuESkFID01aw7lSQSBXcOt3GugBRjS
	 fVt39IlLCkdqE/nSEQ7fcExRXab33fYgoBxaaGfmnFqLHLwfM6ySlB84FYGyKlVm6k7Lj
	 RB3afrL2csiqGz1Q2MK7wMQGzMBGgCOpA25cUomsVXKIH8q/2CofWamQ4w05WLF41sENR
	 eLA3TATMjME8YA17JV0ApD7BkR7m6RZ7MSkiFJIoLOL9PmtnEgv31N08hICZEhe95fIwt
	 H0JQ0IMFqVH1Vd2EEcu+n2O+T/x3TOcux0wfgVqj8mQgsprtnVIYdGY4p3/78phZquA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QAUW0PIX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88F606A326;
	Sat,  7 Nov 2026 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QAUW0PIX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F241F0089F;
	Sat,  7 Nov 2026 20:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082105;
	bh=7fhKC7QdQD85zDoJZvcbZPdVm4wSRgtCvFZ7qhJbAl8=;
	h=From:To:Cc:Subject:Date;
	b=QAUW0PIXdXQom8DoGz53y31ZuRM9lUe19vTYdPhBFjLwcCS+ppLoERC3RIXjMeEOP
	 x2B+rwW2mNVJW5BXT453br4xzW/FJwcjcPmB4wBML7xQdFkLqpRO8kJrBXnnhEsxpu
	 tn2rOdoEWIuVrxv5kseVvaRXM/KxMDaiqlLzf0KrsLwha9XNGOdIOPWIgHxHpCnMuu
	 mQpqikJPL6Minv0AtX94xrj/ud0M3pW4fN72J9pmOPJ6m6KRhdkh7wFs0Bcl75k10G
	 Zm9tuJ4WfFL9pfKulKWeNgDrxhBmAcHl3u0WSok7U6zwvgQmgb96NxXijMs1FtMmfr
	 OEBeXl8ACrw7g==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.18] raid6: add missing vzeroupper to AVX2 code
Date: Sat,  7 Nov 2026 12:08:00 -0800
Message-ID: <20261107200800.100506-1-ebiggers@kernel.org>
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
index 059024234dce1..2d03ce97f655d 100644
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
index 97d598d2535ca..0ae0a621538a1 100644
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
 

base-commit: c3f63d70f236bb7685e6d11d1d9b5b351552e600
-- 
2.56.0

