Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48B1A38F9
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787100032; cv=none; b=Q4mqN1Bucmy447/T4TjkI6TsnkK/YqXzEJJYqg4y98viqmd1DRUFOxlw0YzPVNSjNEDozeHX8WMGVIIq2MgRFsOIPdsvoVFMDOk4SE3fbT1RPV8yLFTI1b/9vdHfvmyR7pDYzGuqcJPWAOIZKZi1GJuNEWfsOkcszM+lpwL+H2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787100032; c=relaxed/simple;
	bh=XDrZLBuOInroCq7eBP8MpsrFsdRb91W6vX6r83xVdLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJ08IobTkLzRWiOCjCGRuU3GZ87jcLnNrfxXTmnQhXVMJvpWSLc9ZPrmoTK6AUC1uLsKlHZjqflYOOFMpRigGNdQo1EWyDXj8xkE3ufn7vuvDAgLBlbKGYsM2S+n697J3m5F9nukwDuKIr/UkFp9bn0rGSWo5Y4uc8ohTdHVC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFKzhMEA; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFKzhMEA"
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-7e9f37a2160so132221a34.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787100026; x=1787704826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/7H02fS9J+kIylLg1nNS7BqX5LaXGZpwW+oYL3M+hxY=;
        b=UFKzhMEAsnCB8GQoRu1FqMJmXl5Ozok1JiVlDNRpiL70dyirUasC6/fbT3DclwBr83
         7SM0TvZKDzONXAxw5ncixXjxJPTcOyBNEy70n/tA2lvYyI7o9VLCoK0SWUgRRHQu6FDB
         MhrTRtG5YwJZ9cx3wl3en8SXlBAw+zeGmsspvWJkLcT0LMW9bc8cQjVxyNdG/++qiaeu
         hJnMHMM3zVV8vW6w8xa6dLwk6+Zx+4/Pzq2n5G9tN9oRiIcQGrmYWd5AHMQU7w3+T9VK
         WSF2JUdO9qQj93Lcm5d5nFbzGDB1FRz0Jn5zS1Mqn9lZ0I8vOPAEmacWBOP6yfNolXsV
         L30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787100026; x=1787704826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/7H02fS9J+kIylLg1nNS7BqX5LaXGZpwW+oYL3M+hxY=;
        b=QlPXuFjR1IzVH8cOSkZc/WZD2z/VVBvECmiWxMeNbvKGmcc6puonsresXx3j6hk11v
         YE7q/jRby4HbcesTa4CnH4EWVna5KI7XoepZLF+dHXSdGCWHoZX4kd7FD1rWFLOCqvUV
         4cHT1mVtN4DQKgV7EPVZAUkDL2LJUcI8uBO9tkdV5V3qQGQABqYy/hkZRzMhfljUnjm5
         +LdjwgnGpJ3L28yWLMf8ElIDfMv8VaOlB4zDCPfDmrDFt5QPfoOOU+YewEq63NJZt6EK
         CZHjn73FMLrANw9qAs0ltEohqIylaOX9GrCPeUz1QYKzhdC/bASHr/RDNXl8t8N0bRJX
         0KPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrpDzwCog/pA9PbJepZ6GkOs/DqKGjjtpH4jMEms1xEvMbCq+5P5XTSXvh2eeuZyJGmU9u25TA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fnRtt8AaE9RvhSzORxQ+TVR9MVh1NGlCdUFygPjiSAI5mOW8
	/1U2TKDkp2u2/oCSDAGn1t7arzDxZu+akJGasyb987LOvoWJLhQL5qr4
X-Gm-Gg: AR+sD10SaVfUJY64ZKXNw66OMkFqHvpjExpFbRSMUB3F9ZjE/suz3gjK66aQ4L8YL+d
	wwvGi+KRDU5SObYa+H2UVzcesId66TW+j+IRSqh0dlhE6v5TLmqshKx2IPiOfzV7yY5LM/ZlNJe
	52/1ymZ2tUmUJsnVoFQQecLVpgHBEJUz2pvSGe4XUtWfPofr3uMP4noqJeZMvhulei1lTFLKZdI
	F6+47G7jKp/Nfm8ZS06gZiBxxlgKEalRY3gtJWCSFqD6LMqiEUNKJ62dkiyFfX3HtnEnlkgPwox
	Fl+BkzLWZHCPK8649grg2jHYxzc2O88jdRlYvaWC7aDYf/7tcVzoC4Ze8uYqF4j3+iFZosO2CO/
	jcl/jFBd6IBY907amO/EPziU0o0tZjWSSKePotbY8Hwu4753yMlYLSuLzz65C8TXodbrN6flZoB
	Y9QV1dH+BDCwX1e2RYRj+XKnM3PBQbIVwXvjoghBJYP5056ihqv/FJeNzfTWwC19n8OQ==
X-Received: by 2002:a05:6820:a290:10b0:6b1:377b:8b7e with SMTP id 006d021491bc7-6b13c5a2694mr876380eaf.23.1787100026298;
        Tue, 18 Aug 2026 17:40:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f44009007csm172493a34.26.2026.08.18.17.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 17:40:25 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <wqu@suse.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: abort transaction before releasing tree_log_mutex on commit failure
Date: Tue, 18 Aug 2026 17:40:10 -0700
Message-ID: <698c480ec13cd6e74c2175924f614b7e324e6cc3.1787099421.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When transaction metadata writeout fails in btrfs_commit_transaction(),
the current code only logs the error, drops tree_log_mutex and then goes
through cleanup_transaction(), which aborts the transaction and records
the fs error.

That is too late for the tree log side. A log sync can already be
waiting on tree_log_mutex, because the committing transaction is moved
to TRANS_STATE_UNBLOCKED while that mutex is held, which lets fsyncs
join the next transaction and queue up in btrfs_sync_log(). Once the
failed commit drops tree_log_mutex, such a log sync acquires it, sees
BTRFS_FS_ERROR() still clear, and writes super_for_commit. That
superblock holds the roots prepared for the transaction that has just
failed to write out its metadata, so it can point at tree blocks that
never reached the disk, and the next mount fails with a parent transid
mismatch.

Commit 165ea85f1483 ("btrfs: do not write supers if we have an fs
error") fixed this class of problem by making btrfs_sync_log() check for
an fs error right after taking tree_log_mutex. That check only works if
the commit path publishes the fs error before it releases the same
mutex, and commit 68d4ece9c30e ("btrfs: don't call
btrfs_handle_fs_error() in btrfs_commit_transaction()") removed the only
thing that did so.

Restore the ordering by aborting the transaction while tree_log_mutex is
still held. We have a transaction handle here, so this does not need to
bring back the btrfs_handle_fs_error() call: __btrfs_abort_transaction()
records the fs error itself, which is all btrfs_sync_log() looks at, and
the error message put in its place is kept.

This is what commit 3810ab40afa5 ("btrfs: abort transaction on error in
write_all_supers()") already does for the next call in this function.

This is reproducible on an unmodified kernel by failing the first
couple of bios of a transaction commit with fail_make_request while a
concurrent fsync workload keeps log syncs queued on tree_log_mutex.

Fixes: 68d4ece9c30e ("btrfs: don't call btrfs_handle_fs_error() in btrfs_commit_transaction()")
Cc: stable@vger.kernel.org # 7.0+
Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/transaction.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 13a7e5f4e08c..ed850bf0546a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2583,6 +2583,12 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	ret = btrfs_write_and_wait_transaction(trans);
 	if (unlikely(ret)) {
 		btrfs_err(fs_info, "error while writing out transaction: %pe", ERR_PTR(ret));
+		/*
+		 * Abort before releasing tree_log_mutex, so a log sync waiting
+		 * on it sees the fs error and skips writing super_for_commit
+		 * for this failed transaction. See btrfs_sync_log().
+		 */
+		btrfs_abort_transaction(trans, ret);
 		mutex_unlock(&fs_info->tree_log_mutex);
 		goto scrub_continue;
 	}
-- 
2.53.0-Meta

