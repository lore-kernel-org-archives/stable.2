Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831C3D3D12
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186018; cv=none; b=nQyTk93RMTpG6tXXGA6hUEvPEx/Gt+01VOUl/jNJKDEYbjQ88s3feQtUygZhJx0rMqk/I5DfQHF+kW2xH2urELdZXPu2d21E6h4Jrnm2siWBGDGcGpoJVUBZGhHB6RgAiyjI+q8E9+2Kh9hgIXjEc2AgSgZcTxJh+FENHBjFZak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186018; c=relaxed/simple;
	bh=+xeqUHvni0jJppV3pBBqE+UKuSuIR2mHnHetNJb7+sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcHthRSjMhh7ILul8/1mgNNVQLlH9R47VpLoq0v1tX9qJsI5HAYqL1KVSsT6XZptk04L3h3T1sVR8mAvi02Psau9ZL04vfKnHgZMDPEsiWg/++i37C7paCv8qa6ZuCD4YNzBjA9z2VaoMLuLcu3AS3BDz9KDigFuS7z8sND5vbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=desRQqkU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="desRQqkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4E01F000E9;
	Mon, 27 Jul 2026 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785186016;
	bh=i4omISfn3j0Y9UiFAa//JrsTj4VxkMYyxHloZJVtWFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=desRQqkUaVXqwsUU+oCEL7Ziwbt74fzqr07pn7eZZVRFxaQlT1CZqizk19D+j+kD7
	 u1pzzJ7UhBmyQw8I4BKDNjUSzINLuSKnYviFjc2sBtK+RzybjRLKC6q0cOlK0e3WEM
	 a3mKgl4urOd7p1yuy2EAGoFeAXYHvFVnafUCcY7tS0/SnlrKB3Em/LnKHg9rgw2XAT
	 /CcM5d6XKY45n4Jh6N0h4O0q9tipV8X/MChBAb5sOFhU1uRAQFoLEneRXVuCehe2LS
	 qgRbeEGtdfx4S4sojhT5r49uA/vY0VypODzEDx7jhB+pQquqKXD8Y3bcYkV5BAEEKH
	 2YivduCYJmPcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] dm-verity: make error counter atomic
Date: Mon, 27 Jul 2026 17:00:14 -0400
Message-ID: <20260727210014.1929718-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072047-volatile-gonad-565a@gregkh>
References: <2026072047-volatile-gonad-565a@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-target.c | 12 +++++++-----
 drivers/md/dm-verity.h        |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 53150024d2dd4e..ed3914b479cfc5 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -224,14 +224,16 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	char *envp[] = { verity_env, NULL };
 	const char *type_str = "";
 	struct mapped_device *md = dm_table_get_md(v->ti->table);
+	int ce;
 
 	/* Corruption should be visible in device status in all modes */
 	v->hash_failed = true;
 
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
@@ -247,7 +249,7 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	DMERR_LIMIT("%s: %s block %llu is corrupted", v->data_dev->name,
 		    type_str, block);
 
-	if (v->corrupted_errs == DM_VERITY_MAX_CORRUPTED_ERRS)
+	if (ce + 1 == DM_VERITY_MAX_CORRUPTED_ERRS)
 		DMERR("%s: reached maximum errors", v->data_dev->name);
 
 	snprintf(verity_env, DM_VERITY_ENV_LENGTH, "%s=%d,%llu",
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index db93a91169d5e6..325942fc8f8038 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -58,7 +58,7 @@ struct dm_verity {
 	unsigned int digest_size;	/* digest size for the current hash algorithm */
 	unsigned int ahash_reqsize;/* the size of temporary space for crypto */
 	enum verity_mode mode;	/* mode for handling verification errors */
-	unsigned int corrupted_errs;/* Number of errors for corrupted blocks */
+	atomic_t corrupted_errs;/* Number of errors for corrupted blocks */
 
 	struct workqueue_struct *verify_wq;
 
-- 
2.53.0

