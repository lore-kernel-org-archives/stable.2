Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047539;
	b=FA0ONxdXpHCEK6OhfZDI0yPU6qR00+K3OqQ+wSLk/cjClgZprKOflbCRDMzUYiWjw7wT
	 MHEyn91y/23Qlk6R6w2EU9GqY1SsY/YdHXlijJgxSV1NA3gK4uG+jUMU+0PyYXUSXNUSM
	 t3NOin8Ka2flgWCReMmP2bic6fTpxaKoxBUtySnd12pD+y5UyGWKb61Hv+PlxjuVNZlT8
	 univX1NZyQeyAm6Ho09FLC3CcUZ4ILs3bi98f3PIW5dsdEMjmvRa9BWkFNdtp6B4BnyIU
	 Onuis1OwSguGB20GJpVS4encyGMtX47/bOIK39VKXYDDYKrg0SSJLE8oT968A0ejDyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047539;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zHeesGOrjKSYO41GbkkUebByljASdNdk+rgeMJGkdHs=;
	b=xHfWp21oCL2c5gbBvWwU+OwA+usWQse9BgRGUPHDZ9tuPgNr/UtblDxFnOMG7svQAc3S
	 zugaL/aTTgl/SrF52nEdI8idn+lV/6MSO20BzMbCBmE72QWn4VqO3N66VFnGzsuwTNhNc
	 OAVT50A37xYVS0K86lCZge8GZx9NLvUDL3DJhRdHCg7ytjDwoPMW/ltFQHYsv3H0I+2WB
	 iu6mLkscD13IOG/soWDJsN8C/fSbQO7rP/vPOgBsqKUZBu3rIdJJA2ExvWpsngVYALL6Q
	 tmBzjqNCCvoc7zhglJsoO/l+Z6dTwWh9hcj73shtW/lXtN2iyaioGYe8y7y40eKjqUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVnT54n0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFA6606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVnT54n0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029EE1F0089F;
	Sat,  7 Nov 2026 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047539;
	bh=zHeesGOrjKSYO41GbkkUebByljASdNdk+rgeMJGkdHs=;
	h=From:To:Cc:Subject:Date;
	b=HVnT54n0yGWj2MAiLIQ9vDN8j4YPnXRrWOMUwPGoNYAohk97aivoz88PVWhOOvOTa
	 kZzeMv9c7dNOngeI+zt5wWNU79BIoXjGL2p784ZV1Q2XZ5/HsbA1DRyP/0B3IAvada
	 O+igsJsGBwNc9RjxMqvagoUeXs6pqbL7vZBKb7ePZqiO/23WcoVnQZLIza0acQC2ii
	 wL12/LXQyjz73Be0Ffo6L5ec8vSmE8q7Ltd8sLohicGeav9x04lElLQHiRRA20uO3E
	 mCwrPXjy+7BOFzjyUqikhveSrHcbk76O8uOTwMHcjSAaZNE0QUyUxpO9sxH3Xdlpvd
	 hCg9uxh8jKUdA==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xor: add missing vzeroupper to AVX code" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:17 -0500
Message-ID: <20261107053217-failed-6.6-7b8fc26c40d6@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7b8fc26c40d6cf4c6751a045c9e42bbb7e78d81b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053217-failed-6.6-7b8fc26c40d6@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




