Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658003;
	b=hDapdp0HYDiR3oyt1j5KUA4QeaB4e5Xz/NjAK0KzFP0HbXkd8ml160w8HcnUryJ6ztFg
	 8mZbhyGHS52l7bddtWZ29fIpKeqCOY+mj3gp7UJBr0cSMJkJt0RhKhpU1P3Ttqw/Sptea
	 nX2CvFTd0Pbj3xVy4f+Zv1KJ0dHbhvnzM24FLe5hRnTk2JflOUe/9JaXSW9LoxaJnDipB
	 nmKuFRt5mw/Kzdmj5EdG1PBWfWNtXqUqoKEmLmAsChrAiK11jPRL272squ/ozjF3tdMom
	 XBFx444l294HfiEc6WUDheykFwC9yvPprBhGv9Sw41yTvX5udSzZtQIBUIesePXf+eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=htbP1Be5/tb7LgqEiuAX137LQm3n+SjOO/0MPt6z5aM=;
	b=gIBur1C/68eOKzfTEpITRyiFdmSOORB8LT1ebszxGf1aPBSyyl+LWzVXfWj2Yc+L0q+Y
	 g+kHQf21AForuamdDxCz9/g1lpEhHbWCbAlWzpS2c0a2RPCIlRdlacAyh69w1SryXUBBg
	 sVM2PqkZuZppe5yHGjiupkzvdxNoZZLwjdUbBTInzk2Rmyny1h4sH4gR5loGQgfaUGi20
	 M+Pj+9twfV8MS/afNsJC7Ygslc/ZNQAX6FVau4IEeGaLnkSpeVFKPMaEKap1IUzAOFkGr
	 ilvBvUuL96Z7uAnFZqaHz9UZGpf60FD/VpVKFsQFDKdTOu4M9xmXQ8lsavXrfcA/oDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZvbmRVbB;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87693606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 08:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87693606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZvbmRVbB
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1274325a91.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 01:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792658002; x=1793262802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=htbP1Be5/tb7LgqEiuAX137LQm3n+SjOO/0MPt6z5aM=;
        b=ZvbmRVbBIRxBLMdiu6sXsqn4FUagcLZYqMBg7GsnI33T70PtyPdF4VG6wkFZLnBo7n
         Fh8b15/yDRJfZwdsvWRIRyG1Eo4LZCR7/BDQJET+hY/u8EocLSSkSB8s1hJ4GNiDitta
         r51I7MMr6PVnw4CNUYZ8MY1HQVzwu2SHXV7AH8JABjHN9w+1onISaV/8sDcRmztxYmUP
         +euotQWgKrZY+fAkv4OuSbyrAQH8MRutJHhBa/06gXfGS3yEeHd2CDXW3PNcmvbIres9
         jxE5lIU3/8VxELzYklGO2zh0pWc3DQ3z/bPgRN4Ka28NJRa++/JzMO1CZt5pLYKPKFYT
         Vfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658002; x=1793262802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=htbP1Be5/tb7LgqEiuAX137LQm3n+SjOO/0MPt6z5aM=;
        b=C1Ksr5qK8ma80/BFuhHW3MpRnDBFLSJYxUDFPdR0eL4wClxW/EHAVqErlZutaIC3tb
         XmlPikI3KCyOuxMkFQLC4x565aafRIwcXCj5O0lrz1e4G3ROYKniPysOqkNH55HJ+rGA
         700re+WUt5g8mFJG/cZ5hF3hcceghLMDnFfUNkiVQRBOXawg/ik6BMHZV/YL2VXu4NrH
         aV6946DMt9fTgxwpwsmancWtKqUbc2kBhdHky1uWQYkzW4auU7O9xQKGKoAleQwU/cOn
         CXSoDyBtS8YObP0RVQj8sDJN9USM6xVgPQD9aeYTAANRFY3e4G3n+SpQOZaWVf8lumqN
         mveA==
X-Gm-Message-State: AFq9FYKyN4E5GnBcT0MU5I2k7d/4e1pdcnk2OdybtMUeRKZ5SbRJ6rCq
	uTFKqFO85OfxW+7QiPY9OeUA6oADORv5xik6x5vh1l6scZR1UW0C4RgVTsFRWjOvDog=
X-Gm-Gg: AYBFou31+vH8kVgWL+X1mCEnmOHvG51H3yjHMa0uoXgt4cjg7HdgdgidrPBglQyH/9q
	9Q1g9mGQHcVIhMJL6irm9qKWahtSGrmGx2BshiWNaTFic/JsWCE7mbEIvOYDKTt+VwS3Vi5KFhs
	Ri5Vv7yLRiXrWAW5vN0/0chY/1GHyGtGjmRyIsg1pFKH5Rb7jE9DxePWh25+vtuPCjCrc36DPzF
	PINKuoumum2jI9c34/9P8Y/vEXykHEYU1BW/TJw06S+RKEfhRvZyn9+bIpDTERdTM5Nuxid4p0M
	oadTNfnOZJQ2JoooB1JBvLldw8JRR8XvT6nH2Rs5O7crzxWwEmR1nGtZ1rAuiAvZpdP+YzyKq+3
	XEV1I7WXoFXTdPDTGPVmQT50e3MrMW3CvWDnvVwvKpSMPoDKG+5cAmflXTKNotKe55zmoJv4aJ3
	9ByrXylGNQkCmaa+VrWCGT289jQSgiauosGReWJeWgeHrWMRbKtU6SXCFhO9ChABEQxg6tQQ3Hm
	dfrtL3ARYBkF4qURaVwU3tLHQFCmSvtmfkpqkw5WPF4kFvCQasefQ3EvpQHXUDLFOBt/eqJxJAC
	9ka8imErqw1MkeFZgA==
X-Received: by 2002:a17:90b:48c9:b0:3ac:c23f:cf51 with SMTP id 98e67ed59e1d1-3ad8708b8demr3966898a91.49.1792658001786;
        Thu, 22 Oct 2026 01:33:21 -0700 (PDT)
Received: from FR9WL0RHKY.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4887669sm3302053a91.2.2026.10.22.01.33.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Oct 2026 01:33:21 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	zong.li@sifive.com,
	wangruikang@iscas.ac.cn,
	debug@rivosinc.com,
	qirui.001@bytedance.com,
	cuiyunhui@bytedance.com,
	guoziyi114@gmail.com,
	samuel.holland@sifive.com,
	ben.dooks@codethink.co.uk,
	cyrilbur@tenstorrent.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] riscv: Fix SR_SUM leakage across context switches
Date: Thu, 22 Oct 2026 16:32:12 +0800
Message-Id: <20261022083212.84721-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__switch_to() saves the sstatus value of prev and restores the SR_SUM bit
of next with csrs. However, csrs only sets bits. If prev has SR_SUM set
and next has SR_SUM clear in its saved state, the old SR_SUM bit remains
set in sstatus.

This lets next run with user memory access enabled even though its saved
SR_SUM state is clear.

Use csrrc to save the sstatus value of prev and clear SR_SUM from the
live CSR before restoring the saved SR_SUM state of next. This keeps
prev's SR_SUM state intact, while preventing it from leaking to next.

Fixes: 788aa64c01f1 ("riscv: save the SR_SUM status over switches")
Cc: stable@vger.kernel.org
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/entry.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 61b7a77166971..628b85e3915a7 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -443,15 +443,15 @@ SYM_FUNC_START(__switch_to)
 	REG_S s10, TASK_THREAD_S10_RA(a3)
 	REG_S s11, TASK_THREAD_S11_RA(a3)
 
-	/* save the user space access flag */
-	csrr  s0, CSR_STATUS
+	/* Save and clear the user space access flag. */
+	li    s1, SR_SUM
+	csrrc s0, CSR_STATUS, s1
 	REG_S s0, TASK_THREAD_SUM_RA(a3)
 
 	/* Save the kernel shadow call stack pointer */
 	scs_save_current
 	/* Restore context from next->thread */
 	REG_L s0,  TASK_THREAD_SUM_RA(a4)
-	li    s1,  SR_SUM
 	and   s0,  s0, s1
 	csrs  CSR_STATUS, s0
 	REG_L ra,  TASK_THREAD_RA_RA(a4)
-- 
2.39.5

