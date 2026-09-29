Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555334E5322;
	Tue, 29 Sep 2026 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672948; cv=none; b=rrUSI3rHlgQgkeJXiVXRkkSF0SZo73LMbYshEuWiXT0c4lUGf2YESoPbkLpk3idiow1FrxEhzy/r8DQv7WkxVXU1GAmYTlWGCVl2fCife5dkncMYRcTb6QmImZZKfpQdkvIaHDHSpXBq2rW1KgiLaOULAf3gu53CYTc/woeV8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672948; c=relaxed/simple;
	bh=7mpE35sXrOZtJiDunAyy5ENg+MP4loZ7kGdeDOzUsTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZ1I8d89j1Kri1aUVIQo2/kCjyL3Y/hUK7A5HLo7g+7o75Ct5yWx1R3UYLFZiHfC/rYGVtog4eIgWcz63ogxGNRQRknM1FYJ/7voVMgqz7M/pIGIsfiSabkiKoCeIr8FmvfhsBb6Cx0uAEd8qMB/iQvT0le/YI08zm1ocFxOY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqwCwEua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqwCwEua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF6F1F00893;
	Tue, 29 Sep 2026 09:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790672930;
	bh=/s9X2Wr6mSOW6vSVla2q+5ix5SjbTSWUTwgrOHWsbs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dqwCwEuaO8ERPmQr7HKhkv0lKUIs+T2qgUMKK0xkWzT+f2LAUvZ/UMxSih6q5Ax86
	 uPR/Se0CUNwAvEVQRr4faOI6sceayxsaWp/2nfkkQNZcHd8P/SR1k2Rp2O+MhrckUT
	 diKhdizXwhbGJ6x1kSGMH4ujwGmt3BCdJpKAjSa4dxPKLnQHp5zPYhqCop2WmU0rRF
	 z2LcIu0LFSCuIZIoVw9jiam9h0oVzOhJQHbZo+idj9PkoOAIfoVc8c1ZlpRJxZAQyN
	 UrZ00DTnBgklVYTGmkev7ABCc9uAqBNdMRXWhaeP8Kk98ozZbWTAsDVGJt3BlwBQrT
	 2OlLRsdROpEVQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>,
	Christian Brauner <brauner@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Eric Dumazet <edumazet@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [STABLE v5.15.y v2 8/9] eventpoll: move epi_fget() up
Date: Tue, 29 Sep 2026 09:07:15 +0000
Message-ID: <20260929090724.1461557-8-lee@kernel.org>
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
index 3c5151e08f63..95d31d23db60 100644
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
@@ -879,34 +907,6 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
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
2.56.0.rc1.315.gc6ed9934b7-goog

