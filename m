Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571AE486B86
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331649; cv=none; b=PDTmL4hP1jzwyUwz02NxmoElrr9IWDaJYXiE+OxkWZ52rKjAF+MDbXrJ3GX8ZGEh42ZvswrGm9GvOJA5lp9XbsLVMzWDeTx4IVdLXH6aPI0bFjdhUqgGi+UblUJov7WG7WBNXTLUSI+NXe0/NuIiMTtcgYGBjOLxwhmVbNxefdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331649; c=relaxed/simple;
	bh=zB1MqNonyZhzzSsQPUTOnSIJ+U2KDccCGJti1GNbW5w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X6BtO8MivTwoRWAXl6SzqJJOfRZlI7rxUwxWed5nPrANodCgw/8lwxD7NIwM+xhLgsz+BYiyIOyFzZ6oqxmZY/VFIpNcxZZJk+H4YwPv1nBhFIzgxFaGmeDdNaQYxouy45799L0dbewgJ381zgIyT6uT1JBOx5NNM18K8F7ZRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rzm4KbLu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rzm4KbLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F66D1F000E9;
	Wed, 29 Jul 2026 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331648;
	bh=3zrNeiCDxizowHlM2r8iPD/lfuWDmiZGnBmQCdwAqLk=;
	h=Subject:To:Cc:From:Date;
	b=Rzm4KbLuRJNXSkTnSxTVA/y5OUQHyUhNOOsHgTAa8Ums7gpuw/Cmu8vET0epA2x7D
	 AJ54grWs150XuccEbJx2+DYMS9Gq0JOgmQCYrQBQdF73QL8Li9f3r5qyqmhynJJu4N
	 GlUd1gEQolzP4txBGaqNCLMK/xcF+SezFq2rtJVU=
Subject: FAILED: patch "[PATCH] LoongArch: Fix address space mismatch in kexec command line" failed to apply to 6.12-stable tree
To: guodongtai@kylinos.cn,chenhuacai@loongson.cn,liukexin@kylinos.cn,lkp@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:27:14 +0200
Message-ID: <2026072914-impromptu-excretion-26f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 485ed44db5694d8d2e5027f63ad608e705286f30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072914-impromptu-excretion-26f0@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

