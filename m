Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1E3148D0
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782169289; cv=none; b=ZIUIKIKwC1I4Z1D7F13/3toxoz/vVVGJbFXDGv3TRh5dXwc1nMbG5iG38Z0mVvWGGHtPKT0hMLRCLXhK5ZmFG0XXa8BLwQxXUVWF9BmM4K99QLlmHxVoIb9Xiwe0IyPvzgxwTp1wpUQacwJeQH1ej18gRaWiIBGEOAcZNurHp60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782169289; c=relaxed/simple;
	bh=AY0KwQ4uOXbD9Hbywkfxc8PNp9Pydpf1VKVhjJyGU+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvD6i8zU7AHMGS6b57APzdy2a7W1eC/lys5GA+XJy3eszaGOfQhUxAqPWn/UMVPfXniZhNPVNP4BOJANLWL1UDs73NuMXZyUOL4AmbBiq54oXHQ+BcHs/2iR5q0U5qsaPWsjCDR0jX4scDwIcZMP0HtCQkM+N24+ApG6zo3D7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiTRBng4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiTRBng4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso3441945e9.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 16:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782169287; x=1782774087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMJlbIB7pXSZcrQfPPwy0Yezg5A38/CdVpGKj5pZHB0=;
        b=TiTRBng417C0+eIglfcvBswRl9l+YNl+EKfYxUBYV/Bey1TtQ1Fzk5bCXYSPyHemnA
         po2rXEgF4qCKoOI1FQfOVS4BaOuKT0RXL7Wh7VWBT62U8B4jCZkYY+RGE+f1B0CcWrwV
         YtPvQTx1JRDRn8VokrSkKtpQN65liUGGGLHAFc63jPPhaiN6rwpJjPhiWSBOh5vWBq5a
         1rptsnCL6sYA75O0557QuVtwNxLZR+4MtR/1GTchYx+nuQ8PYT2HTAie+0gVXU8JZHyA
         9qWndTdcpCN/Zg2Mvetym70Lhd+ElkXAFJxtiioDwe2TRRzXQ9vKaQDnq4IgtWo/DLVj
         9iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169287; x=1782774087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KMJlbIB7pXSZcrQfPPwy0Yezg5A38/CdVpGKj5pZHB0=;
        b=s34x1WYuQHWV1fkq6p096bBd9RueV+/ObzZNmmn2sheyacAaLu64X/Hc2J+2/LAXRF
         RK0DKy5bKRSGd4SUr9Z/lkr953HG1LvRyt48LGmAitCq2neupt8P2GC7TDDi51p/TtU4
         PGt9429hfDO4texOZtS9UJjV+HwINb6FRQtjLGUfW/R9gNOASAw+IjUd75eBaxuWSzSm
         UvWfgsJ457jBsKwZHPNTG9xhW4yKEnALGj8oA6uFO1wX9+t+U2e1DCklkWqj9PDM99fx
         JxK49fZ4jmw243KID7NhzFx8cbheNO1x7+TP9rF+Io4Gs3Jidnhw0zNnJ42ZYqkIzjVS
         M+lA==
X-Forwarded-Encrypted: i=1; AFNElJ9nsONBQvdN4iKFeeEWHoO5m6lT1Aen2jgJzSfZUiWnOHUcwMqsMdU76ARjk9g0VnKzXN0XwCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXxJJ3L9smpuk7FoWqtwiyUMzhDg+jbn8XzhKzRhEw+gM8oc+2
	RH8ynE3RaAhYl7ckX7GsQiiIs32Duj2o6Z997rR54bAsGCJQxgceiZg=
X-Gm-Gg: AfdE7cnyiUqy2P6D9uXPjMM7nc+SICVrUFnorEYe2VTb26XhtOaupLO1Ir9XJbqObrl
	dHUYYkYl9jmXtwH7d3aNejZvMlUV9SEkhspan1frbF+UOV7GEWP283Y1uXqTuizAEWvmFXR8InA
	aGuPRZsJhgFdfPdQ1Z7hCHbpiSyBZ0Mo/xB7v07EzjVaqBYCq0Icsqwgv85UUQoz8wW1YqjUlUS
	a22ABlREOO/BEJn/nbfu1QzWx2V4r2lOQ7gl6atC66cLKIgi++hQ6YhQ8A68m1hY80k9rykPSHB
	fmtAPyfbf66e6np1pZyBJQoVYO1vM8YuqLYhsSecRZcBRyfHbzSrdhH4a0+BeCO4WQou1ciNjnY
	+jSQx9NW5/wfSJ83/Kjlq92dJ4lWAUqDVppQ2KdR1P3I3kDJPkxqyBRKWgA==
X-Received: by 2002:a05:600c:480f:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-4925a0c4f1cmr10788635e9.13.1782169286603;
        Mon, 22 Jun 2026 16:01:26 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fa34sm371339255e9.5.2026.06.22.16.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 16:01:26 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH bpf v3 2/2] selftests/bpf: Add test for stale bounds on LSM retval context load
Date: Mon, 22 Jun 2026 23:01:23 +0000
Message-ID: <20260622230123.3695446-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622230123.3695446-1-tristmd@gmail.com>
References: <20260622230123.3695446-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Add a verifier test that catches the stale-bounds issue fixed in the
previous patch. The test sets r6 = 0 to create known bounds, then loads
the LSM hook return value into r6 from the context. Without the fix,
the verifier intersects the retval range with the stale bounds and
incorrectly narrows r6 to a single value, pruning the fall-through
branch as dead code and missing the div-by-zero.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 tools/testing/selftests/bpf/progs/verifier_lsm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
index 2f8103bfa14e..c724bf389f5c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -197,4 +197,19 @@ int BPF_PROG(sleepable_lsm_cgroup)
 	return 0;
 }
 
+SEC("lsm/file_mprotect")
+__description("lsm retval load must reset stale register bounds")
+__failure __msg("div by zero")
+__naked int retval_load_resets_bounds(void *ctx)
+{
+	asm volatile (
+	"r6 = 0;"
+	"r6 = *(u64 *)(r1 + 24);"
+	"if r6 == 0 goto +1;"
+	"r6 /= 0;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3

