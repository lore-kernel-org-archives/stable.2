Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793921977;
	b=2BUD9ZvLqpZdKNI9BHN1pqt6WFKQQfzB8UzAom7JjmWgmgmIZG7zOad4omGMvDHKwXl1
	 5prijCGraSb7YsvXBFxHTozcy2hygTne/lvqOT5Dp2QTyT45xKOWwiOXnxifKdPan23VG
	 VTG57/fQE7KbheRLch4t1e77mV+gww74qb1dj0Hgl04kjmj8IVMNTGDc26H0OzEopoelc
	 SDJihzrl+IBUfrQ/10Sb4REaFW8cVSKJ5AQKA6ClogNglB39LEtpsVEpP9Srsy4cIIQst
	 1dHc1pozvmlTfWUa872LdEfapY8yZduL0awFgeTpelWwSnwVfoMZXv2i5t6xtG0VeZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793921977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=woK+qirorynDrr5d7z7iL4ZXS/COXdEm5QdLCJDF7e4=;
	b=T0Aqd2qUIJY12vNxSuLvV9Y2udrys0tkQL8cphg1F4vFeu70C/JsFb+ve4II6oRkXR9/
	 fwaDz80yqAeBM+ZLUpPvA8Cau50ld8yslz8Aoa+oRWYc6StE+Iq8WgMk+0T/LNjeSa/i5
	 5xvfXKLwJEtLBk6S1peursz85xpBySOjuZ9qUeJ6f7uadeJmtiAbDrPxw1aHcpMosXUMC
	 iGbhxmXLxt0PMwz27gpG5AA5J77aO7chFFqzBnHD4vhQvlusQ+YlrOH/lftoXAyLgzSeh
	 o+ZBX9htfx/9V7l+jLOlRKc5pRFaUaCqs1OfnyOzEoxan4/0PfLSfOyMkX1ect8RHVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KB7lyczc;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C1D606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 23:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1C1D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KB7lyczc
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b305e10ac7so5507b3.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 15:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793921976; x=1794526776; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=woK+qirorynDrr5d7z7iL4ZXS/COXdEm5QdLCJDF7e4=;
        b=KB7lyczcterb5EVDV1+oFmoxQ3O/bNfMIu7oa0nVQUBwdl7IT84IrRp264QeqWjSnz
         8d1touPbAujLtfx2v2javOBmQDAueGpyePGs9seWxjszh+mt0rbF2mIC6IvkSPMwI6oF
         kZ0EcA13tH7pWzPdWZy6lLMSoe70WOXxzJRR2kPXRNPw8AQt7AjT/CpWBmenwOE+3fDC
         JSsqMq8XeKezNlH6e2flXDU4Ou9ux8wNNB82A2br8tp3Uucni4dP/eeKl9i1SiVc1Ei+
         Lx0psS3lEyTJqWCsKpgL8STF6CBUIWhxXWAPTOHvq6AodtVR/oaoakwC7RfdsTU6VScs
         zZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793921976; x=1794526776;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=woK+qirorynDrr5d7z7iL4ZXS/COXdEm5QdLCJDF7e4=;
        b=DC/rhR2FOBxd6qW9v3Bc8AlNk0nEYIX5jtsoBRhr97738z9QZU35I65bc2AZqXc/sv
         /mqkg2p0fPdlB4ONtai4dzoDJ01MOCXBd7X6f5kD4nEAqO7b3q/qdoOM8JSCk9qg6+fc
         ng2GYBPxv6/emzj6rHN2YPKooZDX5hu8sA5JtKLEKyq4AEOmykr8ThTHximjd+QdNxDt
         fq1sGCS6n6vwijfylDpVmm2lCapCtV8EDla9jMp8Y0XFvuooHlcLAxRVW6fhc6jJ66oD
         ZjMu4YbyJfp5XMTxY9t803wp09C8i9iCfq0gVjksCAckmBIj3GoVNvLhgKxfxceOesN4
         gVSw==
X-Gm-Message-State: APuU4Z+my7DkgAY9wMGNmzC3QSjx4SZwSkfqPsMeQJRqRkfCIjNAI/s0
	M/eMspj+ywurM1oMsQ2+GtB3sw62iexQV/lPL5UUiXoT6gQxlL6nYK6A
X-Gm-Gg: AYBFou2/fofDpwsv3QOu4+d2UNsrRYSqtUFzkgcX17aJHfcUXhr+0t7c6xri0uxP7md
	TUdcG5QijDyEynCuxcpAkBzsPNG9S00grB31OXbuEz3vV7F195DKdq9Skr/oPbk+ctxy4g7m8h9
	iRlMcPByvoQdYlz2J7xEUgArbZmAXiUK2J34H6s02IXssaKmHTwS2ZqZHsSfsyqhx2a5Eaq99wy
	sO38lICBtuzOUi2AI7IlmUmP+M0iVyM7yFSf0pKdiB6Tvc7sJP09sb5volbRVaVw1GrzX1mE2tv
	ZutKgGa8dNmtNPtefGstPb9JXO2Sa6xtK4llgxb3DwyccDsH/kGal8+STylyPKkq55V1qLgSAS9
	b7q+MVpCzyaRABs1VhOPE0jDRN/QmlmmTwwEJyJ7z6hiljYibNLtmtdFrB83YKYrTxkGBoeDppq
	kMf4VbMWfUP5g1ypye+e2JS+5G0E9KVM2cU8OqpwCCZA3KxLwGFAlLHruC8cND8sltq7VEjMujl
	4MAC7ZZYdmOzlMaGqLxGL3ju8jcB+j47y/hrbDqryf/GTh4Gs7rpfTYXormc4TtsCTiO4t7x7HB
	YyctKu5u6gvM8M75KKzL40Ynv2kGio/iAekk8bSzjXQE/0+tWivwkSyTSLf5F04sltmn6kiW05J
	9egR5yYbcjw==
X-Received: by 2002:a05:690c:c186:b0:873:5c0f:28b with SMTP id 00721157ae682-8b341b07068mr3614947b3.53.1793921975579;
        Thu, 05 Nov 2026 15:39:35 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f76dba8sm7031867b3.13.2026.11.05.15.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 15:39:33 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 05 Nov 2026 18:39:32 -0500
Subject: [PATCH 7.1.y 7.2.y 7.3.y] alpha: honor
 force_successful_syscall_return() again
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-alpha-force-success-fix-v1-1-8c26d60c5fff@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNywrCMBBFf6XM2gl50AT8FXERpxMbkbZkrFhK/
 72p4u7cy32sIFwyC5ybFQq/s+RxqMKcGqA+DnfG3FUNVltvjG4xPqc+YhoLMcpMxCKY8gd9l4K
 nVmvnItT2VLja3+ULBGXUcrhB2T+4CtdfUObbg+l1/MC27YRZrWWUAAAA
X-Change-ID: 20261105-alpha-force-success-fix-6df76c50033a
To: stable@vger.kernel.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3339; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=R5BmElxCOz7tstc3VwF/l9JGbmj8ke7bchwOwCPOTIk=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLeCm9+7/tGdtZxUQW/S5P5qm/VmHF0Fmg9W2uw+pPi1
 fVvlNc/7/jIwiDGxTBTTJElbr0iy6y2HUt9Tkv/gpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHaN4iJweg0ZmcXFpapFuWkGRQ15+SWJJZn5esV5+QWpeQXqBXlpmWklGRn5RcSrQCL281BJ
 TV0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0tzBi5OAZhr/vAy/BUvZnf2W/
 /YS7Tp3LIpTftff3hV5vqmav2WPaL1Z/a6J8owMtyZEeD02FZWfS9rZjxv+i6LByLtN2oyHG+Wx
 m9f4fnuATcA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

This fix is for 7.1.y, 7.2.y and 7.3.y only.  Mainline is not affected
since commit 83bd31c2840b ("alpha: enable GENERIC_ENTRY") in v7.4-rc1,
which replaced the saved-r0 check with a flag in thread_info.  That
conversion is far too large for stable, so this patch fixes the old
entry code instead.

Syscalls that return data rather than a status, such as PTRACE_PEEKUSR,
PTRACE_PEEKTEXT/PEEKDATA, osf_sigprocmask and shmat, call
force_successful_syscall_return() so that a result with the top bit set
is not mistaken for an error.  On alpha that clears the saved r0, and
$syscall_error and $strace_error used to check for this and take the
success path.

Commit 55b22075f784 ("alpha: add support for SECCOMP and
SECCOMP_FILTER") moved the restart syscall number to r2 and dropped both
checks, so any negative result now comes back to userspace as an
error with a3 set.  PTRACE_PEEKUSR of a register holding -1 fails with
EPERM, which makes sandbox abort when it traces static binaries during
Gentoo package builds, and PTRACE_PEEKUSR of a register holding
0xffffffffffffe000 fails with errno 8192, which breaks unwinding of a
ptrace-stopped thread in elfutils (run-backtrace-native.sh).

Restore the checks on both exit paths.  On the traced path the success
path also has to stop falling through into
SYSCALL_SKIP_RETURN_RESTART_GATE, which is meant for skipped syscalls
and would turn a forced-success result of -1 into ENOSYS.

Link: https://bugs.gentoo.org/985765
Fixes: 55b22075f784 ("alpha: add support for SECCOMP and SECCOMP_FILTER")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
This is a stable-only fix for 7.1.y, 7.2.y and 7.3.y; it applies to all
three (with a 16-line offset on 7.1.y and 7.2.y).  Mainline fixed the
same problem differently by switching alpha to GENERIC_ENTRY in v7.4-rc1,
which is too large to backport.
---
 arch/alpha/kernel/entry.S | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index 9f2608de2544..fe88cd598492 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -603,6 +603,14 @@ ret_to_kernel:
 
 	.align 3
 $syscall_error:
+	/*
+	 * force_successful_syscall_return() zeroes the saved r0 (the
+	 * syscall number): the negative return value is data, not an
+	 * error number.
+	 */
+	ldq	$18, 0($sp)
+	beq	$18, $ret_success
+
         /* Restart syscall nr comes from saved r2 (preserved even if r0 overwritten). */
 	ldq	$18, 16($sp)	/* old syscall nr for restart */
 
@@ -700,9 +708,11 @@ ret_from_straced:
 $strace_success:
 	stq	$31, 72($sp)		/* a3=0 => no error */
 	stq	$0, 0($sp)		/* save return value */
+	br	$strace_leave
 
 $strace_skip_call:
 	SYSCALL_SKIP_RETURN_RESTART_GATE
+$strace_leave:
 	DO_SWITCH_STACK
 	jsr	$26, syscall_trace_leave
 	UNDO_SWITCH_STACK
@@ -710,6 +720,10 @@ $strace_skip_call:
 
 	.align	3
 $strace_error:
+	/* See $syscall_error. */
+	ldq	$18, 0($sp)
+	beq	$18, $strace_success
+
 	ldq	$18, 16($sp)	/* restart syscall nr */
 	ldq	$19, 72($sp)	/* .. and this a3 */
 

---
base-commit: f2c53ea949c5048f96b3dbb5a5ee7131ce4ff2de
change-id: 20261105-alpha-force-success-fix-6df76c50033a

Best regards,
--  
Matt Turner <mattst88@gmail.com>

