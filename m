Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072762;
	b=PD2slAyWH5eOYz7jetYU28QqS2U8niShgn1XKUgB5LcatLeUTXNcbmtOoLeC+Icw6TLV
	 UY3hN3sr9lWQI2LcPfXpLSODp84w1ssNU5++JpI0y8S2u5XrQ07JaU9pNZu40opYUATwG
	 wG5KGHoolI1K3Vx+DgnaLK49ngunZSqIjt2riBfRQdZeOgvxbA4VphxpEX+RJY82+pOri
	 A+pHhvyhXYMJGlO5shk3cisvajfkLRIQQkU2Bc+FR3sYwg2VczOplu+Gp8lyXZZssKXz0
	 kqI12vHvUIwRLbq3CL2choT1OJw8EYoRYjQHPA+S9pUPRc0hYx6Hz4BitSHLqS2bYwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072762;
	h=DMARC-Filter:DKIM-Signature:From:Mime-Version:X-Mailer:Date:
	 X-Original-From:References:In-Reply-To:X-Lms-Return-Path:Cc:
	 Content-Transfer-Encoding:To:Subject:Message-Id:Content-Type;
	bh=IU6VHGahaQUjfrcJ3t0CrfGoXgu1vrAKIBCseES6bf8=;
	b=r9pr0hGUz0ccoYsWVowIxA81aBY6VDEme8tebaYcLDLtbQeWFuvg/Z9cOx2X+mbqp6Cl
	 rVpr/crPDJFhs67J1So/nWIx8DiGz4f9ly1irIamgIXpjWCg+WlUFi8ETe1UqPZNXKMO7
	 SYe7xG14HXyjmoQYs22fMoIY4Fon4gRAyuwo6vz8YkqORrymc6oG8Wvl3U/u35rnTKaOF
	 wAVFrIarNWBowaEBobR+Zu6h8jN5pWKremxv1EQv/QWn5AFWc6tf6bUeCFpniWpUdAFfO
	 sApi4uDpfDhlXJpar9MT5VulejCUEbzW37uVMi9PuYIYz0JNqtC/ao8xLBcMiF64Gmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=BXQXAwmn;
	arc=none smtp.remote-ip=209.127.230.112
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4B606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFC4B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=BXQXAwmn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1793072757; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=IU6VHGahaQUjfrcJ3t0CrfGoXgu1vrAKIBCseES6bf8=;
 b=BXQXAwmnrK+4EbP7eIcaZpgDPDo9WqPpY3ycHdMWr80q/YjYP144tXRbrWdKpQ5OsUGC8O
 WrB4V4GzI5Wx+s6Ytoy+U3viwbD/fwE6kbbZ76PC6+Fh9UI73DXU0SyXte+M0Z8S+DysFp
 K8vRNsyiXZc2TOXYyENk7LXQ6dOfB30a+PTcdFNv8gc/pQ1Oxrp9L7sMq6t9zAPJ9imWnv
 xoC5TSQr+bB5L5aCpMA07U32fGSdaR11L87SLLwwiDRaA3ysMyoV0GxUGzYUygalQQam6G
 7EcSyPZJW0AlO95LnO10LPlIJH8C0Ct60nmxntYjQWlqJtyIZP30Pal9Imo4Yw==
From: "Guixiong Wei" <weiguixiong@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0
Date: Tue, 27 Oct 2026 11:45:26 +0800
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
References: <cover.1793072271.git.weiguixiong@bytedance.com>
In-Reply-To: <cover.1793072271.git.weiguixiong@bytedance.com>
X-Lms-Return-Path: <lba+26ae01e73+bfd9c3+vger.kernel.org+weiguixiong@bytedance.com>
Cc: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, 
	<chang.seok.bae@intel.com>, <shuah@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Guixiong Wei" <weiguixiong@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <x86@kernel.org>
Subject: [PATCH v3 1/2] x86/fpu: Fix memory leak with dynamic fpstate and exec()
Message-ID: <f6c7690f8288ad9e95996e0cb37fc4c385df9ee1.1793072271.git.weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-ID: <20261027034526.O2Lc3xqfhBd9oRvpPnyQJEr0fCrAmaviMM91u5SO4q0@z>

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
