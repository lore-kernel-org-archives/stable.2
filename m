Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429BA472F70
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105995; cv=none; b=V3aM4cRVfxoTi/IH1NFqZ3xXZBNHAiWBH0gfDE8yvY2MLXVh5u6XLRYWccS/0jkHM+5DrzGaQBDl8Xk6v2rznyb6uDHL8oxTd9Rs9IuJqO+vIRNc/OlpTCkOLFPCZyxHMPU4d9BxZOB9D4FT3TiEvC0ZqbOHkw+3zYCRgWTuAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105995; c=relaxed/simple;
	bh=PDu+3BXTyXpwPgVrtJxUe/m0n6DzpTg9MQ5tOKffmxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sH3UpJOYIpqDhGQkgQkaWT3fFOvmpbph6YbU2Z5d35q3ECrkEOhYI8QJk9ax8sK/JmZ5FVT3PdldVwmJuBSg83AlZ0Rof2LXsoGPWmPRJJQMDX755Vw7+70I/G4I6MNCvkoOGTQAmqPq77KpTqiDvgiJAVnt4QTgWIP/81tFM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Db1Is0pI; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Db1Is0pI"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so2007650a34.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 05:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105980; x=1786710780;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBpSBcnVEC7d3b8VCypHKN8KFVfSMJhdR2dxrFOJYmQ=;
        b=IdxvTvCQQx/1EkzSqMNWJtmi47TaG0FDPLPHpsdCC5ErxheNqlnfjTTTZnvhGgSVdi
         q1NOXLRVUwEajH2aZzLeA4FOohxZ2opwIL/oqLiknZ+t+51r/MnOS9l/NICZThWz9PlE
         VwG8IaQZb42iYKr0hkkVCaEdqsA/E/iWYSCnRZKAMFcKn4feEU421QAZZbHuBhsIZOl8
         Be5jnA1kCp0vb9yMiVrqCoBLAqFBAHXMbfN5MUCTeM1E9eq7lvBEiwCn9nTpxgs25P/F
         bOHppYUvYvwTjMO/VgPyUQaqRbkgfpKjviVkfFirQ66igykZ1tKSLI5jJ7N2iSSJmd4Q
         wKfA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4w8Ra7gUbyTGsU1FP9qO8sYyMh1sJG9hhYI6J61lIuy1SQRobfWQv7FmCOSnnM7mG0Kj8GSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1MuMsDcvBpdbUvxIR/t+QuvgaouYGgXEzUhvxUtkSomn6nJyc
	OloF9ElyOXrBHU0QS3hl7Gs0qqIJU1Y2wmAJV/w9gPlh697n8VJLm4SZ
X-Gm-Gg: AR+sD1322yKSp8Fhy3B4uBH33BgImWJocigw+4cQyapSA4Q0fYDpukd6R1KBYsuinE8
	O37fWEF7GQ/DKaa6YGrT9ElDk2K+aa35K3iW9g2Wy/tdMmCSs68+9tt7LdhssvbP9kyAjXrc5V6
	Axwdvpj5UxOvvS84//Bw47voFjGcjVgwfeHLftGLKz7eUulfmvbI/tT73tENG0xE6M9ApdlK9Nb
	aRPH1yjtquEjop59UgY9KWrC/4mtdOs1mQu//cfmNbnzO92z6W0U98uOBeLKWnDKfMSB+iRshf3
	it6KYrM84iiCc1Y/6Lymx/UlzVNA1bm67qQPRHWPOkCwrnrK9fxPzjt1tqnwNCxdf9kaYkgX4oh
	2jdSRrW3HsKHAc2UloP7+L6C7jQbd+lRIWL4UgOmjH3iuyYiXYakA1ETz9rvlb3R2QLND/mHqpn
	jXj4zUQjJc/JgXARd1xEdbt9co1lzJaHMMgZUztlsCCpGVAfT7hc5lfXMjTNQgm8s+b+mPdWrw7
	uS/1c7dWARjhXuY7UngEDOrZ3pbOuqMnUIbYB/M0aioLd9BY/CgSEpOIdHOHimt3mKR2eHaOZo3
X-Received: by 2002:a05:6830:67f6:b0:7e9:d3aa:e391 with SMTP id 46e09a7af769-7f1e5d182fbmr12781875a34.6.1786105980389;
        Fri, 07 Aug 2026 05:33:00 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b807227sm1141532a34.27.2026.08.07.05.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:32:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 802C760895;
	Fri,  7 Aug 2026 12:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786105976;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=aBpSBcnVEC7d3b8VCypHKN8KFVfSMJhdR2dxrFOJYmQ=;
	b=Db1Is0pIQ3dOMju6mbp/5O1REnHMBoPTWAqsfE0Qv0lrG5Q1cHjx3P2j+N9N9osDfB/WQ2
	TQU5aE36pTpS96xn6y7I7WthValEuCGlBp3F5PUFSBCJzCa/51x7MLnRb7Qn3yB1VqjGNh
	LMyM1Z5WQZzKUH7QHUXg+QSreZmP+zBXgdWiFRP2GB1pIJrWRHoSyFdvYZqW8HKnTWVRDZ
	fs/ofJ3nkYvNbRTU6ltnuoxxwaiLzsjsJvaQAKD37938LN5G2pLLsX9bVMe+mpQ9pnk5oX
	/l5ANzKpXlYNhRNSoaCKqh1OaVpf4dM1rXgze7cxz3+F33pVA73ZEzHzgqaIRQ==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Fri, 07 Aug 2026 09:32:43 -0300
Subject: [PATCH 7.1.y v2] selftests/bpf: Add tests for sleepable tracepoint
 programs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260807-selftests-bpf-sleepable-v2-1-f7e6566f36a1@marliere.net>
X-B4-Tracking: v=1; b=H4sIAGrQdWoC/4XOQQ6CMBAF0KuYri2hFRRceQ/Doi2/UoNAOpVoC
 HeXoisXupw/My9/YgTvQOy4mZjH6Mj13TLI7YaZRnUXcFcvM5Op3KdFuuOE1gZQIK4Hy6kFBqV
 bcEBbWZd7KVPBlu/Bw7rHKp/ZIRHJk1XvmO76ChOiGg+1InDtVWeaGFGIXFw0jkLvn2u1UazO3
 xaj4ILXJjO6KHaHDOXppnzr4JF0CFH9EPlvArK0Klc2E+KLqOZ5fgEA4JSwNgEAAA==
X-Change-ID: 20260803-selftests-bpf-sleepable-eebf2d962201
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, sashal@kernel.org, 
 gregkh@linuxfoundation.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1786105970; l=2967;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=QLheeulIJ7HGlvz8iFzvKmtgtUgQwyFXfWaZE6pfNsQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QI1sbqPaaYnCoqAVjS7/0CJAD6XeShanEL7075pmHQDoR8FTDMKYyPWGpnevcLGwjyZ+7e077gy
 AWSb2I+9WMAQ=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

From: Mykyta Yatsenko <yatsenko@meta.com>

[ Upstream commit 8a20655749c625dcc4debdfdeeaa0cf8bb85c203 ]

Cover all three sleepable tracepoint types (tp_btf.s, raw_tp.s, tp.s)
and sys_exit (via bpf_task_pt_regs) with functional tests using
bpf_copy_from_user() on getcwd. Verify alias and bare SEC variants,
bpf_prog_test_run_raw_tp() with BPF_F_TEST_RUN_ON_CPU rejection,
attach-time rejection on non-faultable tracepoints, and load-time
rejection for sleepable tp_btf on non-faultable tracepoints.

[ rbm: Removed hunks from (new) files:
        tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
        tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
        tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c
       These rely on libbpf's ".s" tracepoint section handlers
       (0cd420a6f40c7) and on kernel-side sleepable tracepoint runtime
       support (439ebd5b5708, 12628ffaf98b, 57918341dd19), none of which
       are backported here; kept only the verifier/sleepable.c hunk, which
       is correct and needed on its own. ]

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/bpf/20260422-sleepable_tracepoints-v13-6-99005dff21ef@meta.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Changes in v2:
- Dropped hunks which miss dependencies
- Added a small note about it in the commit
- Link to v1: https://patch.msgid.link/20260805-selftests-bpf-sleepable-v1-1-e29fa5af4119@marliere.net
---
 tools/testing/selftests/bpf/verifier/sleepable.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
index c2b7f5ebf168..6dabc5522945 100644
--- a/tools/testing/selftests/bpf/verifier/sleepable.c
+++ b/tools/testing/selftests/bpf/verifier/sleepable.c
@@ -76,7 +76,20 @@
 	.runs = -1,
 },
 {
-	"sleepable raw tracepoint reject",
+	"sleepable raw tracepoint accept",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_TRACE_RAW_TP,
+	.kfunc = "sys_enter",
+	.result = ACCEPT,
+	.flags = BPF_F_SLEEPABLE,
+	.runs = -1,
+},
+{
+	"sleepable raw tracepoint reject non-faultable",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -85,7 +98,7 @@
 	.expected_attach_type = BPF_TRACE_RAW_TP,
 	.kfunc = "sched_switch",
 	.result = REJECT,
-	.errstr = "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
+	.errstr = "Sleepable program cannot attach to non-faultable tracepoint",
 	.flags = BPF_F_SLEEPABLE,
 	.runs = -1,
 },

---
base-commit: 74b69060ba6e44e20c2e4dc1847eca21db6e4a7c
change-id: 20260803-selftests-bpf-sleepable-eebf2d962201

Best regards,
--  
Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

