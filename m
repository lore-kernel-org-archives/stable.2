Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150406;
	b=5OxjsUjLjPgRXeGtSNIgUD7ZTjNgJeKfTRm0IMq9JrAXECj+rqe4S3e47ku7pAnYQLyt
	 S5Xxoc6nFulMj9pmsMnRPJJF1TzahAwWwVptvylHxwXNVz05/QCx0UDXOUcdUBAGkhoe+
	 G3hqLhkEe83VS/28bTGkZW9WvnQxAKw9cZMGc9OTEo21qK3INNow3ajUgJeCejrwCet7Q
	 HNBsxvrTEU2jRkMv4M9ZjUufoUkuBVQy5DBl0SXNh5nLWKqPnY6LofYJFRHZK43WccpD7
	 Xz92gccZhL/MCc6NBF3Vojc4ukwLuV6PLfWcTZqa4/JOrQsG3/LB6YIQI4E+yDYYurA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aLduANwv1S0zzwppHfmO8Zkbjseh7UvsZ5j1k5QDDg4=;
	b=j5gS/1MTgM6rU2Edea/zlC/wuw1WXTTkhreq9/BRI24v6f68AqCiKm644Xm+iVpVhdos
	 XhDXyUSYIsxRYUDdy+Fgq3OnllvKWuNSZoqmkPnpzXaYMMm91zwCiy/xUXRM6/s2INg4m
	 xuWnk5K15/GMtod1uVlqhYc4SdYk9b/AdoHbttte9sivP94enJg3Gfg46B+E63OrhLzB2
	 TMDpo+LSSbY2ViwKwQnm0y9E/vsBL5BYK7T2y1vPPdJ9iCM9A/88j0VEuUMlSYMI1UHKq
	 UsEUteAI+aZ2htS1EXv6NWwRUVo7zWlu2RYA292tX560ymFqLjH0s9eugvunKZYSPJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cYuptatW;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562A606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 01:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3562A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cYuptatW
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso245323b3a.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793150405; x=1793755205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLduANwv1S0zzwppHfmO8Zkbjseh7UvsZ5j1k5QDDg4=;
        b=cYuptatWk3AIwuv9NVY3j83Ne4A61NfgI8j3FYTY6xXx/cFjxGfsLVtWCjrLpzKhWp
         25pnxHwRFPtQANPLPSGH6YnFdmPfUI1ByFIlZWoMnzHMztZ/lVvNe2lFch8ihM/BdsN6
         FNlOmF2TkRk+aBvX4uxxQfIaYJXgRnzmG2F5ajawitg5FWu9W7dR7yTKR7GC+WqhGEZT
         ETGOsO4n+ZVDpYbADgdtN5+dXKuTPl6KIeqfT6ijS9xdocn4JqhBpSZVnQixv+DE98XD
         ARMp0gSsgVtXbopws1pGy8qq5vbCPhsXYbXHbbAywwhPtySTAYQULmVzvZ3pHY3rdMA8
         oJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793150405; x=1793755205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLduANwv1S0zzwppHfmO8Zkbjseh7UvsZ5j1k5QDDg4=;
        b=Zt6mOncChWDMOKeCEye90gfpLDuS8SJf6AR2gPlT819ygHjW+mANeKXQ91A8/c5Ywn
         pX+wN3Koyz8Hau1DIAxKrekRqbY/RBa66nPjkFo6Q0t3hMZWx0/SMg0VAGkU5jNaHpAL
         WwVu60gFRRIpdVNf2PMiq7eu8XJO14wxpriGfZWpSe/iSxVng7CY8hj4hxmH7X33vpSN
         q6ZaFbh4YFflBVJy758sqxOv5XRye34FCPN8kGE5EWHU64VAsS1G5916wB4DbLpImdyI
         Gfh9p/yFMHMppgxcBG2MSUf1dRtBYIUgdLm5vMCaT33Fwa/TRdx4zqEr7cemikSvwiXs
         uVbQ==
X-Gm-Message-State: AFq9FYKC7CBN3PgXKBkJf4GbozQD2TnTPONhFQNBaDqlQT7FbBarIExg
	+zWQDREhlpx331TPlcbEdTlzMVQ6/TII1wxMYoH4hxXGqCw5GsmKQDL8
X-Gm-Gg: AYBFou2Dgc0rcKy6eaSzcGHq4GysYatAOO1MoKJ6TQJVFJFwk/LSmic5VFlzu4e048t
	49Zr6FQ72x6MGFpJ9ySxwtIfoWbhl6f0k6zG1p1jY+jtdkfC/NpKzJxbxw2dHWGVLsMKz2570UO
	xjhqlQwLPH6kARA+xZaOFXlpj0WaULGCVM0KFK3Q8e3jwD4NdSt99O+rKsZg267Lf5NLTyVoYcn
	yV5tzZzfsrnmJYpsUH5V7If2k1KaIIAc0GOYY742S0XM/OmeFv9qqsaq4YelG2+xZgNGTkwYI5z
	oeODnkWJXDwDmqU3cJrcBCeAEq2gfwkO0JJhG/BZje6AL/AHaWkxraoKta509x4Y6tnU8hQbP3p
	WY5pysT2m0KPhNih/v3MuxIvHk+nVlY7dukIEwmnKzJ06AsL+t93vww6OMuqcDIM8bAAiXQYUA+
	5pFHS09CqGnatCa6WTgSsydonVFsnXaZHx3TzRreEc2CtiJ67gjD0uCxRvPIyOXgUIa2CLGB0HF
	nhYEN492w8xyLGSh5I+zaVh5ZTm8vpeHBXIe5s0eTPzB0z1GJncF1kuVr1p8CXFRPvvM+CG1idf
	BXHjkaSEKxKwTRnsGuEPZa3CJswHDuK+Do1XfLB7Pkn/fgWaJg==
X-Received: by 2002:a05:6300:49c:b0:3dd:a197:735a with SMTP id adf61e73a8af0-3e902392eddmr613544637.51.1793150405474;
        Tue, 27 Oct 2026 18:20:05 -0700 (PDT)
Received: from localhost ([182.216.53.174])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc8f97esm3272997a12.19.2026.10.27.18.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 18:20:04 -0700 (PDT)
From: Jaewon Jung <jaewon8868@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/ftrace: Add missing spaces after ! in probe syntax tests
Date: Wed, 28 Oct 2026 10:18:49 +0900
Message-ID: <20261028011923.2050009-1-jaewon8868@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025075044.1750113-1-jaewon8868@gmail.com>
References: <20261025075044.1750113-1-jaewon8868@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing space between ! and grep. Otherwise, the shell tries
to run !grep and reports "!grep: not found". This always skips the
conditional checks without checking for kernel return probe argument
support.

Fixes: 25f00e40ce79 ("tracing/probes: Support $argN in return probe (kprobe and fprobe)")
Cc: stable@vger.kernel.org
Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
- Add Fixes, Cc stable and Acked-by tags as suggested by Masami.

 .../selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc  | 4 ++--
 .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 384209968325..70751573e8de 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -33,7 +33,7 @@ check_error 'f vfs_read ^$stack10000'	# BAD_STACK_NUM
 
 check_error 'f vfs_read ^$arg10000'	# BAD_ARG_NUM
 
-if !grep -q 'kernel return probes support:' README; then
+if ! grep -q 'kernel return probes support:' README; then
 check_error 'f vfs_read $retval ^$arg1' # BAD_VAR
 fi
 check_error 'f vfs_read ^$none_var'	# BAD_VAR
@@ -100,7 +100,7 @@ if grep -q "<argname>" README; then
 check_error 'f vfs_read args=^$arg*'		# BAD_VAR_ARGS
 check_error 'f vfs_read +0(^$arg*)'		# BAD_VAR_ARGS
 check_error 'f vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
-if !grep -q 'kernel return probes support:' README; then
+if ! grep -q 'kernel return probes support:' README; then
 check_error 'f vfs_read%return ^$arg*'		# NOFENTRY_ARGS
 fi
 check_error 'f vfs_read ^hoge'			# NO_BTFARG
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index b0e6b80ccb01..06efa67e01ff 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -108,7 +108,7 @@ if grep -q "<argname>" README; then
 check_error 'p vfs_read args=^$arg*'		# BAD_VAR_ARGS
 check_error 'p vfs_read +0(^$arg*)'		# BAD_VAR_ARGS
 check_error 'p vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
-if !grep -q 'kernel return probes support:' README; then
+if ! grep -q 'kernel return probes support:' README; then
 check_error 'r vfs_read ^$arg*'			# NOFENTRY_ARGS
 fi
 check_error 'p vfs_read+20 ^$arg*'		# NOFENTRY_ARGS
-- 
2.43.0

