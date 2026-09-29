Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EAE4EDCB5;
	Tue, 29 Sep 2026 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672935; cv=none; b=jbRO4nS5UZ7jxHu5mqc72zoMCFl6hE6T3C0vF+17US1qm57RrvobNIeLyqzHtbusasyNCHle78wdIAZBaYvPD7gp3dL9uHz9SQByA+oYsXQ0q3GEx05hhHhZ68yTzt9Bv4CxJ2SOOdcGBRSSWmskJz9KZyGPStz62LuvieR/mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672935; c=relaxed/simple;
	bh=hUqu+z+NpsvZRkjRDJy9FdbY36uS+XGX7HQYMrr7A5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sv4UlFZE6cwrQR8rd5+S5q6jgX4RMyziCidZ5nLWN8FleyHYPReKh0Mjy0buxzUdR+12OXzUdT3ekVmZFjO+BlYislF1L6Q5LgNMncNetnfinh/lBm9u3ok7LKAdUYqwdvL2HmKbTRNOzF9Z0yKu0oSEkZ1yi+kU5KGBD0Qzl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gi31GtQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gi31GtQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839BF1F00899;
	Tue, 29 Sep 2026 09:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790672915;
	bh=biKdnORbKSIiIJtm0MtyDDJXFakWvleESeK3nHzzGls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gi31GtQZrwuoT2OYzHsE3ewijr4oBOB5eTN/VKQUeoPEA/lwtbg/YzGd8DAXV/ugw
	 RZL9xy4RAvEBXAhOfi8coHgqHKuZe0th6f+IPNo5xEr1QlwY2wTIZMwFannFF70WBR
	 wzvgEQcaKrMJffOwp3AwMuFiSEfM/aF2ThhFC8ckpm7/3GQRhE4C9Fyd4sG+LXZ40+
	 T6ZQcUQciRo8SEQ5PUMqEyGxZm1nd3T1rnVDGmXcQzyJQjkRgP1YzzSfEfQavHkC2x
	 ujeI/+pWRwOVr0KDdOMB3JpenPzpirA1w6TSF2A8AZueG7mHHiZjed3iO+0In8ygqe
	 g60vrPCEjw+pQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [STABLE v5.15.y v2 4/9] eventpoll: split __ep_remove()
Date: Tue, 29 Sep 2026 09:07:11 +0000
Message-ID: <20260929090724.1461557-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260929090724.1461557-1-lee@kernel.org>
References: <20260929090724.1461557-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0f7bdfd413000985de09fc39eb9efa1e091a3ce0 ]

Split __ep_remove() to delineate file removal from epoll item removal.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-2-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 66bc7c8a33df3618e43ce0d0d4a985595ce57861)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 fs/eventpoll.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4a39ed132c3d..b6d1a939bd1d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -708,6 +708,9 @@ static void ep_free(struct eventpoll *ep)
 	kfree_rcu(ep, rcu);
 }
 
+static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file);
+static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi);
+
 /*
  * Removes a "struct epitem" from the eventpoll RB tree and deallocates
  * all the associated resources. Must be called with "mtx" held.
@@ -719,8 +722,6 @@ static void ep_free(struct eventpoll *ep)
 static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 {
 	struct file *file = epi->ffd.file;
-	struct epitems_head *to_free;
-	struct hlist_head *head;
 
 	lockdep_assert_irqs_enabled();
 
@@ -736,8 +737,21 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 		return false;
 	}
 
-	to_free = NULL;
-	head = file->f_ep;
+	__ep_remove_file(ep, epi, file);
+	return __ep_remove_epi(ep, epi);
+}
+
+/*
+ * Called with &file->f_lock held,
+ * returns with it released
+ */
+static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file)
+{
+	struct epitems_head *to_free = NULL;
+	struct hlist_head *head = file->f_ep;
+
+	lockdep_assert_held(&ep->mtx);
+
 	if (hlist_is_singular_node(&epi->fllink, head)) {
 		/* See eventpoll_release() for details. */
 		WRITE_ONCE(file->f_ep, NULL);
@@ -751,6 +765,11 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 	hlist_del_rcu(&epi->fllink);
 	spin_unlock(&file->f_lock);
 	free_ephead(to_free);
+}
+
+static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
+{
+	lockdep_assert_held(&ep->mtx);
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

