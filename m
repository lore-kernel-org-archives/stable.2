Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048316;
	b=SMcy7yclDCLC4CPSanR7ZvjjnTi/i0ZO4Yqq/xfcgLLxcaI5VusxNr0H4vChQqAKcvNJ
	 HUxwrQuGX+eb7Y37go3JIR1J0Keu1j2EZiSQPU/IsVdFIYCuc5U0hlu0vyP31z/vCruhb
	 4g6ilTZekTpzv1CjAFyOBH6wIk75wu0Y3a4pekOiJPvF8BhALBArBf8S7i6LLtA1L9cFx
	 BppSffqsC39I/uRbEjhFY4cFsgJpn5aBp2q0/MBuQjCniXfVR/J7M+Jqq88EZkpp1w/uV
	 K/rgPj8J5r1DUt5hZO/uXMoyCOosbju1ZI80BNyVzr02IlIzqLFLrK7NtyBMjixj+ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048316;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nX3yQoK8HUkIasDJa2UzYVGEIYk9PkSrCNQV4746Wno=;
	b=EBzM3dpl4S7y9zhNqctIS3kKwD2CNEAv4puZJkZIqzsy6Du5KNXpqERa7iqul1kF6BXL
	 6Xf2M8PxfX6nqzbXDS3+aX6i3WYZom7fuymrXXtRXXn8yHHqXspNXfnbmO7j4/j6izTJf
	 5kYAD8TRONJo6hmI4pV1sV1OUFSKl4oUHIS0/Mvr0/naEZA0yxaqqXawLGIrbGfWV7QsN
	 TIMT22Tsx5V6fi7//AMmTX8zLBVVIcywMzhPT0SRBGPpAAJIdXOsInzz6IUgbtcgBssD9
	 sW9bohLBxpwPJimLbhiiGHjanJXuTLvKbZeo4mbyr+UmDesjkjQZOuuZxoExZY2CcNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eVR0nWYj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eVR0nWYj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5121F0089F;
	Sat,  7 Nov 2026 10:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048316;
	bh=nX3yQoK8HUkIasDJa2UzYVGEIYk9PkSrCNQV4746Wno=;
	h=From:To:Cc:Subject:Date;
	b=eVR0nWYjAIosRACpf/WqpJyXM56DWxucF5zaOTY9s1MLGXoKpS6hGKaiU4cT4Uk+o
	 w6AvMfCCsf5ovJPnyMhN0cCWXFUZT16zBfu4z73DiJnRjl/z6bfJaMeWrifI3LUEty
	 v3wk5G00pndJRlGqcLLAJMuUMuZjPFM827I770mtlPqoqDY6kw60FVAHtMQISIn3Cu
	 zyi8VFn1rWAtdGYK8jfsbA5WFOrV+BEsgeh0XdEZCmiSx0/H+xFM7BwdwCRgpR18jr
	 +HlKwjju2dsadrLCEl5q83A2fQzERQqqi1krwyIDdESoiNPaMNWghE+0/M5tfLwKWR
	 r3BKguJvBhgpA==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xor: add missing vzeroupper to AVX code" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:45:14 -0500
Message-ID: <20261107054514-failed-6.1-7b8fc26c40d6@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7b8fc26c40d6cf4c6751a045c9e42bbb7e78d81b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054514-failed-6.1-7b8fc26c40d6@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7b8fc26c40d6cf4c6751a045c9e42bbb7e78d81b Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 31 Aug 2026 14:22:48 -0700
Subject: [PATCH] xor: add missing vzeroupper to AVX code

Since the AVX optimized XOR code uses YMM registers, execute vzeroupper
before returning from it.  This is needed to avoid degrading the
performance of any later SSE code that may happen to be executed.

Link: https://lore.kernel.org/20260831212248.213805-1-ebiggers@kernel.org
Fixes: ea4d26ae24e5 ("raid5: add AVX optimized RAID5 checksumming")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
---
 lib/raid/xor/x86/xor-avx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/raid/xor/x86/xor-avx.c b/lib/raid/xor/x86/xor-avx.c
index f7777d7aa269b..95b21e7225e8d 100644
--- a/lib/raid/xor/x86/xor-avx.c
+++ b/lib/raid/xor/x86/xor-avx.c
@@ -147,6 +147,7 @@ static void xor_gen_avx(void *dest, void **srcs, unsigned int src_cnt,
 {
 	kernel_fpu_begin();
 	xor_gen_avx_inner(dest, srcs, src_cnt, bytes);
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
-- 
2.53.0




