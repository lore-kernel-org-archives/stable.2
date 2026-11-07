Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082317;
	b=po7ibnwGu3mqLCgGmOndAxCf7EWzDXS6zHagsZEnDGkgUfdcupUTGkL+xoueigIfKA/v
	 nNaYi3SpoHqkU+aj9Ppe+AMAmgLiCGJ+7eoXFWVIwDXyiVZtmwxsV0ras/OrRD64+fkkV
	 NsOpkKfzSib4/gPm4oBGEp6Bc3MLaPKHEDBWc0CuBKIxxnNCiPgTtPJH394FWS7WKntSQ
	 nJ+mjjo1lZ33uElyY3/bjKyC3TNwQ/Ea1EvZ9XeEbautMBUkdndLPBzfg9qR4TzUB1iIU
	 c6I3HeUq5Ayo1y5WhFGeNJJZPzBd8+ZIstE9Vt1F98dOOkcFUokJyIV85601SwWm71w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082317;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VGQ2odwRZ2cKX2se+M4kJBg3y9JaEoKHG9qZ3d6neXI=;
	b=UR4/ShE5zyOBPK5kimR6U1en6AqI7zf1Rr+4bPBngnXuaIi2zWeMhaOrNmBd1HZHzJQS
	 HUDEGaetbU+gSgbesfNbaTQe7kkLVPZd6REY6g4B+6L8I9A9RfvLrQ9fczqKTWRrRW54X
	 aR+l6AmAhaH2hllHMzElYweN4tpbnK3g4Tbrxa4KKabpQDtvgcDiihyjF5WrUUUSirNx3
	 iu/yaB8NrRlunisRbETuR3QFEDmQk0ilXuM/AzQEoWpAxLpsHJNzg9HLfR0vQzpeUc7W7
	 OZkeGLzOqAmd2OOMPVbyw2fxY5paKeXPM5YtBXskuUsGzqVJQP5jYcFQG9AIiRKD0gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKplXR3H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7F606A32E;
	Sat,  7 Nov 2026 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKplXR3H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D1E1F008A3;
	Sat,  7 Nov 2026 20:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082316;
	bh=VGQ2odwRZ2cKX2se+M4kJBg3y9JaEoKHG9qZ3d6neXI=;
	h=From:To:Cc:Subject:Date;
	b=cKplXR3HHmZZukIR3rTjgSiTsgF2aXoKT6Vez4nhaU1kM2LtXE6A0+GFDp1Ynmf5g
	 OHPetec2WR/6QirwfRrZglu93gLOi74KVOo+65tCTqt82EEyuq3uPbldW2B/aYlUrl
	 FmGH7e64dz9XSvmVwdLGABgHPfqOCx8TzsEJZapmbopB5sh1eiaY4WqimXUZBYQNaZ
	 lMyLM0yNcj9tsBXqoUiyDI/LDZNBtcP4shWeeJCf6Fg0+Az2AhKn1P9PRe7DM6H38+
	 DRa69ZvQb+5XaaophsBQSo+0LUMkaxeF7aEbQtMbcYZH4Y8GpV2bQJgWqZzlnoX4kT
	 xWwqgH8Me2Fqg==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.15] raid6: add missing vzeroupper to AVX-512 code
Date: Sat,  7 Nov 2026 12:11:54 -0800
Message-ID: <20261107201154.117342-1-ebiggers@kernel.org>
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
index bb684d144ee2c..1d7eab3723aee 100644
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
 

base-commit: 29c6cdaac04a6989a7ed4ae4275ce4244e617f58
-- 
2.56.0

