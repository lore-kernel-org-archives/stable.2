Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDFA25A2BB
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560805; cv=none; b=HwZCWEvlnWN8dUgbLqjY3aXmfXrx4JCLiEhiLoFMBDcoalHFx2tbklmUg5HuTtvMmkuL8WtTCB0V18Swfkkmh44wll4FVesBLEhjEK8kT+MImLdDHs4b1pEdPD4zptPaHReRHNVPJAow52fQhzViyh2k9Vp5g0oc0mCguAOEwHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560805; c=relaxed/simple;
	bh=u55tjI4cn5C4u6gisnl+omuWo3DcIYuWfy0ZLbSmYCU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MEKWmckZMD3zTqRtYHCcxzCYHS+JqvC2kWS277aupSJ/J8YkxTfTmm9L8mEijXib9BGVruqcIQm/sjmKosoGpKz8kr9cifCg6oAnTFxCnofXV1+7DqoRmNMUo9JVGbzvn41iBksFqYGRfJ+TwCdypgUCtjQFbvD1b2Lhb5YOrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R8eHIXUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R8eHIXUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5861F000E9;
	Mon, 20 Jul 2026 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560804;
	bh=LYWGoh6SCH/7GhpGs8FUYX5uJ49dMiSjvrtUY5n1wh0=;
	h=Subject:To:Cc:From:Date;
	b=R8eHIXUJK3Ry3uMI+qWjtemUICAo/X3X80bPwvHha8g3yZzfRU4mFY+oKW+X3Yq8d
	 y0dCA11emaQL/iytGQ5JGfZ4izzuKkF3pqruszoPREjMGq6jyF/3CG3DsKl6buoD5i
	 boxr/zMYIPrukpHKo1kVTy1uMsIm+jAVeFjiH7qc=
Subject: FAILED: patch "[PATCH] dm-verity: make error counter atomic" failed to apply to 6.1-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:19:47 +0200
Message-ID: <2026072047-volatile-gonad-565a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8ec4d9c5a5cf4b61fc087f871465b1f79b393325
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072047-volatile-gonad-565a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ec4d9c5a5cf4b61fc087f871465b1f79b393325 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 9 Jul 2026 21:37:38 +0200
Subject: [PATCH] dm-verity: make error counter atomic

The error counter "v->corrupted_errs" was not atomic, thus it could be
subject to race conditions. The call to
dm_audit_log_target("max-corrupted-errors") may be skipped due to the
races.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-4.6
Fixes: 65ff5b7ddf05 ("dm verity: add error handling modes for corrupted blocks")
Cc: stable@vger.kernel.org

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index e63a8290bd3a..1b0763091254 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -180,14 +180,16 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
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
@@ -203,7 +205,7 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	DMERR_LIMIT("%s: %s block %llu is corrupted", v->data_dev->name,
 		    type_str, block);
 
-	if (v->corrupted_errs == DM_VERITY_MAX_CORRUPTED_ERRS) {
+	if (ce + 1 == DM_VERITY_MAX_CORRUPTED_ERRS) {
 		DMERR("%s: reached maximum errors", v->data_dev->name);
 		dm_audit_log_target(DM_MSG_PREFIX, "max-corrupted-errors", v->ti, 0);
 	}
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 2922263501f6..e104a651c657 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -68,7 +68,7 @@ struct dm_verity {
 	unsigned int digest_size;	/* digest size for the current hash algorithm */
 	enum verity_mode mode;	/* mode for handling verification errors */
 	enum verity_mode error_mode;/* mode for handling I/O errors */
-	unsigned int corrupted_errs;/* Number of errors for corrupted blocks */
+	atomic_t corrupted_errs;/* Number of errors for corrupted blocks */
 
 	struct workqueue_struct *verify_wq;
 

