Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325812;
	b=aYbynp/BaSrOKcxHez/WgVWlSrNYWtzxeRCX3lKc/Mlqy2tUuy/E0I+5L7ruGCppyjrk
	 W9ioCuYaPYwZSZRbMHTYQ5/giGcAwXOuAnHeEXreLl2xPt4aSr2bxy32J61TaiNbyz5os
	 lmF1e4ZI3HlhvEg/cWnU4Aj21xwZoXOGD04eI4ssvzDnfacPngxWE3E8aGfOayHzTdFq9
	 fXSYffzUGdVuwrA9d5rgMOTKgDqWxeH6yFg3P3x7FN3vMk/DLQvEkdyq5ZTb5tBte+ztz
	 D50nFPB5L81782d8pE1BgdyFV10X4gU4GiUJHPNVW1xIomKwSP9wnmBzCYOlg8nIwmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325812;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D3UJqiZwnvPn+Mgrv2dUSVyfh0FPupoTBw0qs4IUGtI=;
	b=K2whBi4SDgBYUNd94IDDguaLz6tYFY2yWiGqlCWIaOOYgMCxYUTMK4FfvRQaUuUxCytJ
	 l4rFt08vBiNK0ZEXagFK6R4zpeA4rK2hKVmQYaXQ2ZJB1a6QWHwErc6Ah28uaUgXYqXFp
	 mpjrR0SifM1tbFcvT6m3we5RcWKzCoG7UcBCEpbR5HZEfYruwT5mKxlzrUtkP9LI31r5c
	 w6gdRgfa2dbJiEP9r0Nw6okR0xX1q5jpjxYMPRMetZRmWvHfqz65ua3uGGeF4nYAfxiB8
	 dfPcnzl7uW7hATjbs0hNoadfvQgVN8m+If3EMf/nNm2pIvBNTE83Zdu/Ixl5MBFrYuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gukdf++U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B2606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gukdf++U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5362C1F008A2;
	Tue, 10 Nov 2026 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325811;
	bh=D3UJqiZwnvPn+Mgrv2dUSVyfh0FPupoTBw0qs4IUGtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gukdf++U1ZV9uxLKvlyq6bzM6lMEEULJ5JDEKKIOIM0+n5SIT7+2eOpWoa/AvINYp
	 //pRvny1c8lgGMBkHb55stotQdJUoWdQqznc3Rm6NBj7mxfoFVvHSKw2/cPgNS2XK+
	 6X8MJGEtHMaVfO4BgrUE7SHJTwl02rknYoWBjvrMQ2l9D8zUgy4Lk5CBGCskxY/NkQ
	 LBVo9PMUB0nqfvpxrlm/eW4PdCCKDZTCtTpdCysr6UWTvJBePMdn/2egLBa4sA2nFV
	 AdGDZ+NMK8WMZ6bUCOU7aLDrw6r+d5ewpnvafBDW229GWzqwqqbarbRd0iHZuEXFow
	 Pv8jeOv61XJJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bui Viet Dung <dungvn2345@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] Bluetooth: hci_debugfs: Pin module for debugfs file operations
Date: Tue, 10 Nov 2026 10:50:09 -0500
Message-ID: <20261110154953.2337328-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110154953.2337328-1-sashal@kernel.org>
References: <20261107060625-failed-5.15-2a3e2287877b@kernel.org>
 <20261110154953.2337328-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bui Viet Dung <dungvn2345@gmail.com>

[ Upstream commit 2a3e2287877b1ee40ffb80b7d769b633866533f3 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_debugfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index be805c87619c7..770e026b1ebea 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -68,6 +68,7 @@ static ssize_t __name ## _write(struct file *file,			      \
 }									      \
 									      \
 static const struct file_operations __name ## _fops = {			      \
+	.owner		= THIS_MODULE,					      \
 	.open		= simple_open,					      \
 	.read		= __name ## _read,				      \
 	.write		= __name ## _write,				      \
@@ -286,6 +287,7 @@ static ssize_t use_debug_keys_read(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations use_debug_keys_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= use_debug_keys_read,
 	.llseek		= default_llseek,
@@ -304,6 +306,7 @@ static ssize_t sc_only_mode_read(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations sc_only_mode_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= sc_only_mode_read,
 	.llseek		= default_llseek,
@@ -440,6 +443,7 @@ static ssize_t ssp_debug_mode_read(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations ssp_debug_mode_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= ssp_debug_mode_read,
 	.llseek		= default_llseek,
@@ -532,6 +536,7 @@ static ssize_t force_bredr_smp_write(struct file *file,
 }
 
 static const struct file_operations force_bredr_smp_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= force_bredr_smp_read,
 	.write		= force_bredr_smp_write,
@@ -781,6 +786,7 @@ static ssize_t force_static_address_write(struct file *file,
 }
 
 static const struct file_operations force_static_address_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= force_static_address_read,
 	.write		= force_static_address_write,
@@ -1184,6 +1190,7 @@ static ssize_t force_no_mitm_write(struct file *file,
 }
 
 static const struct file_operations force_no_mitm_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= force_no_mitm_read,
 	.write		= force_no_mitm_write,
@@ -1322,6 +1329,7 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations dut_mode_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= dut_mode_read,
 	.write		= dut_mode_write,
@@ -1378,6 +1386,7 @@ static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations vendor_diag_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= vendor_diag_read,
 	.write		= vendor_diag_write,
-- 
2.53.0

