Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667831;
	b=rkYUUdX5C25/wLDNyxmOW3mLylCJ97V3Ab0/88BdOTxr/S7MmgU4olvdLCWoDYFSOSAj
	 xobEIs4bF9xZlB85aUpjEqw9Ab70gbN9EPvtVNsS70jtZ9tUCRP/WyXolPcuimowndeHB
	 85rZEwPJcAXXMISwzfJOGd/vlCe85EbDrtWT/FZOsFXjzVynEZWuG98aNE/WDNC+L5O/7
	 UKCI9OolDbXdV69Ub0m70whvhGcPiPhm2dWU/ZmtDK5rXjva7QjBgd/H9cEMmYArzEfsa
	 HiGAkGap9LCmSMMZLBf6MoHaQVwdEgrLTvFDXo3tL4VMs34KhsdLvaIbF2zHTrb6pEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hu4sJAi0UR6zv2af8fNQzaD1mOTsI3PakILnf/N52jc=;
	b=1Tw6Rr0X+CQKsdZtFk5Wv+LGvwaqAwcsT3/Uwb4CEmGgEOhItm7UFVXuxTZDnvFs15RW
	 dUhc6WuhztW2JwJzZ+DPQ+DkTRCdsQ0KeNdkHcd1IAMdH3ZfP26ARjdAVuiCPmp1LQr4a
	 N4LESyJE2l6TLR7r8J2c2EE7VxWW2Jphv1ZNN6lNypMc8cZScEZ7EGEuqP+ZTC4li7yFJ
	 AudwTMLqSk+okOTjiOLUd5Jrt2Nw4qjEuHvfivEcY5wV1vaBQHJ/kMjqdVUWJRena/ig7
	 njaff4A/DWOID0tkRNCn/2i8NQhv0NuQe1XErsFugQMZkg1cWjGEwrQ8JUF7YxH3X6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Hobq1Y1S;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E822606A31E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E822606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Hobq1Y1S
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8565d77c277so14871557b3.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792667829; x=1793272629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hu4sJAi0UR6zv2af8fNQzaD1mOTsI3PakILnf/N52jc=;
        b=Hobq1Y1Sbj74oF1Ned+FV45xdT2LX4eirbIJTjp4Pm8WgeIZix3oM/y4qD07kqKL1N
         Fuvuflpa/Zk/tWSolzT27ateQjBv+v+//hm7J5PGK+lVUp/J27a41U7s5AkAVfGDe87P
         QpPWj4Ys9wPFVH9zXwnD66gdndZdqcNKBJh73rRnzFfdaYchZwlrcRmdm0m31x5q3eXu
         Le8opCiEKTs0y77zRfym268FPcO0llb3P9TLtTADeCQxWM5QnS7LdQpEgi47GMrswmxb
         B2rQZSc0hK5QL6cE8hHFdI4VrhnpSEBdpKIw0PJ5x2nGnIJAMyrM1qpmaq9LAoTEB+Xq
         txjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792667829; x=1793272629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hu4sJAi0UR6zv2af8fNQzaD1mOTsI3PakILnf/N52jc=;
        b=TLZ2SEf/fOHyY0CX03zstu1mAVbAYOvRTO6KgZwFcuUJO7ss/E2qwc1vNsoEKs270R
         4g2vc6cjMwnwi9fC7vMJA4zLTpFmMKBMpx61SuxAvdZhQ3T6rinUY5EdYvHYMpz2K0xj
         mingIu0LelyNushMh4HDvyjlKR2X1d9NKkSL6KxfwkqFJ3OR52c/DBXWevzFIfqjaOGb
         0fJUO6kJ+JJVtwtZ81iS4eflrTB7NIzgIWK7TStAo/2jxEcNJ9LdC3r5l4WbuwPmU2JJ
         2tHJh9upo10QtZ6OB847ZkpRREmQMJrr4LeqHoyAEgsnf9N1XzQo8EdvEsx4b6hSsWZD
         frzw==
X-Forwarded-Encrypted: i=1; AKwUvBxyqGDfK8LfH03R9kCYHmDfEd4Lf+W9bs95kgzhtggglpEYPB+FLRiQjqa++GA1o+rLsMMDAyk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/o4BYncqW3w+bWRe5XBrR8+vCLtfpmkU9mTinmychCmm4P3FK
	W+qK6qMi7K11whh6gHiyLweG1bZi+xdMEPpvETthXkcDpPWb576b5mIlsnhtaAhyPA==
X-Gm-Gg: AYBFou0ZEWNhypFV77Dw9jv9x20LgYQcxht+gDgKIGcgC9+mhz8hbBR+Gzj4ZBy8C3I
	8vcI24SguBMrwOqcJlsyiBiN7eQm5npR82VHwCLLjKzf3vvwiKl7GFDMohF/PSPFLzg7qKJV+4X
	vD5+RZbP4WsizUeqpABrbwGf8bBbv1wmF3CntvSe3hdPmkijxRDsJCMGwFAEBI5Y4NKGtJXYRvv
	5UJNJUNiNUDRjc9Au3M6GhBC61dNc1oQddqRqbhg53D8GJUXIVEk8dxKJ6ZgEnQYPrINK/RPoLs
	NP6D4nyywbGdJjEIxE8Bjakm+lUQKrir+hXtyk0M5hNxEJwdN154LW/IsX2tQrwnIy8L42eqMuq
	WR4GpUMWwpgteKnQfkqkr6lT61nWeCsIo9WqIj6sRL9oo/C/OB8PItT6kN7MNW6uL+uyIrX0c8G
	+6UBMjvSC4PlOo61We0Y9UHv8gbDqi2mhgojFfF+EKw5n5mr2pTgom9gePS4GAzyQcyXMveEMBp
	KeucdIOXfCCptUJeNyp3rRSkXJNWiblIrTi1qKCS/NpI/qHSu9JtKa4sm1+busv/WFgv2MpQ7J8
	CA==
X-Received: by 2002:a05:690e:118b:b0:672:99e0:ec0b with SMTP id 956f58d0204a3-67a0e5d222bmr1791670d50.163.1792667829191;
        Thu, 22 Oct 2026 04:17:09 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a0e57bb39sm2442948d50.22.2026.10.22.04.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:17:08 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	kees@kernel.org,
	justinstitt@google.com,
	maurycy@maurycy.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] hfsplus: fix truncated xattr names in listxattr()
Date: Thu, 22 Oct 2026 07:17:00 -0400
Message-ID: <20261022111700.1288273-1-hengyul@cs.unc.edu>
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
Content-Transfer-Encoding: 8bit

From: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>

Commit 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use strncpy")
made copy_name() build names in the osx. namespace with scnprintf().

However, the size passed to scnprintf() leaves no room for the
terminating NUL, so the last character of the name is dropped. As of
now, listxattr() returns every osx. name without its last character,
and these names cannot be passed back to getxattr().

The issue can be reproduced with:

    truncate -s 64M hfs.img
    mkfs.hfsplus hfs.img
    mount -o loop hfs.img /mnt
    touch /mnt/file
    setfattr -n osx.test -v 1 /mnt/file
    getfattr -m - /mnt/file

Without this patch, getfattr lists "osx.com.apple.FinderInf" and
"osx.tes". With this patch, it lists "osx.com.apple.FinderInfo" and
"osx.test".

This patch adds room for the NUL to the size passed to scnprintf().

Fixes: 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use strncpy")
Cc: stable@vger.kernel.org # v6.10+
Signed-off-by: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Changes in v2:
- Rewrite the commit message. No code change.
- v1: https://lore.kernel.org/r/20260828-hfsplus-copy_name-fix-v1-1-75ed9f0f378c@maurycy.com

Maurycy, v1 got no follow-up, so I am resending it as Viacheslav asked
in the thread below, with you kept as the author. Let me know if you
would rather send it yourself.
https://lore.kernel.org/r/dc187921249a3f6716b829624853e64c10321cd1.camel@dubeyko.com

Answers to the questions on v1:
- generic/377 passes with and without this patch. It only uses user.
  names, which go through the strscpy() branch. That branch already
  passes name_len + 1. No xfstests test uses osx. names.
- Why + 1 helps: the prefix and the name are name_len +
  XATTR_MAC_OSX_PREFIX_LEN characters long, and scnprintf() writes at
  most size - 1 characters before the NUL. Zeroing the buffer first
  does not help, as the last character is never written.
- Why the write stays in bounds: both callers check that the buffer
  has room for name_len() bytes, which covers the prefix, the name and
  the NUL, before calling copy_name(). This is also the number of bytes
  copy_name() wrote before commit 7dcbf17e3f91.
- All xfstests: see the full run below.

Tested in KVM with KASAN on a804c5742bff, without and with this patch:
- The commands above, and a C test that compares listxattr() with the
  names set on files and a directory: short, long (up to 127
  characters) and non-ASCII osx. names, FinderInfo, and user. and
  trusted. names. Without the patch, every osx. name loses its last
  character, fewer bytes are copied than the size query returns, a
  buffer one byte short does not get -ERANGE, and getxattr() fails on
  the listed osx. names. With it, the names match, the copied length
  equals the size query, and a buffer one byte short gets -ERANGE.
  KASAN reported nothing with exact-size buffers.
- generic/377 and generic/062: 5/5 passed on both kernels.
- Full fstests (805 generic tests, 608 not run on both kernels): 188
  passed and 9 failed without the patch, 187 and 10 with it. The only
  difference is generic/617, which fails on both kernels most of the
  time (19 of 20 reruns without the patch, 18 of 20 with it).
  fsck.hfsplus -fn reported no errors.

 fs/hfsplus/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 71364e093fa7..470f090b2699 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -515,8 +515,8 @@ static ssize_t copy_name(char *buffer, const char *xattr_name, size_t name_len)
 	memset(buffer, 0, name_len);
 
 	if (!is_known_namespace(xattr_name)) {
-		len = scnprintf(buffer, name_len + XATTR_MAC_OSX_PREFIX_LEN,
-				 "%s%s", XATTR_MAC_OSX_PREFIX, xattr_name);
+		len = scnprintf(buffer, name_len + XATTR_MAC_OSX_PREFIX_LEN + 1,
+				"%s%s", XATTR_MAC_OSX_PREFIX, xattr_name);
 	} else {
 		len = strscpy(buffer, xattr_name, name_len + 1);
 		if (len < 0) {

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.53.0

