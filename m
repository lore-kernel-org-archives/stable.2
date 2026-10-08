Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3CE3ACF0E
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429857; cv=none; b=lGPDkF9CVUePitZJivFFX8h+1VSCTSLcsl78GVrxh10UJbyplbULpeQ2T6nsltDtQHnpygKJuhAlB4MqEWu8/c7I2QvuS2Wzwpy39rGwCan4kbVW7HP+Tl24NVTEBbkhTavlNRDKCE6BY+PG7lsmbfTDEzSN3l1Gb1O4O9fQydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429857; c=relaxed/simple;
	bh=Vwd3NDOYwIA5ZKS8UloQMBBYOUW6GUnZ5tUj1OSdmgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HSG/LBqvhcvMzdaYKJYG/5Xwgc1UpzLGV4bmTEva3Dxi8FZGeB0M44DrDZCR4FWQqBKiC2a22il5YwQmKffYH82mQ7PPFlbcRCbgTuAbVKYQfY/DXafho5AphTAg/qj6+KcZ4p+hifblzozU/8iGDXdmI3EDxK9rP0vxaDEyHKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFez1ho1; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFez1ho1"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6790844c9b0so1553334d50.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791429854; x=1792034654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1KnRD+HklADwPSgL/qWcGHWiK0RgAbbE22jyJCxAFIs=;
        b=HFez1ho11ECjpaK/iIT/dtHGe9wBvKUJ372klAem7VCQKq6tfJgE5QyJSDwE+21kQk
         RUrxl7aztFx52xrKXqsR0aSe4szr0JTjt4GS415xJJOFIHOQYolSCgQgte3gQE9nzXXL
         JGmzfbRItNv+7Zq4d/Mt3d0S+X9XfUa1ERgXfU08fKXmx4Pax0EMsXp3IlCamMjO0xe8
         2FvHv6faTWdyJDhS3Q5J7YG1Yz4Q4YPO0gzm0OrnzO771O2Ke3BXiUJvcQDuGlnKxvqm
         gBvS5dq9By1zLAj1nFow0uQHY78LgFKCY/UET0ZUhJAPSZwzv1pT4UGDTOjXUGffRn66
         eiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429854; x=1792034654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1KnRD+HklADwPSgL/qWcGHWiK0RgAbbE22jyJCxAFIs=;
        b=XuKaU1Qh0qhrdjaI+zeipzAmlOqN2KaJarjxvsTSZ5v6jruYfaduWRZCzswWU5bSOf
         +mhqq9cMOhBOl1gfHxhU0a3xfQY5JX3e5lF3rSZpSI7dXorWxK6+CzYKBqkKYX9d0Tz1
         zPEadoKKF8XvmLhncuh1pCVrAZ5L4JKF3a+AjtTR0GJZH2GRKszYec+SFWRm3R6xr2Cq
         JwTMHtIJQ4IwnQXOlWgeOuvynzVoQiFciDY12xHmnDqtZHyx//+VLK+SSw0OhjRJOtlL
         ZMYqXvfUZ64sXGWqERiBSKMDw9h344pYZI0sTbyajPFqRNrmztjkuztbdXokthVql+h4
         V03Q==
X-Forwarded-Encrypted: i=1; AKwUvBxlDd3yfQrBccUID1vglGti6WTgxq00Zm9ujrPusJVUxxgT3nQesfnVYa+WJobgRg889crRT+0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJSX0fq1IImuWQ9V9t6+AWkYp8dG0VarhtppjhG/cznTxPn3GE
	lzdLeyJfC7SKSEt5nAEnOCTRLvtGxrRv3kSQCx1eszMG/ppu1jegK5Lo
X-Gm-Gg: AYBFou0BS86ArTevXKC929rkm+lENZ/RkQPUg4q0bAgRDwu1bmOKAXVicJDg2pBVhPN
	M51MxcaYRrpBwU4lqa5jXaLto3ZMzo+AUaWWMVU7fheuYep3YSXv9lAubua+4NUVYw1GQMc9pay
	pfWsFeJHXrCj33Y3txgSlcoqYvRIvK2NBjs8tBBInlgZLah8e+rKIyBZ14hwePld2amZZvDrKcN
	gXIVMk1dvHf+Bafk1PNnLeoPdreVjGaELPADyokWokp0J61LzhxKrI7UcigiNckt2jzZjlPo8kJ
	PHGptLk3pP6b+URDP/3E5uRHf3h/vx5MpbEHHObOwH+4dJW4KGBnkT7tJOqHqO0R6rSXuUAsyQC
	4obr3/ySEKmmNOFSL7f3P+itMfwPNP/lAb6w7XZsUEdsD0lo3VVyEvCipe2Seib3HHlYCRUm/Up
	mbxJnA9zrKkapwLuTf0TQPIZxIOEQtNaQRRVvGvKtAAxpolN8uo/hsXIxV9K1TGEMoIO6Hmis=
X-Received: by 2002:a05:690e:150d:b0:677:c303:464a with SMTP id 956f58d0204a3-6790a288da1mr2647635d50.91.1791429854418;
        Wed, 07 Oct 2026 20:24:14 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6791b22d0dbsm719263d50.21.2026.10.07.20.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:24:13 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 07 Oct 2026 23:24:05 -0400
Subject: [PATCH v2 2/6] alpha: handle VM_FAULT_HWPOISON in do_page_fault()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-alpha-hugepages-v2-2-8e108af2d961@gmail.com>
References: <20261007-alpha-hugepages-v2-0-8e108af2d961@gmail.com>
In-Reply-To: <20261007-alpha-hugepages-v2-0-8e108af2d961@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, 
 Axel Rasmussen <axelrasmussen@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3631; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=Vwd3NDOYwIA5ZKS8UloQMBBYOUW6GUnZ5tUj1OSdmgk=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKO81zpf/Mr+U3/vi8Gcz78vZGmJOQ0h/di2+Q43Y/Bu
 f0Mfpk8HR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHPNRmOGf2ZPbAy//Z
 7usStMMvh8zbL9oq1yzr1ivJ3v3NNWZH4/XcTwT2mvlPRzU+MN3Wd6M1bMs/Z5yVLf0vFoqdg2Y
 Zn4OUck+AA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

do_page_fault() handles VM_FAULT_OOM, VM_FAULT_SIGSEGV and
VM_FAULT_SIGBUS and then falls into BUG() for anything else in
VM_FAULT_ERROR. VM_FAULT_HWPOISON and VM_FAULT_HWPOISON_LARGE are in
that set, so a fault on a poisoned page takes down the kernel instead of
delivering a signal.

Alpha does not select ARCH_SUPPORTS_MEMORY_FAILURE, so the machine check
paths cannot produce these. UFFDIO_POISON can: it installs a poison PTE
marker without any memory failure support, and a subsequent access
returns VM_FAULT_HWPOISON. Registering an anonymous range with
userfaultfd, poisoning it and reading it back reliably hits the BUG():

  Kernel bug at arch/alpha/mm/fault.c:188
  poison(50809): Kernel Bug 1
  pc is at do_page_fault+0x4e8/0x550
  ra is at do_page_fault+0xfc/0x550

The BUG() fires with mmap_read_lock() still held, so the faulting task
is left unkillable in D state holding the lock, and shutdown stalls
behind it. A UFFD_USER_MODE_ONLY userfaultfd is always allowed, so any
local user can do this.

Deliver SIGBUS with BUS_MCEERR_AR instead, reporting the size of the
poisoned area, as the other architectures do. That is the huge page size
for VM_FAULT_HWPOISON_LARGE, which becomes reachable once alpha
implements huge pages.

Tested on an UP1500 (EV68AL): the reproducer above now takes a SIGBUS
and the kernel logs

  poison[373]: hardware memory error at 0000020000030000 pc 00000200010007ec

with no oops, no wedged task and no taint.

A backport needs the show_signal_msg() call dropped, since alpha only
has it since commit 9ca6af1aac40 ("alpha: select
SYSCTL_EXCEPTION_TRACE").

Fixes: fc71884a5f59 ("mm: userfaultfd: add new UFFDIO_POISON ioctl")
Cc: stable@vger.kernel.org # 6.6+
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/mm/fault.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index dfe427d93072..24408b53197c 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -8,6 +8,7 @@
 #include <linux/sched/signal.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/hugetlb.h>
 #include <asm/io.h>
 
 #define __EXTERN_INLINE inline
@@ -113,6 +114,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	struct mm_struct *mm = current->mm;
 	const struct exception_table_entry *fixup;
 	int si_code = SEGV_MAPERR;
+	unsigned int lsb;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
@@ -185,6 +187,8 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
+		else if (fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE))
+			goto do_sigbus_mceerr;
 		BUG();
 	}
 
@@ -248,6 +252,21 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 		goto no_context;
 	return;
 
+ do_sigbus_mceerr:
+	mmap_read_unlock(mm);
+	if (!user_mode(regs))
+		goto no_context;
+	/*
+	 * Report the size of the poisoned area, which for a hugetlb fault
+	 * is the size of the huge page that could not be mapped.
+	 */
+	lsb = PAGE_SHIFT;
+	if (fault & VM_FAULT_HWPOISON_LARGE)
+		lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
+	show_signal_msg(regs, address, SIGBUS, "hardware memory error");
+	force_sig_mceerr(BUS_MCEERR_AR, (void __user *) address, lsb);
+	return;
+
  do_sigsegv:
 	show_signal_msg(regs, address, SIGSEGV,
 			si_code == SEGV_MAPERR ? "unmapped access"

-- 
2.55.0

