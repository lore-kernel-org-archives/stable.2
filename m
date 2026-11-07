Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049362;
	b=mFUMOvl+NhPnJQLxu5TUHRfPDAsf195ojeFb4oJyXWcPZa3qTVyfdON56o4NbNZb42ZZ
	 vZ1pWiYtQL6fwYhTsxTQDVYYYKaqF3ld8ma56qD3EHSjnMJT0iAL5hCzq5NsOBobcvEd6
	 MLyKCvtZ2T/mQLYNtPpTA93CHQ31rMiRIiw84MXph+qrPDZguooX8RvWHdzD7BLTvEolg
	 mG6qtajdWYU2L0Mo0fBL91X+yYxKXgGv+xCV6FcGY1wt4pZkN06k5buvef6wa2GbEnaoZ
	 uj7pniP4ORCPKvxLOzKK1r8V8D/c5DBAdiE6V4ZOhrIkotZvlmxQscCajKIHY/G3CxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049362;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+RvTHfOJpUO4fRsL8Xz2dEsOakRf0v4SK11JgeFDNjA=;
	b=KSg7xF+1eP0Ta33773pYgvOAaDMWX+1wpWn8g+X64OcgepR2/vrRqja0V6BMNEUK+RZZ
	 uZQUbmcoIt/tNLQ6ak+LA3VEwBkJhGBQqt9j5wc+7rpY6KmvRI5VUfaGejNfP1cJrhp2+
	 5s/uLSi6RlPEgNhcEpRHM+Qx4/1kUL6cnW7ac4IFk9d7W0pxpdAMS1/UMEDeP8GuajFE/
	 GjkcpcDgnufizMX9R9HWCmvEE5ZmYZ0wCmrvlDtghXynl2JbNeSVCOQp6TXNFk1NxPVY+
	 BP4MDSPfske/6UdjZXLvdbspX/xbaCQ1dn8ZF+l/mriGs3l5fAiCiHkkHr8F/ac8srA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opZmupcJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE08606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opZmupcJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277581F0089F;
	Sat,  7 Nov 2026 11:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049361;
	bh=+RvTHfOJpUO4fRsL8Xz2dEsOakRf0v4SK11JgeFDNjA=;
	h=From:To:Cc:Subject:Date;
	b=opZmupcJS2XXD8PjSIlain94phd9b2jl6vySY2qKnMpQk7T8T1UQqK+Txcb+HHU6Y
	 G0cOGK2tC1ulTV6+uP7+8PLubi9HNNYKzVzN7a0UWStIGjXDqnUyrwmyW/4H9kTkyj
	 yZgPBvIT/kpKe2uqVTSMSvBI0DmRLjA0/3UZoy9VRgtjkSOoKlggjjCtk0laSJ0K/4
	 +m8ZyoO+LGGTbkHhsIins3JlB6h7XwAfjWGR6i+DOotXl9c4qLT9XDiIIsEbyAAvCO
	 9PhmoGa8wz3pulxY5ZXDnGfAm+5hwp5b+qlAGXemlB6SvISnnewOn/NzNoWtQLb1wD
	 2EVHpZuSTymGQ==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xor: add missing vzeroupper to AVX code" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:02:39 -0500
Message-ID: <20261107060239-failed-5.15-7b8fc26c40d6@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7b8fc26c40d6cf4c6751a045c9e42bbb7e78d81b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060239-failed-5.15-7b8fc26c40d6@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




