Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795352589;
	b=vazWj++OA/MG5OS+kR2mUmD3eFaKvsr9+ySOTuFsVtttialXbDBlvnW0rVFLCPfjICSW
	 Lz08iIt7igejsY62GhwIZjolg0izbXh2BmHYmN89qyRr1OOWNiut3bXNTrNgpEV5+CAoZ
	 /XD6tjtH/Ev7ZNmZXRyvnBMXV8tuReVfELwI42uaOON05kEcJK7ObOebHsYwhadAYsdt6
	 zH6tavl5Xs+A6EAmX0hBEtmrTqIL4gWd4gzAqflGTkh0GLs/o0kZ8qIlpm30ZV1446jsQ
	 ixOUvyAzuzYdA39ECNddDZzeUoxdcHxqIK3HXFSJB/hup18ElkxR0uvjufQ9ax84tjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795352589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eMt+LuIAISp83lBsQo2yUsXzBU06/qpckceuqqW0mw8=;
	b=lVObsrE6VnDyefnOYXSHTxZcwZHTmUzKTMtfZb6vMbE0+x/oWhLf6iFA5v8aJ6N+zPJu
	 DK5OIcdAJ8cRLcqFX6BWtM6xTvoOdLjVl69hIO2SThpAyYHLSZloL+Cjln6GCltJJHEvA
	 DRLrczMFhfI0Uam/az05O2ZaXctnsSt/16H9YXjNsp/9fqXR/nbRml08d0/kcfF6vFYct
	 njPoNbJHUOIIUfymdrvGNTZlOLgs9fgnbZlZcCiaovRdgESYYt24IPrQ1aX8Ni01WCve2
	 fB05gIuk7t3J3KWdSncPHI1wsNI0e1/unxT/YzLMkHQfHJStuXmz07nj/WlUr8KyrxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=c+q6Hi+t;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197A606A32C
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 13:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D197A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=c+q6Hi+t
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b502b9b702so25495317b3.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 05:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795352588; x=1795957388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eMt+LuIAISp83lBsQo2yUsXzBU06/qpckceuqqW0mw8=;
        b=c+q6Hi+tL9782SFwDefp7XQBdxJIUoYa+4VMydpFxtnIR5fr17puG7ijniU1HbAJvW
         BfG8kT3MD3y30gZxSCUO9yDJho6iKrGkOPubIdSYjOd5INZt84jOZ3Y+918xJTEz3rco
         Xn8KfvMb9U2KZzMur3SK2+oDR4S3yHvLtaIa2dpiYkvZJVTrKmGaz6MT+lIlNCPDym0J
         kBl1GF5oVqitjKODyCwyrXy/g48c9/VfTChbrhWufP3mFRHHHyxu98jtiBwV2f6avkPh
         tiURYAjIMpIEuxdYUmBvzyNs9TIlSPO5aB3RevdgPU7/JvOfjyS3dGNgzsSTa9KJJx7q
         oVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795352588; x=1795957388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eMt+LuIAISp83lBsQo2yUsXzBU06/qpckceuqqW0mw8=;
        b=tkxtfEYkKHadAzG9nKT/C5Kj78xBU6r6Kk3COwW0mBc18YpCdXTY1bc8jonypY9lBU
         oGaiK1/KetN7G27yZ/7Q4uTkyrAI+TiLqKz7zkFTnTGoAVhY1fF+voqgwI9p8aR92GD3
         uXBLLSnf5QPDAGHSbCx/wdbP6WtAjtSjR1erTzfhpWLFa4KrViMr+Fqh6KzRRbxGQOOx
         +wHpWaarLaocq4tsRFA8KRIEvNxL2/QfI9WopRe31OAxdaYlVVfODTHSRu5rcO9Bg8Io
         EWNj3JF5OUBUJT7iyhY1i+Zeyrp3x3PIE6RVZ83s0koXnFK4JCb+BjbN3YR6dqHyrDy/
         QSmg==
X-Forwarded-Encrypted: i=1; AL+hErGzdY1uWovNRbmYDZSg9BkJ0iNFO31hMEs0mjcPBrTc0nZWK8JKjL/Grpi7nLMPs2isngd3s00=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Om6rwzrYBSBvSA5OfrZS04j0FD2ieVnrs2elUQC2TGAAfrQLH
	0zorgbrYPBIzaP8fS/JzfTWT3D7VZF4e26YRgDrCJcD5oJyHPsUBmA1BMhEV71LoXdA+z2Atub5
	B6uJZpQ==
X-Gm-Gg: AZFdTZcOFWEnBW8QDBHPMhgFiSNVhi0Dy85QbTC/sUqru4oKmj/Mg9WSet4SRPCCgLA
	7OhfCh2wi6di1ulCgxp3dLYRyKMh/vxcaajpftCxntB9Peg0dpGt1rpjQaXOEcg5d8EVaUdlR98
	tgg+i9r9LpXTLZDC0Vv7K0t/6b8rinNeV5RG3G5KGUJH9FQ8ww4Htv8ZUyKvrdHV+jh2eHg3kle
	hFBsfFHqHGNttRJkCtAdBXBdtgefF8QF3XE6KftkqmPPhRnmNLmTXpIdRbZJDTMBrSRh1gnZuwE
	zmD0vImt1ziWlAYYnagmbSepDfUIFMmPwBXN3qiMWBoFzRk8LgLwVd/CI1Q3kY8i8cfsLPF1pkq
	60IIK59T8uK4bC5KQ/nJAwuofkF1anNIcOVZZqCISuwPOHHaQRf3uAHDbMYbc0Rm3YZTTEPRQvy
	O7JmE58PXySe2NS8w3RuUjOVKrBn8/KjrCczrq0n0iLBwUxzVwsqtJZGEXHr9R8c3tmnIjgSa07
	k+kaIeZEiPIBYlchloAEFTZ6LE93IpJdQ8ahWY4UmSSWhUJYFLqQcSWEWP5VTi6sWsKgwQmqEK8
	ixRQKSclvVxUbVfCtFvcIefXzExQYQ80cYsMW3h1cCvwAvUlGPVA+2e/ggZhSed8msSscsYypA=
	=
X-Received: by 2002:a05:690c:6b81:b0:8b4:c43c:96f6 with SMTP id 00721157ae682-8b5204b5cb5mr33609547b3.39.1795352587557;
        Sun, 22 Nov 2026 05:03:07 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52030d5c3sm34756207b3.32.2026.11.22.05.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 05:03:07 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nilfs2: count new blocks that a short copy leaves dirty
Date: Sun, 22 Nov 2026 08:02:47 -0500
Message-ID: <20261122130247.2069007-1-hengyul@cs.unc.edu>
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

Commit 665575cff098 ("filemap: move prefaulting out of hot write path")
made generic_perform_write() fault in the source buffer only after a
copy into the page cache has made no progress.  A write from memory
that is not present yet now first calls ->write_end() with copied == 0,
and copies again after the memory has been faulted in.

However, nilfs_write_end() adds only the clean buffers of the copied
range to the count of dirty blocks, while block_write_end() zero-fills
and dirties the newly allocated buffers of the rest of the range.  The
retry finds these buffers dirty, so the new blocks are never counted
and nilfs_near_disk_full() does not stop the writer.  As of now, a
write from a fresh anonymous mapping is accepted far beyond the free
space, fsync() fails with ENOSPC, and the file is gone after a remount,
together with the other changes made since the last log was written.
On a volume shared with another user, that user's fsync() fails with
ENOSPC too, and the files and directories that user created after the
write are lost the same way.

The issue can be reproduced on a 160 MiB disk with this program:

    #include <errno.h>
    #include <fcntl.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/mman.h>
    #include <unistd.h>

    int main(int argc, char *argv[])
    {
            size_t len = atol(argv[2]) << 20;
            /* fresh anonymous memory: none of its pages is present yet */
            char *buf = mmap(NULL, len, PROT_READ,
                             MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
            int fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);

            printf("write: %zd\n", write(fd, buf, len));
            printf("fsync: %s\n", fsync(fd) ? strerror(errno) : "ok");
            return 0;
    }

and these commands:

    mkfs.nilfs2 -q /dev/vda
    mount -t nilfs2 /dev/vda /mnt
    ./cold /mnt/f 256
    umount /mnt
    mount -t nilfs2 /dev/vda /mnt
    wc -c /mnt/f

Before commit 665575cff098 ("filemap: move prefaulting out of hot write
path"), the result is:

    write: 67518464
    fsync: ok
    67518464 /mnt/f

After that commit, the result is:

    write: 268435456
    fsync: No space left on device
    wc: /mnt/f: No such file or directory

With this patch, the result is:

    write: 70217728
    fsync: ok
    70217728 /mnt/f

Count the buffers that block_write_end() is going to dirty, including
the zero-filled new ones, before calling generic_write_end().

Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Cc: stable@vger.kernel.org # v6.14
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

Tested on nilfs2 for-next (8fef1a9dec7b) with KASAN and lockdep: after
single writes (new, appended and overwritten blocks; cold, warm and
unaligned sources; 4 KiB and 1 KiB blocks) dirty_data_blocks_count in
sysfs grows by the number of blocks written, as on v6.8, and a nearly
full volume stops such a write at the same size as on v6.8.

A write into page cache pages that were read from a hole is not counted
either, on v6.8 as well, because __block_write_begin_int() dirties the
new buffers of an uptodate folio itself; this patch does not change that.

 fs/nilfs2/inode.c |  3 +--
 fs/nilfs2/page.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/nilfs2/page.h  |  4 ++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index b217eee57c36..dd0bed24972a 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -249,8 +249,7 @@ static int nilfs_write_end(const struct kiocb *iocb,
 	unsigned int nr_dirty;
 	int err;
 
-	nr_dirty = nilfs_page_count_clean_buffers(folio, start,
-						  start + copied);
+	nr_dirty = nilfs_page_count_buffers_to_dirty(folio, start, len, copied);
 	copied = generic_write_end(iocb, mapping, pos, len, copied, folio,
 				   fsdata);
 	nilfs_set_file_dirty(inode, nr_dirty);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 857926da9f21..0dec7b5b27c4 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -481,6 +481,47 @@ unsigned int nilfs_page_count_clean_buffers(struct folio *folio,
 	return nc;
 }
 
+/**
+ * nilfs_page_count_buffers_to_dirty - count buffers a write will dirty
+ * @folio:  folio being written to
+ * @from:   offset of the write in @folio
+ * @len:    number of bytes to be written
+ * @copied: number of bytes copied into @folio
+ *
+ * Count the clean buffers of @folio that block_write_end() is going to mark
+ * dirty: those overlapping the copied range and, after a short copy, the
+ * newly allocated ones in the rest of the range, which it zero-fills.  As
+ * there, a short copy into a folio that is not uptodate counts as a
+ * zero-length write.
+ *
+ * Return: Number of buffers that the write changes from clean to dirty.
+ */
+unsigned int nilfs_page_count_buffers_to_dirty(struct folio *folio,
+					       unsigned int from,
+					       unsigned int len,
+					       unsigned int copied)
+{
+	unsigned int to = from + len, end = from + copied;
+	unsigned int block_start, block_end;
+	struct buffer_head *bh, *head;
+	unsigned int nc = 0;
+
+	if (copied < len && !folio_test_uptodate(folio))
+		end = from;
+
+	for (bh = head = folio_buffers(folio), block_start = 0;
+	     bh != head || !block_start;
+	     block_start = block_end, bh = bh->b_this_page) {
+		block_end = block_start + bh->b_size;
+		if (buffer_dirty(bh))
+			continue;
+		if ((block_end > from && block_start < end) ||
+		    (buffer_new(bh) && block_end > end && block_start < to))
+			nc++;
+	}
+	return nc;
+}
+
 /*
  * NILFS2 needs clear_page_dirty() in the following two cases:
  *
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index c3ba3468af5c..4ccd740966ec 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -45,6 +45,10 @@ void nilfs_clear_folio_dirty(struct folio *folio, bool force);
 void nilfs_clear_dirty_pages(struct address_space *mapping, bool force);
 unsigned int nilfs_page_count_clean_buffers(struct folio *folio,
 		unsigned int from, unsigned int to);
+unsigned int nilfs_page_count_buffers_to_dirty(struct folio *folio,
+					       unsigned int from,
+					       unsigned int len,
+					       unsigned int copied);
 unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 					    sector_t start_blk,
 					    sector_t *blkoff);

base-commit: 8fef1a9dec7bf58a29bc8a7ee6909ab629401cd3
-- 
2.53.0

