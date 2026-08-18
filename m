Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30406344036
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064946; cv=none; b=YSrfCUHG+zpXfNF9eG32ZZMm5HkHhpoxyyim2Oa/k4cfT91YFsw0b0msqCT2Cfz5RCfezigphGDSs0CTy5mU1PkIAiHfHnaHLrToPhwkjq73Gv+rOls9l5HHTlJNeJSyuSYWYGCROJSrfS78mDSMded2qInRqbyvovI+KSHlBxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064946; c=relaxed/simple;
	bh=cBojm8RkVX6FRIrkZj9tO4jHBWALogJ6xQ3/fRKghc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LU0K7HzdsXhZI7uXvxnkejbrZaARxEjaAyD774ELCGx349csQexL8hS2wY9yl8mGmGLfsLwM8UJMmfLImrAU95xxfFn3Q5v7hmatuRDQyiavXAzpB/PX38iM8VvwkV0MOgWyiPmdqL6/JoZ8v0qFaTOwrHOuRK2B7+u+HDA8dpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHzr1RHK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHzr1RHK"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceb096e675so53480485ad.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787064944; x=1787669744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YsFaoS644NH2HkD0bh5kmr+46rtAuXi0WRjeGi4FwF4=;
        b=UHzr1RHKNWo/7uDDbcqtSRB443DT27So1KBIHmYRkfeOdO5g+9n1fObM6ziWvimRFD
         OtYBxVMJX1BRmbsgV9hRkkKrgKtS/l0plrb+3rIbWCJGy3sDjA9bahxGq2f87KLqwx0T
         z/4cc7bqgOL/c7jjHGdr5X3xQLAdoYPgPXY6fruoUgOi0IVLOK329fmL30lhQUTNoaTU
         CMJ88aRhyO8uSx7zlAjl3xjrAVgI/GcFPtLXY5eyxbcKOLo6cnGBHRQMrkds8zoT6y01
         37RxMyNig8KB71OQLuDbDreJVkSKaNPtI8mlgKvUqCSZCljzr87SXsuqBC9workKc92d
         1DqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787064944; x=1787669744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YsFaoS644NH2HkD0bh5kmr+46rtAuXi0WRjeGi4FwF4=;
        b=edU5TSqwGQnQBE/YZArV5E/amLKQ+a4HefwfbwGnrpVcBdsnE5uNhyhijonk/Hknpw
         2QJt2+udFnrfCN8oA40F9Uj24SrwOqxnf9USNqbzVGOvQDcrUtSRJsC46TsF6uDmntTB
         nutRa4het7IsY/arEAmd79nYZpoAXyh99JbeKpBPLM4ZuoYF/hbiLrei6gXFXWhY9Dhf
         mAzdD6RWP3IvlMpAnvwbaSRsPUYwZL0o7ZCu6IdGVaBIWHN+i4/YjVp9bNI+rPEUi5nq
         cg19BQb5dJ37GwfgCr+B2V/zofzeQDzXXnCH2U/rgbi70fccSjhCGr86/NaPY+/Q6URV
         AcOg==
X-Forwarded-Encrypted: i=1; AHgh+RqPfgOkqmVgpGB4B1V06xaGT1px22x3GEqC/IOcJJqW3x0e8J9HuSUH9/8u0ALZumPnSN1hZqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1H0UO1PikgNAi+APAcQYJOdoAmoRxvSZTQTaDqTgCpi/AETs
	qtzY7+CypNLE5JQm3qszQRGk3SdJNBH8Q0K9wXYBbpoxj1ypXkCyPGzD
X-Gm-Gg: AR+sD12VQz2wlOf7i1yOtEtz1jgyzCM7E9NJmwdZEiRXhIZ4cWl8/LOhJFntNL7GZrV
	54+npUTxt/XkWFnx74GyiJbWye/h9xtcpealltYZkUjj1u7ZAIHHgWJIPy8F2u3+C3m5fuDh6cd
	N6FyVzGkGZYMU6LRXYZfSUlRn8nWRSYsi4ZTTEThFSiT4EXeZo6oUJmMoz2RJL0B2/Y9ZkmvUmq
	TFef9WsT/00Ypy356KAXPoc38gVVehAqhRGUbsIO47OvlHp7eX8/LV7sZMl8rv0CVXwmQoFsjlL
	s6RNSwP6PUKYfY+rBX/bIqXukPe9gWM+iUjV0gDBgzCQLhg5a49DQWob6kLH0xtziqyYYqcPm+o
	hw8W5K1jnTSKPTO15btfqttZj5KEcPai4RVDhJB1ge4GsO7HaO2F6P7DbkcblBid1+8nUgSOcjX
	CrJ0X3DfcjI2u7FPsE+z8j6xHVoF4Ju2wOYftySXm/g8bqNf4pPJJPFlAzf59Z27jjViYloR243
	wYnMXQa0X4=
X-Received: by 2002:a17:90b:17c5:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-3933b874ad6mr34245555a91.10.1787064944280;
        Tue, 18 Aug 2026 07:55:44 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339d00eafsm7363740a91.1.2026.08.18.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 07:55:43 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Sunmin Jeong <s_min.jeong@samsung.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yeongjin Gil <youngjin.gil@samsung.com>,
	Yunji Kang <yunji0.kang@samsung.com>,
	zhanxusheng@xiaomi.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhan Xusheng <zhanxusheng1024@gmail.com>
Subject: [PATCH v2] f2fs: fix i_size when pinned fallocate partially fails
Date: Tue, 18 Aug 2026 22:55:35 +0800
Message-ID: <20260818145535.449055-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

Commit 4275b59673eb ("f2fs: fix to round down start offset of fallocate
for pin file") moved the allocation loop's start down to a section
boundary, but the error path still converts @expanded against @pg_start,
which holds the unrounded start.

@pg_start exists for that conversion: commit 88f2cfc5fa90 ("f2fs: fix to
update last i_size if fallocate partially succeeds") added it as an
immutable base because map.m_lblk moves every round.  Each round now maps
exactly sec_blks blocks starting from rounddown(pg_start, sec_blks), so
pg_start + expanded overshoots the last allocated block by
pg_start % sec_blks, and a partial failure leaves i_size covering a tail
that was never allocated.  Nothing corrects that afterwards either, since
file_dont_truncate() has already cleared FADVISE_TRUNC_BIT.

It needs a start offset that is not section aligned plus a fallocate that
hits ENOSPC partway, so the error path runs with expanded > 0.  On an
80 MiB image with 2 MiB sections:

  truncate -s 80M img
  mkfs.f2fs -s 1 -f img
  mount -o loop img /mnt
  touch /mnt/pinned
  f2fs_io pinfile set /mnt/pinned
  # 2093056 = block 511, so pg_start % sec_blks = 511
  f2fs_io fallocate 0 2093056 536870912 /mnt/pinned
  stat -c %s /mnt/pinned
  filefrag -v /mnt/pinned

The last extent ends at block 10737 either way.  Before, i_size is
46075904, block 11249, so 511 blocks of it were never allocated, and
filefrag does not mark the last extent eof.  After, i_size is 43982848,
block 10738, and eof is back.  A kernel from before that commit also
shows no overshoot.

Keep @pg_start pointing at where allocation actually begins.

Fixes: 4275b59673eb ("f2fs: fix to round down start offset of fallocate for pin file")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v1->v2:
- Added the reproducer and the before/after numbers to the changelog,
  as asked by Chao Yu.  No code change.

v1: https://lore.kernel.org/r/20260817022723.3324123-1-zhanxusheng@xiaomi.com

 fs/f2fs/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4b52c56d71f0..cc0d2b8c4684 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1919,8 +1919,9 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 		block_t sec_len;
 
 		if (map.m_lblk % sec_blks) {
-			map.m_lblk = rounddown(map.m_lblk, sec_blks);
-			map.m_len = pg_end - map.m_lblk;
+			pg_start = rounddown(map.m_lblk, sec_blks);
+			map.m_lblk = pg_start;
+			map.m_len = pg_end - pg_start;
 			if (off_end)
 				map.m_len++;
 		}
-- 
2.43.0

