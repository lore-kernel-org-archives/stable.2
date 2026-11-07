Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049358;
	b=ShMlXYjRzCLluRLOnzsyvqr+6J9yxt/b6GGJipvpfQhKqXVG36e/mIC6pC0BtoYW/f67
	 mFkFQntS2RqluyQxsYsn78yqRt48ug39XNKteP9ZZMHQiNNAj8ok4L5/bZ5qCzf4ZJ9lH
	 +NoMQLQpVkE27caoK7wz2clojqHT76gpsVKPyqhkXG4j4HP9UQa2JuA1udx7o13ueXzKf
	 xxDAMVt53q4Wjxct3gK0gMONacrXP3/5GhM/o+3CmccNSXNeafD5D9qmcxrNZ0DjROkug
	 TxkUFac+3MYJLPIEgN83kqTFgDBt8s+QvXpHaAEp318PDnEby0TEVG/GhtvGm881cSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8zP9pfhVcyktfPDhHfrkIN7YiB5Y8agG5C7du3h54ok=;
	b=4Ts0HVQF5vad7xoImSu8iBbc7J4HQIAjsIR3Sl7GSRCDtHXX2kDjn/TeqjvzM3oS1Hbh
	 p9Jsx0p7xH77USmLdJSpdmhaKWWM1nSbHgkPzSSh5lvJgXBKTU3QHHBivhMs17cWGeEOd
	 QidJpDPPKsMHK8F+7woLZgcDw40CgFiD1+DX3GI4G05Nen4jDm+X5ZTjqkrcXQLKFw0Ad
	 dXARoai1f6NoRa+0KZlWjx/RKmJNCAhKghJODsmOGCMLNEHofFkpU5s+s6mK+J81DxDUE
	 /5TMGG1ZiIHZFcuWgR8m/c0Om+YRXOGNa+VfgSUs+HS8V9IG111trrTZeLgfhkNdyxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dttkz+pN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF2E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dttkz+pN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DEC1F0089F;
	Sat,  7 Nov 2026 11:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049358;
	bh=8zP9pfhVcyktfPDhHfrkIN7YiB5Y8agG5C7du3h54ok=;
	h=From:To:Cc:Subject:Date;
	b=Dttkz+pNewbEP89FfjHW0R+Kxjq7Eq060soLf/VAnW4g6b+VpE2Z94tXFkqXQDHhE
	 RPjzIEAUXpHfxqytMRdu6nCQwrRhTl8igAeEShpTgf5mZK5TCK/5a7ilIaLt8kkVy4
	 gqvMAfj6ihKVd93VcFrH7Lqw5Iyjof1HALzOttH18UkUK2iB2KL9O0zbcLOSDE1e0D
	 iFI+0eU6ymKGrq8QO5iqw/scvrcU5+vFeoTOxE4tHiPsvf7EbaVJsGPVJB0GE5bR//
	 BA+A2D0eVoOYlgWXCSsn5g9wb2qtP0Fxvcfn+Ik0GGn1H4YAwN437Bx7Fb/bFwzbbT
	 orsTtxCl3jrDg==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] raid6: add missing vzeroupper to AVX2 code" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:02:36 -0500
Message-ID: <20261107060236-failed-5.15-24f1241cdb05@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 24f1241cdb056fd630e6710a916e0f7c8c910a70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060236-failed-5.15-24f1241cdb05@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




