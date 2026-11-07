Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048574;
	b=rlDbaJII/S0US7unnQ4oUl3/sIkb6giPl4DmqirBF9hxKJMuyeiH12rZBT4RrnZYWV++
	 THfe7aAq2j/LgMWbL2osyUw/6rMVFVxrKzEG8mYX2bd9P512SqEyaovAu/o5+2YhHjS9a
	 8X7XvQ7PNanvv+uMU9zQ9lRfBAdMt3uY3SNAAgG4b6nIr7N8OFJOs3dYqT+2CUiOofbus
	 20MgJTXrlAgCm1UTik6bUAzRLq7GJHiLCvHwn8HkuRUSdvwbbwbXZisGNGyz3UcngIhzl
	 /LReaYHqJVvj39n4a/lvX5zakseI2INHA+U3f9kOF6EHwM/EH0cg8x3JISclQgQ4muQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048574;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZtyEUkiM47rBPVn01pihNlRRmj3DXaSS6LZa33ST2e8=;
	b=LXaDCveXQe4MumqnI6qnlR6b0MFD7jtyFJcfS8Ahwty083GLpSv4txSr/WuhDuEEeqpy
	 1bRzHC9HtJB1c1qcvupASF/WqF9LrTwvLMc2zz8kEty/ypPj04lWx7kfsV4q1cvbEkfh7
	 sxcmdqtshSU9+w/s1fUhIH3E8eUMWOa4bYK6EATbn5kMXcXYlND8X2Q2b5Hpk6qqP4j/2
	 pfcVOyWGe7tifzXw8lIZbuXPga21mT+/cYjHUe9ru0VO7+cTYpnp0+NHELRXPlLqWQkP2
	 QaWfoQaCd/VgNGB+TvnijBYwB0QZeOEUxiyg0+cB2oJwOcbJ+aG/nWPqT46/SRuKnpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMpsagyq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65D60A263C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMpsagyq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDF61F0089F;
	Sat,  7 Nov 2026 10:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048573;
	bh=ZtyEUkiM47rBPVn01pihNlRRmj3DXaSS6LZa33ST2e8=;
	h=From:To:Cc:Subject:Date;
	b=nMpsagyqjjTFbWnJ2JJiXr2OYeLuUoTa5q9DICNiV/KHeLSlhH9hQ8tM1D1Ie3ExT
	 WkXosI2BSArvSTFniyTrDpOsN8ZDHr2Ep+tudQkTTQOlLo6xVymHYhfx5rC03gysJR
	 MFyc+zOf1H26p/mbJLcTbfXgT6p3X3g1MRqZP5I4mM5i15t+B6VYN/pufEHrrSiGeY
	 X70QkInaUvuHa779Fsb7XIRhr4QxXEhiYN+Zkw3lNqpitaN/2/sPHqHitL+G3skqOj
	 PgI/2rzolg4fuXxtvUkyul4d8I6/o8OmYluFsfvj/k+Tdy4L5mt51rIWyyY3DrHm6E
	 W08BjjzEl6xiQ==
From: Sasha Levin <sashal@kernel.org>
To: ardb@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] efi/libstub: arm64: Don't use the platform register x18" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:49:32 -0500
Message-ID: <20261107054932-failed-6.1-4c86b5f3fa78@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4c86b5f3fa78347fa9cbc9e8ec06615b2f80e397
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054932-failed-6.1-4c86b5f3fa78@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




