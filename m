Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693F3B2FF6
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948236; cv=none; b=f99yLRtXeg8NYR68/Szj/oDB6Si4AbQeXG8Y1rhd4QtOhUsqm5hnNmBmHzcQfGe/L8zABFZGjBLAEPj/UrYW27+IkwWUMx4sqC0EC7rb6iee/StxDfC12I7CMF0gRBz082+5t3Rur2gf4yzPh1vGLO0GFVBuzA0C0UfSD0WJNf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948236; c=relaxed/simple;
	bh=UV50VoozEFUOBOJQFvFlIV/q9kPbFe+J56l16wS6ctg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IUT32nynK8ozveOMIY05pqmSU5p7FIQTQ/R4L9ovDqqbrwCj0vYYSfUncoXC+VqEUdwfWhcgs5LkT+oB/BzgvRrQ1+m44Q/J947tRytONciqGBbjGvi9HheJjMMjKC1JCBgfLQhACL3IMnrqOaNlNEv7Y44vS0mGR3dr7PKzPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zgHBEK04; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zgHBEK04"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786948223; bh=qgMbh5RNFI8OLX8K1ZLrBtKPn2+cUkmHSDywr+PEu38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zgHBEK04VhOF5ckUtewOZRiZUti5gTm9T3s67/EhiV71jjl/+gsnX/sEC+OSU12ne
	 bIy+7KSeOMikwWuraEx/8xEfZAHJLF8WQS//BrG85eBA8aJN3IrfU2rkZmQ7jBSywS
	 KBva8mPwILQDYpQ1Hl4VGyB6D9jEUEg/tzfkEn2I=
Received: from localhost.localdomain ([180.101.244.73])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 739A8AA7; Mon, 17 Aug 2026 14:28:57 +0800
X-QQ-mid: xmsmtpt1786948137th98zjb8g
Message-ID: <tencent_05AD70D6BED7A204CB00860D0C3A303FDC07@qq.com>
X-QQ-XMAILINFO: OSyReP17gB4cs2XLG9gcwSMRL6l6OExF9b5KusC0i6w+U4l8jxv1y6hT6Dvr0X
	 YFzTJjeZDr9bfoCYlJSWgq7NUo9SVUFIfxFvUQRkt5YuERpXcSllySF2ORpP+yg04vUf5k1lWcta
	 kCfzs0M1njFuzGWY9JP2NsdgBa3ieDKAnGJSE0dsAMZOtNOXEuDNT8DK6iyYW5Bluel2j5doVaa1
	 k9UVB/MLSsotUyzh7aXv7lWj0x2puXA1Cln1+trAk3REnValhV/X/9mmZuu96jkiRJAOz+t2Fxyl
	 IRhRi0P//bSfdj45eDckCVCJeAIpRXYHYCWD6B4EYUESgrISmEbD6rcuDLpCbqHssTXXgNfx5yEQ
	 so5PtBp4XRDd+EckJrNNlDYILLcINvfyZTr8k3eUj2o2uEkpm3h69O5crkIuY2C63ogmWXWztsmj
	 kVBmbs26VrrEo4MDfC2zxunOrwBcLxqTkRL4WNZwmkB7V8YCeEiRt5XO6GuQ4rb3vMWFEwlK1D+S
	 alYzLLGfGlTd5+cdGEtRTHlBai64gPG1ZK8AK/QnGoNFuKy30wKE65i4uOH5jniENcSO1ahL6ZDG
	 3xQaMaST1YLRg7GXCAKhpgN5NhWxuFvDiHNFVJEz1JGee9nZVu7WqE+wWXLNjAoPUC/vf24MJCSu
	 fOUO+9TLPigF9ZjgFNgp2A1252RlrMSMXxlcK2Zzwx+2Q31gmOuhEPs6xkIEzxC2I2ZzQDA/qDar
	 IXSMFUqde6cXJmEqcUfYCUbuMwomf9b0EzHQ6i1wzKkbL5TjnmC03J9tPR9+T5osQnJ67p4sLXpn
	 2kjfdk+FeOZjVEGDfoZMM76ywbGqLZSZg7hL8+SvlPAvePFec+3+8l8uh40L28cJ0HG8EJ70zOW0
	 VQDihOi6zFHcyh38rU9mwBoOTAYTt7kzlY2cGjybH67BX65VYXVHU8/u9aaqxiw1vqv6UIu/NtJq
	 0Dj1zZH8uPnHS6dXNray8qVO98LJAsNHoy8+pSIxItFvIaND3lx4xOyjbWAu5f
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Aohan Mei <3472274613@qq.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	jolsa@kernel.org,
	zhuyifei@google.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	corvus@tencent.com,
	Aohan Mei <henrymei@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v2] bpf: Enforce cgroup storage map consistency for freplace attach
Date: Mon, 17 Aug 2026 14:28:28 +0800
X-OQ-MSGID: <20260817062854.2710890-1-3472274613@qq.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260814130650.634992-1-3472274613@qq.com>
References: <20260814130650.634992-1-3472274613@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

When a BPF_PROG_TYPE_EXT program replaces a cgroup program, it
executes with the target's runtime context, including the per-program
cgroup storage descriptor attached to the cgroup prog item:
bpf_get_local_storage() resolves the buffer via
prog_item->cgroup_storage, so the extension's own storage map never
provides storage at runtime. The verifier, however, bounds the
extension's bpf_get_local_storage() accesses by the extension's own
storage map.

The prog-array path already enforces that programs sharing a
runtime storage context reference identical storage maps (via the
owner cookie matching added in commit abad3d0bad72 ("bpf: Fix oob
access in cgroup local storage")), but the freplace path performs
no such consistency check in bpf_freplace_check_tgt_prog(). An
extension whose storage map differs from the target's therefore
operates on a buffer whose size, flags and layout do not match its
verified assumptions: a smaller target buffer leads to slab
out-of-bounds access, and even equal-sized maps can bypass
BPF_F_RDONLY_PROG or mismatch BPF_SPIN_LOCK fields.

Reject the freplace attach with -EINVAL unless the extension
references the exact same cgroup storage map as the target program,
matching the cookie semantics of __bpf_prog_map_compatible().

Fixes: 7d9c3427894f ("bpf: Make cgroup storages shared between programs on the same cgroup")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 kernel/bpf/trampoline.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

Changes in v2:
- Tighten the check from a value_size comparison to map identity:
  the extension's own map never provides storage at runtime, so a
  different map can only create verifier/runtime inconsistencies
  (BPF_F_RDONLY_PROG bypass, BPF_SPIN_LOCK layout mismatch), pointed
  out by the bpf CI review.
- Reformat the added comment to the kernel multi-line style.

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 1a721fc4bef5..043bee6aaab2 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -806,9 +806,11 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	}
 }
 
-static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
+static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog,
+				       struct bpf_prog *prog)
 {
 	struct bpf_prog_aux *aux = tgt_prog->aux;
+	enum bpf_cgroup_storage_type i;
 
 	guard(mutex)(&aux->ext_mutex);
 	if (aux->prog_array_member_cnt)
@@ -821,6 +823,23 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
 		return -EBUSY;
 
 	aux->is_extended = true;
+
+	/*
+	 * At runtime the extension program inherits the target program's
+	 * cgroup storage context (via prog_item->cgroup_storage), so its
+	 * own map never provides storage; the verifier, however, bounds
+	 * its accesses (size, flags, layout) by that map. Require both
+	 * programs to reference the same map, matching the cookie
+	 * semantics of the prog-array path.
+	 */
+	for_each_cgroup_storage_type(i) {
+		struct bpf_map *tgt_map = tgt_prog->aux->cgroup_storage[i];
+		struct bpf_map *prog_map = prog->aux->cgroup_storage[i];
+
+		if (prog_map && prog_map != tgt_map)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -926,7 +945,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 		/* Cannot attach extension if fentry/fexit are in use. */
 		if (cnt)
 			return -EBUSY;
-		err = bpf_freplace_check_tgt_prog(tgt_prog);
+		err = bpf_freplace_check_tgt_prog(tgt_prog, node->link->prog);
 		if (err)
 			return err;
 		tr->extension_prog = node->link->prog;
-- 
2.43.7

