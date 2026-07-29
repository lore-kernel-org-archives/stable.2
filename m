Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327963DB336
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353505; cv=none; b=qhOg7ip0XTvqlApaO7424dFVSX3Q4ywCwzeirXQTYm0Zer1uRR5gG45Ufxjk9QUWgCoNIYsyC3Mu2yfZdsTdr/GDSlr8CrSwdOpnpIX3Q/KHoZHGixiYp7cM0TsdsagVIjKKkAwoOITTeeG6/hd/isyhKj2BS9zTQZ8rIF7LFv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353505; c=relaxed/simple;
	bh=7IF8vIjwJGWyprDwtisa7AuCLoZQ5785f7i8D4ueTSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tHoSHw48Yyad0qCytAPb9FWmROMt8xTHD3LDspuw1ds+s5c6rWxAMVBRFktMBurzd54wu3iCU8ZgmjDhbVB12dsdswBUKXQXrOqNqqy+WrQWRJc4TdU2z1g2VsZtOdDhBDiKv+3WMaGFMoNnYVRHefGeBpDG5qzEvvsiqhhwlKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez4scSX+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez4scSX+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ceb096e675so18008095ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353494; x=1785958294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OIo/8/GMi79rKZq27Qcu4swN+9Qdc9OYyywJWHqBKe8=;
        b=ez4scSX+a+CBP372h+wKOAuoAzBn6ZzTWyyP1c/ECEyYBn0AaxpyHRnf5sA95Be2JJ
         Ekojnu1AaXFan9y8bVvZbHxFl9HA/ugbSIvDHcUupN8FFJadyDq7N+JQyC2UPhbLE1Qn
         5evfaony2+XKiNClqZQ04AR1xxMJ7/UzKr9qdlrNO0KI06T6BDGeMiEZ0nA8yB6s7fio
         h3aJSwkfGYaI1dZF1zzb8pk3WMioAiGaPTZYUfzVUmd/igXH9pNvkW/iu3oLHJuBVD5j
         oqbvFtwEaX/MKW2bO2nos9mDkZ+QhqffscQzPGWoo1RlZjMwRQcuwPe9ffPkjfINr34/
         A07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353494; x=1785958294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OIo/8/GMi79rKZq27Qcu4swN+9Qdc9OYyywJWHqBKe8=;
        b=S/kt+SomEStl1aRhvrA1cTtfGznC9vXfszd16aYIhFWTmxl6mKRPj6K/CPgJ0UwBp0
         A8Z7nL8VsW4icRs16NZQ8BrVvnYSoGCmeUi9YBXcmPeFeY6GfLwoPiuA48k+fdcOv/J8
         akr3Sj3vbzrL+VS5tqOrjkcJhCV0TfcCte/Rwu2XlIhEXOpQwbeCkqRrVkmPU52lDqM/
         0zjK0+QAYTHKNoy0SBgi3Pse//FWN2vJGxjH8G4oHI6SgMmXecigNdkSk5uY7l36Yf5S
         SG8c9a4PNVyC7Vy6XboK16//1lqosXOp/g0rOEUWZPxXQC/1fUjQwdZRGjRdWoNkSjin
         bW6A==
X-Forwarded-Encrypted: i=1; AHgh+RpndY7po8HjoVawdqbl2kFcxgxyyryBU/cYAL7iTp+u6kv1JhVqLuiKgrsgGnCmZKFSUccqn8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz7E7xqyUI/AnHDdMh1gMpUncDevD+l4h1ags0f2H1NMQnDE1m
	s2u59hJSGg4P3lhtkCuZT6CG1W8gkvP8KMaRoM09ivF84TwvsmFC/Y5s
X-Gm-Gg: AR+sD11CCZ7JLDqD3chGIlxVdvnVWklkRIZ4/dXQLJ2VXKNd+pbyQoFXub0Gx1vd83I
	w73KUeDmH2Ng/ENzQXzgD8p4kmxhRbPdQiG8NojmQPWsn0iglk9UCib1De/42+11xSvx+IdB73d
	LWwQS0R4grLp7ZSH09YAgogIrpOLHvzxp+g4Pb2Pe4eTFl9gUHUMZelayds4rV4QhS6GwtsL4Y/
	u1iImkG5Z+KcG7Ey/dwp20c5vJf/XTenl4frCl2iOyfE4+1apUraHSTU57CLRU2Rm7baS00IGF9
	nUzA3zEgLyxbZvgS0VZp3J/t8p60WJ0uK+FEZY5ABr9xf3eYiBSoNZjZUQ9/P81aR4x3U6oocr9
	DtUMrDIHAJdk9VqGqz3kczFN3XdvGswGBiimYxQGApOu0ToOr2dQ06EQr561PdT/G7h2Nz8qiY/
	IE7yWuNHsPzZk/MEkHuiKmk4gO/GdTM48wRr2i93g0OorgEGttGt8TnyAJftQcCRAiEQxPu62XM
	NpbV05h8X/pEUNjsueDL29syY86qzKjzFYKYjdteP0D
X-Received: by 2002:a05:6a20:9190:b0:3c0:9c19:65c2 with SMTP id adf61e73a8af0-3c8ba669616mr9373377637.74.1785353494203;
        Wed, 29 Jul 2026 12:31:34 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504db2c4csm12450394eec.28.2026.07.29.12.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:31:33 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: Carlos Maiolino <cem@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Xiang Mei <xmei5@asu.edu>,
	Brian Foster <bfoster@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfs: bound inode buffer log item replay by logged regions
Date: Wed, 29 Jul 2026 12:31:27 -0700
Message-ID: <20260729193127.3084301-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xlog_recover_do_inode_buffer() advances item_index once for every run of
set bits in the logged dirty bitmap, but ri_buf[] is populated only for
the regions present in the recovered log item.  A crafted inode buffer
log item can therefore make the dirty bitmap describe more runs than the
item has logged regions, and recovery reads past the end of ri_buf[]
before dereferencing the bogus iov_base pointer.

The ASSERT() that checks iov_base compiles away without CONFIG_XFS_DEBUG,
and evaluating it would already perform the out-of-bounds ri_buf[] read.
Check item_index against ri_cnt before the first ri_buf[item_index]
access instead, and fail recovery with -EFSCORRUPTED.

Found with KASAN on a CONFIG_XFS_DEBUG=n build by mounting a crafted XFS
image whose log contains an inode buffer item with more dirty bitmap runs
than logged regions:

 BUG: KASAN: slab-out-of-bounds in xlog_recover_do_inode_buffer (fs/xfs/xfs_buf_item_recover.c:701)
 Read of size 8 at addr ffff88801387d160 by task mount
 The buggy address is located 0 bytes to the right of
  allocated 32-byte region [ffff88801387d140, ffff88801387d160)
  xlog_recover_do_inode_buffer (fs/xfs/xfs_buf_item_recover.c:701)
  xlog_recover_buf_commit_pass2 (fs/xfs/xfs_buf_item_recover.c:1130)
  ...
 Oops: general protection fault, probably for non-canonical address
 RIP: 0010:xlog_recover_do_inode_buffer (fs/xfs/xfs_buf_item_recover.c:703)

After this change the crafted image fails recovery with -EFSCORRUPTED and
the mount is refused.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Kyle Zeng <kylebot@openai.com>
Link: https://lore.kernel.org/linux-xfs/20260611212314.4610-1-kylebot@openai.com/
Reported-by: Xiang Mei <xmei5@asu.edu>
Suggested-by: Brian Foster <bfoster@redhat.com>
Link: https://lore.kernel.org/linux-xfs/ajGB9o5Ys6itU3Rh@bfoster/
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 fs/xfs/xfs_buf_item_recover.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index 02b95b89d1b5..2c2d4a0027af 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -659,6 +659,13 @@ xlog_recover_do_inode_buffer(
 			reg_buf_offset = bit << XFS_BLF_SHIFT;
 			reg_buf_bytes = nbits << XFS_BLF_SHIFT;
 			item_index++;
+
+			if (XFS_IS_CORRUPT(mp, item_index >= item->ri_cnt)) {
+				xfs_alert(mp,
+	"Bad inode buffer log item dirty bitmap: more dirty regions than the %d logged, for buffer at daddr 0x%llx.",
+					item->ri_cnt - 1, xfs_buf_daddr(bp));
+				return -EFSCORRUPTED;
+			}
 		}
 
 		/*
@@ -669,7 +676,6 @@ xlog_recover_do_inode_buffer(
 		if (next_unlinked_offset < reg_buf_offset)
 			continue;
 
-		ASSERT(item->ri_buf[item_index].iov_base != NULL);
 		ASSERT((item->ri_buf[item_index].iov_len % XFS_BLF_CHUNK) == 0);
 		ASSERT((reg_buf_offset + reg_buf_bytes) <= BBTOB(bp->b_length));
 
-- 
2.43.0

