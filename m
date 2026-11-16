Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841480;
	b=HXzPkXzzh6mflGcZ4YQIbaJjozSoV7pEkDKDXONZN8zU6UscbtmkqhctyfMeqZxYyhB7
	 onPHlbMVVIzScnobztloP2lN5t7Eu5atbvmeedBnHXSenbsWRKbA51/gezYSBhh20ZmiZ
	 OLo0AA8j9+hXCgZNy7RilvSUNyzJtN6o2Vq/35/QtqbzYO7wjvIQyiKZaGc1C36jyEpWT
	 fTcgEjWa+Zk+zTbwWoVdT+hhSc4AqIvudu93gzCLaCJGpT/yoyC99qb9rYLuc/Wm9LrF0
	 MNY/O5j+tEZtuNupv3dX6C/YhVDuF+WtK44YCKcp5IC987tQgYKi1ENODZxSKtdkwIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MvTRqL1mdtM+813rBnpKCpEGBrHo1i50Gwhh8qIKRW8=;
	b=XndHqtUXas5+AejmkXa42A2Ac4G9YpV0mxo6TFqINjRgk/XsqnrtN2Eb0rK1vKnL5+p/
	 ZlIUchC0Vue8wotgGIiDm8vOqXXMMbF5GSjQZUfBDW3WSqSV6xwELNVabvbLwwb2So496
	 8aWEqIG4dqBsVgnwSO6ZCEozkIeMdS2G5s1Q1PC9PBZuOR/pIn8KoE55kHWKNtEMDc+dm
	 3f4ZJep8DKHrcaZDke1tmBaDje/2vk78i5zGWPBySiZSaKurTHfOYUYqllQCfnKM4Kzz5
	 RMYi9vZSu+LWho4MIXVR41VyUh9SvVb6hCrld2cIotMcyZpstkp9lp6cCB7DMt+kpJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w6wz4DzJ;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6858606A88A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6858606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w6wz4DzJ
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36dbde64409so5183994eec.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794841467; x=1795446267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MvTRqL1mdtM+813rBnpKCpEGBrHo1i50Gwhh8qIKRW8=;
        b=w6wz4DzJ/F/IIzt0So0o/kHRzp5pszNlPly2C1qgvQJqxUvtvJ2oG6GdouS1L1wY36
         X68f4CN1XT0294VaGFL+8fYBxwe+dyWG+ciakFNSRbD9YRL7vGMwwXOoign2edE150+i
         0oRYSsDNgPvCYF3apJ38dM2bH9FlK16fNxfKchmjvNlfwnOH8aQSVOb/Vobm7G/AIbyY
         PYGtR9jpc5tpbNl94iruCWA/zAWjPQzlP/lYsLK1iwiEGYSEi0XnO9yUu8VY0n9aJ1uo
         1ULcIEcOKquvSqs4wOm3PBI164S6OZBfVKtar5ZvxcR4Gs7+zoKILtg6Mm3Ckj58PcrD
         FhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794841467; x=1795446267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MvTRqL1mdtM+813rBnpKCpEGBrHo1i50Gwhh8qIKRW8=;
        b=TaNSeO8+XPzdYzy/PC2Ydy7mM/E8XXenHYI4KJRqKpGfD71m78QjrEiMg1tQl8jK5w
         UNG+QSwG5uSZFfjtCS7IzUkxb2Tp8mmrZvoImztURrgPt+VlyeD3WkmRCrcZUvqTXecA
         JS9gkg6acU9yRrDD0+aW1jsHs9mJzy/d7wUNYHV6eDmPIPEqAxC9ASw/gzOdwkWTXqp5
         BikUTRyunsWHxaAxDb+OxkLXQL2nE1ldXqDp07whHbBwQ4rfS7ZJHSm4lTAXbcya+oXG
         /f5BZW/qyj6umB1FZ43GYCGUGQBm1dLcxut28ai7Oungr73U8qdEkSyhp0fo+vk6VSyM
         fLOg==
X-Forwarded-Encrypted: i=1; AL+hErF7MhtenF8STKb8uGGQBguqrwwSBinzfcSYpWE8ZPoGfzJVGVYT7ljIHEb0j88sFy9pRJA+s2c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xJgItKIAYcH2ihiXsyU7Sz7E6sA3VyOwse+qjzrDc/3iEBFwV
	aiiF2WEJFphys8B6mxTrytMvmSxz+lJm8Fvz1oaicE/lNUFfpA9NHrvHCIGfcdVJh3TjDA==
X-Gm-Gg: AZFdTZeb1MZnQR8+FJWfzYR8mwMc1Fc9iqbyLydWEeW1RM6pUXlr6EVQejqIAF2n/Ff
	aBCTDzrlrrGDEJ8u3cBdFSZ3mbHw8aBPfIluHWL8Vi2nbWJgcSjq2wNz2mCCAYd3X/itPom/zM3
	Dmym4MV5k8hHoFgs9hs/JECtHnorjI2ICUnpF9P+QZrxwsvefDa3ehdUzrmIuTtV0s7K9SATfDT
	k6V+qR6N7AJS/0/mZKnSfoWIWmqRKsTwLiOUy+V5GJcGsCKwMuE7EPjxsanRLUQYkWBOVkK7iRB
	vHI8lguKjWttmyNBpuF/EjDOFX7zz/uLWMGCOtqLYHllhYocczLjyY4uyHi7aXz3RWLwr2ZzUDy
	s3NvIwU39K1xZuC4y8eV/3+77TEnHKP70kN+wT6CU8eY8MaoMidzbTmt/pEUQ7bI6xnYJc3FeP5
	Qdw3c30K69tRg1i4OZNIlbcoMhwaSorkRaxdOIcQUqtLqw9zntFOaQFv9n4PvZTBP7IwKJAQfTl
	u/vn88SeyBTNjwx+zy17L7u/FmG4s72/S3cc+x59iTEqb2kqV+1wT14epGGcJx2LJ2VhUypF7BM
	JQpBkTI+mm1esIW3RveA8QqtYuiKEkhQw7LncO10CiVUfUPqmtq8zzTlSKRa58J0haxcv15GWDw
	xfQ==
X-Received: by 2002:a05:693c:8108:b0:376:5b99:a7e3 with SMTP id 5a478bee46e88-37963660626mr10679088eec.3.1794841466625;
        Mon, 16 Nov 2026 07:04:26 -0800 (PST)
Received: from dell (ec2-13-229-224-160.ap-southeast-1.compute.amazonaws.com. [13.229.224.160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0c40sm37141083eec.28.2026.11.16.07.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:04:21 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: pin parent dentry in maximal access check
Date: Mon, 16 Nov 2026 23:04:11 +0800
Message-ID: <20261116150411.321076-1-0xbeac@gmail.com>
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

ksmbd_vfs_query_maximal_access() reads dentry->d_parent without holding
a reference to the parent.  smb2_open() calls it after path lookup has
returned without the parent inode lock.  The AppInstanceId takeover
path also calls it on the old handle's filp->f_path without holding
that lock.  A reference to the child dentry does not pin its old parent
across a rename.

A concurrent rename can therefore move the child to another directory
and drop the last reference to the old parent.  If the old parent is
then removed and freed, d_inode(parent) reads the d_inode field of a
freed dentry.  If the sampled parent has become negative, passing its
NULL inode to inode_permission() can also cause a NULL dereference.

KASAN caught the following on an x86_64 QEMU guest with a test-only
100 ms delay between reading d_parent and d_inode:

  BUG: KASAN: slab-use-after-free in ksmbd_vfs_query_maximal_access+0x2ba/0x300
  Read of size 8 at addr ffff8881100f0830 by task kworker/2:1/81
  Workqueue: ksmbd-io handle_ksmbd_work
  Call Trace:
   ksmbd_vfs_query_maximal_access+0x2ba/0x300
   smb2_open+0x60d5/0xec30
   handle_ksmbd_work+0xad4/0x2110
   process_one_work+0x745/0x10f0
   worker_thread+0x511/0xc80
   kthread+0x330/0x410
  Allocated by task 319:
   __d_alloc+0x35/0x860
   d_alloc+0x46/0x1f0
   lookup_one_qstr_excl+0x171/0x250
   filename_mkdirat+0xba/0x4c0
   __x64_sys_mkdir+0x6a/0x90
  Freed by task 81:
   kmem_cache_free+0xb8/0x3b0
   rcu_core+0x549/0x17d0

The read is 48 bytes into a freed 192-byte dentry, which is exactly the
d_inode member.

Commit 2e450920d58b ("ksmbd: move oplock handling after unlock parent
dir") released the parent lock and reference before the final MXAC
query in smb2_open(), leaving this helper's bare d_parent access
unprotected.  Commit 4e45cca31d4e ("smb/server: add
ksmbd_vfs_kern_path()") later switched the earlier open path to an
unlocked lookup, exposing the MAXIMUM_ALLOWED query as well.

Commit 0383a66dabd7 ("ksmbd: pin parent dentries in SMB2 CREATE ACL
path") fixed the same race class in smb2_open() and smb_inherit_dacl(),
but did not cover this helper.

Take a parent reference with dget_parent() and hold it across the
permission check.  If the parent has no inode, leave FILE_DELETE unset.

OpenAI Codex assisted with reviewing the fix and revising the changelog.

Fixes: 2e450920d58b ("ksmbd: move oplock handling after unlock parent dir")
Cc: stable@vger.kernel.org
Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
---
The parent lease break sites in oplock.c are covered by a separate fix.

Testing used an x86_64 KASAN QEMU guest based on 7e1392a42ea2 with
0383a66dabd7 applied.  An SMB client issued MAXIMUM_ALLOWED opens while
a local process in the guest repeatedly renamed the child and removed
and recreated its old parent directory on tmpfs.

A test-only mdelay(100) between reading d_parent and d_inode triggered
the UAF within three open attempts.  With the fix, the same delay was
placed after dget_parent(): 789 open attempts completed, including 561
successful opens, without a KASAN report.  The delay is not in this
patch.  Without the delay, the unfixed kernel did not reproduce the
issue in 67,381 open attempts over 300 seconds.

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 7c3edbe6cb77..0f68500183d7 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -124,6 +124,9 @@ static int ksmbd_vfs_path_lookup(struct
 void ksmbd_vfs_query_maximal_access(const struct mnt_idmap *idmap,
 				   struct dentry *dentry, __le32 *daccess)
 {
+	struct dentry *parent;
+	struct inode *parent_inode;
+
 	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL |
 			       SYNCHRONIZE);
 
@@ -139,8 +142,12 @@ void ksmbd_vfs_query_maximal_access(cons
 	if (!inode_permission(idmap, d_inode(dentry), MAY_OPEN | MAY_EXEC))
 		*daccess |= FILE_EXECUTE_LE;
 
-	if (!inode_permission(idmap, d_inode(dentry->d_parent), MAY_EXEC | MAY_WRITE))
+	parent = dget_parent(dentry);
+	parent_inode = d_inode(parent);
+	if (parent_inode &&
+	    !inode_permission(idmap, parent_inode, MAY_EXEC | MAY_WRITE))
 		*daccess |= FILE_DELETE_LE;
+	dput(parent);
 }
 
 /**

base-commit: c710c654b8a3c92b34e38740dc17c29daf5b222e
