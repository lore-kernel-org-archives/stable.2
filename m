Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6304C3AC0CE
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881162; cv=none; b=jLnaTlw8x7GM/QoLVaJ8ildv/neRtDWIhpaECtYOj9WzWca88+uFS0ribOpgP6g8gnvMeRixiIKIxnBYZXXCPpx0xSf451bOxZxm9Fer6gpxckWAknXDBg1JlBccPU+wGEUFG/rBn0+Fr7V7VSCKD3+ij3/+i5Ted1YPQyaM4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881162; c=relaxed/simple;
	bh=F7Hes+ewLgYvEF4iNJMpld0LQrTq9YmhZA6xR/ilpZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0RCJEHI6e1BwYzfJVy167LwsbS8acDlMXsjxoHJMCJQC2MI1cHONPJcHqvSOcu+7KSxHbNW2w7iFWIEi4W7vI1nnJ/Egq9NYLQ6P01bmLT0iJ1nUvID8sPo53x5Ht06JnhVlPDCSx0eOhqxnl1J+eatfRxfhhrLmEHFHnEogm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=dM8042vv; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b="dM8042vv"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ghgjK6P7tzMpp;
	Fri, 19 Jun 2026 16:59:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1781881157;
	bh=rs+ZPrzaUX/kiOLSziikyJMS7Njz5EQ/nUzkOsvyEDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dM8042vvXY4NbPkoLuxH6KsTsR1OQ5CWH5okX8jxD8Gxur/rXlp39qNpkQYI9r3yG
	 VElPA18j6Kv4u2tt1X69NbVxqlQgQzupumvaI4xZa5GSuWT19kOgZcFqPAKCTqiDjn
	 wU3gdgnMz3t3DrvmCKvBAq+yhNyxOIEhidd+Xm0iIsi5Cb8r/oVJgi4SwbuD3CjxPr
	 Y2emuFIylwZvD8Mha+eCpgOBqBg6+25+9eMOpbPZ2nGSVVOjplIxWEXczNhqYWi4pQ
	 IIDpZAtpzDvsrEU8RBBnRlOA2YPC94C/MuD/56lF2byhSmymK3FyJbCvqQS038Jtjv
	 UFvFHCa+Rgmcw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ghgjJ634jzsTK;
	Fri, 19 Jun 2026 16:59:16 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 19 Jun 2026 16:58:46 +0200
Subject: [PATCH 6.12.y 6/7] eventpoll: move epi_fget() up
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-6-12-cve-2026-46242-v1-6-e15a6de43c11@cherry.de>
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
---
 fs/eventpoll.c | 56 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 27280ba4f3d5b..2993b76c21f68 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -797,6 +797,34 @@ static void ep_free(struct eventpoll *ep)
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
@@ -989,34 +1017,6 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
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
2.54.0

