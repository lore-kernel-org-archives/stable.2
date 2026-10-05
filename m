Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C374AC159;
	Mon,  5 Oct 2026 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212847; cv=none; b=h+2eVy8vuNZTxvbpDxbUQRWKuc2PuKzGNOLS20zIPv7GL+Z12661lZCTYBWe66mHAftm9b+uImokhT5rh1eOq8QgCSTzX+2W0mk7F7VFKkARk79/X8xmUByBB3DYjTmwFxp9KJeHmUX1KRQF7d9IWYHtqJk9k5vm/7dcBIRmzA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212847; c=relaxed/simple;
	bh=ttQIPD4rzczPc3xVN42irelaltqxUbWd51TEoMrrXDE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=YZz2Y8P5Wj1Z/+rQEXEyF2UOveKSd5mWuSlYdaUYKsE9wzyYB6qCX746SzYGcrdfefnuWWIplz0H+g4SUIcJ5PXaGBDaB3g3UrQufsRFG/q5G444+TGBmUJCRMX1yCBcX/hToBwDxoN8FpQWvqbRw2QR9mbjjLPZ0B6O0kL9OZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCzWhW1b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCzWhW1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E4E1F00898;
	Mon,  5 Oct 2026 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212846;
	bh=sMYN97Z+frOkYiPsO0JmcWAdF3xwsiKaF8nH+9JQ/8g=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=WCzWhW1b2guG2oFCZgarEILepjquzCU1AUc5LevKJLEE5SNhdfMnT8PbLnUbrN390
	 wV2GJpE5SnoHlYBYW1ekrodKVNiGI/lubX5K3o8lTD8ZPQK3eRWCQCVNimEvMCQeVn
	 1GCjkm9vZLNiZuMXXcZXYiTKqcRoLZxagQIZAknmXJsKqBpkubFrsRgKbKcOVLARp1
	 X0iSMSRICJmc2D0qD1cAGpYsr/JDCTywBGvk0i5jYmO8ELLw9uQYt0XbYotQGAG1AD
	 rnAtt3mDb6WPtJT1jRU4w/XuBA7PiIh2rJfOn5MURNM486hADEe/kCounj13SSq+8B
	 IFxnanRNLXAaA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] kbuild: Makefile.lib: fix offsets generation with
 debug info
From: Nathan Chancellor <nathan@kernel.org>
To: Dmitry Kandybka <d.kandybka@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260928105330.25427-1-d.kandybka@gmail.com>
References: <20260928105330.25427-1-d.kandybka@gmail.com>
Date: Mon, 05 Oct 2026 17:07:17 +0200
Message-Id: <179121283718.1159753.6553387125743720689.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3547; i=nathan@kernel.org;
 h=from:subject:message-id; bh=ttQIPD4rzczPc3xVN42irelaltqxUbWd51TEoMrrXDE=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFmH96p/O/X5gLvS8Qomz/+7Zrj2nXs6ceIG/axHZxde+
 evKlPdMvaOUhUGMi0FWTJGl+rHqcUPDOWcZb5yaBDOHlQlkCAMXpwBM5MpVRoblF7Z1fVMQeTbn
 iaQY38tvgZ6N4Q73Y8/Y9hrdyTnvdE+PkeHpmfZ9GxzMC3WiA5SkFiqcaZT6/YP/b0y79wSp3f/
 /TeMCAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi Dmitry,

> When debug information is enabled (e.g. -ggdb3), the assembler
> output file (e.g. kernel/sched/rq-offsets.s) contains additional
> directives such as .ascii with offset info and debug metadata.
> 
> For example:
> 
>     .ascii "->RQ_nr_pinned $3048 offsetof(struct rq, nr_pinned)"  #
>     ...
>     .ascii "->func); __data = (it_func_ptr)->data; ((void(*)(void *, pro"
> 
> The current sed-offsets macro uses [^ ]* to match constant names,
> which is too permissive and can match unexpected characters when
> debug directives are present. Additionally, the fallback command
> 's:->::; p;' strips '->' from any unmatched line and prints it,
> which causes debug metadata to leak into the generated header
> file (include/generated/rq-offsets.h), breaking the build.
> 
> Replace [^ ]* with [[:alnum:]_]* to match only valid C identifiers,
> and remove the fallback 's:->::' command so that only successfully
> transformed lines are emitted into the generated header.
> 
> Fixes: 7dd47b95b0f5 ("kbuild: consolidate redundant sed script ASM offset generation")
> Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
> ---
>  scripts/Makefile.lib | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 0a4fdd8bd975..32251eb6ca33 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -493,9 +493,8 @@ quiet_cmd_zstd22_with_size = ZSTD22  $@
>  # the .ascii directive whereas GCC keeps the <space> as-is.
>  define sed-offsets
>  	's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; \
> -	/^->/{s:->#\(.*\):/* \1 */:; \
> -	s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
> -	s:->::; p;}'
> +	/^->/{s:->#\(.*\):/* \1 */:p; \
> +	s:^->\([[:alnum:]_]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:p;}'

Sashiko notes [1] that this results in BLANK() being dropped, which does
not result in any functional change as far as I can tell but it does
kind of make these generated headers a little harder to read in some
cases. Obviously the default fallback is what causes the problem here,
so maybe we can change BLANK() to include something that we can look for
like the name of the macro? This diff on top of your patchset appears to
keep the generated files the same while resolving your issue.

[1]: https://sashiko.dev/#/patchset/20260928105330.25427-1-d.kandybka@gmail.com

diff --git a/include/linux/kbuild.h b/include/linux/kbuild.h
index e7be517aaaf6..945006392cde 100644
--- a/include/linux/kbuild.h
+++ b/include/linux/kbuild.h
@@ -5,7 +5,7 @@
 #define DEFINE(sym, val) \
 	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
 
-#define BLANK() asm volatile("\n.ascii \"->\"" : : )
+#define BLANK() asm volatile("\n.ascii \"->BLANK()\"" : : )
 
 #define OFFSET(sym, str, mem) \
 	DEFINE(sym, offsetof(struct str, mem))
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 32251eb6ca33..96c2ec50f06e 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -494,7 +494,8 @@ quiet_cmd_zstd22_with_size = ZSTD22  $@
 define sed-offsets
 	's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; \
 	/^->/{s:->#\(.*\):/* \1 */:p; \
-	s:^->\([[:alnum:]_]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:p;}'
+	s:^->\([[:alnum:]_]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:p; \
+	s:->BLANK()::p;}'
 endef
 
 # Use filechk to avoid rebuilds when a header changes, but the resulting file

-- 
Cheers,
Nathan

