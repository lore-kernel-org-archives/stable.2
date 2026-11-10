Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273027;
	b=PY9K92slpFeBeQDbVCvDs346aZfuDC+Aw1xHXZDYUzIcmkm7yHxhf1gmWagjaZteEDlc
	 oMFbJO/Sxm6EVoTZa1FNEROJEocr0Rz9zDiz6G7i5fZT8TEwyZlRhwS+tjB9R2yn0+ejA
	 vkNDItyE3HLOlPmwb9LQvU7z4PxdQdI4RZlVD7TGfhqPJuVNEegHdoMaPf4VPpisnWB1E
	 nDUgIVWUC/tb9T5PFZ/5fSxTdCbm78ScAOlDPcA5iykHDB+92mni9Ue7rGZnlW1BEmnmQ
	 SCKUTp9c7uSI4W82oB1K/roiMU9lRja/u3D4hOq5ozujCC9467TrQnAbMA8MUVZRn1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273027;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YDCsXzXO/scHZYB9/XhEskPl0KAC0IkhWkrIWCe7euw=;
	b=JZnGhbIUDPHKaq++ZlURmHq95haP1YIdTgKnrBw0o7+WijqJhVEm5n3pjUC66Dp7lPql
	 ZkzOYrbgQflIspgOQ8UjoGzuWlxNr1JZH8nFHuk1LEs8Ovat+1VQ8IATdlObc3Ojy10lX
	 P/zbwgU36Oey34QVjV6ODlZ3wouJ7/1HHN8/QD4xuS4N7qN6xdbqIylqhPik7/GO8m9AE
	 cEysNuStUIVmTW+keOrqHKWm07UN4AmsKdIA4iNgbdwG6gOqO9mvRe5iSnhpxK3Bla4j0
	 pyZ8JL2LGEo0tQCrKjkQj9RFsHIPIREdn4kPiE3xQRec+lRmcmWV0xYrSnkIhQSZyDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QB26+lQ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED59606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QB26+lQ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82F41F0089F;
	Tue, 10 Nov 2026 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273027;
	bh=YDCsXzXO/scHZYB9/XhEskPl0KAC0IkhWkrIWCe7euw=;
	h=From:To:Cc:Subject:Date;
	b=QB26+lQ04HIg7rW+FQMOBslV1/gA2dc+q8OyFhCABwW9lgi+LQOIDzL46yZ0UmJKr
	 nIeUdsPK1y/P4aKcL42fDfB7cgaAyudqZyIhEu5Drsf9bIy5JCxI9T8eStsr/F9OSW
	 TveDgk/2l+5DfmsF8nmS3apn6NTl5oHaxZ0477BZRX9dZXgo3FDn1SnkHmF+zZX/Oa
	 /2ImuZi7ZJaX0xMIdXXj3SBOnn9E+cY3bW33t842BYkL0lTQsay/ztIF5a2TSnAnaE
	 AyR0+DbxV7l9KmBZoYzrkBGj54R75nAUtFjGSioS0sVtijnZ/PEouOi4rpRkcTI7pI
	 X1CNSKKJgQMhg==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	ardb@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] lib/crypto: mips: Disable Octeon SHA code on little-endian kernels" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:10:25 -0500
Message-ID: <20261109201025-failed-6.6-dd2a4edb26e1@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x dd2a4edb26e1c78823c50ba10c42f2d3de2e5ec4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201025-failed-6.6-dd2a4edb26e1@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




