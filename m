Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F86E488D8F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331655; cv=none; b=ECzVMwIqX4bNcd1LPtxu1bWHPZe/iImln86iwKyJZHaGiICGmlay8QO/QCAMqGkyfh9+wTT9DymgcZ6eStQjyMdrx5pKzwHdRSbkJWKSEDy5f9mNRzJ4ectbnFaCRu+fBshNnzfbR3EemdbhB+MV49sOp2f4Zd4swp5qM9olrDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331655; c=relaxed/simple;
	bh=RyItYvp1VWdeLqkMfFL4rmSiW5zmetFCp3rQarMLCvc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r8gO3TYh0XoWdz/z8o21kdLBgucL9vMhbbVmdq4Z1A0BaYDiV7UIRMKXXZPwKWfD01pO1aYL6vGOmEQNoS+y4UfzO8uYBAEC+8xUYq9/z2dRZBzRSGeClX0YwXk6FzkiQDL5Zsvb+cY0dc0V62KOiX2ADmDkZYErUapkoae/xA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CtMsTOLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CtMsTOLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2A51F000E9;
	Wed, 29 Jul 2026 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331654;
	bh=MJ/rCVcpe16hi8hExZRD9Inu4QlLE04HcMcICEU7t4M=;
	h=Subject:To:Cc:From:Date;
	b=CtMsTOLNP3s3PYL8VO1M4vR6d3NxNxSLuP3yFbqaevUTczadho+bo6cK/chv8R9hE
	 PKU7blQMDTzLcuiJSp85xtA3R7Dt5cr/JCSKN5EmvVHSc6yDJu/FUyCJrDM3QtnmE8
	 BuRf5kN4CBj+R1FWpt1sXQ5SwYckIHaeKJxe58FQ=
Subject: FAILED: patch "[PATCH] LoongArch: Fix address space mismatch in kexec command line" failed to apply to 6.1-stable tree
To: guodongtai@kylinos.cn,chenhuacai@loongson.cn,liukexin@kylinos.cn,lkp@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:27:18 +0200
Message-ID: <2026072917-goldsmith-trilogy-8255@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 485ed44db5694d8d2e5027f63ad608e705286f30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072917-goldsmith-trilogy-8255@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 485ed44db5694d8d2e5027f63ad608e705286f30 Mon Sep 17 00:00:00 2001
From: George Guo <guodongtai@kylinos.cn>
Date: Thu, 23 Jul 2026 22:27:30 +0800
Subject: [PATCH] LoongArch: Fix address space mismatch in kexec command line
 lookup

When searching the loaded segments for the "kexec" command line marker,
the kexec_load(2) path (file_mode == 0) passes the user-space segment
buffer straight to strncmp() through a bogus (char __user *) cast. This
dereferences a user pointer in kernel context, which is wrong and is
flagged by sparse:

  arch/loongarch/kernel/machine_kexec.c:84:51: sparse: incorrect type in
  argument 2 (different address spaces) @@ expected char const * @@ got
  char [noderef] __user *

Here copy the marker-sized prefix of each segment into a small on-stack
buffer with copy_from_user() before comparing, and skip segments that
fault. The subsequent copy_from_user() that stages the full command line
into the safe area is left unchanged.

Cc: stable@vger.kernel.org
Fixes: 4a03b2ac06a5 ("LoongArch: Add kexec support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605051639.aEPioXdD-lkp@intel.com/
Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index d7fafda1d541..1883cae93bc3 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -42,6 +42,7 @@ static unsigned long first_ind_entry;
 int machine_kexec_prepare(struct kimage *kimage)
 {
 	int i;
+	char head[8];
 	char *bootloader = "kexec";
 	void *cmdline_ptr = (void *)KEXEC_CMDLINE_ADDR;
 
@@ -59,7 +60,9 @@ int machine_kexec_prepare(struct kimage *kimage)
 	} else {
 		/* Find the command line */
 		for (i = 0; i < kimage->nr_segments; i++) {
-			if (!strncmp(bootloader, (char __user *)kimage->segment[i].buf, strlen(bootloader))) {
+			if (copy_from_user(head, kimage->segment[i].buf, strlen(bootloader)))
+				continue;
+			if (!strncmp(bootloader, head, strlen(bootloader))) {
 				if (!copy_from_user(cmdline_ptr, kimage->segment[i].buf, COMMAND_LINE_SIZE))
 					kimage->arch.cmdline_ptr = (unsigned long)cmdline_ptr;
 				break;

