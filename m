Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A416F26158B
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046995; cv=none; b=Z6FPmxin38lLCN8FR0OudPHtMafddavBHW0O5I9aToqiafkJyxsLvsWP5W86pLrbXckptSXRsReB4Mgrgvgc2V3cYZSFBPsqcsJcCqkkKMAVtLa51/HtPWmkYU9R9J7kSQFPmBxopDG6iyBEpQ5yywbfVnCyY15wuElVxNbcoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046995; c=relaxed/simple;
	bh=7ibTghDomdFK+AuRMk66RXL/ZL3+I70CKoequsSTJ6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QKFeVV4L/bOhHAacpXx6BNNogQXLCsBIad6cWv1OE9kY43v05UWDZJ7tddeWXGnagK/Ae0SxskSQiEB0wajKyUSFQx75+KZ7WcZJnQ+RopXA3YuxaN9pPKLxMIU+oXc4Ob4SP5wKm7GKYvmtTsnyCDy7LZqDruf366CcpJMgEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de; spf=pass smtp.mailfrom=swine.de; dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b=Fw7sjZAb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swine.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b="Fw7sjZAb"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4998590d392so46219685e9.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 02:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swine.de; s=google; t=1787046992; x=1787651792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8fXTVcuANg8HG1Ctn5Fy42Q/TSh5wfRVcnMZYRYvZPA=;
        b=Fw7sjZAb/Psmzxp+ewF4YVgm5lyY/FyXUmT6DTcnsR/Rf3yOrmq4oFDXOo2GQUfV6A
         A5IKQpnp4AM+uvXRmHWuwxMmSxZqTmh/kvchNpbmjV+3ynAlKdsy94lePD0cZ121x8ZA
         k1s2nSsYQWFh5K7Ji24+Qri7141s1VyZGu3IfeMJ6VmeeynPgmjVvmoK0PqpU2CnkkvG
         +ZCJeuUcnnG2tGWpK56467QDJc4IN5hRPrFPcx9sndsl5FFHtFyUAjRTgE5PDUHCyoOS
         rHINOzHP0a4dCeHlx9hmDxn/GiBHcCV4T+1ixjEUKsrFL9C/8YRYDqm7381dmUyEfhXX
         VeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046992; x=1787651792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8fXTVcuANg8HG1Ctn5Fy42Q/TSh5wfRVcnMZYRYvZPA=;
        b=couXtyrKqu+IhI7zzOODT/FOROk5rOMkZf0ThT1cFuUPW1X9iH/H5zdkuIXVMclrfq
         dTlzjvXVvf4d0X4H3Qa1IL3CIrKxrPY6yt+Su/SyrXxaczFiD+USMmnPPZBkT9r3ElZn
         sSuSMP/azHYGNOd3je6w515Ao8Fj5qUlAyGeCQHt3bpA6tp9FmHLe7tz0hzMvo2GNEPV
         CMAJDZkA4eA8Ok6JKJnNi1CHA2VH/IOaDleQWLL/PnySxTvBOs7GyfddmFIHnNJwsDV0
         Y6ABtbnHyqaEtjDBlE5y2Va6DKOqyUn2Pwzql5n+iF+4mhrSEgTiAPDiEZUzaE0GrPT1
         yuzg==
X-Forwarded-Encrypted: i=1; AHgh+Rq8m0YKKhfxXS/NweejQiSlILjHLu+kHbD81YNYv5w5hJKYWySzEvTyPG/iiTT/P7aVBGvXhhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAlM71OGfpMIPUpLkz/wFQt5E3tAOUu7dhE1LgmPUrp7rZ/uCk
	hzQKwyjzYBBNrKNuTr0MKYOowhTbQ7zsHro50pt2UHbXPUHasZL8zJfNfAU/iuTxYrA=
X-Gm-Gg: AR+sD12nwFL/z6oNI5xhOolq8FNB4fIo7fpjbsKFwvNiVQN5mp4UsG683223qu23UzU
	AE2+ZfSD/iyQVuhKXHbFHNN6wpZ9VF1y7ruQmYAsVWxjzcWZm1cFzFmipx46JGOvYDHDUabFZGX
	N/9wjVcgLU53JxfHRO28xOMHRO+Jb79rzZk7XooZ+ouGDHsfBXbRgpbMZNrcORa2DynMHBSrC5f
	diY9ohbnFIiM4/fF3SwboiLBXWwc27gmyZ7WMyF/mC7AySsRfjTLoM3DsQfhepfNQWvmzehRWPA
	zQ0Oz61+1f+0tkGrvP6XJrpNZFlUyt8Z6Bvc9tGENC7b+ylYNgBd1HXteNwSJQ3IofhkRdy/kb9
	l1ote64wgC+AZ9ts8tVGx6ftzQkt1ZqRfVWf6pFzGMFg67yyW0DFhX2mJH8BUfPmCC+FxzYWD0h
	LksarlV8NGSDyYxBNtR0bATLayXbTdkFJdtcFgwgDROmIHLc7RheLElT9utr4E3xwoBhD0/Yuw7
	CmhAw6hr66PLA==
X-Received: by 2002:a05:600c:848e:b0:499:8156:cd3f with SMTP id 5b1f17b1804b1-4999fb3f78bmr120150495e9.8.1787046991876;
        Tue, 18 Aug 2026 02:56:31 -0700 (PDT)
Received: from christian-gtr9.tailscale.swine.de ([2a02:6b67:d11b:4200:508:9a18:a3aa:3270])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b81748sm10780123f8f.37.2026.08.18.02.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 02:56:31 -0700 (PDT)
From: Christian Simon <simon@swine.de>
To: bpf@vger.kernel.org
Cc: Christian Simon <simon@swine.de>,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	tj@kernel.org,
	yonghong.song@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH bpf] bpf: guard classic uprobes against private-stack corruption
Date: Tue, 18 Aug 2026 10:55:39 +0100
Message-ID: <20260818095545.314358-1-simon@swine.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eligible BPF programs use one private stack per program and CPU.
bpf_prog_run_array_uprobe() uses migrate_disable() to keep an
invocation on one CPU, but another task can still preempt it and run
the same program on that CPU. The second invocation then reuses and
can overwrite the first invocation's private stack.

Protect each real program invocation with the existing per-program
recursion context. When the program is already active on this CPU,
account for the missed invocation and skip it. This matches the
private-stack protection in bpf_prog_run_array_sleepable().

Skip dummy_bpf_prog before acquiring the recursion context because its
active pointer is NULL.

Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
Closes: https://github.com/open-telemetry/opentelemetry-ebpf-instrumentation/issues/3056
Cc: stable@vger.kernel.org
Signed-off-by: Christian Simon <simon@swine.de>
---

This is my first contribution to the BPF subsystem. I reproduced the
failure described in the linked report and would particularly appreciate
review of the recursion-context handling.

I have a reproducer, that this patch fixes, I am also unsure if this is
something that should be part of the selftests.

Tests: https://github.com/simonswine/beyla/commit/20c9912a02c5d5924c992faf7ee353c7d71c9fa0 


The analogous uprobe-multi path appears affected but is not addressed by
this patch.


 include/linux/bpf.h | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..11e3d7f00543 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2572,12 +2572,20 @@ static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
 
 typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
 
+#ifdef CONFIG_BPF_SYSCALL
+void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
+#else
+static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
+{
+}
+#endif
+
 static __always_inline u32
 bpf_prog_run_array(const struct bpf_prog_array *array,
 		   const void *ctx, bpf_prog_run_fn run_prog)
 {
 	const struct bpf_prog_array_item *item;
-	const struct bpf_prog *prog;
+	struct bpf_prog *prog;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 	u32 ret = 1;
@@ -2635,15 +2643,30 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
+		/* dummy_bpf_prog has no recursion state. */
+		if (unlikely(!prog->len)) {
+			item++;
+			continue;
+		}
+
+		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
+			bpf_prog_inc_misses_counter(prog);
+			bpf_prog_put_recursion_context(prog);
+			item++;
+			continue;
+		}
+
 		if (!prog->sleepable)
 			rcu_read_lock();
 
 		run_ctx.bpf_cookie = item->bpf_cookie;
 		ret &= run_prog(prog, ctx);
-		item++;
 
 		if (!prog->sleepable)
 			rcu_read_unlock();
+
+		bpf_prog_put_recursion_context(prog);
+		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
 	migrate_enable();
@@ -3208,8 +3231,6 @@ static inline bool has_current_bpf_ctx(void)
 	return !!current->bpf_ctx;
 }
 
-void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
-
 void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
@@ -3538,10 +3559,6 @@ static inline bool has_current_bpf_ctx(void)
 	return false;
 }
 
-static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
-{
-}
-
 static inline void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 }
-- 
2.54.0

