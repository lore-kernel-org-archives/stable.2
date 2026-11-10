Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316042;
	b=uGZ0WNB37Pp4vLKwuzMhv4jc1sMvkP5AjKZjfVnu0Aqsv00q1BXkHHW355g6bAlDCiJS
	 Y6LXZYjjFZF4fU/chasOhL1LF3vTKd7oOLwqQ9FudhZ4ldfhDhYPRo2LRacgw6TOn6zyJ
	 fz5GcflHeHQn4L8QvJitpYgv3gfZiTjY0uaHc1CT+59K9WzJhlH7Cwbh3xrVIDhF/9DmT
	 qd0St5Z14RRHffOYhN5+/GX4PUjvmfcIZ7eMHPNfgt4W44gjPOQA3ABgKgRmH6REmHftV
	 folGVDei+FjEsm6x2BnHz7SmDKpQGIc/b3L02J2dxWaLyhfs3+xpe2TbM9seRctYu1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316042;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AzSXXdPBuS6PY38ldBy9Mvq2CcaygFYn3oLsatZd/jw=;
	b=LmYW5sN6Bg+QaNMxgLmwsVIyRp7XPILWEdaKVqCeZoZBafaij729SyQyBWPYhk3dt1Cn
	 ILVm1M956uHaTSND+rbfmNxxm42exF0Sekuc8o0w8sSaoNVv6HXL6lWkGZLhOIBIHJz0G
	 ZTMV65MPEnjN4lWSKOCFeBQuaYaxLZJxjT4JsoTBfPOcNJYhQTmEc8CA91gXbpHejliXY
	 RrzacvCJtUtii0SAalZX3AKb2grhRRGcJerwN5t1BxF72Tvzb0h25iAm6tFEYm85n0HXa
	 XGT1eo2ioJM/PN+icLaylEsZLAq6dGt6wI1UEcTfrgClnafGWllw1OuZtnnCmwapnSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2SJTftN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265A606BFDF
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2SJTftN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD51F1F008A3;
	Tue, 10 Nov 2026 13:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316041;
	bh=AzSXXdPBuS6PY38ldBy9Mvq2CcaygFYn3oLsatZd/jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H2SJTftNjAurJkBUTGvz3m+JxA3zPNKbFbOkJA1w6u6sYUATKlvNAwvFekEHtO6T/
	 SlPh8w9n037vIKvDklN1RyMl4pfLYngSFrxheqQNowFD/nQ6EzwPjK8TOP/VV6afbt
	 Ze6qNwiLi0nVGdVDP7pc3vJO2HCIaHw+75sU4bv/ZTxYRs0NAs/ZI8x86EPt/xEd7m
	 TT98gm1pN4pyxeS5cpJyfybVBUDNom9ykUkpxWBE+AEilydQJD/+ttJMens8MGbCqT
	 0BT6iiBut3zs6hVxEuzht8TmUy0Cu65vV+nosWEUvB+VV1T33Av9Q626c+BfLQjUbd
	 VQZ5Emhv7uAVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Palmer <daniel@0x0f.com>,
	Christoph Plattner <christoph.plattner@gmx.at>,
	Greg Ungerer <gerg@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] m68k: Fix task info flags handling for 68000
Date: Tue, 10 Nov 2026 08:07:18 -0500
Message-ID: <20261110130712.1651427-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053339-failed-6.6-48859f8018d9@kernel.org>
References: <20261107053339-failed-6.6-48859f8018d9@kernel.org>
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
index 7d63e2f1555a0..37926b4b205af 100644
--- a/arch/m68k/68000/entry.S
+++ b/arch/m68k/68000/entry.S
@@ -21,6 +21,13 @@
 
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
@@ -73,9 +80,8 @@ ENTRY(system_call)
 
 	movel	%sp@(PT_OFF_ORIG_D0),%d0
 
-	movel	%sp,%d1			/* get thread_info pointer */
-	andl	#-THREAD_SIZE,%d1
-	movel	%d1,%a2
+	/* Doing a trace ? */
+	getthreadinfo
 	btst	#(TIF_SYSCALL_TRACE%8),%a2@(TINFO_FLAGS+(31-TIF_SYSCALL_TRACE)/8)
 	jne	do_trace
 	cmpl	#NR_syscalls,%d0
@@ -99,16 +105,15 @@ Luser_return:
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

