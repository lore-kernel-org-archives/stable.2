Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047544;
	b=nhWegbepHbNNx9EskGICyYZSvSnOjK03QtjIOezh9rhNC87xjpzJIYaw6VhTg93S65Dp
	 rzedRQ8bOUvEsvt/jWG3kVTaceOXxfLNyRdgQuVBw35AVDeCU/OZ60nDCTJbwQsqu/DEP
	 9sjeatZhXhZzIZaVu6PBsLDncrdK2vZfyIqk3nSEp4ckBqXIR3X6P9GGLo27GlA/KURpu
	 3B0+kQbWRKOtitGxujnxg2JRmBXFBWpftppuFO/HLbwtmolF97dzPkdoC64bRc3MIjxq1
	 wWvAHmGVvrSNpTFhHHIsy0huQ1ZjFYR2S4G7vnXw27DgvuX4EhH/Qo2Yz6fhEOqIW9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6hWMwNIHfGpzXvUdqsleajez9RDEji97wYM/cdXX7AU=;
	b=l+oB0Z8GewPBKW+sVfSqH6c5gQwrexPNbQ3fQ5PlLiGazoEcPsJaGsYNGTaSbfSXg1wE
	 JjmnWsWiaIvT3VRZy+IjcuQckkXl3X57xQv9ut6rKzTsW5quGqUH4Ty1B1molH+vL4nMn
	 9p3x7RWdGy3Qf15k1I2hoTSdxezldGRAIVZSQKXoq8sc2mGcVkxYSFQk+2EE6puFpsVCy
	 BfjXV+ybwKwxfq+J3B4WKo0CXc9L5C3O5vxksZLkCi6i8Gu6zDvdVm/l+oq8g9bkPqUlU
	 LoYS/fSq/dCGsaG18PuhMuWqjTUxQQw1M7j8KqQEIwPEOCOR5suKMNvzpIsjdno7Pvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3rUdpmW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1EE606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3rUdpmW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6835A1F0089F;
	Sat,  7 Nov 2026 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047543;
	bh=6hWMwNIHfGpzXvUdqsleajez9RDEji97wYM/cdXX7AU=;
	h=From:To:Cc:Subject:Date;
	b=m3rUdpmWTSlwjbCor17P7UvYJS+hzIiBCYxU2ZQw8zyqZJ2Gfr2wCxZrwb/PCwWlL
	 jFnWpPywRSJ7jiy6G7i/jbhtqfaFg3Xny/6Xz0UAuMT2isco7kGPrK6hdKokT3Po1P
	 rvFsrWf3R5kv6YyNfBjMQTZ5sz+QNM2Hd6h4T84Jh1GsZ/FLza6IsJ3Ntwi4oi5JVu
	 es+0SU3FqeQzjYmf8cAHwNRLOyiq2arLwHmcuRmF5qjEUPAXChrDKAgr/JUrY075m/
	 kIoDQxZYramdKm1GtAOcu996vQvlue+uhW5x6bgJee8BXEv2aJm1i3uM3itX7MIP2l
	 y89N9xFYQWL9w==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] raid6: add missing vzeroupper to AVX-512 code" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:22 -0500
Message-ID: <20261107053222-failed-6.6-b82cf9e49c1b@kernel.org>
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
git cherry-pick -x b82cf9e49c1be7cf1fd8e1bd806b0cdd25ab8127
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053222-failed-6.6-b82cf9e49c1b@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b82cf9e49c1be7cf1fd8e1bd806b0cdd25ab8127 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 31 Aug 2026 14:23:16 -0700
Subject: [PATCH] raid6: add missing vzeroupper to AVX-512 code

Since the AVX-512 optimized RAID6 code uses ZMM registers, execute
vzeroupper before returning from it.  This is needed to avoid degrading
the performance of any later SSE code that may happen to be executed.

Link: https://lore.kernel.org/20260831212316.213896-1-ebiggers@kernel.org
Fixes: e0a491c12968 ("lib/raid6: Add AVX512 optimized gen_syndrome functions")
Fixes: 13c520b2993c ("lib/raid6: Add AVX512 optimized recovery functions")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
---
 lib/raid/raid6/x86/avx512.c       | 6 ++++++
 lib/raid/raid6/x86/recov_avx512.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/lib/raid/raid6/x86/avx512.c b/lib/raid/raid6/x86/avx512.c
index e671eb5bde63e..772bfc4af6dfd 100644
--- a/lib/raid/raid6/x86/avx512.c
+++ b/lib/raid/raid6/x86/avx512.c
@@ -78,6 +78,7 @@ static void raid6_avx5121_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -137,6 +138,7 @@ static void raid6_avx5121_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -208,6 +210,7 @@ static void raid6_avx5122_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -292,6 +295,7 @@ static void raid6_avx5122_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -396,6 +400,7 @@ static void raid6_avx5124_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -529,6 +534,7 @@ static void raid6_avx5124_xor_syndrome(int disks, int start, int stop,
 			       "m" (q[d+128]), "m" (q[d+192]));
 	}
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 const struct raid6_calls raid6_avx512x4 = {
diff --git a/lib/raid/raid6/x86/recov_avx512.c b/lib/raid/raid6/x86/recov_avx512.c
index ec72d5a30c01e..299a3f044d616 100644
--- a/lib/raid/raid6/x86/recov_avx512.c
+++ b/lib/raid/raid6/x86/recov_avx512.c
@@ -211,6 +211,7 @@ static void raid6_2data_recov_avx512(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -353,6 +354,7 @@ static void raid6_datap_recov_avx512(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
-- 
2.53.0




