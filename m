Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D3D3CF20E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189144; cv=none; b=oBOgLcAs0WSRUic3NFawQ3zioV3lm5Sq57XCLpBxowtggtQUsrJE2FhOjc9F6uMdxWiIpgzirPmliY/P+7im7ECgx3b6TTjl6F/MHINOEMK+YBCu51FSKoitelO15EEi+h8scQGG/u8drgtt6RZR0hRAqevNLW5s2843kHHIS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189144; c=relaxed/simple;
	bh=EsxJrqudXBxfM3A7IK5kUzMXQuAzQ72mvegzmfEN35w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXENfv9BntQu2lW1WO5Jp+iyBdg1lg/GnKF6Rkb/Bx7+vyMzq2tEttER970sk4I5lMHa55CKWjCeGhzAhGYJw1D0mKGH58ekBa2jcID9YZ1yV9ZSEBwdeSZQoZbyID1X78Wd9fSE4sP5SKnvHQO3f0SyraBP7VjMwN7SGpzr2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DId15GuM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DId15GuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2DD1F00898;
	Mon,  5 Oct 2026 08:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791189138;
	bh=HvMNNEHVAUqxxRRxIgYaF23/3u43WdZjgKu6YTvXJc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DId15GuM9x/nHM88t7I6z4JYCK/e0HKgJIL05rNfZMyDwe2cNWbevYpq8/S21jUa0
	 wVOmt1Z7nAxvX7N5vswdCmUqrVPMzPpB/9wRXPny2Ehh04zT1fbb/sh9wy8dhyafxO
	 1NNYelFrOIThCFsFFiv6Z9Vccf1zto6Q3qD7ASLJpFF8m5pQ/r/frmxKx8zysGtCT9
	 F/aLBAd/8pBocri1FOhvn0LyNr5cvAtLOTZUM9NkW+MyUmWb6OEQUSiFuCDYTlqLIM
	 NzJDy3go1T3+q7xdxMpYlPCdb7pwrWDdDsGZ2wLbxMNumypvTO/9t+fxZQ3DQnD0Ih
	 i834Of9dQoZWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yi Yang <yiyang13@huawei.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] vc_screen: reload vc pointer before if (ret) in vcs_write() to avoid UAF
Date: Mon,  5 Oct 2026 04:32:14 -0400
Message-ID: <20261005082909.1446143-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100455-constable-passion-970d@gregkh>
References: <2026100455-constable-passion-970d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Yang <yiyang13@huawei.com>

[ Upstream commit 226bd5603371cd9f6642cbb9e9a677f445de3530 ]

The reload of 'vc' added by commit 8fb9ea65c9d1 ("vc_screen: reload load
of struct vc_data pointer in vcs_write() to avoid UAF") sits after the
'if (ret)' block, so the copy-failure break path exits the loop without
reloading vc. If the vc was kfree()'d via vc_port_destruct during the
unlocked copy_from_user() window, the post-loop
'if (written && vc) vcs_scr_updated(vc)' is reached with a stale
non-NULL vc. The '&& vc' guard from commit a287620312dc ("vc_screen:
fix null-ptr-deref in vcs_notifier() during concurrent vcs_write") only
handles the NULL case, not this stale-non-NULL case; vcs_notifier() then
reads param->vc->vc_num from freed memory:

  BUG: KASAN: slab-use-after-free in vcs_notifier+0x7c/0xd0
  Read of size 2 at addr ffff888007149190
  Call Trace:
   vcs_notifier+0x7c/0xd0
   atomic_notifier_call_chain+0x70/0xa0
   vcs_scr_updated+0x77/0xa0
   vcs_write+0x71b/0x7e0
  Allocated by task: vc_allocate -> con_install -> tty_open
  Freed by task: kfree <- vt_ioctl (VT_DISALLOCATE -> vc_port_destruct)

Move the reload to immediately after console_lock(), before 'if (ret)',
so every break path below passes a fresh vc to the post-loop
vcs_scr_updated().

[ sashal: REDUCED BACKPORT of 226bd5603371: carries 21/23 upstream
  changed lines; not carried: drivers/tty/vt/vc_screen.c:vcs_write()
  (partly) ]

Fixes: a287620312dc ("vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write")
Cc: stable@kernel.org
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Link: https://patch.msgid.link/20260901113131.2760010-1-yiyang13@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: Adapted the -ENXIO error return to use the existing unlock_out cleanup path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vc_screen.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 27b44dc123859..22735ca14395a 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -643,6 +643,19 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		ret = copy_from_user(con_buf, buf, this_round);
 		console_lock();
 
+		/* The vc might have been freed or vcs_size might have changed
+		 * while we slept to grab the user buffer; recheck here, before
+		 * if (ret), so every break path below passes a fresh vc to the
+		 * post-loop vcs_scr_updated(). Return data written so far.
+		 */
+		vc = vcs_vc(inode, &viewed);
+		if (!vc) {
+			if (written)
+				break;
+			ret = -ENXIO;
+			goto unlock_out;
+		}
+
 		if (ret) {
 			this_round -= ret;
 			if (!this_round) {
@@ -655,18 +668,6 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 				goto unlock_out;
 			}
 		}
-
-		/* The vc might have been freed or vcs_size might have changed
-		 * while we slept to grab the user buffer, so recheck.
-		 * Return data written up to now on failure.
-		 */
-		vc = vcs_vc(inode, &viewed);
-		if (!vc) {
-			if (written)
-				break;
-			ret = -ENXIO;
-			goto unlock_out;
-		}
 		size = vcs_size(vc, attr, false);
 		if (size < 0) {
 			if (written)
-- 
2.53.0

