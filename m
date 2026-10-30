Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371116;
	b=mjLAUYZ8azCpTOvNv7fIK7M3UVZPmwrQ78rf03PxxEEQqm4hdF7JDuNmtrZK4eZifok/
	 pb7XX/UqCIwFyvqVufngshFQawVgGJ4/8fyBQMuiJAmw4O88SIfZrHQdjMfKo5+cv/x7S
	 gOCmLdWHILXlicgBjMsTk5hTOdvdV2MdR8dvvvQG+H67aB3Wy+i4YVLCudj8ixXKACZ0B
	 LmpjGVHx4sfwvxME5qm/RLpdaL2V6trZ8+mzrRFg4TuDa/k+X1UO5hTvHkYLIDcU123rV
	 OQhEfKHRvtRFKlgPNZ0pYM0D++azgiN+C+agya9WFN59MXP6eQBYenAB4amB1Kn0cZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=UOSHPEuPJrP4hwKgANyKB+VdrZBD6GoAdbpymdbjrek=;
	b=vZBngH8h8fHaNnC3MIuY2nbuWqA0Zbi3UcgKaW8Oc8gvpPUt2O3j/7a3uKTt5SSQ9QQt
	 WYApue67gT5knap/eWOmBIME3la1EO6aTdXeGZu52ohL/JSXOz9OL+63sU0eeBSg55DWy
	 qme0dMa+n8fGgjyUnlmId3+4IW/VXKoo00Va0ObzBbntNfovgGn10NrCZvvE/u1FrYMq9
	 hzqlxBloXCkpofIDFPaYPMybjwZwzKCup57MExalIt//RfccULrFNzKPhQ19ejDqUmwWt
	 f2GAg5cZmwwpYhNYlmzMGyy6gU4LO4QkLNYSCkRIglyQ5hohqUazM58I4Nr0sbQfDPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EKId8D8A;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F790606A336
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F790606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EKId8D8A
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e503815adso67766985a.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793371115; x=1793975915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOSHPEuPJrP4hwKgANyKB+VdrZBD6GoAdbpymdbjrek=;
        b=EKId8D8A4eO24XIG8F66q3IfTX8eM65GzoGy39nJxqcKCAFNPMfVgLi2oOOuHHex0g
         YTiVb7O3vQwfqmqk9rpF1S+xTdgIz0ZY1mdGcTWJpC3gAB9BzrP7ePEhxio2FxjNFOnI
         hvRzyk28sz/TPmFQpKBQPLGcMdodk0bvtL2Z3z3tWt26vqwU1NrMS3gUcncnxHDepkq6
         HZG/3UNNzLr8KJL3YIcrm8wnZd2GPKxWRggFEPuh1/rG/LqIIClvnu/SJReb3iWLK2Z9
         0uPvQ4kNSx9XEzUBdSyxhUgWzOz+eJ+/D4SUIWf1JkZcZVaf4n5/x3Qn0YZTuaMO9yTf
         KoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371115; x=1793975915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UOSHPEuPJrP4hwKgANyKB+VdrZBD6GoAdbpymdbjrek=;
        b=znAXCinVzHN/PlkbHwP3aHPJrFRKLSPjTDfnzXQ5m7jHEjeoSlrKUgGcvF7JOw6StF
         IPDhRgDZgMfY14W6zsHxZV3K7/nhfbPGS8vKBQ2anRotzh2mqQ7q99/P/yCNUh9FHosQ
         Pd3j09Uap/2n9Dpyg1QeJOKURD8Hd7f9Q2Sp0LIafiwj9TBq7GH/Milj7NfXa+yeuefp
         r5Vp0LsTsR692y3POgtxrJbk9DtVDGI5FptWuTs/n428f4e4X2w42jahe/kWoHCAOxT2
         H0sIxi7lbHMCPF7ujWi0ZS/J/LH/7SfL6t86D1xRUO3tc+W1712ljlSCL/dM50yBBX07
         m37g==
X-Forwarded-Encrypted: i=1; AKwUvBz/yHYJYaHyjpdxQbatGgoZippRZJBj91pA+X7MXaaasH4djQJOLmrPOp7LMVyqpHrWblfCaiU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJM9t0d/AzIvZCgfWHvUe2gVRUFIUdQCiKMjqWjWuZVei3Du4m2
	cGKmd+vTmps6zeYxyBL/fCvVSab7z0hioxSoP79UtprmPWbjkjjyOfQ+gjJcv9KwNeI=
X-Gm-Gg: AYBFou1mqio/8KyUUicBN8OQgOnj9V25WtKum8ATkyeUNTOckSOp52FYgSHH6S0NX2V
	UfXD4xCIGaZSVWZfUxW/2FqhcypTt7J8DxTl9C2EmKv66EAPERwBCAkwdNGNvWOE916YP68n2FC
	ejrfF2Ghsww50G4Zo1SjBeURrQpBVqtijqHfYrIMcQLcSYnJy3dpzUUrjtsMlUqRaS27I/o77n9
	pHraS4s1SIV6Xnev2SRHjMvaawrqTBMzpb7r0Z/A/O6gWEOjqJHqe/45M52fqZzvf5HocDLdCz0
	SaqnY2a3fc9AWu5wQtezslrT3+dmm88KhPW+GL/H8BhOf+jO4M+cv3loei/KqysiRdWh5rDc6+8
	13veKHPA4YdyIlCVV0RyqWWR5jssDcDp22i71w3YNveKvqrZ+SGH6sQEVfkvKt4a8gbo1kju+TG
	Rkgk1KpdxOU+ikEwMkKZcL0BzkIEfCcxpPXrG2WhRjyrMRCvr86QbQ0mF0xJ1lApUJ/GC4NigF6
	hYQtd+3OjtaCy6yqH/x720OusBJC7T1tScJqEhRQxIcSNF8iqhxouFx2DdTR0llSJLw0tC/M6WB
	xZrReTQQ9pyguW3kLAhsUfiw4zn5Cr/uTnpOB4HTbmGh
X-Received: by 2002:a05:620a:1722:b0:939:5cd5:e243 with SMTP id af79cd13be357-944215653b1mr408320985a.6.1793371114903;
        Fri, 30 Oct 2026 07:38:34 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm155037985a.18.2026.10.30.07.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:38:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 30 Oct 2026 14:38:09 +0000
Subject: [PATCH 3/5] btrfs: make fsync wait after pre-submission errors
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
Message-Id: <20261030-b4-btrfs-data-integrity-v1-3-f4d4196731e6@toxicpanda.com>
References: <20261030-b4-btrfs-data-integrity-v1-0-f4d4196731e6@toxicpanda.com>
In-Reply-To: <20261030-b4-btrfs-data-integrity-v1-0-f4d4196731e6@toxicpanda.com>
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
 Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793371105; l=6592;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=HUNR8hbKnbK40hEJq7DcGZ/e7x0to5/xK6XjAAqC0w0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QErKZxQlWcswuo/SJzEJq+5Zml8uo2TMPibkv85z4z5HV+1oC0FMyLgnt26ijp7z39tiYPLwMcj
 R0i41c9zdwQs=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit f13e01b89daf ("btrfs: ensure fast fsync waits for ordered extents
after a write failure") made btrfs_finish_ordered_extent() set
BTRFS_INODE_COW_WRITE_ERROR in the inode when a COW write fails. The flag
makes the next fast fsync wait for the completion of the ordered extents,
which is where the extent maps that point to unwritten extents are
dropped. Otherwise the fsync logs file extent items for them, which is a
corruption if the log is replayed.

As the comment there says, this is also needed for errors that happen
before a bio is submitted. But for buffered writes those don't go through
btrfs_finish_ordered_extent(). When running delalloc fails for a folio
that already got ordered extents, or a block can't be submitted,
writepage_delalloc(), submit_write_sector(), extent_write_locked_range()
and btrfs_cleanup_ordered_extents() call btrfs_mark_ordered_io_finished(),
which marks the ordered extent with BTRFS_ORDERED_IOERR and queues its
completion without setting the flag:

  writeback (or a first fsync)             fsync

  writepage_delalloc()
    cow_file_range() for range A
      creates extent map and ordered
      extent
    cow_file_range() for range B fails
    btrfs_mark_ordered_io_finished(A)
      queues the completion
                                           no dirty folios, no writeback
                                           flag is not set, does not wait
                                           btrfs_log_changed_extents()
                                             logs the extent map of A
                                           btrfs_sync_log()
  btrfs_finish_one_ordered()
    drops the extent map
    frees the reserved extent

If the error was already reported, for example to a previous fsync that
triggered the writeback, this fsync even returns success. After a power
failure, replaying the log replaces data that was durable before with the
unwritten extent, for which there are no checksums:

  BTRFS warning: csum hole found for disk bytenr range [14434304, 14438400)
  BTRFS warning: csum failed root 5 ino 267 off 0 csum 0x8941f998 expected
  csum 0x00000000 mirror 1

Both functions share can_finish_ordered_extent(), so set the flag there.

Fixes: f13e01b89daf ("btrfs: ensure fast fsync waits for ordered extents after a write failure")
CC: stable@vger.kernel.org # 6.10+
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ordered-data.c | 62 ++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index df74c75d6c29..6543e99055f2 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -401,6 +401,37 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	if (!uptodate)
 		btrfs_mark_ordered_extent_error(ordered);
 
+	/*
+	 * If this is a COW write it means we created new extent maps for the
+	 * range and they point to unwritten locations if we got an error either
+	 * before submitting a bio or during IO.
+	 *
+	 * We have marked the ordered extent with BTRFS_ORDERED_IOERR, and we
+	 * are queuing its completion once all its IO is done. During completion,
+	 * at btrfs_finish_one_ordered(), we will drop the extent maps for the
+	 * unwritten extents.
+	 *
+	 * However because completion runs in a work queue we can end up having
+	 * a fast fsync running before that. In the case of direct IO, once we
+	 * unlock the inode the fsync might start, and we queue the completion
+	 * before unlocking the inode. In the case of buffered IO when writeback
+	 * finishes (end_bbio_data_write()) we queue the completion, so if the
+	 * writeback was triggered by a fast fsync, the fsync might start
+	 * logging before ordered extent completion runs in the work queue.
+	 *
+	 * The fast fsync will log file extent items based on the extent maps it
+	 * finds, so if by the time it collects extent maps the ordered extent
+	 * completion didn't happen yet, it will log file extent items that
+	 * point to unwritten extents, resulting in a corruption if a crash
+	 * happens and the log tree is replayed. Note that a fast fsync does not
+	 * wait for completion of ordered extents in order to reduce latency.
+	 *
+	 * Set a flag in the inode so that the next fast fsync will wait for
+	 * ordered extents to complete before starting to log.
+	 */
+	if (!uptodate && !test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags))
+		set_bit(BTRFS_INODE_COW_WRITE_ERROR, &inode->runtime_flags);
+
 	if (ordered->bytes_left)
 		return false;
 
@@ -436,37 +467,6 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 					uptodate);
 	spin_unlock(&inode->ordered_tree_lock);
 
-	/*
-	 * If this is a COW write it means we created new extent maps for the
-	 * range and they point to unwritten locations if we got an error either
-	 * before submitting a bio or during IO.
-	 *
-	 * We have marked the ordered extent with BTRFS_ORDERED_IOERR, and we
-	 * are queuing its completion below. During completion, at
-	 * btrfs_finish_one_ordered(), we will drop the extent maps for the
-	 * unwritten extents.
-	 *
-	 * However because completion runs in a work queue we can end up having
-	 * a fast fsync running before that. In the case of direct IO, once we
-	 * unlock the inode the fsync might start, and we queue the completion
-	 * before unlocking the inode. In the case of buffered IO when writeback
-	 * finishes (end_bbio_data_write()) we queue the completion, so if the
-	 * writeback was triggered by a fast fsync, the fsync might start
-	 * logging before ordered extent completion runs in the work queue.
-	 *
-	 * The fast fsync will log file extent items based on the extent maps it
-	 * finds, so if by the time it collects extent maps the ordered extent
-	 * completion didn't happen yet, it will log file extent items that
-	 * point to unwritten extents, resulting in a corruption if a crash
-	 * happens and the log tree is replayed. Note that a fast fsync does not
-	 * wait for completion of ordered extents in order to reduce latency.
-	 *
-	 * Set a flag in the inode so that the next fast fsync will wait for
-	 * ordered extents to complete before starting to log.
-	 */
-	if (!uptodate && !test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags))
-		set_bit(BTRFS_INODE_COW_WRITE_ERROR, &inode->runtime_flags);
-
 	if (ret)
 		btrfs_queue_ordered_fn(ordered);
 }

-- 
2.55.0

