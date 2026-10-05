Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B79365A03
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182449; cv=none; b=HDLY4DtogbkeSyOS7ZdvZZTME6TY8Qe4Hx76/G+3tIVHTmjXljJ2VobyEEBBuACvGtBLFJg7t+yT0PaRo7PdT9ik7nNSaAkrgPg50TXX1QkefleMj1ip9aln/n32cuty/c+xG+brrvl7TfM/FgCUkQNjbdxfa7netz2gZ64Rhfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182449; c=relaxed/simple;
	bh=eyRYmpC9FDCcnq6sMR/HGO5S965kooPZEQbOWPYUQgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkrb2bHjzzYvf7PcDp7afiS5IEl7NLyo8G2E43vkSW4y8Fe5YFkH4tEGT4nYbuU44YJEH7RAT+suEHOiBYM2eeXdtY6LXubgsx2z2gdSW3n2ai/++ZmnCw/3KRER7sCH+nXbEFucHKh4qHoKi5+Q4j6MOhaNkbpuyCS88NdwgzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOPZyv6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOPZyv6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7EF1F00893;
	Mon,  5 Oct 2026 06:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182448;
	bh=Nhq8+47UAbhtu8GdaEjvnwp3oJJA+ewN2bCfLRv5848=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aOPZyv6VqqhyzbfvjyEWuLxq0l+LbnEr2RG0YjTfyVLFAxeY5g+5bYhTz4Sn8mqXy
	 bGsEC9VvF85Qs+fZRijlJU3MMALk/gXP+81GnCwK0WJ9sPwI3hu8iqkqW3gOvUIYu4
	 bkMq0mFywpu1vQVaMWfaTdv7TgmHrHMx5PqLkDyVcjJAFYBBYZFwOs1z0G5QPh9jaM
	 0m6z6S3Z3zG+zvq0g3LWtH09mkbC+rFJd9bntQXsatQFzcAr0EsUUxdn19NEAiG6y4
	 F1MmcoQQFFzWUKjoGeDnHZuip9Q1oTyrn6DM7zw1Ui/IarQqGaZ9Wq3TAGXRP9l4zm
	 bs+C9QXconX5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yi Yang <yiyang13@huawei.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] vc_screen: reload vc pointer before if (ret) in vcs_write() to avoid UAF
Date: Mon,  5 Oct 2026 02:40:44 -0400
Message-ID: <20261005062847.1328878-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100455-expanse-liking-c1f2@gregkh>
References: <2026100455-expanse-liking-c1f2@gregkh>
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
[ sashal: Replaced the direct -ENXIO return with a ret assignment and goto unlock_out. ]
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

