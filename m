Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C0383C86;
	Mon, 31 Aug 2026 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211386; cv=none; b=i9SggwmvZ10J2KsTeNxZvUbOVC7LfqSvB0UTEHnR0qsiXJESheB3/Hr3TaheqjdnitwO1KiBTCPNu/MjqYYCF21yZrlj2HnZvSQTAOwaxEhTsJTJbZOznSgECjcwfY6IV8JwoNZCbJE9aSBcIA5+8dbqw1CIkOwPJLDisy/WBgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211386; c=relaxed/simple;
	bh=nldIFa80IYCsNGDvP0UYw8EP4Dl1TsymhJvMip51JsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaMLoV275jZirlr/pXzH9D/t71DqoK67MmLomzIDaX+bZnILlP1qINdqjzQAH/VKmzspMR9bxs+4lFqO7jqYbRhH0U/aP6ndxLC7CihnYpTDt/FdJDKJDdWJCZZqugXqj6Xx1Ud2lIxH2dsFT9HUYJNyM6nhBOrOWqQ777N8uC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2SUXZ4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2SUXZ4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6B21F000E9;
	Mon, 31 Aug 2026 21:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211383;
	bh=yx2a5OwppLln4gWqpSEW4TXJQoCBkyAK3jcFYAoVMww=;
	h=From:To:Cc:Subject:Date;
	b=U2SUXZ4sb/kx8R1IsXh2MrXNE20XselxAn2li/tjOXoe3LkZoEs9PG/19UC/kzyz9
	 BZkiY7CUUsa+Ow/4X1jCSNweXSniu4va2PUifEOiXdaY/RwcrfToA5VvIOrfQs29JC
	 RDLhEVGCTAq/6Um//9vof3tq9xE8pTNuu4Curm4AukICPFyofNpF9ianqaBKY6qK4o
	 6d8lQAydKWSqZCySQ2LSimklUt//ClG8KjQJF5kQyPXwSgVVUJUqUKyrYssHIld3Xo
	 ILQbEARGKUQ0R3RKI8X9jk8HP756tFtQn5+yh1Kgau4jfWGRKsk6m+M0aUYl6S4xRm
	 KZM4MvO2/47VA==
From: Eric Biggers <ebiggers@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-raid@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] xor: add missing vzeroupper to AVX code
Date: Mon, 31 Aug 2026 14:22:48 -0700
Message-ID: <20260831212248.213805-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the AVX optimized XOR code uses YMM registers, execute vzeroupper
before returning from it.  This is needed to avoid degrading the
performance of any later SSE code that may happen to be executed.

Fixes: ea4d26ae24e5 ("raid5: add AVX optimized RAID5 checksumming")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

This didn't get taken through the x86 tree.  Andrew, it seems you're
taking patches to lib/raid/.  Can you apply this one?

 lib/raid/xor/x86/xor-avx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/raid/xor/x86/xor-avx.c b/lib/raid/xor/x86/xor-avx.c
index f7777d7aa269..95b21e7225e8 100644
--- a/lib/raid/xor/x86/xor-avx.c
+++ b/lib/raid/xor/x86/xor-avx.c
@@ -147,6 +147,7 @@ static void xor_gen_avx(void *dest, void **srcs, unsigned int src_cnt,
 {
 	kernel_fpu_begin();
 	xor_gen_avx_inner(dest, srcs, src_cnt, bytes);
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.55.0

