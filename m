Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047730;
	b=1qpiTPr0Kc6AQzRc41UNZAcMKqCuRV179HEBcIj9korUx1ExCi82g8HGMEzZeKZz5Y+R
	 L3JMdtAofviubFPfoMPWncIHbhdK9GoXEfevunVGcaASR3efG8UkylP1KnzVQMzczAod/
	 wFRm0sBCg1EUFd+M6VDfqkxEGd6TY2H9BVXrnIR3cRDzZwEYkdMN2m+eUt+fVMxtEg0W/
	 EoHFzRgNGBhFZ+MgYNeSpft9tiGHaXy/poXChaBP1RHbsVnxtF8cxED0DRkYFIw4IvogH
	 zyOUjN3hMpEIkZNerF9+V/6nY/Yn6rsGSso8ffAk5KDxZ3eeu7qlFTkKEb7PKh5hxpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047730;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rBNJulKpRxAsGfAIz1LRREa/wIQGDJ797j2YPEWLoJw=;
	b=29KaUtowj2S/vgS6mdyTd1RO1Fvg+x4AyEqCe515ii1YbTQZCs4YaNkUQR61j6YjZdUg
	 pqlHHAz2qYpSKr81RuTwoUPoiPYltBpnr+r5ZfRnSfLGJ4MDJRw9g5aeMETOEv6JcyKmY
	 lReavUFWI5MbXvTskxbvRcP7L1OiTMhht3V8engtsncaEjyFQeSuMuq7qgYdzwLTWB7Rl
	 eCQR0cT9c201ww8O3wuGplCGCAc5OM/RO8ZmVJ5vP1bxG+h/jDsHkbYd7a+VVI2bUJP5P
	 B4ME9B915DPJmFNszijOgV/L4VNJGna6vMbOIihXdWlsk6uPj2cCIPb75s4Vj8TfFtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2M2jDxX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8017606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2M2jDxX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D651F0089F;
	Sat,  7 Nov 2026 10:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047729;
	bh=rBNJulKpRxAsGfAIz1LRREa/wIQGDJ797j2YPEWLoJw=;
	h=From:To:Cc:Subject:Date;
	b=A2M2jDxXe6kA/OmM4OPe8FFTedyTkFap12/J1IYJ+vFa9O4YTymRXQ0iTSaonrwOQ
	 KEj7ItC9iEz1jYtAswdseiMue3BEQCTsMGrxYCubOnRt8PommNZmTLUnmTS5Of6nzA
	 ZUQTkZnr7jXpIk1riCSM3qsJ7LOFoWG9WzhFha2TsWSTai64SgYgEtkMeTXf5nsa9g
	 xKZTuDT4nWief1VYoEsoSpKiemWEvF2vx+OSnfF0ypWyrrbCOmhzG3IzUOOvMc31cj
	 k0mHD5J9GjwwlxyExnTVI1DDXQWIAWWqbvI5J1DHMywJEj/mPwcaJ8RFJzrsQfhpRV
	 H8tJjd92BBvWg==
From: Sasha Levin <sashal@kernel.org>
To: ardb@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] efi/libstub: arm64: Don't use the platform register x18" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:28 -0500
Message-ID: <20261107053528-failed-6.6-4c86b5f3fa78@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4c86b5f3fa78347fa9cbc9e8ec06615b2f80e397
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053528-failed-6.6-4c86b5f3fa78@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




