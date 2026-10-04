Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9D1246778
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135548; cv=none; b=q5wvgP0G2HC6hRjqbqrLsFQPOKa7zsIpx0XvRLE00G9dA5nrMRtXjHylrXvGEC/tIKsNpWfWM455xDPZ/XunqlwkCTCbd+XznMIm06iEDYe9zit8M/qg9TyrfomFapPN/mUiPcqHuWZI9r/XwoN3gBdpXYfTrqnnx1xkNcwai3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135548; c=relaxed/simple;
	bh=W+9d9M1mJM/nuCzkO3Lhb3lXy1iC8mcaIQXvHXGHrVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8cciyJ50zC1JMH7xOxyLlVqBhF6VGeRGOrkMQl4JFT/1uCkyRAqHSlLsMEKNPFjTZ6O5UKv82kfNp4eqnljzBhcrONFdFk0/hClrYPPK6PiciRJnmzpnWVoXoh+QxRWQ+52FC/0ulYWsGSXWyqSc9ClfDC0BoIv9s2hTkSeFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHblCtD6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHblCtD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7511D1F000FF;
	Sun,  4 Oct 2026 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135546;
	bh=Y1O/M+Wq1fA5ogYsY/pnAJtxoIkhJiVTsQ/E/T86CKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hHblCtD6J7H1DRezKAZK7CjkV1nPpvk1ZZVuzZS4NMeC0vqQ2UsA86yHbU/VgTTeo
	 7K/RCfwhLWvTYKAeaFa4ryUXyGe1hDvKZ3POPIh+8+R1UUI6C1JTv/Ep543KDBIrk8
	 boMduuiYNO1Jq1KH7myL2w6MeSELJpk4jsyXwrbUnKscE6RQcQoEa3AtMK1LLb/pSr
	 mAAShxYDlvuMZW+SghUFQ9sECpyVHhK4Kj2GowY2SxICxq5ChcjQwGvpl220o6gZ6M
	 W6D77a6zTl+HQBx/ncMe2JFILTXHqd6Vqe3nDiZ8i0tQbbrOheSvCbIbfwDR5bPZ3W
	 kV6n+craa5Ghg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yi Yang <yiyang13@huawei.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] vc_screen: reload vc pointer before if (ret) in vcs_write() to avoid UAF
Date: Sun,  4 Oct 2026 13:38:59 -0400
Message-ID: <20261004173840.989210-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004173840.989210-1-sashal@kernel.org>
References: <2026100453-thorn-hurricane-763b@gregkh>
 <20261004173840.989210-1-sashal@kernel.org>
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

Fixes: a287620312dc ("vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write")
Cc: stable@kernel.org
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Link: https://patch.msgid.link/20260901113131.2760010-1-yiyang13@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vc_screen.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index a59d2006b1a99..508d43167deb2 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -638,6 +638,18 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
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
+			return -ENXIO;
+		}
+
 		if (ret) {
 			this_round -= ret;
 			if (!this_round) {
@@ -649,17 +661,6 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 				return -EFAULT;
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
-			return -ENXIO;
-		}
 		size = vcs_size(vc, attr, false);
 		if (size < 0) {
 			if (written)
-- 
2.53.0

