Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047719;
	b=MINTKn2F9bxyrY/P5Cje81/uJkWtGlFA9XX9n+plAagvKQ3ACxFBBbvHPk3SuHp6cOWW
	 lgNCWUcLyS8uPef1+jsSWuKauqC8wrQwUEapyUZC/hQplcvhsdwKPd/J3C0BIbX5JI/9o
	 VCpE+ItC2EslyrT6wB1Qp88falvO2kUnZ/iGa9nFzk1G5oKLmg9SxiGKrwwhrxQu0CFUg
	 0iHFzLv/mhCF9Z7TzuqkuMHc8JsfPL9BDPkEbcEOP8dTPxseR7fzdUXl31l+T9qX90VS3
	 nBKEWRenY0mJb3Y4/gk4LmnzGEDtruOZbs5leiKrlkVKOgYdoZwdruyE3xDWgyONjqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047719;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IVRCWD74KzHdkB8vUKm4vkdz5tWP2nfdUBjpp6kKLIY=;
	b=bsoMmH3H6viYRKW9GIDmMhXacG/cfDJPmKv4q5l7CxlfThUTm/XJaYmp3/benRdWLKut
	 fafyPLd4GaJ/3PDQ2ctvIalEWRYTFbVDYVLfp2igzdWYa0n4XhLKPxd1tqOnpcbhY+PML
	 g2Oq9ycxfE1jzr1Ir+ELF6Rndr3A/cVmbn/CFLb6mBkuXyyULrVVjQXBBJqTGqhmoiEds
	 bmMwTAgEbcW132fbLsCzqMm8dLJTszshMIQsT4x71xYpkecbWvQdWI5RWr4olBf1O0HLq
	 StzJvfJFjZb8kTT4LahzyXrou56exKJ/o0s56PGZ6Sbj47eW0a2qZP7Sai9FEaKx1tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JDhdxC0x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JDhdxC0x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834181F0089F;
	Sat,  7 Nov 2026 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047718;
	bh=IVRCWD74KzHdkB8vUKm4vkdz5tWP2nfdUBjpp6kKLIY=;
	h=From:To:Cc:Subject:Date;
	b=JDhdxC0x1BJb6ULT9cT3wqt9Ht56YwpfFUkjE1csbUHz+FwZd4QZ5/eEBfLkpKqL4
	 hhEkIw6PAjZ8RV0IySZodLU/bFtzjGV18iWeaYqujSlXgxYmw2dNgVDBqG5vDuydPC
	 FvWvD+crKFrpQ0Q55ExXIpJXALpwg1Eevci6swD54MF2wlsTG3pldhhDixmHqG6Qgj
	 P9XZmt31tcrm9i5q7Y3wd8aEW9zfsSmSlLptxqDbacTcVojjHX1weZz8fGBWQui82U
	 t0wT60HZ6Qb+WmodrXBDmsyJPFibH/eJqLCCuyijo3olmz10I3pD5Gmc2VZuVE2cuO
	 rRTTK48mOQO8Q==
From: Sasha Levin <sashal@kernel.org>
To: dungvn2345@gmail.com,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: selftest: Pin module for selftest debugfs file operations" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:17 -0500
Message-ID: <20261107053517-failed-6.6-64aabf94eccc@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 64aabf94ecccb1120a63b4ee5a6761871a181a41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053517-failed-6.6-64aabf94eccc@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 64aabf94ecccb1120a63b4ee5a6761871a181a41 Mon Sep 17 00:00:00 2001
From: Bui Viet Dung <dungvn2345@gmail.com>
Date: Thu, 8 Oct 2026 12:18:03 +0700
Subject: [PATCH] Bluetooth: selftest: Pin module for selftest debugfs file
 operations

An open debugfs file retains its file_operations pointer in the
debugfs proxy state. However, test_smp_fops in net/bluetooth/smp.c and
test_ecdh_fops in net/bluetooth/selftest.c have no .owner set to
THIS_MODULE.

As a result, full_proxy_open_regular() calls fops_get() which succeeds
without taking a reference to the bluetooth module. When CONFIG_BT=m
and selftests are enabled, a userspace process can open either
/sys/kernel/debug/bluetooth/selftest_smp or
/sys/kernel/debug/bluetooth/selftest_ecdh and keep the file descriptor
open while the module is unloaded (rmmod bluetooth).

When the userspace process subsequently closes the descriptor,
full_proxy_release() accesses the already unmapped file_operations
structure, triggering a kernel oops in full_proxy_release():

  BUG: unable to handle page fault for address: fffffbfff8056f03
  #PF: supervisor read access in kernel mode
  Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:full_proxy_release+0x8e/0x140
  Call Trace:
   <TASK>
   __fput+0x39f/0xa60
   fput_close_sync+0xff/0x200
   __x64_sys_close+0x8c/0xf0
   do_syscall_64+0x115/0x6a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

The issue was discovered via manual code audit of net/bluetooth/smp.c
and net/bluetooth/selftest.c.

Set .owner = THIS_MODULE on test_smp_fops and test_ecdh_fops so that
debugfs keeps the module pinned until the file descriptors are closed.

Fixes: 64dd374eac15 ("Bluetooth: Export SMP selftest result in debugfs")
Fixes: 6de50f9fdb60 ("Bluetooth: Export ECDH selftest result in debugfs")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/selftest.c | 1 +
 net/bluetooth/smp.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
index ae5b44bb9d3d3..cdfc40e0016b4 100644
--- a/net/bluetooth/selftest.c
+++ b/net/bluetooth/selftest.c
@@ -188,6 +188,7 @@ static ssize_t test_ecdh_read(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations test_ecdh_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= test_ecdh_read,
 	.llseek		= default_llseek,
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 5c3bd42783860..5dac8b2eae42d 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3698,6 +3698,7 @@ static ssize_t test_smp_read(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations test_smp_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= test_smp_read,
 	.llseek		= default_llseek,
-- 
2.53.0




