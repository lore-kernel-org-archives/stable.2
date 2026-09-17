Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE7353A6C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649345; cv=none; b=lT37HQHxuO+isOXkQllqnL0cmql7Q9jIoDn6W9N+UD/YJdN5D4OahCfpdaZTD4lzQt+JMZ5a0c0xRjmoPPRphey1T4daOdXqoZbGnUZM6OJRHoqmjsUlbydmlrrxhwH8VYnOyiP822OcJOV/Gl1ADMWVH1s2gkSAKhwqbZR0Z0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649345; c=relaxed/simple;
	bh=TWQi4vjpossR7pzZ8YC3QyR9ynVl0lIVprQ7zDrOyT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHXoyQ220qgC0JYHa+MiNRmA48NRCnwAveEV3s7k+5KPZNEmwMgKMDsSmXPpl3RCAD1mp2Il+RsKFAXy70iBnJc6cei+OLoauoKETr9JFp9uhyh/UYToGWVNaEz+8OroyPtdAYIm8Yw4gC7faOJeNEBMoZctPg3fIc3CcDRrfxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrNiyne+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrNiyne+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5901F00893;
	Thu, 17 Sep 2026 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789649335;
	bh=s7ZurGxeh9pJX0LmOh0IYs77w0WZI6HBtBr9KBlNdf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nrNiyne+dIhu0oicIxbNuhCNqUX96D6LwBdp0yJYjVebx6nnLBi+2YDE/gcP6mb1T
	 MQmcyq1hOvV1OXpVK47mZJGG9/iUnyu8a/cA9orlUGZrR0dfRCW86f5Bla9iFgoRtw
	 9hQjODkO0NfN4gpM0moA+ntARrNodihoMlKsPvB2zEUaJDTYvNDk8naE3b3o5UeK3G
	 34jkUmkixmw3VglAsOAbpPZDqb1uu/Puf41MykUuKjFRUJIMwETYCoeCfM4rMr87Bz
	 3XKTQ4AL/O8LjM2InOLAdrbtCo3Ezqppw6xsoEBuiIimc3Z2owmqfC9M1JHRe7y2Z2
	 I9C9bSxj4Z5QA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: fix cifsFileInfo reference leak in deferred close
Date: Thu, 17 Sep 2026 08:48:53 -0400
Message-ID: <20260917124853.223447-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091615-dilation-nuclei-5a78@gregkh>
References: <2026091615-dilation-nuclei-5a78@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 5520e89a5a4f834bced64cf2ac927001cc513a40 ]

When cifs_close() defers a close, it hands the cifsFileInfo reference
of the closing struct file to the queued work. Each execution of
smb2_deferred_work_close() drops one such reference.

deferred_close_scheduled can be false while the work is pending: the
workqueue clears PENDING when the callback starts to run, before the
callback clears the flag under deferred_lock. A close in that
interval requeues the running work, and the callback then clears the
flag, leaving the requeued work pending with the flag down. A later
cifs_open() can reuse the handle and its cifs_close() reaches the
same branch: queue_delayed_work() fails because the work is still
pending, but cifs_close() returns without dropping the closing file's
reference. The cifsFileInfo count stays pinned and its tlink, dentry
and server handle are leaked.

Check the return value and hand off the reference only when work was
actually queued. Otherwise, use the shared _cifsFileInfo_put(), like
the mod_delayed_work() branch above: the pending execution already
owns its reference.

This issue was found by an in-house static analysis tool.

Fixes: c3f207ab29f7 ("cifs: Deferred close for files")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Adjusted cifs_close() context due to missing trace_smb3_close_cached(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/file.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 2914b751970c8..65197b26aaede 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1462,11 +1462,18 @@ int cifs_close(struct inode *inode, struct file *file)
 					cifsFileInfo_get(cfile);
 			} else {
 				/* Deferred close for files */
-				queue_delayed_work(deferredclose_wq,
-						&cfile->deferred, cifs_sb->ctx->closetimeo);
-				cfile->deferred_close_scheduled = true;
-				spin_unlock(&cinode->deferred_lock);
-				return 0;
+				/*
+				 * Each queued execution owns one reference.
+				 * If nothing was queued, the reference of
+				 * the closing file is dropped below.
+				 */
+				if (queue_delayed_work(deferredclose_wq,
+						       &cfile->deferred,
+						       cifs_sb->ctx->closetimeo)) {
+					cfile->deferred_close_scheduled = true;
+					spin_unlock(&cinode->deferred_lock);
+					return 0;
+				}
 			}
 			spin_unlock(&cinode->deferred_lock);
 			_cifsFileInfo_put(cfile, true, false);
-- 
2.53.0

