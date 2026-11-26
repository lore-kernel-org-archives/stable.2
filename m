Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658497;
	b=aHqofp8EkCfuJ1A8QPHM4rqBCPKf4jwAIfQCtRFFBtX+rC7h0vh+sf8wJ9OnJVwPq85H
	 xH0EHkygZnJMsXs9zojMZrlicoKgqs+iy3WAMey2AUZbstfYP4AYyb+2WlGGvqeIcQ3k2
	 FVVAvL6UkuJMGNh+qjavLjYZiN0jIIn3W81V7IrFvDKNFNvDrq2md5t20z3zgay6Kjk+c
	 LmEz0H6PxAjnkUKptlg9hvQDOHm4f32i2xLLbbYe+58YHKz1JNGPjLsksYCz5p/dKOmLZ
	 hFBihXElpnOahz17XLbx0FpmraWl1ZN9WdojZM6D5RrLXv2Ny1LKXsCUm23X+UAViaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0JixWO8SMEA50WF8n4KhQUS8q4QvKxbUZlWyzztb5dM=;
	b=xl5jRITKD82uRHCYbdLZj0y1NCzdo5XHggbuaUdv+VrbbvX5gqdGG1S2lA0h46Qgkq66
	 BPGmPQyqFSHKIfC0WF3ZxW7cmql2aaZ7ET0kmxL3MQ82tc0vMNfJQdZYryii3x1O6FRY4
	 fmD3ovOt7oOJ/fFbWIUYRJcSxxfX8o4YPWVLFTXxcsuM5UlZ7KlR6keZgIzhyGxRAx1Dp
	 dIIXQ7ee2lzrYmMuhOWo33TKxA5jBdhYztoSLP0VXYVeoCJ9Jt3acLEG5XS0vg9ujvjCL
	 /dTULDxmXC9+qb+cQhybIXhFirDnzwHrreiIzc+nrkEH/Q2AkAV/NjMHNkfw+4rAtKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WrHAEPPh;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CB8606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1CB8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WrHAEPPh
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f05b465cd1so35563335ad.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795658496; x=1796263296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0JixWO8SMEA50WF8n4KhQUS8q4QvKxbUZlWyzztb5dM=;
        b=WrHAEPPhE8RvdSSjxV5EBaEFNwhSOuiSyzHzwtnSw0y5p9jTIJxRWb5pqPK8lS6fwx
         Xr8l8t6os2i6aWOwI3ToZppY+gScNq3/YDYHJ+sCyuKvjccEy8amnOyKShkIv25yXDYP
         YbPK1NVU/NSK3cAMxgZ0XAiMfacza41UCtyArDmvrhheUeNCCqwtt4vdxwYL6EPj+clS
         /Ca57iCxEBj1hScq27qwr15wbID28KJqJjY+/XrOnU1ehCKbRekZVhMj9OfqC6X4G7d3
         rT1r07cH4/REAl2luE4GfPsii44MdHNADFC73yeUxQ3qh0QeP3Ungy1NLNG9fbKhrVuO
         vkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795658496; x=1796263296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0JixWO8SMEA50WF8n4KhQUS8q4QvKxbUZlWyzztb5dM=;
        b=tQ+Yv3TBKgosfclQM/2e56eckrtLHusbc6hlsg+JDAqz2flG2KUxFfcNgz2V8JY+jD
         YiE13m7M4djAK5ipzSNK5Qijfg8Lp8Wf6VtD08dOoXZtYc59kgP/CzFIfc69W2mneGSz
         9U/XqLg0OpBGnZF7caCKjdD8n6q2y/3MVsywEWqULdKqOE86JCcwdjbF+bSZKQULqyNM
         lGf5UoQb0hsTd7BTycAemmCh/G8gFOQ3stRwsc5Rcm4Hk5GlXGHm3aaEjWnWLY56YzWx
         tRnikTfbtNY8saM7MC5NDLifR9dDDxVqg8RSIB5BCV5Ta7odpiVmTzObVxBvk5aOQ1O8
         CEfg==
X-Forwarded-Encrypted: i=1; AL+hErHnZxdUUrM8kKZTiFfdM3V9cIZppCBeEEHg/P6GQX3oGNQKqd5rJmClGGZ0wt2lYSYIhGMfdmc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1FsmD0PupkUpvKXdtdxB0nj5R8xZu0WQMHJ9tC5swECMBnwJ9
	KlVGzazPald/b3pn81eod7dD8s4/gtckriZj1j19kcTmWs0fOUpG8nHE4afQvQ==
X-Gm-Gg: AZFdTZcazatXezqRao9+Q41oCyF4RfgPREM+cxkc2O73x4uG6H7UB8wsWe1Pg5yqe+d
	mVw23qN04ojrh2CtZF/xZqPeTZsDnzWYbePRHO8cgu80Gf7JLUeeWZzZYuqbBqoh5F4ZdMIKTqu
	BNlnAeqFWnymlQu1h821zsE2nOK2yIQl2i6tz6Ib2LLpgiXsJjKR++v3JZgz8VQd/rE3HJjrLdT
	1Zi4MIWVWo7mzZtVGCjGG4ei/8Zicow9ZlAEhTT1IDK+g7BzVyxrFIqHfe4Frw+l5TB0tFsWpA1
	GQW/fpx2KYkRapZMPubt/P5G8+i1L8lCb4ts5ksHVfGie5PVI8hj42wlZfPuvmFZDfEXv9JUc0E
	zkh/vpRpjFqjhzvtvpP1YfEFQNnvVaU4JtEdbIk6R3rYaCdJtCh1wSqVf4lSAkrl34pO3UtQ7nG
	2qLyqo7e/dz04fJ4X+L1NC9WODq3DPoLW9skTxfpJmKUgEVcr63en+QLzrPTQaPmYnkkHst/WOf
	p7zbwuUISTPVy0j3K/5bXKFZLB0laIxR3FQabbcxRsPy/Q8iQ+7KQAHCK2HQ17br6V959YE+Uw5
	JGY40NZid6DVKSqcglksZBVUi0ViW1p5JHKaKeGrqLiHywUJBRJ5ITmFWOz3G6am2h8I06xuwkf
	WWHIdIIzfSvxppQZMuD2YABLU5bgjyIqSWZA1HMcZQok962seQw1ZvA==
X-Received: by 2002:a17:903:181:b0:2e9:ca71:45f4 with SMTP id d9443c01a7336-2f0d8565618mr38910575ad.33.1795658496124;
        Wed, 25 Nov 2026 18:01:36 -0800 (PST)
Received: from fedora (n49-177-87-40.rdl1.qld.optusnet.com.au. [49.177.87.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84027sm95269755ad.7.2026.11.25.18.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:01:35 -0800 (PST)
From: Ronnie Sahlberg <ronniesahlberg@gmail.com>
To: dm-devel@lists.linux.dev
Cc: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	bmarzins@redhat.com,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dm era: read the metadata again at the first resume
Date: Thu, 26 Nov 2026 12:01:23 +1000
Message-ID: <20261126020123.655988-1-ronniesahlberg@gmail.com>
X-Mailer: git-send-email 2.56.0
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

When a table is loaded for a device that already has an active era
table, the new table's constructor opens the metadata device and reads
the superblock into its own struct era_metadata, while the old table
keeps using and committing the metadata until it is suspended.  The new
table's view is then stale, and its first commit, in preresume, writes
it over what the old table committed after the load:

  dmsetup reload era --table "..."
  dd if=/dev/zero of=/dev/mapper/era bs=64k seek=500 count=1 oflag=direct
  dmsetup suspend era
  dmsetup resume era

The write to block 500 is missing from the era metadata afterwards.
The stale view also refers to metadata blocks that the old table may
have freed and reused since.  A reload is how an era device is resized,
so this is not an unusual thing to do.

A status request for the inactive table commits the stale view too,
while the old table is still active.

Read the metadata again at the first preresume, when the old table has
been suspended and has done its final commit.  This is done in the
worker, which is the only user of the metadata.  Until then the target
doesn't write to the metadata device: status doesn't commit, the worker
doesn't digest writesets, and postsuspend does nothing.

The resize that follows is moved into the worker as well.  It was done
directly from preresume while the worker could be running, so a status
request at that time could start digesting writesets into the era array
while it was being resized, and commit while preresume was committing.

Fixes: eec40579d848 ("dm: add era target")
Cc: stable@vger.kernel.org
Signed-off-by: Ronnie Sahlberg <ronniesahlberg@gmail.com>
---
An AI coding assistant (Claude) was used to review this patch, to move
the resize into the worker, and to help with the commit message.

Tested on 7.4-rc4 in a VM with lockdep and PROVE_RCU enabled: writes
between reload and resume, status and clear of an inactive table, and
shrinking and growing by reload, with the metadata checked by era_check
and era_invalidate afterwards.

 drivers/md/dm-era-target.c | 117 ++++++++++++++++++++++++++-----------
 1 file changed, 82 insertions(+), 35 deletions(-)

diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index ea499adca4ce..801ca632581b 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1187,6 +1187,13 @@ struct era {
 	int sectors_per_block_shift;
 	struct era_metadata *md;
 
+	/*
+	 * Set by the first preresume, once the metadata has been read again
+	 * and resized.  Until then another table may still be using the
+	 * metadata device, and nothing may be written to it.
+	 */
+	bool activated;
+
 	struct workqueue_struct *wq;
 	struct work_struct worker;
 
@@ -1205,7 +1212,9 @@ struct rpc {
 
 	int (*fn0)(struct era_metadata *md);
 	int (*fn1)(struct era_metadata *md, void *ref);
+	int (*fn_era)(struct era *era);
 	void *arg;
+	bool no_commit;
 	int result;
 
 	struct completion complete;
@@ -1338,8 +1347,15 @@ static void process_rpc_calls(struct era *era)
 	spin_unlock(&era->rpc_lock);
 
 	list_for_each_entry_safe(rpc, tmp, &calls, list) {
-		rpc->result = rpc->fn0 ? rpc->fn0(era->md) : rpc->fn1(era->md, rpc->arg);
-		need_commit = true;
+		if (rpc->fn_era)
+			rpc->result = rpc->fn_era(era);
+		else if (rpc->fn0)
+			rpc->result = rpc->fn0(era->md);
+		else
+			rpc->result = rpc->fn1(era->md, rpc->arg);
+
+		if (!rpc->no_commit)
+			need_commit = true;
 	}
 
 	if (need_commit) {
@@ -1365,8 +1381,10 @@ static void do_work(struct work_struct *ws)
 {
 	struct era *era = container_of(ws, struct era, worker);
 
-	kick_off_digest(era);
-	process_old_eras(era);
+	if (era->activated) {
+		kick_off_digest(era);
+		process_old_eras(era);
+	}
 	process_deferred_bios(era);
 	process_rpc_calls(era);
 }
@@ -1400,22 +1418,7 @@ static int perform_rpc(struct era *era, struct rpc *rpc)
 
 static int in_worker0(struct era *era, int (*fn)(struct era_metadata *md))
 {
-	struct rpc rpc;
-
-	rpc.fn0 = fn;
-	rpc.fn1 = NULL;
-
-	return perform_rpc(era, &rpc);
-}
-
-static int in_worker1(struct era *era,
-		      int (*fn)(struct era_metadata *md, void *ref), void *arg)
-{
-	struct rpc rpc;
-
-	rpc.fn0 = NULL;
-	rpc.fn1 = fn;
-	rpc.arg = arg;
+	struct rpc rpc = { .fn0 = fn };
 
 	return perform_rpc(era, &rpc);
 }
@@ -1596,6 +1599,10 @@ static void era_postsuspend(struct dm_target *ti)
 	int r;
 	struct era *era = ti->private;
 
+	/* Never resumed, so our view of the metadata may be stale. */
+	if (!era->activated)
+		return;
+
 	r = in_worker0(era, metadata_era_archive);
 	if (r) {
 		DMERR("%s: couldn't archive current era", __func__);
@@ -1611,30 +1618,64 @@ static void era_postsuspend(struct dm_target *ti)
 	}
 }
 
-static int era_preresume(struct dm_target *ti)
+/*
+ * The metadata was opened by the constructor, but if this table replaces
+ * another one then that table kept changing the metadata until it was
+ * suspended.  So read it again now that we are the only user.
+ *
+ * Runs in the worker, and commits by itself so that nothing is written if
+ * the metadata can't be read.
+ */
+static int era_activate(struct era *era)
 {
 	int r;
-	struct era *era = ti->private;
+	struct era_metadata *md;
 	dm_block_t new_size = calc_nr_blocks(era);
 
-	if (era->nr_blocks != new_size) {
-		r = metadata_resize(era->md, &new_size);
-		if (r) {
-			DMERR("%s: metadata_resize failed", __func__);
-			return r;
-		}
+	md = metadata_open(era->metadata_dev->bdev, era->sectors_per_block,
+			   false);
+	if (IS_ERR(md)) {
+		DMERR("%s: couldn't reopen metadata", __func__);
+		return PTR_ERR(md);
+	}
 
-		r = metadata_commit(era->md);
-		if (r) {
-			DMERR("%s: metadata_commit failed", __func__);
-			return r;
-		}
+	metadata_close(era->md);
+	era->md = md;
+	memset(&era->digest, 0, sizeof(era->digest));
+
+	r = metadata_resize(md, &new_size);
+	if (r) {
+		DMERR("%s: metadata_resize failed", __func__);
+		return r;
+	}
 
-		era->nr_blocks = new_size;
+	r = metadata_commit(md);
+	if (r) {
+		DMERR("%s: metadata_commit failed", __func__);
+		return r;
 	}
 
+	era->nr_blocks = new_size;
+	WRITE_ONCE(era->activated, true);
+
+	return 0;
+}
+
+static int era_preresume(struct dm_target *ti)
+{
+	int r;
+	struct era *era = ti->private;
+
 	start_worker(era);
 
+	if (!era->activated) {
+		struct rpc rpc = { .fn_era = era_activate, .no_commit = true };
+
+		r = perform_rpc(era, &rpc);
+		if (r)
+			return r;
+	}
+
 	r = in_worker0(era, metadata_era_rollover);
 	if (r) {
 		DMERR("%s: metadata_era_rollover failed", __func__);
@@ -1658,10 +1699,16 @@ static void era_status(struct dm_target *ti, status_type_t type,
 	ssize_t sz = 0;
 	struct metadata_stats stats;
 	char buf[BDEVNAME_SIZE];
+	struct rpc rpc = { .fn1 = metadata_get_stats, .arg = &stats };
 
 	switch (type) {
 	case STATUSTYPE_INFO:
-		r = in_worker1(era, metadata_get_stats, &stats);
+		/*
+		 * Before the first resume our view of the metadata may be
+		 * stale and must not be written.
+		 */
+		rpc.no_commit = !READ_ONCE(era->activated);
+		r = perform_rpc(era, &rpc);
 		if (r)
 			goto err;
 

base-commit: ebb7a8dc1e74c705daffe11c2faf38ec2628f838
-- 
2.56.0

