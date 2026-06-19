Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7F27467F
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881517; cv=none; b=Ju7h++xBRnVDfod712gQ/mMEu6Y5FkjMrWfpE8gI0og0jbu87crJRPRP+DH+Igqm7mt5NCToznt404MXWHTNLXaV9OuvjqFJGryIsrhunyC59CN+IGKNeFWyDtKtvhJMCl6CgLTyQutuwwL7jHWtKi2FOAMy6FCkklmmYDkDtpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881517; c=relaxed/simple;
	bh=7xLsm9+GuD+ArEMSFPBN3QvywSaUNLAE3xk01dLL37I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jtGg+napvf/szvZeeGVq1urJ+e4oKT1C5eM9TXKCWAROPU5XZvHZKdiC9axzszTg2TMgqx+LFUg5r/MlY7o8rLIpowCesx+tf+z8g23LqmtHDG7Na6iP6RZSwiCQNjnR2Vpb+G1KeGPLz0GTaQBXRLhby00EoCueN+q5VP8dxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=luRpEn9s; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b="luRpEn9s"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ghgjH4TmRz9vH;
	Fri, 19 Jun 2026 16:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1781881155;
	bh=ysxwfeYwNd5Kpj7JVpBssNtkt3y+xhrpB9VC8FO4w+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=luRpEn9sSJnMP3L1heBEy7xHNEQYa9QBxdIqyQdM6AccRSryh+mMZ/1pGX/q1WT2Q
	 Gz6ng3YciGj+zzkK9motxxqjdbqNw9O9438bF4T43E9Z81zZ2vl9Dhrmit6IKtZFki
	 4vG16N58xlbGfW/frbAhWN4LYPCpszQWnJHYUdBMlVy1B7aYsC6C3QiISSzgbIkTAH
	 tDdAoyxhFjmpqhH9RR4Qf6EduUrykc75neobDZ7BkWAQ/5cZK8tOJ7T+pc2ZZ0fSqB
	 WgXsQsTf1+wQt+2bJxg3/YUzGPqIMdB/ibcCofPaxYQFqQhimybYcjMmJZ+cJsIFa+
	 SCdKai5TMigkw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ghgjG3dN5ztqr;
	Fri, 19 Jun 2026 16:59:14 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 19 Jun 2026 16:58:43 +0200
Subject: [PATCH 6.12.y 3/7] eventpoll: kill __ep_remove()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-6-12-cve-2026-46242-v1-3-e15a6de43c11@cherry.de>
References: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
In-Reply-To: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Soheil Hassas Yeganeh <soheil@google.com>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit e9e5cd40d7c403e19f21d0f7b8b8ba3a76b58330 ]

Remove the boolean conditional in __ep_remove() and restructure the code
so the check for racing with eventpoll_release_file() are only done in
the ep_remove_safe() path where they belong.

Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-3-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 fs/eventpoll.c | 67 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1cba4ae4a076b..3ac8a26c3522f 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -797,49 +797,18 @@ static void ep_free(struct eventpoll *ep)
 	kfree_rcu(ep, rcu);
 }
 
-static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file);
-static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi);
-
-/*
- * Removes a "struct epitem" from the eventpoll RB tree and deallocates
- * all the associated resources. Must be called with "mtx" held.
- * If the dying flag is set, do the removal only if force is true.
- * This prevents ep_clear_and_put() from dropping all the ep references
- * while running concurrently with eventpoll_release_file().
- * Returns true if the eventpoll can be disposed.
- */
-static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
-{
-	struct file *file = epi->ffd.file;
-
-	lockdep_assert_irqs_enabled();
-
-	/*
-	 * Removes poll wait queue hooks.
-	 */
-	ep_unregister_pollwait(ep, epi);
-
-	/* Remove the current item from the list of epoll hooks */
-	spin_lock(&file->f_lock);
-	if (epi->dying && !force) {
-		spin_unlock(&file->f_lock);
-		return false;
-	}
-
-	__ep_remove_file(ep, epi, file);
-	return __ep_remove_epi(ep, epi);
-}
-
 /*
  * Called with &file->f_lock held,
  * returns with it released
  */
-static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file)
+static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi,
+			     struct file *file)
 {
 	struct epitems_head *to_free = NULL;
 	struct hlist_head *head = file->f_ep;
 
 	lockdep_assert_held(&ep->mtx);
+	lockdep_assert_held(&file->f_lock);
 
 	if (hlist_is_singular_node(&epi->fllink, head)) {
 		/* See eventpoll_release() for details. */
@@ -886,7 +855,25 @@ static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
  */
 static void ep_remove_safe(struct eventpoll *ep, struct epitem *epi)
 {
-	if (__ep_remove(ep, epi, false))
+	struct file *file = epi->ffd.file;
+
+	lockdep_assert_irqs_enabled();
+	lockdep_assert_held(&ep->mtx);
+
+	ep_unregister_pollwait(ep, epi);
+
+	/* sync with eventpoll_release_file() */
+	if (unlikely(READ_ONCE(epi->dying)))
+		return;
+
+	spin_lock(&file->f_lock);
+	if (epi->dying) {
+		spin_unlock(&file->f_lock);
+		return;
+	}
+	__ep_remove_file(ep, epi, file);
+
+	if (__ep_remove_epi(ep, epi))
 		WARN_ON_ONCE(ep_refcount_dec_and_test(ep));
 }
 
@@ -1118,7 +1105,7 @@ void eventpoll_release_file(struct file *file)
 	spin_lock(&file->f_lock);
 	if (file->f_ep && file->f_ep->first) {
 		epi = hlist_entry(file->f_ep->first, struct epitem, fllink);
-		epi->dying = true;
+		WRITE_ONCE(epi->dying, true);
 		spin_unlock(&file->f_lock);
 
 		/*
@@ -1127,7 +1114,13 @@ void eventpoll_release_file(struct file *file)
 		 */
 		ep = epi->ep;
 		mutex_lock(&ep->mtx);
-		dispose = __ep_remove(ep, epi, true);
+
+		ep_unregister_pollwait(ep, epi);
+
+		spin_lock(&file->f_lock);
+		__ep_remove_file(ep, epi, file);
+		dispose = __ep_remove_epi(ep, epi);
+
 		mutex_unlock(&ep->mtx);
 
 		if (dispose && ep_refcount_dec_and_test(ep))

-- 
2.54.0

