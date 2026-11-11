Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419548;
	b=ukZ+jS8mmuXDo8GG5+aalpHH8N+SPrWSGEKvSKCYOL4YUmsi2nHmbJSpme0/wpa3dDVk
	 QObqYA/J1Iw7glh8vjuYMzAyXNi8UdAtnWPEq/4RSeTLwkXqtt5fR6JaBKBheHXna68/Z
	 uWYWRvw3CS6p4W4DcYVeKxv3TCKD4viNxuZWYiDb4xKfh2XjYMUH6xEt760XUNAey75sZ
	 KYv19SpkZzJO/N59gEatZgak24IbjhEb//X3+mURxFNzeL5nCtONGhw3eIZYqhccv+4a7
	 uRYKOjdXquU62VAi/mkcgZrzYGDUBwlVE1ZSj/p234BWIgDnLjv/hzA1RR4utXt6E8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WaqnWNvV7JU7VNS/6Ua/J/JnApB2IJmo9S1AEr4ywbY=;
	b=Cu+aBP30DHcsPLxfyPitTYn4MEs+S+XTKkXK0GhTbInTA8jbIvF9VLaAn7zZcFc7FDjN
	 K2aHGo0bEXFqtV77lYZW6haOgwNsehIY4lNNz286zAJu4IX9FIH+MhEjFajaSqkfUrPU1
	 2tBLI/fTiyMByI6tSld+Jug2rmMn2+Y3JneAYnpQ9POzEeLSWgqJfcgmAoTs/Dq4qMJ0f
	 6FWHInFkDB2EXF0zJqY1lsOwol74JTpQxb4fqdIHNWUdMgl/tm67lKpaeDkPm+KdIsS0S
	 oxIlBDv8Jjj+lxJWArJEdFMGbKWW9IeMSsOn+GjEQhHWE3fS5rByx5g4j0iDrj0MBMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b7xr5fa+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E61606A896
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b7xr5fa+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D201F00A09;
	Wed, 11 Nov 2026 17:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419548;
	bh=WaqnWNvV7JU7VNS/6Ua/J/JnApB2IJmo9S1AEr4ywbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b7xr5fa+PfrYSyAf/G7PQLiIiCFsvmWN/jBwT4pkCOpmpfPjA3EBt192ChZvXngZC
	 btYYJcL4bR2MyllxaSvFjgo1p3S/zCZnTeFkAZftZfdUtyhnQpTpuB08oVO6ybwh5k
	 yHTDkx8cKu8GWwxVh4awC2OguOSm/QOrqvG6XMaTs1ozYnP1kUAH3nUtQyAzK2l1DP
	 2FJwGUmiMj0AGKnvM9uh7RLk5tJep+BR2RhMzDI1jxQ2rSwdfu+LzcjU+rx8XITfN6
	 Nfvh5hDiZWxAYqIJFc8ndfmxrNQjHP5xsTSLn+vDdsIW9AhDjN1JxVioXTGkj+t8+V
	 745Kiztq4DRMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li zeming <zeming@nfschina.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] arch/alpha/kernel/smp.c: remove unnecessary (void*) conversions
Date: Wed, 11 Nov 2026 12:52:25 -0500
Message-ID: <20261111175211.3693066-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055102-failed-6.1-fe221b7b2d3e@kernel.org>
References: <20261107055102-failed-6.1-fe221b7b2d3e@kernel.org>
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
index afa4b990f9226..9cff09ea8178d 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -628,7 +628,7 @@ flush_tlb_all(void)
 static void
 ipi_flush_tlb_mm(void *x)
 {
-	struct mm_struct *mm = (struct mm_struct *) x;
+	struct mm_struct *mm = x;
 	if (mm == current->active_mm && !asn_locked())
 		flush_tlb_current(mm);
 	else
@@ -673,7 +673,7 @@ struct flush_tlb_page_struct {
 static void
 ipi_flush_tlb_page(void *x)
 {
-	struct flush_tlb_page_struct *data = (struct flush_tlb_page_struct *)x;
+	struct flush_tlb_page_struct *data = x;
 	struct mm_struct * mm = data->mm;
 
 	/* A targeted tbi() needs a thread of MM to be current.  */
-- 
2.53.0

