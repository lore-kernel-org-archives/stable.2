Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795695344;
	b=unyrjYCbo/1lJ4yNDWDas9GdKZTIVUZ22+5dyO0rmC8n7onHhWyI3JWAEf2a2ogmR8DV
	 oWCjVu0UYeBa4i/hnLdk7bXVyhsNVIEQIrdylqPVwiBdqggWM5Fmjd5IQ3CyJ9ccK15zU
	 fPsS3nym22H+jOD8Nrw5pONhKzpodDoJseOCD/sa0hrcFunmurhIBBdqAGbqvdOCPwk0g
	 DZFGWzpktb6tTIHUw5Ob7cYbJycd87QddQRUj9w+wki0s4Py3uIO/43NQD9gar2ImxQuM
	 49e6wxr6PXqbc3lz/cz5xEF5OTaymKdmTsgQ0cdtnHjCfHbKFBgKM4g2jxDusBmRHyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695344;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=N5xNpk5x4M7yDPJWJWGiZgxrBA/l4h+Uz4GRvv4ty4s=;
	b=CC0FNUPhRg/zo411FalDo8G3YLoSiKMntB53z3AKpUyF2tW7Ihcl7EY3Ya8erw3jujSR
	 TGkaXd/XfSXwUIvqEcSop8Sx9G5Y118kRK9TCDqNn2WRJviBpkkHL7BDAtgE6vZcLO86B
	 vC0+DsJczLu3IzFHA8d8I5fTlD9FZSFA8BGUVWmeUVYeWqwxMR3o/L6mnsr6LzvhEsnQ6
	 3VSSXQFd9Yqx95AkU9Ui0mSUWigKRBV7LijuRhRMKG+yD38BS6ZBag3Qkk69MSe+CsVm7
	 B27G5XGAwwZCb+QQyKVHD+zDIeu+sh5M3Neqm7xvGM8lqKWL30Q33iBs2rMu962q3QA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDcoIN7I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C3B606A31E;
	Thu, 26 Nov 2026 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDcoIN7I
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795695343;
	b=Q2xP9dizc7eSTZKIjhn5TYBcqD2FT3N763EDFnJYrHCE4PPK3jz5e5hTnZDwJdtrtPHP
	 OrunJdOb4juhcfxgaNdMgZvUZ0Pj7Zf4kaY9goJ3T57D+g2wR/2h1pmSOMrt0Tln+2AVz
	 ++vUjbwYTcvMRr2urCNUSOz40NFosOV5QYrnc8F822SD+VZEvcmtHtCLf+5pfhWrUMFbx
	 ArgyRSb1MOmVPTlmHv7czRjUArdOOeHRlbf9OLfob6JGrN+NBit+KL/ykiBRuyHBp99Au
	 HcE/JY0mjHvOJ+Sgl/wKqfXMmvRRmOo9576fFDjGzB33OZvBTcQeO1T7NnxXrrGEDSQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695343;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=N5xNpk5x4M7yDPJWJWGiZgxrBA/l4h+Uz4GRvv4ty4s=;
	b=vLKHZIBUrUYYaKRxZasTdas57qPOj+fTNBhswAUwwL4HSR55ZTX4wFg5BMXlgL21FwWn
	 QJG8/pHcz9pPTeIgHwwJWaqc0EEeLir09VPoboj7cHJmqQanYoNtVVNxot1O6B161vn4z
	 2CdO8LEmj9HxRoJleb80RgHkbwHGYcyRQi3k90nktbmarForG0AbLhbN49bgIO1bWLFEW
	 1SgQesYnScBKDU2/TLMgQZ1KKTk5oQagZOBv6mwF6DvU4rwpWhJiUmqAuGyifYp7eFN+e
	 mngJvH/xPAZFXeaBxvO/LP+ImBTB3ovaPnrdtzpzu6QsQ9FmiDLnsCFdKMvhsrJ00eg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 17D3E1F000C4;
	Thu, 26 Nov 2026 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795695343;
	bh=N5xNpk5x4M7yDPJWJWGiZgxrBA/l4h+Uz4GRvv4ty4s=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=EDcoIN7Iyd68mt93QEvRV/4GjbgTGkFHwAStqDnw3rPmVntifoW60A11l+UB5N5wr
	 Y7k19ErariH13fFQox2z7mF5sl6WTosPdf4scVnc2ak1lkJ7JYctBMi9dfwx+V0BmI
	 Je0AwBvYBUcE24vOtyAlWuqm32d/+YNCMBYYq0IZQ5ClNZx7FbNbXVuVARcodHOKeG
	 KYP7yf1UI8mdgs9oq2iu2pok/nG3PWSqWJUlDYRlwnsFkT334hHc29qKutHbbsEU+a
	 +pyyt3mR9BCu0EZ1cwsdiy+pUhHI2fCi6d33dh6qLz8f9vKau+CHEiYFIjaKF11ci8
	 ORmLL1LDxKSxw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9C35F4D491;
	Thu, 26 Nov 2026 12:15:34 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 11:45:01 +0000
Subject: [PATCH 5.10.y] bpf: Clear buf on error in __bpf_get_task_stack
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
Message-Id: <20261126-so1b-bpf-510-v1-1-24bed4a57fa0@certik.com>
X-B4-Tracking: v=1; b=H4sIALwbCGsC/02NzQ6CMBCEX4Xs2cX+pAR8FeOhLYvUmJZ00WgI7
 26rF4/zZeabDZhyIIZTs0GmZ+CQYgny0ICfbbwShrFkUEJ1UqoOOUmHbpnQSIGD1ZoM9UYPPZT
 JkmkKr6/uDKaVon3D5cf54W7k1+qqTWeZ0GUb/VwRUxzXlO5Y+fH/A/b9A+rlmNulAAAA
X-Change-ID: 20261126-so1b-bpf-510-9a33e5e85398
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 bpf@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795693500; l=2361;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=hk81rXf0b1uO73SLKT7st7p0Z3no78nTgTSXqVZ7P4c=;
 b=/NzVrZ8AD7J2/dfD/q/IdzP5o6jbwiocZ4hZI5XE0uA8mo6JD697/nCYEbkVq/6dSUQg4vGzr
 0kxx+wVy2V2Dtaulo5Xuw/ITq6qyJCtOzu/EhvYsKsYhUHmcIT2gKNs
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
[ adapted to 5.10.y: use bpf_get_task_stack() ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.1.y and newer already have this fix. This branch has no
__bpf_get_task_stack(); the same code sits directly in
bpf_get_task_stack(), so the two memsets go there.

Tested on v5.10.275:
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
index 3ec76cb5f240..c9a9cfbca4ae 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -670,14 +670,17 @@ BPF_CALL_4(bpf_get_task_stack, struct task_struct *, task, void *, buf,
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
base-commit: 99112ea818e35b606397c84fbc05e6fadb6ea162
change-id: 20261126-so1b-bpf-510-9a33e5e85398

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


