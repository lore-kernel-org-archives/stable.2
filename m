Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815790;
	b=xO7ctXL3NRasgAMrmU4wFHQlHcQyt6jBnCQPltKRRsVjlvYcQ2q1Z7m7sjx76ZozMPPY
	 eaP50QH6VmTBzbcBnG+71xnAHXOx9QRIhfyRvJoP4uvqB69A7dvinHkLZUspDghbw0qEv
	 ZyLQ8TfMSbvk+X6rJx28DAH4yFVTNK8FrE28XjlGaiFw8mObhl2ojV0IvmQ5o/2poPDFl
	 kpvKVWFJZ5czpnIG3fnj+wAKNdJVsbr2z+cKCcmsmtPpNl9RmsaPGjTErTsn7f1bd4Ups
	 nHgwh9oq+TW/fd193QSj52CnZy1OIPw5rbhHAkaRMOF2TgdIiGtiIPuNp5KCmPX54eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815790;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s8nyuPESILDtZRyHcByevB/pS4xsxVlO2piAttG/xrU=;
	b=4p0YCEzMWwW5T2Y2U32PsHWphZSuIuyv9qNAZufhJjHwwfTyAsv0Yu9bLVpm3ZcJQgTj
	 CEy8ocnG8AeytkqdZSarIF8GyeD8ogpr33XscZDlI3zelkoCeZYrbnYmhIFQGUF2xnyXb
	 HOrg9nN2QfJSZ0IPSI/B8Bp5VjCIab8hxkNdocIr3ZLHAYiQocjGatua3Y9ob/x5EBDAQ
	 eDhMNg4ehwr2mDrsFSDlspq2UrWwhQ8ctUDvmlChmb3SiZ5s8UzaFaYqkAixN97p3l3d/
	 2UyS57200spECqUFy7UdiNzlgAAnL3w7tqtwZrtIqs9YJdYwVk8iIAjqC4ygKCdId8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hstizpVg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB19606D80F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hstizpVg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B771F000C1;
	Wed,  4 Nov 2026 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793815790;
	bh=s8nyuPESILDtZRyHcByevB/pS4xsxVlO2piAttG/xrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hstizpVgzJTtnZINo4ix4DhnW9/e0EOW7zYVuuA+sVszfRvQ28PIE+pLxPoDlmg83
	 JBUmHlQ1gWQBhRHkFvMV8PZnyhx2e07zckDKjvk7K1aNQkQ2fJujJ0VlmsVLON8nNW
	 uLMi3YXtAwIfiYw1zRqgd8m+5GQOOAZiRpmErPgAgVgRQarKiUB5GUd7OoEj7FXM6E
	 8e4ufzeFFoIkcj5qkhdtfDdW8kfo5P1Zz2TNNHjhe0Jo7WabxR0OH5jIef/DEZcrlw
	 FUMpxOn87ZfWGJWiuQJ1aZvTvic42rNy6QWBg8CKraGlavzqEdHKu/xpbFKQus5GBX
	 axwj6BO7ZopfA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 9D7F4198003A;
	Wed,  4 Nov 2026 13:09:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 13:09:47 -0500
X-ME-Sender: <xms:6nTrakR6t-WrIyHfCnMslBF-_aATTkIoO3IC-FljEvuV5jBWH__Pdg>
    <xme:6nTrahNLD3Fb28CYlkevcSC-NI36mLWDthoGG0T-mCxWecWsKZx3LjxKsD3_bcNT7
    sLza5_ytQfxCOOEN46HHlQtvxa0bbGghEdl22tdkaFMAvZVRlMc7xQ4>
X-ME-Received: <xmr:6nTrai4OpSQ4Pi1t9rLnukmoTL1AhN9D-4TKr2PawRNYMZlugUfJNtBxM_0>
X-ME-Proxy-Cause: dmFkZTGxPnPV7tjFAgTN5ziCectx9w+cnh/2pW+T5vdtufAnROjbmBRi2o4om8fZ99eb/O
    f0Op14B5vnrw1ktw2vSlvXD3sZMQoAwDJMAOyV1E4cIzEKUTW0wE2r1Bxp4/7PxUsVpP0R
    aiep1CRAOQ6mFVdfILr5iQ0K7uwetTR1WzpD6jYBl1cnkdIlSpDKtjgQYnE1a823DMb7bz
    mw1Qqa41iSHx42Mu7olm/tZBpddHgSi7ARZf7yQ9Ip3UhuBcU9Vswrp1hMyDIQuNi6MQY5
    uPmwor17GnKj7QMC4kFpYGY15FGq7IFmIS9P29r7LNg13aEboLevw6zj+rR2jj3pvD83qN
    C9dA8fQlHanOrNkWfuSf0qS/citP70dKTTHxAguVmcVUybkW7raaIrhIfrDz8gBlvnJ2wn
    fY7HK74a422uG2sal5UyVy2L1FKt/4Oax0LC9CGQxwzbMLB8RraHDcNiPoSTeWC/4OpSbO
    KUdCMLq0ft4SpLmoau/6vAWjDkNvbe7nKQx2u6OX9yRb1L+cJSze2RRGDEbnljLK7BEMrQ
    WzThhAWd5EMKVbr5cEIxftU4o0Euj62ZKVm31nqvvPw9ojkiogZs4zlEU6UPll8MB6yIaq
    uKhMRhEvZ3xu82UQFThQGqBtFH/g/BIGnUsn2R6MGEwAPsbBCuF1LGTGYyOA
X-ME-Proxy: <xmx:6nTrasXQFg8pK-8YwAPbhQ7-N51W1VQED2vGROs2yg399Ju4DpbT-A>
    <xmx:6nTrahNSx5h3AMCA25_Ow2T-Oyp-JNIys_PdxmYskkXBh8yCUvZEnw>
    <xmx:6nTrarjTsJoVsmMsQxdwRBPArxs8OaQPpCyDVO3aSejOsgzKHhPJoA>
    <xmx:6nTrav5_zJPMUeb6COCyAMAD1aMHkXQ2n6INeb5j0R16rIewHkfjMg>
    <xmx:6nTraqcS7J4gm4HG_Aqh2r_PC2Ga8hEmhVZj3ZYZg3Ct_vPqjUhRB8wX>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 13:09:45 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Usama Arif <usama.arif@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	Dawei Li <dawei.li@linux.dev>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] arm64: sdei: Run the event handler on the kernel vectors
Date: Wed,  4 Nov 2026 18:09:33 +0000
Message-ID: <20261104180936.2981070-2-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104180936.2981070-1-kas@kernel.org>
References: <20261104180936.2981070-1-kas@kernel.org>
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

With KPTI, VBAR_EL1 holds the trampoline vectors from the return to EL0
until the next exception from EL0 maps the kernel and installs the
kernel vectors. The trampoline vectors only handle exceptions from EL0;
their current-EL half is zero-filled.

An SDEI event is dispatched regardless of PSTATE.DAIF, so it lands there
whenever the CPU is in user space. The SDEI entry trampoline maps the
kernel but leaves VBAR_EL1 alone. An exception taken by the handler then
executes the zeros, takes an undefined instruction exception to the same
vector, and loops there forever. The event never completes and the CPU
is lost; RCU stall reports are the first sign of it.

RAS notifications land in user space whenever a task consumes the
error, and NMI backtraces land wherever the CPU happens to be. The GHES
handler takes no exception on its own, but any exception in the handler
path does it: a WARN, a kprobe hit, or a fault fixed up by a _nofault()
accessor.

Install the kernel vectors in do_sdei_event() when VBAR_EL1 holds the
trampoline vectors, and restore it before returning to firmware,
including when the handler fails. The IRQ-like resume into user space
keeps using the interrupted value, as it must go through the trampoline
to map the kernel.

Fixes: 79e9aa59dc29 ("arm64: sdei: Add trampoline code for remapping the kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/arm64/kernel/sdei.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 778f2a1faac8..9fa2a3aeed48 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -18,6 +18,7 @@
 #include <asm/sections.h>
 #include <asm/stacktrace.h>
 #include <asm/sysreg.h>
+#include <asm/vectors.h>
 #include <asm/vmap_stack.h>
 
 unsigned long sdei_exit_mode;
@@ -214,6 +215,20 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 	if (arm64_kernel_unmapped_at_el0())
 		clobbered_registers++;
 
+	/*
+	 * With KPTI, VBAR_EL1 holds the trampoline vectors from the return to
+	 * EL0 until the next exception from EL0 maps the kernel. They only
+	 * handle exceptions from EL0: an exception taken by the handler would
+	 * run their empty current-EL half and never come back. Run the handler
+	 * on the kernel vectors. The IRQ-like resume below keeps using the
+	 * interrupted VBAR, so it still goes through the trampoline.
+	 */
+	if (arm64_kernel_unmapped_at_el0() &&
+	    vbar == (unsigned long)this_cpu_read(this_cpu_vector)) {
+		write_sysreg((unsigned long)vectors, vbar_el1);
+		isb();
+	}
+
 	/* Retrieve the missing registers values */
 	for (i = 0; i < clobbered_registers; i++) {
 		/* from within the handler, this call always succeeds */
@@ -221,8 +236,6 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 	}
 
 	err = sdei_event_handler(regs, arg);
-	if (err)
-		return SDEI_EV_FAILED;
 
 	if (elr != read_sysreg(elr_el1)) {
 		/*
@@ -233,6 +246,11 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 		pr_warn("unsafe: exception during handler\n");
 	}
 
+	write_sysreg(vbar, vbar_el1);
+
+	if (err)
+		return SDEI_EV_FAILED;
+
 	mode = regs->pstate & (PSR_MODE32_BIT | PSR_MODE_MASK);
 
 	/*
-- 
2.54.0

