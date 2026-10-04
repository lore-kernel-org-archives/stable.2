Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340622FDE6
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147736; cv=none; b=M4hmTigC1xMPeM7VSl1t++w9c5V8WzXNgRsaYIszsZM2zRaHyWSka7OLPUWUazsASlH0EubeVdKlW+5PTBT335ByvovdDx5hEzbr85OhQ0ZHFvgl9RXWP1stRt4W59zVVow5AhjpWr/jW+pADYXlVgcrRw3AxBiQpuUZBRcGABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147736; c=relaxed/simple;
	bh=zQhVPnjOmNU/bz91xAETPXxBk3PfaOxhqB3foISFvKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkPNXvPfDlSsvJThWvWz37zElfca8XT/L/2gQz7eJaAH+tpyxdvR6o42bvcppeiRC/khSKUEfSltAKuZfBxIJGOHn12XKx/6zFBVGEv/s7mitXymdUEUS9FxUnIipT55/SC7W7vZ+HfCF0CzCPIQd2yqqSpgh80VH84jBvrsXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tde+h9OT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tde+h9OT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D171F000FF;
	Sun,  4 Oct 2026 21:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791147734;
	bh=/PlnVscxUUyVMFz/vHlUx3E9fZjpNOdxmGuUEiphRG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tde+h9OT621rgqHFu60bmXC0++Wdy7ayq4y/yfZ43MPdbQDxdZnXngZpq+6k9/axx
	 SKbDXB2MeIPWd+n6ozynOSpYf1Tm7JpBhWteVaTgTqF1cbzrnmAw1QkXFIIeGksxnT
	 DLRrNOS1QSiHb1DTRgBXiszL86+DyPJHCEkMxo4IekX//yRjWRsmMrNH/Ogrux5Boo
	 qjp6BN727d+qZCGBGYSySvO/4oeZPZKfYLFwsX8APqS0KacB7tZPz64pZ92IviaFHA
	 aD4XzviLLbbwOR+gzDjN08gY1ng+w9CKDA/5+nzPidgQ3WzrnO3zDADQK0vMl6r0cv
	 GUE33o7+CT/OA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yi Yang <yiyang13@huawei.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] vc_screen: reload vc pointer before if (ret) in vcs_write() to avoid UAF
Date: Sun,  4 Oct 2026 17:02:11 -0400
Message-ID: <20261004210031.1001408-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100454-caloric-pried-9341@gregkh>
References: <2026100454-caloric-pried-9341@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ sashal: Retained `ret = -ENXIO; goto unlock_out;` instead of upstream’s direct return to preserve explicit cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vc_screen.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 5c417b6426bbf..a7b3fac5304d4 100644
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

