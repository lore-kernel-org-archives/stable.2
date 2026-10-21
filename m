Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609099;
	b=q9/Z32Kg7bUYTsGDVIMbus1YKbQ780mNgOU1NDOgVX1MY0XDVvZsXva1WUboms+83Dh0
	 uncedk5TZfI0yBt285d7S7Bjiv/oFk3YJKo6qz7Y3ohlMkYINFi6C8FBodI3Z11QdcjGi
	 67gLM9tc0B8w6k0JZvRZjf+GRvBFLG1XSfu4l4WoulvyI/3Iz4rk9bVL0uTPpNddLzdbX
	 BOBD9f5TBcFGOpE36X7LPp8LBaVPGuxBxA9xWejVoGlpgPx4CVNKCOQPBtjx5F6U7QRcb
	 GuTMca2WWfgNbXPw4BPExgypNQSzypAyRSrAf9VCnrMUJryTMdje4ShFEas2bT5D0wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609099;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xRvd94tmSxAaQgza+g8FTO+Z/dinhulsKwwfnc1BqFY=;
	b=5L56NXDI++AwuUGi8xvaWqnW3IMhslnsoVW8zIZVb1hYZFw+8X/BzDPs95MAk3/THp+X
	 wVX2Z4mc340dQ/WLq4qsU3hyl4qmCovUqujb2fqqIMn/VZlbrwzrVu6lwh4r/ZH+p29EO
	 5CjXA+MrX+Ysk+qSVNQ8/1m7Jn6RfA3dX0bRmQ8Bk+tn+VyCKRlOlYzCPxBtUu4Px0kFd
	 H3PTnB8IvRmQ4RlO7emuRvFY2gu88nPv+R3QFBI5I3Yw0FFzhWidJKuToEwlf/BpWnXbN
	 Kw9cAJM/is5QmRshyGGUqx4qpVNQzCktpaa2p8NG+gFjIwwqfO9tCEGhsz33aCyM6IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgvJuLyn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663F606A31A;
	Wed, 21 Oct 2026 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgvJuLyn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2EC1F000C1;
	Wed, 21 Oct 2026 18:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792609098;
	bh=xRvd94tmSxAaQgza+g8FTO+Z/dinhulsKwwfnc1BqFY=;
	h=From:To:Cc:Subject:Date;
	b=LgvJuLynUgmvOR2zac6QQoM6y9ghmMO/gf/PNpOJuRq0BSfQfAdpSJt00JoRXGnsI
	 asqWOuhGLe1duXjI/fymLwttnWlgrDM6Lc+8udu9h/Pw0uyxfAPr2T9GviI57epSC3
	 YXDoNNyruUs3a0shrRSDXqD5cHKpMUklTtVEg4VsVXHMUYHUE3Ia6tnYJsDP0lLRRl
	 0jXIYG7ytGNfsX2y4/kDPkV9U/gIoWbMlzY/+KZCRg+ts0B8rkHvYrmn8hMFYbZEXx
	 /FzDpxfNsF7vBwbTeKh7g/5tp6AYt6SmTlV3d7sZRsyMwnBObtM5PIaSWg/duJVOzq
	 PUk6XVDXpWamw==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Cc: Paul Burton <paulburton@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] MIPS: mm: Fix the cache error vector jump for XKPHYS kernels
Date: Wed, 21 Oct 2026 20:57:09 +0200
Message-ID: <20261021185709.22561-1-kaloz@kernel.org>
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

except_vec2_generic jumps to cache_parity_error with a j, which cannot
leave the vector's 256MB region. An XKPHYS kernel such as IP30's, linked
at 512MB, is outside it, so the j targets an unbacked address and its
speculative fetch raises bus errors on unrelated fetches. Jump to the
handler's uncached XKPHYS address instead.

Fixes: 7505576d1c1a ("MIPS: add support for SGI Octane (IP30)")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/mips/mm/cex-gen.S | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/mips/mm/cex-gen.S b/arch/mips/mm/cex-gen.S
index e528583d1331..6989fe274aab 100644
--- a/arch/mips/mm/cex-gen.S
+++ b/arch/mips/mm/cex-gen.S
@@ -8,6 +8,7 @@
  *
  * Cache error handler
  */
+#include <asm/addrspace.h>
 #include <asm/asm.h>
 #include <asm/regdef.h>
 #include <asm/mipsregs.h>
@@ -37,6 +38,21 @@
 	nop
 	nop
 
+#if defined(CONFIG_64BIT) && VMLINUX_LOAD_ADDRESS >= XKPHYS && \
+    VMLINUX_LOAD_ADDRESS < XKSEG
+	/*
+	 * An XKPHYS kernel may lie outside the 256MB region a j from the
+	 * vector reaches, so jump to the handler's uncached XKPHYS address.
+	 */
+	PTR_LA	k0, cache_parity_error
+	PTR_LI	k1, TO_PHYS_MASK
+	and	k0, k0, k1
+	PTR_LI	k1, UNCAC_BASE
+	or	k0, k0, k1
+	jr	k0
+	nop
+#else
 	j	cache_parity_error
 	nop
+#endif
 	END(except_vec2_generic)

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
