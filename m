Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352112;
	b=fDJ5GNYG9CNHKatl1Qd3PhNkbNNISyABMbOET8BbV1YHCgEJtoFnlrdTAv/l+3+AFFJ/
	 GFRo62xU4dMMKahD4wfYlITV0AfbhgtIHIwBMA6GKHKDyWzKmR8X4FUVpscTOS7AiV1aM
	 3N6dIihky/+GEBm9u9by/bzp7NfsAQwzo+rByBEKm8oQmZPaumQi4mpCpsSKsi/vurCy5
	 GwF4L/Iz2JT+lreXCFV+xRuDZDS1yRXbxgrr56FTP05WjI93ztU4DcNrVma4DAon2OaCf
	 smd/O+bAorzRtJE79tiYmWxhZB7wUaOYeA0dGaWfII3csy8GUn4d/4Oamoxo4l0jUZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352112;
	h=DMARC-Filter:DKIM-Signature:Cc:Date:X-Mailer:X-Lms-Return-Path:
	 Received:X-Original-From:References:Content-Transfer-Encoding:
	 In-Reply-To:Content-Type:To:From:Subject:Message-Id:Mime-Version;
	bh=K3LEbG6xwteKsvtNo2f/L8YJueuoW81IhHXhpa5L5K0=;
	b=U9UEosLGiX6XTCNokvK2vLlzsOyEWFWH5PxIueHNcQiU2pzA3eMvUztWKgnSicfCSHPX
	 HCO+rCayz+tTclI6KZovCzTYsWLmcVrzgB072TJnr89ME392CpE57/nWIwqGAhV58/bcW
	 9s5jZ7H8ZqBrBrrLW2eTzmhhom8FhOeVx0h4paUhhAihO4NcMX3c6jUQcGildspdLXW1S
	 xBnw8L4EKlx43ggmYRnESPvwRDFx9rwyl1Ra221MYC17wz9DGnnFkMP6zWDadKrCODcDG
	 UM6npxws2phRchTSeWQS3aTMOFNbcNQvJBMyexjwmjbVmgE4RWRVWVvW3yeJs76vq1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=fnnas.com;
	spf=pass smtp.mailfrom=fnnas.com;
	dkim=pass header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=3UOkvJFC;
	arc=none smtp.remote-ip=209.127.231.42
Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD0D606A31F
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECD0D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=3UOkvJFC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1793352107;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=K3LEbG6xwteKsvtNo2f/L8YJueuoW81IhHXhpa5L5K0=;
 b=3UOkvJFC01tFm8R+sC3yd9Y4hEdLQ2eqXkT3LK7KmMJ+M/P3uNmgYmhz+mpV/oD/HuVjcq
 VbXOvC8LYYmVupxfZBvPWLHzUowSHlO487jKNRXA0uEDHdnv+DjwkRuQrm+b4Yodkf8Ip5
 TkNJqsz7zUMgXEIfwCh7cOuMPHIh9rwp7Ifb3iCJcAy49kaaBlVqe/ctihFZoaWuvfqOxo
 unFnMDwwvW3+CnBe+pMA1SmIgezugT2hYffgTljq3xGbqcusj1w2OpfBhfltdg0lBgEqfZ
 JpEM1JZgVifIPY/aGZn5hw8zpL5x7DMW3BI02jwBo2n/XkXOiijWVteladRt3g==
Cc: <stable@vger.kernel.org>, <yukuai@fygo.io>, <chencheng@fnnas.com>
Date: Fri, 30 Oct 2026 17:21:29 +0800
X-Mailer: git-send-email 2.56.0
X-Lms-Return-Path: <lba+26ae461a5+575cf4+vger.kernel.org+chencheng@fnnas.com>
Received: from fedora ([183.34.162.132]) by smtp.feishu.cn with ESMTPS; Fri, 30 Oct 2026 17:21:40 +0800
X-Original-From: chencheng@fnnas.com
References: <20261030092129.1671254-1-chencheng@fnnas.com>
Content-Transfer-Encoding: 7bit
In-Reply-To: <20261030092129.1671254-1-chencheng@fnnas.com>
Content-Type: text/plain; charset=UTF-8
To: <dm-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	<agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>, 
	<bmarzins@redhat.com>
From: "Chen Cheng" <chencheng@fnnas.com>
Subject: [PATCH 2/2] dm snapshot: fix discard writing into the next COW chunk
Message-Id: <20261030092129.1671254-3-chencheng@fnnas.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0

From: Chen Cheng <chencheng@fnnas.com>

zero_exception() zeroes one chunk of the COW device and takes the start
sector from bio->bi_iter.bi_sector.  remap_exception() has already set
that to the COW chunk start plus the offset inside the chunk.  That
offset is needed for reads and writes, but for a discard it is wrong:
the zeroing window is shifted, so the head of the target chunk keeps
its old data and the tail lands in the next COW chunk, which holds a
different exception.

io_overlaps_chunk() should have caught this, but it only compares the
length.  "maps to entire chunks" in snapshot.rst also means the discard
has to start on a chunk boundary.

A discard that is not a full chunk has a second problem: after
remap_exception() it is sent to the COW device, where it hits a chunk
that still backs a live exception.  After a discard the contents are
undefined, but the exception stays in the table and keeps pointing at
that chunk, so a later read returns whatever the discard left instead
of the snapshot's data.

Reproducer:

	truncate -s 4M o.img c.img
	o=$(losetup -f --show o.img)
	c=$(losetup -f --show c.img)
	dmsetup create snap --table \
		"0 8192 snapshot $o $c P 512 1 discard_zeroes_cow"

	# write two chunks, this creates two exceptions
	head -c 256K /dev/zero | tr '\000' '\252' > pat
	dd if=pat of=/dev/mapper/snap bs=256K seek=1 count=1 conv=notrunc
	dd if=pat of=/dev/mapper/snap bs=256K seek=2 count=1 conv=notrunc

	# shift the snapshot by 8 sectors, so a discard that is aligned on
	# top is unaligned inside the snapshot
	dmsetup create top --table "0 8184 linear /dev/mapper/snap 8"
	blkdiscard -o 262144 -l 262144 /dev/mapper/top
	sync
	echo 3 > /proc/sys/vm/drop_caches

	# chunk 1
	dd if=/dev/mapper/snap bs=512 skip=512 count=8 | od -An -tx1 -N1
	# chunk 2
	dd if=/dev/mapper/snap bs=512 skip=1024 count=8 | od -An -tx1 -N1

Before: aa 00  <- chunk 2 was zeroed although it was not discarded
After:  aa aa  <- nothing written, a discard is only a hint

Fix it by requiring the discard to start on a chunk boundary in
io_overlaps_chunk(), and by finishing a discard that is not a full
chunk with bio_endio() instead of passing it down to the COW device.

Fixes: 2e6023850e17 ("dm snapshot: add optional discard support features")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Cheng <chencheng@fnnas.com>
---
 drivers/md/dm-snap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index e49427bdbeef..6968e806eb84 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1946,12 +1946,12 @@ static void zero_exception(struct dm_snapshot *s, struct dm_exception *e,
 	dm_kcopyd_zero(s->kcopyd_client, 1, &dest, 0, zero_callback, bio);
 }
 
 static bool io_overlaps_chunk(struct dm_snapshot *s, struct bio *bio)
 {
-	return bio->bi_iter.bi_size ==
-		(s->store->chunk_size << SECTOR_SHIFT);
+	return bio->bi_iter.bi_size == (s->store->chunk_size << SECTOR_SHIFT) &&
+	       !(bio->bi_iter.bi_sector & s->store->chunk_mask);
 }
 
 static int snapshot_map(struct dm_target *ti, struct bio *bio)
 {
 	struct dm_exception *e;
@@ -2007,15 +2007,17 @@ static int snapshot_map(struct dm_target *ti, struct bio *bio)
 
 	/* If the block is already remapped - use that, else remap it */
 	e = dm_lookup_exception(&s->complete, chunk);
 	if (e) {
 		remap_exception(s, e, bio, chunk);
-		if (unlikely(bio_op(bio) == REQ_OP_DISCARD) &&
-		    io_overlaps_chunk(s, bio)) {
+		if (unlikely(bio_op(bio) == REQ_OP_DISCARD)) {
 			dm_exception_table_unlock(&lock);
 			up_read(&s->lock);
-			zero_exception(s, e, bio, chunk);
+			if (io_overlaps_chunk(s, bio))
+				zero_exception(s, e, bio, chunk);
+			else
+				bio_endio(bio);
 			r = DM_MAPIO_SUBMITTED; /* discard is not issued */
 			goto out;
 		}
 		goto out_unlock;
 	}
-- 
2.56.0
