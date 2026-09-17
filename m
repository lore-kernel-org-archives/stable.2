Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF652E070
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651377; cv=none; b=DU6YkaRmW8GymkqoMWLfCB/D4ZdRZFIsoMbw2t3KxqE0IO8XI4o6JozasVMBdKx6HPCqP52qA7uGAAIzyD7lyZJ4uDX0hRPVUuIoPB7zuFlOBkCmeKLXDrdHzqa9vk57v6rCBuQDn7V6G7VUKCex99/mjoA/F6zxkmVnJH6L+lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651377; c=relaxed/simple;
	bh=6bAjjafvKhIrvVNXsfoFihGVYXc1pIFB4p0ji4B6rPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kf2u6IqDdnQASj5wOl497stOGV7lHO8UrfuGdXu7bn/gb8pD8mMWlAeFdtQKZJLJTt8kZbiUIyJZ7oX8UbjqnntMl3tlmGWQSktiVdvOunaSj/W7B50ubUJ11ytDlR0Wu3S1sIXNCWuzJzHwThk8KmVTtVXxmHn4nfo3DQuGgCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHlnhRNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHlnhRNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD1F1F000FF;
	Thu, 17 Sep 2026 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651375;
	bh=4lFjKY0PniljWgBt7L50YnnFFRABBXPLo+X6ouU7Tgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KHlnhRNKUbFSt8MxlV0c84gplNfLd3wDZAf7FLXyjtHiay5+oQl+4X0jyDY57cvvS
	 PXW9g9nDyWi5zfhCsyE4n6qm4IyTfP67QlXzOmANVDhEWiHWntniPMyNpKRfaGSnk3
	 SFxRoQgX+yzEpTTHUtFpeYqacfThutq6inl5mYjBvd1eniuD6XgT3y93/7+o2y4IJY
	 0Mp/Pcp2c1e7YVSJUpI96M3bRu0EjOQplC+GfRVXSpHFceIs8thBVDnwAHSU27wlKB
	 2uYTTC5MXDtEAqFpBL01002SJ2waGXdFoTnupIa9Ik8/xCI2HC7GkW/OQM1+QVZGnF
	 eZx3RCwUvxXeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix cifsFileInfo reference leak in deferred close
Date: Thu, 17 Sep 2026 09:22:53 -0400
Message-ID: <20260917132253.366252-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091618-legend-fiscally-1061@gregkh>
References: <2026091618-legend-fiscally-1061@gregkh>
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
 fs/cifs/file.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 71f585a41d456..b776fb2989df9 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -901,11 +901,18 @@ int cifs_close(struct inode *inode, struct file *file)
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

