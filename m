Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3CA44DB9D
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484838; cv=none; b=MXn0CXMGk2Hk4ak4yJSeBzBOKaskmL88HJEwTvZ+ClFD1rttpyI5zxJaIzqo04RnaWDssh8WR0+iCgELzV3A4aYsb4HKo40uTtl7zrkOdtEM4/wgQHJg5OzZxYPQBRIBZI048zHYEUvVWpQ/0PsXbLoGGNgobeACxQDq0//Nezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484838; c=relaxed/simple;
	bh=R0PR3gYxX4+jZK8thl4AlhbDo07ovqY0fnB5qqNN45c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPICCSY0E4S2b6rMZRa3nwHeM1mErVR6dBMwGMLnOJnookqMHI8TPsNrJlyBlA5LwkyNSSFjXnJ5Kpv/1NjbNGnA3zlK5NmEkC4ZxePrqgJtf7UnBsz4ciKn5jZ0AHzvU5UddSVomc7KZCbqcSbqp0tJoLVpxjfE/WQKuUvfaeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K82VXobe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K82VXobe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B968249FB;
	Wed,  3 Jun 2026 04:07:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E120A3F86F;
	Wed,  3 Jun 2026 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484835; bh=R0PR3gYxX4+jZK8thl4AlhbDo07ovqY0fnB5qqNN45c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K82VXobe0HnDFieGUR8pO4JjnD5S6qR3qd4BYsglV4SaqRFw433ECtvFXhZ3HJ4Bi
	 AHK0ABNxy7Z53sfBmZHs/3Yhwsyv8mNB+hNfYXcR22iV4EDnl0mvzerBYb29LyOGXm
	 nJLEXTqOHFJv6JyJW8KQbjqHSwuULt+3UuGY6ySY=
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	stable@vger.kernel.org,
	tabba@google.com,
	vladimir.murzin@arm.com,
	will@kernel.org
Subject: [PATCH v4 16/20] arm64: fpsimd: Use opaque type for SME state
Date: Wed,  3 Jun 2026 12:06:26 +0100
Message-Id: <20260603110630.1027435-17-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260603110630.1027435-1-mark.rutland@arm.com>
References: <20260603110630.1027435-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the SME state size can vary at runtime, we don't have a concrete type
for the in-memory SME state, and pass this around using a pointer to
void.

Using pointer to void means that it's very easy to introduce errors that
cannot be caught by the compiler (e.g. as 'void **' can be assigned to
'void *').

Improve this by adding an opaque 'struct arm64_sme_state', and
consistently passing a pointer to this.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h    | 8 ++++----
 arch/arm64/include/asm/processor.h | 3 ++-
 arch/arm64/kernel/fpsimd.c         | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 581661a759a3f..fff6d54afd9fe 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -163,7 +163,7 @@ extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
 struct cpu_fp_state {
 	struct user_fpsimd_state *st;
 	struct arm64_sve_state *sve_state;
-	void *sme_state;
+	struct arm64_sme_state *sme_state;
 	u64 *svcr;
 	u64 *fpmr;
 	unsigned int sve_vl;
@@ -199,7 +199,7 @@ static inline void *thread_zt_state(struct thread_struct *thread)
 {
 	/* The ZT register state is stored immediately after the ZA state */
 	unsigned int sme_vq = sve_vq_from_vl(thread_get_sme_vl(thread));
-	return thread->sme_state + ZA_SIG_REGS_SIZE(sme_vq);
+	return (void *)thread->sme_state + ZA_SIG_REGS_SIZE(sme_vq);
 }
 
 static inline unsigned int sve_get_vl(void)
@@ -218,8 +218,8 @@ static inline unsigned int sve_get_vl(void)
 extern void sve_save_state(struct arm64_sve_state *state, int save_ffr);
 extern void sve_load_state(const struct arm64_sve_state *state, int restore_ffr);
 extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
-extern void sme_save_state(void *state, int zt);
-extern void sme_load_state(void const *state, int zt);
+extern void sme_save_state(struct arm64_sme_state *state, int zt);
+extern void sme_load_state(const struct arm64_sme_state *state, int zt);
 
 struct arm64_cpu_capabilities;
 extern void cpu_enable_fpsimd(const struct arm64_cpu_capabilities *__unused);
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 96c0c30eac50f..c2a627f393144 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -131,6 +131,7 @@ enum fp_type {
 };
 
 struct arm64_sve_state;		/* Opaque type */
+struct arm64_sme_state;		/* Opaque type */
 
 struct cpu_context {
 	unsigned long x19;
@@ -167,7 +168,7 @@ struct thread_struct {
 	enum fp_type		fp_type;	/* registers FPSIMD or SVE? */
 	unsigned int		fpsimd_cpu;
 	struct arm64_sve_state	*sve_state;	/* SVE registers, if any */
-	void			*sme_state;	/* ZA and ZT state, if any */
+	struct arm64_sme_state	*sme_state;	/* ZA and ZT state, if any */
 	unsigned int		vl[ARM64_VEC_MAX];	/* vector length */
 	unsigned int		vl_onexec[ARM64_VEC_MAX]; /* vl after next exec */
 	unsigned long		fault_address;	/* fault info */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 0da2f75de5dde..b9506422d29c6 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -808,7 +808,7 @@ static int change_live_vector_length(struct task_struct *task,
 	unsigned int sve_vl = task_get_sve_vl(task);
 	unsigned int sme_vl = task_get_sme_vl(task);
 	struct arm64_sve_state *sve_state = NULL;
-	void *sme_state = NULL;
+	struct arm64_sme_state *sme_state = NULL;
 
 	if (type == ARM64_VEC_SME)
 		sme_vl = vl;
@@ -1645,7 +1645,7 @@ static void fpsimd_flush_thread_vl(enum vec_type type)
 void fpsimd_flush_thread(void)
 {
 	struct arm64_sve_state *sve_state = NULL;
-	void *sme_state = NULL;
+	struct arm64_sme_state *sme_state = NULL;
 
 	if (!system_supports_fpsimd())
 		return;
-- 
2.30.2

