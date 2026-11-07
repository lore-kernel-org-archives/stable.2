Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082200;
	b=W5lM0EEgnQcFsHSWML/lERIi2XpXdrgkbTtP+e9pHDD37Too7wDKDYhEIuPr31xWCLOJ
	 m2abvOBstcoKMuESsv7ufVhW913G1wceSOg4OcWZFMowPCK3mzFJpad26EJYZpeQ76Gcd
	 k/BItuaTT18n20OxkTuMELJlF/4CXqoa7NiU2xBpr+pOsyyQ7k3+H6RMloXK6Hp83tCcH
	 Q7RkaBNcIJ4eS/5Uqsla62Sy1Hr1GW2wzorp7pc/IUk+/voL/9LJzVwKGbYwtk04NuRm/
	 g5KY3o9qbfYuqK3WFipGRhk9/THXOmUjMW8vjhPcRLY6JF55ezdfyD7BEXwjpZH1Xhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082200;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3faW4M0EjCySFzPw2tv8jqgQtRWdYh5R7fb7OjQC/Sw=;
	b=y6pfm4HWbhoweNWrLfq8jYcyxjeqFsLd5mBrj6lvgVNzN6q9uKiOSsv6yq1WyzTQyxSu
	 1Bbqr3gETa02mLnEH2Nq262Lzyn7U/xN6h/kTvVTckYtpBGfmlmECDx2fy7Cu2UbG1HIO
	 pYw8VxJaCgTmpeRAN5qYM3VLN94L5ZjHgdW4PFTWxZaroRReWq2FDReXoxlFgWd6UJcpK
	 Jb/rT/sEOr3D3F801+zDykwrIN3a2pipMYEkOtUBD3/oMKq7RALusyq7/GBP+hiqEBuOO
	 4B4DukOOGREU5cznsOYbbc5Fj9GgUnKrmY9eH4Bc17AHfstfraDlyRpwil3hhcLqYEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mW+YpXRM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB2606A32D;
	Sat,  7 Nov 2026 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mW+YpXRM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A011F008A5;
	Sat,  7 Nov 2026 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082199;
	bh=3faW4M0EjCySFzPw2tv8jqgQtRWdYh5R7fb7OjQC/Sw=;
	h=From:To:Cc:Subject:Date;
	b=mW+YpXRMu8rbQxEyL9Mk3+iVofmTr+JkMM6aHvwl1YuruwVHUhcb8FBY4+CLcj16W
	 fVhbZaQZcPpkor5dlfEDE9+XZ9wkxfa26u+pB1noKqzHSFnk1H6EgO99BckWXq6NIU
	 GzTWdfSTraKsCycKHWe/0I4/zFg20XL6JsEdNOFotb0c5GyyUj2yNZ8Xp7P0h7PA33
	 usDR7+IFry0FIiMQb9oAGvkPyUvuRIGb8mosHEfb7lPGel0646HSszKDJSGxjk+XIB
	 dmSP2MGMFuywjUVWFhSi1MWAUSZdx2SyJKFtjgpaRPBQvd3HjtdX8Y5WSnzWUct3Lo
	 gSwhKCyMh4hyA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.6] raid6: add missing vzeroupper to AVX2 code
Date: Sat,  7 Nov 2026 12:09:39 -0800
Message-ID: <20261107200939.106544-1-ebiggers@kernel.org>
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
 

base-commit: 5139929c698c273e07cb0635732f6a918a7b8e78
-- 
2.56.0

