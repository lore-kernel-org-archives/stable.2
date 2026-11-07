Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046154;
	b=yf2ZYv5FQf/AITqYDx4JMUPyL80X+ZEjFSpnK5LoRXUVElhsjh7wNWNJ9EuszKErpsIq
	 dCGj9KOg8bT7KWH6MLw6XH7ko9fu4DzRGCeABgUhrxgY0/dsJnlxIPlopc9ImU1Ld2l0T
	 p+4cEswF4JhnmeFd9ea5eD+90s0uWHNJYg+w5iX+Q5aSgwcf+qIGfBVi7Y0mZl9U/RCk1
	 7T3NZlf0Mgq5VPLogHYUCg2oM2d2qllYzIY4GHDkfJPYfjKSIdEgsFGdw2ryJFytf95rO
	 QD8ZCqj0f7JwUAP372VK6OKlbL3V+3Vr7a6+Bo4bEgRtSnfYyrCctPyLLAnLFwqF4vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046154;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CZJ8oR0HPyaW4skL2EL+OiO8Gj4qGnSIyIISIhNIZj4=;
	b=NZHJWkGZ/iyZ2Bw++9ekhVXji5B4TbptGqlS6vPDetb4FvKBRmff3Cn6NQDGHCkbwLVa
	 pZCqPAVXL3HC+adJmQjSUCY80Z0V6IqlXNxEdCfxyalj9e077gizC/P6N2euutHg5accl
	 NHaOvwNvryTq81NCxuH6fLm9FC5xRd83cIMuSf0PFMlL1f14a/0wTBJ0J1A28PAKZOiM+
	 Te9KiCCK2JsLxgOwhfY7Wo4zY8+2D8laTfNYrzm5kcQnofTA2Q3W2kl8tZ7T9dbMGKEgB
	 V++xmWZbBX/P4CkEMZwM+wRcpo8WJtHMZv2xg9UPDF2r7RxFHBqRkqOEqLsVUS7pMFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQfoP5ed;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198BD606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQfoP5ed
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C481F0089F;
	Sat,  7 Nov 2026 10:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046154;
	bh=CZJ8oR0HPyaW4skL2EL+OiO8Gj4qGnSIyIISIhNIZj4=;
	h=From:To:Cc:Subject:Date;
	b=OQfoP5edAb9YltpDO9E1WgJSiTpfMd86EduKzJm/g4e71BA4rK9uDTFKUKhxkS6F2
	 izcymHZHQtWRDWPrJxdqR7o4Ffu1paxAwDsWu6XSi9ZdHk/WL6x2Khv6GCEtT3o/y3
	 5ojATG3FCOpiYdugA+5nJoSZh/U+vpxk/moXHNUOKtGH5Z4FDiYfCg0imJXGY5CxEK
	 c0Qf3hIRJEq3+6VsZBJt9EPLO5K/PrkxzhRB3ZOPLDZ0KfhfVVO78aQSjIXCpcrGS2
	 lae4NLeC/ghRK/kE1PXySjRX0CrNW/dZ+VF7ZGlyKpPhAPiY4827pbs+3Si4wdDW7M
	 bUxFC23B8mehA==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] raid6: add missing vzeroupper to AVX-512 code" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:09:12 -0500
Message-ID: <20261107050912-failed-6.18-b82cf9e49c1b@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b82cf9e49c1be7cf1fd8e1bd806b0cdd25ab8127
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050912-failed-6.18-b82cf9e49c1b@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b82cf9e49c1be7cf1fd8e1bd806b0cdd25ab8127 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 31 Aug 2026 14:23:16 -0700
Subject: [PATCH] raid6: add missing vzeroupper to AVX-512 code

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
 lib/raid/raid6/x86/avx512.c       | 6 ++++++
 lib/raid/raid6/x86/recov_avx512.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/lib/raid/raid6/x86/avx512.c b/lib/raid/raid6/x86/avx512.c
index e671eb5bde63e..772bfc4af6dfd 100644
--- a/lib/raid/raid6/x86/avx512.c
+++ b/lib/raid/raid6/x86/avx512.c
@@ -78,6 +78,7 @@ static void raid6_avx5121_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -137,6 +138,7 @@ static void raid6_avx5121_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -208,6 +210,7 @@ static void raid6_avx5122_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -292,6 +295,7 @@ static void raid6_avx5122_xor_syndrome(int disks, int start, int stop,
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -396,6 +400,7 @@ static void raid6_avx5124_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	}
 
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -529,6 +534,7 @@ static void raid6_avx5124_xor_syndrome(int disks, int start, int stop,
 			       "m" (q[d+128]), "m" (q[d+192]));
 	}
 	asm volatile("sfence" : : : "memory");
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 const struct raid6_calls raid6_avx512x4 = {
diff --git a/lib/raid/raid6/x86/recov_avx512.c b/lib/raid/raid6/x86/recov_avx512.c
index ec72d5a30c01e..299a3f044d616 100644
--- a/lib/raid/raid6/x86/recov_avx512.c
+++ b/lib/raid/raid6/x86/recov_avx512.c
@@ -211,6 +211,7 @@ static void raid6_2data_recov_avx512(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -353,6 +354,7 @@ static void raid6_datap_recov_avx512(int disks, size_t bytes, int faila,
 #endif
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
-- 
2.53.0




