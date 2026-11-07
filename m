Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046296;
	b=NgIuj8qXQIcB1ngfxAscO1xgnjfdmfAQvhMdNmI6BcbWuheL5l3/cEQCfZJX718JJvYH
	 30Bx9bo+kVPdCXxiSQHCPdwUrCYXNswNS7O0LT4T2YbvaoYd2ALTgvvZjt96cZ9BB88uJ
	 sxYy3YwlCN18kvit24BgvznAKmX1mQomw4Uw8gOziQL/V48ACSzUSaw031HQOUWusHG4D
	 GAIVFq9jLdKgYNqpDXLkd9dR2MMd5QOcvE3sB60YV6rvWDAdZ6aZFEr9xv2YY7uqG0Wst
	 CA9bKOCgngwaRiklVGzagpykPG0chP85xMiA9/ckkhRy9cIGHQWNl8Yp4fmyJVGjAKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046296;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=v2XmTKNJ5ILias2jLcnq4aZzemcmltr6WwB8BIJdOY8=;
	b=qmmAsTrFBPCXnc+UUUzpdDAruk7uVx+2tqzF6wKWgKUCQ3zTkGlHlUwdDB0TvppkgBd5
	 qjFNqoYQbXCBe6DWaBlm/g6hxwgoINeYIF11EU3WyQU5AOw7UPw1jLXrD7uFmg2GRUP7l
	 gjJPv8dFxIwivicpuTB80XegwRV1T4aOoJ7FyBOLA76bxJ7yeO/O8H/S8jcbMjLUR+7gZ
	 XsU1KSAhyhbmYHlMWScFRJp9EvY23JBdLdkdHYOMJa3NLFnO30jHXR/Uy1XWZjgBGY5LG
	 MG8yvW4I8SnvVsKE2EqmvpOw78ThkbNAXn9UQbfFaujIH44BfGA09cUI5I/ldQkVWGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYTE3raD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25329606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYTE3raD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962B71F0089F;
	Sat,  7 Nov 2026 10:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046296;
	bh=v2XmTKNJ5ILias2jLcnq4aZzemcmltr6WwB8BIJdOY8=;
	h=From:To:Cc:Subject:Date;
	b=ZYTE3raDZ3zffxCyrCnPUIr4asvHRBkZB44kWaEbyD1CojLX6QjN2vfqfLOd0Dlxf
	 uO4gPrEuSMjRTzrS0Mw2Nd2p3dNX2QajZpcQlEUFAAxBHnv0NPhNUgDKPUB1Kz0ZgL
	 KdsZ9E4qRfgerqXzU65GLDEkwDvTPjhfWGbotkX4HNIm/5e/6Llak8zB/AN4ZRJHj0
	 EnbbWSxLS01BwkTwiJpyEsbYeoOAg7QkyeyUnrEtmVzwSj4UAVx9T6DA2Mvb8KA5wt
	 iiJ7ThVDOZFOtY2FVgY7Kaq+kGfgg+iqfHEUPuqATzKpe2GUV9awPGsOS7nPefc75g
	 miecfMwcivYDA==
From: Sasha Levin <sashal@kernel.org>
To: dungvn2345@gmail.com,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: selftest: Pin module for selftest debugfs file operations" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:34 -0500
Message-ID: <20261107051134-failed-6.18-64aabf94eccc@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 64aabf94ecccb1120a63b4ee5a6761871a181a41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051134-failed-6.18-64aabf94eccc@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




