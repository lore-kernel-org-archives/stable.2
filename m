Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707028;
	b=kH/qt4Jh7w1G9HOFFx2tcPHCgLtUEivR/YsiSTMjg7eYvditdb5ggakjNgCLrs+z4IES
	 3BUipEiZf5wZJGX+BVndbNoBhrDJAY90fBZM4Qm9LwEEUO71dTPC6s5EvKOu7Wa6CkFFs
	 wYbAlc9YSk59VtR8K6sriXJE7Z9pumbbv33G/xqgRgLYi2iJF8n4/Eo5/x0uzM56wYYnE
	 uliLZ4mC7rZtqL8R5Xh8xwdm+rOVC359XwKcTdbQdOO6UlW8WYG+1uLahbyVGC6C3Ky4W
	 q4dUuoC/OzXKIam01NQNy8MQQl34ilGOepr4IGb659SJm8E9iy5grTCOX6Ki7scHnFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707028;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XKZ3x/rie7YxuparZp3FDLxAgZri1JZZJzg0hOQw4vo=;
	b=iYmFD12KarIGPfRW06kMwRaqbAOeZMd/2rfD9MCB09NPdzERdbs1dwGT1OZfqEw5lx3E
	 0pVoko1xTsYZ5OiMb/8dg6T0smUtv+kXcVH2cBL/JEGjX/FN8q/gjBztXNf5Wi3t4yFdS
	 kxTZPnXhsXWQfQCfmEqi4uITTBux5RBSaaqd0RVUHWzoXy9SOty2lqxxP8AEOKnWD1f5E
	 bLGqCMkRUn39XdYqHx87+N0GiRsxIvmW2D4+PvyMHvdnRQf2rxdKYWi7i+llxRYMJSrTG
	 0e8DL2jiEQYgNMot2NClPBkvw54eg6nJu8lvX2JX5kIXQZJ7YyB5hooV77S7+Euk1yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qvVSwvYS;
	arc=none smtp.remote-ip=95.215.58.195
Received: from mta1.migadu.com (out-195.mta1.migadu.com [95.215.58.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E180606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E180606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qvVSwvYS
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lu8CDYDhRtzNr4mWTlOAnFDoXf3YmniHydQtAwXqbPE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795707025; v=1; x=1796311825;
 b=qvVSwvYS+vQRrNqxiqBV1FRAZQXkbL2FGin2XOKpf0hskFHEnu6V2vWXdM7WhRLavn9/dIYW
 MJOBffbwtgCes9V0WriPRbF9wwEhPoLkKQfY5RtXVi64sydWpRTmxkYXdmdvs1A2q8yNFrz2gZr
 nmB0/Y5D/rrYU0RydnivmXDo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4c568da8571219e0;
	Thu, 26 Nov 2026 15:30:25 +0000
X-Mizu-Trace-ID: 4c568da8571219e0
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH linux-6.12.y 3/4] bpf: Disallow interpreter fallback for arena-related insns
Date: Thu, 26 Nov 2026 15:30:01 +0000
Message-ID: <20261126153002.162337-4-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126153002.162337-1-leon.hwang@linux.dev>
References: <20261126153002.162337-1-leon.hwang@linux.dev>
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

[ Upstream commit 34746b5a84ec37c0ea2bf6808c65c5ed8790eb51 ]

Since the interpreter does not support the arena-related insns,
interpreter fallback should not be allowed for these insns in
core.c::__bpf_prog_select_runtime().

Currently, when the interpreter executes the arena ST/LDX/STX insns,
it would hit the BUG_ON() in ___bpf_prog_run() at run time.

[    2.579196] BPF interpreter: unknown opcode a2 (imm: 0x0)
[    2.579998] ------------[ cut here ]------------
[    2.580652] kernel BUG at kernel/bpf/core.c:2349!
[    2.581314] Oops: invalid opcode: 0000 [#1] SMP PTI

Set jit_required as true when arena map is used in the prog to disallow
interpreter fallback for arena-related insns.

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Link: https://lore.kernel.org/bpf/20260715141122.15783-2-leon.hwang@linux.dev
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
[edit]
  Apply the check_map_prog_compatibility() change in
  resolve_pseudo_ldimm64(), where this branch handles arena maps.
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 492355f69d26..ab6263a769d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19772,6 +19772,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 					return -EOPNOTSUPP;
 				}
 				env->prog->aux->arena = (void *)map;
+				env->prog->jit_required = true;
 				if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
 					verbose(env, "arena's user address must be set via map_extra or mmap()\n");
 					return -EINVAL;
-- 
2.55.0

