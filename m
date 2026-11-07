Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050620;
	b=V2JA8ojy1fh1fH+BwPWFpacwjAodD4zwGPtZL2dWHQAuO77gkc3KkT+xpzlryB1R0AC6
	 FRMpwRPigmDvJ963Ed0ACTVmqu7gQdXvDK935kinh65NtIs25f9JN7kO3XrK+l9tw0yNt
	 9f7ILkc6PtvpccG/UAWCgyQCLLd43bjvLGg8WcZQC/HRykJ+lYpmTsdC43cpcjRUP+72J
	 niVyY9XZ+aSGXAoXBzEBaX7h+cwgjHpFCD1zO5twrc+dKJINqu4UJMHpOadRAw2Mql2av
	 619SCBokV07YL8Zl+OwmGaIV4HMK7TltwgqFvf2sB4YGBGC70dQfxyAnb0Oe9KFDeUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050620;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=g2CylvW7+GJEoeVLTi7VwZqXR7CgtljAKZXO6c9wLE0=;
	b=4InlBDsgRyc+LCkziPEXVBvR+IKQU/wjtFnmzNopPOuhwEvWjWnxRe0DJ5eRhIlAyTvp
	 r99a/ZUrnuiqrkhYOnvFtypuK8hnAWktLZGnaBcprXs1EXfXZJr0wAtj7MUC6HgifNbnq
	 lSWn/Wwx1FcIRpG036cSsOCpcxYhh85mplXTAY2iZfQCBOm3io+RwuWXVkh/IwHoCCz+p
	 rS2wsXe/3FCDeA6Wi0uYiMCiAPRu+mLa5Qso4K4n+EnlycdkpU6y761dER3DlUWtUGCja
	 5GTR2vhl/tHrPXquJu0n/+mn1ynCJkD8Fd1ZlxxXItMtA27kBuYS2vqJmdXhkzLzy1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8RO5gZv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F492606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8RO5gZv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235BB1F0089F;
	Sat,  7 Nov 2026 11:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050620;
	bh=g2CylvW7+GJEoeVLTi7VwZqXR7CgtljAKZXO6c9wLE0=;
	h=From:To:Cc:Subject:Date;
	b=C8RO5gZv2el3fEWAHPrTJ90fOXWI4fUYTB9ZOmhaXzegvA6Uo0/95hKzs+mHJXt7T
	 yU19UOYzbh6LwlUYFCgJLoDHJF4jVRiOX+Ippsj+jugWoI6jqtduos0i8YSgf1sJk3
	 R3Hg93iAILhMzFIPyhuBS7hvWSjbS4ybz55qRkxFcixD+jGPSxvZw57HEhT5qAKKZG
	 rR0qHf5r1OTBa3kZET4VWqTm+CV05mjJSauRvJJABNwUNN8CsJYe0kFzzhUkD6XG+W
	 +JQiHIsJBIqfusdWO5X1lj+02VtKgUBu6yqCpWvUAResZHwjaR6iLKFFxj1CKd2mQW
	 /5W9qDkQBrRSA==
From: Sasha Levin <sashal@kernel.org>
To: ardb@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] efi/libstub: arm64: Don't use the platform register x18" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:23:38 -0500
Message-ID: <20261107062338-failed-5.10-4c86b5f3fa78@kernel.org>
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
git cherry-pick -x 4c86b5f3fa78347fa9cbc9e8ec06615b2f80e397
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062338-failed-5.10-4c86b5f3fa78@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4c86b5f3fa78347fa9cbc9e8ec06615b2f80e397 Mon Sep 17 00:00:00 2001
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Oct 2026 13:38:58 +0200
Subject: [PATCH] efi/libstub: arm64: Don't use the platform register x18

The UEFI specification designates x18, the platform register, as "do not
use" on AArch64, so that UEFI code is compatible both with an OS that
assigns a fixed role to x18, and with one that uses it as a temporary
register.

The arm64 EFI stub and the EFI zboot decompressor only avoid x18 if the
kernel is built with shadow call stacks, as that is the only case where
-ffixed-x18 is added to KBUILD_CFLAGS, which the stub inherits.
Otherwise, the compiler is free to use x18 as a temporary register, and
it does so.

So pass -ffixed-x18 unconditionally when building the stub for arm64,
so that the image can be run by loaders that rely on x18 being left
alone, such as a kernel that uses it for its shadow call stack.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 564773c89d146..e13d4dfe27c58 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -21,7 +21,7 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ $(CC_FLAGS_DIALECT) \
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_KSTACK_ERASE) \
+cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_KSTACK_ERASE) -ffixed-x18 \
 				   -fno-unwind-tables -fno-asynchronous-unwind-tables
 cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
-- 
2.53.0




