Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315762;
	b=DqboUdNu25GnMWom7RjmF0ZFiPKuHNwAmn8aob7JR3iXETHKorqc1MplAnkD/depmxzr
	 W8CPFIPlTL/GFkijni1Op04ykKlC/ZhhTotja6rJmwFTTppCPpmazboCvNEtvw+c0l4yY
	 t6tPoBGkX3kGCa5iHRKXziZAo0Q7Udr2VF7CGhtIIJ1BrR1wqj0ialJX+y7DKgAN+shHD
	 fnVkl3CELaIigj1GD3ZtbEPCf1l1HHqbz5SS783dDjEVBhP5oTrfeMg9feoJekOtNy0fz
	 y7hHpm+csw/w4yG385xi667ZuBmPUqM92bFijKCirYvZRBvAo7luq+exnqwoCes3WIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315762;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bKqotkfgeIkTn5dfcEYagCEFjLqb8ZqcEdVz9mzlJe8=;
	b=FNbkVgbttlDYDinIXCGbYCrN8kZukJ2ByN0rtSAbKMmQpEt5Nea86odj9yeGgYx5HzZ6
	 w9NKrjGQX4C+DFB4//NDeBFQE8Y+foakxQkYO67wJWP9dOnBDw7RSrZWbDKqzQvoKxTuf
	 iowgPhRet5sk19vcd1FbMGPA7o+Fc0glklvl6KE0hkzdRjgl3gul7KJTaESH3mVu5TViA
	 tFgtVjGM/nqEs3q970yavfbfls9KoN4rXUvjyAaj1l26D9xTO/eMjubgAULleU7zueCfa
	 3KyqdFXkzG3MAlj4vua/K0y7Zc/fI669oXP90Vwx/XTG4g8nKkq14i39AzCim8VlJag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFWJkUqN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ED2606A7EC
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFWJkUqN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCBD1F0089F;
	Tue, 10 Nov 2026 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315761;
	bh=bKqotkfgeIkTn5dfcEYagCEFjLqb8ZqcEdVz9mzlJe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OFWJkUqNNV9jqVdyCm2MRyN5DIUwLp36p2HZ7ClD9jC5JKhqSe+is/aeAJMJwCZL0
	 3HKHKN1jMhQ/blc+H6RkpaK7uNtP8XPzYncKJj1TOudssK1l/p05YCEw+CRmgKY+02
	 yHjuVa/5/WF0ejOADp6xhp2/tn6WVbczZIcgCW5m7OULtVDApzf8fhJ4g4F6DZxB2h
	 7+UDRb0KXhXy30uJnVKaNSPl+JqZsN4tBxbaKsvofeoCHsU08lIGArvDcCyhlyvEZ6
	 J8rGWHGIJp4ApTElzjbLaaWM3KcMYNbY3COemaUs1hjg1pUdUtswdRAQw8pLM/LU7S
	 tJi7GJCgUXzMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Palmer <daniel@0x0f.com>,
	Christoph Plattner <christoph.plattner@gmx.at>,
	Greg Ungerer <gerg@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] m68k: Fix task info flags handling for 68000
Date: Tue, 10 Nov 2026 08:02:38 -0500
Message-ID: <20261110130232.1619444-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052109-failed-6.12-48859f8018d9@kernel.org>
References: <20261107052109-failed-6.12-48859f8018d9@kernel.org>
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

From: Daniel Palmer <daniel@0x0f.com>

[ Upstream commit 2c6805145e1605cef39459f78979f7edee251b41 ]

The logic for deciding what to do after a syscall should be checking
if any of the lower byte bits are set and then checking if the reschedule
bit is set.

Currently we are loading the top word, checking if any bits are set
(which never seems to be true) and thus jumping over loading the
whole long and checking if the reschedule bit is set.

We get the thread info in two places so split that logic out in
a macro and then fix the code so that it loads the byte of the flags
we need to check, checks if anything is set and then checks if
the reschedule bit in particular is set.

Reported-by: Christoph Plattner <christoph.plattner@gmx.at>
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Signed-off-by: Greg Ungerer <gerg@kernel.org>
Stable-dep-of: 48859f8018d9 ("m68k: Fix seccomp filtering on ColdFire and 68000")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/68000/entry.S | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
index 72e95663b62ff..c257cc415c478 100644
--- a/arch/m68k/68000/entry.S
+++ b/arch/m68k/68000/entry.S
@@ -18,6 +18,13 @@
 
 .text
 
+/* get thread_info pointer into a2 */
+ .macro getthreadinfo
+	movel	%sp,%d1
+	andl	#-THREAD_SIZE,%d1
+	movel	%d1,%a2
+ .endm
+
 .globl system_call
 .globl resume
 .globl ret_from_exception
@@ -70,9 +77,8 @@ ENTRY(system_call)
 
 	movel	%sp@(PT_OFF_ORIG_D0),%d0
 
-	movel	%sp,%d1			/* get thread_info pointer */
-	andl	#-THREAD_SIZE,%d1
-	movel	%d1,%a2
+	/* Doing a trace ? */
+	getthreadinfo
 	btst	#(TIF_SYSCALL_TRACE%8),%a2@(TINFO_FLAGS+(31-TIF_SYSCALL_TRACE)/8)
 	jne	do_trace
 	cmpl	#NR_syscalls,%d0
@@ -96,16 +102,15 @@ Luser_return:
 	/* heavy interrupt load*/
 	andw	#ALLOWINT,%sr
 
-	movel	%sp,%d1			/* get thread_info pointer */
-	andl	#-THREAD_SIZE,%d1
-	movel	%d1,%a2
+	getthreadinfo
 1:
-	move	%a2@(TINFO_FLAGS),%d1	/* thread_info->flags */
+	/* check if any of the flags are set */
+	moveb	%a2@(TINFO_FLAGS + 3),%d1	/* thread_info->flags (low 8 bits) */
 	jne	Lwork_to_do
 	RESTORE_ALL
 
 Lwork_to_do:
-	movel	%a2@(TINFO_FLAGS),%d1	/* thread_info->flags */
+	/* check if reschedule needs to be called */
 	btst	#TIF_NEED_RESCHED,%d1
 	jne	reschedule
 
-- 
2.53.0

