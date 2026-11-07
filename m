Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048310;
	b=JlcQN6IXkBKoZnEL+d5kLSHr63RLkG9umjDYhcDKmlpMIEElmDeXW2C1C/PHMgeZr5db
	 rODsGiSJg6yjhtpp2Gbo/LouZ1oyGVYOpyGp3BCOrK3zl70EuzZ0vm4gprnT/yLjiXVQg
	 Ee9L8y+3METKnCJu0mqMxZ/SSAtwWWcJiaZ0mrkO9DcBgzvdU6N79m6dUOkREZMgg/BkY
	 2DkcuclLJ98xaEAfVjRWcEq+JLLt1JiOY0V3RqW3J0TW4OQkJXrvhB9M0UORSf5p+R8gx
	 thHLoeBBaevi9SsHcchM7CmWq6JJn/cum0ITYfNqAyXXdXIa8AGyA8X+5IcCTrSQjVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048310;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AB4yAgsuW2YtevWe+ZMu8wIcDQbzxk3mNm98n27hmwo=;
	b=M/zokkvZbga1EGUw16V1C460tV1ku9wvTlpktNthXdIcMphDXL2F3HV7gO4+/WHnSk+M
	 j5fQTnnsuiwQQ2laqQ7VN/Le5jCPpd25niUcxBkV7e9Mrn6CkpBoUX2nMJFKCTmy+goo2
	 DrRI4WYnlHiolLd9oKRbKjcEwYhY3Ip7qLlcCqeDExWOJyDvvDv7aLWXfj2/BEk88EQmd
	 J3qAJ+fSNUSgtGM3N4TV92T42jw7w2clKT8szOX+xK7tTZXXR3U/cK9900afLHZHxQzzW
	 B2rpey0OVYWM9r/sNHdaoqM237NzqjkuCfCE3gl103YRyxBVbKEbhGUo2v3NIAEw7Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFcj7XBt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFcj7XBt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989D31F0089F;
	Sat,  7 Nov 2026 10:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048310;
	bh=AB4yAgsuW2YtevWe+ZMu8wIcDQbzxk3mNm98n27hmwo=;
	h=From:To:Cc:Subject:Date;
	b=kFcj7XBt05kioc4eMrw0tOCyZ28HGfDOdmyulRR/DK/4Mymz4ResjhGpqGYUzydkB
	 jZ8sd3dUPFhhMuWfMLxOu00czYVJR8e2F5PTCqHf4cBMhyiQe5ISqDBBST1YOLQOu3
	 C4uFh3G0zZikcpvKEMAZQKW9N0F6v1r/SSNBktkzx8QqMKeFlJPx1LeEbIBsQ5LhXD
	 H9UP3jWHAhuiwK5W7I/uziOPouIZfH8UbvcgHFLYbsm9sfsq0D7hoCsQAZJ1HD/fbI
	 L8EIN5rsixwfoL2QvGCJRTXQWtzl49OaMJLbwxrpUikkcFrxiC658rR4iaABKr7mtf
	 EesTb+lu6Asrw==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] raid6: add missing vzeroupper to AVX2 code" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:45:08 -0500
Message-ID: <20261107054508-failed-6.1-24f1241cdb05@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 24f1241cdb056fd630e6710a916e0f7c8c910a70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054508-failed-6.1-24f1241cdb05@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




