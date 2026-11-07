Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082155;
	b=H2O7YqTi5L3iK+5ePdi6UoRirKbWnwq75lON5/cevHEVTsSRufXkt6F3S38CFTUoln/3
	 7S6pX3LmStTC8tVbMHqI+UY6Z2zkWVoNeUVfLt9U4yfIfTHOb/A6Ox+m3S1VCt/qXBPS0
	 ZwAjetzhvvqpJ9HmslTcP7DMIZVYV0RIQ95y28uOZAsgTKdq1F8EGcxRXHF1q7PD8o6Jo
	 cvDqYEeZJvSXreVnicL4W/rdtU4Abf03MlncGCHr4GKhaHJDnCoSZoGu/9QvADU0KrHzt
	 2ao5ZpHZtVHwjg6+q/brS9hvxvb02mmnxp+ud5QQsfjIV6fl35Lo9GrMA2IobKZToRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082155;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=heCP1ctwgt1GnMrAWvwe4yb/DKWEjkRjEYjYKC5xWTU=;
	b=GOw3co0/p+vfHOK4hk3W76cQpyRerJG1r4Pc7YuohOv1Q4hivyC2QJr1iuWNzsz4S0H9
	 VdUlJhNJ1LLO0B1nQVGNKc4A/jAGc/zVLmr4JK3YTp5geo3dDr2LXV4CVaGPDy7Ra7m6Z
	 fvk7rdaXax7qIDu7rlZxBS5kB+xNEXW5tdK08G9DtHZEys72rWzie9atiNfAnTNigYIP/
	 KhjEwWOFyJBrDkjIURUhAPFxMD+u6s090+NAXJDKY9VyaS8ZFCuDjMOAhNsJTP0hu29H8
	 AjAbJbHX43Zry5jG1qeZ3DA5zu/m4iz3UVXwq3J8bJT2wAlfp5DMgsSEOOD4mjvw1cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJSwbYOR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAEF606A32E;
	Sat,  7 Nov 2026 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJSwbYOR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E140A1F0089F;
	Sat,  7 Nov 2026 20:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082155;
	bh=heCP1ctwgt1GnMrAWvwe4yb/DKWEjkRjEYjYKC5xWTU=;
	h=From:To:Cc:Subject:Date;
	b=jJSwbYORtvfrGBYGAJ5Q7ESC5x0nA9QPITMb+1yQ6PwbZRQKOSJJt/x8BF5Mp/Sqw
	 lMApF+nDEYWACOLzixiZvgu3uoHH7g8y+YENT8v46IiJ0O8kEQcU0JC9sOpnNTnt2a
	 qvzIRWychARkejlIspUfs1Fshn9kczx3g4hMRIsROBaiy5z7jEDVH0UQouHh6CubMR
	 8zIRDVbIvMkDhoNTzx2IxuDqT9Ec3StiC7Ct6byb+83Ss/3uLU2G3WQMJ01t7owbWN
	 B3sDK+kfiV9ZrSyeUcQBQKhrnjy9F3pzQKr9i9NBMruaOGD/b5/ZRtFRKviQ8SJxRu
	 Knm830g8dFLqA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.12] raid6: add missing vzeroupper to AVX-512 code
Date: Sat,  7 Nov 2026 12:09:13 -0800
Message-ID: <20261107200913.103158-1-ebiggers@kernel.org>
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
 

base-commit: 5c40a1750f44dd6c7292d8c8d0b4ffff1734576e
-- 
2.56.0

