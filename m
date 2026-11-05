Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884968;
	b=vTG4o7ZYu02u2QOWZee+aCECFJHsPOb2Y481+Hnlmn9PMWmWEDWErGanW7K8xgvEe8FG
	 NX73blDQfiVDG7PDFzbCFcYvGMapuFeRT5nFiOMxpErXvjS2UVClhC/Ll0Jv8WR3anal1
	 ojPO3VsiJXAD4zJBk90UBF6fvWTh4bzTwED4ILI4rmcYw6HeylV81lEiURUhTZV5Klssh
	 S55CkKScmILj3rAuE824Jo6j3kXOkCA/eQO+h6tkid3nnHSCPL9mUZKChSwLCAiNcKzpr
	 nG1RF3wof6cTfpETrqn/Qb7PHW/FMXz51sj0ZlZ9fPwXCnVuDT6Bq08PYKR+rnAAhgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884968;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WYskst57saLSN4NfYIJN2XlgRB7fhCinmhIN9YTkUyg=;
	b=FVhfhxHN3BtdsehwTfxc9GFP+V+ep66wkLCluvdkgihonAcYU+GufvMy9XAx3pbcyHh8
	 FeyALdgz+xOoSeXzOB1CJHv5HD60EW90KzDO4txye7wBbHfP+ghGvyxWhorrF4GBkj7JD
	 ZlDq4diZ0mwfjx8xGuW6lL8A9v77/4RBICgtdM7Xaq5nGCez3rOl5kpssYwbuX0o9896n
	 uR9u94VfekGwP5Ed5bheq8/nPg+TaRsstM44/EVhjbhXsH8yEK2WdlCkFrUlIjxqJNm+T
	 jmWaHx2izG/5Bfom14nUj+ck+1BrvT8xl/7wd/uj3FU1uxAur4XAD0cD3X32Sfcsa6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPwsgtMg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9637C606A32D;
	Thu,  5 Nov 2026 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPwsgtMg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314CC1F00A1B;
	Thu,  5 Nov 2026 13:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884968;
	bh=WYskst57saLSN4NfYIJN2XlgRB7fhCinmhIN9YTkUyg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kPwsgtMgthByqOdBPI0+I/GE8EKigC5bnccdfezD8rIgj7C6jZKHWtQQUymOJN8mK
	 h35lysW26cvEohIRestxB2HuGlc6zFyjcGpCrlFY65hkJ9idwaMBVotzeu2nAl73ZL
	 4yRGRgh1wAgDyzvFryrk3CuBSX2U+fIulafiXp36f4EnmBJqmW05affumd3PMQja80
	 ABOTibHlUFIktDv9RgiZxRF1Ju9QeFNEwbKQMXp5lpdeST8CqfJaCMhQun6jjiMvh0
	 0FnxO4g9HdCE2EKgKndBzp2Hhkz1kW+PhESXAADh2CObUAj43aBTrL4RV+m2wMKVhh
	 g7/S4z7Ys0F8Q==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 05 Nov 2026 13:00:12 +0000
Subject: [PATCH v2 1/3] arm64/gcs: Ignore attempts to change GCS mode
 during signal return
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-arm64-gcs-store-gcscre0-v2-1-954d5bffd69f@kernel.org>
References: <20261105-arm64-gcs-store-gcscre0-v2-0-954d5bffd69f@kernel.org>
In-Reply-To: <20261105-arm64-gcs-store-gcscre0-v2-0-954d5bffd69f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3749; i=broonie@kernel.org;
 h=from:subject:message-id; bh=89Z9BtoATgubK0m2BOgIS3mZAvlCF+CWPrHquvWYOUY=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeNCvHVWcyz+7ZePJno42g9r7Yjct4i5UzvoQ8vD2/f
 vYRc9uujlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAExkZi/DX4m6GvXoH36d/VWl
 vpKhvfO+6JpuEj2T6ST/e2bTf9/tHxj+V7vzK6wUm8MqxTdBJPWt5YaUraaXmCJSZveHRnxJ43n
 BCQA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

If userspace tries to update the GCS mode as part of signal return then
we update the thread state but don't update GCSCRE0_EL1, meaning the
change does not take effect.  We may also get issues for other tasks on
context switch since we suppress writes of the register if the two tasks
have the same mode.

Since no currently known userspace tries to use this functionality close
this by ignoring any attempt to change the mode through signal return.
The GCS mode for the current thread can be changed using the prctl()
interface and will be preserved on signal return, allowing updates to
the mode from the signal handler.

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/as-8IqsbMbOBo5Oq@arm.com
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Fixes: 16f47bb9ac8a ("arm64/signal: Expose GCS state in signal frames")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 Documentation/arch/arm64/gcs.rst | 13 ++++---------
 arch/arm64/kernel/signal.c       | 22 +---------------------
 2 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/Documentation/arch/arm64/gcs.rst b/Documentation/arch/arm64/gcs.rst
index 226c0b008456..f2bcd66328bb 100644
--- a/Documentation/arch/arm64/gcs.rst
+++ b/Documentation/arch/arm64/gcs.rst
@@ -179,9 +179,8 @@ intended to be exhaustive.
 
 When returning from a signal handler:
 
-* If there is a gcs_context record in the signal frame then the GCS flags
-  and GCSPR_EL0 will be restored from that context prior to further
-  validation.
+* If there is a gcs_context record in the signal frame then GCSPR_EL0
+  will be restored from that context prior to further validation.
 
 * If there is no gcs_context record in the signal frame then the GCS
   configuration will be unchanged.
@@ -190,12 +189,8 @@ When returning from a signal handler:
   point to a valid GCS signal cap record, this will be popped from the
   GCS prior to signal return.
 
-* If the GCS configuration is locked when returning from a signal then any
-  attempt to change the GCS configuration will be treated as an error.  This
-  is true even if GCS was not enabled prior to signal entry.
-
-* GCS may be disabled via signal return but any attempt to enable GCS via
-  signal return will be rejected.
+* The features_enabled in the signal return context will be ignored, any
+  changes made using the prctl() in the signal handler will be preserved.
 
 
 6.  ptrace extensions
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 6a06a4e352b1..80398ac83c3b 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -741,36 +741,16 @@ static int preserve_gcs_context(struct gcs_context __user *ctx)
 
 static int restore_gcs_context(struct user_ctxs *user)
 {
-	u64 gcspr, enabled;
+	u64 gcspr;
 	int err = 0;
 
 	if (user->gcs_size != sizeof(*user->gcs))
 		return -EINVAL;
 
 	__get_user_error(gcspr, &user->gcs->gcspr, err);
-	__get_user_error(enabled, &user->gcs->features_enabled, err);
 	if (err)
 		return err;
 
-	/* Don't allow unknown modes */
-	if (enabled & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
-		return -EINVAL;
-
-	err = gcs_check_locked(current, enabled);
-	if (err != 0)
-		return err;
-
-	/* Don't allow enabling */
-	if (!task_gcs_el0_enabled(current) &&
-	    (enabled & PR_SHADOW_STACK_ENABLE))
-		return -EINVAL;
-
-	/* If we are disabling disable everything */
-	if (!(enabled & PR_SHADOW_STACK_ENABLE))
-		enabled = 0;
-
-	current->thread.gcs_el0_mode = enabled;
-
 	/*
 	 * We let userspace set GCSPR_EL0 to anything here, we will
 	 * validate later in gcs_restore_signal().

-- 
2.47.3

