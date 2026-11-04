Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766939;
	b=WpKQOR1eh81gVGzsiug8rzQRBRV90v5gblWscu847u/Gqtb0CkKGN89TXxqg64Ouogfb
	 2Qm7qvlOFeyIBhPvSb2hvVrGC4Ngw/kT+OdRK1r7VT2McbrTEJKxRQBj4Dosqg0FVfRuM
	 B0kvmDzMINn31ssuJesggsIsgQ3SGFfGMeffaaXUbcVJ3kd/nztiP3pYENg1VqnRPfScz
	 NnU/KyXceH6KobVbwskna/UJAClcOBzvwM1KUgTxqqPJN8Xr5DvEH6oASZR3priU/tvmy
	 +sc4HRqyOhVPySR4oz7IaOL2alrjlys2w8INVrc6tdl6TOkF8MJEZBdwG6vY93DkbPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766939;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AMKGIe8BSbyYaDU1MMtpU1Bo9w4z1tdfz9JE1gZvoo4=;
	b=zBB4U9xBGhc2A+teaiLc/FMz5jId+BOUp/xfoV9BeqXkGnp+0XPcLtUiWoCYOaGMUM4L
	 daqT12SmsshIiMNejq8bjbg2A3QHP4S8hSmLSAnGwH8D9kGieRB3EYwOl5DuCjreSj2sC
	 2y+/vq1iCrpSXKQojXPzlT0CFU4mj7Q+WbWnBoZQKHXe1h627ZoUKEu2qC0PNj63YKF7D
	 GKXZSuDnQ7ouXQsuIcrEzqP08xMCD3ZLRmFUDpBNJ94ICo3RTFVxgfCAG+aFyOW4xmv28
	 r5tthVbaYNpCPBJECcaq5QXxQIo4mr1Eb3b0rnJ4eu9mYTxYv1aIKZjr13o4Ifw2uIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZNeny0A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC696606A326;
	Wed,  4 Nov 2026 04:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZNeny0A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9F31F0093A;
	Wed,  4 Nov 2026 04:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793766938;
	bh=AMKGIe8BSbyYaDU1MMtpU1Bo9w4z1tdfz9JE1gZvoo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gZNeny0AqlMk+AXEw8+Jj1xLNEloVUyeNBpl/c1IVQedYcOoZyBiDvBheYZ0OyX9O
	 wac8+AsyvSHZjRJpNIQxswnsRg3HH4YjznFgbLmnYMV0+B4WRxH8hiWxJr1jG9b3bh
	 dZS/rolfgZ5bSVNqA/SvLx9uvH2Iz23asfsf74xi3bE1izezxB2MoLaSnidY/IFk5O
	 acn2luoay4tMwXfyX8fJArWynnu6rz73yDefZm95wAe2aKiLYjeS3/haa604Ic98jY
	 eCV7TDPcFsj/6U05X1c3REfjFl7YH11PUESM9vAeR+XUgejBrQwoV/CZUK+IE+Fy+f
	 j1zhyCMnu//Pw==
From: Vineet Gupta <vgupta@kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Vineet Gupta <vgupta@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ARC: io: work around GCC PR127718 in __raw_write{w,l}()
Date: Tue,  3 Nov 2026 20:35:34 -0800
Message-ID: <20261104043535.2039948-2-vgupta@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104043535.2039948-1-vgupta@kernel.org>
References: <20261104043535.2039948-1-vgupta@kernel.org>
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

The __raw_write{w,l}() accessors use inline asm with an "m" operand for
the store destination. GCC's ARC backend lets "m" match any legitimate
address, including the register-indexed [b,c] forms that only loads
support: stores only have [reg], [reg,s9] and [limm] addressing. With
newer GCC (late-combine in GCC 15, combine in GCC 16), a writew() with a
scaled, non-constant offset gets

	stw.as r2,[r0,r1]

which the assembler rejects:

  Error: inappropriate arguments for opcode 'stw'

With GCC 16 this breaks even hsdk_defconfig (drivers/net/pcs/
pcs-xpcs-plat.c) and axs101_defconfig. allyesconfig additionally trips
in drivers/pinctrl/renesas/pinctrl-rza2.c and drivers/video/fbdev/
s3c-fb.c.

Work around it by passing the address in a register and using a fixed
[%1] address in the asm template, so the compiler can't pick an
addressing mode that stores don't support. This is the minimal fix.
The next patch drops the inline asm altogether.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=127718
Cc: stable@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/io.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index 00171a212b3c..b4a3393d1bdc 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -133,10 +133,14 @@ static inline void __raw_writeb(u8 b, volatile void __iomem *addr)
 #define __raw_writew __raw_writew
 static inline void __raw_writew(u16 s, volatile void __iomem *addr)
 {
+	/*
+	 * Not an "m" operand: GCC can pick a register-indexed address for it,
+	 * which ST doesn't support (GCC PR target/127718).
+	 */
 	__asm__ __volatile__(
-	"	stw%U1 %0, %1	\n"
+	"	stw %0, [%1]	\n"
 	:
-	: "r" (s), "m" (*(volatile u16 __force *)addr)
+	: "r" (s), "r" (addr)
 	: "memory");
 
 }
@@ -144,10 +148,11 @@ static inline void __raw_writew(u16 s, volatile void __iomem *addr)
 #define __raw_writel __raw_writel
 static inline void __raw_writel(u32 w, volatile void __iomem *addr)
 {
+	/* See __raw_writew() above for why this doesn't use an "m" operand. */
 	__asm__ __volatile__(
-	"	st%U1 %0, %1	\n"
+	"	st %0, [%1]	\n"
 	:
-	: "r" (w), "m" (*(volatile u32 __force *)addr)
+	: "r" (w), "r" (addr)
 	: "memory");
 
 }
-- 
2.53.0

