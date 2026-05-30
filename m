Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992DD3C1F;
	Sat, 30 May 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780136618; cv=none; b=YeEo/0Rm55aiM4o+LAecMqlZz27Sv9Wn8r0Bz3QoN8R8p+3Gr0ClLpTavuq1xxXWLfvOy8cDSs6LcmgJy5btDTp9x+22SI45UGTbXH1gdelsDq7pURIEaxTjgCtn4ZUqnBGYF48R5RoOqOpiusRXvu82WVzBTL1huku4EGifbWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780136618; c=relaxed/simple;
	bh=bKt0PP1g+uZvTxoZiHPW8joK1YQcRcBunTy3AtuGxII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OzkBrZwhyR9iPKPAUjAl4jgtPWG6vS1JysXok2D9ifdtVJ+yL6HCDVS1uLwZO8SJomzHYnNQ+FdPLj0e8cBA1LoTbcZ3D4FYmRoA7r5gSD+OMLaS8BnPei8tXwXtVl3l4hnStYSIWa7nSmvhdDLFC9vmfa+aaqLovyw/gvedV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=M4RrRL1g; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="M4RrRL1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1780136608;
	bh=bKt0PP1g+uZvTxoZiHPW8joK1YQcRcBunTy3AtuGxII=;
	h=From:Date:Subject:To:Cc:From;
	b=M4RrRL1gj4swl9GiUCtfVBotB0UShyH4cGA287JW1qgrctoztIuVUqPCRticVoON2
	 LvthLAMQ6oLgebHcIOboPjvKaYyVaxvOMHNbClLec0q70xGiO4AY2abaPsDv1LgrWf
	 t5yutv5d4C4w/ZDXnqRHS1Ncyu6XlhDSnLahavYo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 30 May 2026 12:23:25 +0200
Subject: [PATCH] x86/tools: Only use unprocessed UAPI headers for vdso2c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-x86-tools-build-fix2-v1-1-2eb92ed1b0b7@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB1IYxPEq4iLxEzsFDGS0SKId
 29al9+D958glJkEuuqETB8WTkvBo65gfLllIuRQDFppq0yj8GgtbinNgn7nOWDkQ6NprIk+uuD
 sE8p1zVT2f7Yfbsvu3zRuvxZc1xcNShD5eAAAAA==
X-Change-ID: 20260530-x86-tools-build-fix2-5365fbfada64
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Theron York <theron.york@cloudnuke.org>, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780136608; l=3092;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=bKt0PP1g+uZvTxoZiHPW8joK1YQcRcBunTy3AtuGxII=;
 b=gq3PWl17j8XrUJ3Q7UKfb8UasvjCXrZ2pkLJgiDR3zBBAqqrPJk4gIeM+VbE8T61a9/s7G1MF
 3P011U/jsF0A0qui3CrasfCo/JCIEQSu1TerO/CbppGcmaZ817sAKg2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Currently the build of insn_sanity against musl libc fails:

          HOSTCC  arch/x86/tools/insn_sanity
        In file included from arch/x86/tools/insn_sanity.c:17:
        In file included from ./tools/arch/x86/include/asm/insn.h:10:
        In file included from /usr/include/asm/byteorder.h:5:
        In file included from ./include/uapi/linux/byteorder/little_endian.h:14:
        ./include/uapi/linux/swab.h:48:15: error: unknown type name
        '__attribute_const__'
        ./include/uapi/linux/swab.h:48:15: error: unknown type name
        '__attribute_const__'
           48 | static inline __attribute_const__ __u16 __fswab16(__u16 val)
              |               ^
        ./include/uapi/linux/swab.h:48:8: error: 'inline' can only appear on functions
           48 | static inline __attribute_const__ __u16 __fswab16(__u16 val)
              |        ^
        ...

__attribute_const__ is an internal kernel symbol and is stripped from
the UAPI headers during installation (see scripts/headers_install.sh).
The error does not happen on glibc as by chance that provides its own,
compatible definition of __attribute_const__.
The usage of the unprocess UAPI headers for insn_santity was an
unintended side-effect of commit a76108d05ee1 ("x86/entry/vdso: Move
vdso2c to arch/x86/tools") and is not necessary.

Only use the unprocessed UAPI headers for vdso2c, like before.

The usage of the unprocessed UAPI headers should be removed
completely, but that will require a bit more changes,
not suitable for this late in the cycle.

Reported-by: Theron York <theron.york@cloudnuke.org>
Closes: https://lore.kernel.org/lkml/399bf58e-1c91-4c3c-a3df-dae08a891b55@cloudnuke.org/
Fixes: a76108d05ee1 ("x86/entry/vdso: Move vdso2c to arch/x86/tools")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/tools/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/tools/Makefile b/arch/x86/tools/Makefile
index 39a183fffd04..afd967bc4051 100644
--- a/arch/x86/tools/Makefile
+++ b/arch/x86/tools/Makefile
@@ -38,8 +38,9 @@ $(obj)/insn_decoder_test.o: $(srctree)/tools/arch/x86/lib/insn.c $(srctree)/tool
 
 $(obj)/insn_sanity.o: $(srctree)/tools/arch/x86/lib/insn.c $(srctree)/tools/arch/x86/lib/inat.c $(srctree)/tools/arch/x86/include/asm/inat_types.h $(srctree)/tools/arch/x86/include/asm/inat.h $(srctree)/tools/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
 
-HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi \
-		    -I$(srctree)/arch/$(SUBARCH)/include/uapi
+HOST_EXTRACFLAGS += -I$(srctree)/tools/include
+
+HOSTCFLAGS_vdso2c.o := -I$(srctree)/include/uapi -I$(srctree)/arch/$(SUBARCH)/include/uapi
 
 hostprogs	+= relocs vdso2c
 relocs-objs	:= relocs_32.o relocs_64.o relocs_common.o

---
base-commit: f5e5d3509bffb95c6648eb9795f7f236852ae62d
change-id: 20260530-x86-tools-build-fix2-5365fbfada64

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

