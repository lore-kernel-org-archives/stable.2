Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6603839D6EC;
	Mon, 19 Oct 2026 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414339; cv=none; b=JCIqlvOH3maJNVa2x6R+vUKsuIBNKaP9HgvfBftPe9FpWqdtDOvXhS1LnuG4SDYc5yCb02POxSu+rE4InkHx955UojTY9MyAkqYyYD1YmE3oMXT4ykQiRpHT0n4uxs9t9wBPn9DVDqxYXdSNv+KWTNe0LckXle0MgWRui5vZ1bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414339; c=relaxed/simple;
	bh=UvnW/ptFCVa6iQGyAM0E5xT9G7n7qsnHLg33EU/MtTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nqet4a9CBoaDudyiSKp0Brl4L3sVBxNHZjMKMUVmbuBEJL2L6HMDKtsj3zIIU51WBF7pKSkQFgh51Ia163mUDxf14El7lt20Ml0NSRmktAL3NIOKP90+ZoGRs4KVyUGqTry1Ykb9/1rerq6jQ95zJ+VXJ2RXY13yOjuaSNr+X0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=g4SvlhnW; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="g4SvlhnW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=U/XKh6GM1z/aGHCctk0Rw56ql2dui7YkAPDZ0Gsb3Qg=; b=
	g4SvlhnWYEClp9ivcUM0jIP5DKxNAErNqCeiy0FSCi3oV6rccrH9cv7k+DKj3wjSN3rIF7ey3bTf+
	ZV50wvHpWFThIA0CzBsxeKqXPnbhRqYEIhpTNbkhn7M5vMzgZ3z2OdO1sXtmbZJXWreb/owYT2E4l
	tTR3ya6vZxg/KkS72s+ANQjSWguHZLVJpTUM6a51cfxsRfXKvqy6coc7ocEG32Cxthd1+hODoQ0ZJ
	lsBucpqJmKiFfkZqnJNvvb42WgbA3SgJik1eMO60GI9LIN6G4LKo+YZXdIB64WKBcGNgnDjyMkFEC
	Bc96EO+OZ3WS9SNmHInNso82wIJWQ7S2Gg==;
Received: from bl21-120-122.dsl.telepac.pt ([2.82.120.122] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xImqS-003Tpz-PJ; Mon, 19 Oct 2026 14:52:04 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: luis@igalia.com,
	mszeredi@redhat.com,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	stable@vger.kernel.org
Subject: [PATCH] fuse: fix 'inval_wq' parameter setting during module initialisation
Date: Mon, 19 Oct 2026 13:53:29 +0100
Message-ID: <20261019125329.17932-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the fuse module is loaded with a 'inval_wq' parameter the inval_wq_set()
function will schedule work into dentry_tree_work.  However this worker is
not initialised at this point because fuse_dentry_tree_init() will not have
been executed yet.

This can be fixed by delaying the work scheduling until later if the module
is still being initialised.

While there, also simplify the sched/cancel by using mod_delayed_work()
instead of schedule_delayed_work().  This will result in having the period
being changed immediately instead of waiting for the next reschedule.

Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidate expired dentries")
Cc: stable@vger.kernel.org
Signed-off-by: Luis Henriques <luis@igalia.com>
---
Hi!

My initial approach to fix this was to use DECLARE_DELAYED_WORK() to
initialise the wq statically.  But this would then move the problem to
fuse_dentry_tree_work(), as the worker could still be scheduled before
the module finishes initialisation.

Cheers,
-- 
Luis

 fs/fuse/dir.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e49b4e874b15..23c8259725c9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -43,7 +43,6 @@ unsigned __read_mostly inval_wq;
 static int inval_wq_set(const char *val, const struct kernel_param *kp)
 {
 	unsigned int num;
-	unsigned int old = inval_wq;
 	int ret;
 
 	if (!val)
@@ -62,11 +61,14 @@ static int inval_wq_set(const char *val, const struct kernel_param *kp)
 
 	*((unsigned int *)kp->arg) = num;
 
-	if (num && !old)
-		schedule_delayed_work(&dentry_tree_work,
-				      secs_to_jiffies(num));
-	else if (!num && old)
-		cancel_delayed_work_sync(&dentry_tree_work);
+	/* Only start/stop workqueue if we're past module initialisation */
+	if (!module_is_coming(kp->mod)) {
+		if (num)
+			mod_delayed_work(system_percpu_wq, &dentry_tree_work,
+					 secs_to_jiffies(num));
+		else
+			cancel_delayed_work_sync(&dentry_tree_work);
+	}
 
 	return 0;
 }
@@ -224,6 +226,14 @@ void fuse_dentry_tree_init(void)
 		dentry_hash[i].tree = RB_ROOT;
 	}
 	INIT_DELAYED_WORK(&dentry_tree_work, fuse_dentry_tree_work);
+
+	/*
+	 * Start workqueue immediately if the module was loaded with the
+	 * 'inval_wq' parameter set
+	 */
+	if (inval_wq)
+		schedule_delayed_work(&dentry_tree_work,
+				      secs_to_jiffies(inval_wq));
 }
 
 void fuse_dentry_tree_cleanup(void)
