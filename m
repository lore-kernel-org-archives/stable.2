Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C35517BAA
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650647; cv=none; b=UqfQqlGvXXPzA8lxOJVm45oP9QK66ObYD/wFHB8XEZ9oD+QRNJG78Edtt+lCU6yLRROzuLFevKZbTIrYZ4pDtgprxsVnTM7bRRBUcjUB69gCJcST2uuEqW4ZeoA1zCXT9uUnwrsENIDYRxFdjeIZP/CKafScRZr2wnrvoAx20WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650647; c=relaxed/simple;
	bh=O0qTFOo0yKs7n8rem6znaesNJ4D9QJZ8zvkqid85hJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7pI8/AjGvRdSxZF265GdnqCkAW9BMB9mgEkrfieYtf6/R4E9YqMZ/mUUHnJg341fwA+v2kHgarGp4Bmq6F9QtVeJXyHQLGcmqJuz8Y3/3AW9gi/aGtnQm+SjU2T2GGmQ/fq9XKIT/DrgfmMICK1EdEWGA1m1EX9cxzU/jZWzow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWBxOTMY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWBxOTMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFD01F000FF;
	Thu, 17 Sep 2026 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650640;
	bh=Esgf6S+XAcwnBlNS1BaOXQdAkA1hgcmbzOnYQHgeX9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jWBxOTMY4zY6mRBL//6yccKlL25/6xIjUr6AfbSOhcgltnl5gS47BCCi/o+6DAZRH
	 6b7Ei/cWdfflDmJqTJx1XpU8W0JKsWwiEQpNvpqSqlWpE7UwfmWM77X2+GX8ukRK9a
	 QLnGqAoREIFVV0UuYmYVPpWh60ZC2FYWa388d1I8aL3vL8zkxMIBOAutdGQUfBL33f
	 9KtmdMVhHlAoWSf1/e2yce0vmg8ww8ZKDYPSlqCLHY3BbtrKL+DnMABBcXEgW680oR
	 iIQVUaGYDd/IT7WkjSqwupS6gSuQr0d/p/c53mFu1KsiEwqEvHHPa06zEYFKa6X8pP
	 2zqtnNjHHY/NA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: fix cifsFileInfo reference leak in deferred close
Date: Thu, 17 Sep 2026 09:10:38 -0400
Message-ID: <20260917131038.335403-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091616-concrete-scabby-841b@gregkh>
References: <2026091616-concrete-scabby-841b@gregkh>
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
index 94c8b173a8d63..34bae1866307a 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1260,11 +1260,18 @@ int cifs_close(struct inode *inode, struct file *file)
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

