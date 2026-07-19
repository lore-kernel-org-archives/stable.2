Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA123D7FB
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784492576; cv=none; b=AFc5nP2aL8ve1C+7ocdDrbW7MtiUD9ZwuPsLpQuY0daYoYn/CeMZHcHhVLqwKtRjOPhgucULNPP/ApZkz9ejJqVLp3swfbNAE+uio9EsEP1amdlHk8WWzlZA2qWRNHcCOgpOthVhjmqHG3PjwrvdzQrBzgKEwPvc2chvRao2tsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784492576; c=relaxed/simple;
	bh=IVHptBzTulzVzCXj5RTZquMiLovkrsASJwy1yGQkD/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SszJ2tG/Uv8lahg21WwwdcF4J3at/0ySrXvoZS13RjXrrgfH32V0soTZ7r6Hr7niMtXfVob63lLCDTWuZC3f4shHeoVN6kZ8wb/TMeRVsq3I+QhVIQcqYgvpmtITC8SQMEqXHMFvIShqqXnMn74JViijHwCad+qcmSoug7OG4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org; spf=pass smtp.mailfrom=achill.org; dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b=SMhF7vSB; arc=none smtp.client-ip=89.58.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b="SMhF7vSB"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id DE7DA9A0B21
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 20:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1784492015; h=date:message-id:subject:from:to;
	bh=IVHptBzTulzVzCXj5RTZquMiLovkrsASJwy1yGQkD/g=;
	b=SMhF7vSB8oVsrlCQt36w4MXEKLqvbN7+j4cVfxf2hh4i9HSJEfZGx5g1SJbuWn2KWlLunhfCOlx
	bvIuxqNXK+mob1j6+axuUuZs8Seh5+YG7Rm1J9hQI/0emxjIAVGclSC6/OTaCy5galjAYVX2+xlx5
	smZ3BgMbhu+TBPR51b1jd+IXouFj4Kw9QrcD27z0zRJmdEhkOd2ZqKQSgb4noLmqbvL9iyzE9/WlH
	ZTHWG1SYtVN5SuDhY7MV9G04QP5Un5dx8VxWBUy5IbzmXeKqVs1aclWIjc+Ft841mBovUqkx0AvEd
	+8Z8hdV+P+naZR+aJK7RolDsXRMzgYEbcWoA==
From: Achill Gilgenast <achill@achill.org>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Achill Gilgenast <achill@achill.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/tools: Scope uapi include dirs to vdso2c
Date: Sun, 19 Jul 2026 22:12:56 +0200
Message-ID: <20260719201328.183537-1-achill@achill.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

With a76108d05ee1 ("x86/entry/vdso: Move vdso2c to arch/x86/tools"),
-I$(srctree)/include/uapi and -I$(srctree)/arch/$(SUBARCH)/include/uapi
were added to HOST_EXTRACFLAGS, which also applies to hostprogs like tools/=
insn_sanity.

As a result <asm/insn.h> -> <asm/byteorder.h> -> <linux/swab.h> now
resolves to include/uapi/linux/swab.h when building insn_sanity. However th=
e
uapi header uses __attribute_const__ which is normally undefined.

	In file included from /home/achill/git/linux/include/uapi/linux/byteorder/=
little_endian.h:14,
	                 from /usr/include/asm/byteorder.h:5,
	                 from /home/achill/git/linux/tools/arch/x86/include/asm/in=
sn.h:10,
	                 from /home/achill/git/linux/arch/x86/tools/insn_sanity.c:=
17:
	/home/achill/git/linux/include/uapi/linux/swab.h:48:15: error: unknown typ=
e name '__attribute_const__'; did you mean '__attribute__'?
	   48 | static inline __attribute_const__ __u16 __fswab16(__u16 val)
	      |               ^~~~~~~~~~~~~~~~~~~
	      |               __attribute__

So only include the uapi include dirs when building vdso2c.

Fixes: a76108d05ee1 ("x86/entry/vdso: Move vdso2c to arch/x86/tools")
Cc: stable@vger.kernel.org
Signed-off-by: Achill Gilgenast <achill@achill.org>
---
 arch/x86/tools/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/tools/Makefile b/arch/x86/tools/Makefile
index 39a183fffd04..24030dcc3243 100644
--- a/arch/x86/tools/Makefile
+++ b/arch/x86/tools/Makefile
@@ -38,8 +38,10 @@ $(obj)/insn_decoder_test.o: $(srctree)/tools/arch/x86/li=
b/insn.c $(srctree)/tool
=20
 $(obj)/insn_sanity.o: $(srctree)/tools/arch/x86/lib/insn.c $(srctree)/tool=
s/arch/x86/lib/inat.c $(srctree)/tools/arch/x86/include/asm/inat_types.h $(=
srctree)/tools/arch/x86/include/asm/inat.h $(srctree)/tools/arch/x86/includ=
e/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
=20
-HOST_EXTRACFLAGS +=3D -I$(srctree)/tools/include -I$(srctree)/include/uapi=
 \
-		    -I$(srctree)/arch/$(SUBARCH)/include/uapi
+HOST_EXTRACFLAGS +=3D -I$(srctree)/tools/include
+
+HOSTCFLAGS_vdso2c.o +=3D -I$(srctree)/include/uapi \
+	-I$(srctree)/arch/$(SUBARCH)/include/uapi
=20
 hostprogs	+=3D relocs vdso2c
 relocs-objs	:=3D relocs_32.o relocs_64.o relocs_common.o
--=20
2.55.0
