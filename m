Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050357;
	b=QU4Gpk8wUExmadgs6hTOlf3GNaGJMeUwT9N+hnpUwsqDOo4Qt9epyvs0aL8A7jmOzMw9
	 IWZ/P8SHSwTTshR8jN6Dl3knj4JMmKFw20hiBuG7cFCH83seCUAbJU9djkPNwdMQAq0Dt
	 OSI3K5qK+pAP2E7D7S2It8JARUoT/IBuTUMgfdJqzEd/5k+Pb4/BIDHxbd/v0s65spcHg
	 ISO1V+xstU/OD+f/qFimImuz95y5xbO6UEVX1AKyTqkd8Or8nzeF8CsNjPVEl6oGqE1wm
	 ZcOQ6nvQPa79p4g+N8sfjPzWec/TkV0XD9qwwbGPMBSJjrW7cqa6+vVwTFNSTpvsAsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050357;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CQT6K83A8mtuACmSWZe+OH6D17RfeW/qNW6e4phUZ4c=;
	b=AaxhSGZLu83TDfZw/0e3xxdnB4O+kgV4kdYWIfkrndITEtYt0RUmq4ojgXIB/LEJibLA
	 IxPgAXM7qVE+d5TQ1eTTJs/xBmJZ20llH7uyFuzRcLxLJ+qsRaWSBHgo3ID8hAm/ZXg9/
	 xT+W70XYo9jJu6i8Rt6iTxd27QzHH7a27zjzNOcW6G5dgJeoeE/xMYvKMmHkckgGUBEjS
	 vuHpoJaS2F4C8JRdk+PRL4n1j/pkX9Hv1ABDuxfXBKEgEtItMe9J+KR6HLSUTsDVYH8SZ
	 7t4VTyb//2/dQjLu0lI2OyO00JUQwISlhbtxHFVr0k0Ar9k0T/AED+9FRuL+199e2wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KvXTH0gc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F469606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KvXTH0gc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915D61F0089F;
	Sat,  7 Nov 2026 11:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050357;
	bh=CQT6K83A8mtuACmSWZe+OH6D17RfeW/qNW6e4phUZ4c=;
	h=From:To:Cc:Subject:Date;
	b=KvXTH0gcp4wTYTKiw6W5IR6gLSEfN6kgZGbBfOr3ifTRBstZIrVDtmVN2GIUytldf
	 YQBI9P1d68bAPuHoTEgjMKZPiMjoIzfIA5RR4Yzd83L3QeKXX7dRaULzV1YlEAsgXL
	 wb2hTamng5n5fUQ8wNW1YnWFrIf34yA/2P4t9TeDBfcJ0Weg3KVvpEV3YItWA5uLEg
	 hARWJ3UCwMdT7/jtbYBFB9zSWCO3oYy0Mj6QBgwcaYDqbwAjMDLEXr6Y/simIAN1po
	 Ugy2HmHZL3OoZuCYeuLBK9zePecPlRvEJRzbtYqlcYTAgjmU9+p0CNWVLcM7/6PAMR
	 Wjxa7NwXEAZMw==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] raid6: add missing vzeroupper to AVX-512 code" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:19:15 -0500
Message-ID: <20261107061915-failed-5.10-b82cf9e49c1b@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b82cf9e49c1be7cf1fd8e1bd806b0cdd25ab8127
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061915-failed-5.10-b82cf9e49c1b@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




