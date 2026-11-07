Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082153;
	b=nQtYpDAlnkBlDA7XhUzY0kDKKLg1hMKbu0iFI6T9nomTC5R5G33WxszNgGgv54040ft0
	 AUMCjIUf5wzOuLGdxyEwdf5x3xRyo0d9eINPrjQxSNdFjk+1gXtmVAmcDSHTekbBnfMPA
	 25dIdQM8t8bQXZm2nr5pwpz7jdpufKCy6E5eN2bB/bI50UI4SKuYvnPjSiCaJWT4NMA92
	 u4uuvq18HIKz6QDOhRZYpKzj1Mhuq1oMPmvW3UMhsgXKS2XEO09HyRJ2Q3aB/VuiAVYa0
	 Wc1b+EA6F9oP7hkfpneZPaP5XU/AyLRg+G2/lYvx2Q9dQRGQlqHMPI//r0wur/+RlAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082153;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yK0wVa13Td10mMNaVwrNKmGbMDfi89cMOBgCfZcfWjQ=;
	b=ru+BUjDIwPydtk3A4OSsy1w3/CSZTNQivJYzhTUupdPaGWZ7kC0N5B2BIuXyoNxpex2+
	 F1LCxEOXRU45Zq1zydOtmIgtEiMwIlbv/zxCh5CcgwmNtvIJKJpApxwdZvTzT9wDXZs+/
	 ALu5xU5ZduhoZitVtbpnd5rGKZIo+y48wE9YuS7ahzHSvr91dL3T6fS1v9cbJL2LxnOuS
	 iZe1MDiF8jtczCP0dzl1qxP3XlyXN0qJUFmrTEJ6qrOapOvQon7MBNgQaueWO5iT9D7yP
	 Egmn42Uz0hQRXrvwljHO4UGAMa4iV1+zgHIC7lOM9rzF+FgSpUF8vC5U7GAxmwR0xsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FroSnYXe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499AF606A326;
	Sat,  7 Nov 2026 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FroSnYXe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2E81F0089F;
	Sat,  7 Nov 2026 20:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082153;
	bh=yK0wVa13Td10mMNaVwrNKmGbMDfi89cMOBgCfZcfWjQ=;
	h=From:To:Cc:Subject:Date;
	b=FroSnYXepE2fBp93WYX1GowlHwLnCdcYiqfNpnP8ltGVVpFMLL/UMi3HxkS9/eY60
	 qrA1CTOf+ku8SDPMq7yqtSmcxACCV/NoFxmqvJUAIGZXAkhJ9itzTI7aRbXumnzQ9/
	 qQnyhwscQ658GmjHJJ7deNZMSzGtDRVoLg3CLFqQODLHtZe92BYW84jZQv0VZz/H4G
	 pRyO+PnoABYMLtTzy/cYRU4Ab08VHKWoe6rwXYijA1rUy2wmuyiBWs4tOLTTAPNMRG
	 VywMmdIN1tE1HsZK/tQfkrAfYXln2FZsHo7R8g88Z/HBaKoi68/iu29x+kZJAhNOmZ
	 untgalcwrcidQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.12] raid6: add missing vzeroupper to AVX2 code
Date: Sat,  7 Nov 2026 12:08:49 -0800
Message-ID: <20261107200849.102995-1-ebiggers@kernel.org>
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
 

base-commit: 5c40a1750f44dd6c7292d8c8d0b4ffff1734576e
-- 
2.56.0

