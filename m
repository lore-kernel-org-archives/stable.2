Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072710;
	b=3NSQEOGMKxDRtmnjzS3wFzOHn2YN0xrs+dUaKc8G67s12pd93fJ7dvgpzWKwrZ6aIuVB
	 GyNcSDXW98+I+bWMrxtt25tehaN93Vfqr1lcYdkH61zdAc1hZHk+fxn5V5eh7i5OAXPKn
	 H+NrAW/O3GO6uEjkITYfpqzuSsEhaqGdJ5LVeUIuTgBS94LEO9tb3XnZypj2ZL8eK3C4U
	 THU7sP4qTqqX92YaMVFOMSgX8lYHW1EaMJfCw22Gcw8abgwq9BCjWAwuZ1fFOzeYF8v4t
	 dDbKYcevVCoxG4s+EqUlJaAHC5kG33WPC5WaTPTrCBOyAZAKtCgZSe4uJtgCdtlTw/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072710;
	h=DMARC-Filter:DKIM-Signature:To:X-Mailer:From:Subject:
	 Content-Transfer-Encoding:X-Original-From:Message-Id:References:Cc:
	 Date:Mime-Version:In-Reply-To:X-Lms-Return-Path:Content-Type;
	bh=IU6VHGahaQUjfrcJ3t0CrfGoXgu1vrAKIBCseES6bf8=;
	b=EYf26BUkDu4Fd1f9X5WFKu22Djf7j0e6xrlER89U0BRpIh8kVR/Mu69+wtTr8jEDE7bN
	 TG6C6cZYdVtzKf32N3oB9Y1LueBfl1sMNJv7eGuruyar834QJfO61zO7jfknLM9OPwXZv
	 FtHb6TvXLHHkQIN5kzMgMIiRhQyIrGfxKER7yn150+p1/8ATvQufzOEAWKd6B3a+a7Gbw
	 VrXQKNdxUjPdStrNu1YoE3yetteD2dvAB02Pp0JMxPwXP7Va/EGO4dU0+ODC9kXn7NguW
	 jqwi4wwSKBKG5UUBM+WilPI8cZnSyOES0PPzBLU4SdCh73Dy6ADWb9XsGgMTpO3L7zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b="S9i/mKlO";
	arc=none smtp.remote-ip=209.127.230.114
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94A606A324
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA94A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=S9i/mKlO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1793072703; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=IU6VHGahaQUjfrcJ3t0CrfGoXgu1vrAKIBCseES6bf8=;
 b=S9i/mKlOK9odgmXt9DGNd6+hoJII6+ec8+di8uoBGU3cbV0f3kaUvK7h2/vu/ta7+0eVyM
 8XWDuz5jqk3bZ4FK/L7VwO5nKqSlZxlchOAYeZLYuUU4W638Q0F2A2ofgRLpzuAmtWEOjy
 wpbaFXfSLlQ7MRfEXVWY6gpf+Pg94tZ175F5k103akXHxpdEucn+774ohlnw7Y1r6LrOeN
 qzevb9TgiPGskokqhdBdTJhqoiIfWTEWGNGyUZiIPcMi8FMnoJ0159kNwr5q/KBKGc0y1M
 WElVGuXhij8/gyvJqOKEQQbVTkW5w+vSzvm+3wAjsANhPpPmiDYA62QX2yzjaw==
To: <x86@kernel.org>
X-Mailer: git-send-email 2.55.0
From: "Guixiong Wei" <weiguixiong@bytedance.com>
Subject: [PATCH v3 1/2] x86/fpu: Fix memory leak with dynamic fpstate and exec()
Content-Transfer-Encoding: 7bit
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
Message-Id: <f6c7690f8288ad9e95996e0cb37fc4c385df9ee1.1793072271.git.weiguixiong@bytedance.com>
References: <cover.1793072271.git.weiguixiong@bytedance.com>
Cc: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, 
	<chang.seok.bae@intel.com>, <shuah@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Guixiong Wei" <weiguixiong@bytedance.com>
Date: Tue, 27 Oct 2026 11:44:29 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
In-Reply-To: <cover.1793072271.git.weiguixiong@bytedance.com>
X-Lms-Return-Path: <lba+26ae01e3d+2b6cf8+vger.kernel.org+weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8

Using an XFD-controlled xfeature can allocate a larger fpstate. On
exec(), fpstate_reset() replaces fpu->fpstate with the embedded buffer
without freeing the dynamic allocation. Once the pointer is overwritten,
the allocation cannot be freed on task exit.

Free dynamic state at the start of fpstate_reset(). In fpu_clone(),
clear the pointer copied from the parent before resetting the child's
state, so the parent's allocation is not freed.

Fixes: 500afbf645a0 ("x86/fpu/xstate: Add fpstate_realloc()/free()")
Cc: stable@vger.kernel.org
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 arch/x86/kernel/fpu/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index d1aeecd57f5ed..dbe6696fdf8cf 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -594,6 +594,9 @@ static void __fpstate_reset(struct fpstate *fpstate)
 
 void fpstate_reset(struct fpu *fpu)
 {
+	/* Free dynamic fpstate (if any) before resetting pointer: */
+	fpstate_free(fpu);
+
 	/* Set the fpstate pointer to the default fpstate */
 	fpu->fpstate = &fpu->__fpstate;
 	__fpstate_reset(fpu->fpstate);
@@ -670,6 +673,8 @@ int fpu_clone(struct task_struct *dst, u64 clone_flags, bool minimal,
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
 
+	/* Break the link to the other FPU's fpstate: */
+	dst_fpu->fpstate = NULL;
 	fpstate_reset(dst_fpu);
 
 	if (!cpu_feature_enabled(X86_FEATURE_FPU))
-- 
2.55.0
