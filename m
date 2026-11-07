Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082261;
	b=drm9mQX79hfy6fnnU2xRtG0v+pHSE6n+oYvWsWjp9LYDJ8+zAvM6gCeqxTw8pimUc6Li
	 Z281k5DJMWiTCM9hiyH4W+7Px4jg9nOGSHZdCeUaTXTWmFep51leom+H2WfIhwU4SmLBf
	 TU8sWvJKBaczzY/Z2gsmd5hfyz05rye0EcE51Z2DOxMCgSSyE+sAe7re+QomBDNoKse1F
	 qb1kjVTRNe1ftlB5Sdb5e3OAesgirLQ6GSEkiKnx4as8tHg9NoCOZlUJHnSb7XwtcSnZX
	 9LdT7dFGZ5HK9xpibjHHYXxDEFB7vgihCE7nWAPDFsYU0qJkyppa47oZxcutzZm75ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082261;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EO+PZhlxNVVYuAADrtgn4+YtATvtWCK4wDwjViKkpbw=;
	b=d9tGL8ZhPPrXCLovIfJpkaxTGpXuGGkM9Zwie96QEIVpRZQiHdhUf4ogIKKZIMRChMpJ
	 UAAyg9tGFl9rpzkG433kZjQt4JnmuOXEPpSkKt/9H1I00plUzq5b4r7D1tqDPNldF/vAK
	 hGwyaX2/nOYozvgDo8CWgX335OowEAceq0ol9t2uwWwsWZ/lqaNTELN+N3K9pAACwRG4j
	 RCr31z04vvnmkNEZcbBH1yBD79iAMuV/efK7zoH46tImag7N+d6kv4U9lR3bgAt4SzcQd
	 z3dU/SLFS0qQeW3poDqGvLiLgkYu7y094S7DC7LcuBigjLbthYbaHLkQM2VHabuMDlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrK+V7H0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58F606A326;
	Sat,  7 Nov 2026 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrK+V7H0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3EF1F0089F;
	Sat,  7 Nov 2026 20:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082261;
	bh=EO+PZhlxNVVYuAADrtgn4+YtATvtWCK4wDwjViKkpbw=;
	h=From:To:Cc:Subject:Date;
	b=LrK+V7H0E8Yfd/GBOayzUqWND0yD8hF0iAeCZ9tzUKx9+fEZapeHlj3XrrYD5w08Y
	 gZAnCLh0vQsppqXG9cxI3w0IHTPEe87DmqjKl6bRdiG46rkJZj2doP7i5R1ZkrZwxf
	 aQ7+c7/Z1II97lUVpJ51j/d2yepkjRB/HMul4A9yz4V6MKf20Tp5rcXyGu2zbHaeEF
	 rtG27DIeGpqIossHXKg8s5OsKypeRoNzeqzHg1HTfkgNNAxxQ6Rbb7o1CO6LVllvxK
	 4nH+nHNtgtvCxvYYnU+QvkBIAUUU4I2kMMG9Pc3FuNlqydH9CUuFBYY3TUpqn5+1YP
	 pmyDatD6Mt30g==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.1] raid6: add missing vzeroupper to AVX2 code
Date: Sat,  7 Nov 2026 12:10:42 -0800
Message-ID: <20261107201042.112539-1-ebiggers@kernel.org>
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
 

base-commit: c75b0cf0982c00cddfd88d1acf3872f79b40980c
-- 
2.56.0

