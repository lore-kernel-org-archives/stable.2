Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ADF4B0499;
	Tue,  8 Sep 2026 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857517; cv=none; b=pmyIpBESKhVzq0M1y1k99MPSHRZgQKoptuw3CTNRTpexzyuffos6v9hCRC/vHFmmDW33WKOy/tORb1PhahwhbM02nJmwjYYTixdJ2oLAbPBRsmKqyd6doW9tlnpnZvQk47q8VQm0FTFzZhTIHa4kVsAkXILJcBVpV5ES/FlfTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857517; c=relaxed/simple;
	bh=lUhTTqDXjWSozDYvOgWluPtMj4VP7+tgm1MYHhHMvkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa6vyQBC8YzAGwayUNcvssUE1p/F8anIQjAJsCGjRqGkxFZ6M7Uv0BiDlYPINuKwj53Lu16p4ZitHb6wEmud0PQT80fWgMd0kHtdjosAtrsJnkdcyTsJB+rW6EvU13J6vBmZS/nGsB2JSL3SepNCK5KciCGDs1Kinr3ZSY3Yu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9toVJqF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9toVJqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D68F1F00A3F;
	Tue,  8 Sep 2026 08:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857508;
	bh=JN+w8piQmIvn5+hWh1OR7JoJxA1KW4+kNIUncTMIa5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a9toVJqFZLWdk5O90y/TU8I8aHBHtkhu1dKkGjVmZ+V6FeeZtx/fMBHfOLWYWYv7V
	 RnlZPcudTaLIGzpzZoE/mioNyFHi6u9MKZXhd6kjf9XGDyiYiyh1lcGvDh6RuD6hn5
	 3QWXZft9w3RMuzNq8EuMJB/lDgaPEpBQ8BUHm9Bn1gs3/QWf8AKluCCtzE2hOiXjgN
	 /T6kroR+2Ht1e6CrwrFqUKSHTcKXuvQjTa/8gN4DnShX8eEcNKi3IZ6bxiM7JBH0iQ
	 3QWzLiNMUl/peFv7RJyJXV23/c464CbDsO7jOBe/Qhbx/KpL1DehCkOXvv20zJ63fW
	 EP3N54HpTOOXQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Christian Brauner <brauner@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [STABLE v5.15.y 7/8] eventpoll: move epi_fget() up
Date: Tue,  8 Sep 2026 09:51:03 +0100
Message-ID: <20260908085113.3960814-7-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260908085113.3960814-1-lee@kernel.org>
References: <20260908085113.3960814-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 86e87059e6d1fd5115a31949726450ed03c1073b ]

We'll need it when removing files so move it up. No functional change.

Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-5-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
[file_ref_get(&file->f_ref) from original commit left as
 atomic_long_inc_not_zero(&file->f_count) due to v6.12.y missing commit
 90ee6ed776c0 ("fs: port files to file_ref") and its dependent commit
 08ef26ea9ab3 ("fs: add file_ref")]
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 7859566c519c75965b57ab2caccf8d6268717c9a)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 fs/eventpoll.c | 56 +++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f6db6621bbee..88a7a8ead9cd 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -708,6 +708,34 @@ static void ep_free(struct eventpoll *ep)
 	kfree_rcu(ep, rcu);
 }
 
+/*
+ * The ffd.file pointer may be in the process of being torn down due to
+ * being closed, but we may not have finished eventpoll_release() yet.
+ *
+ * Normally, even with the atomic_long_inc_not_zero, the file may have
+ * been free'd and then gotten re-allocated to something else (since
+ * files are not RCU-delayed, they are SLAB_TYPESAFE_BY_RCU).
+ *
+ * But for epoll, users hold the ep->mtx mutex, and as such any file in
+ * the process of being free'd will block in eventpoll_release_file()
+ * and thus the underlying file allocation will not be free'd, and the
+ * file re-use cannot happen.
+ *
+ * For the same reason we can avoid a rcu_read_lock() around the
+ * operation - 'ffd.file' cannot go away even if the refcount has
+ * reached zero (but we must still not call out to ->poll() functions
+ * etc).
+ */
+static struct file *epi_fget(const struct epitem *epi)
+{
+	struct file *file;
+
+	file = epi->ffd.file;
+	if (!atomic_long_inc_not_zero(&file->f_count))
+		file = NULL;
+	return file;
+}
+
 /*
  * Called with &file->f_lock held,
  * returns with it released
@@ -882,34 +910,6 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 	return res;
 }
 
-/*
- * The ffd.file pointer may be in the process of being torn down due to
- * being closed, but we may not have finished eventpoll_release() yet.
- *
- * Normally, even with the atomic_long_inc_not_zero, the file may have
- * been free'd and then gotten re-allocated to something else (since
- * files are not RCU-delayed, they are SLAB_TYPESAFE_BY_RCU).
- *
- * But for epoll, users hold the ep->mtx mutex, and as such any file in
- * the process of being free'd will block in eventpoll_release_file()
- * and thus the underlying file allocation will not be free'd, and the
- * file re-use cannot happen.
- *
- * For the same reason we can avoid a rcu_read_lock() around the
- * operation - 'ffd.file' cannot go away even if the refcount has
- * reached zero (but we must still not call out to ->poll() functions
- * etc).
- */
-static struct file *epi_fget(const struct epitem *epi)
-{
-	struct file *file;
-
-	file = epi->ffd.file;
-	if (!atomic_long_inc_not_zero(&file->f_count))
-		file = NULL;
-	return file;
-}
-
 /*
  * Differs from ep_eventpoll_poll() in that internal callers already have
  * the ep->mtx so we need to start from depth=1, such that mutex_lock_nested()
-- 
2.55.0.979.g7e5102b832-goog

