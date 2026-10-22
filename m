Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686028;
	b=VIKN3Ykp5MZYwOHjc98bwtZNrCUUbOEF5hTWUyukSt0BzFDQkeb6ENtWUYcY/yUJHjUC
	 A6wal8Qliw+KbTTdqc1ANFY0fFSGhH7tMS6rgSM1tVKEP1PaqE3hw8waPJ+Azej86j32f
	 i/cX1BrV/aJrBla4JaqRuIoPsqS+2naqfI4umE6Jbj494Ah9hudvLX7noVafvi5z1/xvr
	 aAGFtu+oh9Nq6Gbysm2/bgvRJtjmE9xz0GzerSsflCOuqHNmgAJXA7DkOOnUf5cWOZcOr
	 t+5jgPrrkDDKctNZccqsXzKoRQAThz4UCvkXNyNCey/ynkG/vLS9OfZJBUfF0oXs+kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P83f4IprDp7e5obGVb5Vbzr+nVTtl7vkcsibamZws88=;
	b=c/yAakG/OhZaZxvY1gmyjgP6/TuGNyrk7PZiJGH/FIEIFi+E9XlXTjOm8E1avg+kihwP
	 k0xIvJJdjOba659tJoEIskpnYFZ5GwIkZOl+hcXdhaWD4W6i36sf2VeYLl7xSnJaXE1RU
	 FURUa2j9Q1NV0XTHBpcioodVHU9oFfNlS47Bd89e/evlYTDB+f67Aa4Hk2hzwDMggigCC
	 wrpGWR7JPDJxSDzLEsgkY/T05qap/gPG4fadlafj9BGvIYcqGawj0LvSi/RjYEE/hm59f
	 e8pvxPGixcfYA5zO3wKQpULGv++Pl5B4E79+HMqWZdzBe0jSyoZ/XYmK0wa2+spOB4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE86606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DE86606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917b78dfe30so800146d6.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792686026; x=1793290826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P83f4IprDp7e5obGVb5Vbzr+nVTtl7vkcsibamZws88=;
        b=KbaoyUs/PSNXKOd75b6/jtzcSg2o2CtEO3zAmKjr9+2epnPrzQNUDUzsCaSo4Kd8vm
         skhDicCz2/TPEmHC3KfuPTP4B32b3gGsQu7mU4iXz+PkM8H5udS51wCkfKfaXGeJZpMo
         j2XZwuYyDnnCQNnGwtIsM2memFFjNOtd6JpVsCUetQlAN88KlkjQvzREwtUEnppSzBwZ
         kG7Myu9FsYl2rafm5pWirFYctxoFksnRDWIkFJIa6EbRQUOiFOxHBzPZPCpbAlOnolug
         w039PlOX3DQCtdO9fnifn6gF7fVEnxf9AhRvhEQYuPmYuUIPbjrjokK/sxN6hUhY0uAn
         fSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792686026; x=1793290826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P83f4IprDp7e5obGVb5Vbzr+nVTtl7vkcsibamZws88=;
        b=mlxMgJ6JcVJJ6qvpj7dLuehhQ6ZwZEaVOYvGgrPphSL09zagf85FJOwcjWeWhvJKqe
         HCSNqZ9oi0nv+vnYz/EFjFf0KcxmfKeKyXK7xM4eX5j7xYKOCsqt2uc6IutPPEIG/BKF
         WhYDwikPlMp7XzzCIBEK2tQep47w+D+iMvfoHMzF2g4hTouFKzW+/khtIb4+HZSIKkyJ
         +C8ywi5BnVcpQ9K6kxfaHIdbZgvZtsoqF5rLEC7HygGMT9A+z8ZYR74+iuY0SQ6vaXoS
         A7F3O+VW6L8pnfMypDaZlRCbC0s5IGoeqMwtzpqSWusyBnqGPSQMZVZv/q9K+mGJnn11
         DQAQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/u6+epVyK6rNvsV0u6hCWrXY2tND6XvCPYqRJqW+eHgIM/IntgedLVu/pioh76V0tDBvO44Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBA4wd8y68QENgu4wRT+ycw4St9qm6RiN6h2vJzZCW+1St7hP+
	OkGpgHpTjjW5NpuMnnrML1QMoFLXAIVxw+s/YxiEFS83/6WQHfxn3+Ar6bXYGo7cSg==
X-Gm-Gg: AYBFou2sHKuNLkKOFz+bsUEKUVbVYGFLGgiZj89tJbSqMlfTXnH9kxq9vLOktSERm5E
	dYY4N6iSe1GupsHUcycEgCRJq5bbmrUi2bq+4nn24oQNLJh6JSUH9Tb4faARXmvca9l1RddKhcE
	GLZkgC91uXED0xusURmQY8IvyOISluqMXiB7ZONgp+3WLl2Ti32YqV8iuWph70hFwsmGQuhbk8P
	FvFMhJDo8Ef+RznCztqIO+IzYOFCQoouwPXjja9hEVjzbcuKMkvtf1A81rYIzDavUQ7zJ5VyT6r
	5XDddPkzbghfzAQqT0qQMuIOnBbFdUMLsAoHs03qXYdFrZArhiGdr88ngKt+/F7hkscOqnpEomv
	WLImcqrXyEo2TZaQaQ2XFikLFx5TnglInqSZGnpXJtwC8+HYxBOAgyskaPMNafB5PIWHp6MCkzD
	yzNiBvCVJ25WyTJUHMSubSGkvyBUmfUo9kz/WGqeu/MOdGmRwQPWA7i91LBv9bWOE+UfBSxmzES
	7fuXyGB0v9Lp9EquQSShvG6F35RJDaO8ErnMu4jH7IbEGI7OJ6gbLMR0fPkycYoHQDG8izkrZOf
	UQ==
X-Received: by 2002:a05:622a:1f8e:b0:536:6c4e:13ff with SMTP id d75a77b69052e-5369b861036mr90429941cf.56.1792686025878;
        Thu, 22 Oct 2026 09:20:25 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536ab792935sm30803631cf.25.2026.10.22.09.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:20:25 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: free clusters on truncate again when prealloc is off
Date: Thu, 22 Oct 2026 12:20:03 -0400
Message-ID: <20261022162003.1688315-1-hengyul@cs.unc.edu>
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

Commit ecbb433f9a8e ("fs/ntfs3: fold file size handling into
ntfs_set_size()") made truncate go through ntfs_set_size(), which
always keeps the clusters preallocated past the new size.

However, those clusters are only freed when the last writer closes the
file, and only if the prealloc mount option is set. As of now, with
prealloc=0, a file that is made smaller keeps all its clusters until
it is deleted, also across umount and mount.

The issue can be reproduced on a freshly formatted 32 MiB volume with:

    mount -t ntfs3 -o loop,prealloc=0 ntfs.img /mnt
    dd if=/dev/zero of=/mnt/f bs=1M count=8 conv=fsync
    truncate -s 0 /mnt/f
    df -k /mnt

Before that commit, df shows the 8 MiB as free again. After it, they
stay in use until /mnt/f is removed.

This patch makes ntfs_set_size() keep preallocated clusters only with
the prealloc mount option, as ntfs_truncate() did before. fallocate()
with FALLOC_FL_KEEP_SIZE still keeps the clusters it allocates past
i_size.

Fixes: ecbb433f9a8e ("fs/ntfs3: fold file size handling into ntfs_set_size()")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Tested in KVM with KASAN on ntfs3 master da4391c496fe, without and
with this patch, on a fresh 32 MiB mkntfs image:
- The commands above: with prealloc=0, the used space after truncate
  is 11816K without the patch, also after remount, and 3624K with it.
- fallocate() with FALLOC_FL_KEEP_SIZE of 8 MiB on a 1-byte file,
  with prealloc=0 and with the default options: same results with and
  without the patch.
- truncate(2) by path on the default mount: same results.
- 11 runs of a random write/ftruncate model test (15,900 operations,
  buffered and direct I/O, default, prealloc=0 and sparse mounts, and
  a nearly full volume): same results with and without the patch.

 fs/ntfs3/file.c    |  3 ++-
 fs/ntfs3/inode.c   | 12 +++++++++---
 fs/ntfs3/ntfs_fs.h |  1 +
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index c11da747270f..2afc2fe8f009 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -680,7 +680,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		}
 
 		if (mode & FALLOC_FL_KEEP_SIZE) {
-			err = ntfs_set_size(inode, i_size);
+			/* Keep the clusters just allocated past i_size. */
+			err = ntfs_set_size_ex(inode, i_size, true);
 			if (err)
 				goto out;
 		}
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 8adbdf1a7d11..72ecd802a8cf 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -887,7 +887,7 @@ static void ntfs_readahead(struct readahead_control *rac)
 	iomap_readahead(&ntfs_iomap_ops, &ctx, NULL);
 }
 
-int ntfs_set_size(struct inode *inode, u64 new_size)
+int ntfs_set_size_ex(struct inode *inode, u64 new_size, bool keep_prealloc)
 {
 	struct super_block *sb = inode->i_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
@@ -911,9 +911,8 @@ int ntfs_set_size(struct inode *inode, u64 new_size)
 	if (new_size < ni->i_valid)
 		ni->i_valid = new_size;
 
-	/* last 'true' means keep preallocated. */
 	err = attr_set_size(ni, ATTR_DATA, ni->file.ads.name, ni->file.ads.len,
-			    &ni->file.run, new_size, &ni->i_valid, true);
+			    &ni->file.run, new_size, &ni->i_valid, keep_prealloc);
 
 	up_write(&ni->file.run_lock);
 	ni_unlock(ni);
@@ -921,6 +920,13 @@ int ntfs_set_size(struct inode *inode, u64 new_size)
 	return err;
 }
 
+/* Keep clusters preallocated past the new size only with "prealloc". */
+int ntfs_set_size(struct inode *inode, u64 new_size)
+{
+	return ntfs_set_size_ex(inode, new_size,
+				ntfs_sb(inode->i_sb)->options->prealloc);
+}
+
 /*
  * Special value to detect ntfs_writeback_range call
  */
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 90ccfde951dc..0dd9efa2c88c 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -801,6 +801,7 @@ static inline struct inode *ntfs_iget5(struct super_block *sb,
 	return ntfs_iget5_flags(sb, ref, name, 0);
 }
 int ntfs_set_size(struct inode *inode, u64 new_size);
+int ntfs_set_size_ex(struct inode *inode, u64 new_size, bool keep_prealloc);
 int ntfs3_write_inode(struct inode *inode, struct writeback_control *wbc);
 int ntfs_sync_inode(struct inode *inode);
 int inode_read_data(struct inode *inode, void *data, size_t bytes);

base-commit: da4391c496fedc1ca78a99907712f2256ce8fb80
-- 
2.53.0

