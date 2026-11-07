Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081499;
	b=dCCmDvY2ILr5UzOH8fTYs6hWJ82vINQCq2pzWWnEd6YibpZnk4PKsJLw/zrzi2V3+Ldp
	 gBpwZwk39+Zvxfy82GPa2KGSfFsakp9aX9piprvTTXdBRPCu2kixhmibMlPTdoSrG18CO
	 Ce6EK/qY/FKBPCxKTbOuVs5l1ZiDB6We+LKzIFT62ktZ93BEyjdKdo7hoHmGtAKnXzNgD
	 IuXC1l58HyNLt6icHzGME6JmQ98zPLSx77pjmO4an6poxYbqKNuFpfLI1d7ZeHTgYxYWQ
	 bVryoAeLE0fQ8bpkUDjl7iqdNVNkWn5X/50cgdn54CxLeHZD2kiehb22wJrK++JMrbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081499;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NlGjQyu31uV9g9/CJYEFE/EWIJHar1jzX4+IaOmjCko=;
	b=AQJl4FUq9hLZPzOOXAML/lFJp9IioWqchLAPp7mUrsznt5u1nfrVZRltG89DioAZ8Xwz
	 MzqgyiomhsdoPMGZFpY1VJSoY7lRn0C9KUeZb4SYDgEKK0y3FrL7BCtOxQ4oSQwgCP+YY
	 C+VcQwJMR436uD3DVCk0Snh0HMoOL+O1BzWHQp+AagYgqkAngc7Sy+eaRqpvXm+EJG5ZE
	 F/OnWEklPKOqtuvF3+vcW3kRqlyBaxL3nIWS2qt6Qp0Ol+YOTVWZWQUJnOs0Dor6wPEEr
	 IRHJeDFIkbW7PjXEAJBepOwQ1j09Nl6GKjgDd5+yPCBYKK39Pb8Eytc2ybwzQQIZWqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xgieg+K3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CDC606A332;
	Sat,  7 Nov 2026 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xgieg+K3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8AF1F008A2;
	Sat,  7 Nov 2026 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081498;
	bh=NlGjQyu31uV9g9/CJYEFE/EWIJHar1jzX4+IaOmjCko=;
	h=From:To:Cc:Subject:Date;
	b=Xgieg+K3SKg2yshTSGc5BVdu7NBT73ycht4PIenP86HdGVinUBcD/XuBrpEIheTOq
	 SHU4OdvNbudO+4SX4yt/QMYc4EdZ4pbWXnKHGf0fW2LGLGuaA4cRAC8/ox8S64yVbA
	 8hToEw0esJNEMVG8SY6cNY8KTpREOT7P0SOBY6jKmoy+UuY8NspMtQL5Oy4tL1d5fb
	 XvfPcN4/e/7xrUCCXcFJie0D8xYGERt51jGMlOSsg58W7vfON2+fR3SlycKtZw8CSW
	 eIOB6ffImezjkX0Xij6sTFqkfYbh3bg6aXxzDJyuGrX31QHAiHRP84FSQdOT0Aq8n5
	 P2gDVWldekoQg==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.15] xor: add missing vzeroupper to AVX code
Date: Sat,  7 Nov 2026 11:58:04 -0800
Message-ID: <20261107195804.86498-1-ebiggers@kernel.org>
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
index 0c4e5b5e3852b..10b703dfc7c43 100644
--- a/arch/x86/include/asm/xor_avx.h
+++ b/arch/x86/include/asm/xor_avx.h
@@ -49,6 +49,7 @@ do { \
 		p1 = (unsigned long *)((uintptr_t)p1 + 512);
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -79,6 +80,7 @@ do { \
 		p2 = (unsigned long *)((uintptr_t)p2 + 512);
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -112,6 +114,7 @@ do { \
 		p3 = (unsigned long *)((uintptr_t)p3 + 512);
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -148,6 +151,7 @@ do { \
 		p4 = (unsigned long *)((uintptr_t)p4 + 512);
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 

base-commit: 29c6cdaac04a6989a7ed4ae4275ce4244e617f58
-- 
2.56.0

