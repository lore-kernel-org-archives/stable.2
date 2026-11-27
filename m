Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773298;
	b=izowPqcoT4I2rErchHwEprZQ5ko9ztAiVq8aB5uAYArdCLQe0NUh8k9upolIC9uqP4nF
	 M4PkEa7TOl9gTZVP28IfzzoJjR1IWstirdhKlYnUPsPPl6uomwJFamVci6Ia9aLvG4I4h
	 EPnoX4p33n0qffeGBVHT5+1CaWDuR1UxqDOnvSRDb6JV6XDnUKyx5EPKp2VSbvMttMGcs
	 99XwEW9ovPH9PFCPO2j1esdUVZUn8q8kWyTwvFCZdwlNIU6Lxj7MyMzlU3UQZPlBIpygK
	 Waxw2EpR8NOGqWvc5XvNilSlRZtNvjbw4Y/NCVeu8xUCngnQTa5kUg9RiV8BBdooStg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R5NRBFE6LyQ+OcOMVwBzMt4B5m7JjyvvYW8xEn2fXVY=;
	b=rWFpvfBuYXfkUHSpJrmzVbvgO+qRw0pCSiYGU/ojllqkgTD3rZic5tEQP6KGvCxM2O9v
	 OgO7QWqFFVIDPI4HTlQZIjZJY5xMdqnoJPa+C8Bzr2Zov4rj7Hn0vndzwgFJpNrW+YzUP
	 fP1FVrSzexJn0mhIp/ITY3PQ5X6OYQvPK9Ka9hh9NQ7d3Ez8K9Stf87aiCG0SoXZFa+DN
	 L8DAMvhRgn0MsULSDVQgkxLm91b3jslDnEPEAbEq23/GZ5qC2D+gNk4sKizD8slNVe3wh
	 u75OlgUJNmPLLKEiHSMiAAtKYCBNGGnCEoI0lpZiYAOzFitp6V437yh7eE4l/9KWLeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=nJpM88aV;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E472606A32F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E472606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=nJpM88aV
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b4f4095a7aso68603937b3.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795773296; x=1796378096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R5NRBFE6LyQ+OcOMVwBzMt4B5m7JjyvvYW8xEn2fXVY=;
        b=nJpM88aVuWd6NlXHVoqKaTO7UqOEpXIliV1H5+UHbq4wjj2ZeqLqUwGUY7hS0N08V7
         RHNJs3fHTck5qPsixpUH7UX7vxNZC3XTwF8lWnOtSkkGHOILCuAKivHo7AZRS5CBeytq
         1rG0938Q+tPwd2ZXBhFMAwy54PHOlqXB2reeoc+jZTG1DMnP29NbWf/zcw97lGcoGRFJ
         Jc7oSajVj5ADGTlU2Zd9/5l4kyjH7TnR4uNy7yqzYTvp51hkQ/CkvbAo+Ntqf+yXGwxO
         gSaDu0IRotpK+BQJv3HJ/55STY9aSgiXtmfxjE/dTiG1LqZNMFLC3B5LRkVIY1M8j8Q0
         z2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795773296; x=1796378096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R5NRBFE6LyQ+OcOMVwBzMt4B5m7JjyvvYW8xEn2fXVY=;
        b=d3zjnx4Qu6btfLzSb8mVSmFYTC2O599L0lev3DpCrTK5evmGh/i+v4lS/bdkHLPY1T
         kPUEa6DQIRfsNznFgU9pmHD9DJX2oXJaS7NsUwcpQubmXWoOv9qVk1N5HQDrXaM1n8jO
         TYBUDAzspfcq7Pyg6Uj1rKGSgtXQo1F84iwg+IM2gexzpP+gxB4pYdusmksRjl9ENIcc
         xu8fxMX7RKHX+g/o4q6ZBbgf1LDN2fBo9/gtUBrays4Rcci7PAOGg9B4kHkxLfBLL8ow
         JIj6Cvuu2SRO+MeSwYtToKc5nIda0yLrOH21xp4OTnA0jnyd3O7lnSuRM9PO1vL9uQH6
         wkRA==
X-Forwarded-Encrypted: i=1; AL+hErHvuazw9QTjGdX34U6R9zjfIwEzMnruDBfbfD9zO2XU5uIjczVh9QmLt8d/dCy5YAx4zt4VhOI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Q0LKFVK9Nl6U3aqppUcJm63aWChtMYkSq9xCJ80Cd4jITMekK
	ounBHVN+3z4g8Ox4WBdpC/IOo6F0crlVRT4qKPF83VlLuj9neE1gHhr2MVL4DD0tV2ULsIYfAZT
	JSp+e8JGd
X-Gm-Gg: AZFdTZf56TnSXsWAQ70vv9mV9gCgfNPw7fECqH6Csm5CFlUsV8caSKy10iwyGahqyKo
	OefzKV5cvxeWHm5qOJwPDhNf5WQZqJrV2HdylVNsb0gVcsaotpcL2go0jG66yF+Fn7yjQtB88Ou
	tjBlpvnWKye1YXFxUVQktfT1StxlRSFNyIsiNEQCXTUoyQF0cexXdzMe9I7tADeUTJHiABKjfUB
	Wn+xIiBWmkdPoE0G30/d2JT+tTxHQO+RquKs/cm47/R7pFZ14oRsOVvtVWVYbDOqLPeFztOr7on
	205dDLnHazCfxcMwaWl+FqipcOkbJRBo//jc7beOzCX9aB+w/Ub4Bwk+nTWYj2suWJmZapXYj4t
	s6JjwK9pokUSbtEnH0v+h0jwv8dRta3fAmayDEzsSf51Q+PbkZaQKpiVDGNr6BfA0jjl6sjMh2L
	mYoDSBNk/LZruj9mU/24zuZwUJ+lUCoxiIC4DF9ZpgMYbjzVMMXcZ8X9CdxaxJ14wf4gConsnjj
	5jVDzOw07W58abZ8dZ8zMHA7LsGFF/99qOYTuzLcT8G1T2F+sHA+Sjaqcn0UHK8pyYKK6+sr2Hc
	b/fL14iXo+mn0tOU6Hop6DZc6uOnNYuVH8qieEgqTF8LLD2p/s4=
X-Received: by 2002:a05:690c:3347:b0:8b4:da4e:ef09 with SMTP id 00721157ae682-8b520325401mr116169647b3.1.1795773296194;
        Fri, 27 Nov 2026 01:54:56 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202cb0b0sm95567197b3.23.2026.11.27.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:54:55 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] nilfs2: count new blocks that a short copy leaves dirty
Date: Fri, 27 Nov 2026 04:54:49 -0500
Message-ID: <20261127095449.1379289-1-hengyul@cs.unc.edu>
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

nilfs_write_end() adds only the clean buffers of the copied range to
the count of dirty blocks.  After a short copy, however,
block_write_end() also zero-fills and dirties the newly allocated
buffers of the part that was not copied, which is the whole range when
the folio is not uptodate.  The write is then retried, finds these
buffers dirty, and does not count them either.  This skews the free
space calculation: nilfs_near_disk_full() does not stop the writer in
time, and the reserved segments are consumed.

This has been the case since nilfs2 was merged, but it used to take an
unusual short copy, for example from a source buffer that runs into an
unreadable page.  Commit 665575cff098 ("filemap: move prefaulting out
of hot write path") made it much easier to hit: generic_perform_write()
now faults in the source buffer only after a copy into the page cache
has made no progress, so a write from memory that is not present yet
first calls ->write_end() with copied == 0 for each page.  As of now, a
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

With this change, the result is:

    write: 70217728
    fsync: ok
    70217728 /mnt/f

Count the buffers that block_write_end() is going to dirty, including
the zero-filled new ones, before calling generic_write_end().

Fixes: 05fe58fdc10d ("nilfs2: inode operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

v2: as Ryusuke asked, the Fixes tag now names the original
implementation, the stable Cc has no version, and the message says the
bug is old and 665575cff098 made it easier to hit. No code change.
v1: https://lore.kernel.org/linux-nilfs/20261122130247.2069007-1-hengyul@cs.unc.edu/

Tested on nilfs2 for-next with KASAN and lockdep, also with the short
copy from Ryusuke's reply (1 KiB blocks, source running into a
PROT_NONE page): the dirty block count is right, and a nearly full
volume returns ENOSPC instead of accepting more than the free space.

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

