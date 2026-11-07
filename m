Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082314;
	b=1sE512KJUcNThWkmUxv0VXSpY3POFoovfA1jJ5pHr2cuHZKliKjZ2TZ0C3h8hFhFiVaO
	 UGivGrP/p8ULBIwhkWrYnqHBFu0qG3LTS+EkfeBXZyTfWmKlJSSOtESDpVptXWLwloDX3
	 ddARB2WqFApU2t8ZDXRNVq1tpO5Crm8v79ILyyzLwDxehDiWS1yEgwF4UmV/vl3MUqJAm
	 siaG6L4s7tuGieQTsyDCHq0NqFJbwAg01pl8a9z++lk3o+CuXrKYncIFFicWYheHq1YiJ
	 6E46ZS57OwftIO1+K6HYUsk0YKbmvNH07r+zUZi+6i7NWM0A/CmXgrEhbHaglq5vVfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082314;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8yF8kXh43AbXd3xpQB74N6B8PNlPohdBnSrACWZP+zM=;
	b=ullLxi11xnPW0SJlzD9aSOMNadSdNvOgdSOICLQaJssQPwt384/TBShhwS/UJfQJdIB5
	 fYqWj0yhpJyw8nP0qxGHTQRJJVX9dci+HPHm1+5mxl91LMAtaLmMupk/FnCHBQEm8dxEJ
	 kSw+M4yd7TbLhqwXI1INRt0BNgJvPU1FyxSrm9mUIEZBnDBclrMfq8s5FkEg0qwkb8Dl6
	 Db0WpKVvWIcJLYonsY4F1wcXadpd8YIDg9aSEyi60io+nj5Xi3LG9OlFS5yK584KNW3k/
	 rhR6bpLSBvyNkyjMXdk9iUQU/l9X/u4ZEwCnuYSx7tr5H5yyQcA8bLFxLh8afc5UDKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ha/Ln3eV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02037606A326;
	Sat,  7 Nov 2026 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ha/Ln3eV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E231F0089F;
	Sat,  7 Nov 2026 20:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082313;
	bh=8yF8kXh43AbXd3xpQB74N6B8PNlPohdBnSrACWZP+zM=;
	h=From:To:Cc:Subject:Date;
	b=ha/Ln3eV1ejaQedCaccdDp8mtcZT/8mpv7hMfjrs0H3m6euxgoQZfD60DjHUCWCsB
	 z/fNcHarM+pwGg5AmzC3bWUUZu5ZbqwQ3+YNd4/AnfDsIlVUKYFRMwK8Nkap1hTlO0
	 BkJKbSLBIzj6cS14onUlAATiXESdM2YUPpCG6TpEzGcs7YaAvPsmmOuEVePncUfU4s
	 f78Kz5DdXnlm7JVQPIdYbrSqNdYMSFso6crn0O3JLvia3Y5bOBPvcjDntVKube0PBR
	 /z50bV3xEj0QkZMl/FHNCWBkbRG4xm/qyeF44ClkXR6mOqh7Kvp945BXbss/pXRpQL
	 gEyJLMxp/kmug==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.15] raid6: add missing vzeroupper to AVX2 code
Date: Sat,  7 Nov 2026 12:11:14 -0800
Message-ID: <20261107201114.112659-1-ebiggers@kernel.org>
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
 

base-commit: 29c6cdaac04a6989a7ed4ae4275ce4244e617f58
-- 
2.56.0

