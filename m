Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB640DFD7
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786192947; cv=none; b=BGEZpLb7rcANs6WiL4LIeDqw+j5vyNO1l0hjLzLw8xzTVvX/yo4ja0vtAu/eRGaLjgB5IS/gupqgo4URL/4oBSpvRWY/iFr+bg4gM4nW+dm8jRSXP0TA/I6EdH4DDH7NNTOS7qXwiciNfgcPQaA7/TwQwz3rjQzJiKtisLdvCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786192947; c=relaxed/simple;
	bh=MqwfpCfPpwUsLwz0eQR5bEDe0+77f+x/Tg6mBc1Kj3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OgeaLJVUaJvhXphIT7/B2C7wt62ZIWwib8HP1yzO0M8yEuz/s2AGKa3uTUJ1YQBsZfUAd5zRPh8G2+wj/qnnFiHL9GoeLu9cr1hjctDw0NYN2HDtLUNV70xK8tqmUCb4dIoR9N2pbeAohV8kZw1ETq7V/qyoeDyOc24XP3GGitQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=cd6FsAkp; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="cd6FsAkp"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6aaf3f54dbeso243556eaf.2
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 05:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786192938; x=1786797738;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M36Y4nsmek7mvOPX1W1gLnRACNnaeg9N6lEHl/R6IK4=;
        b=pyUXcLiWn6iEVs87Y+DQ2H5FTqnph/T4kqdEuK2aB1DVHLVRZM02mjHNSb2jWxdd0B
         +2Q8ZyHn7m9AWbcmxA/MboNBqEtda9AzMRIG2Jnz/rI85Dt4LFDALQyxB15kikxyqbNO
         THy/PKYeYNAtIIaFzSPOprG4eJq5ImBGOeT+tPa8BThspShDkcxwWhwVO0PpdV60gbzL
         QUwzALiadbTAjfSvr7fv09cQFY9WauEzRwRdmjVi+eYygIPjCqKzTYUvRuw/7qnZBjJK
         Zd4eg917O5EedY8k7yHtDzjSlsDrt/wwg/1GJ2zuXLzpgUS0cxEFK1edRp1xr8UyTee6
         CHdw==
X-Forwarded-Encrypted: i=1; AHgh+RqruEcvmwgtlIHXEQgRwBSXNWlrXFHXxVkUWM29Q2bxiguNWBrVVNvWMQDeQF3el7UhaQHeqR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSrR5nvhTJ9LjPmdANli472wxEgWHm2yPTizN43zdn8v3Px3B
	fx0l+f7puNKg8WbgxqD1LUJMbx7ZKA9vbgvDvHAHwullY5YSFjHJ7IxZ
X-Gm-Gg: AR+sD12djOpXdsTWQ6Tt9lb52bvgHOEhgzYZbEcMfpzPNF+F99ICz/4dQfpTqXm/DoZ
	rcVypVHY5a7gLrIjlIhIfhHFXLkR6Lbkk0gODsvlAsIbTdeRrqF0K0kdwzVqqWdlvIHvIrOMy7u
	JZSJwfgDBbKKBjwqNM1Ty1XD9iSuxcft8VO5Mmk0zYoRewzDKB2Lmmz56EOb4iYzNWS54jf5+BP
	1c3JGJmsKom943h7iulohg0f3N14BHffEyK2dqazhSmcKiECMiBGPdAQIdSWt81Z7iq7Kq0bszh
	iWsEFf4UwziTaFgJOR7UB/29/1w7epPW4Cq+riuDXTa5+CHgZFbQKOcD91uTvIxpWOOqZVu8df5
	dI4x5QiPwrDagdVhqnB4Ph6axFDWStcmNJiipMnezH610OUozk+KX5DGjf43LjPNDzNjlqK/Unl
	g1jx8nHjD4qbQHjXIRuf+5Ykc0fsbizCejCOF5he2wHESADsEAMpomfafqwt+U79BuwOQwVbOiD
	vWDb5hy6VCD69CaVDyAuK7AIAubjpLG2SGSR0Z2MmHIvC1b76eZhGkTNCcQ4+nPdg==
X-Received: by 2002:a4a:ec4c:0:b0:6aa:8fb6:b951 with SMTP id 006d021491bc7-6b0420b728fmr3347539eaf.19.1786192937673;
        Sat, 08 Aug 2026 05:42:17 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0512521a1sm985611eaf.5.2026.08.08.05.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 05:42:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 547AB609D3;
	Sat,  8 Aug 2026 12:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786192935;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=M36Y4nsmek7mvOPX1W1gLnRACNnaeg9N6lEHl/R6IK4=;
	b=cd6FsAkpNabpqwn3VQV1TiAyPcc4Jtj62/EiQMLpbpzwbM1s8MOChMrefIJ03ZELyAnm81
	wP4f4VjXMkPS6wAuY5SjWQGdnwM/cum+T2yrjMmOOoUlwNiaFBrpC2/a/du2wuwNPLqYex
	bcSM0Awl3RI6hFlpvpKfbKIldNIAU9nYluNAqomckLrafrbY3iLZOPc3cGWFw6N8WXR3V6
	vC6I+hGk6DXnSUduhUDmX8LYJ8zxL6Z8XyKxYwR+DTZp2wo3PUsLZkNnmfKHHqY+HsGmPF
	sbNnDTZwMf37xLprVgqzL4JVYjY0sLCdV9Fs/ihPdRJmi5wXof2JmqKf4ppRUw==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Sat, 08 Aug 2026 09:42:11 -0300
Subject: [PATCH 7.1.y v3] selftests/bpf: Add tests for sleepable tracepoint
 programs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260808-selftests-bpf-sleepable-v3-1-45ace406061a@marliere.net>
X-B4-Tracking: v=1; b=H4sIACIkd2oC/4XPTW6DMBAF4KtEXtcIGzCQVe4RdWGb5+CKEuRxU
 aOIuxeTLKJISZfz9+nNlRGCB7H97soCZk/+PK5F8bFjttfjCdx3a81kLlXe5AUnDC6CInEzOU4
 DMGkzgAPGya5VUuaCrddTgPO/m3xkdSayC/u8tenHfMHGpKZFowncBD3aPrUoJi4Nek/xHC5bt
 Flszr8pZsEF72xpTdMUdYn28K3D4BGQjYhJvRPVewKydbrSrhTiiUhPzPIxTf2akivlaqhKKVc
 oLZ6oZVn+AFHmFsmBAQAA
X-Change-ID: 20260803-selftests-bpf-sleepable-eebf2d962201
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, sashal@kernel.org, 
 gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Mykyta Yatsenko <yatsenko@meta.com>, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1786192932; l=3439;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=g58F76qg6k8m7EjeGVVW4PoJeUMQe4Mk6i/jWW8k71c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNqHo6RdztrUIAQ7hx/DvsItndW3x6XAEWkiIwCVLPeOSSFuVZozMAvs7d2/J4IDxRdj08w6mMc
 pNyUetMFJ7wc=
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
Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
Hi, backporting commit 23b933c6223f ("bpf: Verifier support for sleepable
tracepoint programs") without backporting this commit breaks the selftest,
as seen in openSUSE CI:

https://openqa.opensuse.org/tests/6145723/logfile?filename=test_verifier.tap.txt#line-780

Changes in v3:
- Sign off
- Link to v2: https://patch.msgid.link/20260807-selftests-bpf-sleepable-v2-1-f7e6566f36a1@marliere.net

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

