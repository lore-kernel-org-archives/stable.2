Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081428;
	b=xHIjleAb68XgXS9ktqceeSvCjL+W6CckqMkuzqSTtZcUM6IPCakiGCSsk/0XUMbFtBbH
	 crzV0QEbEFoiVVcFyAYD7gPYW56aumUfMnFRHM9QtGZDoGjphVa7VbnzRDqNgSn2O8/t7
	 eoZjreyEzahdYthJ649EhLyUUuGBqpu9pzWXkl7nN80aC0D3ZBrG7mflBExQzp++IZjAp
	 0u6EriM1/C9608lkYxIODB4tUV5m5tawfQxv0egm06i1EoSTflwPuzhMSjjgBOIXEx4NG
	 QTgeaWfgRSkbq5uikUQhD66k1zmo0h0jsICk/uN0iH0S1L5oYRFUBR00WRtv6SGg1tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081428;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eLe3eXmXPdzxlMK8YcXnAKi2EnTg4jowN6HdPRQ52e0=;
	b=juMBqT0BqfonnYXL2xlW8zubi627hLC55IJUnETGv6z2VNWaG4w4mqrRb+RLK6y7NfhK
	 vGCZ9D47q+czgGojL6EZB+8+MT/NCntQEDwYVnNn/3DUiur1S3IZXY3+fMzWjMB4u4J32
	 mxQqziFPsebzuLnj4KMwuHrINrYwTEbJK3aX9BkZnxwBIIRmMLoLndcWdxBeqdD2ZNI7J
	 fJci9Moc5i47o4g2Uq2WjZdWoRptOdNYdqwWJLloLGjcZeJ6tZe7wJ9+KmioA7LtSx1AH
	 aKWBTXLrufbKUNuRW8DDLGknM47ehtfTzA4YPugGpr3ZxEJKSO8NelMXFgXcRq5o14Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B/lLfkVd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02B606A32C;
	Sat,  7 Nov 2026 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B/lLfkVd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9692C1F0089F;
	Sat,  7 Nov 2026 19:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081427;
	bh=eLe3eXmXPdzxlMK8YcXnAKi2EnTg4jowN6HdPRQ52e0=;
	h=From:To:Cc:Subject:Date;
	b=B/lLfkVdKz/IrScPB3EVzFNAjBl15i1xZvP6hEnbBsS2KZ4OEF+yChS0T/samZ3/Z
	 9O4/uqWSIn+tz+IL207eN+Y6vRc1Ko6tsDGm4N3qG5NF0xUTXPG+7doXFQ3ck5C9yl
	 YvbzpVPncXiRg0YkekhV83538YqWHT7mfFF8a/GiyuPBjq6yc7Wq/lzTwT+XXtB6s6
	 UwatZuoFs7mW2YH0depeX1DNxQ/ddgF3HKYMPK+CrNNJ07oJmgEhg/gZAyY8C9zgQ0
	 qiICCLUJIps/RNdAphNuBuzYYnaCcdDtx5qswkHwyibpBLumCFrddEKQrSzfJEwmsY
	 FiZwD6dTJ5q7A==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.6] xor: add missing vzeroupper to AVX code
Date: Sat,  7 Nov 2026 11:56:59 -0800
Message-ID: <20261107195659.78122-1-ebiggers@kernel.org>
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
 

base-commit: 5139929c698c273e07cb0635732f6a918a7b8e78
-- 
2.56.0

