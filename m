Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F4F547075
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791435708; cv=none; b=Z5MVOgppV8gDN+/tAH3otcNi4xqm0Iocd7SYnblv/INlxhrKGrcYhomU3gHGydPHlTCSZ90vXGCYPARKSc9154jgbifNPKwUQfJIXiNbJhjVyrleo47MYIkvfNINTuxF+Vn/+ilKCP+16fS/lNUv6KqEhvnS/x6p3p/g7rWFyyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791435708; c=relaxed/simple;
	bh=Lr8R1biVw5Gr5KRv0ZFED/ZEj+95G+ohm4P7sF1PD50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzlhHGyItbcCL7fMqNZ1dmHsRQkHyf3DQDe3rscWdlFNaGrk+EHf8RcdMurLJJU8Kt42QFPtezYiBX6PoK+HzuJGyMVJlKas7jMlD75pa1oUxzR4oHUh2zZSFxiQdej28xNFK/jv0YixUARVVq2xRm+MF1VtPNP6kieccJ1zyto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsgduzHR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsgduzHR"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8819033dbadso1711693b3a.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 22:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791435705; x=1792040505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ak5iTOIQGfouGHICnb+S+V/d3Pepokyc2hoELrEJXYU=;
        b=lsgduzHRHcus9oGfRp8Bl8LlXDVe7JWhbHf+YY0WeIr4lp1BZWgu5bIcoYdO8fxD6f
         Vt/1lE7lBHEeVO3naoKJf8zHdHLjF2FUNdRtWHG3CTnd37/yfnhQmmWgxwfrYIq8S/4/
         VqEcyrKYTm/Ndmp6Y7WDcTlf+GD3IPPDfKR7OoniFTOOO9AEZHOtzbqVab2jUguCmEgu
         KKooOgEhhgqRdd+jGXw0RpoEYM3gEoPYS/jJNri9fC2JIvhtKys0egcaB6RhVWdVWw0G
         VozWjUQO0Ge1EYsdimy5a6eqbTmqrYbtM8Atna+L9X8ThNZuWuRcDG7tAWdkZ7gDYJdu
         53cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791435705; x=1792040505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ak5iTOIQGfouGHICnb+S+V/d3Pepokyc2hoELrEJXYU=;
        b=lKQ4VKh4Od8FsuXkPS04653uNuD1LCNAtXsjpnAm+5l7e1nuHOy4U7OV3X7EhnXS4z
         W0wJe9nxEgErKSOs69Xf3IDD1n15rLg03qpl96JYsJpkyanu/wqnFCUVp1T65gjR76Sw
         O+WjBuiHa23cazKBHq6lWNn1s4DDFdChDKxTL46p/oY95gpdGfUd0KozkP0h0XxzuGRC
         ylBubYwkzSRY1cnnZq7DFTrFTuYWoD7NLNLhpbOUKibb520aS3uxS5t2kdJf+jQxUDGG
         iNQs98v8kuEH0M3DdOA8uZl+3Tc3iiekzovNl+1x0oH/qd5o6/+g7J5n2u7UP4idz6of
         N+Hg==
X-Forwarded-Encrypted: i=1; AKwUvBzx1IAiWQacf3RUYyGeq0gv7sO/8QwCxwXViKPPA0ZIuRtisEyLN07acSIEXHGJvzesJEduJ0E=@vger.kernel.org
X-Gm-Message-State: AFuF++n5zq07gnyVOlReNpSW0M+boaahqAPzbsTjfX2rjEK97NsGAcDc
	bg91k/gjigu9w54v6lH30BSHMClHTfDj04kTuONVm6ktGydZYCqzkCfO
X-Gm-Gg: AYBFou3QLB+sX+vVDr2Wmmp0/jkVSCth+sWkveqSJDGZ6TgbL+nPNpOsROMv0y43rux
	TGYJAkbZHFz0tpzeKi3XcQArWMN6yVXOeJGGXvKQlzFckEvprgFjAU/LQb4/mHlUZ+9YnSg8byK
	Vt/HQISrA63KHoMaT2z+aONYRQHRjt/l0lrbnWLEa8q0Q1S/U+abZBvjRi5iRlCFV4HXibF/jsP
	CmQb1TkSpfBHg8GcCqtQrasajcBNmhEqkFVkzaFEmQ9cyWOkVhsw5gEvTK+3sEDsL21t3mFjD0j
	Q13RRcekWI7aIrwyjl3ZtPcETD85FSqMPTIrO1Wn06CWWBknqcgkVlUvnRNLvOqoiAIHWW5TgCY
	obwSnPuRFuxVgbxkK9TC0U1a7vWfbJi0/d+KZkqJ5cnyuPtGlZr+vC+HJbLMWNzx505sZIb0KPR
	vDjIM/f6cxihpO+/bXipts9/HuoWA0V+DVEVwuQwdwcTY+FJ0UbRhGMGe6wQsdHa2Z/7I=
X-Received: by 2002:a05:6a00:2183:b0:88b:7e32:d96 with SMTP id d2e1a72fcca58-891ae9e0ebamr3474162b3a.1.1791435705534;
        Wed, 07 Oct 2026 22:01:45 -0700 (PDT)
Received: from dungbv.. ([116.98.134.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bc07927csm1020989b3a.59.2026.10.07.22.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 22:01:44 -0700 (PDT)
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bui Viet Dung <dungvn2345@gmail.com>
Subject: [PATCH] Bluetooth: hci_debugfs: Pin module for debugfs file operations
Date: Thu,  8 Oct 2026 12:01:40 +0700
Message-ID: <20261008050140.483853-1-dungvn2345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 net/bluetooth/hci_debugfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 2559fb6324d6..cd5ef398f238 100644
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
2.43.0

