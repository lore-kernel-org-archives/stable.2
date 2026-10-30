Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348299;
	b=RZyzc2FIjuk/nVEJu3gthMuBMsr8g+y8f2kZXedZ1IHFQOrYVboE9S08G+brnbg3QZ0Q
	 ITvcYejJM0k3u4eYehrjPYKunOxs22oR7693u4gYVdbom0FMSH+l1Cnnh++ouM8KJw/QD
	 n2n7YzL/BEBL9ss4+DscXa0pRHrsR1mnyTgBLno9RlWoIwlh8lpHh5o5tBC7tPfuuWfnU
	 d6oCVS+5asSua7OmWp6W7bByKHJ3T+XXTDzcaCnXcJHDgHofO4qqESxje/yPmqEQXjFE3
	 49hOUtAkAg6Oet/YPUX6Un+gpOIPOS+Tngnwkuu5gZl56FOA70q0k1mCnnzIStWSnrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348299;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yjMdRQDa0BKiCjyBLxfnEtlG7A95NJovK+UaME+7Qrk=;
	b=rMNeZXeSQq9oVPid7cIc65qcuVtevY2lDW4kL/WzgIoEqcQiI3Bp7qCYFUtM9lnQ0zcR
	 m9ukASeDQtuF5Hp0wrAj0f/C7Bzj5hMj+i3CAu5dB1XG8Vs2PMFGnWu0s1JsFczX41eDY
	 g9IvdTbL1Cm2AzQaNylhhg2JHwdkm8c4pbWdEVqnItIiwqGk/aXuZKxbkCdYA0uxU5Bep
	 XnCkvUMeHHRJakqWIpeBvD7LKS9Qg3WFA8Fn1WJMEWdTgrKE2GPokwDBo7ojCyOxpTdfV
	 VuJFYto55CAF+lQbjmXrNw9hmOG2TbL2vxmuX9H9eYAcKX4c/bhQpaEXY9yWuvUTmjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=rxt5i0Th;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6F606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECE6F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=rxt5i0Th
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 151311C025E;
	Fri, 30 Oct 2026 09:18:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1793348298;
	bh=nAKASWeLvsdxgMY7KJmCSMlmE5AQrN3mfo3HXClaYIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxt5i0ThsNrl23thNy7cTr9bABZU9b3fe2/C9Lvxnj3av9MeTIKy9j1+BDyrVDscf
	 X4BL3SwNKryEjF/bh30OUT8qgNRbbXY/sjaegbjwX6KXNhoBlQF4UHdWURi6hor9zY
	 LsB7KoQF5A2AevA9o5orNX+mXA4Ez7bI0D4u6Enk=
From: Renzo Davoli <renzo@cs.unibo.it>
To: 
Cc: Renzo Davoli <renzo@cs.unibo.it>,
	stable@vger.kernel.org,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH v3 2/2] powerpc/syscall: Return the preset value of skipped syscalls
Date: Fri, 30 Oct 2026 09:17:55 +0100
Message-ID: <20261030081757.1065832-3-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030081757.1065832-1-renzo@cs.unibo.it>
References: <20261030081757.1065832-1-renzo@cs.unibo.it>
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

