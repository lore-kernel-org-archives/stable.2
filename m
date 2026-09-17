Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D14B404D
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650668; cv=none; b=MD2x4bGPrv23rH8P3NU511wU1BwbXBqxpFxXX9rlDE0joEG4NFRoRnSYQb4r1mKsJ4Aqbl7TxfG4kE5tGwg7e6gf+z9UjaoWx7uFaJzO2zcVMRJK9D1i/wXpmzqWonUeNyYHppLi6AgdfeQiuhxkAjCVCR6lhBKgsYAQ+cgMO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650668; c=relaxed/simple;
	bh=v4O1gr/avx3KNNJWebTg8oZFvsnunEXZjaraS0c5N1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kh1jRRrC9Cx0YoVpVYqRu2rZdlu2b5AiE/D0hDiNEWtfmp+1aLQ5rSScJJ6TIVyIqCvzk5HcPa6OXJImyRGQXe1IeoMFUqj//v5IlRMQQKCFgtHClDt63m2h4D7d153sl4Ra2VNWJeKMoS5V/+MtLK44JcMkb1A3V83jGpQu/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Km8OUsXX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Km8OUsXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B921F000FF;
	Thu, 17 Sep 2026 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650663;
	bh=+to/C7it9u/RnU4LSf7+5cLs6YSzatVrM+FJKlsUTbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Km8OUsXXFwYSEK+Z36VX2X5XWqYRg6aTVL+gwhYR3IjKhI9b6ak8k8+9xJklbjvK3
	 k/jmBeFRDEubJ/7hmf9L2SEx9rA4k7uIPa5JF5oF9aZZcjvC/ZM64h7isdpdfEyvD2
	 ax+q76HRrMQSf9a7E/tpktwDcI19q+WZ4oMaVoHygVea1Dkf53XXPklDpEC1kv3LOl
	 AShuhDBzcsdteZ1C2voTNJI0sGNjKLdcnIU+RU89oQpmKpvDePHMdd601CUGwdo+W5
	 bv46yO+G9PNB86yi/GUbtsXGp6DEVHZZLniSsZ/cnhq3sJJCFkt37vfLsuJ+JsX4SA
	 BMX7Y1JU0M2Hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjoern Doebel <doebel@amazon.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: avoid leaking refcount in cifs_queue_oplock_break()
Date: Thu, 17 Sep 2026 09:11:00 -0400
Message-ID: <20260917131100.337293-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091615-enchanted-bucktooth-2e30@gregkh>
References: <2026091615-enchanted-bucktooth-2e30@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjoern Doebel <doebel@amazon.de>

[ Upstream commit 9f2e63f1b2d5fc5b5423424902c091123e220e7e ]

cifs_queue_oplock_break() unconditionally takes a reference on the
target file before queueing cifs_oplock_break(). Only that work item
decreases the reference counter again.

If another oplock break arrives while that work is still queued,
queue_work() will return false and not queue this second work item. As a
result, we will never reach the point to drop the file reference again
and are leaking this reference. This can be triggered when interacting
with a slow-responding server.

As a result, later unmount operations for this file system will fail with

  BUG: Dentry ... still in use (1) [unmount of cifs cifs]
  VFS: Busy inodes after unmount of cifs (cifs)
  kernel BUG at fs/super.c:777!

Fix this by only incrementing the reference count if the work has been
queued successfully. Taking it after queue_work() is safe because all
three callers hold tcon->open_file_lock across the call and
_cifsFileInfo_put() decrements under that same lock, so a worker that
starts the handler in the window cannot drop the reference before it has
been taken.

Fixes: b98749cac4a69 ("CIFS: keep FileInfo handle live during oplock break")
Cc: stable@vger.kernel.org
Assisted-by: Kiro:claude-opus-5
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Adjusted the patch path from fs/smb/client/misc.c to fs/cifs/misc.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/misc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index cb7fb2c4ea71f..c7f846e50fc59 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -620,10 +620,11 @@ void cifs_queue_oplock_break(struct cifsFileInfo *cfile)
 	 * open_file_lock to enforce the validity of it for the oplock
 	 * break handler. The matching put is done at the end of the
 	 * handler.
+	 *
+	 * Only take a reference if the work is actually queued.
 	 */
-	cifsFileInfo_get(cfile);
-
-	queue_work(cifsoplockd_wq, &cfile->oplock_break);
+	if (queue_work(cifsoplockd_wq, &cfile->oplock_break))
+		cifsFileInfo_get(cfile);
 }
 
 void cifs_done_oplock_break(struct cifsInodeInfo *cinode)
-- 
2.53.0

