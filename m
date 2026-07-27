Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BB345CCE
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195314; cv=none; b=G+i/IGfyldbmxtoJzw1Yr0nzSXzowBFnAeFSBBc3MuDB+6rJqmVmfb21jUCiTAQS1jY4/LvencCojuY0lxNKvL2ZpSLCqjNdKqJT3RfAawh2TOOeveuCWzyO24TaoWApDTGIK2CULybLn3hHsHTQu+WpN5p4VbfxYzF2U7j5Clk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195314; c=relaxed/simple;
	bh=sRpSrV+k28s/rrez3d2Ha6/CfWkcCtEp5QGR+k+4Naw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fghbQVndoby6g6KhvL7aCC/6R1GR6lABTuWBaJwqXBHmCwnKsNW6jyyUs86CxxjGeQvcy9kFH9t0SgNnJxlA3sZfuX8+3MxlwHSMSljKUz7AZafQPfVB7qzPvdVGFOhc0a5ndgI+ve11TbZGTbiHJubEuFIo0ZdXhfL1+PLQRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFPOHVPL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFPOHVPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2C71F000E9;
	Mon, 27 Jul 2026 23:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195312;
	bh=XIaMF5iiO1IsqWiM/7w70/3ZY9votC/ltdKxF6pRXkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WFPOHVPLifv3wpfBeVvt1eEsDFPwhrKvibWYFCRIcX5cV4PLV1V9wZLjmgMyo3JZ4
	 uIjsfDPtXvp801dzh4QR4EPiTSguAm8G9LJwoKNr9gH91wm+ETzorwHSaBq0kWB8fU
	 XYJ9dl98YxpOi27jrqSan0OaE43KaQrYB5mAZYqBaUnH081rI1+GSsQ9TNv4y7PLxr
	 ILJJxIpcHYYNqBV5XAvSIN++YT1Is/WglOdLmdXvfvgALE/1bki5MaPtbURjNLrQwb
	 wV8jMiKjNN2SNbNpuXLzgwqFqMZs5PspVh939rr9Qu3lhb/MY5wzsuw6fCW4EYMNvX
	 OnT5aceqg4dkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm-verity: make error counter atomic
Date: Mon, 27 Jul 2026 19:35:10 -0400
Message-ID: <20260727233510.2427591-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072047-quilt-dinner-8214@gregkh>
References: <2026072047-quilt-dinner-8214@gregkh>
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
index b24a475a660031..d92eae52783090 100644
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

