Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2303BE172;
	Thu,  8 Oct 2026 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457775; cv=none; b=GwzY7GG9hrJ9dlajbnKF95kwomAFbxOVYbd+MCjN4lTWyA8PImBbuP7v/yhtYVoZx//bvIhNasMvgglgOB/1f+dpGDL/ndAx/11K+RNyaFl2ydsuH7Zl0qth4ekPgNQ7SnASXJRPif9r5EQGgCO9jBgf3L37xCpdYGEAL1XU5Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457775; c=relaxed/simple;
	bh=75s9Og1njdygxV8tnkbcGXlKjyNinTjM7/sgljM9zf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pgQns/BIOSxdCDyC+E7kXc5psWaTqbcPLAerEKh7qHMm92JybZRmC2kSS4sjizdfX4kKA3MjmNbYYN8BZpvD/T3ETt5j9ayUhAqC5zAE3rwVowOU/ck6sObEIfVdeMpzLL4UdRRrkjRoSqwrgCHcGWUhUrE3ZqnUrPARUyJKkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1zI3Owf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1zI3Owf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C771F00893;
	Thu,  8 Oct 2026 11:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791457774;
	bh=K/E2/Jsizusc3aaYESoZpCk7qa83D/rUYpDEILEV9xI=;
	h=From:Date:Subject:To:Cc;
	b=Q1zI3OwfGZmNM89ul2wQM2L4yfb/lebm/OoxtpntYe66nvoZd84HSApmhPwydW0Iz
	 jCuYBVo0r9xyPu+xGQKP8dMk248yAIhYUEOWUhuWhnF1T5hk/F3v2JID3C/qLVCcBv
	 rZqYQ1HQXemdEw22nFBuyOiV/tQ6kphwcfIomDXyRZ2qZvUx8DQmUM4M9juC8oiY6g
	 gJJhmbBvIaTTeJOr4emp2V7NVRE2lmhkqW3uYbMawwsPQaH5047sLWS4yfBr6Y+wst
	 SC7ZrRJd5CbNWOJ7pYoNZBfurmYCSPtFVUlgLrHn29tk/RWZs9/QdvkaO4g5DxZjUu
	 8Qh4kzhL5jzTA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 08 Oct 2026 13:08:49 +0200
Subject: [PATCH] lib/base64: Silence clang-24 -Wconstant-conversion with
 diag pragmas
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-base64-silence-clang-24-constant-conversion-v1-1-0858b60b23c8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN0QrCMAxFf2Xk2UBXZxn+ivjQxkwjI5OmDmHs3
 2317R64nLOBcRY2OHcbZF7FZNEK/aEDekS9M8qtMnjnQ+/ciCkahwFNZlZipLme0A9Ii1qJWtp
 YOTcPpjB6CilNp3CEanxlnuTzq12uf7Z3ejKVloB9/wLpj7x9jwAAAA==
X-Change-ID: 20261008-base64-silence-clang-24-constant-conversion-b682c6bbf563
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Guan-Chun Wu <409411716@gms.tku.edu.tw>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3702; i=nathan@kernel.org;
 h=from:subject:message-id; bh=75s9Og1njdygxV8tnkbcGXlKjyNinTjM7/sgljM9zf4=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFnHK196bOqL3Nbwcetyr2kbOxn+8dbMUzzk634+kG/ij
 /+TZZtjOkpZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBE5rUwMtzanjU/LvPm8cmi
 aqK2tlJvXDe/NH3vt/PhJuPkhz3Nyg+AKvjcfu+ZJ7RF7N6ukwo1/PIXF32S2+N9qqAj/sb9O97
 XGAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent change in clang to warn on signed char conversions within
array initializers [1], there are several instances of this warning from
base64_rev_maps in lib/base64.c, which can break the build with W=e or
CONFIG_WERROR=y:

  lib/base64.c:58:18: error: implicit conversion from 'int' to 's8' (aka 'signed char') changes value from 131 to -125 [-Werror,-Wconstant-conversion]
     58 |         [BASE64_IMAP] = BASE64_REV_INIT('+', ',')
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
  lib/base64.c:52:2: note: expanded from macro 'BASE64_REV_INIT'
     48 | #define BASE64_REV_INIT(ch_62, ch_63) { \
        |                                       ~
     49 |         [0 ... 0x1f] = -1, \
     50 |         INIT_32(0x20, ch_62, ch_63), \
     51 |         INIT_32(0x40, ch_62, ch_63), \
     52 |         INIT_32(0x60, ch_62, ch_63), \
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  ...
  lib/base64.c:34:42: note: expanded from macro 'INIT_1'
     34 |                 : (v) >= '0' && (v) <= '9' ? (v) - '0' + 52 \
        |                                              ~~~~~~~~~~^~~~
  lib/base64.c:58:18: error: implicit conversion from 'int' to 's8' (aka 'signed char') changes value from 130 to -126 [-Werror,-Wconstant-conversion]
     58 |         [BASE64_IMAP] = BASE64_REV_INIT('+', ',')
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
  lib/base64.c:52:2: note: expanded from macro 'BASE64_REV_INIT'
     48 | #define BASE64_REV_INIT(ch_62, ch_63) { \
        |                                       ~
     49 |         [0 ... 0x1f] = -1, \
     50 |         INIT_32(0x20, ch_62, ch_63), \
     51 |         INIT_32(0x40, ch_62, ch_63), \
     52 |         INIT_32(0x60, ch_62, ch_63), \
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  ...
  lib/base64.c:34:42: note: expanded from macro 'INIT_1'
     34 |                 : (v) >= '0' && (v) <= '9' ? (v) - '0' + 52 \
        |                                              ~~~~~~~~~~^~~~
  ...

These are false positives, as the branch where the wraparound could
happen is unreachable with the values that clang reports. This is not
considered a bug by some clang folks [2][3], so silence the warnings
using the __diag macros the kernel has to workaround compiler warnings
when necessary.

Cc: stable@vger.kernel.org
Fixes: c4eb7ad32eab ("lib/base64: optimize base64_decode() with reverse lookup tables")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2181
Link: https://github.com/llvm/llvm-project/commit/a5ef934a8d295dc03be3960f2b3744ec2e53238e [1]
Link: https://github.com/llvm/llvm-project/issues/223923#issuecomment-6056856245 [2]
Link: https://github.com/llvm/llvm-project/pull/226775#pullrequestreview-5454407389 [3]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/base64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/base64.c b/lib/base64.c
index 325c7332b049..e46be3a55585 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -52,11 +52,14 @@ static const char base64_tables[][65] = {
 	INIT_32(0x60, ch_62, ch_63), \
 	[0x80 ... 0xff] = -1 }
 
+__diag_push();
+__diag_ignore(clang, all, "-Wconstant-conversion", "https://github.com/llvm/llvm-project/issues/223923");
 static const s8 base64_rev_maps[][256] = {
 	[BASE64_STD] = BASE64_REV_INIT('+', '/'),
 	[BASE64_URLSAFE] = BASE64_REV_INIT('-', '_'),
 	[BASE64_IMAP] = BASE64_REV_INIT('+', ',')
 };
+__diag_pop();
 
 #undef BASE64_REV_INIT
 #undef INIT_32

---
base-commit: 0c2669a9f4a1d607e7591ae50ccf3c432a0aff08
change-id: 20261008-base64-silence-clang-24-constant-conversion-b682c6bbf563

Best regards,
--  
Cheers,
Nathan

