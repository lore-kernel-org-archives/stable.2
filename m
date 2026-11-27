Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795744495;
	b=wI3K9TzQjwHawrb+rmtYYOlk6f2/99u6pBzjBfJSPf7pr3JLLGzMcapSPa7wlpXDF3ab
	 EgJeULcDWjJYEbItZtKhn3pOwxYAt9edwKnf+XRRdIzYmqojzU9aYt75WYgRModg04KE/
	 DSed5NJkOA8zHnH0D0vept+aqI5QcZTcNdqpCxGNHfBAhtPJpTpp84IlZyNQK2/Ltmk8l
	 jY1DLpk5ISIeNEa9gW+11S4d8TATYkN255J+oZyeLEiqBa66F3c6aH+Rxn43KkeDzptjz
	 A+L2IyVaz2o32s2q7cnlZgfChk2KmtBs4Ip9EOK0MR+uzO+OPEmf56SeX+k9nug1+fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795744495;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Vhf5RHVu1JkDanSJjY0gxQGMSgP4WDW2Fmq6j2ZYc7o=;
	b=zfSMn+1P+MxclQbG5xUEmJY1NFt3if3q0TTx3SD02u09QhxyDFhwRef/7g7Zgkte9jIk
	 wOaZr/Y3zKm/J0qXM/nvFWFXqO48MsCoDk6B1c3FSwpTI7yqNMu2rWnxvd8VlmmJMjfVu
	 xvgCzOnQP0fQpf8ULSBmZ49kLeP+Kp7evL+smy1YhfdmtIFHToDQsZC7s4Ml9KFB3Ml0C
	 AANf7RaTrKrug5w+ez627kZxpC0r1HcWqU5SflS1U+PoJrwO5KGdWXSjVylRc57WDOgEj
	 fjDpUzE7p8+L8Djl9vt3uXHa1ROxLDVFteD2wgKGqmYSYT97OgcsTjQmU4/wvADMOnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=UOu4L2rS;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1vANKWJy;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FE5606A31E;
	Fri, 27 Nov 2026 01:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83FE5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=UOu4L2rS;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1vANKWJy
Date: Fri, 27 Nov 2026 01:54:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795744492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vhf5RHVu1JkDanSJjY0gxQGMSgP4WDW2Fmq6j2ZYc7o=;
	b=UOu4L2rSCFpOiSj52sxlTWsYSAbGwuD1lksvZjt5cXkiB2o4/Uj0wisA4cLNvRfL/G2Qrc
	HDH2QexP4YXAtb3jDq8Y4RTn48fCtD2BnR1Ld9y7opZntYHbPAAm203wchzFy5cC9/3EaR
	L2BtUOG1Es40lSVpMnsUaX9xy2zikDlxyYLA0KLpPNtBa3IfpvdBKdeo4rRjuStp/hlBFh
	T8XmIO7txpmQbDG1xn4NQLQJ2EH83WTlBVxAHcja01DAjj73kV/RcKU/G+iw5wMP9j8aoF
	yuXEajVZYbeF1aLQcCuL+z4PILNOQPCPlZSwxTHZ6gC3ope43ieVXgED68InBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795744492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vhf5RHVu1JkDanSJjY0gxQGMSgP4WDW2Fmq6j2ZYc7o=;
	b=1vANKWJycP8bY6XF/+NmEMt922cXuGfvdzDI60XxNidZvwJQ5T5ZuOqjJQjQZ3UDL7Rn5j
	mud44uSryna3lBCA==
From: "tip-bot2 for Tina Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu/hygon: Work around XSAVES Erratum 1386
Cc: Tina Zhang <zhang_wei@open-hieco.net>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Zhen Yang <yangzhen@hygon.cn>,
 Qiming Deng <dengqiming@hygon.cn>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261127003818.1208038-1-zhang_wei@open-hieco.net>
References: <20261127003818.1208038-1-zhang_wei@open-hieco.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179574449039.92412.8155622661498767085.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d430c96a291a9c2e7f9a279e8bf9ec252d18c4a9
Gitweb:        https://git.kernel.org/tip/d430c96a291a9c2e7f9a279e8bf9ec252d1=
8c4a9
Author:        Tina Zhang <zhang_wei@open-hieco.net>
AuthorDate:    Fri, 27 Nov 2026 08:38:17 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 26 Nov 2026 17:39:54 -08:00

x86/cpu/hygon: Work around XSAVES Erratum 1386

The XSAVES malfunction described in AMD Erratum 1386 also affects certain
Hygon Family 18h processors. Under specific conditions, XSAVES may fail to
save XMM register state, allowing stale register values to reappear after the
state is restored.

The failure mode is documented as Erratum 1386 in "Revision Guide for AMD
Family 19h Models 00h-0Fh Processors", Publication #56683.

None of the affected processors enumerate supervisor XSAVE state components.
XSAVEC is therefore equivalent for their enabled state components and is not
affected by the erratum.

Family 18h models 00h through 06h and model 10h are affected. Other Family 18h
models contain the fix in hardware.

For the following model and stepping combinations, the minimum microcode
revisions containing the fix are:

  Model  Stepping  Microcode
  04h    0         0x9040000f
  04h    1         0x9041000f
  06h    0         0x9060000f
  06h    1         0x9061000f
  10h    0         0x91000004

These are the only known steppings for those models.

Disable XSAVES on affected processors unless a matching model and stepping
entry identifies a sufficiently recent microcode revision containing the fix.
This allows the x86 FPU code to use XSAVEC instead.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Zhen Yang <yangzhen@hygon.cn>
Tested-by: Qiming Deng <dengqiming@hygon.cn>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261127003818.1208038-1-zhang_wei@open-hieco.=
net
---
 arch/x86/kernel/cpu/hygon.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 0bccb93..ea37c48 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -10,6 +10,7 @@
=20
 #include <asm/apic.h>
 #include <asm/cpu.h>
+#include <asm/cpu_device_id.h>
 #include <asm/cpuid/api.h>
 #include <asm/smp.h>
 #include <asm/numa.h>
@@ -170,11 +171,39 @@ static void early_init_hygon(struct cpuinfo_x86 *c)
 	set_cpu_cap(c, X86_FEATURE_VMMCALL);
 }
=20
+#define X86_MATCH_HYGON_MODEL_STEP_UCODE(model, step, ucode) \
+	X86_MATCH_VFM_STEPS(VFM_MAKE(X86_VENDOR_HYGON, 0x18, model), \
+			    step, step, ucode)
+
+static const struct x86_cpu_id erratum_1386_microcode[] =3D {
+	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x04, 0x00, 0x9040000f),
+	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x04, 0x01, 0x9041000f),
+	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x06, 0x00, 0x9060000f),
+	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x06, 0x01, 0x9061000f),
+	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x10, 0x00, 0x91000004),
+	{}
+};
+
+static void fix_erratum_1386(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
+	 * certain circumstances on affected Hygon processors. Clear the feature
+	 * flag only on microcode revisions without the fix.
+	 */
+	if (x86_match_min_microcode_rev(erratum_1386_microcode))
+		return;
+
+	clear_cpu_cap(c, X86_FEATURE_XSAVES);
+}
+
 static void init_hygon(struct cpuinfo_x86 *c)
 {
 	u64 vm_cr;
=20
 	early_init_hygon(c);
+	if (c->x86 =3D=3D 0x18 && (c->x86_model <=3D 0x06 || c->x86_model =3D=3D 0x=
10))
+		fix_erratum_1386(c);
=20
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
=20
