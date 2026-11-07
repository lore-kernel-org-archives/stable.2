Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048562;
	b=fbOpdZtt4PpBZ4Si3oBgl14n4fg+hgCgwHrfcJllv6oQwCp3el2nZIDkRL3Mhps7FlO+
	 QxY0qoBS4y1xNAb9VomWGSSrHjuAgZK7x0lYei6zPD7+xmp0AZBRqkJfsAZXaGKQf7hU6
	 edpuXW9t9sE+iIwGkh98g+S09nGjOWIbiRQl+2V/WU63+M0/lipxvlBGhG5gnrrfIb3rl
	 GFYOIqD/0cb0tr5a7Wk3lalTVyA0t9gm4GwfJ9kYS9my2VgcOGrF2DpURy7KI933he38j
	 8JzmknCiGkjaElHSxa5mvMDCGmbncMsQXODQnaZq1z/75rdH/zQmjhivZT8Wi3q8HhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048562;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=62z6FLjWI+r3DiNELpahqJhjTZiljT5Oyrt+Tlypoho=;
	b=3uh4m5oUhn5N5ErydeonvLpDNfWFBYp/i1BqPbgmQiULxe11tEjcgyJ3TmfWLJ4LCbbR
	 4IbB075hk9CkfRL7Rt7kXUPA81//znoirWWd0TuDhWSFgOZPlPF4Jv/s8nlQBpA8zM4Am
	 /kYP40S5BJr2KJimoP8Mi3Vfi94qpGAxUQWqqYy/gDBMn9qtupp1elwkj7Dv0f4njrEHZ
	 cR6FytsbjcR3DqtvaKjSTZdQzZjIxtZdP0rMmATGziuiwHxNPJw7iOvwMjrORL1L73foK
	 akTqvM5uwT9oY8h7Ou+/P7R2YD5Jtk95RxCgYsT12v7Ta1ohxZoHqK65PUI1i6mSI6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTS3OWBh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E4606A33C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTS3OWBh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6A61F008A4;
	Sat,  7 Nov 2026 10:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048561;
	bh=62z6FLjWI+r3DiNELpahqJhjTZiljT5Oyrt+Tlypoho=;
	h=From:To:Cc:Subject:Date;
	b=bTS3OWBhekfg9n24ElmdqKfMWVh7bmyqf1iFcMs2m7SvARtzMSFErrr+Z73H1nmiT
	 iLipBuPKSQlVib9/iavuTk0DxZZEI5Tn1Q9oR9wqPX5CdeM0ibgNhcRKtZ824Cu2aq
	 1e0NjLZ6GHROyVO5ouxautNSZH7S0vj2XGAsXs5tQVrrUVpaUe8zZBVRinQy1SWOqG
	 qOGYW3sZs6l45KqFjkDuK0Xx4helSNjllY1KL8m6QeoqzjCdipk4l8aBF5riNfsqTD
	 Mn8UExID7dptv3hiQA5LgfuEVdEKsf8xCxV6cWRx0g1tuXj4OwgN+TKkrKhtw849+p
	 02T7xiwRcEygA==
From: Sasha Levin <sashal@kernel.org>
To: dungvn2345@gmail.com,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: selftest: Pin module for selftest debugfs file operations" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:49:20 -0500
Message-ID: <20261107054920-failed-6.1-64aabf94eccc@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 64aabf94ecccb1120a63b4ee5a6761871a181a41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054920-failed-6.1-64aabf94eccc@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




