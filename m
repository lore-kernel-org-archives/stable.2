Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419877;
	b=Gq8ikzxINRGF5cloYnk6V/6/Vx2kMJX7kTygDgD7THAicJPEkK2RUiPieWv6aYgoZYuL
	 HSbPOkAO/i2xqFn/SaLM6lYo/FztxGOxp1U0HVmMo7Am427kHfxlGBWK9CM/Ewx5799C1
	 VOWA15M+GklUl07nIVoH1dvBdA3AIxQvs473RpL5BfkGlnPoSY5Q4qlM3w422Hff2jyV4
	 Ymj91oDv+1NHGuM842f/OZPXbPBhDrLG+f/vLIFaG0XamvgiKvQuz56FwQPPkjRPDrGKn
	 6o++bKlS/icax7+f6c6vS/pxqAum3jPvttNAFXB3zSJuhGat24D/GM/3bf5G4SHzCmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rxZDV3nYxdbUnpHmE/B3X68mpGffGprb6aDXhTSC51U=;
	b=0hu4AfG0BIZjiZLyqzf5ij/OqTymYiecAFOOJwDEOK7pMOoS9gjPACOJzr1YQgtsGNv8
	 FoVyY8CNdQXTe18aHYS9SgFb5uDc8fcIPJEWK1cg3iTXlitVNqgnZeJWMurujJDJG8PKy
	 3bp5n6p3+OiHsGyEoEWFz0FmLnWiOhzKqUJ4zFDD/ztZGYjSXSVlhz3ZQy429HZMxnhBh
	 nrhF7XFOls+IpSdrp86qBfqjW936ltpzgScdsEKesvVwp9QV0YQyDwqolhuyJmITq7Zoj
	 pRLJYvidY63ALTzEXuMdNAxZcK/smNksmrJVl23Z3DLGOtzIqmGv8TbUthCDG5hCAZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjsARsDh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D860A3833
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjsARsDh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534AD1F00AC8;
	Wed, 11 Nov 2026 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419877;
	bh=rxZDV3nYxdbUnpHmE/B3X68mpGffGprb6aDXhTSC51U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HjsARsDhM/1jgzFFG+ey76Cmt81nPXk7HnZf3O3RtP91hAmwYCG4RPRDWbis4/GU9
	 fzhavSnCZx5nZnftQsvkSBdSg8g2AMpP7Px/wbAfWeBE/eRcW8IPCK0bAfOD8hBw2N
	 RPRONBUI/2SinbLycM26xMkd+kdZpugFS4Ozg0jVouW8BJDTM+G99HalU5vCMBNEQu
	 z0D+X+utADLzLyVLKwMC5TqoKTEOge7AIuiGkYKsogNrRGB8WAWZfSzptE82eDtk3G
	 IX1y/hP7cDPdpUHbJwrsCBA2nVIytATBxkba07Kvac9ggdWD/KbaEw9VREwQhrsq5m
	 KflaNqxpKjN2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li zeming <zeming@nfschina.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] arch/alpha/kernel/smp.c: remove unnecessary (void*) conversions
Date: Wed, 11 Nov 2026 12:57:51 -0500
Message-ID: <20261111175746.3724675-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060811-failed-5.15-fe221b7b2d3e@kernel.org>
References: <20261107060811-failed-5.15-fe221b7b2d3e@kernel.org>
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

From: Li zeming <zeming@nfschina.com>

[ Upstream commit 829715a2d14c7110987bfa5e6173b516c41f8627 ]

The void * type pointer does not need to be cast and assigned to another
pointer.

Link: https://lkml.kernel.org/r/20221213074522.3738-1-zeming@nfschina.com
Signed-off-by: Li zeming <zeming@nfschina.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: fe221b7b2d3e ("alpha: do not skip TLB shootdown IPIs for kthread-borrowed mms")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/alpha/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 8a712076436f0..8fa4345306a53 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -634,7 +634,7 @@ flush_tlb_all(void)
 static void
 ipi_flush_tlb_mm(void *x)
 {
-	struct mm_struct *mm = (struct mm_struct *) x;
+	struct mm_struct *mm = x;
 	if (mm == current->active_mm && !asn_locked())
 		flush_tlb_current(mm);
 	else
@@ -679,7 +679,7 @@ struct flush_tlb_page_struct {
 static void
 ipi_flush_tlb_page(void *x)
 {
-	struct flush_tlb_page_struct *data = (struct flush_tlb_page_struct *)x;
+	struct flush_tlb_page_struct *data = x;
 	struct mm_struct * mm = data->mm;
 
 	/* A targeted tbi() needs a thread of MM to be current.  */
-- 
2.53.0

