Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046793;
	b=WdI1/8QJNXeLWV/1e//KsFzOEL9HCK9uTeecLY9c40INHB/83KpwJaqIM4GzKra0upHB
	 EOEpj/Je5qzAmU7ylm6ba2e6d1/XlLOmpQx2dfcOi+LDfkVzvPyNE98BUqe3F/zZiG8vN
	 XZpvgU9K3YcyK73jBXj6doHxKROM3dmunuSaL66pF55G/s6ip6TsGp9d1Y9FJrby4MMnS
	 aJFPfK/JxLN6cXpFvW7xMSd9ueWKxlGTBvbTbdVBoeAH8mKO/9V+blMqO1iWmvSdvhxed
	 8lYjy7gO3mMugDyW2UqoHpOMdWzWqSOfQNikLSRs03iJYhtmSpO7L3Gi8szJ8TlKdrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046793;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZwGn80YQDU6jiCzaRIWRJ2TNdiCuaRTf08ixsN3ZH8c=;
	b=BA68LFW3XzXs9rB9SM2pv7FffpezzgsZ2QJTenPp3QvMewlK8h7SI56rZxnXmBxXLvgC
	 yI8fmqearbRCg5pDEcIk6fga/iY0cHZeyS+DnQ8bFR8BB/z6q3f/o1yTUOUtr9RAvOrd9
	 s+1r8hh4eu8ITK/pPFHR20lmomFnIFxik4v1yLu7wTTmrO5lP/LCSw77skjU+7/suRdF8
	 V7b+TR8mEhOq0HqdziKlkbKZ4RWiEmbTbc/L7ZOnXbprVQEmZcb7l2bfzyuF6agIQHg4j
	 16elcQ6KDLZpzZyADVTDTNcWAAlUPS7P8gygQa5JyWMN9W5lcv2u9m+iJ4+Y+7FAeEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bT/XFSB7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EDD606EEBE
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bT/XFSB7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB591F0089F;
	Sat,  7 Nov 2026 10:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046793;
	bh=ZwGn80YQDU6jiCzaRIWRJ2TNdiCuaRTf08ixsN3ZH8c=;
	h=From:To:Cc:Subject:Date;
	b=bT/XFSB7QoG8gFXMCHK1P3SP50OPto1XZVQHYNZNU4oGC4Rm6HAf8MEkz6IDkmHyO
	 18MmY2OLPjZr9tTi75OH60dwDGLxcNJFr/FR59pLa+9AqfjOEQCxT766bz07nQ7Ozn
	 OrGHGDCDob5zXpckAJHvx4CBZNRSZhdZGWiccnmDhhUITithV88Ts1zW9okoOBULob
	 XzkRhcJnBPDdTXln2pAK6ij4tCfGX2FSdOuHIPw4pdofWdftdd2NWBjzCVgjEmKZSH
	 RKN532aZh91QNbxGTZFm6ft77IlD3pB213YhbCH4nDtekaJkk/h8bNQDNoUtjXfHTR
	 NGtmIAxu/0N0A==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] raid6: add missing vzeroupper to AVX2 code" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:51 -0500
Message-ID: <20261107051951-failed-6.12-24f1241cdb05@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 24f1241cdb056fd630e6710a916e0f7c8c910a70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051951-failed-6.12-24f1241cdb05@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 24f1241cdb056fd630e6710a916e0f7c8c910a70 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 31 Aug 2026 14:23:08 -0700
Subject: [PATCH] raid6: add missing vzeroupper to AVX2 code

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
 lib/raid/raid6/x86/avx2.c       | 6 ++++++
 lib/raid/raid6/x86/recov_avx2.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/lib/raid/raid6/x86/avx2.c b/lib/raid/raid6/x86/avx2.c
index 7d829c669ea79..3cc2fe7ac42c5 100644
--- a/lib/raid/raid6/x86/avx2.c
+++ b/lib/raid/raid6/x86/avx2.c
@@ -67,6 +67,7 @@ static void raid6_avx21_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -115,6 +116,7 @@ static void raid6_avx21_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -175,6 +177,7 @@ static void raid6_avx22_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -243,6 +246,7 @@ static void raid6_avx22_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -334,6 +338,7 @@ static void raid6_avx24_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -444,6 +449,7 @@ static void raid6_avx24_xor_syndrome(int disks, int start, int stop,
 		asm volatile("vmovntdq %%ymm14,%0" : "=m" (q[d+96]));
 	}
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
diff --git a/lib/raid/raid6/x86/recov_avx2.c b/lib/raid/raid6/x86/recov_avx2.c
index a714a780a2d8f..820871046e305 100644
--- a/lib/raid/raid6/x86/recov_avx2.c
+++ b/lib/raid/raid6/x86/recov_avx2.c
@@ -176,6 +176,7 @@ static void raid6_2data_recov_avx2(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -293,6 +294,7 @@ static void raid6_datap_recov_avx2(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
-- 
2.53.0




