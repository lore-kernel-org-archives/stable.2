Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046795;
	b=NHhgMqQ9pyspreXVwtaII5C56B3purshNofV+pdKsa2YCBnNhkkS+PRebGyyC6f4JAvR
	 H7MmlOUw7W1e6S2ue/2RsPLVKfrVgv38lwBdzPj4ukjtAWLeF+CaIvkkUQOZ6bA4R533G
	 xuikdVA8cUy6qA8IzZpcsf+VicqMsxOLKT4iigOiQB6O+4QJidS8n1jUmpcqUFDfoIgpF
	 TackZ5Di2Pgye/XwcDXwPKEQMgSskEer/E1hvulcOaAY/o1Gz4Mu6gSk1WUgDoz1kKumN
	 8p0XTzZ+6BsZp4kDHPhhvFF3v4tZZEBs9OUFWaVEONp3ett1l57PMyQljFLN7YyNFJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046795;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=w+N4exbQMyjkxoOBzuuaSXjdUvHvkR4ZurVS7VnvwQc=;
	b=tr4LGUswZ4B1dhp4rR9/Lz6OfXFFxZjNnyZj6LRrud01XNc3gHmkUYnNlNjYavTsuIjd
	 vjVxEoqE0S4vzrcaLmnY+G4bfQsuvjvccT9zE2tqMKy+7QswkYTRN7oK/92lyftcysOTB
	 CQSqa38awJ4IzDBEOjPAFQVwrDpYBQTGmXmGm6XQ6PZMNDOFI/OgycGq09FcXxKtqJyds
	 EP5+zWXMbvQf7nJm/gdCjXffjWJxShs7s/wRANEcZSOE5InC5EXvUH6eair7thMiK5A/8
	 3qixX2yfmS8KoQR4TJecCwve8lCnuSNTkilk3/qkIabzvKwxeSnlw5Swn6Gb6W7GgcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1hBU5in;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB4606D829
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1hBU5in
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB491F0089F;
	Sat,  7 Nov 2026 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046795;
	bh=w+N4exbQMyjkxoOBzuuaSXjdUvHvkR4ZurVS7VnvwQc=;
	h=From:To:Cc:Subject:Date;
	b=R1hBU5inueZeoJf8sAWbgU4kHD8GH717WuLn0Rw6igGeeGQb6HOiHVC+lCF2qbVah
	 N5tvk5I1DwrTFGd+Vc/GEBYZ5ym5TVcQo0udAjOC7ZU7YfxGS4kDVBouThDDI5rBlL
	 /tfu11LHicXrI+FGoSLKEPqridX+hbOKB6LOqJ2cc4ynG5zQxgio3UzODScFLTtZ6m
	 jDc6hdcgp1/8MW2/FpxKdWmbY60lH/rvE1qp/+Vm9h1tJuwb1QEjl3RUcvcljnGe5U
	 dsVI3hdtJHrB1uqovWrrTh9r/PayyhkdEBZFAdbmgR0V3xV5YfoKB37schpjz7+wcv
	 p8fJsRvn+b3MQ==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xor: add missing vzeroupper to AVX code" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:53 -0500
Message-ID: <20261107051953-failed-6.12-7b8fc26c40d6@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7b8fc26c40d6cf4c6751a045c9e42bbb7e78d81b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051953-failed-6.12-7b8fc26c40d6@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




