Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33C47CC91
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631687; cv=none; b=LxTc24Ns+45PlUscjavsvjO2SisAknyx7Nm5GMVTB1QmpQMlA1lzYnuzhwuvq4KNA9Hqt0KQ7E2jHC56uFWxAsAiVAYDviBAPZBFMa4erPB4jaAMl7k7ol2KtWrgM5WNc2mLPSKDwy5z1Vdl4CLxCYUeWn+FZSls/q3fns4EloM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631687; c=relaxed/simple;
	bh=56iPGefvrDIOQ0kYSPHWkBcVy4fG83iGF+E4yp8AZ4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1kXEBOp1gGHpN8xzd28No4tU09JqywTzCeh1la85+VhGAhxcmmSRKRp1VdGE5hFvJQFrLnptGUaYHxZPRTMFXSPVYhvaUyVCJlm99kF4BBo+p84WG6AhIOFSd7Gixlm18V3KbWtNRg5TL6d6+M3jsLm2fn/wx8HHhHQTfUrT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvhsqXhr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvhsqXhr"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4624a44e152so45143f8f.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781631683; x=1782236483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKy4647HVZtA5TmBvoQR4FjcGycfij8utQ+A9hIT6Tg=;
        b=RvhsqXhrj6ArXU3dAhWnOzK8CQOBp9xOZ4DQ1AMiM8cIbLNdfMNtlPt5I8CovLO2sW
         cFYwWFBsYBvCB4Q3h3dY/dSJvtCCawygDduwl8kegMPAesHONnjcFjr5xw2C+hAe60Df
         h3j/ZSw1JMnvnlKDTzpP7XKLdCNwxiUEJIv/MWRT8/zpQhvzV5+xDixzz66daNPTA9PC
         FMC+7kg7nrFl3Zl+VfYhjzD8WzSFyQ1D4vHaHEuC1InKpNMnmxWLSLITZlwfJ+BdGnV8
         R1kphGjMrKnR/cYekSvQe6T02tE0Z29tjy2o1f2GkKb+OF4wH7jOlkWVT4IwEU3v2QDt
         5TaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781631683; x=1782236483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKy4647HVZtA5TmBvoQR4FjcGycfij8utQ+A9hIT6Tg=;
        b=dgvzuCjI9xhijUwW14bNzjOCVz3TY4RnmaFZJIlXH/Tporpq3Dwuq3xFgewICR5Vz1
         oC3iDgCaGJ7H44bVAogCeeqi35r9+2vpyyJKuvXt81D1/95TFofDPJ1rRtf3Z7vqeJYu
         5Zb4f7IIxCOaK3qIoAr/gjeeu76pwf7+84z80yyJERmdxilL0UwvGETnJl3P8BcuthZg
         7UWrxzNF1filiMFw9j83SJNUze0fmawz+FSBo6SG8iUozOJWznlcHmRLLMcpNFLkVICj
         eotGi0xW+FehKuPe/HORDwmc5IKImh75geSt18Tj1pBlCRCrevrO+8Myzu9VUpgy5K0b
         FSTg==
X-Gm-Message-State: AOJu0YwrgMCUk/9zYkO7mXsw376R79KnJcHKGvea41yfXIwePwrhZSyp
	pBzbVXqZnV1Qhf0YbROQgnGWDjYCBODG805OPv4okXWRu9IooW01eLrp0B636CY=
X-Gm-Gg: Acq92OEyV+S9PNI7yKn6ZuJHlkk4WtGhx+uX1dIATPH+STrhgRyRccGYlC01I4W7Zht
	INWOXk9ds27kp8KNa5l6JhkINVm5Zz7vPeO/FTIc+ZZedBUWh6kU81UVRAsKHvKp3bAOEI8wOM6
	y1LdFloQM6kw31uahLs8g3r2X7p/hrRl5xlqTOeLji6Zrc2pQUMrk03ebKCdSR7JlyL7j5M6778
	DUbeCqoJXF2napv7VinJy4kqOX++4a/oxdXJ7zCiNgjLBN0p80CPLVSGQchyWGUgTcb5PJg6iE6
	+Sz0Cgr/UyHnW1RV8ITK47kGaIb+5He4r4K1XcJt9ZN5huc1mq8HKdeWEB9A9EpGRcQOFDmxQWl
	VHD/lMmFG2ziGS7Eu9cMZEU5rkfA4aCKtSDlVSTsr/5cm1iXXB/napYXC5dlJFO1FMxwTlMpRzx
	Qs85y9w0IJobWMP0Q6AdTLpZm8Ltf0jgO7gf+P0Zny8bxOUtP4ZZYs4GJ4v2iJNNcnsrdxyr+vK
	ffx3KiWVKo+wMEciiSayuR6K0e9bPf1c4KlMNZa0K7tze10k7BvmQ==
X-Received: by 2002:a5d:5a02:0:b0:45e:e509:d2fa with SMTP id ffacd0b85a97d-46236275eb2mr616305f8f.3.1781631683244;
        Tue, 16 Jun 2026 10:41:23 -0700 (PDT)
Received: from archtop.localdomain (92-242-249-94.broadband.mtnet.hr. [92.242.249.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d70sm46775690f8f.19.2026.06.16.10.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:41:22 -0700 (PDT)
From: Jakov Novak <jakovnovak30@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel-mentees@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Hsin-Wei Hung <hsinweih@uci.edu>,
	Florian Lehner <dev@der-flo.net>,
	Jakov Novak <jakovnovak30@gmail.com>
Subject: [PATCH 5.15.y] mm: Fix copy_from_user_nofault().
Date: Tue, 16 Jun 2026 19:40:10 +0200
Message-ID: <20260616174009.9906-2-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit d319f344561de23e810515d109c7278919bff7b0 ]

There are several issues with copy_from_user_nofault():

- access_ok() is designed for user context only and for that reason
it has WARN_ON_IN_IRQ() which triggers when bpf, kprobe, eprobe
and perf on ppc are calling it from irq.

- it's missing nmi_uaccess_okay() which is a nop on all architectures
except x86 where it's required.
The comment in arch/x86/mm/tlb.c explains the details why it's necessary.
Calling copy_from_user_nofault() from bpf, [ke]probe without this check is not safe.

- __copy_from_user_inatomic() under CONFIG_HARDENED_USERCOPY is calling
check_object_size()->__check_object_size()->check_heap_object()->find_vmap_area()->spin_lock()
which is not safe to do from bpf, [ke]probe and perf due to potential deadlock.

Fix all three issues. At the end the copy_from_user_nofault() becomes
equivalent to copy_from_user_nmi() from safety point of view with
a difference in the return value.

Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Florian Lehner <dev@der-flo.net>
Tested-by: Hsin-Wei Hung <hsinweih@uci.edu>
Tested-by: Florian Lehner <dev@der-flo.net>
Link: https://lore.kernel.org/r/20230410174345.4376-2-dev@der-flo.net
[ merge conflicts 

  copy_from_user_nofault: caused by force_uaccess_begin and
  force_uaccess_end functions. moved the code around to call those
  functions in the same way after the additional checks.

  check_heap_object: completely different implementation in 5.15.y.
  removed any changes from this commit as the current implementation
  doesn't call the same lock which caused problems. ]
Signed-off-by: Jakov Novak <jakovnovak30@gmail.com>
---
Note: I have checked all syzbot issues linked with this backport and
verified that they work locally (the ones with repros) and on the
syzbot servers and I ran KUnit tests to make sure this doesn't break anything.
This is my first time sending a patch to the stable repo, so I am a bit
unsure if there is more to be done for testing, apart from inspecting the
code and running those mentioned tests.

 mm/maccess.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index ded4bfaba7f3..2b186ce822c9 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <asm/tlb.h>
 
 bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 		size_t size)
@@ -221,13 +222,18 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
 {
 	long ret = -EFAULT;
-	mm_segment_t old_fs = force_uaccess_begin();
+	mm_segment_t old_fs;
 
-	if (access_ok(src, size)) {
-		pagefault_disable();
-		ret = __copy_from_user_inatomic(dst, src, size);
-		pagefault_enable();
-	}
+	if (!__access_ok(src, size))
+		return ret;
+
+	if (!nmi_uaccess_okay())
+		return ret;
+
+	old_fs = force_uaccess_begin();
+	pagefault_disable();
+	ret = __copy_from_user_inatomic(dst, src, size);
+	pagefault_enable();
 	force_uaccess_end(old_fs);
 
 	if (ret)
-- 
2.54.0

