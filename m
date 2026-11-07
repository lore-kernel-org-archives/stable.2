Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046978;
	b=0gbMPt7IawbCQ5LewptePTfEWRy+6nDYsXKgIF5GYX4EgWx1h2T3d4M+N42MDY+J7dyY
	 2JuoQtSUYc1pFjvQ+0VCAPAWw0wFpy3DCGrT7AxTdwDUC9ZQfMCzFIEAxNDTQu9N94gMg
	 PYs3YBPZTV/lWHkQotoppODf1M9FPJpn1h7o3fEnm99ixX6KmpGO4eN42nr5Mr5+tVb16
	 iARtFRbUBdZbn7u/crI0Nw0mS/z6HH8U6agERuNqZi773iH7QNqBhNWKHQOil00OQkCuD
	 nqY2OtUlXXObXqDaCTzWaYGJRLbjO17xMAGcjXbY3/fnNYce56QADdxAt+4PFQCbVxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046978;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gRkF6QHP90tKLUSLc3NEjjLcCcj+IcJhak63PQeJA7A=;
	b=XMgjSkimI4lJBww2bqI9iLOp+do3DRkplgv9MyHOrRr5YOXuH+JNZPb4PFLUrcVvGBjy
	 CrnNaTThGDIMJhKvrdFurwNs9cLzpw9yp5u5tm7x14M26eHfpBGYP9K+sFHYV8mY3gE9q
	 yWh3q0hL45u8/Df3iheEzq/sBVES8uKzorWqOZ51+LiN5Pr4O+50/4t/zgHGC1/k8HBzc
	 JP52sEzYn+0EVpXkEi6aSViRnvnlzjUwSs5ljK2ZFL2iJY0TCT/aA93oJ/94KQMDgHKm2
	 0CzbQIKO/h+mQBcBpDMvtPUTwvppVna+5bngWR2kFLKjzF7z27hqat6QYfxdyFetnfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhTqV6oE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630A606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhTqV6oE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FFE1F0089F;
	Sat,  7 Nov 2026 10:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046978;
	bh=gRkF6QHP90tKLUSLc3NEjjLcCcj+IcJhak63PQeJA7A=;
	h=From:To:Cc:Subject:Date;
	b=lhTqV6oECxmJwkD2b6GRDZ6Sodez4PvF61XboY5DRjhXT+9oXzdgvtIHRpjujogNi
	 tZfYWBaNk+huo8R4ita4Ivbuhdnhm1gk5zcOKHcnI66yNTethAkgmDf+/4+X7M42UP
	 46SlgD6oTBsP0TrNPBUV0nmy4+42hClWj0bOaYPkeKuXjFlsDFaJaTY2SaFwzL+eDp
	 zXKEyA7nGSqVnlnLE308UWJvKhye2RSxe97XOosiALCZPgSGgJlXVRZYtlAMG6tVaH
	 u4ddTwtgpNvhu9Lq0LTw+wjfCPrXQoufdxa3wiDq2lsMVGx1RaGE3KlF3OpmymtEtC
	 qExFaznLya0oA==
From: Sasha Levin <sashal@kernel.org>
To: ardb@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] efi/libstub: arm64: Don't use the platform register x18" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:22:56 -0500
Message-ID: <20261107052256-failed-6.12-4c86b5f3fa78@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 4c86b5f3fa78347fa9cbc9e8ec06615b2f80e397
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052256-failed-6.12-4c86b5f3fa78@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




