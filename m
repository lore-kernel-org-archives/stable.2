Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708117;
	b=DE/5vIyX8BCA4uaNlt9w8qC9wWD4N7u8pUry8ZumoD9/GcrsxCAwQ1EjHCkxIMmQLGTa
	 DaPpP3la6hoBj8iSkuXlr2kh8eaoFgO5L/k8e1hZrNTLMIVCtRLtGzS45IvHtp7Lp3HSE
	 PsTBCLPgxcDlpJ/2nwLsy4AEkR+QTnfM+d6yUdO18LqAu4kqQBF4DCXWWaQtgFka4jOdv
	 DLvHcgCDxBHCA7CBrz071Z7kwYldQzNKC5Lyzbe/TD5fuz+cU6qMrLbbhOAkYGQ0VKdQ2
	 g9uMGM3PFG4norwe169kwJyWHqiB7uhcdnrHYfSBzPATKeUviiRR4V7VnksWzUo78jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708117;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C1dEdWeDxpgKQfDGosMbcKuIvKQ/TjH2X7ZuB6oiK2Y=;
	b=LIYuKCYEk17hzrYr+puHOGMkLTCu8DfAoTUtTcYSoWIRpWzhUc5qR14m0QjtCeDZje0c
	 YBU9IMOMEE5xdnZ8ucqeT2Qut39oohA7UWopElVC7MuipZxTAyFHStT5HYxKr8zdC1sft
	 V2GMy8PUhtU39w//Y43zAq96IvXeWaBGQzurf8mgULMIec73UxffnbEnZ3E8HYUz/rA2Q
	 RgbJ6B6bgpwM2w+nQoJAXu2VFf1P+rGOKJTD/RsNCYTVt8idhIWPyMSwKvLDzmcgIXGHd
	 8X7NxqrOBKMfFtEPIjyE/ElyzwmrK4FjKIeUxFAa8f2AMaXHarHsZjINss5QAsB/SBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RQTFnD56;
	arc=none smtp.remote-ip=91.218.175.47
Received: from mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F88606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4F88606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RQTFnD56
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+ugi0ffknDsDv/WElNjAOvTzE4ppDV9pVvzwvWa3Ih0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795708115; v=1; x=1796312915;
 b=RQTFnD56vgKXG1lsOHneagPm+AI7VtL2fuA8SPXgSMXCsatoh9vX8hgD3qjVxqJLdOvEAweQ
 xmUqCIaQj5q1FOujOhumDKghvGBcHvMCUnLdtyI6JucCNiImLXjmWQVflkpGbGi0KEcu3MQC9r8
 xMS8a/VX9LsoGLV1x4fMQYTA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c0b53319757a8e46;
	Thu, 26 Nov 2026 15:48:35 +0000
X-Mizu-Trace-ID: c0b53319757a8e46
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guillaume Laporte <glapt.pro@outlook.com>,
	Vincent Thiberville <vincent@harfanglab.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH 6.18.y 3/4] bpf: Disallow interpreter fallback for arena-related insns
Date: Thu, 26 Nov 2026 15:47:12 +0000
Message-ID: <20261126154714.169698-4-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126154714.169698-1-leon.hwang@linux.dev>
References: <20261126154714.169698-1-leon.hwang@linux.dev>
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
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2749dee1643d..0ed5d9e0db39 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21106,6 +21106,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			return -EOPNOTSUPP;
 		}
 		env->prog->aux->arena = (void *)map;
+		env->prog->jit_required = true;
 		if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
 			verbose(env, "arena's user address must be set via map_extra or mmap()\n");
 			return -EINVAL;
-- 
2.55.0

