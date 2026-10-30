Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350179;
	b=lp8EFIe1QdZVcJ4CW10tUY28AZ97z+sKJ0IlZH/a+mM3BuF2TZ70XRI9KVtUXBQX29TC
	 2mcMicwWiC/jDZvO3X99hK+1UqU5OPfac7Rxb2LcixGc9ktepNAYtE5hbSmFOydhqB/0H
	 80n2yydrfpel7Q5FzrmcRM8elo53ZusBHHg02LYHLLagR3TTdoqheG7W7piUone9nuyzL
	 W7+ZaNWo5o/HzbnfGIZkRXN8o4aON9hB84y+l3BSOv5YWcfbh5CBp3nv8iTpEGmh98rVy
	 YJmFASLNVqt297DJ5D8eoSC9aaeJy3ouTrAowRSwEkxVT+OJ5Nr2JkrDgigGvzcmG7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350179;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yjMdRQDa0BKiCjyBLxfnEtlG7A95NJovK+UaME+7Qrk=;
	b=ol2JUyVih50L0QeZuCXp0Ruf4WtEiFEOLrj2642MjvwbTHesbDC81sLfFeTT9YqtjcpH
	 HHiqEehFE9cOLGXyu7HMeeiJsNLX2ubjqz61cSO2EQRd8JU7+q3WAOEYtHtKqZQkgPY4Q
	 S9i8AcqSfFrcFmnNiSheVhNo83+ijEGQp2To81+oGDn65ZYXo+HhNBfNzwqn8IsITSLG/
	 nKBkaig3AnjP1igwq/a2oOaJ9ckWzQQBfEMQbA7osivANfQ7L/LeWGxVxS+LfWLTVr+hE
	 NmcFFGoQI75Uw2HZHM0MEtBcbd+DeI1CfF20wWRtpcxOkaN4DGNcs49FUXIMFm/vMLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=dQidhxzT;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D63A606A323;
	Fri, 30 Oct 2026 08:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D63A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=dQidhxzT
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 2D96A1C025D;
	Fri, 30 Oct 2026 09:49:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1793350177;
	bh=nAKASWeLvsdxgMY7KJmCSMlmE5AQrN3mfo3HXClaYIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQidhxzTAJZ2Z8XUUUbgPOCm9zpmY7boSUY9h9rxbTpGWRum+I27qOoWJsEa5NJhu
	 hZvPmcCZ2ilUKxhjOrp3sbKnmYiSsz0A3Tsm3IuRyOYTkBmsFXYg/10hFn9McXNTAp
	 vmFhWdetaz6QgEXdyKZXJbYm6Y3QeBpZHX26ZDfA=
From: Renzo Davoli <renzo@cs.unibo.it>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Renzo Davoli <renzo@cs.unibo.it>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] powerpc/syscall: Return the preset value of skipped syscalls
Date: Fri, 30 Oct 2026 09:49:25 +0100
Message-ID: <20261030084926.1068384-3-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030084926.1068384-1-renzo@cs.unibo.it>
References: <20261030084926.1068384-1-renzo@cs.unibo.it>
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

When ptrace or seccomp skip a system call, r3 (and CR0.SO for "sc")
already hold its return value, set either through
syscall_set_return_value() or directly by a tracer, e.g. with
PTRACE_POKEUSER at a PTRACE_EVENT_SECCOMP stop.

Since commit 05c033db7e9a ("entry, treewide: Make
syscall_enter_from_user_mode[_work]() indicate syscall execution"),
system_call_exception() returns syscall_get_error() for a skipped system
call.  syscall_get_error() is 0 for any non-error value, so a success
value is replaced with 0: the value set by a tracer, or the val of a
SECCOMP_RET_USER_NOTIF response.  Among others, the seccomp_bpf
user_notification_* and TRACE_syscall.seccomp.syscall_faked selftests
fail.

Return the error from syscall_get_error() if there is one, and the value
in r3 otherwise.  The error path is unchanged, and a success value is
returned as it was before the conversion to GENERIC_ENTRY, when
system_call_exception() returned regs->gpr[3] for a skipped system call.

Fixes: 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall execution")
Cc: stable@vger.kernel.org # v7.3
Suggested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Assisted-by: claude-opus-5-5
Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
---
 arch/powerpc/kernel/syscall.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index f7412556a9e8..7b35b895b70c 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -19,7 +19,14 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	syscall_fn f;
 
 	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
-		return syscall_get_error(current, regs);
+		/*
+		 * The syscall was skipped by seccomp or ptrace. r3 (and CR0.SO
+		 * for "sc") already hold the return value, set either through
+		 * syscall_set_return_value() or directly by the tracer. Hand
+		 * it back in the form syscall_exit_prepare() expects: -errno
+		 * on failure, else the value in r3.
+		 */
+		return syscall_get_error(current, regs) ?: regs->gpr[3];
 	}
 
 	if (unlikely(r0 >= NR_syscalls)) {
-- 
2.55.0

