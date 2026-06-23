Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5EF3976A4;
	Tue, 23 Jun 2026 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246237; cv=none; b=fJL5tOGPYtq/5mbhNvjC8a549Oa1zjGkN7YwbYjaWWJ6RKizQTYyT5k19aeZBdroswOQOzblsOgX4Qu+ViwFNUBSH2taNSDF6zhUzIHT3I+WSLKQYTYFbsBcgBMEZE8B99qrdleKeO4za5rOM/VAiwAOunxC6P6cqteltyFMtfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246237; c=relaxed/simple;
	bh=Go5eWlXJHSVntX+2CQ8j+W5AmpWJvdGUJZDOc0J/WhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f8xxq8xZhsu+bTX5Rw0BWsjWzm8OmBpzQY7+P7C65+JIxkcEAgBL4vKFXasUjoGgou8As/iGQQiXwl+AbfnhScBx7E2bcAIzw91eafeNAeTPIGmDXz+KFoS1yyJi+vmlFDlL7pyAiD9D2r4Rz9gQvh2YFX+eZfRvkw8s1xxHd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crdbzpKW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crdbzpKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2047A1F00A3A;
	Tue, 23 Jun 2026 20:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782246235;
	bh=aDOY5sMw+CXYJvAlAFZYLE2Azsgwb9nRFtjYFuPPBwI=;
	h=From:Date:Subject:To:Cc;
	b=crdbzpKWu4piOr9lVh/g/u0NquFNemQdB0lcLow+zRi7k4jNDwSbbZC50w4AlV3D/
	 a/uTKjN5Bt0pTbVJ2lNjRm2fot+dRE0UpRGI5MYMrfERtjFW6q2UlstRm9QdrZixJj
	 VSHAPlNI52HBp+IuYJLDp3y6pZfyy451Vt9POOYGHV2V7QLfy0FYEtLzpngWTL6d+X
	 d18Htm80IiQ3WY/LuQ9YLEDFruXV7tjxCM0jaI1VVtn5YFxyD3bCll34uJ7AsYaJIg
	 HBnKk0aHGkS2TzPBxflVm2wH/jgf9Y+hRnsFlM0/Nv1/pQj/oHzsuAevgFEfMANPF0
	 p53IoYdCnBieg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 23 Jun 2026 13:23:46 -0700
Subject: [PATCH] fortify: Disable -Wstringop-overread in tests
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-fix-test_fortify-for-clang-stringop-overread-v1-1-15ee8342a953@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN2wrCMBBEf6Xsswu90aK/IiJNsqkrkpTdWJTSf
 3fVp+HAzJwNlIRJ4VRtILSyck4GzaECf5vSTMjBGNq6Heqh7TDyCwtpucYsheMbLdE/rIpahNO
 cF8wridAUMMTedY07jrEfwS4XIdv/dOfLn/Xp7uTL1wH7/gHYEpNRkAAAAA==
X-Change-ID: 20260623-fix-test_fortify-for-clang-stringop-overread-df4b31b97f47
To: Kees Cook <kees@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Go5eWlXJHSVntX+2CQ8j+W5AmpWJvdGUJZDOc0J/WhQ=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFlWryP37pW2NnFe2P7oyiqet3/t3ed81J4l27d5n+c/w
 0Nxu8++6ihlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATWXKFkeEM14zLF1c5RhnH
 P1iilRVZrFPUJ2R4Ovnt27/Tg7RXNs1nZLjIcX6/DSvn7dpQ+YzYw09Zj9lKdygcUJtc1nvCZc2
 UDnYA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

clang recently added support for -Wstringop-overread [1], which is on by
default like -Wfortify-source. This breaks the usage of -Werror in the
fortify tests, resulting in the following false positive warnings in the
kernel build:

  warning: unsafe memcmp() usage lacked '__read_overflow2' warning in lib/test_fortify/read_overflow2-memcmp.c
  warning: unsafe memcmp() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memcmp.c
  warning: unsafe memchr() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memchr.c

Examining the fortify test logs shows a warning like the following in
each of the failed logs:

  In file included from lib/test_fortify/read_overflow2-memcmp.c:5:
  lib/test_fortify/test_fortify.h:34:2: error: 'memcmp' reading 17 bytes from a region of size 16 [-Werror,-Wstringop-overread]
     34 |         TEST;
        |         ^
  lib/test_fortify/read_overflow2-memcmp.c:3:2: note: expanded from macro 'TEST'
      3 |         memcmp(large, small, sizeof(small) + 1)
        |         ^
  1 error generated.

Disable -Wstringop-overread for the fortify tests, as it defeats the
purpose of testing the Linux specific implementation of fortify, like
-Wfortify-source.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/2168
Link: https://github.com/llvm/llvm-project/commit/86f2e71cb8d165b59ad31a442b2391e23826133e [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/test_fortify/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_fortify/Makefile b/lib/test_fortify/Makefile
index 399cae880e1d..44cd5df41a81 100644
--- a/lib/test_fortify/Makefile
+++ b/lib/test_fortify/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ccflags-y := $(call cc-disable-warning,fortify-source)
+ccflags-y += $(call cc-disable-warning,stringop-overread)
 
 quiet_cmd_test_fortify = TEST    $@
       cmd_test_fortify = $(CONFIG_SHELL) $(src)/test_fortify.sh \

---
base-commit: 122b52f0bab007ebeb414c8280c1def17b9ed1f4
change-id: 20260623-fix-test_fortify-for-clang-stringop-overread-df4b31b97f47

Best regards,
--  
Cheers,
Nathan

