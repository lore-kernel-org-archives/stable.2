Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081461;
	b=c3zdzVnlESNk7ItEIieb3ZF9oohaJPLKDnRbdu8xm2pBZJi8rLc1ydYA3wAVpjYmEI52
	 kJ847atYBqd2aeag2RKp45hYy9s53863f2x6bDpX6UBQ3Ro1pyE3sxmmXxRE9gXfwAYq3
	 75Q4HCAgqMKPY12FXvvwmL0/2Q73NbXG14DCbC/zrcqvE9DRkly9vG7S2TdtFXoKebco6
	 aV7eBHPvAMGDImGZRn/Zt6zEQUh7ClL9n07ALOWQaRzYxaNSJ703QBRVaVDQkAQ6ULTfC
	 RlsBXmvnz2LsdQD00SKhsNPUBRVlL44gkZBYJvoZgFCLsjfVcPV7dMmhJlwZePQ5gTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081461;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ysw3yPuODH+f774xsi2kHa6BO5Vyv4FmY7WPcLGjw/k=;
	b=Rdj4zYv16URMOmySiMZ0nMzdxfGj2+B/ywHwQn+YcJmHHigqi3PvycQH3NmHCVAzXHCv
	 K06fGPh61s8eIFn/cm+2M2Ai1VPaf//zpypYtW2Fhic/Y84SrxBLXAhZ+Y57G/io2qwpQ
	 9gG2WtOoJp8oa2WGX43mMsPm6QGu288V9S8kfH1qrUTmHAHg0ByRWOgDHhehPoH9rmT4Z
	 traZoADeBDi48J0QbZg0DIn/mWNUztf63yrirSlK0+mUuwEQUMnFONs6oE/AQHIhNRVmj
	 MK+4Pj2w+soGHYJBYerQX7Kpy7T2gsYra27izq4ykFaVfi9soKq7MDAJOcd0wnXLfVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SN6PwaT7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D8606A32D;
	Sat,  7 Nov 2026 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SN6PwaT7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4DE1F0089F;
	Sat,  7 Nov 2026 19:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081460;
	bh=Ysw3yPuODH+f774xsi2kHa6BO5Vyv4FmY7WPcLGjw/k=;
	h=From:To:Cc:Subject:Date;
	b=SN6PwaT7VylEhsYQiqfN1woIEk+KhWvlcdNeWRPiVTRNFb3ncHnktMZEzjO0kfyBa
	 rPBCB6wsUTjPWAchXkSPg+gOsAk7IANoqTiNw0YCySFDevc62dlWK9Dg0UkiCchAXz
	 UGn+1esVnn1t3vW3dKofG6TvoRqT6E4r6BzMuWDZ0Ht6DEz6R3JkYeT/8pTsbw5ZjY
	 rXbAHdFJWPNfDgGKCY5d/iMof8Yt5Sd71R57Y9bKgZejl9P1/uXVuQTU38/P1JZZWE
	 F3S+Uhyy/GdGIBQcXIJ5fugyH6sTzxOFeLZi32tLyOkYlurdk8YQLu+ckF78Ex8xGS
	 KPAe9wdDX5Gvw==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.1] xor: add missing vzeroupper to AVX code
Date: Sat,  7 Nov 2026 11:57:35 -0800
Message-ID: <20261107195735.81802-1-ebiggers@kernel.org>
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
 

base-commit: c75b0cf0982c00cddfd88d1acf3872f79b40980c
-- 
2.56.0

