Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB9223D7DC
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200300; cv=none; b=l5oqGtdO1BTiZZJY4V6y/XVkPtfBsjYVa4zJqPAwjDLWFbCj8skA4BZnGCdX8VVPjI/E/dZXnkCLNfH8HWdvvYF694Z9rZrMPtnoFuJH0EWpSM2ZO+Murm+kZJrIGAJzUFJLEXlPkTq9ryEcwlTgmMMo1dMXUz2pGDmdqRw6Y/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200300; c=relaxed/simple;
	bh=+Dt1FdYtXP+dLnfRxp2Wh6f7uRA+Y2LiFr+gX218YaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3cgaiob1NdlGqT0gVkAXYOTJV23ZR21GEJjd+nJGda3UCjgz5NJRcc1Fuzn7d4lKnzLajn2L4axQZzNgLqwPPvUIc8LiEXsoGLvQxPURGa9XJyy+gw3U0GNznUoI5b1QMgbPjy2jalWidu5hpT5AH6jxxn0WHblVaUx13pM278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2TdDwqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2TdDwqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D571F00A3E;
	Tue, 28 Jul 2026 00:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200294;
	bh=BVUlsUo3Tqnw+CBO+Iblx3nzs3zc2WWoUphNT9GmNv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W2TdDwqNyDdIBUBWYQk11Wc3Mqb8pKgTpaCxLsWOqOaN0MTNlVOn8WhZwNmyUdMSy
	 en/eg+pa8HudYs9Zej6ZKyiBt6CXG9hYDZadrM7y1ejfQ7yMwCtNYEriy9L4YpmEn4
	 khAGYn+m1f0cusCkUfI8OVKmv4dYY5iwbALWrTLpmdK06jfBeO8EPUtgmoQJgaFQJE
	 MSvxi9niy31PA/Yt0i0T5TWoYXdBuITJ9ibVJInyLDXznp7d0y3G4w7n/9XifktdaQ
	 zM0l9RUfHtcVN4PreAczgKOIPiIlMmC6RdCR4uXSMRvv6/CRN5Vj1NrdP3hcVO2Qf2
	 5MBhNNd1L/Oxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dm-verity: make error counter atomic
Date: Mon, 27 Jul 2026 20:58:10 -0400
Message-ID: <20260728005810.2696057-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072048-same-empathy-c4b3@gregkh>
References: <2026072048-same-empathy-c4b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 8ec4d9c5a5cf4b61fc087f871465b1f79b393325 ]

The error counter "v->corrupted_errs" was not atomic, thus it could be
subject to race conditions. The call to
dm_audit_log_target("max-corrupted-errors") may be skipped due to the
races.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-4.6
Fixes: 65ff5b7ddf05 ("dm verity: add error handling modes for corrupted blocks")
Cc: stable@vger.kernel.org
[ kept 5.15's braceless single-statement DMERR body instead of upstream's braced block containing the absent dm_audit_log_target() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-target.c | 12 +++++++-----
 drivers/md/dm-verity.h        |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 21ef7168cc0b04..926a8c990163b3 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -217,14 +217,16 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	char *envp[] = { verity_env, NULL };
 	const char *type_str = "";
 	struct mapped_device *md = dm_table_get_md(v->ti->table);
+	int ce;
 
 	/* Corruption should be visible in device status in all modes */
 	v->hash_failed = 1;
 
-	if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS)
-		goto out;
-
-	v->corrupted_errs++;
+	ce = atomic_read(&v->corrupted_errs);
+	do {
+		if (ce >= DM_VERITY_MAX_CORRUPTED_ERRS)
+			goto out;
+	} while (!atomic_try_cmpxchg(&v->corrupted_errs, &ce, ce + 1));
 
 	switch (type) {
 	case DM_VERITY_BLOCK_TYPE_DATA:
@@ -240,7 +242,7 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	DMERR_LIMIT("%s: %s block %llu is corrupted", v->data_dev->name,
 		    type_str, block);
 
-	if (v->corrupted_errs == DM_VERITY_MAX_CORRUPTED_ERRS)
+	if (ce + 1 == DM_VERITY_MAX_CORRUPTED_ERRS)
 		DMERR("%s: reached maximum errors", v->data_dev->name);
 
 	snprintf(verity_env, DM_VERITY_ENV_LENGTH, "%s=%d,%llu",
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index f61c89c79cf5b9..ad5104daddb54a 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -55,7 +55,7 @@ struct dm_verity {
 	unsigned int ahash_reqsize;/* the size of temporary space for crypto */
 	int hash_failed;	/* set to 1 if hash of any block failed */
 	enum verity_mode mode;	/* mode for handling verification errors */
-	unsigned corrupted_errs;/* Number of errors for corrupted blocks */
+	atomic_t corrupted_errs;/* Number of errors for corrupted blocks */
 
 	struct workqueue_struct *verify_wq;
 
-- 
2.53.0

