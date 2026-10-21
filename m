Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609289;
	b=pG2IZumfpxYi+el7z8YLWOa300PglQsJUBZu9iv0QXYX6l41l59bTqvPxUiL0bOX5wZf
	 nipvAtevf/p1GVf3N4/BnafeH4W+IWa98BbmqXxfk3SdnYUaPjIrORr+9wdh4A6W8yeRt
	 bQs6i/3+eh3FkTjn7Xr5A75xNym5z2knax1YuFLQ9onNJsiJRztultlXhuC+JJZHn5+PR
	 ko8Xj2hmr5Puu4M7cuFvR8WcGoEznPaHzXbi0xL0nDFs6jJ60c0UTsMpnqnr6Z1nkAeOh
	 WmRXGa7WK8P6mh0iImAHSOzAFnPaEmEYcVdAaY6A7fM1Ibhwc/ODJHhf9yP8741sehA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609289;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PRe2NYJxuhncsR4aT3ffbxqidw3GkmS5s7J2yFuY5Wg=;
	b=hH+isxh52xxapZ36OrU+k5MPPKigeWavw4a17WiCSIMwPCZFvidCAe3AOG6yBbRFnF9Z
	 jKuMsDJsHDHFtvNqBD2Hm6XjLbkZUnKu6fgfqDTSZjqqflg9RWOjuSGKeMqtcSXbnAS6o
	 y7WmMo2P2+O6izZ4sVgNt7Z8cWgEymwDtpDsbXRZkuObAPajQ1f3OFVcCaRm/53euEyOY
	 d9tU5FQJqPJdxAe8dgB7Y1UAhNv2Pknzq4os6hs6GFt5pqwK/euaLtli/XjLNa/8Z8A3F
	 Qz1T06UGIGusmTAkeW/n7hHeTcUrcNlTtuUD/njb5XIvbP3TCJabF8Xob/paJDy+D0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOni2VZV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D9606A31A;
	Wed, 21 Oct 2026 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOni2VZV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147DB1F000C1;
	Wed, 21 Oct 2026 19:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792609288;
	bh=PRe2NYJxuhncsR4aT3ffbxqidw3GkmS5s7J2yFuY5Wg=;
	h=From:To:Cc:Subject:Date;
	b=NOni2VZVMGgGp5CQiYLq8aRma5CPEiWa9jfGg4tGj21+VVrnAq4ekmHJ8N+6isZ88
	 +u324KOgg2yuKbJ9XMz9Qo1DkzwGYrPXO8X2GeAk0GVeG1IncLAzTI4thLuxviz/DN
	 zjLpotDY/mXW5fMresvQF/sXsQJvj3+FIV7r8CM/gnyCanwFnjr5nRs3q1nhVb5GiA
	 F03WNTWODGLYmONUi/fIBmiwcbyQSMUsbWEivQTV8Go8qFF89MvXjtPE8yjmCig9LO
	 9c+ZANP4VH9YuAIKzjwlfBpdUu0XItygv3BmaJJ2CMEVAJPxEJQGnFeZvmJnel8moC
	 D9hPJUbMPviCA==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] MIPS: c-r4k: Flush the cache error vector before writing it uncached
Date: Wed, 21 Oct 2026 21:00:20 +0200
Message-ID: <20261021190020.20954-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
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

On R10000-class CPUs, a store prefetch while copying the preceding
vector can leave a dirty line whose write-back overwrites the uncached
cache error handler. Flush it first in r4k_cache_error_setup() with
r4k_dma_cache_wback_inv(), as dma_cache_wback_inv() is a no-op on
coherent systems.

Fixes: e01402b115cc ("More AP / SP bits for the 34K, the Malta bits and things.  Still wants a little polishing.")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/mips/mm/c-r4k.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index d8aadd3dc057..ae31966ac65b 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -743,8 +743,6 @@ static void r4k_flush_icache_user_range(unsigned long start, unsigned long end)
 	return __r4k_flush_icache_range(start, end, true);
 }
 
-#ifdef CONFIG_DMA_NONCOHERENT
-
 static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
 	/* Catch bad driver code */
@@ -786,6 +784,8 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 	__sync();
 }
 
+#ifdef CONFIG_DMA_NONCOHERENT
+
 static void prefetch_cache_inv(unsigned long addr, unsigned long size)
 {
 	unsigned int linesz = cpu_scache_line_size();
@@ -1684,6 +1684,14 @@ static void r4k_cache_error_setup(void)
 	extern char __weak except_vec2_generic;
 	extern char __weak except_vec2_sb1;
 
+	/*
+	 * The handler is written uncached. Copying the preceding vector
+	 * may have left a dirty cached line of it behind, through a store
+	 * prefetch or a speculative store; write it back and invalidate it
+	 * first, or its later write-back overwrites the handler.
+	 */
+	r4k_dma_cache_wback_inv(ebase + 0x100, 0x80);
+
 	switch (current_cpu_type()) {
 	case CPU_SB1:
 	case CPU_SB1A:

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
