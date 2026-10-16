Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1084A39795B
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179981; cv=none; b=Rqz6iLpl4vyT4aiw7Lsra49zTv+pUKPzGi23u4DUnG50fTyUNZeG4N3LejVDFRO/zJXVZhzC4rg/vl22380951E2gsrvsUmaQchd9ZHE91OIXFyQgVD/XZGp9vBPCNpanbnj7BOtyKdMGkWRNQG7TziGXRLV5vFmNmWXprkn10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179981; c=relaxed/simple;
	bh=EVazFA0csJsZIo3f4B6QUACEMBA2ndyJfDDy8qymyLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6smaND2Rmc7TkU+7kPkEHwMClB61wt267YPgI8/lU0MUnTIozxM6gOQPA00JDpguVdIMtM4KB0LqVVC4uoXcOAVTBBL02YE3+8nVKSSlOlw4vmoD5WUoJr1J6CY6Xlfjtn25yHN/LOD6fEkuOJU+8Z9VCL3vH9ZNeBQg5bHg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRp5wEGg; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRp5wEGg"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30b6dad2382so774835eec.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792179978; x=1792784778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RiRo02OA1IxHJkhQCnHi5URLw0bi6CvLtMWBM69Y8xM=;
        b=CRp5wEGgJakPSigX9Y3ogxQymTOTvKjy0ti445e9jZigMGpHnm+PVRDTdoI4wW2y/q
         tffh1S74qOGIrWNdpV+q2H3AbHNhuF6bceWw1k51pZLQPbkY8Xj0y+bBqiTBDNhBugNQ
         XVFQ9V82xpmDKcKEbhSqzkqw62oeAKJ+7/PuVfT5D8CSk7L13Esp39Mu7SDRKVZL8QXy
         NTCoa3MSHPPVpMiFjNOfwq07JmyJD3ZUKX0UY2Hg9pHAVyqNObSrT047gssrkxlPv2GX
         bfpbqCMsEGhP/yyeWBpW14tyIMCW6AxIbe6K08QCECpxC+t/D/YOG38V8G60Hm1JKMgi
         gUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179978; x=1792784778;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiRo02OA1IxHJkhQCnHi5URLw0bi6CvLtMWBM69Y8xM=;
        b=biFTVJpKeXo9xaCAbGzlC53C98cbyo1v/+V0aZz0jF0CLcboHaTQVVmGCuaE/kldQZ
         vervGxrLKq65M6SjKfAVnAaMoQDBCxzqA3Ht+UUxmA/TVBiuO10a1RNfXWofrCavdN/2
         Ywhbup0wcQMHLO0VAhIatoUvSTNeiQkV5PjCOg8D8GKhk+9LP39k0oQ8SY5JXWnXTLaH
         g/05p2n1Qn8pN/Dz04pd+GueGKkhNHSLW3Qo1HefsKBwg5pX57eDVI2eP3cjFtpQMzgI
         LRcODWiDgdxX1gt7OHT6kfpMQk5rbXlVZ/C3cd7a6gzrKdtUqhg+Gn+iIGyip4fCOQCh
         qNYA==
X-Forwarded-Encrypted: i=1; AKwUvBzPxCT4u9as0pZOOO8Z85Xb75zu87vBLn0ZAXc/TmAklDCKKoEcylGKP7jjs+mhV37dWRqo0g4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGumrUr4WZvju9WI3r06Xu75vGTORRlJXu9D8kNWCCiMNO4RnR
	frwR2vtfoMg1DV533RiJYfkJj4KMS8mLADPl2wzfqi2l8tcKMEOWz/bm
X-Gm-Gg: AYBFou3MUIuK1WZuJwyDKw2cJ4+U3aYmspgfTLzPcUJ5Vqd8LaFL7b4vFzHCACWXDbb
	Kck9g9Ebq3yd+JzT3n2VH57iMLN9qMl9Lf/QOgcbL8ZE3C8D6LoHjPCsUPGIgr0vqe1Agxgy4Dm
	YmlqEkavXyFf4a7i2S6iJxJlHCjY3H+lFknw9eAZM22qrM+I4X/RN5tDX3nyZOizDJGdf39crq6
	rsh2cHIt7KKyAzcPYDeuRbv0yky0qtg8CWAbf56FAcP1WSywUifvd7waoh+emWwc6TJmYtfTZV5
	3bsp0hd8IIWrih0ttdjlTCsSdoK47HWTGLEInFOqGOYdvNqstch7O4TeHMYGtWJOYCnzDYSeYf4
	chPGRumNS2CC7fOvQ90TYrhHD90yHUV1VO3ow6m0SBQ03UkTQHmTomm5olgalBKubHqPKJ+4bXE
	02X9+B7sZ/2g0dXpr98Scj1RmeuTcioBpVFdOtRmAoayR8h6fHq/xcJXkBh/GmsbEN
X-Received: by 2002:a05:701b:2712:b0:151:ece6:b16b with SMTP id a92af1059eb24-18512c38159mr1013993c88.7.1792179977759;
        Fri, 16 Oct 2026 12:46:17 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm11008321c88.16.2026.10.16.12.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:46:16 -0700 (PDT)
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
Subject: [PATCH 1/4] arm64/gcs: release GCS on failed fork
Date: Fri, 16 Oct 2026 16:46:00 -0300
Message-ID: <2539f61f79a6053e2a33a1d1ae9df09013c04bd8.1792179433.git.ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792179433.git.ivanrwcm25@gmail.com>
References: <cover.1792179433.git.ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

copy_thread() maps a GCS for a CLONE_VM child and can still return
0. A later copy_process() failure then goes through
bad_fork_cleanup_thread, which calls exit_thread(). The hole this
series hits is clone3(CLONE_VM|CLONE_PIDFD) when put_user() of the
pidfd fails after that mapping. arm64 did not implement
exit_thread(). deactivate_mm() is what normally calls gcs_free(),
and it does not run on this path. Each rejected clone leaves one
GCS VMA in the parent's mm until the mm dies.

Select HAVE_EXIT_THREAD and free the child's GCS from
exit_thread(). gcs_free() already ignores a cleared base and a
different mm, so the usual exit path (deactivate_mm() then this) is
a no-op the second time. copy_thread_gcs() zeros the inherited
tracking before a user-thread allocation, so an allocation error
still skips exit_thread() with nothing to unmap.

A kthread copies the caller's GCS fields via arch_dup_task_struct().
kernel_thread() uses CLONE_VM, so during a failed copy_process()
the child still shares the caller's mm and gcs_free()'s mm check
does not save us. Clear the inherited tracking as part of kthread
setup.

Tested with CONFIG_ARM64_GCS on QEMU 11.1.2 -machine virt -cpu max.
Sixteen clone3() calls with CLONE_VM|CLONE_PIDFD and an unwritable
pidfd pointer leaked 16 GCS VMAs without the fix. With it, the VMA
count was unchanged and call/return on the parent still used the
original GCS. A successful clone3 child exit with the same flags
runs deactivate_mm() and then exit_thread().

Fixes: 506496bcbb42 ("arm64/gcs: Ensure that new threads have a GCS")
Cc: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Assisted-by: LLM
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/kernel/process.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cab741a695f5..c7fc79409f98 100644
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
index 581f80e9b9b7..eb5314b4b42b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -341,6 +341,16 @@ void flush_thread(void)
 	flush_gcs();
 }
 
+void exit_thread(struct task_struct *tsk)
+{
+	/*
+	 * copy_process() calls this after copy_thread() returns 0.
+	 * deactivate_mm() does not run on that failure path.
+	 * gcs_free() is a no-op once gcs_base is cleared.
+	 */
+	gcs_free(tsk);
+}
+
 void arch_release_task_struct(struct task_struct *tsk)
 {
 	fpsimd_release_task(tsk);
@@ -503,6 +513,17 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 		p->thread.cpu_context.x19 = (unsigned long)args->fn;
 		p->thread.cpu_context.x20 = (unsigned long)args->fn_arg;
+#ifdef CONFIG_ARM64_GCS
+		/*
+		 * kernel_thread() uses CLONE_VM, so a failed
+		 * copy_process() still shares the caller's mm.
+		 * Inherited GCS tracking would then look like a
+		 * child mapping to gcs_free().
+		 */
+		p->thread.gcs_base = 0;
+		p->thread.gcs_size = 0;
+		p->thread.gcspr_el0 = 0;
+#endif
 
 		if (system_supports_poe())
 			p->thread.por_el0 = POR_EL0_INIT;
-- 
2.43.0

