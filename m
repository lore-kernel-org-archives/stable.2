Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050360;
	b=sAUhVVJU/EHC0rZrnflG9OR9p1N5+bV9N1wVD+KiAoYp1J1/PZbaMf9DJk/UqoS6Daq9
	 pnaav9ceR2kx9alqIvcHE8PvxrxOdO6uf3R0Do4fUZKqzHbTbZwXwBT1FRtrxPdIRsFHt
	 cLSJpZA0IaxNfJYyqzJS6MMR5poPg1YRJjoJBN1Fn6aiB1nfvGpTTa+K5XLpwb0h5Hiwr
	 Z/tJ1Ma9Up0ZkuOvrfs+AH3FZ/6I5cp43ifSMgcV+IQdtyjN79v/2FYSlB4gvlq43+AUl
	 5k099BxEU1kZPl4k0KnA1kCAHP0u9Ku+JiLcu2+PTIgD7y2ZXoEI/mAcZx9USQNt/Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050360;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bajUh5OVmD55ShPsw6l1labYeK6jkXpARYojOF3B20Y=;
	b=Wb8QmZwm/EAcf8y6o5qAIw+vIE1jV8n+KaISdSGm3ZVikwh6NvaiuVj4e1+PPxRXV16D
	 NiUoDu+0pINsTXzQrbHQMUNjOSiH5t9QBqpgPYPliuJfvGERt08Lwp8J9ZBLMCuexMxv1
	 b63C9yCvWY8kchWDoaKfdFrNYJkAmyxlUEDFU1qDTEe1SEbVPVqyH9I3GhZGaSn4BXmYK
	 qaAuW9bA3nWy5bpUg1lX7E5qh84RBg2MLtszhW/y8oavQR9TU4a2LXCjkMW9/q4h84zsI
	 nxR2qLP085rciMApOCg1/3Osv3sEvf5kLttClbL/Uu1e+uLECK/qk82lBGXLoCtHUeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U5j/oIwZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95908606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U5j/oIwZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F401F0089F;
	Sat,  7 Nov 2026 11:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050360;
	bh=bajUh5OVmD55ShPsw6l1labYeK6jkXpARYojOF3B20Y=;
	h=From:To:Cc:Subject:Date;
	b=U5j/oIwZLJGh5ineccACwSTRdS7WNebUDz4vQrbVrYp/qOHl9WpfI7SKTXI41vrQ4
	 67h5IhZUjMExbp+LGKL4Dij2aa4meVxdrE56vWUcXPfnwPEKi2u+1sb+1yhLurq1Td
	 cOuqD/ILgVBenY271QdRpAR8I7/4RbdrSeiQfXC8a61VQJoe6DcHBnoUH1vTTC3jJH
	 dBtj9gSzMAoIhCigvUO3yEXIwo+fvTti9kEE7BZWVX62mVxjg2TshNNOsT203fLzik
	 YS9VK9grpDIA5LXMNaFqeZln4PdJyxvMq6XP1wfccMFkSZD3xyxJRrCFQk7FwYLCCi
	 qbSKKZZKPNuOw==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xor: add missing vzeroupper to AVX code" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:19:18 -0500
Message-ID: <20261107061918-failed-5.10-7b8fc26c40d6@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7b8fc26c40d6cf4c6751a045c9e42bbb7e78d81b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061918-failed-5.10-7b8fc26c40d6@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




