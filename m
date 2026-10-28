Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202244;
	b=FDD3q509ff93/7Yg103AoNvudYbABfphI4za5apeHRr4BW3E6eIa2qD4Itjkseba+HYK
	 Q0gt7d02Psx4NNpIrdT+22oMVk/aAlHcn0k2+mSlB6Sq/El4VuamwVdPr4cXDPk6DHUmi
	 T7VdvgU70t//oFN98uYHEpsEXXND6xIpVV78b0xe7GvPwp9whkIG4SkKBSFEs8g9DX4Kw
	 mp766ve4R8NtTv9pRQm0yDVlLT8b5hpys7Wx2xtdd0OaWa9/3pbu2Rfh9nLHulQRHhTdW
	 zl3p6TA1vTQ5pJT/FSyJPN1DnFkaDF2mcSZhmHXLeJAXQe7sXcYwsoBNUP4cu31cZwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LtVK1tZIhPZZzO5/CiK34fSmqjpUW0luLWU4OXZFlqA=;
	b=uO28erdtxVSfEhHg05gKH2mIXnclODsWRuA3QrX1vDfycKzYzdu9vYjuI/8qsXEJzbad
	 BuJlOnCb9YQAN+Xgfv4OmMBgWVvdYw+wOnRDdjwBNyWyPy9zaCy20sMVszhHq02E8ZjJF
	 q8UIBEYLSEE3hTDYTlOpudwB9Ub61xyiyEs3PFxgIzUUBcAOK3hFJsI9KYjoXl5hlJrs2
	 G+OYLUs8ErFzVZEOCUoa2+mHcbKj6T8yxYDX5V0rNtedp4qxJAgsdvWYrdCYk3QhsuZoa
	 RP5C6fIV+WnKes+saAcjDMID7udekrlMxPAl0/D/G8j4hJUkhCY0AIlIP8h1f/NxzWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OhNhf4Bj;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7C606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07F7C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OhNhf4Bj
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so10169435e9.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202242; x=1793807042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LtVK1tZIhPZZzO5/CiK34fSmqjpUW0luLWU4OXZFlqA=;
        b=OhNhf4BjuSG3e/6VN6GivJmIl/+gJb/TUjJc9z+vBd7CbssvdrIGIH1vG4k+ZfuDpJ
         p81CwXU0OCpslFV70v/D66L0u6pYrg5/WjZNwTPRpJVoE1MHqRJrAvD/nLF5sn/Rwh4T
         BnLwDX91KamNaosDa04cISQoCfHTzRDMW2cEXoKS26/NrJaZ4w3fwAhcDoE3MmD1nBdA
         ds3t6FTpp0UdeBAr7Lq6vbjtA8gTPoCpf9bkLKWJB0diWmPNCIrNFDiOEnDxyAU0GKFW
         ZkpzXaupcEaw34ti0Y7HcfqGFhPINTamCbaEJya7l3ZC+xuTe6W6BPXlk1yHXA1LuRKx
         2jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202242; x=1793807042;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LtVK1tZIhPZZzO5/CiK34fSmqjpUW0luLWU4OXZFlqA=;
        b=vG856Xur/+X4mghZMtH28yjS8+lVYFY0D88UuFa1isW7s+Yj8LWzJ4PKULF914m+87
         S6rtYmlmKPKjj3V0JKFCKdvINBD/vavFf/C6LRPV80ZctohiCFwzh4rvfvKnKstEKkJZ
         JKrAtb2isdiZFqSjPCqGZTlifgor5A+i/IYctIlm+ULtWbF6MC02iAZrWzQwUggAApfA
         Dwh8Qi3IJHUOjIca9pnR9GTc4oIt0ekO1qzIl0f5xVTaJLJDame9pxYx6K+T8XhANePU
         bULrlmIXGYnpS3XorNtF/nGSenFuQo8QHZdRM/dzfKXr9b6s4EKFgZT9HGDHQgoXam8m
         +76Q==
X-Forwarded-Encrypted: i=1; AKwUvBzPjqzjCpivL+5qHUE2ZyRth6rL9Eehmo/3Df0Tl9eS/MmL/cimTbVd977YsngmK93SgBF6j28=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUrlgLX/HHHfRlDeqLyvGwec6cuUjW7BeyUkukYySS/eM2aH1N
	cFXsJmfKqLxYWUabjP2gcZqPSndMPeRnGTtp6ObfJZwom81VDVwaiISV
X-Gm-Gg: AYBFou1Ylb1LeeNri/kGOS6MsFNFnfIWWghBeVTco8MZ2r0eYsACZs5eRabPKJgbiGE
	+xd83uqlY1wRerMqMwD4jbwh1rRzfWgSY0vxenBIpewObmStzeDxkIH6c6GdpsXZ6vwef4kCVJg
	FuPcvO1YGYfHARBf1F+ZKRqwuWY3VHxBYimpmU89qCxz7Fv45Y8Ys9pWAaLLB7OKYjx3jT7lCm5
	25jsXI92TSdKKBLX5knJG9/ZEWyIjN3pV1gUhK+Qaq/No9etbFsd9LAorhp2kvzkC1Ld+QAEaVb
	RZVkeX9i9X6Z+CXCoCnaMhqYhf+QeREysM4BZJtM+7UnMEcCd8S5/rVc2EBWa3v2ma3QAWPJz+/
	kGrTbHbdS/XWJ/dCa/GbJDjYRiT9QxSRFpStkGaIXoo+r3Et4rtvcHy3nP7zw/7lnU4tbvMB+QG
	X14x+ctF6B8VPAbSLfS8mh7Klh+8TArjhsfVENotlK+woBEomj7zIeJXM+DXW3OkERqAG6bsJcA
	veX6dbLbj0kLH9FjvXE+2CBHd/fJepzZpCJSdc1Pan/XIwn/hvAn/VG9jq+2e/VruO/BlQnHsZt
	zIs/9to6ijicEANnCipDOad4XoisqjtPBIhtRoUT7QXejMgfIthQqVYN9XyTqwVHVA==
X-Received: by 2002:a05:600c:a48:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4a9661ab4e9mr59192805e9.11.1793202242297;
        Wed, 28 Oct 2026 08:44:02 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8c05sm37044493f8f.49.2026.10.28.08.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:44:00 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	James Morse <james.morse@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Zong Li <zong.li@sifive.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zishun Yi <vulab@iscas.ac.cn>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/4] arm64/gcs: release GCS on failed fork
Date: Wed, 28 Oct 2026 12:43:12 -0300
Message-ID: <20261028154315.1272705-2-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028154315.1272705-1-ivanrwcm25@gmail.com>
References: <20261028154315.1272705-1-ivanrwcm25@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

copy_thread() can map a CLONE_VM GCS and still return 0. A later
copy_process() failure calls exit_thread(), but arm64 did not
implement it, so the VMA stayed in the parent's mm. Wire
HAVE_EXIT_THREAD to gcs_free().

x86 already does this via exit_thread() -> shstk_free(). The separate
x86 TLS leak is different: copy_thread() itself fails after the
alloc, so copy_process() skips exit_thread().

args->fn tasks inherit GCS tracking without allocating; clear it so
a failed CLONE_VM copy_process() cannot gcs_free() the caller's
stack. Keep that helper in process.c with the other fork helpers.

Fixes: 506496bcbb42 ("arm64/gcs: Ensure that new threads have a GCS")
Cc: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Assisted-by: LLM
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/kernel/process.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cfef22aee709..3010ced4b4f2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -177,6 +177,7 @@ config ARM64
 	select HAVE_ARM_SMCCC
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_EBPF_JIT
+	select HAVE_EXIT_THREAD
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 581f80e9b9b7..d17172e60acb 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -320,6 +320,13 @@ static int copy_thread_gcs(struct task_struct *p,
 	return 0;
 }
 
+static void gcs_reset_thread(struct task_struct *task)
+{
+	task->thread.gcs_base = 0;
+	task->thread.gcs_size = 0;
+	task->thread.gcspr_el0 = 0;
+}
+
 #else
 
 static void flush_gcs(void) { }
@@ -328,6 +335,7 @@ static int copy_thread_gcs(struct task_struct *p,
 {
 	return 0;
 }
+static void gcs_reset_thread(struct task_struct *task) { }
 
 #endif
 
@@ -341,6 +349,12 @@ void flush_thread(void)
 	flush_gcs();
 }
 
+void exit_thread(struct task_struct *tsk)
+{
+	/* Failed fork after copy_thread(); deactivate_mm() does not run. */
+	gcs_free(tsk);
+}
+
 void arch_release_task_struct(struct task_struct *tsk)
 {
 	fpsimd_release_task(tsk);
@@ -503,6 +517,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 		p->thread.cpu_context.x19 = (unsigned long)args->fn;
 		p->thread.cpu_context.x20 = (unsigned long)args->fn_arg;
+		/* No user GCS alloc here; drop inherited tracking for CLONE_VM. */
+		gcs_reset_thread(p);
 
 		if (system_supports_poe())
 			p->thread.por_el0 = POR_EL0_INIT;
-- 
2.43.0

