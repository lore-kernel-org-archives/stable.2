Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207913;
	b=EK99/ZWt+RSUVAiG3ep+2Rpx+8nVTaqDeUwAY9i2Yw8h80ff8BMjed6RoziFShufPHWY
	 EIhOL0/NYsIeF+yzg2mzB3D5lbhfxKdkswsb3VSJ2dK5ov2zbye+Oc5qZSJuf9h8y+tYK
	 kuVLmHEdc/NybIuauSzG9jCbMjI4ZGw9xW8IlT/BQP9FPd9PF2qnsOv/dCwgw0RY6SgXz
	 5G68iRPTDluf6zRByRTiLN45AaTzTqpNoalt549Ch355t7pZPltAcBosgj70Szn/kEsuw
	 0jiNrn6ZY9CKpRJYY66m1dJcEusORWvPXPMmZJh2a/vlmcwU6pGaSrM/oefUVK1Gkfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ni8+5UxvC9X/M4BOYv/FYGIjJasL4So4SmYdwNZ/JRI=;
	b=PxHsxdRPcU7aIqvGFHId3s7x556z/Gmjwxx5v6rYBoh2dNioE5vzBOqpY+BLt6k2HxT1
	 61kmqJNaq6d3BwvmdyVtgpyUMyYroJsssW59wRNcXe5hqPptAUpLU3cRY/OVeO99TiRFU
	 aMz1fedpq2iFys1LcookRAB7ZflXRnQEtFB2nfK8igXKQA05euJjRQeUh/ghsIdpSOyuX
	 0pQgRJU+UnxXu/XXEoxgDW7D8rQvWf56ANcHZIWAfTy3PXoyssIPlHSTfncojmoyJiH5N
	 aaAFD/VdSbh3bRGpbJh7etAyjOpERwTOkxIUr6yc81Gu25VkZttFz+AaBX/WY5FbKpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="HBxx+v/d";
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5EE606A6A7
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB5EE606A6A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=HBxx+v/d
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53644b28706so21483151cf.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1795207911; x=1795812711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ni8+5UxvC9X/M4BOYv/FYGIjJasL4So4SmYdwNZ/JRI=;
        b=HBxx+v/dmjfecYpxmXpSBaIq6OCABUJOGp1j7QzoiVYlRShmZBU31psS1SNDLBUJx6
         FVeY4YOBxaHqvBABCghue3hOC5aIfL9JuzV9yIZrHoytlB/LdDprVbbMNALjWToYYzpN
         wOOfojoQZ3I1emKVH53hI+7X3ruUnsaD58sePAYD5W8rlv3PF99R/qjxg8jWVgTWhTCd
         mFCZRblolstQrvIr43qlnXMJIeLhaBGQJN8X+YYh90j+5i/gXZ39LQddQqdS2c5hqGav
         IDf3Mfmy8UcNZdBd/+N5HHU9gaBawN9w+8+1iycxTrcC5JSAG/96CF2EXCUUNx/l7Jqv
         ZX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207911; x=1795812711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ni8+5UxvC9X/M4BOYv/FYGIjJasL4So4SmYdwNZ/JRI=;
        b=R/ombk4HH+F0cgMGPs3+Bit8qxUc8rjv7Gv2ngSep/UuFMJbDuoVPsg2qz/RBYDxDK
         IaYIIrY9ypDmlI8JfoRZordqnpUUstQbxFXNGo6hDBce0a4yW7QNqSSDCn/TsDbHGDDI
         HMGfQ0kNKDkYdRwIv4u9vDfWNitu4xb4FFLf1k5offm/0sbNya/IWjwap2PUhvi7MW0C
         OtkwjI2p+/BmHQArOBwgiKy0JTjX6Qa7/07Lo6zkYTQLLmz0UpgDPNx7NOgf9+G0hkrc
         gpaJgBgY/xxKcv6LJ1bCTuESTCcpPUZpSgEgOLK1eIi1c/ZVsat0oO/KH6xaNGqGd19F
         /4IA==
X-Forwarded-Encrypted: i=1; AL+hErHXLFoKloerTG7VxM44bWzPBpQTM/SW5YVlsuPlR9dfM2DJlSiKVUxgyCulXrKw/9RqN6ncIqg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SIZl75nstV6zgWn9psTdm5IEHtRYao3cqiwmfNwMPCBhpWly0
	GS+ApVg/F1y/wdQYb8BdXYTo+9OaPnm49dfK1FwvWQC7dpfJ3OEgId3OUunaOShtme4=
X-Gm-Gg: AYBFou3dLvB/9uX/yPa1UoEnt90iV2383OJKBxSWFOcHrtDjASOjWZnBgIO+DTIo/nT
	69Z5mCBZPB2ihctP+Rybt/vY9dQb5mPZ/tpuK3uHMLkPZHos0vnMFVSzDiJiGL9bWprMK6qrz6E
	kMhoiycAHOaQ4rof1lN7KIEM/N3bHf0t1dWKzGYT5ZB35J8oZSuDu0j/UIYfS0iW9pRpEWEicaU
	l9uq8o9810r8YIzOaSN/WBwISxlNyhPZKmqDKG++UXceXZTlYG6hnEkfSWNEZz/69tabOVGZgqB
	n/Xj2JfPkXs2YBEpNuAKXjYXi8vMMgjQ/uDG3AF5CW+mjftSto0rUCHaYO2/yJuCOF5S+0uX4y/
	qZ40UIR7hjBgfn2e096qbRm5rYx6X5dclEqmPMzkBPUOBbSy67Ss7pXqOuTRJN0w8b52JxQOm5K
	9CDFuQqgt93lUeVJoIs7iX3WUfgygC7hq7Il5vBjO5lFGFUWDNbkpCDunHGC8BG9mrS2rm49wzd
	V1TasZvz9JgAqGjDEW9Y3uBNnA3ZgMpswnkQy9HrEaxU/DOCtXIlTTsDeAiLdwoHsp4KGn/Gn0F
	QQlfMBPMFtUGXB/fSiRjOS1PXNdqL5tHgvSAjVHLNE0qHg==
X-Received: by 2002:ac8:5d89:0:b0:55c:5ebd:881e with SMTP id d75a77b69052e-55d769ea3b0mr80154591cf.21.1795207911065;
        Fri, 20 Nov 2026 12:51:51 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78880604sm32574651cf.24.2026.11.20.12.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:51:50 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 20 Nov 2026 20:51:33 +0000
Subject: [PATCH v3 5/6] btrfs: don't report success for a skipped log sync
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
Message-Id: <20261120-b4-btrfs-data-integrity-v3-5-4de4b91b826e@toxicpanda.com>
References: <20261120-b4-btrfs-data-integrity-v3-0-4de4b91b826e@toxicpanda.com>
In-Reply-To: <20261120-b4-btrfs-data-integrity-v3-0-4de4b91b826e@toxicpanda.com>
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
 Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1795207902; l=3593;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=yT+M8OK+YU0CxQ2FYx6ZFQUt7h6OwSb2I7+b5apjQ9s=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHYbR8k2XZUGA7a9b9eWl1aRjryferBqfBcHIaHGpXFVcQxzOQF4jaVHlUM7zBn8U0NfptqCoHl
 WfR2fUvU6LA4=
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
index e50f924bca59..e15b26f9b920 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3439,11 +3439,20 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
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
@@ -3577,6 +3586,13 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
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

