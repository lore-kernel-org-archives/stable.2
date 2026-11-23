Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416927;
	b=VAONWw6LPppEMkICK+q0forZDsEXKcRCQd1VfHb/iydyK7PlU2u9B55FE8GHhvSOGO9U
	 kamXXrUQ3qeE2F0UYdhBxRfK5kaykOX6hxWi5MWCQ2YGHz/MB8uXxjpq4m2yCTaxi3988
	 E+IRVc7KQUAAvirgjqkzaMgdsGOBaA8N3cNFKWFdrYX6cmIH5clYGzf9QG3xCRRbVeFuQ
	 iza+ivQ3UgurzaLvnIj6+6E3DZo9eAJsPOjmQL3YSTBfbXVv3EvCqwDJrRzmq1yUYIYRy
	 2THxXDGpSX5BuUf5yrHA54YaBk5gP1ob3ZX2QbgdPYMFpKkK994P7YG0s7AQYl1Izig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Sw0yGZEZQlVpTyvtRZOPIDwQKkA+/+G9V7rnQKUJs00=;
	b=ayqkw3t5PMj0qFod0FcDoqX/WxZEhjqEhm2sgdv6fq6hEWYFh2eYe0vzo5Zcxhe7VHA1
	 UbWuyeNJgPThkZ7Q6o8xF4GMkIVz/oNXIFugzag3xwbz2yCkdQGzq8VuJcDvt1xVWOiDP
	 BY0SA64tF/IFHDQREw/adNqgcdfV+RZWlXTINPetnsYaoaQYZvPZYTALY9PE+4cPtBzFF
	 5PCzuakXNQPkhT890A0wT/Cp8Mwfpyov52nLn1EQtc2QXwA0cchLacpvKCPI0VCjIdFjF
	 2yFht12pT2FsJAn6y9QQ1cWi7Z7dQgX1cwe/+qoy/eWD2UvgFs70BaiMl8Ac78FwKUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zxTI65F0;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46981606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46981606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zxTI65F0
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dee593f18so2773889f8f.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 22:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416925; x=1796021725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sw0yGZEZQlVpTyvtRZOPIDwQKkA+/+G9V7rnQKUJs00=;
        b=zxTI65F0z0G+SdjQh4XAnUVy4FDqLLVtBcXkxpo+xWF0fnYrLgcbdSjtZWltCxZgWd
         nsECxVhOXssve+Yp6Avsi0TD4k4jJDZx2IiBFddPuzrQRHYaaADIGKyUftplAiAPDQ8T
         CzlmZmfrWQnqdnHN+meCttMqlS/i1zpmRQPW+dfV9eh1TdEBDjKP0NX6/BG3EXw/BTSl
         KBcWcB3Y0aCd7PYLkUkIsmGUfjSZIMiHprJJylm2f7ooTcj+CKg3173RgZEz2c6X3aNT
         Y6VmeAz3s5gKNBlbV/xUo13vm4jcaw+2icRPAbo8saTdVGATcXkiQAGKZx69/8l4dy4F
         k4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416925; x=1796021725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sw0yGZEZQlVpTyvtRZOPIDwQKkA+/+G9V7rnQKUJs00=;
        b=JcpxJdDo4AfVUX0/y3OzUmiN82biS1+sTiO4pPJS+VHVq51vddQvZw+B8KRNWpFJVz
         C39TKQVae6zORDDB7R7mfW1zpwxtDOG4hchAdLlUUPnq6hKPsx/T/xIGkcGErWDfmtBr
         hoh3InKPKNq0ap8KQ6Onoo52QpSBJH2TqI6px9ppriGqNNgmBmvLShL/ltz1TsWXZpd1
         0FCvmqE5WbUi+hZnSe7UNdgiPSCrm3uEHsyOEcZlc4TUTNnx/3CK4pjVgoJVTZBmXvzi
         F79b/AUrmmaYThRXQzNAQI77BW7/u6joVHst6+n7xABzWomShLt62zskfHHQ9YOiKINl
         d1lA==
X-Forwarded-Encrypted: i=1; AL+hErHMhPfN1qF8s/FKNn/VjTRREWvmSGCkMk6Hh74Le6O3GjIIavmNDKi93Gn+3eMcxOeaZaEC0oQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/m5o3OhaioLCvv6RMFByXMAszr8xar/h6nOgbz3KQeYMTc9fEV
	dlf+RoCOhW2bCQk4Zy/1XdVY3hZx6QZbdvC+lyxz/XYreUbt+LqJsGz3
X-Gm-Gg: AZFdTZcEqh1+ZFUWpfjldyL5DImy9qvA7tsUxcoZdhyLkXbxekIsR4qz+Xr9t8/OCG/
	mRQl+LevGU0rvdrzKPQgh7c6R09KlH9ub23+tEJojmRk5HHcReuXGSewuN/vav7R8cEO5l0tlTC
	yDn0yk58ZBB7x293s7Iow/e4kP4M9QmvNRVExle7CPTJQs5Tt2+bHzsnP2e8LNKiwtlWb83p1uO
	w7CpZBd1tlWdtdskSci5LYhUgd15Vx/KkKRI9UFgFdLBrjRrGCl4rmQb5URcOSnt0+twY/KxDq/
	MjUJbSOS9IoTtCyFb3moUV1s2MLUid8qADS3hapn1GGHFkX6fEGk3p1pcTApxYAQWZgoQoaB827
	EKOQUOq68vnbFBGyKYU73Jrc29w83ROIEEM9vGpsEIGIb18JiIqdFp/NjPnDU1cOyt/0AT35xiU
	A6HpEpzDwgPtKz96wqKRN9h7iOyAebUCy5CZrIenDtUoyGSD14w1s+QjDaY1T1BPtyQwz83h1Jj
	uzy55si5NtyPQbrIDOkSPKHjvkyK8C6tqx3N1L+InG3GnBzYSpfUAw7HXuc7N5mDwhZDv6yeZqp
	OkafXWU/cTdA4d32MTNpZ3QMrU3l+ewshE1vwiLHhxTu2CfZ8Ptccy13
X-Received: by 2002:a05:600c:a085:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4bb88811c75mr236581345e9.19.1795416925315;
        Sun, 22 Nov 2026 22:55:25 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([37.111.157.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2e6dsm20601212f8f.6.2026.11.22.22.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:55:24 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: [PATCH] ext4: preserve EXT4_STATE_MAY_INLINE_DATA on failed inline data conversion
Date: Mon, 23 Nov 2026 11:54:49 +0500
Message-ID: <20261123065448.60742-2-arbabhaider649@gmail.com>
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

Commit ef09ed5d37b8 ("ext4: fix bug_on in ext4_writepages") attempted to
prevent ext4_convert_inline_data() from racing with delayed-allocation
inline data conversion by calling filemap_flush() when
EXT4_STATE_MAY_INLINE_DATA is already cleared.

However, filemap_flush() is asynchronous (WB_SYNC_NONE) and can return 0
while folio 0 is locked by a concurrent buffered write and
ext4_has_inline_data(inode) is still true.  ext4_convert_inline_data()
then falls through to ext4_convert_inline_data_nolock() with
EXT4_STATE_MAY_INLINE_DATA cleared.  If ext4_map_blocks() fails (for
example due to -ENOSPC or a corrupted block bitmap), the out_restore
path calls ext4_restore_inline_data(), which unconditionally re-sets
EXT4_STATE_MAY_INLINE_DATA (both inside ext4_create_inline_data() and
directly).

When ext4_do_writepages() subsequently runs (e.g. via O_SYNC
ext4_sync_file()), it finds both ext4_has_inline_data(inode) and
EXT4_STATE_MAY_INLINE_DATA set and triggers:

  kernel BUG at fs/ext4/inode.c:2949!
  RIP: 0010:ext4_do_writepages+0x25c0/0x39a0
  Call Trace:
   ext4_writepages+0x285/0x500
   do_writepages+0x205/0x520
   filemap_writeback+0x1a6/0x250
   file_write_and_wait_range+0x8c/0x150
   ext4_sync_file+0x2cf/0x950
   ext4_buffered_write_iter+0x428/0x5d0
   ext4_file_write_iter+0x7cb/0x1450

Fix this in ext4_convert_inline_data_nolock() (called under xattr_sem,
which serializes against ext4_da_convert_inline_data_to_extent()) by
saving EXT4_STATE_MAY_INLINE_DATA before destroying inline data and
clearing it again after ext4_restore_inline_data() if it was not set
originally.

Tested locally in QEMU (x86_64, 4 CPUs, KASAN+UBSAN) using a concurrent
mmap + O_SYNC write reproducer on an inline_data ext4 image: hit
kernel BUG at fs/ext4/inode.c:2949 on mount #1 in <1s before the patch,
and completed 32 fresh mount/race iterations in 10s with zero BUG,
WARNING, or KASAN reports after the patch.

Fixes: ef09ed5d37b8 ("ext4: fix bug_on in ext4_writepages")
Cc: stable@vger.kernel.org
Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
---
 fs/ext4/inline.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index ceee69a66..c4ef91cd3 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1105,6 +1105,8 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 	struct buffer_head *data_bh = NULL;
 	struct ext4_map_blocks map;
 	int inline_size;
+	bool may_inline = ext4_test_inode_state(inode,
+						EXT4_STATE_MAY_INLINE_DATA);
 
 	inline_size = ext4_get_inline_size(inode);
 	buf = kmalloc(inline_size, GFP_NOFS);
@@ -1181,8 +1183,12 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 	}
 
 out_restore:
-	if (error)
+	if (error) {
 		ext4_restore_inline_data(handle, inode, iloc, buf, inline_size);
+		if (!may_inline)
+			ext4_clear_inode_state(inode,
+					       EXT4_STATE_MAY_INLINE_DATA);
+	}
 
 out:
 	brelse(data_bh);
-- 
2.53.0

