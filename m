Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082263;
	b=tj+Drr9H6K09lvg2ME53+6y55jta6tfMr2DRsH7ok6ORkRRsn7HcRxY6jCJEqjURHebZ
	 0DKm2WlohxdnKVWaC3oqRFKcI6+VpJyOHiCBYQvk5otgdxrS1CU5qdaHEa66N8u8+zFnb
	 B/FHTuX9VY1PqU/U/r5q8wIHfNSO3pCsCo0jmnmJnqcC9JIHN9PTvbyv9YXRdFkWv2IDs
	 4zhlNB74Wha8XRztzQLyrmMIUiNElGZGGoaLogWjIMXreWOGOPtdhXET1LfD6L6Dl59Tp
	 ulNIT7vXpZPtxzMBTBrkKfqplvridd8WWizo0TUmN79AK9G9LKgt7JchzVDxsVxOhaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082263;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T0ODNMh02eS12fQt4MkceenMeKw9eeidJp2zVzQqz+w=;
	b=VfKvCnca2eDhKlKRkmZwITVajKxHxsMAxPFGTgUL8TaSnnBRxJrWnJdcwsoRvZ+PeE9P
	 pBJkyv9ZzUoqCX2lgdNzaHtQcL1x77vFOpVhFO3XkbDf113tKXsQb0sOZv3sLoE0RNGgR
	 fFzG/GffprTOZY204XciafOZKxqUQ5OCgxH/hcF9m+SfVtja+LcN+Ouoyg2mH7FnqQ3Fz
	 Y7u18l6F5vrtJ9sfId8BRsZanmWooTxY0E4LR+fHrqukDU0S4W/VngTBKtN03i3Moaz3n
	 nC2DIWE8Tu7WKt0h7pqOMxQGrYRkEsso+/EnwUXnFn/f0oTELN1Kv+XPlSZ/wkHsOsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBKjNtH1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF14606A32F;
	Sat,  7 Nov 2026 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBKjNtH1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE7C1F0089F;
	Sat,  7 Nov 2026 20:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082263;
	bh=T0ODNMh02eS12fQt4MkceenMeKw9eeidJp2zVzQqz+w=;
	h=From:To:Cc:Subject:Date;
	b=oBKjNtH1jx2W/tOfG1II+gqYsdFmvXga6X6oEDe0N5iKjGF+3SzWVmuNPZLdlXFI4
	 HWjtL1NXAVsAlgFe3cwOaHpCUZu9qTSmomswnNyPTKaKVH/9gqXENEBnjWMN5gpLGC
	 uZ1gsf1fWOLfaeMfR44dG00eYY7z0Xhgl4/BOHfaPT4jfMcz0m/BszHVBPLc1QAwlE
	 o+J1Wmd2xJnqQerenBXQOf0wmYLkaKqIT+Xt6StB68XzUyHe31pTubsfK70+UxkZm8
	 fuTDnCwNIzX6IYrxTOD94jZLEPdq5qRch/t6vv9QTglK9G7xuyyIV0sa4aBVJUcyks
	 jbUW3CbQBb/Ng==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.1] raid6: add missing vzeroupper to AVX-512 code
Date: Sat,  7 Nov 2026 12:11:01 -0800
Message-ID: <20261107201101.112567-1-ebiggers@kernel.org>
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
 

base-commit: c75b0cf0982c00cddfd88d1acf3872f79b40980c
-- 
2.56.0

