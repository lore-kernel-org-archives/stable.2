Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050599;
	b=oS58q2r82SGUS9OJ5Ze9DvDXuM7lnhb9pCPBi/0nFPn7Pmk2kxWPWisl82+39NsS6bkQ
	 XC8EQfKnIvDVnCAssiHXlLjMMpbixfKv10ZCuQIlYL3twIACDWlt987JmQsYpFtJgkWjf
	 SU6RNOA4wUX77Tp7qAo/R4V48VMd2k4jDEZcsxUdLNU8ax5/6Ro5iw+mQkBqDsgKh1DOj
	 0PrLxJLbFAFRIOmoHbXUlK3XhxUkJD7+SZbHh3GO1ciCfYYLcFfV6qeQDDNML7JDMe38y
	 jDMpAe8hp9BJxFBkAZh46bwpepdiCV5kxG5hkXlqYhJHwRJTUP7FUFzQqcZI7kE0ecQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050599;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y0l5fPAM13AyI8b4WoAO8weHSgtueFSQIxhpb7h5SwE=;
	b=U83uywiKof+lG9r/eOvVmuDHedu+fNZiLsIH5V1SvjByXPaB94V6zfm+um4gGz6DNax4
	 4Mrb1AxciB6LJKUuEt28fC3LcTZJvGe2RXnB3aa3BA9YR/yubn0GnNEUsqjfuT9BrTq65
	 dY4x4o28s5FLRu5C08olA8zGcVwdAfq2m/ofiGHFAlvdVU23zVO14vwUZho9essXZImwS
	 AaFkQ+IgpvVUAXXGKD/DQIh/QL5gOx3HHUgy/D/x9mIHVSgDelJvlGbnhC/ITYcgwjKzf
	 JPB+fzZVm5jsvcA0ZgwKjdnw9joTqpYB0w5w1jUthu7LGNsmdJxCZ3V8lsaMQdUXv/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JH1FFwr/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JH1FFwr/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36331F0089F;
	Sat,  7 Nov 2026 11:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050599;
	bh=y0l5fPAM13AyI8b4WoAO8weHSgtueFSQIxhpb7h5SwE=;
	h=From:To:Cc:Subject:Date;
	b=JH1FFwr/zt/D29bSFgLJQa5Ps2piYYvz16aBu1nuaNaqauIbaX6bdJK2/G8DhSFYj
	 Nm3FlTRobjjJG+kiPnmFD9bRqPXED5YKvbGt5MzC2ln6YFXDuf+xb+T9CYCl1Xb+Yg
	 GD5qyumaJFK/rXlp2vZc7hV4o4+cvaU/6HJ8id3Ek87zT2/KYeAgiVdQmnokudAFc7
	 AN/T6AGnKvjnaq3Bm/A2EF+3OQKaIxFEZXKKpcjRQqSXXMnA07SW3qgsjGZi1cWFCv
	 6l5/euBummqDyjWUM2Y4uhWCqHZL3//XQ8/n+ZbAtjU+/mXdidZ6v66A0ZHTuD5tdR
	 uqjBd5WhZE5ng==
From: Sasha Levin <sashal@kernel.org>
To: dungvn2345@gmail.com,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: hci_debugfs: Pin module for debugfs file operations" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:23:17 -0500
Message-ID: <20261107062317-failed-5.10-2a3e2287877b@kernel.org>
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
git cherry-pick -x 2a3e2287877b1ee40ffb80b7d769b633866533f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062317-failed-5.10-2a3e2287877b@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2a3e2287877b1ee40ffb80b7d769b633866533f3 Mon Sep 17 00:00:00 2001
From: Bui Viet Dung <dungvn2345@gmail.com>
Date: Thu, 8 Oct 2026 12:01:40 +0700
Subject: [PATCH] Bluetooth: hci_debugfs: Pin module for debugfs file
 operations

An open debugfs file retains its file_operations pointer in the
debugfs proxy state. However, the file_operations defined in
hci_debugfs.c (use_debug_keys_fops, sc_only_mode_fops,
ssp_debug_mode_fops, force_bredr_smp_fops, force_static_address_fops,
force_no_mitm_fops, dut_mode_fops, vendor_diag_fops, and the
DEFINE_QUIRK_ATTRIBUTE macro) have no .owner set to THIS_MODULE.

As a result, full_proxy_open_regular() calls fops_get() which succeeds
without taking a reference to the bluetooth module. When a userspace
process opens any of these debugfs files, a subsequent controller removal
and module unload (rmmod bluetooth) can succeed while the file descriptor
remains open.

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

The issue was discovered via manual code audit of
net/bluetooth/hci_debugfs.c and verified on a Linux 7.3-rc6 test VM
with CONFIG_BT=m.

Set .owner = THIS_MODULE on all debugfs file_operations tables in
hci_debugfs.c so that debugfs keeps the module loaded until close has
finished.

Fixes: 0886aea6acd2 ("Bluetooth: Expose debug keys usage setting via debugfs")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_debugfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 2559fb6324d63..cd5ef398f2382 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -65,6 +65,7 @@ static ssize_t __name ## _write(struct file *file,			      \
 }									      \
 									      \
 static const struct file_operations __name ## _fops = {			      \
+	.owner		= THIS_MODULE,					      \
 	.open		= simple_open,					      \
 	.read		= __name ## _read,				      \
 	.write		= __name ## _write,				      \
@@ -283,6 +284,7 @@ static ssize_t use_debug_keys_read(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations use_debug_keys_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= use_debug_keys_read,
 	.llseek		= default_llseek,
@@ -301,6 +303,7 @@ static ssize_t sc_only_mode_read(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations sc_only_mode_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= sc_only_mode_read,
 	.llseek		= default_llseek,
@@ -437,6 +440,7 @@ static ssize_t ssp_debug_mode_read(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations ssp_debug_mode_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= ssp_debug_mode_read,
 	.llseek		= default_llseek,
@@ -529,6 +533,7 @@ static ssize_t force_bredr_smp_write(struct file *file,
 }
 
 static const struct file_operations force_bredr_smp_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= force_bredr_smp_read,
 	.write		= force_bredr_smp_write,
@@ -778,6 +783,7 @@ static ssize_t force_static_address_write(struct file *file,
 }
 
 static const struct file_operations force_static_address_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= force_static_address_read,
 	.write		= force_static_address_write,
@@ -1177,6 +1183,7 @@ static ssize_t force_no_mitm_write(struct file *file,
 }
 
 static const struct file_operations force_no_mitm_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= force_no_mitm_read,
 	.write		= force_no_mitm_write,
@@ -1315,6 +1322,7 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations dut_mode_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= dut_mode_read,
 	.write		= dut_mode_write,
@@ -1371,6 +1379,7 @@ static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations vendor_diag_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= vendor_diag_read,
 	.write		= vendor_diag_write,
-- 
2.53.0




