Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0811F53B354
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174955; cv=none; b=SVkUuYjra13h52Uo+w8ooAo36jS3lLnE2kTcSs2aiS/6pXwMad8ldTlZWUhzIlliixvx8rGxF8ECJXGB4zt81FP1IkR7hx3yjK+v1XZ29fpoKkuG3HTmwnaYlhZHrqnmZc4+fIe582HMSx3vQmZ6BorDwVQ71j7elfR521ZAW9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174955; c=relaxed/simple;
	bh=wvFQBz25XEKcRJNL0SSe015v57XgY3JcbH7bg42CNMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0fCCZS7Iz3W+veEfkdzg6r4KJa8qCSQFyxce2okmJiIF0nvTv9m10h2JhsWt400vdix8u0xo0ynsztUH6zwfSH/yZNOhqX+besHkukCNHmtSZ8ETgJJefd14X4Y/N2NTH7sPbnLQlkXJl9h9dEDkysw5mZe+TuIHgVMNnjmDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pj8Hj02T; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pj8Hj02T"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b390bcab0cso526421eaf.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790174953; x=1790779753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z1JAcPQg636JNOKXQW2C4J8TQkuklMU5EX+3CopghKI=;
        b=pj8Hj02T5RrCa13vH2T6dW5BamMMzzI9RLcsJ7/rd3hZna05HBKy3gEoymkTskyEdd
         AWTg8e1upkbBxE3C8AEP4mONO3KZkM4GRiK+qwyvHuNytIROskMd6L7B6L68AA1zr+Zu
         ShiN+5esV0D1R7f9caPkTg16alL85axdwwaH3z4WUKPGoh5vNIkdV0U/FIxyVTRyLRbT
         p0yYq0B7XhG52UZBgrYsqyxWTbVV/dhGoNQxF/tjfTr/KL270pjj4LndKFMZKdVCYWFD
         l2SiHZiZWQM5xjwKHn5Udbw26F3Fz/AcGX5SmYxfObQ0H6GEFSBM7vFQfq5WbUpd9x8v
         0rnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174953; x=1790779753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z1JAcPQg636JNOKXQW2C4J8TQkuklMU5EX+3CopghKI=;
        b=FY+VZFfUeE9N3oXYnBQVHzyfcBH0YwTCN010M/ZDKXIQEXucJOKuZvKSnDlqpUneYe
         vibeq0T5ajx2yWVj6YJICg0vitrP2T8wdW5T3jZCTQmzoeYqJp+LMvkuwUu0aPkcGa/E
         0eChNJIDrgVEciE1pWtBz21IDu2i3RFNfvfe8i6ovlYxUSFtnRzcPcYkUoN8cz9+iHmb
         4+u5RX1K8xkh0D91O7cw8UZKr5MvnuXhAU4NCksiNssI2hQzCUCqxoGLQdiU5P+IhAyz
         2YDlLGQlW4w1D0C5FIcbNH9d2rT0ybGndyrLTPwWGfPXVPUZTTIKra/bCvb+W3OycvAL
         nmJA==
X-Forwarded-Encrypted: i=1; AKwUvByy+7XZhCA7p6xMbPVLdmodPGvLIBepz8yxURLgf9DQHVIaWWRURLdAow0u4L0+v1tl4ZnBoxo=@vger.kernel.org
X-Gm-Message-State: AFuF++nhYFWsKtszpFhR7lkJYqrsaVqGcOvnYKrEZ3zImPTF61kcUEXy
	OZBfN8AFq5lPnVFKAAsIYdog4B15XbQDqULMgfrFl5AoBbOEcLVS8tbb
X-Gm-Gg: AYBFou0+bSjpajjKRcEYS+q4ilVMliGX+Dx48dwhy833GV60l2/62+6EG6jJZ2eZYRQ
	utowaL/17Hi4bnADCwZRZa3DxiLlasyA7gJNCUUESk1w+bcCiRRhTZQEDuqsO1TRbr1oftiNrOX
	/oWZwjN5EUmyFpiu3El0/DHhnBprinZiDu3jdwtRPLMVN9aJBLEzvc9CoTKSJBUXvWbaez5C61F
	QUqnni4BG7DfcRLzecuHd88J/+1U4WKMABfzFBjx11I+MUjAknOUjQKr4t9DHW9y8cJk510hn2/
	HWrbHFoKsdKmRWNofgO/QNnXezAk/wYgBJgmoSGhQZwzpW/TLDHbkM+cWhN+2VlhHacDz/0oO3W
	5JRkqVyE+hBCEFnMJ6MQICo/ZS3K96BRRU+ncYJoh5dxGmjMToXnyM6W0vI/AuOcAVfoe0T60Iu
	VnQmrFiEP0l7whaind417TT+LKpzHVOyEepZq+JmCcqaIGaWWFdAUm7nA7FtLqxHNMla2XOy36J
	x+EpBOlfq0zYMENYrqP071Ey9ac+J5FkqMPLayJ
X-Received: by 2002:a05:6820:4cc4:b0:6b1:3552:3195 with SMTP id 006d021491bc7-6d2cfd50098mr2368712eaf.11.1790174952926;
        Wed, 23 Sep 2026 07:49:12 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d2c92c2619sm2788537eaf.0.2026.09.23.07.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:49:12 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Allen Pais <allen.lkml@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] sparc64: kprobes: fix relbranch_fixup() for BPr, FBfcc and FBPfcc
Date: Wed, 23 Sep 2026 09:49:07 -0500
Message-ID: <20260923144909.414968-2-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923144909.414968-1-danishkhateeb03@gmail.com>
References: <20260923144909.414968-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A kprobe single-steps a copy of the probed instruction in
p->ainsn.insn[]. When the copy is a taken PC-relative branch, its target
is relative to the copy, and relbranch_fixup() moves it back to the
probed code. It only recognizes call, BPcc and Bicc, though. For a taken
BPr (brz, brnz, ...), FBfcc or FBPfcc it keeps the target as is, and the
kernel continues at the copy's address plus the branch displacement.

GCC often starts a function with a BPr on an argument. For example,
__se_sys_getcpu() begins with "brz,pn %o0". With a kprobe on it
("p:kprobes/kgetcpu __se_sys_getcpu" in kprobe_events), the first
getcpu(NULL, NULL, NULL) crashes the kernel in QEMU sun4u:

  init(1): Kernel illegal instruction [#1]
  TSTATE: 0000004411001603 TPC: fffff800048d63c0 TNPC: fffff8000492631c
  Kernel panic - not syncing: Fatal exception

Add the missing branch formats. BPr is matched with bit 28 clear. The
CBcond instructions of newer CPUs share its op2 value, but they have no
delay slot, so a taken one never reaches the single-step breakpoint and
this function.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---
 arch/sparc/kernel/kprobes.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index 191bbaca9921..9a26c57c8d33 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -207,12 +207,15 @@ static unsigned long __kprobes relbranch_fixup(u32 insn, struct kprobe *p,
 	if (regs->tnpc == regs->tpc + 0x4UL)
 		return real_pc + 0x8UL;
 
-	/* The three cases are call, branch w/prediction,
-	 * and traditional branch.
+	/* The cases are call and the branches with a PC-relative
+	 * displacement.
 	 */
-	if ((insn & 0xc0000000) == 0x40000000 ||
-	    (insn & 0xc1c00000) == 0x00400000 ||
-	    (insn & 0xc1c00000) == 0x00800000) {
+	if ((insn & 0xc0000000) == 0x40000000 ||	/* call */
+	    (insn & 0xc1c00000) == 0x00400000 ||	/* BPcc */
+	    (insn & 0xc1c00000) == 0x00800000 ||	/* Bicc */
+	    (insn & 0xd1c00000) == 0x00c00000 ||	/* BPr */
+	    (insn & 0xc1c00000) == 0x01400000 ||	/* FBPfcc */
+	    (insn & 0xc1c00000) == 0x01800000) {	/* FBfcc */
 		unsigned long ainsn_addr;
 
 		ainsn_addr = (unsigned long) &p->ainsn.insn[0];
-- 
2.55.0

