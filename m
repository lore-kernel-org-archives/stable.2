Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9D83C81B2;
	Tue,  1 Sep 2026 01:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788227213; cv=none; b=InYkMMPi78jgW4xpSS3QIdin4df02OrgNJs/PZCL6++0RKXxPhOUFrwZUcZym3oP4TozqB57RYFO5VaSiieP6ljfZwpR0LCAB2n19XpnZJHT7z0kkEQfg9siMSrRgENd1va22ZQv3BYiF+XFWYMSmUcXAM+iu6qkxrepIupzgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788227213; c=relaxed/simple;
	bh=9ZxkfOw4TOE1Obq8/2i/Q1JnSICiUGC/3m4Hm3cdZxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kAsXNq3XomVl5H6Q4frIqvdpPAySqXw8vqX/RCYTIR/mB/Bly4D9TRJUNyW61c1wDsU6VBKRfu//VdUxbPCZ9yvBidBRy/PLrCyaOw908tc+XidBkkg/Y10ERjGLpqMhboi7s2Zab6wChv144mQWZWjFPYUWKOTQxqopDTN++rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU3QSXFP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU3QSXFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39551F000E9;
	Tue,  1 Sep 2026 01:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788227198;
	bh=tv/giztluJ3mJ3RD/dlXAJAOrQrL283c0fCKgwhPQNw=;
	h=From:Date:Subject:To:Cc;
	b=QU3QSXFP8x1XBB2jqxBwYMIYC6tpOLXpJIxKHzWmZF+v3OYf22PrEiVCgo92nFeXa
	 JQaHAMGUP2etlCoyZrEjas5G/HZCLEnZDYnnm8XAy8Ph0urEGPjZAxfPKlz9Pu8P/9
	 78gVz7MQ8b2ephK9Tbo8KCVQbnRmZhijkxIPDR8nhD/VuOmME1nrI0WIgRg98XK8NJ
	 wQFgMmJ4BS1zLHnFzBHFt0nAhZRDOAhvrgalkbRDCnaK3ro5UgnzMp+HOTpJeKtiCL
	 PxRiue+v22OwsenIxO1eMX0MFwFnPNxcKNK1nosXtdhkqelL67k+zXOiI130Z7MNrl
	 d0f7wucaYad5A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 31 Aug 2026 18:46:31 -0700
Subject: [PATCH] scripts/sorttable: Mark long_size as __maybe_unused
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-sorttable-long_size-unused-but-set-global-v1-1-8a96b88697e5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXN0QoCIRBA0V9Z5rkBdWHb+pWIUHeyCdFwNKJl/
 z2rx/Ny7wpChUngOKxQ6MnCOXXo3QD+ZlMg5KUbjDKTmkeNkkut1kXCmFO4CL8JW2pCC7pWUah
 iiNnZiGYyXs370Wp7gN57FLry6/c6nf+W5u7k63cA2/YBchsEko0AAAA=
X-Change-ID: 20260831-sorttable-long_size-unused-but-set-global-262c0873a1a9
To: Steven Rostedt <rostedt@goodmis.org>, Nicolas Schier <nsc@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=nathan@kernel.org;
 h=from:subject:message-id; bh=9ZxkfOw4TOE1Obq8/2i/Q1JnSICiUGC/3m4Hm3cdZxU=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFnT9Cr/zv6ov/LiJsZC/iOTVGze1d6xCZ3R0fJHtDI6+
 Jx7nOy6jhIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRn3MZfmya8nb7sfn/RftC
 DjoIKPRviG9jnuDeOevD7ZWNK70kDBn+OzHdfSGpHXpedyl/Y9revT9Z+dUijPJyBMSWqfjslHr
 JAQA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building in a kernel tree prior to commit b055f4c431e3 ("sorttable:
Move ELF parsing into scripts/elf-parse.[ch]") with clang-23 or newer,
which implements a new warning under -Wunused-but-set-variable for
static global variable, there is a warning from sorttable because
long_size is unused when MCOUNT_SORT_ENABLED is not set:

  scripts/sorttable.c:452:12: error: variable 'long_size' set but not used [-Werror,-Wunused-but-set-global]
    452 | static int long_size;
        |            ^

Mark long_size as __maybe_unused to avoid inserting more ugly #ifdef
directives while insuring the warning does not reappear, as the
aforementioned change does not alter the uses of long_size, so it
appears to be coincidence that the warning disappears after this
refactoring.

Cc: stable@vger.kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This is breaking our builds on stable:

  https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/33143924291

There was a previous patch sent for this issue

  https://lore.kernel.org/20260603191708.27241-1-beakthoven@gmail.com/

but it was marked as stable only. I think this should be taken via
mainline and backported the normal way, as it appears to be coincidence
that the warning is not present in mainline. It does not look like
scripts/sorttable.c has a formal owner according to MAINTAINERS so this
could either go through one of Steve's trees or the kbuild tree.
---
 scripts/sorttable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index d8dc2a1b7c31..d7b50581c732 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -116,7 +116,7 @@ static inline void *get_index(void *start, int entsize, int index)
 }
 
 static int extable_ent_size;
-static int long_size;
+static int long_size __maybe_unused;
 
 #define ERRSTR_MAXSZ	256
 

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260831-sorttable-long_size-unused-but-set-global-262c0873a1a9

Best regards,
--  
Cheers,
Nathan

