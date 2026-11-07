Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082201;
	b=Pt5SqtSdyb8BbwhtMzLNqcu2Hwo2pT6jxIG2nBY0m5OIuxl2FPTQ9wr/asTWQd8jRdcK
	 s0jkjLjCvdCJ5Bz83iV6lQdmo5npn5ezSIjoYRboqLbjs7ipSh+X+RzY2eXIWjB9xm6s+
	 DCM4Du204LJXWQEufJD2YThCreFNNLSt2+HPQSZa7fuw6f9DyF5HcgnVsA7Xq8M+iZ5DJ
	 qNe1Mubkq2j3HiRWU9h8fgSNJSnr1UfOfWGCrrlzS7oflk+EokaAzLkHyA9rvmH/UMAkl
	 tWJRO1rf9Zz7wixjxfAneFT2UIx+6HITWe4mIM06pPoPifp6LyNkiWqHpxX9yZF3iFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082201;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a2Di98h1MA6w1Gllqd0OxJso9nwH4xImQNkACxV4XuU=;
	b=lnBrzjUVPzFLjioZPyM8AmzVV1EqlYgdoKC2oNRlmSAnl9ZDfY8PtteM2H3/cSfn0GwR
	 fWu4PyBwcrEBK4VGVdCiU5QsFmXRSBKr9mSuo4zsmiioQD3Vgh/ionntkAqLo+VcCO7jS
	 eyuTtB19oKUxo0jJqkbUgkWcyPlWdY9JwceApPLRm3EFqnODS001pAFUURmAedg+Gr9ut
	 geg0gxihYMwrX03PIEMRb/qHkUsS2mGxpizyDAjAodep6vYJ4XRDmO+HS9MgXvaNDMQIh
	 AuwG3cmR5GkGIBJkbu/n5mL231iNSZzxJU4v2PLgRe5g7uLKKVJkoF4suPFrituqbbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOHA+Swk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB0606A335;
	Sat,  7 Nov 2026 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOHA+Swk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5951F008A5;
	Sat,  7 Nov 2026 20:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082201;
	bh=a2Di98h1MA6w1Gllqd0OxJso9nwH4xImQNkACxV4XuU=;
	h=From:To:Cc:Subject:Date;
	b=mOHA+SwkXi9NYpM3hr4DFtFRjwA3gTo7UPZHI9hwTqWgzSj3MxSepxsOZVsV3Z9pt
	 JblyFQCf/HkfjmfwD32cnJjM0LtBXQEUc+MwaPDp1mXzSH0YTSY/mYjFXnPH+jmFbt
	 j96l22Y7zsITlTjUq4vxSK9MSAzXije92+kXhQdaubDqN1MBYp/zvU2aRLYXZze7YH
	 z8Hm0GLeSWObZk2pSyj0UYbGQiz97/TK3L9inOsoX4I4ZVCF0nxHWyVNrM1A0/MdU8
	 zLkdx0jjvEiywbxljwV2cpOPYJPWaKZ+gRUZcfhXSJDcuO9R2cUMMxS2JrkT0ak4H7
	 o47/bDF2B/hAQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.6] raid6: add missing vzeroupper to AVX-512 code
Date: Sat,  7 Nov 2026 12:09:59 -0800
Message-ID: <20261107200959.106570-1-ebiggers@kernel.org>
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

commit b82cf9e49c1be7cf1fd8e1bd806b0cdd25ab8127 upstream.

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
 lib/raid6/avx512.c       | 6 ++++++
 lib/raid6/recov_avx512.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/lib/raid6/avx512.c b/lib/raid6/avx512.c
index 9c3e822e1adf5..30956989e7d74 100644
--- a/lib/raid6/avx512.c
+++ b/lib/raid6/avx512.c
@@ -95,6 +95,7 @@ static void raid6_avx5121_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -154,6 +155,7 @@ static void raid6_avx5121_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -227,6 +229,7 @@ static void raid6_avx5122_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -311,6 +314,7 @@ static void raid6_avx5122_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -417,6 +421,7 @@ static void raid6_avx5124_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -550,6 +555,7 @@ static void raid6_avx5124_xor_syndrome(int disks, int start, int stop,
 			       "m" (q[d+128]), "m" (q[d+192]));
 	}
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 const struct raid6_calls raid6_avx512x4 = {
diff --git a/lib/raid6/recov_avx512.c b/lib/raid6/recov_avx512.c
index fd9e15bf3f30f..c8a152d9ab6da 100644
--- a/lib/raid6/recov_avx512.c
+++ b/lib/raid6/recov_avx512.c
@@ -221,6 +221,7 @@ static void raid6_2data_recov_avx512(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -363,6 +364,7 @@ static void raid6_datap_recov_avx512(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 

base-commit: 5139929c698c273e07cb0635732f6a918a7b8e78
-- 
2.56.0

