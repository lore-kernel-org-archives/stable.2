Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795695575;
	b=4MKal5UTl63qzRlSldopm4UN2jMpyzmoTdikA1/yxZH3G1YkHn648f5rLo9vsR0e2dxC
	 ipLyEq24jRxja3ovWFRGy2QCrKKfyoNzxoYh/cjH42JYnAtmlLDt88SoNw8sgoeyw0+d1
	 RKMFstWadW7Ch2/VruusnplHCQS7Nr3MK1MFSQPmjIqfgw4KBbrjFqNjtgbcE2+FAt6P1
	 BxN9h+dJcrx4XUKWh3KzMvza+XhLW9jp27HkFysTAaPkKL9K2sKdvHV/Hn0dYNpENqlxo
	 a+31EZ3o160Up20mQbjBiyH2UTlzWXbP9ATNWOxCtkSLuYtjv6eNMZas8+GoaIFKcSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695575;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=JlssY66KgAX3fjWD235Kej1M2yTYA5eP8egsUM38Stc=;
	b=3LSF2E032nFizapMYk6q5XsMzQVzIwJhQX37zb9bssquFkwmEzGiSlDH+ReU+zuu5XCy
	 R4aZUClf6BaqimbeJgLHsiBHw++Rka1u2jnf1dLDAoUlQiEo3rV3cK/ZOo6rsSsX0MB6q
	 jy3/gM6cWE1J5VDpiJS2VQU7SUcn+GVKZZXmYBWZ1ECcgrhizN28TThkbyOZCnXO1FERf
	 qjZMTX7SE1Yt9TL3ZvAsDKWbNa0VtAx8fb6v145P22QCIZaPNyXptNtMgtALUOFh58Z4T
	 6dbFARBZBeozr5umz7WhGeIL4p7tP1YIRqYZ0NExNKiZrWgeLGagC6hXm/Rvmlm0LkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KP0iQ5is;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D83606A31C;
	Thu, 26 Nov 2026 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KP0iQ5is
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795695575;
	b=Qs1IYFWz0T3T00x0x5FVN3wuKeCfMtpdyezdsfVSaT1IofD+BDU2Zg2Ist6b9qI6y8gV
	 HJRZhsACGh5k2aCC+xpEcP452D0XRnkeh8RAaTHS3F82C1bpDXeE+omYfznSu8mPFkpuh
	 x+a3fVZkX86+WQAjxgYMefW0rxeRbDiLb7GhURri5XRn40pEvSxh1Dfo/qPBvCDhKy+Zz
	 qbtHg+b3xDj5X47pGhUTooy0VsAxArtl/qumwtEvsVpmwa+OVZ6g5rvI06G+Bev13hXLw
	 bbnfSr+Y05FiPccugFYZ7BlF2UayPBZHZ/mOq5ju4yP19iK9uYmSs1GrmGbakCxmzkg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695575;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=JlssY66KgAX3fjWD235Kej1M2yTYA5eP8egsUM38Stc=;
	b=EZiPDPR6KUFS7wvAgP6eY3VUdJgO5jmuSpoiW7mHnh4SW0vAQGgG12jt92UBZDFEMrxM
	 UiXczNCKkZZeUHwi2TYBoVYe8TotG+p510o/vt/YiZ64Q6rYRKeJuUf8KVF+rw1LaKEfq
	 4TwvFNeHLpdk1qY6bgek5QUzfVOav5PXzUrgYxc5KCfPo8nq7IvXXLxEuXXqsqXLofRge
	 g3mojai3f0WOfz4c0NOSo/mzkuw5Qpib67siUPQb+XD1FEJfdy2uQ0bYMWI5vcxk+usur
	 2pPcVHHTqwVE9n6v42jAyDJtiwWQYau5qI2wvb4+GDOdsmcg9vt30RjghmUO0sp04Rg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D08001F000C6;
	Thu, 26 Nov 2026 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795695575;
	bh=JlssY66KgAX3fjWD235Kej1M2yTYA5eP8egsUM38Stc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=KP0iQ5is++oaum7MEeVy5VRwFwbHj0tBqIZUqVnjsvGqdcSrDfwM+0qQ/2TvdvBJo
	 LVXwofYDmE7voIGRXEYB2QFLJCT5F5dHSKB5Vn+eQJNN2/+S1nMS9kfO0M6Pftec98
	 7ubc73dm3NxMdMxOtcFzMaOUbKJjILpKrI9Goza2Wh5huFf7KT1wu20m6JjsHhSXDl
	 zsIkzjAsmi8Jamd5AEOyefOv+14tZetKr+UhNSrHVrNRZKbinWrkUSmUxblPJk4SLf
	 TLNLq06eshhoeRQqpgty7RL4ikWO2qT71MVsHmLy9Z9eu2OBqWemx+sG794zwhPIw3
	 qWwL77V0yduXg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 60E0C4D491;
	Thu, 26 Nov 2026 12:19:34 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 12:14:15 +0000
Subject: [PATCH 5.15.y] bpf: Clear buf on error in __bpf_get_task_stack
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
Message-Id: <20261126-so1b-bpf-515-v1-1-03acb4631a9c@certik.com>
X-B4-Tracking: v=1; b=H4sIAJYiCGsC/02NzQrCMBCEX6Xs2a3dYCL4KuIhP1sbkaRkqyil7
 26iF4/zMfPNCsIlssCpW6HwM0rMqQbadeAnm66MMdQMalCGSBmUTA7dPKImjcRWG6fDcDBHqJO
 58BhfX90ZdE+6f8Plx+XhbuyX5mpNZ4XRFZv81JBwCkvOd2x8//8B2/YBv3Z7dqUAAAA=
X-Change-ID: 20261126-so1b-bpf-515-1ea56b5d0467
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 bpf@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795695254; l=2361;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=BMDL3A0/tlxrmRgMDwvaLHJhFSpu3XBsNg3zFHP17+0=;
 b=3R3df+Bn1R7wlrDwKrYQSJttf6fYzizf/dcs5kvvNK63mwzoA0ekqGyvSSPO9WfjqbqtuNx7E
 i/fpGuNQpdXDhsKSwBUniKdHR3MfZRPROVB6te5LSmHAAnoIFq5hFX3
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Jiri Olsa <jolsa@kernel.org>

commit f5d242825ca417bb6afe35fde6e8880f97ca43fb upstream.

Both bpf_get_task_stack and bpf_get_task_stack_sleepable helpers that
use __bpf_get_task_stack have buf defined as ARG_PTR_TO_UNINIT_MEM
argument and we should initialize the buf on every return path.

Adding missing buf memset for __bpf_get_task_stack fail paths. This
provides deterministic buffer contents, which is useful when the buffer
is used directly as a map key.

Fixes: 06ab134ce8ec ("bpf: Refcount task stack in bpf_get_task_stack")
Fixes: b992f01e6615 ("bpf: Guard against accessing NULL pt_regs in bpf_get_task_stack()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20260803210149.296496-10-jolsa@kernel.org
[ adapted to 5.15.y: use bpf_get_task_stack() ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.1.y and newer already have this fix. This branch has no
__bpf_get_task_stack(); the same code sits directly in
bpf_get_task_stack(), so the two memsets go there.

Tested on v5.15.226:
- x86_64 allmodconfig W=1 build of kernel/bpf/stackmap.o, base vs
  patched, no new warnings
- booted the patched kernel under QEMU/KVM. I didn't run a BPF test
  that hits the two error paths.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.
---
 kernel/bpf/stackmap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index e04571c1833f..ca1a15c94724 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -530,14 +530,17 @@ BPF_CALL_4(bpf_get_task_stack, struct task_struct *, task, void *, buf,
 	struct pt_regs *regs;
 	long res = -EINVAL;
 
-	if (!try_get_task_stack(task))
+	if (!try_get_task_stack(task)) {
+		memset(buf, 0, size);
 		return -EFAULT;
+	}
 
 	regs = task_pt_regs(task);
 	if (regs)
 		res = __bpf_get_stack(regs, task, NULL, buf, size, flags);
+	else
+		memset(buf, 0, size);
 	put_task_stack(task);
-
 	return res;
 }
 

---
base-commit: 4f2df9a01754521fbba3493e8ad91ef65515e68c
change-id: 20261126-so1b-bpf-515-1ea56b5d0467

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


