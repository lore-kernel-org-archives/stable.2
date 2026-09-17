Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FAE51C325
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650907; cv=none; b=CjZdH7GDMJYXuIHHzjwf9Sy5o2r7Fn5lkJzhpM8yMrnYOjRVC+Mp87MHh2XL7d+lbrnucXrg3foFMqNs0UZVNVVvRS3e/6jFgBCY9jkzqVmveby14Q9g4eH8T3TeAs2dv6IMSofBaoSLMZE7NadqWTuVladL8tmcbX75fPEzUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650907; c=relaxed/simple;
	bh=n5KKJhMbPWNS3wPT14AAi2SibMFCmsQhsORpDe5l1Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqobxo68gPSOSsdFxUxSkLwB3zaAYCr88eWf8YXRoVVEtMTJh7dMPIcAdyEsIngsyLFHARd+/hwXh14onX/C4Qmmmr0YIu1VGfi/70hP64tMy90cmdMGO09ine6OwdX+6fRMG8MlT9e7NV7DtL99bExb8VhtCmGQASFAwnC3CMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aummwZe3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aummwZe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462E31F00893;
	Thu, 17 Sep 2026 13:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650901;
	bh=Sk7l/0gXnU0IERVxOpqtN9CCo97VXrYEk7criNyxjZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aummwZe3tcHcqxbvWwmhbb1qJom8LAK6JmYI9LN5OOEjMnXH5nLdEzspSdE5DEXIe
	 140MUetDbM+q6UklXUx0G3tG861H8Iavq4WXPNxfeWtTKonspaWmJnFhJPonxurfY0
	 VnbdrUmrMXg6FmMluguPlpsRvTic8X3DcYH2ny9ABdm8G6N2SZ2h6Z5eLVe7m65Hgi
	 XirJO/WXGU/zIwTUASnMidnM5mWBtRnxRcwYvURa7Bgq8+CNmAxoky0wN8q0kes4Gv
	 mP5aVip58h/6Aob0lgEnbDwCCj+iqKxNWlcAXIqRWJ/p2jWTjc3/v/HtHHZPWF7pkH
	 +1Lxj2WA+7Etw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: fix cifsFileInfo reference leak in deferred close
Date: Thu, 17 Sep 2026 09:14:59 -0400
Message-ID: <20260917131459.350156-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091617-seventy-tutu-b0ac@gregkh>
References: <2026091617-seventy-tutu-b0ac@gregkh>
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
index caa55b5bc110c..04185e679ef0d 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1042,11 +1042,18 @@ int cifs_close(struct inode *inode, struct file *file)
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

