Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112805;
	b=28EGGmQEdBCRDnDvV5JTqvvKPIittSVSoL6qeHzEz2XUhx8hgIt6MbOWtXmKOlAYp234
	 dUM7n+IIecHt2P7pwQAVDcMVieiptZUILj/AdUwWuWfA58q5Apqrl9xlY/3AmxFGRA7x5
	 aReyzK46rYIuKJtEH8RMaZ7BssvJ+iml6um8pPLEp1EOxLjan8isAGQ8cAnHjU2jH/3Sq
	 sdv4MFiWIPFO+hRRZa0CY6cwFfIY52x2s6aiKGLLAgOizlwP7bG1SIhSj9Z9avYSP9qPc
	 65DOQsN9O7EcrB/4O2jBSeIHlWH6g4zDzWf2DQulpWJbweeVKnPczxy+YS6OaTs8y1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MpIBWf7/b2ks94p+dnClhdfP917IQaGrC6d3ELQJeOU=;
	b=gmCEY83N7BXrmlPlxZ55FfA6Hdy6gEQOXk04rkqMoJ6N3oiemXDugJneR/CKmUlXAr/h
	 d3DdLihCZ/WrUDjadu3+t9i6YI7N/URmwtK7S7m+pCDMiViwhRZFFRuaFsVpWtRFuTS2T
	 ycSuCehsS2xuM1zeD7Y3BzgHjTlTopREPZIMWuvyLgd37EscLEYUtga+u/LO7foP4sokS
	 Y4r9Yx48Eu0jkXvQ+U12V11HWW1R2xQA076m214aAFd1d3L/RNt2iRlnBLMrpOXEUh9SR
	 wlPxEC8La3/EOcWQLNOr2aPJRTPUHvr8sR4kZnP8JamU5Lj1w0CWpb9g4sO7rz4a0+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PL0uNvOF;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A9606A31E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 499A9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PL0uNvOF
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so7718a12.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793112804; x=1793717604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MpIBWf7/b2ks94p+dnClhdfP917IQaGrC6d3ELQJeOU=;
        b=PL0uNvOF6KtmytVx/LyM6gB7gFM05V7MDTXiIU/jNVGVrb8h0a4YBmqrVAgfzJYkM/
         XIIlEJw0YrfmwpzCxmxqRPuPBrSO/A+mN3FRztpVogzN5DyzY3Sq8CWDatzUvbLI2rzi
         PEoaPyAY2SHhTTr0iu4XDHOxPytwusNn66/D7hbTLGkaFvARqeP3wSVvxPrg+czWBFbi
         RvThogGY40pn9hSgBkEgfoaZM+UFVgqyOpQbxAV+BfMI+qMCM7/3D1R4tD+tval28tEb
         ebUXb/xw8hrtyeGU568eNfHW+R/Qs73nxMAMBtE4IOYI4JVt4Tzz/h41aFppjGK698YZ
         ta7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112804; x=1793717604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MpIBWf7/b2ks94p+dnClhdfP917IQaGrC6d3ELQJeOU=;
        b=HJ56si1+MzQ1eIXamxdEw0+DH3RRnm41TrbdWKdRFSb061YAD+QMmbDBhpD/QY0+VK
         CWZGuxSVHbXWQGv7aITHVtHf6x/CYKoEcGBZkcuvpDerrS+PSq8M4A7uXj7A1hPoYQm9
         AzxfX7zH0+hMnV5rAXgaMZO5vqhl2g3JURxq2qBqxl5QuydcXqDKwvYRUkAuKTL3wWTW
         G6SPyOnnU6lzySy/TVk0rhXNAnSB1AlhUJTFT+olLHpYapBy7JC841pmtVX3eIDBFXWs
         C3rM1uwjHNkmSSoRyWb3TEtSmvCS7DkNESeluYr3zeaM2H+s4j32wDYAVH+YjG0xTpsk
         Fevw==
X-Forwarded-Encrypted: i=1; AKwUvBylqWPGOMZTmu0bslStGGbZnUO3+2uyAd4Hi48lzwX75Y3D4gLuRfyyaitjQCPGWwzXTeYJcQo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDFbTr0W8JjKbhABPG2TjN/odQ1FQ8xqaY6AarjRnATLEzpv2C
	JaHhwscZxDj2LEdE8ERZV/vLus/Jkfz2taHaKHGAQpsaOKzFUSPObeme
X-Gm-Gg: AYBFou2zsLqcGC1M9DTWJYqBnAcae4T//cP1mCUAJSVqp32YJmGP1rYSeCPFZmdgtRF
	T/gMkhsMgLFZqalOAIO2TFhj7Tegy7CW1q0nk7snByMdKRClsvs3NmJ3CCQTIlGcd7fZbgkz6l2
	Acv1ajeyo7pWYkma97m5rRlkv1hTTF1bCuWvINlBUZMN3DGwRchRMGmeWCcRoU15UUjMO3KzMHL
	XpMOovvBPn6L3m9R+lmArHu9oEOt9Np4ph3y7ZhQmAfrTddLZ2hEbHDYGAzhhl9vB1KYIjvrl2+
	WKl7fzQ7Yar9tnL2mL5qYwFFnPeJi09xmXjkTXJuPSvqBHbMRqMGD0C9yvQzreaYnoE2OUeeopE
	sJEen/dlpbx5C4qN8ethuKZ7j3lxm8PqHOui2e3QuCsoOHlz1Lw9FB6sGDoOGIzw/0Y8Hqd7fj0
	Cc/KTCup/LUt+WmB2jhgjqQX3MyBvXXRXtt8ORdAGJDZo64ZBZQPYXGuITrFY6CyGq8+WrmzsH8
	iOH2eDKWDnvdISaRl4llNgGdYzqukLsAfznfG0g2NOu5awxEcQfHw==
X-Received: by 2002:a17:90a:b896:b0:3ab:b39f:41c8 with SMTP id 98e67ed59e1d1-3adead4dce8mr5470253a91.46.1793112804486;
        Tue, 27 Oct 2026 07:53:24 -0700 (PDT)
Received: from lgs.. ([101.76.249.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40614d7dsm4093349a91.3.2026.10.27.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:53:23 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: exynos4-is: fix DMA memory double free
Date: Tue, 27 Oct 2026 22:53:13 +0800
Message-ID: <20261027145313.136305-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

fimc_is_alloc_cpu_memory() frees the coherent DMA buffer when its
DMA address does not satisfy the firmware alignment requirement,
but leaves is->memory.vaddr non-NULL.

Because firmware loading is asynchronous, this error path may run
after probe has returned successfully. A later remove can then
attempt to free the same DMA allocation again.

Set is->memory.vaddr to NULL after freeing the buffer so the
existing NULL check in fimc_is_free_cpu_memory() skips the
already-freed allocation.

This issue was found by our static analysis tool under development.

Fixes: db47622c13ae ("media: platform: exynos4-is: remove all references to physical addresses")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/platform/samsung/exynos4-is/fimc-is.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is.c b/drivers/media/platform/samsung/exynos4-is/fimc-is.c
index b7d9bfedd590..9fdc352abfe4 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-is.c
@@ -346,6 +346,7 @@ static int fimc_is_alloc_cpu_memory(struct fimc_is *is)
 			(u32)is->memory.addr);
 		dma_free_coherent(dev, is->memory.size, is->memory.vaddr,
 				  is->memory.addr);
+		is->memory.vaddr = NULL;
 		return -EIO;
 	}
 
-- 
2.43.0

