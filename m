Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9097DF76
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982863; cv=none; b=PwmZuKKA3wMpMDR56gdk0aKkbPr9roSPokrcKMXj+BGkBkW+DlKuBr7ijPfAn6IBgN+WsXfdHeHf7B+TumHroLiHM1A3EWDkzeq+CIuhbrhGVbjnXt8S/G51bT/kzKyBUb/YoxRQ6n0wmhzLNiKvR1kcyYi1ZjKzOrZ9tqMIYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982863; c=relaxed/simple;
	bh=cWjV8h1cQrtdcyPgxMG0qe7pvsvyiL4napaYUUAF7JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGO+fZhvLJ1HEe+Au7h+H7djM12EDb1fD8NSd9LENmXBAtMdyC6FjPW+VmPhHtzcerT11wl/tzRLeYPF+B3u6WG2YGgSr1twCjSdzFMho1Nh0y3B4BZMQgL1nPQqErmOEsukRUDjiJNJ7YzlsJntxZhMM0KDS7rnZwHSCy3Sgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgI6dYKr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgI6dYKr"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso1276986b3a.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785982861; x=1786587661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8rrR7xn4oTTUbhGxl5QbDi5ytS4GenrW393UJoeG+oc=;
        b=dgI6dYKrXXzP9lZ5l/XC/jhET5rv3KRjfuRgJ+4YcXnAooZGlA3V8zf7+RceOoEwAm
         3HJ4UGEKqVZAWgQ/OB2BdAV1b5zeLCTBO+8dmU4sC96vfjIsgB25+/Lxy78hStEjXIjJ
         XOBcwbUAM641O9HA1PbTXyw9OGERthUtTUIl8j5Tx5xrMGDEuYML1Gs2unZLL1dDm72N
         SPvKBhBpmxscytn6nhNJ4QgtwTlK0ljImyv480s3Sko7n7QZyj07r72090rsV+epA442
         +OS284YOvscXxV8LX9MsrcdGayTceKk88ZbTPOvcUtIcPmH1xg6is5TTbvTWBKDCpkRA
         f4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785982861; x=1786587661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8rrR7xn4oTTUbhGxl5QbDi5ytS4GenrW393UJoeG+oc=;
        b=GzJ5gpuybVNy770jLd9DDQBAwgdJjuh41adYcxIvlcszJOp0eSjYA345p3OIQR/BS5
         V0crTFhNfd6ahRJQOT+8MXqzQKm8p6NjhydXi98GhdkHeYDVW9JHmTUdKU8qXkdmFksW
         Soy2CW8iU5msbgyFELZVCI2B1AkET79+UCY+ISkOR6Ocx6hUmKKAepRrRkqwlXB6IYfv
         HtZ2P4IZO4EuNfu7+qCIw4iNTXSpY3vnfaG7uiqt2+A3AjUAGdTu9TPrGzDl2N/NTbKP
         6tbF7jW7pLlOPtkstjHguHJfN1/6DHsOoSAq28eef38OeK4dZIIfkvXQ4E8uOMO5BoRy
         YpBg==
X-Forwarded-Encrypted: i=1; AHgh+RrlXweBGNRqhh5dAIm+UmiwYlnH5INnQ3z50C/xmoj6t0xMdAZTjxKCy9E8/nwq1Sd80NFdtpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3FM5BUyo5SuT2opjzOhmEuXpOL8Ww0vxhtZcbBiOPOqJka9C5
	qTr8hvG1ymLB/9YOTEdIHdbx5jYhJK96EsFdpFlI+JY/gBMo37hZNQg8
X-Gm-Gg: AR+sD12rsh7WVUH1osSEPS2PyCIWWb9loW3ZIktJ5O+Lsg3n4QLY986j0QbPFv2YRHP
	xPlD1HBNh/Gf9CERVfM7OxaVBdlw20g4J5Fr4kuImNu2qWuOSzmLfSEPi40ahClXiCXkq5XXGeh
	EHSMaovr+IOpgn8JIla8Y1jC5XXKX1RqUYZI9JS1GlvUnyYPb+eauK5QDr41mhc/EXmU+U86Ntv
	zZ9mgYwNvBnVEwBNYrs9/uT5RHITwhsCsvHk2VN4XtnK5oGPYmtBOEnixa1vkWeCxWD6XgFpZoX
	WOu5qF9ZV+ELI74bfeGcDM4ziymiQiQ0gU0Uz4rEQ+8BXrlEunUBtSiw3fPBRhCahx6HLAmtUZN
	vhkC8WVLg7MG38jDuk3VzsbHSw/ole0Z+vq/oq9RJTystsFz4JHWNnmYpbEYBQ7+PH2iDVV1LGJ
	CqVMRu644b/F4kaX94haT/6eBPTsKL+kvWaeM0zLDgESZuVjKLJdFGT4XvAU1wd8m3NuMJqTh+F
	Jpk+SucwOk=
X-Received: by 2002:a05:6a00:240a:b0:84e:538:476e with SMTP id d2e1a72fcca58-84f2e0ed7fdmr11031006b3a.32.1785982860876;
        Wed, 05 Aug 2026 19:21:00 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f4538ba99sm323012b3a.9.2026.08.05.19.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 19:21:00 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ext4: fix readdir position truncation on 32-bit kernels
Date: Thu,  6 Aug 2026 10:20:43 +0800
Message-ID: <20260806022044.167962-2-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806022044.167962-1-zhanxusheng@xiaomi.com>
References: <20260806022044.167962-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ext4_readdir(), the directory cookie position is rebuilt with

	ctx->pos = (ctx->pos & ~(sb->s_blocksize - 1)) | offset;

`ctx->pos` is loff_t (signed 64-bit), while `sb->s_blocksize` is
unsigned long.  On 32-bit kernels unsigned long is 32-bit, so the mask

	~(sb->s_blocksize - 1)

is computed as a 32-bit unsigned value (e.g. 0xfffff000 for a 4 KiB
block size).  In the AND expression with the 64-bit `ctx->pos`, that
unsigned operand is zero-extended to 64 bits per the usual arithmetic
conversions, yielding 0x00000000fffff000.  The high 32 bits of
`ctx->pos` are silently cleared, even though directory size is
allowed to exceed 4 GiB on 32-bit (s_maxbytes for ext4 is many TiB).

When readdir() crosses the 4 GiB boundary on a 32-bit kernel the
position is reset back into the first 4 GiB block, making the
re-validation path re-enumerate already-returned dirents indefinitely.

ext4_readdir() reaches this linear path for non-indexed directories, and
as the fallback after ext4_dx_readdir() returns ERR_BAD_DX_DIR, so a
directory large enough to cross 4 GiB can hit it.

This is the same class of bug that commit 3dce5bb82c97 ("exfat: Fix
bitwise operation having different size") fixed in exfat.  Cast the
operand to loff_t so the mask is 64-bit before the AND:

	ctx->pos = (ctx->pos & ~((loff_t)sb->s_blocksize - 1)) | offset;

64-bit kernels are unaffected (unsigned long is 64-bit there, no
truncation occurs).

The truncation was confirmed with a freestanding 32-bit test program
mirroring the kernel expression: input ctx->pos = 0x100000100 produces
output 0x100 with the unfixed expression and 0x100000100 with the
cast.

Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/ext4/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 17edd678fa87..8113f43d4989 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -252,7 +252,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 							    sb->s_blocksize);
 			}
 			offset = i;
-			ctx->pos = (ctx->pos & ~(sb->s_blocksize - 1))
+			ctx->pos = (ctx->pos & ~((loff_t)sb->s_blocksize - 1))
 				| offset;
 			info->cookie = inode_query_iversion(inode);
 		}
-- 
2.43.0

