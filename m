Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DBC3C13E3
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180135; cv=none; b=b1yZKFCyZe+DZA5Xi955Q4lnw7632ZnObA/48SeEzQJeOxAVUk+ybAIZaPc02bk9b76iBCLV4KQjvjHCwRvqXdcuODEYqPrloGj3N97aWGS+oJVRD5SOG1R+CF+3mOmd19LT9yixp9ujJoBpyh3Aevd1YD0W1xbNXkUoePw0glg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180135; c=relaxed/simple;
	bh=5IfqO8Gq7e5o6maQ8zbJD4CT6zM0iRmPq2wnL7tMfz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYIC5mFfFe1Hj3RKspjcR9iL4CYUUdaJQ/QML/HdGnGAf9//TSoF9T0Z3YU5y3rMBS2YwPtPgfWHSZSyK7IjSDxl77UglYoaOAxOWW3j7CNArGSY5BasYRs87uqhqmsCsPBZfNUhIHrnDOfp76WY41jxgA9VWS6amL+u57r8KEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re6O6UZi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re6O6UZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CF41F000E9;
	Mon, 27 Jul 2026 19:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785180133;
	bh=ITzG86dMFDPzvO39dp9ZqQ5FYnmkYa3kSiP6OpsWmJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Re6O6UZisSFqbePQuymq8h/RH1j72F4FyOCd5VA73ZRbLqYz2AKS2MWomqR7pdiNf
	 4LJnGgtgLD6jqEAmks3ZWnkbKfjn/GSsrtNI1JvDjbwedJm+UgQkiSATYw37n1VRed
	 xjElL9T7O/5iv9HKHQCV9pfDFeIpjRqqpn7x5ukkTLQ01OY4JXtZ343z3jsoY7O2Y1
	 gGXp7QXqdx5wIxQLMSYsFfCR31E5A8JStouTS8DtKgL9/uN6198F1kYaSdmpqgLYGu
	 mwaBMo7SiwPRPwIFnO2DZ4ba7fBNxCQsWjTqietYrxDwzbaDqfaNs2D8KdV3G1I0rN
	 26XeaHQZFfJ3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dm-verity: make error counter atomic
Date: Mon, 27 Jul 2026 15:22:11 -0400
Message-ID: <20260727192211.1722315-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072047-swipe-subsidize-5d17@gregkh>
References: <2026072047-swipe-subsidize-5d17@gregkh>
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
index 6ae5886566d910..087f49518417c1 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -227,14 +227,16 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
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
@@ -250,7 +252,7 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	DMERR_LIMIT("%s: %s block %llu is corrupted", v->data_dev->name,
 		    type_str, block);
 
-	if (v->corrupted_errs == DM_VERITY_MAX_CORRUPTED_ERRS) {
+	if (ce + 1 == DM_VERITY_MAX_CORRUPTED_ERRS) {
 		DMERR("%s: reached maximum errors", v->data_dev->name);
 		dm_audit_log_target(DM_MSG_PREFIX, "max-corrupted-errors", v->ti, 0);
 	}
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

