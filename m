Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050602;
	b=kVotCxSOFPEnz2mQEnGLKFs6Ah5Jwt4n4Z+L/pTDvLKMcTPTPdjp+azsuIQYWiEDwQaR
	 E+vg+BkfT5qEQgh4VGH+7rWMM7BV9SH5lTKkizBztUoJXMq8eJsFCI31VLaTHvj6Qrruo
	 aIEDTWLYua8iuOdQfdctScaActkauen9Gqpr4b1ooXxtyQIkcIF6p5oJqKqzBxJJUHCPV
	 C5li/ip43bV7tIvPBUA7jcVNoXZoR6wMs6xATyIsf5hKvUbH2T++4e0tceIoC4P7Rgi6r
	 SHQaeopO7omGgsriDc9I1xfFVHx3wwCZsad96RDUU10Hlbqo20LU5yRGA45pRaj6Htw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050602;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=O9SHpK/cmUaB6osPnlaHEQJho+Pci024/z5+OavNuMQ=;
	b=NLVEms8pYcLHqbmuUHu21AoXWrcg0qprHY5eO0aUQEYk7jLJpKhFN0SgaMr9dvRkyog1
	 WsbyX6jQ8ZpgQNcgWyUz62RaxExCtYrT3tlJ0/4heknn+JGqHDU2UZztQMQjuR3CeINZC
	 oxD+dV8ixt8s4g7URMlKHnRZmfB8KhSt3w1q3oGn+ahHxqG8XmVKFdaF9CaPikxEcRD+S
	 3L4hbQDQfoRxYmc/I6RitPMLjbvnK3dvKDUECBlDifjD801mALlFIdHkRsageYZhWHUiy
	 w2D7qQ3MJuTMwIzuynDh3OnAL2GLPuEuvMQJZ2jPVvFTVIk7kUizXWJFWhIqBfvlm2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9xib1Ap;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356FB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9xib1Ap
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D1D1F0089F;
	Sat,  7 Nov 2026 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050602;
	bh=O9SHpK/cmUaB6osPnlaHEQJho+Pci024/z5+OavNuMQ=;
	h=From:To:Cc:Subject:Date;
	b=F9xib1Aph9oTUnK0vWSJ7GIm/F7uyRv+e/hYLHI5ICPzJltNZsQYe5aegEFAeFmfK
	 V0JL0TcxB1DpW131f5l8TCXFKWnttR1LL8q60I0EyEhQVqlhIcHFNiYiwJfgbnd/sT
	 /5hVVHNy8XHZQUsqWmw2CDaidjs9/+uqUGNDR+LTdm8bkbcBBGVQsLcFBnuic1Qenl
	 CHHaoGxQ9hzPpS8WkHPIB+JnXKSVFqav6w5zHNTZ9We855X3+V2S75rUfqrdxUnCXr
	 +zYMRzEH3h2OVrU2lqtpsTWXN9En1Qf9vCKv0h5+onlEDcoYVzaSDaTM5TSHb47zk3
	 Rs11SS+MDV2zg==
From: Sasha Levin <sashal@kernel.org>
To: dungvn2345@gmail.com,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: selftest: Pin module for selftest debugfs file operations" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:23:20 -0500
Message-ID: <20261107062320-failed-5.10-64aabf94eccc@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 64aabf94ecccb1120a63b4ee5a6761871a181a41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062320-failed-5.10-64aabf94eccc@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




