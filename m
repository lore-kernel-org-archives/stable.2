Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046967;
	b=SGw/c/Fn2q+NP5FT9SM+y1VqPoeqdE6NRQRoieQFgAtjpLca+eHyMPfTSfRFQ1TYK54C
	 nha4oiiwevTXwjvZbZFWvbORWDNPzjSBuiDiPZP2Xys3nk6FMH8aSQubuCp8NTCmmYMEA
	 sSgcm7YQ2WUIJwU6s30ibS794zVZ4g4hxfW0vZPFpwMf06n6ob+eqmW1JMMEAOmZ0hq2p
	 4fjCJQsrwqSo8WM7W4yMvYJpPPYY4oCuKk2LzulLI86vc9sHFBLSxKW1+E9zBXccicaZ3
	 TeLdy/0PxE4mrqaKuIpa4ZVHYbvib5O+ie00hcCbcT8/N6trlluN+JG3XvPtNi/s57Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046967;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yxwYI+OARDTP/5GtdUHyA/pw5lJihVqe3WF2sOe43qk=;
	b=DJWIJT/QuiIXhRieH6iF+q8KPd00AOm2eAs6xma+NSP3B0eyK8CZmgsGJj1tOyDSDp5C
	 TZ+1LBXF7oJV5nBYtoCDyUcYZXFwqGTuouu+E4rAY5zXCLdJUjYlFUW/SdcBNK507/3op
	 M2YLYgNfHN/Olo5b3q222z7UK2L7U0gHotDx/9BkOkDLE5Rx8M108RKwjj9xsKhleozQ1
	 3P+Xxqd39zizaeVwNT7ZRAqYrl/RpAJ+gGNIMeloxVAn9gZc+8XCpL++Q0v/yOLzxAQH/
	 yAnAmek/ndeo5bCIjkt0uG5Y64CkxKdrpsOZDy/dud4aakr0s8b40qCylmoADeQpOAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDVzzO3n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932EA606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDVzzO3n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118E71F0089F;
	Sat,  7 Nov 2026 10:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046967;
	bh=yxwYI+OARDTP/5GtdUHyA/pw5lJihVqe3WF2sOe43qk=;
	h=From:To:Cc:Subject:Date;
	b=oDVzzO3nXPslhktMepZgzWgNvum6mPlkzjJiHMlcdkmz8c+sCTy8KuiAdgZhwPEoz
	 myUg3V64cf+J4N64ZC1o1x/I3ciYJOfVMSVSNmCVLXHp6PDS4D6YRDXohOse53uKK/
	 j+26FcD21e5uxVy6fmYhy6wsv+arAbEj9HzHsQ3Ro85kThQcikLR3afU8trVSOUXdj
	 VotYT+3jU4RyvyIn0hxrM8o/aY2OmcDcW66qVNm7V3+I9obLQc2pQ9E7XJdztnSem3
	 tk3khIEDkgkq8jgv+RyL8wHN1yrPTzbQ7mHdFIV0Zewodm3kNBO6JDribBqJNDs+2y
	 8YsqGXDDO9GrA==
From: Sasha Levin <sashal@kernel.org>
To: dungvn2345@gmail.com,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: selftest: Pin module for selftest debugfs file operations" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:22:46 -0500
Message-ID: <20261107052246-failed-6.12-64aabf94eccc@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 64aabf94ecccb1120a63b4ee5a6761871a181a41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052246-failed-6.12-64aabf94eccc@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




