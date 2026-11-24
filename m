Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537610;
	b=a0s7Xi06htPFYO+GI906Qd/XMemaUlmGBKybq69sryXUm7dbygMjFJIgoctMPoxlEGGp
	 qrRvVv4e3x/hxKIj1EM7DD4zZ4HFD6q7w1ptpkBr1i9R5pBhHFqzs49wlJeU84M2iotAb
	 idftPvApCaEzYK2djLoq0PeIXOQTdqGGzcmG5COUDW3JBCnWVWqpwz3adAONVVxsWMkTx
	 MUaObtKiG3149DIiWOE9Hhqqg57NAtkNImkozkdYbjsUDHBFaqQV0vPn1wsgCYD4GjqdM
	 AclNSX9zwpv2lewcjjho9QR4qOE4oLG6el3EEKofH8PcSHoqJLjI4oLyYR7N6AyIpIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537610;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=LdrUCRKgyWrlQCpCtdOxSUchjxA4kk1c36K0/U5GGno=;
	b=5b6P1VTBNeMrzFuDb0ACXwJTMRhPETkyNIRRW8slbVQ1vDEoNwiN4NJqLH93duCmViqG
	 n5ZuDVKSyiweBuBn+FpUR0SXwMNQlGtIRv12W6pz/H01r2eLBJQCniiemHZOmy1JXoaq0
	 NPo1GLIxWDIXyVI99+gm40/7Q0E+db9BHRljIkzKjcWaRaLcIpIpLST88RFLT64Jm77v5
	 OQcrc53kbSdtRWZ4Ig5BM1QOFtofjBhTk6YOTkXaHauWc1gJjOBCE6uEbfMSKkLF8FdXw
	 0MhEdMPfQ/m0VlKTi16x5AkV32c0Afl8+PniTJ9frJfPHVFYs3qcR72g109611D3XKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=idXWi+UN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Xs7Q2bYH;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431E606A681;
	Tue, 24 Nov 2026 16:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7431E606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=idXWi+UN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Xs7Q2bYH
Date: Tue, 24 Nov 2026 16:26:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795537607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdrUCRKgyWrlQCpCtdOxSUchjxA4kk1c36K0/U5GGno=;
	b=idXWi+UN9vZkx/T0kETG9tXagsIq6kAh3RQV2amTsPEnTg+0X7oj4dCF5EpIesRKbq/uYB
	zV+ba3YS2ufJUq1lewA1vAGTznXipeipgt2GeLS46Yq1Nsw67lwdFvOyhHZfIRG9PQWbEP
	fw8Oa+LgaudzBL2dE4aGJjoog4h9FT1P0Mj7mMHDbtIfiUDC0YI2kqMOuxGrdVCBdCI/m5
	Z4dtiI+Jqlc/nzYBdDH67f+26JxNuxeo94I6oQ7eObHpFKmkGvNLA44qzoCVWjrDCKrrP0
	ubQ5ksnEmjL9szo+gdW/Ng8XzkUDAsj/lYTNvFKk7/OhRG6zLBjgfg9UZINZZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795537607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdrUCRKgyWrlQCpCtdOxSUchjxA4kk1c36K0/U5GGno=;
	b=Xs7Q2bYHvmtt+sAW3pFq+ApPXole+ZJwQ/rzb9qCewF8kYIOA8fcX9xM5ZmlckX2wOC+XN
	D6DpdiWdG36xudCA==
From: "tip-bot2 for Christian Brauner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/shstk: Don't warn when the shadow stack is freed twice
Cc: "Christian Brauner (Amutable)" <brauner@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261124-work-x86-shstk_free-v1-1-fc456c538e70@kernel.org>
References: <20261124-work-x86-shstk_free-v1-1-fc456c538e70@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179553760555.92412.15232234673704545601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     b1e6233ef68ff994c924fad46a728e7191175bef
Gitweb:        https://git.kernel.org/tip/b1e6233ef68ff994c924fad46a728e71911=
75bef
Author:        Christian Brauner <brauner@kernel.org>
AuthorDate:    Tue, 24 Nov 2026 09:46:22 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 24 Nov 2026 08:24:44 -08:00

x86/shstk: Don't warn when the shadow stack is freed twice

exec frees the shadow stack of the old image when it releases the old
mm in mm_exit_exec_release(). That happens right before it takes
exec_update_lock and before it switches to the new mm. If the exec fails
after that the task exits with the old mm and exit_mm() calls
mm_exit_exec_release() a second time. shstk_free() notices that the
shadow stack is gone already as shstk->size is zero and warns:

  WARNING: arch/x86/kernel/shstk.c:472 at shstk_free+0x7d/0x90, CPU#7: shstk-=
exec/120
  RIP: 0010:shstk_free+0x7d/0x90
  Call Trace:
   mm_exit_exec_release+0x21/0x110
   do_exit+0x1e8/0xc30
   do_group_exit+0x2e/0xd0
   get_signal+0xd11/0xd20
   arch_do_signal_or_restart+0x72/0x2b0
   exit_to_user_mode_loop+0xd8/0x560
   do_syscall_64+0x412/0x600
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

All it takes is a SIGKILL while the task waits for exec_update_lock or
for the mmap lock of the old mm. Both are taken killable. And a task
that sleeps in a page fault while it holds the exec_update_lock of the
exec'ing task for reading, e.g., in readlink() of /proc/<pid>/ns/mnt,
makes that wait as long as it likes.

Nothing is unmapped twice as shstk_free() returns in that case. So just
don't warn about it.

Fixes: 509ff51ee652 ("x86/shstk: Add warning for shadow stack double unmap")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://patch.msgid.link/20261124-work-x86-shstk_free-v1-1-fc456c538e70=
@kernel.org
---
 arch/x86/kernel/shstk.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index eb690ba..df5576d 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -465,11 +465,12 @@ void shstk_free(struct task_struct *tsk)
=20
 	/*
 	 * shstk->base is NULL for CLONE_VFORK child tasks, and so is
-	 * normal. But size =3D 0 on a shstk->base is not normal and
-	 * indicated an attempt to free the thread shadow stack twice.
-	 * Warn about it.
+	 * normal. size =3D 0 on a shstk->base means that the thread
+	 * shadow stack has been freed already. That happens when an
+	 * exec fails after it released the old mm as the task then
+	 * exits with the old mm and gets here a second time.
 	 */
-	if (WARN_ON(!shstk->size))
+	if (!shstk->size)
 		return;
=20
 	unmap_shadow_stack(shstk->base, shstk->size);
