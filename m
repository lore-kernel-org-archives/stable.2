Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701792D061C;
	Sat, 29 Aug 2026 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974091; cv=none; b=ozDDnXtH6e3fGc/3jsfy3/F7/zzan+cpYyw7+g6JwW4XN130aXRGI0ANCxeaKV96ySS5TdPXuR7tPY8Df1cZILLTpDRGM+pKcp83rcMve1l7p/QIqCwYxegaVFCncCABiiHNL3yE92yx4Q6+ydp4LRxgpdXg330K/ugFbhGf0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974091; c=relaxed/simple;
	bh=WPs3wAJgEq3flVs62pD60OVHXkTNvKDl0z42at+9wZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgXU85NEmVYikVl9sbfmMsp2Fkth+htgDx85lYzwfqaqq5ChHxB1VaBpCaJ2Ny1AhwfTLEZVffx5EQJGKoOrjtSyjvy9d7bbf6ETKdyiyL55kIk4jMSgCife1Nj2Fb/CheXOrZrPRkrVlZvF+Ud3ga30Zxhuv5sFbetPiE36/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=jCBwMaOP; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="jCBwMaOP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=1SiZ6RAcTnxUt18ISJf3Ko4dkoY8ASuNW5
	fj3eV0bt0=; b=jCBwMaOP4mkNa8gc4BAV50F3Dc54SxgJK2gjXPcjd5Gkh676Ax
	crxOlYHRa9VP9quuAYNEQm2QGSZ4QSWGREk2ttZl4Xj6OC2HJ1tVUs9xLm6tvgcd
	KZASzF4dV4zIsPxOPBqW7zG+XWJib+/a4rdnxYLcWWZA0nF3N6Ku1AZB4=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDHyTC3UZJq4VazAA--.190S2;
	Sat, 29 Aug 2026 11:27:51 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	tao.lyu@epfl.ch
Subject: [PATCH 6.6.y v2] bpf: Ensure reg is PTR_TO_STACK in process_iter_arg
Date: Sat, 29 Aug 2026 11:27:48 +0800
Message-ID: <20260829032748.2324743-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026082824-donation-nail-1190@gregkh>
References: <2026082824-donation-nail-1190@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgDHyTC3UZJq4VazAA--.190S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw15Jr47tF13tFWfGF4xtFb_yoW5Gry7pF
	1xWFnFgr4kCa129F1IkF4xuFyY9as5J3y7CF1kA3yFyF4DKa4vg3yfKr4Yv3W5KFZaq3Wa
	yrnIqws0q34UZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07boOJOUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

From: Tao Lyu <tao.lyu@epfl.ch>

commit 12659d28615d606b36e382f4de2dd05550d202af upstream.

Currently, KF_ARG_PTR_TO_ITER handling missed checking the reg->type and
ensuring it is PTR_TO_STACK. Instead of enforcing this in the caller of
process_iter_arg, move the check into it instead so that all callers
will gain the check by default. This is similar to process_dynptr_func.

An existing selftest in verifier_bits_iter.c fails due to this change,
but it's because it was passing a NULL pointer into iter_next helper and
getting an error further down the checks, but probably meant to pass an
uninitialized iterator on the stack (as is done in the subsequent test
below it). We will gain coverage for non-PTR_TO_STACK arguments in later
patches hence just change the declaration to zero-ed stack object.

Fixes: 06accc8779c1 ("bpf: add support for open-coded iterator loops")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
[ Kartikeya: move check into process_iter_arg, rewrite commit log ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20241203000238.3602922-2-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

[ Xu Yunxiang: Resolve the verifier.c context conflict by retaining the
  6.6.y BTF lookup and its regno diagnostic convention. Omit the
  verifier_bits_iter.c change because that selftest does not exist in
  6.6.y. ]
Assisted-by: Pi:GLM-5.3

Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
Changes in v2:
- restore the upstream author and complete Signed-off-by/trailer chain;
- document the 6.6.y context adjustment and why the upstream selftest
  hunk is omitted.

 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ad679bc42427c8..fc97a5fff9b7d7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7827,6 +7827,11 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 	int spi, err, i, nr_slots;
 	u32 btf_id;
 
+	if (reg->type != PTR_TO_STACK) {
+		verbose(env, "arg#%d expected pointer to an iterator on stack\n", regno);
+		return -EINVAL;
+	}
+
 	/* btf_check_iter_kfuncs() ensures we don't need to validate anything here */
 	arg = &btf_params(meta->func_proto)[0];
 	t = btf_type_skip_modifiers(meta->btf, arg->type, NULL);	/* PTR */

base-commit: a4a971135a2ff64382ae4235b3ae60503bb1036a
-- 
2.43.0

