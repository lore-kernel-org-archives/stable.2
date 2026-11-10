Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273918;
	b=g8d0aPV7nnMbLrY6Cqvz+EaWnQ6oH0uOJxIG3XeknvkUS9x/bJYiwL0mmF+0hh4iiQsJ
	 904vE068+Usnj6Uxjm3h16xTHptcM1pwjEPMMwWEZBtDQ3UD2fuhUIJoct2nMxNQctBFe
	 oo42TrNcFyUcW0u3md0LsTMEnnNkUn5fe1AeSG3Sg7VvuGX0IQmaDn6WmQxA/JFCmQMyB
	 Poow31Vtfuy/+8ySVzGb8clJjJmVC3ORsChCX3yCGwQ2St/YKnTZluhmZ8vIh/JLuD6pN
	 jOS8Nr7zh2QSZdXv0yzEo83lbDsc3o7PY41C2VAb5yc8jIPKAgSnvaiRzfByu4OTRgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273918;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gTQLHsPfH4XS1c0lC5uvESlDOmF8UHnJAELSrwJjKaA=;
	b=KHmHMs1crVl8WEfFCXiVXWImynEoH1oFbzqYpxi2Fn7GQioVF9NoYhFfIWqi7yZ07yim
	 MaYWDs6bQyr4Mh4VlZxJQ8UlUB+04YTeozP+7TuRPP6YrpY80YCebk3XQDgbaRKxCRphK
	 rg9WgqiBZykssS1yAtkpT19IwHqSEb3Qe0aYNox7mjRfDc4QBwXRYBZXZQa87kmISwwBl
	 +lq0/L/7DBqwVYBTtA6Lfq3b7MUV5CyjcCCMtHgzoauBhGVxgM3EMNaErcjEtkZqhugrD
	 DC2vcRjWrBkcIL57P1qVTPg3l+SMKmVu2wnrLaUO983uoAllEjHk1qDT8StXAQR9A1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1FGh7r2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105F6071860
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1FGh7r2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4391F008A1;
	Tue, 10 Nov 2026 01:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273918;
	bh=gTQLHsPfH4XS1c0lC5uvESlDOmF8UHnJAELSrwJjKaA=;
	h=From:To:Cc:Subject:Date;
	b=d1FGh7r2iy+VJ+0bZ4PJj3I5DOpM6QJmlIdvhVYX7FwIRi7EiNpd2smrf6O2a/fZB
	 iskHio+3Cj3JiLCYEJb1MTAOmhm6m4nKntzc0PQScJbBM49eK4zL8RPoynO+wv03ja
	 z/AXnGROhzK/+xJ106BaEacBCg30xg+wyW2meK4D3nqOvB1Ww2VAlFyIZYrUtXpAPw
	 cDphJdOHFH3MKYIn4yJndSVJ+CBnFrpUQ6zyvHl868N2l3hZHh6R3azUn5t5VIxjth
	 P4CW1Ar1yOvvla3JBbqYcVlk3KD+9Qqm1Zy+cMizGVIdLh1cQUbSmNTJXFDhqCviad
	 AGtdN4vHorVZg==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	ardb@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] lib/crypto: mips: Disable Octeon SHA code on little-endian kernels" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:16 -0500
Message-ID: <20261109202516-failed-5.10-dd2a4edb26e1@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x dd2a4edb26e1c78823c50ba10c42f2d3de2e5ec4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202516-failed-5.10-dd2a4edb26e1@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From dd2a4edb26e1c78823c50ba10c42f2d3de2e5ec4 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 21 Oct 2026 22:44:50 -0700
Subject: [PATCH] lib/crypto: mips: Disable Octeon SHA code on little-endian
 kernels

Kernels built for the MIPS64-based Cavium Octeon SoCs are normally
big-endian, but little-endian builds are also supported.  Currently, the
SHA-1, SHA-256, and SHA-512 code using the Octeon crypto co-processor is
enabled in both builds.

This code is untestable without the hardware.  However, based on the
code itself, it is implausible that it computes hash values correctly in
little-endian builds.  Such builds write many incorrect values to COP2:

  - SHA-1 and SHA-256: The 64-bit integer that contains the last two
    32-bit message words of each block is written to COP2 entirely
    byte-reflected, due to missing endianness conversion in
    octeon_sha1_start() and octeon_sha256_start() to compensate for
    using native 64-bit loads from the message bytes.  This differs from
    all the earlier message words which are written correctly.

    Furthermore, the state is written to COP2 with each 32-bit word
    byte-reflected within each 64-bit integer, due to incorrect use of
    64-bit endianness conversion in write_octeon_64bit_hash_dword() when
    the state is kept in memory in native-endian 32-bit words.

  - SHA-512: All the 64-bit message words are written to COP2
    byte-reflected, due to missing endianness conversion in
    write_octeon_64bit_block_sha512() and octeon_sha512_start().  The
    SHA-512 state words seem to be written correctly.

Big-endian kernels aren't affected by these bugs.  These bugs also
aren't new; this code has been broken on little-endian ever since it and
Octeon little-endian support were first added in v4.1.

Commit d2a948d2db68 ("MIPS: Octeon: Make octeon-md5 driver
endian-agnostic") made the MD5 code work on little-endian kernels by
adding 64-bit endianness conversions to the COP2 macros used by MD5
(some of which are shared by SHA-1 and SHA-256, despite those algorithms
keeping the state words in native-endian instead of MD5's little-endian,
causing some of the strange behavior described above).  However, SHA-1,
SHA-256, and SHA-512 were never fixed to work on little-endian kernels.

Therefore, disable the Octeon SHA-1, SHA-256, and SHA-512 code in
little-endian kernels.  This causes the generic code that actually
computes hash values correctly to be used instead.

Fixes: 82be2dcfa6a1 ("crypto: octeon - add SHA1 module")
Fixes: c3d0def62001 ("crypto: octeon - add SHA256 module")
Fixes: fbaa4dfd51a0 ("crypto: octeon - add SHA512 module")
Cc: stable@vger.kernel.org
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://patch.msgid.link/20261022054450.20746-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crypto/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 56f308dd02731..83b4a211c15d6 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -237,7 +237,7 @@ config CRYPTO_LIB_SHA1_ARCH
 	depends on CRYPTO_LIB_SHA1 && !UML
 	default y if ARM
 	default y if ARM64
-	default y if MIPS && CPU_CAVIUM_OCTEON
+	default y if MIPS && CPU_CAVIUM_OCTEON && CPU_BIG_ENDIAN
 	default y if PPC
 	default y if S390
 	default y if SPARC64
@@ -255,7 +255,7 @@ config CRYPTO_LIB_SHA256_ARCH
 	depends on CRYPTO_LIB_SHA256 && !UML
 	default y if ARM && !CPU_V7M
 	default y if ARM64
-	default y if MIPS && CPU_CAVIUM_OCTEON
+	default y if MIPS && CPU_CAVIUM_OCTEON && CPU_BIG_ENDIAN
 	default y if PPC && SPE
 	default y if RISCV && 64BIT && TOOLCHAIN_HAS_VECTOR_CRYPTO && \
 		     RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
@@ -275,7 +275,7 @@ config CRYPTO_LIB_SHA512_ARCH
 	depends on CRYPTO_LIB_SHA512 && !UML
 	default y if ARM && !CPU_V7M
 	default y if ARM64
-	default y if MIPS && CPU_CAVIUM_OCTEON
+	default y if MIPS && CPU_CAVIUM_OCTEON && CPU_BIG_ENDIAN
 	default y if RISCV && 64BIT && TOOLCHAIN_HAS_VECTOR_CRYPTO && \
 		     RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
 	default y if S390
-- 
2.53.0




