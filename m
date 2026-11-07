Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082109;
	b=5Oa/kK58EVepqh8O6p2CWoeHy11SXWhF3P+dGiIVLGLQvRCbeaH48h/GA17XaGj7CpqV
	 okUmJLBGtm6FuXXMBQ1oTdWPX5kC7LVevQSoVFKTrWRes05bC80mNO8pWob7V6waeIP0G
	 ztDm57b1c+IkeGii+aFm7PzEK0zdiHvnjw3BJcdTYFJXaUHSqnWJHN4ROnvnNRQ2rAmZP
	 uIDkO0ZHHXhJjM4W4rcoNjHs2mFBpY1r6xvdYVkKyaRtqmyYo7jpAvCAIaxM9oKyJQfp6
	 0sozoPJYvuwSfgn/vON/YW518a0CNmh7RM5N/B2bmRSslQklyZNsQRilL+S7B2Cvalg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082109;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EhY9IdoF90/BI/O3GuB4KjcdWlLliaBr43p8vRIPJzY=;
	b=mxo4nVDEql97Gps4MxDeLPriOlHE06XsvIX3p0vFmVQe8CpY5Jpd8juv1nLGtlG/fdXp
	 kv54zAaz0d5vy6L71MMyo2cclXHS1/ibiZJiHXzE88S9Q1ufq4Gaaid6gaUIcKbLLI0IX
	 xn9aVgXvbmN0q7XhY57OPi/WTa8GDJode6bagWS6w+0rxedSc9iOZ1bejdITOz91LyIfk
	 BlMRI6QPCT5nfZRjT1LXYM860euU6KoicZEvPvzEngTcUEc+lRVAZFFqdzy6+AnwQoiZ7
	 pbC14O89+KqVa0serhkG7HPIknnk3y3kaKpxyQblNsT/3mbjqMXM23AW4nOLOmgxOBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7PkuVaX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8D606A32C;
	Sat,  7 Nov 2026 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7PkuVaX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B5E1F0089F;
	Sat,  7 Nov 2026 20:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082109;
	bh=EhY9IdoF90/BI/O3GuB4KjcdWlLliaBr43p8vRIPJzY=;
	h=From:To:Cc:Subject:Date;
	b=k7PkuVaXpfvuI+EupOhY4U3OOD5jmVBX69yNhls350uFHTjkt5QX+XjeB/sYlsVqO
	 6vHfniglxPmiEju2MzhwgtZvn1UMY6WpCLJMNc9dlFbMCZV+U4XWncIVOTmOTUSIRV
	 OIQeQIoU5NO0tINb1EgO2cSAM9O65CuaUFssTS/LSXkWf8aQojJrkaooH8nxo3K5iT
	 CWytDyFmDOmSjIwzVJ23PxeCaVxkLm8EdVWMULJ+0Lyf2QyK6pxPLKT/rguevAz2M9
	 Ub0CAn6kaiqH2Vh+cdkNiObIEZG8YtQWqkDLA2Q+NHhJDSCevkAm/2OlTdD17J0eHV
	 DvQlWjwFBxXwA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.18] raid6: add missing vzeroupper to AVX-512 code
Date: Sat,  7 Nov 2026 12:08:25 -0800
Message-ID: <20261107200825.100575-1-ebiggers@kernel.org>
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
index 009bd0adeebf0..d989ca64847a5 100644
--- a/lib/raid6/avx512.c
+++ b/lib/raid6/avx512.c
@@ -93,6 +93,7 @@ static void raid6_avx5121_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -152,6 +153,7 @@ static void raid6_avx5121_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -225,6 +227,7 @@ static void raid6_avx5122_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -309,6 +312,7 @@ static void raid6_avx5122_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -415,6 +419,7 @@ static void raid6_avx5124_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -548,6 +553,7 @@ static void raid6_avx5124_xor_syndrome(int disks, int start, int stop,
 			       "m" (q[d+128]), "m" (q[d+192]));
 	}
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 const struct raid6_calls raid6_avx512x4 = {
diff --git a/lib/raid6/recov_avx512.c b/lib/raid6/recov_avx512.c
index 7986120ca4442..32a9720be269d 100644
--- a/lib/raid6/recov_avx512.c
+++ b/lib/raid6/recov_avx512.c
@@ -219,6 +219,7 @@ static void raid6_2data_recov_avx512(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -361,6 +362,7 @@ static void raid6_datap_recov_avx512(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 

base-commit: c3f63d70f236bb7685e6d11d1d9b5b351552e600
-- 
2.56.0

