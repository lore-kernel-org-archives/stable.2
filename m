Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6661FECBA
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 04:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787892384; cv=none; b=bMhn92dnEtS3LJRgZquI/tSeeGxpjliOJ41NafxAzWGqRRH7d1TYfiadsGbNUjfNps20h8dM7YssAG2vpeOcZlk66DVmm3mrEICv/92vRi7z/JLN65YQO70qF3x3BqSHSS1JPHSlWCgd02R71etjlqyp8o0u1H5V7oF8DDrn5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787892384; c=relaxed/simple;
	bh=DxS7dsTRDluIU/9qsxEhUW8jUVshDl3CGgsRutmjBBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaFHQCwOQWdNFI0kJrZ2dfa1uoeNXmz9TD+gGR1A+FltL/8DtakMiocLor4UYuDwK63HpUIKGTztfvjJPQNwk7TxAhbEqNR3ZStZhEa89hDUYmCARMT8elQJy9Z3HDq2L+qX9tJQIQeRnXoP+M+I5RNDheojSNFNdXiIpy7jp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=cKBjnBVM; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="cKBjnBVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	Message-ID:References:MIME-Version:Content-Type:
	Content-Disposition:Content-Transfer-Encoding:In-Reply-To; bh=DY
	UUCQrvTLsV/QOasNElpLeWFHdbfrfLEVIgEq4pAiI=; b=cKBjnBVMDrwzBrWwge
	px7n1YTmgIH5b3sY75T8hsxxcAdjVGK9bEZSYnUB+hdTGWl+7sM8e7OHioP3fd8Z
	icmx8KEHyQv00RJvUw+r/3WmnU+daCF3GuyLstQlc85pUyGOyzmtzzGd4N59jV3R
	eFgSRMhNV7JPJxBbfQHYSsxow=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCHeiGGEpFqyb+sAA--.619S2;
	Fri, 28 Aug 2026 12:45:58 +0800 (CST)
Date: Fri, 28 Aug 2026 12:45:59 +0800
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: Willy Tarreau <w@1wt.eu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, security@kernel.org,
	andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
	Tao Lyu <tao.lyu@epfl.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] bpf: Ensure reg is PTR_TO_STACK in process_iter_arg
Message-ID: <apEShxAOrNDGUoga@DESKTOP-F439VFF.localdomain>
References: <apDzg_JciKsoBk_A@1wt.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apDzg_JciKsoBk_A@1wt.eu>
X-CM-TRANSID:3pYKCgCHeiGGEpFqyb+sAA--.619S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr18Xw1DJF4rZrWUuFy3Jwb_yoW8WrWfpF
	1rCr90grW0ya17Arn2vw4I9Fyruas5G3W2kF4Fvw4rJFnYyry7Kry5WrWYq34qkFy5K3Wq
	vFn0v3yDK34UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx
	0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402
	YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07je5lbUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Currently KF_ARG_PTR_TO_ITER handling does not check reg->type.
process_iter_arg() therefore accepts any register whose constant offset
resolves to the stack slot of an initialized iterator — a bare SCALAR
(kernel panic) as well as pointers to real kernel objects (map value,
ctx).

This is the 6.6.y equivalent of 12659d28615d ("bpf: Ensure reg is
PTR_TO_STACK in process_iter_arg"), which is in mainline since 6.13-rc
and was backported to 6.12.5. The original commit was framed as
completeness (align with process_dynptr_func) and was never queued for
6.6.y. 6.6 still lacks the type check (verified through 6.6.154).

The verbose argument index uses `regno` to match the surrounding 6.6
messages in this function (later trees print regno - 1).
The verifier_bits_iter.c hunk from 12659d28615d is omitted: that file
does not exist in 6.6.

commit 12659d28615d upstream
Fixes: 06accc8779c1 ("bpf: add support for open-coded iterator loops")
Cc: stable@vger.kernel.org # 6.6.y

Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c | 5 ++++++
 1 file changed

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7827,6 +7827,11 @@
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
-- 
BPF-SemSan disclosure follow-up

