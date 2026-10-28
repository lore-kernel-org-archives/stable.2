Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202263;
	b=FMU+lPTYdeJ4pl1kU2Uv1f5g+b0jIZ4zGl8jgKux0thy06AsQSrEgKNloP+i7SLW/ZXx
	 0UnTUFxxLgoXNcjIb2IAW8bAFam5YQBJrrRDmQWwLDswcabYR4pbGS8OHhFdJH/Qu8ky1
	 SlrkuE52XNlfulvKYUsj8CwuOnURpoPYYxpTfp7b9z6K3/vYD02n+3TeyTm5Q3SSFFAP5
	 pNK1aMmi/aMb2DZBG0GS7uQOxcQMdphA/+OucWPyqnvl1g1kz4IqUhvNTdOgRop8Dxl2w
	 wpt+FtmOAvtc/LV9FueoY71ewrXLGwbbWxVPtyYjVCeW2FxcsWLftO6H38U5R1c/xPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hqyoatBuWzt+rzT6XLIO+YQLmt48/m/aZM3ACi+9940=;
	b=ohrxvT1WRu0FRMgjpf4fmHpc0RfMWks1LiDly1rGnE0NZKQMbt0BmtZnRoCuLj24yesa
	 rpAecsJwEHW8T3p0gHu4STc0+7kmVZTHmBhuj5iirBIAFbJoK0GDuYutQ5EVNpcNCpM4G
	 xUu6npM3pPv2SYfVWssOzh5Q8U5e30RuqO2YPKOsQha9B1YMZoDnAqF05E4yKNZVC6E0g
	 myPhEOPA1utsYtuAGWX+vHD5gtptbMsEyRBnYBpAVrvG47kayb9MII6kMLj8D5qBJO2bC
	 R+Au/Tdq53fC23FNSzpdddGls94AIj0XTGcXm3fabKj2i0Xmj6jkKD07lF88vWjZrow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vVRQYMZm;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2476460A383E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2476460A383E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vVRQYMZm
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so10943005e9.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202261; x=1793807061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hqyoatBuWzt+rzT6XLIO+YQLmt48/m/aZM3ACi+9940=;
        b=vVRQYMZmRATfXuBDLw24cUDCHaJq7j+gDMv8Gym+FaX7CLKfgfFnccPLvsd5c+/Tka
         /HLjVRkiJ8uODWT7w65gtCQTsKUEsQiC01/kPuUs8L/YMB913fPNTBqbjmgUPH5lTrlN
         LU+ae7VGzf5rwTZXkeQw13PZUDhNUmZ/KBQxqtWoWh5jLsAz9Nkqim6r0nksE2WuSLuL
         ikrzSl7HyUx13SpLJa09UXCNK5tyPaYhxhU6hlyBqSNCN8j+V0i6NujGOEXmnmDNIQQ7
         Q9jj6iCxMz5X0CAIyh3MjVyp84AK91EmGTy3GAPMrFdreF4iVpAxoZ09RD33DzMZE8LJ
         UD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202261; x=1793807061;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hqyoatBuWzt+rzT6XLIO+YQLmt48/m/aZM3ACi+9940=;
        b=RUJ8SpsImNCX8qs54hASmXpScPpdq7WXo+rml7h7kZaRaMlS07YktQejeV8mXbGRdP
         6rdAjeidDcfMVeHkKEFPEF5cAvD0iG9fnx/FYIRpVv6rwLwdtT1ErrpgcAS2/YbCtkZF
         95F7Zk9k8qhezR/9sibROcBrGBkUpRBioG4Uz8/xiZQynGiabOogPZ6h11LHgxGZ45y7
         /Nz8cVjCXgTgFyV8fGya3QldJcD9OMoErDliDSOfK4nvMADbcudwayTuwuEuLDSh+lfX
         2EP0q1de5apEums8QsM1IN562QCgEVpa+ZDadRd3os9O7xCNzzqYBzEvuQnxE41uJrN+
         Doew==
X-Forwarded-Encrypted: i=1; AKwUvBzns3RYC8aKP+7SC8Q+SA6jlH4nFU5bTJ1+l+V4g+w11Slui1G22gOD0VUwP0TKbNIcB54oju8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIi73ZSMs+EUDj1Oa+XIV7LJINGIdq6anPwYdQINfWeaEuIYyqm
	Fw9ifQpxea6eFZjXhHK4wDTN267cdlCWvazm02UDrST0J1r/bVOafQjy
X-Gm-Gg: AYBFou3BMSh7B6ovKBY7LzRqc8nSdKm1foKF0wZTTkSkCf6Dd5GbCjpXIxsGPUkIBIO
	T7ywdJFjtSEdEaO8q3QnN/KZ4cLcCLj5bGFoyFSimaMqVPyR4oerqh1YhSfEnJyYjcUGajT6y/D
	SgYQwT3A+IObf0AiuFPCnZuxiy8GR7A9ge3RaHDN6Y0DY7eEXY+ypRpIsHW+17nFOISOnXGwibT
	9Yf6ysNyQMU1mlLU1VdQJm5oXx1zLZ7XB9mFMTo2cr2rOaoUkXAm4c2A+qc3ZHnp/2QEqw7buaQ
	rgbXvbTle9EaqudfDSD8lZ19rh1M2Cpl2Jk5JoBPzavweOgyKslfLMHSHNe8X1LhMw3vVsOTj2c
	ZBMtZl2jZp28G5vTc6dEGleO3ehDwM+sppKAgLcNjutAz3mE0xqMki8EJYRM2eKwg4piqpKXHhb
	2r29lhm4x5VsM6tDmwdy0X68RGhveDMsZ02OzzxSjXeMNpscbXtUcJWGBV6a1F8wQpKsnAsbp//
	sbdA1+yqbvkEfCQX0bUAUTFvOC4cdEYK6q6tfc9FJAynUyWCHZsir90wzgRlI8bGoNSVezcGXmr
	Vgl//ypqhTj7KxGs+0Ufpe5HdNHM5N8tlvybw3kRS54mUY+jVVs+xvDOu8z4n/cKhg==
X-Received: by 2002:a05:600c:8b6d:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4a967f8c344mr59591525e9.31.1793202261496;
        Wed, 28 Oct 2026 08:44:21 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8c05sm37044493f8f.49.2026.10.28.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:44:20 -0700 (PDT)
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
Subject: [PATCH v3 2/4] riscv/shstk: release shadow stack on failed fork
Date: Wed, 28 Oct 2026 12:43:13 -0300
Message-ID: <20261028154315.1272705-3-ivanrwcm25@gmail.com>
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

Same hole as arm64: copy_thread() maps a CLONE_VM shadow stack,
copy_process() fails later, exit_thread() ran but was never
implemented. Select HAVE_EXIT_THREAD and call shstk_release().

shstk_release() already documented this path; connect it. Clear
inherited tracking on the args->fn path for the same CLONE_VM
reason as arm64.

Fixes: fd44a4a85516 ("riscv/shstk: If needed allocate a new shadow stack on clone")
Cc: stable@vger.kernel.org
Cc: Deepak Gupta <debug@rivosinc.com>
Assisted-by: LLM
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 arch/riscv/Kconfig          | 1 +
 arch/riscv/kernel/process.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6c9d61d83d71..ba1ee563aa54 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -168,6 +168,7 @@ config RISCV
 	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_TRACER if HAVE_DYNAMIC_FTRACE
 	select HAVE_EBPF_JIT if MMU
+	select HAVE_EXIT_THREAD
 	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST if MMU
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 7cc5a6a5c020..5bb93377d67f 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/tick.h>
 #include <linux/ptrace.h>
@@ -213,6 +214,12 @@ void arch_release_task_struct(struct task_struct *tsk)
 		riscv_v_thread_free(tsk);
 }
 
+void exit_thread(struct task_struct *tsk)
+{
+	/* Failed fork after copy_thread(); deactivate_mm() does not run. */
+	shstk_release(tsk);
+}
+
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
 	fstate_save(src, task_pt_regs(src));
@@ -261,6 +268,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		p->thread.s[0] = (unsigned long)args->fn;
 		p->thread.s[1] = (unsigned long)args->fn_arg;
 		p->thread.ra = (unsigned long)ret_from_fork_kernel_asm;
+		/* No user shstk alloc here; drop inherited tracking for CLONE_VM. */
+		set_shstk_base(p, 0, 0);
 	} else {
 		/* allocate new shadow stack if needed. In case of CLONE_VM we have to */
 		ssp = shstk_alloc_thread_stack(p, args);
-- 
2.43.0

