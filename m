Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA753B358
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175271; cv=none; b=RQ+R5JiuUYUgmoomgb86YucciVMFYqy/2AhpRrEUlL+fVyDwspRlX2FgRUxdiYqGo9O/X/V2ACm2yGN9EcN7ftsmOaIRs2uZSfSIY2ayoDJrz2/Ssbxh0jGZ0dF0ShwDWK64nnww+82rRh9g7UU03dLC7NVAnz8jr8BH59EV7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175271; c=relaxed/simple;
	bh=BQ3AIo9FaExG3aW1u0QXqsgAz+u3CyxtPn+zj7VYhc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tisWQ64buE7phBlrPAFP/1N19C5XOecy5WOCr+sYVcX8haqcDHf/xm1lxS2KeUhFnQe26zDu+f00DtnKaYK6PHBpGZfZADkjZ1G3Swo1JZtKuGJ8UmG0hNN6bZin8P//V6BBXCsh8CVD+VbcA89DJSpL6tYIpSbfO7q6U/Ajb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCFSrIC0; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCFSrIC0"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a2ffee6so467830b6e.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790175268; x=1790780068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8imZswOXgJq9Cx5JQERORsPUChw1RLSPP9EHDsUeryo=;
        b=YCFSrIC0lwqobzyWufIQdV+GBzHpF+Ee2UQ6PKXA4ZgCLCa7gB5Jz2XhCrot7XSWHz
         G2QmyzOtR8zr5vIXqYv1vEPXJP2+4+HNbP3nUdWcjpGD0JVWP+vUefUe1HjtNWT/drAK
         du5NHAcJ9ssvnENlG7L0+pdUJo6HpKdO7FLb5fpPBLDFxSLVI/T55x2ic2ssthOEIQLn
         7oTrle9afXPxeRPfcqoURZRVqPJhpUfjILLJ+qA+Nx3U5Y9hDImkoElfAK6b6Gdtyuom
         7y5jRKpmuL54MnNrysbt0YjJ62Wj0f3UvDhJyU+1RtnE2zkJ0C4lsUJT8zmC9+I9vGDy
         RQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175268; x=1790780068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8imZswOXgJq9Cx5JQERORsPUChw1RLSPP9EHDsUeryo=;
        b=wYNINlxiHoNy7Ye4ITi+LqDfHb2/g/67kSTh2pbM6GngQwm2EXxzOXPZYPOqiLaZGU
         +Celeeo2cDnsfVvUWN0ZgKQyGGJlAWNUCGoogfhRhlfBGouJig1vNZx1lzfgWioH8Y3d
         s4bdTtTqGMpNGCBTAXtMMiEE//YAJAvJN4fDeqr+qrQ94PP7pCWj1Vda8/xp7CcMbAu5
         YSNpEfE+yA3fVpjFkrzp+KUTIJRO8/8O8w+/YnKiIENNteyDnifalFnFseIF5OXnWTLo
         4GNtW7ldp2xWeNEhl0xxID8oSkcyNi0OzryI0QjUS7GsLvx0gLRI5V7RtehFdYUxiA2r
         foRQ==
X-Forwarded-Encrypted: i=1; AKwUvByLkULYAybZDxdmIufvc7FD5jqOR1Px/0zAK++s8WnDjRQyxyG8NJWHZrrjMKkDrceynQ8TtHA=@vger.kernel.org
X-Gm-Message-State: AFuF++kA+TvGE4pjBjbkSp9R5zzIdcMXLqkRQMLyO/gN837Cke1bR4nx
	MhEEjjKkOsI/bzHt+FIeGasP21K19QqbrX7ma54IvjB7KC8XI4n/8iJH
X-Gm-Gg: AYBFou2OYrkAuI+KTg+nkNjBnZwJ0pADhOVZh+bLy4Md4CfV4Ao0NTsoKbSasO0bUF3
	143ZX308mfxO1hT3nlBwfWm05uO2pgd0fkErONQKadp7yuBvbCnhsfw2/GLt2Iux+Hj2zbj0G1x
	xoWuk8jabvwmSQN/aXlMOEqUr3ilHVvgnU8t3Q6ilU+sTYLyTpxuORnriyPIFBEY31zPLpgSqXc
	+q+/mXzkWmdiXB/atlXJGEMnwSRUQPuDxIrHSqrTyJuGgFmgA3FVWBt32kYLS+3vvxGVe4P7Z9s
	AnZuV5/EccAh63j3kMTP1yfeIW69tdzxop9LF92+vand2apHDPRloXahBkP+4284M6Tbs3vKahJ
	i26b02TZYj+S0/M4M5sEBivffmlYFvH03l/G+w+UBp/JHPlkHw9NfLFwnahikisOWDyz5hQxSIq
	5HfH7TmirQ9R5ewZ6j7WSOiZLAx6R+A4DHJ86hCaAfSO8KoyR+XSbpB3NwGE4ktZSKaZgFow==
X-Received: by 2002:a05:6808:4f60:b0:4d6:9283:1bdd with SMTP id 5614622812f47-4d69283317bmr1082080b6e.58.1790175268279;
        Wed, 23 Sep 2026 07:54:28 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c4bf8e14sm2290752b6e.14.2026.09.23.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:54:27 -0700 (PDT)
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
Subject: [PATCH 2/2] sparc64: uprobes: fix relbranch_fixup() for BPr, FBfcc and FBPfcc
Date: Wed, 23 Sep 2026 09:54:26 -0500
Message-ID: <20260923145426.421639-1-danishkhateeb03@gmail.com>
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

uprobes single-step a copy of the probed instruction in an XOL slot.
When the copy is a taken PC-relative branch, its target is relative to
the slot, and relbranch_fixup() moves it back to the probed code. Like
its kprobes counterpart, it only recognizes call, BPcc and Bicc. After a
taken BPr (brz, brnz, ...), FBfcc or FBPfcc, the task continues at the
slot's address plus the branch displacement, inside the XOL page, and
dies with SIGILL.

GCC often emits a BPr as a function's first instruction, so a plain
function-entry uprobe can kill the probed program. In QEMU sun4u, with a
uprobe on a "brz,pn %o0, 1f", the first call with %o0 == 0 ends with

  init: potentially unexpected fatal signal 4.
  TSTATE: 0000000082000203 TPC: fffffffbffffe01c TNPC: fffffffbffffe020

where the task's [uprobes] mapping is fffffffbffffe000-fffffffc00000000.
FBfcc and FBPfcc behave the same.

Add the missing branch formats, as for kprobes.

Fixes: e8f4aa6087fa ("sparc64:Support User Probes for sparc")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---
 arch/sparc/kernel/uprobes.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
index c8cac64e9988..c8ba033427ba 100644
--- a/arch/sparc/kernel/uprobes.c
+++ b/arch/sparc/kernel/uprobes.c
@@ -97,12 +97,15 @@ static unsigned long relbranch_fixup(u32 insn, struct uprobe_task *utask,
 	if (regs->tnpc == regs->tpc + 0x4UL)
 		return utask->autask.saved_tnpc + 0x4UL;
 
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
 		unsigned long real_pc = (unsigned long) utask->vaddr;
 		unsigned long ixol_addr = utask->xol_vaddr;
 
-- 
2.55.0

