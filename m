Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207914;
	b=uK0JMc+sgchvQK38XVmYwfXHPJcAQaUEn+xCgopNCIMrz0WapZfvDnM0kW4hW7tUpmJd
	 uKlrXAsrgE3PfqzjoRrzYnVWhqNAOCPcs2qKVGDl11F+AwQzIA864drDDl84Xqly3J4Xj
	 wSrsP7mh4XnqNIJE4eAnfKTwM+BKFNJcsCChhTjca5mSfZPDjYas9KBXjApgTxCOIiibQ
	 H1zX0mME756RKiz/jzndioZO6G05aJ2du9sOfDqcehm18wUkozdRiFOz1hjC7ERwV08iH
	 rOU7zpkkKeJi0A7RcDcKtdFzKuGTxOUjyvN/SOBpKM4GA7Dxa8yw8ZgSmcgkRrhaRMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=KIKK398ilfo+vt1JEKAhnf8Yt2T9QcIWNWPp4UNSxb4=;
	b=Z3BjSKxU3d7fQX4+Px18OPxpstsJzJsT0dLsSZjSl/PM7ubF0SpPZrApcGuYUZ89Gpz6
	 /aJjpAHUknTKP5d6WQWRnGj1k+I6jFeS815mGSs4ato32T2dSC7s4O2Bnq52fXwlHUU0j
	 +Q99T2JzgJTBckt8jVpAxEhef8sLyxbkzHLyiP/p1/ZFbMlQLiYYg6Rg1iTo+IPdAWNEN
	 euYw+rqoFhQ5XQLFXw4GL1virMhDoZsvYmJ3ci5SjbsYcekNVzqO0VIzynoSq16jo4K+a
	 xJi2Bx/WUa6CTrGhh7NCdLGueePrkQJqjxZ/ffwtyuNMhmvscShWj5WgZ87veCRYTIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=QjHDcX+4;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CB606A33B
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 222CB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=QjHDcX+4
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9496317b730so162087285a.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1795207910; x=1795812710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIKK398ilfo+vt1JEKAhnf8Yt2T9QcIWNWPp4UNSxb4=;
        b=QjHDcX+4QmElXaG2zWR1LLmrWCgEc7SwMod6WXnv1rJ7ZMDOtfN0QVUNkrq3RE1Mf+
         y0whmkc25AtWEbyA6YfMxpkEl1Y+9dB/fZjdCrvmXw4p8sR+iH38ncf3qsFkW7TERRYC
         h3kOTAZNZBUJ/CjyfF8oy97nJz9EctJACQLyqF9613DjCONf91vJ020p3nO9W90b5Vpx
         iOdHdEmS8lzOSYnB2xLei1MF0EA/dcjn3WBeP/It92PCc5cqUtPCLvM+N9N8fHyqdjbF
         wWlcbv1cmxEPwI7waFe2eQCUBrpLvg5znwBJK3sWsgInksplaoyhLdxGri9MhABRdrl4
         IPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207910; x=1795812710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KIKK398ilfo+vt1JEKAhnf8Yt2T9QcIWNWPp4UNSxb4=;
        b=q8ij/Q997qkVijzNU9YKq0GjQrV1PqLDI2Sa/Xnu2MpW8pxVI/7QVoaJo+bSw9yATm
         /XCEwPsZ8NvwlymHUcPIoLvVdNyTKP+DxQ4IYcyVnTcdly6jAUMzayd5Q+Yru5O0fwAZ
         pbISwiD+/No2HiXZny2uvCS9vc1iZTgGFW0IJF1ljEMWrM9BJyCeww+7kWVeaguxoeRJ
         nYf/fnh1YZ57ZuICscM+J4KzUXQ7TXZntmB1vDxdUKSPTcs3k8/bJnLnbURCi+yNcfmR
         +I5ekrIrYIdslkByARyyN8tpmu2vJ9Pfbe49WNDAjIbcmlATn1qRxQdbkGnGSsipenLw
         gDQA==
X-Forwarded-Encrypted: i=1; AL+hErGAG7aUnoL1nqSn61yY9ZphCW2jNhpUy57KNFEPUZfLIcGvuYqgCv6zrTc9bbgNODHvHN/jQDo=@vger.kernel.org
X-Gm-Message-State: APuU4Z893Pn6k06Zx3bUYKXUKo/OYbpbo2bnZxyJ9hrAY0HeIUEkpxVU
	jx5lhF4Yuog0Bh24xe15sIMAQVyLfI0WIff8Rz91DNQzyS0luCKwUGgCIlCLKHEqdrM=
X-Gm-Gg: AYBFou1Rztw+ydzXEb/AFanB/7BKSCJDHBpi1Kri2Z4khINl9bKNrPgkchBRQuwwvrj
	+MfPcqDMO52kzPOWBykHqtLl+KLOT71NW3EvvfNv4r4Z3jDciOluZ7vWc5fIRUgFnQppusCEBHN
	nLB+m8mX1srCgfN2ZA7hUsooSLi4S0FJjwWNjo8Chvo9BOFi05+6zDb3IlEbcScvJ+zq3QNlUIs
	cPJsEuodYasTsidTsIuAicgRTpKdEkt+YLxvelHzvJeA+yLdFCt2xDvgTPF+9nnodAe+zDULjVM
	A8k11eZNqVoWSQWaAvWYyaVF7xm1V1yo5mQwNJLe9fTZCi9QR80GzycgV1LzZwzltWqLUH5L02d
	fbKKmNUqu/R9rUhktFSsI7b9zjdz3a5C8nkdFsOTAqDUMx7/HKfM4g+A91x6dfMws18qMb5fDxo
	8YDIxiR1lQP3+diwsohAIhGG61p/c+/kH8+bMTbbZFyMIXEnPxmLzsFDGgjOckNp0z7Iwrqv65W
	P+3hJQaNKHZPmqM6kDZqm4ZFe5U7nLVOxezbWSFT2qY5/HIb6rOxfH8kuJBabY6FgzfhYixjhpy
	e51m8ymkS3FF9ozzT0BP4UYqSFoKcKLdcruX3mypjpon7aU=
X-Received: by 2002:a05:620a:462a:b0:949:7472:b845 with SMTP id af79cd13be357-949bab0dc11mr704003585a.55.1795207909936;
        Fri, 20 Nov 2026 12:51:49 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921366d853esm29054896d6.27.2026.11.20.12.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:51:49 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 20 Nov 2026 20:51:32 +0000
Subject: [PATCH v3 4/6] btrfs: wait for ordered extent IO in fast fsync
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-b4-btrfs-data-integrity-v3-4-4de4b91b826e@toxicpanda.com>
References: <20261120-b4-btrfs-data-integrity-v3-0-4de4b91b826e@toxicpanda.com>
In-Reply-To: <20261120-b4-btrfs-data-integrity-v3-0-4de4b91b826e@toxicpanda.com>
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
 Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1795207902; l=7841;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=DvaL+jXaouqbVXZ9jHJEFWKWThs3+WNc07wy0Wopgvk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCmRl9TNd2voJjkZoD9F7iNn1qbOnHltKXg9NRP+iyT9sZlitqL6yoOkKheOyQEZUQFW4k1Z+iJ
 H0YafGBmuRQc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A fast fsync waits for writeback and then checks whether a write failed
or was truncated, in which case it waits for the ordered extents to
complete. The check can come too early, because end_bbio_data_write()
clears writeback before it finishes the ordered extent, which is where
a failure is recorded:

  end_bbio_data_write()            fsync

  btrfs_folio_clear_writeback()
                                   filemap_fdatawait_range()
                                   BTRFS_INODE_INCOMPLETE_COW_WRITE clear
                                   btrfs_log_changed_extents()
  btrfs_finish_ordered_extent()
    set BTRFS_INODE_INCOMPLETE_COW_WRITE

A direct IO write has no writeback for the fsync to wait for at all, so
the failure of an asynchronous direct IO write still in flight is missed
too.

The buffered case comes from commit a11d6912fdd9 ("btrfs: remove folio
parameter from ordered io related functions"), which moved the call to
btrfs_finish_ordered_extent() after the loop that clears writeback. The
direct IO case has been there since commit f13e01b89daf ("btrfs: ensure
fast fsync waits for ordered extents after a write failure") added the
flag.

Fix by having a fast fsync wait for BTRFS_ORDERED_IO_DONE on the ordered
extents it collected for logging before it checks. Since "btrfs: make
fsync wait for all incomplete COW writes", a failure or truncation is
recorded before that bit is set, and a barrier in
can_finish_ordered_extent() now orders the two, pairing with the fully
ordered test_and_clear_bit() of the flag in fsync. For a buffered write
the bit is set right after writeback is cleared. The writeback of a
buffered write that is not done yet is started first, and fsync returns
the error if that fails, since the rest of the ordered extent may then
not be submitted.

This depends on "btrfs: make fsync wait for all incomplete COW writes".

Fixes: a11d6912fdd9 ("btrfs: remove folio parameter from ordered io related functions")
Fixes: f13e01b89daf ("btrfs: ensure fast fsync waits for ordered extents after a write failure")
CC: stable@vger.kernel.org # 6.10+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c         | 67 ++++++++++++++++++++++++++++++++++++++++---------
 fs/btrfs/ordered-data.c |  6 +++++
 2 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4208587abff1..ee09c4ecbd4c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1512,8 +1512,8 @@ static inline bool skip_inode_logging(const struct btrfs_log_ctx *ctx)
 	 * If we are doing a fast fsync we can not bail out if the inode's
 	 * last_trans is <= then the last committed transaction, because we only
 	 * update the last_trans of the inode during ordered extent completion,
-	 * and for a fast fsync we don't wait for that, we only wait for the
-	 * writeback to complete.
+	 * and for a fast fsync we don't wait for that, we only wait for the IO
+	 * of the writes to complete.
 	 */
 	if (inode->last_trans <= btrfs_get_last_trans_committed(fs_info) &&
 	    (test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags) ||
@@ -1523,6 +1523,41 @@ static inline bool skip_inode_logging(const struct btrfs_log_ctx *ctx)
 	return false;
 }
 
+/*
+ * Wait for the IO of the ordered extents collected for logging to be accounted,
+ * starting IO on the dirty folios of a buffered write that is not done yet.
+ *
+ * Waiting for writeback is not enough: the end IO handler clears writeback
+ * before it finishes the ordered extent, and a direct IO write has no
+ * writeback. A failed or truncated write sets BTRFS_INODE_INCOMPLETE_COW_WRITE
+ * before BTRFS_ORDERED_IO_DONE is set, see can_finish_ordered_extent().
+ *
+ * If starting IO fails, the rest of the ordered extent may never be submitted,
+ * so return the error instead of waiting.
+ */
+static int wait_ordered_io_done(struct btrfs_inode *inode,
+				struct list_head *ordered_extents)
+{
+	struct btrfs_ordered_extent *ordered;
+	int ret;
+
+	list_for_each_entry(ordered, ordered_extents, log_list) {
+		if (test_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags))
+			continue;
+		if (!test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags)) {
+			ret = btrfs_fdatawrite_range(inode, ordered->file_offset,
+						     ordered->file_offset +
+						     ordered->num_bytes - 1);
+			if (ret)
+				return ret;
+		}
+		wait_event(ordered->wait,
+			   test_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags));
+	}
+
+	return 0;
+}
+
 /*
  * fsync call for both files and directories.  This logs the inode into
  * the tree log instead of forcing full commits whenever possible.
@@ -1626,11 +1661,11 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * IO of a lower priority task while holding a transaction open.
 	 *
 	 * For a full fsync we wait for the ordered extents to complete while
-	 * for a fast fsync we wait just for writeback to complete, and then
-	 * attach the ordered extents to the transaction so that a transaction
-	 * commit waits for their completion, to avoid data loss if we fsync,
-	 * the current transaction commits before the ordered extents complete
-	 * and a power failure happens right after that.
+	 * for a fast fsync we wait just for the IO of the writes to complete,
+	 * and then attach the ordered extents to the transaction so that a
+	 * transaction commit waits for their completion, to avoid data loss if
+	 * we fsync, the current transaction commits before the ordered extents
+	 * complete and a power failure happens right after that.
 	 *
 	 * For zoned filesystem, if a write IO uses a ZONE_APPEND command, the
 	 * logical address recorded in the ordered extent may change. We need
@@ -1650,13 +1685,21 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		if (ret)
 			goto out_release_extents;
 
+		ret = wait_ordered_io_done(inode, &ctx.ordered_extents);
+		if (ret)
+			goto out_release_extents;
+
 		/*
 		 * Check and clear BTRFS_INODE_INCOMPLETE_COW_WRITE now after
-		 * starting and waiting for writeback, because it may have been
-		 * set while we waited, and if a write failed or was truncated
-		 * we need to wait for ordered extents to complete so that any
-		 * extent maps that point to unwritten locations are dropped and
-		 * we don't log them.
+		 * waiting for the IO of the ordered extents, because it may
+		 * have been set while we waited, and if a write failed or was
+		 * truncated we need to wait for ordered extents to complete so
+		 * that any extent maps that point to unwritten locations are
+		 * dropped and we don't log them.
+		 *
+		 * test_and_clear_bit() is fully ordered, which pairs with the
+		 * barrier before BTRFS_ORDERED_IO_DONE is set in
+		 * can_finish_ordered_extent().
 		 */
 		if (test_and_clear_bit(BTRFS_INODE_INCOMPLETE_COW_WRITE, &inode->runtime_flags))
 			ret = btrfs_wait_ordered_range(inode, start, len);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1a4e3e34ec11..728e73baf15e 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -420,7 +420,13 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	/*
 	 * All the IO of the ordered extent is finished, we need to queue
 	 * the finish_func to be executed.
+	 *
+	 * Order BTRFS_INODE_INCOMPLETE_COW_WRITE, if set above, before
+	 * BTRFS_ORDERED_IO_DONE, as a fast fsync tests the latter without
+	 * the ordered_tree_lock. Pairs with the test_and_clear_bit() in
+	 * btrfs_sync_file().
 	 */
+	smp_mb__before_atomic();
 	set_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags);
 	cond_wake_up(&ordered->wait);
 	refcount_inc(&ordered->refs);

-- 
2.55.0

