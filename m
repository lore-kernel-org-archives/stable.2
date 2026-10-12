Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5392D7386
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798061; cv=none; b=dH9cjXml2scal48WY1aVkSBjuxlYkNNFY4dvibGr0KUWMa0uou2HIIjmudvzTjwYsQW4poK4xnq9ozh8r/35KLKEBpir0dZ2gCD8xGn7TemedtfuWHqO4dmbJWyJzX3MEahr7t9TV3bCDr1AapukDuvaS40JLP5XoCLmbmMijUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798061; c=relaxed/simple;
	bh=lmbfP6/LQtekS5d2UAKODhzYECFpFLpPjSLkUfC8pXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TqwFxFec03Pgn6FClSjdyBgwQ4gF2A4+Zn+ZRC8sJ7Oug21OAY1g/HBlc+nzf65+EC6hBzM3DgZwsGs8KPH2rkKfx/sq16NxHi/+BxnfybeHeCJKIPtC9pYzxlWpudkgWXG0pV2IKEIeTgeA8SvdnTFqxMcD/FqAlZOrURn1Bss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=KmzPzZGG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="KmzPzZGG"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e7457349eso162242685a.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791798059; x=1792402859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TFmCIpUfagd6jNTqIQiMG7oS1DzngqujJGbDwYFy81o=;
        b=KmzPzZGGAxQjOkzm1xv8X3AhmKEYRXzDhSZS090y2Bu8N7FEvbfBDH7tniySi1WnB7
         ksTf4RwnRBOExs+JIUYJctnAxgIPBdvZikViTPWNAsKzAugyjfnSOK7qPBKOl5vndkCO
         pdRxN4bwvGdIPV0An0q+XE3OpCUJDJ0ru+RqzWMWsQNBDF5ST/az65NN1LEn0p31rrUr
         LWlS4Ou/S/sAx2MOxgMZ4PGVrTwXML6dq+Qi8B9NS/6KzlI5vZhXfwa2I9Ki2MQYCTUV
         V2OUO5JG5qrRxEs5MkR4Ti65NZOLRrVsLKXuMRcX2PKIX9nAKRKPIfh7kslewmgTqof9
         F/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791798059; x=1792402859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFmCIpUfagd6jNTqIQiMG7oS1DzngqujJGbDwYFy81o=;
        b=vvWLgGQ9RllIykYq/oFSJrtnFhB9egCNLgtxsIc1lN+1g4xHASEE7RBrK4US6sEo6B
         lyZBzJF27wSvsUnvjV6QPR7tSq9ajMJFSgdvap+rmlz511leR8pymm0oouUGwWah7m+K
         7SVHqM0arppKrYZ11BavfDe+rE4+YVMGDvgWgj4lzWiXrN/flUNRrJvpXNp4o33hBY4N
         5Qj1R0jWEdXqzWl4kUaAKLftDAuqZhgjGMtlFRnti+Y7kauD8vm15m3yhj3RbETiuifc
         MqE7JdO53EvUUnvDqItZbfz0Cx6fNRVCBfPBwGR4eO6WC0JeiIRNaba5t9JQKxct6lc6
         uQXA==
X-Forwarded-Encrypted: i=1; AKwUvBwVQmBuGPFY1AzGMQEJX6Fi1T92OG34ti54eNBVaNa/AjHA7uKBjobp8TPtuHprqp0RMtZGIuA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2bPjmM/+cQ2otYLZfqDieauTD2nMaMOLRIdvSVRZoAKaB/9jF
	j0vraCoCGvq4UsquzZeRIhzYJGiJTs8H53K7ILtkdCHoAZN7IX6dMSIVU31RBrH0Wg==
X-Gm-Gg: AYBFou1VcwvqbLPblL1c80gfXPYk4sJdwelxiEc9qt5WRMu/o2GY6sG32siImH8oWTB
	rp5x7giSUbwEG0cnorEIKeeZ1PBkTnhOYb/obd++9dA1RMYupu0xGQe+Yf4c+5KOZT7ylndRUcI
	Unfom0Oq3OpSKpr/d06imxf57OagXS9lwUSOsIavugz8osqcXUpquaZKVzkN9TIslLG4FIBY4Yx
	/dWFYjuJWQiRqXIXhLm8Yvz91C4RPVwZGZ3kmnduB9PTTnyblhJCH4vVp3VMIKtr+J+g6q2C/nI
	uW70dIxSqeC6OGgc+l+nh/7C/Fi892V/uxYnE4Dnw6tkpz9qdijawurual2T8FKzMrTMUSTXqkB
	4Fi8g0IQzzLgiCFUGKF9+YtUuglYV0LU79PwSlNb4V/XoCq/6+z3u7EKJ9H7Uluf8pmRkLkKqel
	lcIWtLBExzurzyaCqwhroN6LtRfwEVNFZgz3wJJMwtDwHlR4hvkjwQY742elsqQnD2QRvA5JQyw
	OJWWTwoirq6qVxyURy/yA==
X-Received: by 2002:a05:620a:710d:b0:93e:5daa:67a4 with SMTP id af79cd13be357-93ebd225a6cmr1469980085a.29.1791798058677;
        Mon, 12 Oct 2026 02:40:58 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b815fd211sm21817986d6.48.2026.10.12.02.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 02:40:58 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	exfat@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] exfat: free clusters beyond EOF when a write fails or is short
Date: Mon, 12 Oct 2026 05:40:46 -0400
Message-ID: <20261012094046.2592731-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 82a81a7352bc ("exfat: add iomap buffered I/O support") and commit
867b9c96dc83 ("exfat: add iomap direct I/O support") made a write
allocate the clusters for its whole range in one step. They also dropped
exfat_write_failed(), which freed the clusters beyond the end of the
file after a failed or short write.

However, a write can stop early, for example when the process is killed
or when a part of the buffer cannot be read. As of now, the clusters for
the part that was not written stay allocated beyond the end of the file.
exfat_cont_expand() does not expect them, so a later write or truncate
that extends the file fails with ENOSPC. The directory entry records
only the size of the file, so the space can be lost for good once the
volume is unmounted.

The issue can be reproduced on a 64M volume made by mkfs.exfat and
mounted on /mnt, with a write of 1M from a buffer that has only its
first 4K mapped:

    #include <fcntl.h>
    #include <stdio.h>
    #include <sys/mman.h>
    #include <sys/stat.h>
    #include <unistd.h>

    int main(void)
    {
            char *p = mmap(NULL, 8192, PROT_READ | PROT_WRITE,
                           MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
            int fd = open("/mnt/f", O_CREAT | O_WRONLY, 0644);
            struct stat st;

            munmap(p + 4096, 4096);
            printf("write: %zd\n", write(fd, p, 1 << 20));
            fstat(fd, &st);
            printf("blocks: %ld\n", (long)st.st_blocks);
            printf("ftruncate: %d\n", ftruncate(fd, 1 << 16));
            return 0;
    }

Before commit 82a81a7352bc ("exfat: add iomap buffered I/O support"),
the result is:

    write: 4096
    blocks: 8
    ftruncate: 0

After that commit, the result is:

    write: 4096
    blocks: 2048
    ftruncate: -1

This patch will bring back exfat_write_failed() and call it when a write
ends before the end of its range, so that the clusters beyond the end of
the file are freed again. It waits for direct I/O in flight first, as
exfat_setattr() does before it frees clusters.

Fixes: 82a81a7352bc ("exfat: add iomap buffered I/O support")
Fixes: 867b9c96dc83 ("exfat: add iomap direct I/O support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Based on the exfat dev branch (1cae92a58966).

Tested on v7.3-rc6 with fs/exfat taken from that branch (KASAN, and a
second build with lockdep), on volumes with 512-byte, 4K and 32K
clusters: the program above, the same write with O_DIRECT, a process
killed in the middle of one 48M write(), a fragmented volume, and
asynchronous direct writes in flight while writes on the same file
fail. With the patch no clusters are left beyond EOF and all the space
is free again after the file is deleted.

Without the patch, the killed 48M write leaves a 1.5M file with 48M
allocated; after a remount and deleting the file, only 15M of the 62M
volume are free.

The inode_dio_wait() is needed. In a test build without it, a direct
write that fails while asynchronous direct writes are extending the
file frees their clusters, and fsck.exfat reports "less clusters are
allocated".

 fs/exfat/file.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index f106db945d8d..dc57d2c2f0f0 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -804,6 +804,19 @@ static int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size)
 	return ret;
 }
 
+/*
+ * The clusters for a write are allocated before the data is copied. Free the
+ * ones that a failed or short write has left beyond the end of the file.
+ */
+static void exfat_write_failed(struct inode *inode)
+{
+	inode_dio_wait(inode);
+	filemap_invalidate_lock(inode->i_mapping);
+	truncate_pagecache(inode, i_size_read(inode));
+	exfat_truncate(inode);
+	filemap_invalidate_unlock(inode->i_mapping);
+}
+
 static ssize_t exfat_fallback_buffered_write(struct kiocb *iocb,
 		struct iov_iter *from)
 {
@@ -862,7 +875,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	loff_t pos, valid_size;
+	loff_t pos, valid_size, end;
 	int err;
 
 	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
@@ -881,6 +894,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	}
 
 	pos = iocb->ki_pos;
+	end = pos + iov_iter_count(iter);
 	if (pos > i_size_read(inode))
 		truncate_pagecache(inode, i_size_read(inode));
 
@@ -909,6 +923,8 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		ret = iomap_file_buffered_write(iocb, iter,
 				&exfat_write_iomap_ops, NULL, NULL);
 	}
+	if (ret != -EIOCBQUEUED && end > i_size_read(inode))
+		exfat_write_failed(inode);
 	if (ret < 0)
 		goto unlock;
 
-- 
2.53.0

