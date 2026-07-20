Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6EB27380A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560808; cv=none; b=X00r0ZRrjjjg7VmxbJiCyNmxIGiv2tPlnojUZo7Cyczpfuw9WjfuQ62eNa9p/hxGUpz5nCqoj+l9YCUGuw5HwGO4eJOy4tk4BxXFwfTPeZBKAxo54UfkrcgnM559058ynjm0r0sm8qJ6vjpxMhLEB4a/vJj5c3Qha9IWRZsqWV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560808; c=relaxed/simple;
	bh=Lk+3d6zqzQJsOlMQMsCUDpZyeE1ekqFitBVjZd/QVcA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ASYqrV6Pv9ktM8AcJrXDbRWF7IgIiijgCd1hdJumalP1hEPb3xAcKZd2YSX11NaL0ayRQu0Th/UF47RZVdipQLYoyn8P5Ng3U3AUTNBT3RHAdaukoLpMDBVXWOQpmknJYpc0df+JdRJk0nxGquFV6Mx2NyyHYwW8ixG8VCEtQg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DpoI9bjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DpoI9bjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9591F000E9;
	Mon, 20 Jul 2026 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560807;
	bh=OOCreKzKURDPCYJmHl5x+pF1C64wFUSeMqSy6HoL0xk=;
	h=Subject:To:Cc:From:Date;
	b=DpoI9bjPWWdHym8PDO7OZKnvg5i+2dUgXJBX1eINCM/JVMFmYaiY3TAoKb8yHC3Zj
	 F9NaUC0tWQv1cfS4vWb6rEzEOIXrVAgU6DsNHme8Yomi5V1rKIG9JuEgDTU0kPijKs
	 6rgwRgXDF1ukvKc3vKDcir9PM8r+XN987LdtnXIE=
Subject: FAILED: patch "[PATCH] dm-verity: make error counter atomic" failed to apply to 5.10-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:19:48 +0200
Message-ID: <2026072048-same-empathy-c4b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8ec4d9c5a5cf4b61fc087f871465b1f79b393325
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072048-same-empathy-c4b3@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

