Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082358;
	b=QFVFeXP/+XSllHlMzQBTDbuNmisb9oZCTxHvwZiB1UFb6M+LXFEcMndj3XvJD7mZYpM9
	 tJX88QyiXMeJvrslULhbw/QVXccuyM/KBbgishnF3YHs7uAGgn3vKgzXkAFWmpWSnEk/n
	 lstkLKbUe+GQaxgNf2cR+v0z1qxMn2C2ybue+zrQbN0GT0htwb82NwWzHo2207ShTRfL1
	 CwrHdM7BOtYUZYvIGTI8SeQQnn/1+gohV3BI6Ooh6Mm/6svQKHp3CTF41upir5qK2YGQd
	 BwzEOpsP5YrN4o8Cnw5iXk2Q4U8qZOfVloVEg+3+ri+WSTEHu8gGu3Ta6berv8RHxhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8Tgu+w3PIztx+MsIlkYBoIyNBoo0GXaYzKtlhxX6nqQ=;
	b=cmyLp2tgrBJS0orQWBR148lE3nhHGEqIeDKq0ML9eCk28V0xfHCRRbcSABvtLCDtTsPY
	 jFO9EvQwIAEu1AUNdqIxYkCF77B5Zd1aLW99uvrx1mKOhOPaE4PRKlzOwp3HFBI7DB/0x
	 Pabh2uwxlUPg8Skta3JaMiXxo1i8X4ST8wMt4mme53iDFuug6/Sm0cO8DxGJRGj02CuZu
	 T8DScUb8ORo6UPhUModaMZnJMlOOiN0sGWBBD6OAve/gK2pcQm+pqVvmNbvzDDW8aBTNV
	 NaM5pjfjEOSAs6z8ut2pLtSqx9G9/Pw8Dj1nqUdGDekY7vRckuPPzYLL6Uy3Khb+P8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjWT1juj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4780E606A335;
	Sat,  7 Nov 2026 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjWT1juj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC1B1F008A5;
	Sat,  7 Nov 2026 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082357;
	bh=8Tgu+w3PIztx+MsIlkYBoIyNBoo0GXaYzKtlhxX6nqQ=;
	h=From:To:Cc:Subject:Date;
	b=RjWT1juj3AX9QzZrr/+nEOWbDJmuoCErbxfkAAkW3CXO1eUqcbKI6pr9iOiOiYSVm
	 kQjfs7y+VGO7xqJAjnA8+BkiBBTw32x5Bo6zPaIr3fKyQeAgpqPUy6qxLPyt51LA6p
	 JpEeL1ip8g5nx/Chodmi/bdygBIzwOHmcjJOiASGPLMZggaEXImQlXWb0fG/L+ZPc5
	 DwuIT9dU7bttdgQ1SYdNC+pr4VrXHPV3EbJQF2i0lKfNa51mSsdCV9mKYOhsf/Z7OW
	 QqN1jFk6JQ1oYLweplIcBLktR+/50PGfY0e1qjViz3yMiQBjCphAIsJ7vIC9GXfNuT
	 x3jDWuVCNHpaA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.10] raid6: add missing vzeroupper to AVX-512 code
Date: Sat,  7 Nov 2026 12:12:35 -0800
Message-ID: <20261107201235.124765-1-ebiggers@kernel.org>
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
 

base-commit: 3a323bc22b881a5bdc1646080f93f5ecb22850bf
-- 
2.56.0

