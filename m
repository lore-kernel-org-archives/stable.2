Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081381;
	b=NrIfgng7AmMsg4iLg0VN3DhvIZM249ZP77ZPsS2fvvM0tpLkfFJU6Y7fyG53Y/4rF45x
	 KYbINt5VI/vByR/r0KYrR8SMezyHGnjasP4suXJ3TPlGPbt4wUfmUNz/RA3TDc6N8z/Xu
	 HBIWhH3KVKqwfMTc9KNE/1suW8uvDi1DTgQJzU+y5799zBLRA/qOomCHbpMh0h3QTjmH7
	 Y5eNK0CbZxVGLK2rM5ONl5xC/oWt2+8blw//UDlG5vxkBNL5+dmKfeFR+xAOId/IdkyVS
	 xMLJ/7Xw9d1x6gXYC/Wtbfv6zTsPqAFGpJ1mDcEqaKgtg0DEHSGG568YJYI3L5x0xeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081381;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ivSU3kKMi0Blbc3cyZ06wsXOHzi/bVQAz54nnFSsCJ0=;
	b=V1c+11yqiuJs4xyfYh8CRm9KSmEikZOr2ViJgBIdWuXLq1R3DPVqgtqe/91DicchBW+C
	 xkt+Nzq4r8gNG0voTVZcSopUY4iXcjO4UkTa9LJL7jXbyhsJ8MfR9qX5Aqu/ZH3UjZlTz
	 xgqi4f5nqosNGkW3SjO/vgwNgW/OCqHO5iSaw3MtG4+7FJ2ojtBw0FVlZj4Qc/DYGYSsH
	 eKFTSyeUs4LQJIpEUdYUKZTcYKXc8OoyDmqGwbAj/to1cNjeaIJgp9zPJHFjUfXMUUZip
	 cLSU4Yslm8bmjtHzAoz5/Gbg4sWmLnufLfSMiZyaIwinzdwgheJLfMlzp7F2fubSQbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVbX5lr3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062B4606A326;
	Sat,  7 Nov 2026 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVbX5lr3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5111F0089F;
	Sat,  7 Nov 2026 19:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081380;
	bh=ivSU3kKMi0Blbc3cyZ06wsXOHzi/bVQAz54nnFSsCJ0=;
	h=From:To:Cc:Subject:Date;
	b=SVbX5lr3t5i/fVbJSi/LXJ54g5kiNIncaYQ0fGzk0118axvxqk/JsRnFCeQmCgd3W
	 ikipM/7E6AYuQ6HHDo5X6dFaakKppsr3gBW8qX6W86T7eJfXmmKRh5SxMX9ssgfUSK
	 /yl21utFzFThJ0yAXbBkSYz1WiwsAL/nbwmOWaOWN1WNLu8HIDHaPgIIz+UOmFUq1Z
	 3R/cMDUwPMPtIltLM7Du1XLqGUJSPYiReY3eyqrZZz+QSLHhHwPpfIEGO42hPgIQqZ
	 heRlGGG5hsPZwfg2Ggw2c6JVPX5FtcFu6cIREcag+6fFLVmm5Z3GvEsChlsxbEvixl
	 e3vMoTM6I0DLw==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.12] xor: add missing vzeroupper to AVX code
Date: Sat,  7 Nov 2026 11:56:16 -0800
Message-ID: <20261107195616.74804-1-ebiggers@kernel.org>
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

commit 7b8fc26c40d6cf4c6751a045c9e42bbb7e78d81b upstream.

Since the AVX optimized XOR code uses YMM registers, execute vzeroupper
before returning from it.  This is needed to avoid degrading the
performance of any later SSE code that may happen to be executed.

(Backported to the old organization of the XOR code.)

Link: https://lore.kernel.org/20260831212248.213805-1-ebiggers@kernel.org
Fixes: ea4d26ae24e5 ("raid5: add AVX optimized RAID5 checksumming")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
---
 arch/x86/include/asm/xor_avx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/xor_avx.h b/arch/x86/include/asm/xor_avx.h
index 7f81dd5897f41..c6450acd055d1 100644
--- a/arch/x86/include/asm/xor_avx.h
+++ b/arch/x86/include/asm/xor_avx.h
@@ -50,6 +50,7 @@ do { \
 		p1 = (unsigned long *)((uintptr_t)p1 + 512);
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -81,6 +82,7 @@ do { \
 		p2 = (unsigned long *)((uintptr_t)p2 + 512);
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -116,6 +118,7 @@ do { \
 		p3 = (unsigned long *)((uintptr_t)p3 + 512);
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -155,6 +158,7 @@ do { \
 		p4 = (unsigned long *)((uintptr_t)p4 + 512);
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 

base-commit: 5c40a1750f44dd6c7292d8c8d0b4ffff1734576e
-- 
2.56.0

