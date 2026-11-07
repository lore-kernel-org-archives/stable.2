Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081533;
	b=Ee/6r3oRv0Gg/kClMvFnqKYzBR5bzV4HHKtgNDBGqDstq/OUbFrDt9Px5nHzL2ixFXPz
	 iqrMbHwMytdF1yqyCzZNvuKf0Wx1U3wgr00IXC23DhkrFM5REtwMTOSrkKd5c4X1m5XAc
	 pTQiOr3nIG8Qa9qAgsXgFOhxHBsuH7pg2JQhAQwKMTBjkFX51Q+d2CL+Ca1gGt9OTGHjr
	 /wt9Sc9XQJhSjC3IJCRLBH8gbMuktwbrZFhGW88ZsKaZ25NVqWaPbne/mJR5xoOb+u3pU
	 5JU3zvNgdlvXiSHcBTg+/BeMKjpBnBjcmFHtqcc6aR+KUaJTN5I6d9DOfhxMkBntcrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xFR4mDwbmHHyTyXtuI5xHvlbYQma7f5XLvvaKXC/OQ8=;
	b=k4i7eT1cwmIcnpgL1Cf+BMpdOLZRbLMLjuYG9/UDVsJle+ap/WSUUo3Yn0T3Bmd+P8ub
	 k1xbT7JcDi8wuV1RnnJZGhE4pUOghcpg3Co7jGbZVVC9RZHFx88u08GJg4su5OA8Cczm9
	 nKZf8e0EZkZfeepCNMTJzPX7v50T1LE43r/vG7rg39WjqP5SCCl3OoV0qX6dTJxGN0HXl
	 fkQYAXNE047+n8wZPw8/xgPBa/Qk6+irLte6xwRUlI7pJ0rL7xN8Z0vjmG3DjOgQwUE8l
	 4c48z61pisVX6Qx26ujt3wKPizgjvkTdrqlQ8s+N88VEfMdXd3ajCo8p+eu3AivvwaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PgEgm0Ac;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D5606A32F;
	Sat,  7 Nov 2026 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PgEgm0Ac
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA2F1F008A3;
	Sat,  7 Nov 2026 19:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081533;
	bh=xFR4mDwbmHHyTyXtuI5xHvlbYQma7f5XLvvaKXC/OQ8=;
	h=From:To:Cc:Subject:Date;
	b=PgEgm0AckeL8jzvspUR+ma9D6C+LKcGuP+pDmf48uOe9MprtWuNSrEQDto0wGCfJu
	 X99mQX4Et9xaWtMnS62eM1xuCgR9fhjevwVwIXdSD41RjFF9JyAs0o0YmAMYcf/DVu
	 EYjsWG2bbHakDeSJyjQCBBmfHKlaxS2XNHmoWqem6GEN/pMfY5N8SvMBIr6BBCBDAi
	 57L4NRqqsbpqZm3zi5wNavxP34MTndYolnZ+xcm+E60JCqBKQL1z0zBoelU05pPOK0
	 p3oETIpjQfYGla0Lmto8D9FjHgkswiPNC9BoC88tlwJSgYcMZwiLeADHegPLQWshtK
	 y6V+RTpntmkbw==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.10] xor: add missing vzeroupper to AVX code
Date: Sat,  7 Nov 2026 11:58:34 -0800
Message-ID: <20261107195834.86581-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 7b8fc26c40d6cf4c6751a045c9e42bbb7e78d81b upstream.

Since the AVX optimized XOR code uses YMM registers, execute vzeroupper
before returning from it.  This is needed to avoid degrading the
performance of any later SSE code that may happen to be executed.

(Backported to the old organization of the XOR code.)

Link: https://lore.kernel.org/20260831212248.213805-1-ebiggers@kernel.org
Fixes: ea4d26ae24e5 ("raid5: add AVX optimized RAID5 checksumming")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
---
 arch/x86/include/asm/xor_avx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/xor_avx.h b/arch/x86/include/asm/xor_avx.h
index 0c4e5b5e3852b..10b703dfc7c43 100644
--- a/arch/x86/include/asm/xor_avx.h
+++ b/arch/x86/include/asm/xor_avx.h
@@ -49,6 +49,7 @@ do { \
 		p1 = (unsigned long *)((uintptr_t)p1 + 512);
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -79,6 +80,7 @@ do { \
 		p2 = (unsigned long *)((uintptr_t)p2 + 512);
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -112,6 +114,7 @@ do { \
 		p3 = (unsigned long *)((uintptr_t)p3 + 512);
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
@@ -148,6 +151,7 @@ do { \
 		p4 = (unsigned long *)((uintptr_t)p4 + 512);
 	}
 
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 

base-commit: 3a323bc22b881a5bdc1646080f93f5ecb22850bf
-- 
2.56.0

