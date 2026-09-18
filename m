Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3D5187E1
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750012; cv=none; b=iG/on3h1OftGd8QcjPQQRcJN+rOSU9P0cQgkzPA6UCGTk3Lf6CqZ9fA4iVJCbKsHEBMKLkLTKtjdep8Vq+vrAgMNKIRX8MmU8wFVWp0wym6KKK1jeBL0D6vr2zg/UkggVePmWeLjJAnmth051qa9LVuT/MuMwJngYl7Lmpni3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750012; c=relaxed/simple;
	bh=wKMEjBLMtgcuZryZ1Ys60OL4D/gso7hVRXG0PKiZqjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Br9i4E0kIWEA4FPCQMCNM4udAbLgq6HdFexXJMtZ4k1EGYZc4w1QcXV6N+wmi5UpPPZ/1Aq/Xc0cyZJwjsfC4ThbBYxcAMTDwVp+FhondUhgzlfiBwqqbXCI3TyqWBFPOB3XZrWdJ5Vbyj0HKkCKoLTAUdntbp8/upkdCCfMlGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUjSi4R/; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUjSi4R/"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633ece3so748133f8f.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789750008; x=1790354808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7otw+sAMt71PNBKElWj0ae0gBS5tnkAn3QFMjtVJGHE=;
        b=bUjSi4R/BmY86PhE+0uls2LFddbG7rje3EZa8EmpGtOkSLeBODSsAqr8gkRZ+mebrU
         dgbQ0oq8DdorB+DaMVTx84kyXvF4u857L8FYGpqfoSmpQEr5+4+3KTLjht3W54TKgrFO
         Tx6NKfyLYF0cRVwqSwBgdOoiCiGo/Iae+rY5XuvaWyc/Booip0m8RnIO5ptTd3gNR78a
         Sm/GAtbHb22b+xl829j2vJ/pgB7iMLALYLMwEe6eVZEsUA0cgqJtDxcWj9ZIGC4PZV+J
         ZoAPs8y8fZXdv/eX14baBqxzPXLkMnPs23GW5mUJtDUrJD0AGNDyKJI5kKk/QLK63Dx4
         ujuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750008; x=1790354808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7otw+sAMt71PNBKElWj0ae0gBS5tnkAn3QFMjtVJGHE=;
        b=hZSv4vDFnmFYYwh8bsadhNLflyRM5ZU27XQgVy2xkuXfWwy4Nz6e7XzmJEbuvXUhOn
         CmMx/tnWZEK8RBKkQc9pnbzUzv7vDgXgS4dBt5GIpFKyOoXDePFin05Jbv47zuJ3Sftz
         BDhwMxuIz9FjRhapT4MtU9986rTMsGw/wNmPSkcYW0Kw5aE+kv0gSKVoanQQglv2phVp
         VZJVTnPLwn+USA1+7ho0+pWTALZOT6QQbs+KCOXnleaUsoJo0amsrh1BCE36LI8KuXmK
         WAWHtOVv9/hxZhkBhJ8Ipv9yqsFt8KpX3LoKviWM1YqURVg8/Og8gG0Wq4ptV5BrHkZQ
         hVKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlwZqAbWS7lhe8nsmpFpq7tRgi3WOS6Qvc1sHHIMNAjYb/jA7k1zZw5e1sCFsVkf4UWzSDUs8=@vger.kernel.org
X-Gm-Message-State: AFuF++md1pnQD8D4eanHSAbaGMA/Hjh1NuG8BCqIA8gX57qqaYUVrqtG
	hRUZsuQYOjbiwBOvzEqWpqowGUveDHmB8gT/oBew9MW2h44Tqh7DHPbE
X-Gm-Gg: AYBFou3tCC4CpF3tH4CBH7EOaKmxOJzS7Am8fDYTZC2fse8YmKEi2sSNeG3C6Mc8Jgx
	uUMn8MiTMPiJ7iYzrr2p6bR3X23TP3g2N8wg7ZVePJW12UtH5NaxWBG/y70gTJ5p7y8qRozL7BO
	S6LHwWFrC6ocF7/HyljT2LgzkYOhzfTx7WA1ghJCYX8iPLUXI6xZGFpM+qD5hw+XJwM3qIWc6Cn
	pzfcBOxKi8EKF4zDR3VaTVndEV3Exw3yDY9f6ow1LvlgUsap4HmKd2km1VKiOCEScrdHndXvH2X
	N0IdzLt95phoSBpVV+kSzSUaNJ1N71bpzG6pQaVcmSTiYUYlq5eqJwqUQIJY7Eu7f4YqpO+qxsx
	zlkx7UkdnkBIkbLd7428+LjSPzhznrNeW8LVZfm5i9zrt0aGUK0cPPBBs7GwazumVPggVxU1mlb
	c+zixwKynIw0wMY8LJ4pVAExAhRcX5hdK6Er+79QBKwxo3lI0TnoCDHr5OTsvClOwejzdCp/34q
	j9iJBFt8mSFdZlJudmZWAhzkquEUwMWRjOfMzPOjAUe93xFiJu6qUb7Dc3lbodfxxvl
X-Received: by 2002:a05:6000:178a:b0:487:1266:5be7 with SMTP id ffacd0b85a97d-4871e26674emr4855205f8f.26.1789750007431;
        Fri, 18 Sep 2026 09:46:47 -0700 (PDT)
Received: from Raghu007.. (sgyl-44-b2-v4wan-174108-cust110.vm6.cable.virginm.net. [80.1.81.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48720072efcsm5135585f8f.25.2026.09.18.09.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:46:46 -0700 (PDT)
From: Palla Raghunath <raghunathpalla.0209@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	raghunathpalla.0209@gmail.com,
	syzbot+e8ebfecec06a009dd2d3@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	=?UTF-8?q?=EC=9D=B4=EC=83=81=ED=98=B8?= <kudo3228@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH RESEND] romfs: reject directory entry chains that do not move forward
Date: Fri, 18 Sep 2026 17:46:41 +0100
Message-Id: <20260918164645.9230-1-raghunathpalla.0209@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

romfs_lookup() and romfs_readdir() walk a directory's entry chain by
following ri.next, and stop only once the offset is zero or past the end
of the image. Nothing stops an entry from pointing at itself, so on a
crafted image a lookup of a name that is not present spins forever.

That loop has no cond_resched() and no signal check, so the task cannot
be killed, and it spins with i_rwsem held and the dentry left in the
in-lookup state. A second lookup of the same name then waits forever in
d_alloc_parallel(), and it is that waiter the hung task watchdog
reports, which makes this look like a dcache problem:

  INFO: task syz-executor239:5636 blocked for more than 143 seconds.
   d_alloc_parallel+0xd13/0x16c0 fs/dcache.c:2839
   __lookup_slow+0x82/0x2f0 fs/namei.c:1904

Require the chain to move forward and return -EIO if it does not. File
headers are laid out in increasing order and both loops already treat
the chain as a bounded forward-only walk, so this only enforces what
they assume. In romfs_readdir() a cycle never advances ctx->pos and has
getdents() repeat entries forever, so check there too.

The hard link chain bounded by commit d30b5a954e0a ("romfs: detect hard
link cycles") is a separate one. Sangho Lee posted a fix for this chain
in July 2026 that validates it at inode instantiation; it has had no
replies.

Reported-by: syzbot+e8ebfecec06a009dd2d3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e8ebfecec06a009dd2d3
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Palla Raghunath <raghunathpalla.0209@gmail.com>
---
 fs/romfs/super.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 7f783d6173e8..846b57f265ef 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -143,7 +143,7 @@ static int romfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *i = file_inode(file);
 	struct romfs_inode ri;
-	unsigned long offset, maxoff;
+	unsigned long offset, maxoff, next;
 	int j, ino, nextfh;
 	char fsname[ROMFS_MAXFN];	/* XXX dynamic? */
 	int ret;
@@ -191,7 +191,16 @@ static int romfs_readdir(struct file *file, struct dir_context *ctx)
 			    romfs_dtype_table[nextfh & ROMFH_TYPE]))
 			goto out;
 
-		offset = nextfh & ROMFH_MASK;
+		/* likewise, a chain that does not move forward would have
+		 * getdents() repeat entries forever
+		 */
+		next = nextfh & ROMFH_MASK;
+		if (next && next <= offset) {
+			offset = maxoff;
+			ctx->pos = offset;
+			goto out;
+		}
+		offset = next;
 	}
 out:
 	return 0;
@@ -203,7 +212,7 @@ static int romfs_readdir(struct file *file, struct dir_context *ctx)
 static struct dentry *romfs_lookup(struct inode *dir, struct dentry *dentry,
 				   unsigned int flags)
 {
-	unsigned long offset, maxoff;
+	unsigned long offset, maxoff, next;
 	struct inode *inode = NULL;
 	struct romfs_inode ri;
 	const char *name;		/* got from dentry */
@@ -245,8 +254,15 @@ static struct dentry *romfs_lookup(struct inode *dir, struct dentry *dentry,
 			break;
 		}
 
-		/* next entry */
-		offset = be32_to_cpu(ri.next) & ROMFH_MASK;
+		/* next entry; the chain must move forward, or a corrupt image
+		 * will keep us here forever
+		 */
+		next = be32_to_cpu(ri.next) & ROMFH_MASK;
+		if (next && next <= offset) {
+			ret = -EIO;
+			goto error;
+		}
+		offset = next;
 	}
 
 	return d_splice_alias(inode, dentry);
-- 
2.34.1

