Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420832;
	b=jH6Wh0Vdg6s5gNN7GHz90ctSikPTk2RfoUpn03VJKPwEQMw9xwD09y1ROD4vjyJKloRw
	 c15Rm6zH18YUglLU36CVNiOQ3N/tNP2ap2Fh6mXIZ5SbdqXBa3MUuPadh47ZMrsI6/mAp
	 onNKZVigzHJY+RdVO2FueUx6bx12z2l1TBt6AedwTIl6D06ADkMHvXbEPW06NnXrfUPJE
	 83h+tCb8v2hOdP3MWNzHluWkJuiECWJhzLhQm9VDKtXI5wtGBb0yfHo4b77PWDfJylJ1u
	 LPmbX3Hggomb9MWLeP63bdsZniIBC4HL1GI06Q2Zy9oA8nIpxh8qsC48EK7tjM0onUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420832;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rxZDV3nYxdbUnpHmE/B3X68mpGffGprb6aDXhTSC51U=;
	b=t0m5QIcjuVXZhS9X6Ka7da2Bc7DvKxw5NtTQUrvnkVgQ3byucSM/kzVaZU0x9z1Lz7mH
	 0cYaOgfO4DUtWEmrYg+H37b0D0epcNulETMiTDsdW5nQ206GhpBRt9YlMGTSBSoOTj7VW
	 TVUiJVuPVYte1TaqUsR4Kmp8EfWUfW2tFY2cP9VQxt/XA0k0LY3DvM5b5a5Na3iMaczKJ
	 S4K3GrBOEg70NQ5WhPbaMMcIGl8jrrFHPU87Xsd5XYYcg4FETL1l5layJHWndfsQHRJPz
	 U9JaCHoT6ZCO7ypPg+tSi7LI9fo2CMhDXrj/3ekK3VVk25MrPs6w3GG68OF5r+Kkt3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMdczkvZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C58606A895
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMdczkvZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCD01F00A05;
	Wed, 11 Nov 2026 18:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420832;
	bh=rxZDV3nYxdbUnpHmE/B3X68mpGffGprb6aDXhTSC51U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MMdczkvZhJoPo05C/uhIO92NfyN3TUSmbKSknLAQ7RePlHT4cWa84dhoUrP5sVLT6
	 Tk0w/D5pkD3Aaih5j/rAvxL7ZdO3y/0b6Cb7iFtT9zUw6Lb0ZuqMHBomu+brXRb86+
	 QBQra8BJ9GJwnna4fFTkNzyJpGvyDYAZV2SEvqQeJABo5g1+yDOhBbOGpL2Uo1zeED
	 O52Y74400JaZnXUe7dE36gOKZ9W78shc1E4DOcdeZBYQzn/JH3fSEBMtgu0qMQdfFR
	 MFsx6EwxRaIMbMR0XY8YEu4jG0g+kvLSOlyBqwx3P65tDlU142E6gtiYIwZWNLp9oQ
	 grU0K9ARAUP8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li zeming <zeming@nfschina.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] arch/alpha/kernel/smp.c: remove unnecessary (void*) conversions
Date: Wed, 11 Nov 2026 13:13:47 -0500
Message-ID: <20261111181340.3748826-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062501-failed-5.10-fe221b7b2d3e@kernel.org>
References: <20261107062501-failed-5.10-fe221b7b2d3e@kernel.org>
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

