Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081201;
	b=0dUfQvgTfReoZVnLo3NoJCiJopSV+y0Kdve00jIw9p8lklVy/pzO+LfOJz3EI6aZ7r9T
	 RqKbZhbwTId3bSAfvBw3DEB/BnOOEO3gl5oYXK6fvNrRxdd9yh1uhrRsyptAzLbok8HsI
	 Ub21A9zrpv1WlP7Hqa2WaQuuEPhj3cA1Dm0o/+bFEwVCpXpxd+9f+FVd9TfbHFvV4ndE/
	 aEtu7R5zvQ+iYqngHJity42uDHNw/q7/IpA7SjZiSWfriAxnH+zqnLQ1XrQG4dGu654HT
	 BtCl+IUBb1c7JCCOq3caNYxNuK+jjgarTKoM54DUpuUrdeKXlprXbhFKL5+UfQLCrTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081201;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AvZ97yWocWxohysGgiociKqR5TlzHE3BV/H/45G4aYE=;
	b=xPoGdBG17jYKg97xjtPoQ0AdtO0jKX1l9b8O/dhSDhREjisPwfbGmnRFaXYWUfczB+lD
	 7LQOGXEnUqty5kF/fOxEbtZLeaaxk259yze2LyHhsZdkPjftgcz6D4fVTjLvf98c2MQ7P
	 ONlCCpczkukw6REZF3vRpbUB0YpJNyUP9FeXWYqumgIPPfeY0yUmt2lR5+f6pR+sJFaG7
	 Fds3GNaLcDE/M7MtMh6HihAoTsfVntlHB+mEWUP8qZHEnH1V4EqIQ4gz3aA9hMOb0LIsM
	 2iiZz0QPWLkwTtrEBHG3SQUYtww4ROcTrWYy5MsDQ6ftLkVulqcobdOXgLK9cqtRAyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAmNdvRD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02E606A326;
	Sat,  7 Nov 2026 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAmNdvRD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6681F0089F;
	Sat,  7 Nov 2026 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081201;
	bh=AvZ97yWocWxohysGgiociKqR5TlzHE3BV/H/45G4aYE=;
	h=From:To:Cc:Subject:Date;
	b=OAmNdvRDj7vqEWk7fTx9FoiUHwJKkmtQjHz3oVGb+Patc9cYUBAK1s7/6lIhq9aMV
	 UeRf6j8QOy5vSYBUH4320gmZA8ePyIbmtvbtA8ZTPU+pPSvzRvGgp+KrsUOX9hFKqs
	 OeE+PzhXr3sdXGtL9oSU01FaoBVR3TpEIJrTJzony2gE/S3EkhqAyURKOk2iIzBVeT
	 0CLjgRf8C5cHvaCUY+FJD2acS2tb53yM9Za5EU34Cv27uEAMBdNKyTQQxMJNp30Vsh
	 fNM75pvb62rBLwoVEkzJrD1MirL4j6Ld9SEVX8Jxza/nATnCUrvHKbwV6Fj2qP06/P
	 Wpipmj9F7INrA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.18] xor: add missing vzeroupper to AVX code
Date: Sat,  7 Nov 2026 11:53:18 -0800
Message-ID: <20261107195318.57068-1-ebiggers@kernel.org>
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
 

base-commit: c3f63d70f236bb7685e6d11d1d9b5b351552e600
-- 
2.56.0

