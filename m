Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D503803EB;
	Mon,  7 Sep 2026 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772855; cv=none; b=dE5MbdKZanWQQCPbGu9Em5twbMgszQWicqaCGmYcT6jmQMihV/UmJUwMZEg8pam0sla58Xh/0tim+QQna/xXy55TJdftKEWXfkVo0uKq/6E2Z0Na13Jka6+zD/bjCAr1p0TNpJyMhUgia2juttcqLlQgXRVbmv9TNbEHG+ItEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772855; c=relaxed/simple;
	bh=eO701lbX3C5DHJYwfENHGPXPgUh8CZ+Pu9PQWduUm/s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XYCRGUDNxTboRcyj0J+FtK5690+B2wn37gb3HJzU/wAooR1GMMzcG73bzaFGkdbJTgtT9BT3hIJWbkeIP8neBQrQycLrr8NmBLLSTt0XxSA2zvRCCmSs1XLpTL4FWqfHCdsVQAf/39riyk0YtPqhVWf3axIYDVnAR2vEc4+OMOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0mqWwVLj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OZ/ioMZE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0mqWwVLj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OZ/ioMZE"
Date: Mon, 07 Sep 2026 09:20:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788772851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIh5pP6ywjSkbVM7jFloGpR+IHpa5cKguv76QPPAOJc=;
	b=0mqWwVLju4/i34erg/v4v90yx+rSAO7AlW7KQtOGpVwFLTe6RU3e5EUrMNtZOxrXksNNWH
	ROBroBu+Fr6CW1DpAd2jpoiG/Z+u2ZyDfPyLWNIFN0VCELBo1YC5Hw9UulwnvoLDP90b3W
	JJ0bd85dB8dlm9MLCy5ZY6hRQm7aijm8FLcypospLl7LmP37zAGHREoh6kYirWwsD0+ovT
	44zNRCKTxCz+sycE04ZnAsdKZTDesR+/8MPfWpmcbX/gf7f7NC+BJTcr7CCaXF8QF+YNC6
	idL+SRXADEFHBiaOqDZDY6YLsZMMF/HfApCVGq1JQc2ttZkvon5vOwWRkakmRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788772851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIh5pP6ywjSkbVM7jFloGpR+IHpa5cKguv76QPPAOJc=;
	b=OZ/ioMZE6BXYVd0UErDzsCRSXvDrL2fIJKU+DTgg0I3z8Bvb6O7Ee5P4EIPF72zdJVCu7m
	dzmsE42semyoVFBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] entry: Guard syscall_enter_audit() invocation with
 CONFIG_AUDITSYSCALL
Cc: kernel test robot <lkp@intel.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87tso45bqq.ffs@fw13>
References: <87tso45bqq.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178877284970.623050.384082963514653186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     954f7a48fa2ae7310c67729fb556caf726783436
Gitweb:        https://git.kernel.org/tip/954f7a48fa2ae7310c67729fb556caf7267=
83436
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sat, 05 Sep 2026 10:43:57 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 07 Sep 2026 11:17:54 +02:00

entry: Guard syscall_enter_audit() invocation with CONFIG_AUDITSYSCALL

A bunch of older cross compilers notably RISCV64 and S390 fail to eliminate
the dead code when CONFIG_AUDITSYSCALL=3Dn. The code in question is:

     if (unlikely(audit_context())
     	syscall_enter_audit(regs);

and in case of CONFIG_AUDITSYSCALL=3Dn:

  static inline struct audit_context *audit_context(void)
  {
        return NULL;
  }

which should make the compiler eliminate the syscall_enter_audit()
call. But a RISV64 GCC12 cross compiler translates that into:

        if (unlikely(audit_context()))
    1c34:       00000097                auipc   ra,0x0
    1c38:       000080e7                jalr    ra # 1c34 <.L785>
    1c3c:       c511                    beqz    a0,1c48 <.L787>
                syscall_enter_audit(regs);
    1c3e:       8526                    mv      a0,s1
    1c40:       00000097                auipc   ra,0x0
    1c44:       000080e7                jalr    ra # 1c40 <.L785+0xc>

and then claims in the failing link:

   include/asm-generic/preempt.h:54:(.noinstr.text+0x1a20):
	undefined reference to 'syscall_enter_audit'

which is obviously hallucination.

Add an explicit IS_ENABLED(CONFIG_AUDITSYSCALL) check into the condition to
cure this compiler madness.

Fixes: 6f25517010dd ("entry: Rework syscall_audit_enter()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/87tso45bqq.ffs@fw13
Closes: https://lore.kernel.org/oe-kbuild-all/202609031938.ZvZZaRQy-lkp@intel=
.com/
---
 include/linux/entry-common.h |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 6574b71..fa2854f 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -102,7 +102,14 @@ static __always_inline long syscall_trace_enter(struct p=
t_regs *regs, unsigned l
 	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
 		trace_syscall_enter(regs);
=20
-	if (unlikely(audit_context()))
+	/*
+	 * The config check works around broken compilers which fail to
+	 * eliminate the dead code in case of CONFIG_AUDITSYSCALL=3Dn as they
+	 * insist on creating a always false runtime condition based on
+	 * audit_context() which returns NULL in that case. The explicit
+	 * IS_ENABLED() check makes that madness go away.
+	 */
+	if (IS_ENABLED(CONFIG_AUDITSYSCALL) && unlikely(audit_context()))
 		syscall_enter_audit(regs);
=20
 	return true;
