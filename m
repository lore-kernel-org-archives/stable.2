Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2873A963A;
	Sun,  7 Jun 2026 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838691; cv=none; b=qGTCy2RTmd2ECvcublZ2028N02hccgzadGMo9PP84g9f8aatn+UlbpJY1H5Rl+y3xR1gEuuRi9YDzkD1ciTi7c1uWFT1i3GhtT9VmpllrUlUALPKXDaVQ16M0CctPE80k8FHNz/FZLMANmaH7HAynoLqUMSLZc1xETXbUvOy6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838691; c=relaxed/simple;
	bh=yb4BXyAJWMu2fwmiWc5tCIf2WquakStJIyTMMDIBRww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U6AZB/fovjVegm4v9T0FxQqZY/4A/6mLS1m+ggOMh/vsOmX6qOYpTcB4RjFz1n76iPXYaTf2EYKmE9d7ba/E7kYCmLQuYZgkxwZaW5wJBk1PR9s4l1VpFq5KVd8Fa5UdHSICfq0oCsYkJRTxIA+3fu7dvYI9uDr3xCvv1R5f7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=W40ed+Al; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="W40ed+Al"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=QHF3niD3FfxGc+79DPsRFE+jwSzDC2N
	OUwgjGpYau5Y=; b=W40ed+AloZHeF2NxuYw8XO9zyRHEN3zJ+xfjILdZ8vooOGO
	sVm39e+1wuE0a7lGuNtIzSzGRNSfOUauXxdSgwlJFyqIpXKkJEKGPkjBoisKBM5u
	Ahysjmmdim8HQvXabgiS3dT2YoW3YYdpTXGRuLeyOTXAOAghTI0Zpw1sy0+o=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQD3CJ4KcSVqdwgUAg--.41669S3;
	Sun, 07 Jun 2026 21:24:28 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sun, 07 Jun 2026 21:24:13 +0800
Subject: [PATCH bpf v2 1/2] bpf: Keep dynamic inner array lookups nullable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-f01-v2-v2-1-da48453146e8@mails.tsinghua.edu.cn>
References: <20260607-f01-v2-v2-0-da48453146e8@mails.tsinghua.edu.cn>
In-Reply-To: <20260607-f01-v2-v2-0-da48453146e8@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Daniel Xu <dxu@dxuuu.xyz>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Ihor Solodrai <isolodrai@meta.com>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780838667; l=3023;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=yb4BXyAJWMu2fwmiWc5tCIf2WquakStJIyTMMDIBRww=;
 b=dukIfljGe8oRuXtRTPDvpC9w1le66lZ1mr4SC+1ZPlaQJQOkz4Qrp30r1x1st2Wpe13QvQPHy
 uxSQ0N/G7vpAztWpITJdwz0o3q2nDRmFypE9FB6EZkUSTkj8ohqjgkv
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ywQGZQD3CJ4KcSVqdwgUAg--.41669S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr47Ary3CF17WF4fWF1UGFg_yoW5Cr1UpF
	4xGF97Jr1kAa1Yq342ya47AF1Yka47t342kr1rG3yFyrn8WF1DXFWUG3W2va43AFW8Cw4S
	vr4Ivr9Ykay5JFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4
	vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxkIecxEwVAFwVW5GwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r4rKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUY1v3UUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgELA2oknpuRgQAAsQ

An ARRAY_OF_MAPS can use an array created with BPF_F_INNER_MAP as its
inner map template. A concrete inner array with a different max_entries
value can then replace the template.

After a successful outer map lookup, the verifier represents the
resulting map pointer using the inner map template. Const-key lookup
nullness elision consequently uses the template max_entries even though
the runtime helper uses the concrete inner map max_entries.

Do not elide lookup result nullness for maps marked with BPF_F_INNER_MAP,
because the template max_entries does not prove that the key is in bounds
for the concrete runtime map.

Fixes: d2102f2f5d75 ("bpf: verifier: Support eliding map lookup nullness")
Cc: stable@vger.kernel.org
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4d..ff9b1f68ceca4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8471,7 +8471,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static bool can_elide_value_nullness(enum bpf_map_type type);
+static bool can_elide_value_nullness(const struct bpf_map *map);
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
@@ -8621,7 +8621,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
 		if (err)
 			return err;
-		if (can_elide_value_nullness(meta->map.ptr->map_type)) {
+		if (can_elide_value_nullness(meta->map.ptr)) {
 			err = get_constant_map_key(env, reg, key_size, &meta->const_map_key);
 			if (err < 0) {
 				meta->const_map_key = -1;
@@ -10221,13 +10221,16 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
 				 state->callback_subprogno == subprogno);
 }
 
-/* Returns whether or not the given map type can potentially elide
+/* Returns whether or not the given map can potentially elide
  * lookup return value nullness check. This is possible if the key
  * is statically known.
  */
-static bool can_elide_value_nullness(enum bpf_map_type type)
+static bool can_elide_value_nullness(const struct bpf_map *map)
 {
-	switch (type) {
+	if (map->map_flags & BPF_F_INNER_MAP)
+		return false;
+
+	switch (map->map_type) {
 	case BPF_MAP_TYPE_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
 		return true;
@@ -10589,7 +10592,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 
 		if (func_id == BPF_FUNC_map_lookup_elem &&
-		    can_elide_value_nullness(meta.map.ptr->map_type) &&
+		    can_elide_value_nullness(meta.map.ptr) &&
 		    meta.const_map_key >= 0 &&
 		    meta.const_map_key < meta.map.ptr->max_entries)
 			ret_flag &= ~PTR_MAYBE_NULL;

-- 
2.34.1

