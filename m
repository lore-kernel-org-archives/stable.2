Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F395D39CD06
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117219; cv=none; b=P1si5p9Gz7ooLSY2IwFw1/9dQayZFh3Ohd4GeNHvKbw9D1xPgn9jdRx3M7ei7j3eKTuycF54q+BUUeO2T2W4kYR6tHTgzvChDQZg8vd6ANW8g/uP4V+oDD41cJXT4jn/WvXDjtdMQJ80NMrPnKnzs6kmBUfSzE/50pdPH9YITWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117219; c=relaxed/simple;
	bh=t4G+rp3o3QQb0uixe/zF+RppGjXCWGxNuVviYuy97f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVOmxOCrUFqfly95ccGCX5/pbnm8lCYCeiHde5StcmLFClchjvxM8pfB6V4hKkYpPdEVs3JJnFiX/aho9admbSaEN/EBeq/eCL0CrWzjFarGmGRniAYl4VJ6fYfG+3ZxDEY7PNqdFPdPe+NjZwa39We2ODD6eUMlij2atkP2hvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=E30JFyar; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="E30JFyar"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15354aa70e8so1695587c88.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792117217; x=1792722017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IneB9ql9cZEWl0m4euLYZmuBKXti4FNDOTwpu2ynGco=;
        b=E30JFyarG3ZFQt7vYsXRaEgR2ZnXO7iBnzIZhyzf/4sV/12WQTrsZsWK9kFoVyHpBq
         XbJ8Bmkz8zgYdNtFYYOFi8/lIXWKRzBQqGkUOuJWztMWJi3d6Q74NxYg2z/13KWBhmTm
         atoalqzaVboObs8gCGfOVaN7IvI5px7O2BD2smQh/lSg5rBSk/TxXKGDNIPcSt/6pBv2
         z+oMuqbG4XYor6HMV8cgw4lbB+RNf5l9s3d3NVA0XAAfrteysBAOY8umWk85ZWOuGbPZ
         z3ZH7wmWbN21+kssrgPALfOLsK/SXrosz7VXTtHWAOFa1onulZ9RPlHYMIjlWG8JK507
         +BUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117217; x=1792722017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IneB9ql9cZEWl0m4euLYZmuBKXti4FNDOTwpu2ynGco=;
        b=KMMx5TMfTNBEnFMibpZZ8JjyjU2naAeVmi4M8jLa5rhFWX560ACQ0bENPGdoTIzmEj
         /jV5zB1GXpH7CAER9ucJSYcenevBzm/Z9zC8h4qioXYqvoiN6+GGg/SyyC2rir45Ky8C
         MY9D+uZIQ2PQ2FD349m3opWy11/Yq8Vvi6FVYbkijtu84adRGg1Ec9G2LxhCvjKnSBeY
         LgwBIzPMSZ2Hj8FngIAPut0BnCs8NYNIAcIAbxZYTmEgsbXdb/vFrO/REJf6sRzeFX1D
         KOLZm3p8X852p1dCeFkNxsPXeKuJn5G5/PF9TJUE5OG2QJ9torKqmdF3wEXOUjvP9gnu
         i/vw==
X-Gm-Message-State: AFq9FYK40ZlOfaUcStIB8EoX2HUDp3gH6OqwOLhKnzBtiokv677hm7dj
	AgJa6KEzhMvjoBz8Zyw4KB6NFJtgpXQA/QrOK1x+ETMJhABplHYIq8k2gjjnYVjR38tlcHa+88i
	orIH9hQp5JQ==
X-Gm-Gg: AYBFou0wgMV33akZx+t0LNy0Uw9xzI/AemudW7/ka/p2xfHnBAqiZpv7lV9FLJ5uZVY
	EXeCSuYMfRIPDAG+vCd+pV01yOyn2ogp7tc7aWq+aSzuD3Ub4LWWWJh59ShaF5AX7f+GCnaGZCj
	NoYA8r/KdJszlllMn86TIsJ6K+Mpl7kE40y2UyUuvWZ6kfUb1cmIfqCbbGHYDLNx8vtVQG5FIjS
	hicXrxjn3es1KMUuNz6iQZDBHHGvMVHbRVTFyikqeUIjSRydJUy2rGkzR8TJm/y+WOp/LNJm2ZA
	2p7uKdgUzmPE/jdavnHJ54XiXsFc2kxhDmrvYPaiHwIQOuHMPKTG7zbVKtwY6ivF/VcpfbRmkCV
	TpKzqkKV+HTIZIXMQU5AgctYtutwflvlPis09C3IUegb0L3jrjpMw0iiu1aDjkQHmREZr8wwOf6
	uDoFhJOPth5weQ4iRKlyRLLhHPP1oa0wBQs9vVWGZ/q8raKWPuWz220AJa36ki9D4dTI/260y60
	KJWzvJBhjBBF3Nd/rOhPZz3dKEP1r6GVjW2kZ881DqGBijEy++HbszXbKPpJW6Lp6FV3g==
X-Received: by 2002:a05:701b:280d:b0:16b:fdbf:4a9d with SMTP id a92af1059eb24-16bfdbf4ff5mr29140509c88.27.1792117216849;
        Thu, 15 Oct 2026 19:20:16 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c5cb39esm1434734c88.22.2026.10.15.19.20.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:20:16 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y 1/2] bpf: copy_verifier_state() should copy 'loop_entry' field
Date: Thu, 15 Oct 2026 22:20:10 -0400
Message-ID: <20261016022011.16938-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016022011.16938-1-artem@trailofbits.com>
References: <20261016022011.16938-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit bbbc02b7445ebfda13e4847f4f1413c6480a85a9 ]

The bpf_verifier_state.loop_entry state should be copied by
copy_verifier_state(). Otherwise, .loop_entry values from unrelated
states would poison env->cur_state.

Additionally, env->stack should not contain any states with
.loop_entry != NULL. The states in env->stack are yet to be verified,
while .loop_entry is set for states that reached an equivalent state.
This means that env->cur_state->loop_entry should always be NULL after
pop_stack().

See the selftest in the next commit for an example of the program that
is not safe yet is accepted by verifier w/o this fix.

This change has some verification performance impact for selftests:

File                                Program                       Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIFF)
----------------------------------  ----------------------------  ---------  ---------  --------------  ----------  ----------  -------------
arena_htab.bpf.o                    arena_htab_llvm                     717        426  -291 (-40.59%)          57          37  -20 (-35.09%)
arena_htab_asm.bpf.o                arena_htab_asm                      597        445  -152 (-25.46%)          47          37  -10 (-21.28%)
arena_list.bpf.o                    arena_list_del                      309        279    -30 (-9.71%)          23          14   -9 (-39.13%)
iters.bpf.o                         iter_subprog_check_stacksafe        155        141    -14 (-9.03%)          15          14    -1 (-6.67%)
iters.bpf.o                         iter_subprog_iters                 1094       1003    -91 (-8.32%)          88          83    -5 (-5.68%)
iters.bpf.o                         loop_state_deps2                    479        725  +246 (+51.36%)          46          63  +17 (+36.96%)
kmem_cache_iter.bpf.o               open_coded_iter                      63         59     -4 (-6.35%)           7           6   -1 (-14.29%)
verifier_bits_iter.bpf.o            max_words                            92         84     -8 (-8.70%)           8           7   -1 (-12.50%)
verifier_iterating_callbacks.bpf.o  cond_break2                         113        107     -6 (-5.31%)          12          12    +0 (+0.00%)

And significant negative impact for sched_ext:

File               Program                 Insns (A)  Insns (B)  Insns         (DIFF)  States (A)  States (B)  States      (DIFF)
-----------------  ----------------------  ---------  ---------  --------------------  ----------  ----------  ------------------
bpf.bpf.o          lavd_init                    7039      14723      +7684 (+109.16%)         490        1139     +649 (+132.45%)
bpf.bpf.o          layered_dispatch            11485      10548         -937 (-8.16%)         848         762       -86 (-10.14%)
bpf.bpf.o          layered_dump                 7422    1000001  +992579 (+13373.47%)         681       31178  +30497 (+4478.27%)
bpf.bpf.o          layered_enqueue             16854      71127     +54273 (+322.02%)        1611        6450    +4839 (+300.37%)
bpf.bpf.o          p2dq_dispatch                 665        791        +126 (+18.95%)          68          78       +10 (+14.71%)
bpf.bpf.o          p2dq_init                    2343       2980        +637 (+27.19%)         201         237       +36 (+17.91%)
bpf.bpf.o          refresh_layer_cpumasks      16487     674760   +658273 (+3992.68%)        1770       65370  +63600 (+3593.22%)
bpf.bpf.o          rusty_select_cpu             1937      40872    +38935 (+2010.07%)         177        3210   +3033 (+1713.56%)
scx_central.bpf.o  central_dispatch              636       2687      +2051 (+322.48%)          63         227     +164 (+260.32%)
scx_nest.bpf.o     nest_init                     636        815        +179 (+28.14%)          60          73       +13 (+21.67%)
scx_qmap.bpf.o     qmap_dispatch                2393       3580       +1187 (+49.60%)         196         253       +57 (+29.08%)
scx_qmap.bpf.o     qmap_dump                     233        318         +85 (+36.48%)          22          30        +8 (+36.36%)
scx_qmap.bpf.o     qmap_init                   16367      17436        +1069 (+6.53%)         603         669       +66 (+10.95%)

Note 'layered_dump' program, which now hits 1M instructions limit.
This impact would be mitigated in the next patch.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20250215110411.3236773-2-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2025-38060 to 6.6.y.

The code changes are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 kernel/bpf/verifier.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 778a68bfb91dd4e765252cfb1bacb4b658d1381b..c00113e691955a6c9c6caa56007ccf90ce9b87d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1804,6 +1804,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->dfs_depth = src->dfs_depth;
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
 	dst_state->used_as_loop_entry = src->used_as_loop_entry;
+	dst_state->loop_entry = src->loop_entry;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -17561,6 +17562,8 @@ process_bpf_exit:
 						return err;
 					break;
 				} else {
+					if (WARN_ON_ONCE(env->cur_state->loop_entry))
+						env->cur_state->loop_entry = NULL;
 					do_print_state = true;
 					continue;
 				}
