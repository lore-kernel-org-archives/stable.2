Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718352;
	b=nJdFBv9h9iTaJ7L4jhPOnor4iKyUD/02hm1YsoNzfYftsmtiEwKVJ7/N0oyiij1bxBck
	 uF11R+t9SKIxEpYBWWfaOtrA/7k2+K+6Rds2CMwLFF14LuGEjSDHyszRx0fj4AYiY48HC
	 N04QaZ7INRRdxOo7+Ascb1ZOr8xGDdSpeY4R12CKkyKyuBm/XaZujxHs1/rpdKVkt96oq
	 qLCz2HR0PEVqX6rluG/nUeGbTC3q82Tyvyw7EaZb6jiK6DMM9/lPXSjKNQUO/4rJIkSuH
	 i3t4J4bfl4qhl6qYt935vBkbHUaUEJo6vzcHc1Dip4w9zFApjrDH4RAZsM7XD0gnP0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=lAa/3aJjQPYp1qwn90DpoaP/PT6OS4IOMITQs9V5xd0=;
	b=x9z4CJ1NBiHN+fwIGW9Ob0vOvqSgD9CQ83VWV/+dG+JrSO+2bSwofw3FEgatR1+udMtf
	 zbba6E6bQuEsQiZ77k8GO5C6+EsSrC6LLn5R/C6oniPNs8jYuxOO4RXMoIe0JyybPyCDf
	 s063C0QRkyrB7GnmZ1qCBhbw5Bnf773AHWzMkCDMyVZF/64oQGpgIAiboZSW/WLN4w2Zl
	 baS9BWOL/2idJH/LPRkxk75jTZIB63GPXYnQW6cu8G9ag00AlyLWUAGW9D6aZqpGqaEPb
	 iF58Ke7iauzd1koHM0I6bcgaMozR2Aa++wMH/IpvaJk+9kLlr10i76HMKcJZds1jeYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=NBNXcPHR;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE76C606D826
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE76C606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=NBNXcPHR
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9905d61449cso1135756241.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 07:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793718351; x=1794323151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lAa/3aJjQPYp1qwn90DpoaP/PT6OS4IOMITQs9V5xd0=;
        b=NBNXcPHRVhfotKqrLNY+IG8lG5uIbvofkj0aI9bAqJCBAHo/LGAftaMqZeCpS66ecz
         gcFdDkkekpZb0uHt5rVYeuZvVJnDh3LYzf/O9UZAe/VinE3LvbwTodsOQOgIp01ityQQ
         PyX/HAB+BH6NsqogkcGiT96k8BCovOJbsXCRovxXl5B1yLiZ/GlWzSaL15faBygv6sU+
         In4p9RwatKeYLmgPY+5BWeZ19dykPmN190m0xPgwlgisWD1v3Fh2D1xO7bR3mhU/TD73
         bKdkDrSL18p12J0TbUUuprXMRiJ3hn4mt7c/30eORkiCzgbdKdJN6wfpQidKLB5iYFgP
         6CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718351; x=1794323151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lAa/3aJjQPYp1qwn90DpoaP/PT6OS4IOMITQs9V5xd0=;
        b=0vGCtm4yGLXpzFWaXe47EY93vyMcgO3MRJThKrry3Gm95afpeimmt+UvB4es1xRbRL
         /5ru/S3sOPMYS170JthUNjQNegKcVswGAELQDoSjSpHE3XV/twtu0qGDLp4B3BtPqEMR
         NRiILdwMkukslfw4tyHlmyD8M1lBV1dWUfOgoLrWtZpdiaa1dAQEfP1x4v5fuLpVpfKf
         4IH5MCDmEaEcxvc/0d35fdchHyoZ9N1+UlrDXfhOsDVa/5qjlaXM09LfOHIzZtjtD/TM
         7vtH4OLs5VaGQOQqH+zt4Xs00KYzsfYRQsWrvYerjPVns3Ki8Ezzd8ry9cOe6qlfc9n+
         L61g==
X-Forwarded-Encrypted: i=1; AKwUvBxShJ83VQb7jge7fya47QefFN+yNd+pwtIXxKSxc1B9yAQ7uoQz5+003stpuXltMKW4E/P+6GU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jcVbJJJeWenn9tfho/BYDN7FvD/g6SNnLdSDJLtRkD2Pe/b9T
	PK+DW8cJ4dpkbzXo3gkpE88EOtwT3rgDtyWsv+KiuVVU8BUx4V5IuqTzKjSlUophkmE=
X-Gm-Gg: AYBFou30A4TjtJqv4yZXtsG/nfxVGY081U9dSM1R+sppDt/CEChixdbtwyKI+hRc2n1
	aSXU1xDyzmuZnkK7wxe/SBv5BtOOxBUi7J5iqCwCWHtSjwUn/cU/+qwHOXwFpKJQ/5FEl+RpDYI
	vC4Q3IbTPaRUMeh920eAUsG0TeIQ87X7TuXLvUwQmCCC0ZE0M37b6Z0HfMHTqtyFnbIN0ZETJW1
	krF6YLbt+RHZLQcXNkRZYC5/v72i5+2BDClaNhMa0wRt7vRWFd0wOOOAnI41TZ0E0N9l3enX4zA
	HNk3zTbthIQDOSdaRa6wROHqPMvObEeQDBHBcjwEDgWbjBn5bN1REi8tXe/IK0meP+gAZZH8K8a
	YZES9X43O++1uoE7G3JzVI5I0TtkiGFMRAotXjWFg5K3Z8OQKWvrYpMQbpLd/tjQDYycnBFEcUA
	Fq/ZG6MynS4nuJFuvJXK3clP6ksAYTCSZTRbtU3ejT51p3ARUv1xGDkEaUVYBo2AC17t3fUF2LF
	bGj1EluS6UfC3VPQPE7MRqy0uZgZrG/JHd97WqHsLqLhcIx8//WjFe0BiTQu7WUyiPChpjRgX8M
	Uc5Axq+F8gP6hDLaoP2klQoNr7Oa8dwwa9okbs6uEhGT
X-Received: by 2002:a05:6122:4b8d:b0:5ea:e905:2039 with SMTP id 71dfb90a1353d-5ec6894e113mr5697560e0c.13.1793718350840;
        Tue, 03 Nov 2026 07:05:50 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee437d86sm15203204241.8.2026.11.03.07.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:05:49 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 15:05:19 +0000
Subject: [PATCH v2 4/5] btrfs: don't report success for a skipped log sync
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
Message-Id: <20261103-b4-btrfs-data-integrity-v2-4-577dc2690061@toxicpanda.com>
References: <20261103-b4-btrfs-data-integrity-v2-0-577dc2690061@toxicpanda.com>
In-Reply-To: <20261103-b4-btrfs-data-integrity-v2-0-577dc2690061@toxicpanda.com>
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
 Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793718330; l=3593;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=pb3ZJaSZEuGE2EuaruC+9DgUr6NKGbLn9bdI+79i/3E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNP/iVXQVI4rBjCBBM7l+LEfTdcSroeAQzE1wE6QOTOIxSy311mqKEM+XrtSpfK/0Fm3jHKzS1A
 M5tAKULnvzQY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

When a commit of the log root tree gives up, because the transaction
needs a full commit or writing the log failed, btrfs_sync_log() still
advances log_transid_committed and hands the result to the contexts on
the list. Unlike a successful commit it does not advance log_transid, so
the log transaction it just retired is still the one new syncs join.

A sync that gets to the log root tree after that adds its context to
the emptied list, sees log_transid_committed >= its log_transid and
returns its log_ret, which is still 0:

  fsync A (subvol 1)           rename       fsync B (subvol 2)

                                            btrfs_need_log_full_commit()
                                              -> false
                               btrfs_set_log_full_commit()
  btrfs_need_log_full_commit()
    -> true
  btrfs_remove_all_log_ctxs()
  log_transid_committed = N
  log_transid stays N
                                            log_transid = N, log_ret = 0
                                            log_transid_committed >= N
                                            return 0

btrfs_sync_file() then ends the transaction without committing it, and a
crash before A's transaction commit loses what B was told is durable.
This was reproduced with delays added to btrfs_sync_log().

Fix by advancing log_transid when a commit of the log root tree gives
up, so a later sync joins the next log transaction and either commits it
or gives up itself. The check for an already committed log transaction
can then no longer be true, so warn on debug builds if it is, and force
a full commit.

Fixes: d1433debe7f4 ("Btrfs: just wait or commit our own log sub-transaction")
CC: stable@vger.kernel.org
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1d9dfb63fc5a..3de7757d168d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3437,11 +3437,20 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	if (log_root_tree->log_transid_committed >= root_log_ctx.log_transid) {
+	/*
+	 * A commit of the log root tree moves log_transid on even when it
+	 * gives up, so the log transaction we just joined can't be done.
+	 */
+	if (unlikely(log_root_tree->log_transid_committed >=
+		     root_log_ctx.log_transid)) {
+		DEBUG_WARN("log_transid_committed=%d log_transid=%d",
+			   log_root_tree->log_transid_committed,
+			   root_log_ctx.log_transid);
 		blk_finish_plug(&plug);
 		list_del_init(&root_log_ctx.list);
+		btrfs_wait_tree_log_extents(log, mark);
 		mutex_unlock(&log_root_tree->log_mutex);
-		ret = root_log_ctx.log_ret;
+		ret = BTRFS_LOG_FORCE_COMMIT;
 		trace_btrfs_sync_log_exit(trans, root, ctx, ret);
 		goto out;
 	}
@@ -3575,6 +3584,13 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	mutex_lock(&log_root_tree->log_mutex);
 	btrfs_remove_all_log_ctxs(log_root_tree, index2, ret);
 
+	/*
+	 * If the commit gave up, log_transid still names the log transaction
+	 * we are retiring. Move it on, so that nobody joins a log transaction
+	 * whose result has already been handed out.
+	 */
+	if (log_root_tree->log_transid == root_log_ctx.log_transid)
+		log_root_tree->log_transid++;
 	log_root_tree->log_transid_committed++;
 	log_root_tree->log_commit[index2] = false;
 	mutex_unlock(&log_root_tree->log_mutex);

-- 
2.55.0

