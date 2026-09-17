Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE7509EEF
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650237; cv=none; b=tHdBB4Y6NG47p+GAJSLLUxxBGKIVrQnuyQqO3vShWdNUuDcZ4AOZ2BVsTGmbU3wI+yjlBBjUlt51eRGIYnrkLqmR7ng6sJANSI66ILTTk9hyc1UITF77TwIOIp77yJyzvlCZhRMxqGhzdf1VGzXH/AXILIVEVjzunfjGQA3Qn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650237; c=relaxed/simple;
	bh=E0QFCVYRArtR2EYWmx9mugHU7Hkp2VFGTxfsXQQaMCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9zkR0OJt/p5GJlSIi8v/eNrmAOKiXHiLpezfjicR7W4LnlgpwCPvyEOiDQSHO0ek1qtrNJEKKEJsk4I5fvJFWzT1USoVMO9qx98q4n4jjZ3i6qd7jCDVNphsT55hrYyD5AigCspzpCfgiRiXuQfVI04lPHIKpIq906+Qao79Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h63YSlM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h63YSlM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3661F000FF;
	Thu, 17 Sep 2026 13:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650225;
	bh=RWRyGca5lJA5kdZgJNEkz/q9DeysekEi4ScNL1v1SEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h63YSlM1rteYDWBynIt15IXxvoghA0XbZ8NoRAtMN5yJdGAwbTNdZ3/Zy3I22Sc7a
	 T4bp1c/QN//r/lLXYqScB90y8dqZsNpNkUiQCzvNJMmu1PkI7AkNtBax36qfekPgN+
	 N6Q5Fq1IkkE4DxS6+pv1lxeqtyWUho2P6TjzbSdaT1eYt+avYU9t6YNgFoZTKJAHyC
	 GqzlD0Kof1pKWlVnfUJrn4g9ioou9vZhe+8QgucNAcIltXMpQun96CBAIUpn7AmoYc
	 N+/q5QBAl7Jr7mXoU44b+30yPRiajbpnxH/r73Rpyk96vagWCuiWR3d38dkL5RAi2n
	 2LjKxvrocgSDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: client: fix cifsFileInfo reference leak in deferred close
Date: Thu, 17 Sep 2026 09:03:43 -0400
Message-ID: <20260917130343.320130-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091616-unscrew-providing-4bc5@gregkh>
References: <2026091616-unscrew-providing-4bc5@gregkh>
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
index 70b64df9fb2eb..721ce75bbc4d2 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1373,11 +1373,18 @@ int cifs_close(struct inode *inode, struct file *file)
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

