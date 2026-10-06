Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3E39CCFE
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327148; cv=none; b=kVAdnVhoQ5fdOv7biMb+XHs02ggQuzHWmTc3ySWCmtlsGsysnJCsf4KAtLplyjt8iaHf5I5lS8YtAcWKdagUUmkMueezCx75ge2YtVIR4/vnPRFSY3JkLjTL6HAfDYI7Ov/saczXc7wvTbfJrgK8rC1dZ07juvOl/SeFbtbwvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327148; c=relaxed/simple;
	bh=pFTkUMk/rZ+bcDA0dNreWXqO/ymmW56hA2wPC8A0SUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFSUf0yjRdJc0Gb5bt+ha0G24zpCn/spkln9q2RPxdna8HfbtP5lqEMfx+TABUizGxNC0lnDxKJozeu3EgaiQGBztW8RPqe1szhppXk2O1MNp1IAv2LBjVKuMTwiqv1wM09R72a9MI3oYA2Pi96qjvA7HyebWLkOlzl57MjwqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=HEXJrWZn; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="HEXJrWZn"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-49dfaa16190so952587fac.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 15:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791327147; x=1791931947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VPdIVaXesRNcKlAXCOjj3AwAY0KkqhBFBWxij3ZELec=;
        b=HEXJrWZnCVzML/4nQOkSbzEeQszW1PFvDhMzKeJpilHYncWrYzZhdHfCpCPYXCHbgZ
         GE2MtdcQibEbpodKhu3snvcc2TyZMyPj8t03FfVvF11TilRHC6MEsaAQGQSjYT/CsxYS
         F2R2F86nETkHHmd2sz1QLdJfkFC8HqMIYlTOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791327147; x=1791931947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VPdIVaXesRNcKlAXCOjj3AwAY0KkqhBFBWxij3ZELec=;
        b=qQHiKcfTOsbKUW1h5IPwrjdIfzy84v3SfBj2OjrJn6QYvv4YnjVQxUWPyFVIx3op3D
         hM4z3ox0XUamLhM5fadQhAw2xtjJXmlNzOg9V5IBoDT4eAEUjYUKoukDmpE5bAm4BwrA
         Q04X3r+hhAwTnL7BLcBTWZWll7F6Vv5IiKRl0sOcB7vHJRKZsfZfFUhCbeIJfWWnKUn1
         u1rHO+OlV3adzSiC3wyBFuqEG1Mu4y+WPX5iqYvsmQSRclKyJNgA/CAqq0gmJ/ri57r7
         rn0HZVYjlnfi0unj0mz/juh7O8IZfsuS8QXGq3hR4Rf2CkDqjq+0wTHL4QkV89FCJyqF
         x3mQ==
X-Forwarded-Encrypted: i=1; AKwUvBzA7wMF9DStKw6FRS0ibc37WhC1BuxeOMnLc+2iM6S/GQQn7RuLAvQyQ2C8FYh5JGoAsUMPU9U=@vger.kernel.org
X-Gm-Message-State: AFuF++kQqe8c7UJkheXFrkFhYJP6jELwrQUqtC1YXvZf+1/MCVcJnSh8
	DjhhIiUcnqu4O8xZe7KhBu5naFCKebdTbmHG1BJ10QGJixbo3mHDsuyPh5mkdmZVsEU=
X-Gm-Gg: AYBFou1jvy27u6vQ9OOLvA1wFYmMYsmj/NzrKNeSrz7k6d7Kejgmd9fcaGU7YLFoth+
	ddHF2aUIMYgxUGsMo33edIIsuSctFkSrtElwP6fNVsPr1bIXYXaB3js9QUEIg3hfk0Lf+PvPLiA
	RDcFZ86a3LIsRxeGpn4tPq28itiI+NCOxf+XsLnAjTUtNF5vBVRXztQQRIHbRSp6vOQm7ecwDz2
	7TgGq6eTPnkAwPVlBgOA0rKuRiljnUzVgR0QkfzwKXNpyfGeFFzHqdV466ZzNwRrEwPb9RhspOw
	PZW2DrLtJC+L6u1GjMeYmgb3VpcW/pyCedWVUP8DQyylUNB0N/vaudnWieCel2giQudbJMrc8bW
	FxM4OnBkMHRlH2JA05J0A+HssWOkbXigIpWaCJjusHSGx6n/q0slbYuGwKHcFnhepfxKPVRfphE
	keuxPOzXWvdajgLC5A/G91322uUo4cdVkqEI5wexphAmmufJvfVJs2o7FNivmnzbDdex9LmxrA+
	AID93LpKGtholqI4bnjptql48i8Wio5dZyV1hLsE9GB6WlW8O7Xb7ZvDj4EdWFM5BfnrUgxu60=
X-Received: by 2002:a05:6808:3c47:b0:495:ce6d:7d48 with SMTP id 5614622812f47-4fc44b3f7cbmr587506b6e.9.1791327145807;
        Tue, 06 Oct 2026 15:52:25 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc49a71636sm583940b6e.16.2026.10.06.15.52.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:52:25 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Validate user addresses in faultable buffer copies
Date: Tue,  6 Oct 2026 15:52:21 -0700
Message-ID: <20261006225221.54513-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syscall entry tracing runs before the syscall implementation validates
its arguments. For a size-bearing user argument,
syscall_copy_user_array() passes the register-supplied pointer directly
to __copy_from_user(), which assumes the user address has already been
checked. On x86-64 this can copy mapped kernel memory into the raw event.
An unprivileged task can open a task-bound sys_enter_write perf event at
perf_event_paranoid=2 and disclose that memory with a write() that even
fails with EBADF.

Use copy_from_user() for each actual array pointer. Use it in the default
trace_user_fault_read() path as well: the original syscall-array tracing
implementation used that path, and the helper is documented to use
copy_from_user(). Keep the existing length limits and per-argument fault
handling, so valid user data is recorded as before and failed copies do
not contribute bytes to the event.

Fixes: b4f7624cfc94 ("tracing: Have system call events record user array data")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 kernel/trace/trace.c          | 2 +-
 kernel/trace/trace_syscalls.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e4a490d3d08c..07acbc44d99c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6263,7 +6263,7 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 		if (copy_func) {
 			ret = copy_func(buffer, ptr, size, data);
 		} else {
-			ret = __copy_from_user(buffer, ptr, size);
+			ret = copy_from_user(buffer, ptr, size);
 		}
 
 		preempt_disable_notrace();
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e35744049e3f..d9190fdc030d 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -683,7 +683,7 @@ static int syscall_copy_user_array(char *buf, const char __user *ptr,
 
 	for (int i = 0; i < args->uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
 		ptr = (char __user *)args->ptr_array[i];
-		ret = __copy_from_user(buf, ptr, size);
+		ret = copy_from_user(buf, ptr, size);
 		args->read[i] = ret ? -1 : size;
 	}
 	return 0;
-- 
2.53.0

