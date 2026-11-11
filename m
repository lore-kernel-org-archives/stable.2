Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434056;
	b=YZsWcg4wE3/Ah2rI7S1qvyCIS1cniGCmwhB0B1LRtLcj9DRAzCp2K7mT3UgQimX95LXl
	 pm05qCiQ6fVC5yxM2uShIwim4umgQbkyN+pX7MwMqjzcP9LQ0IUH+SrCo8pQKK18KSa0s
	 hYlrcYgqc6QqmRGn5zerTG9PTa1+m2gHjpGkrv5VaD8P9A9R/mixJmW5zVESJLbS3EqXS
	 9VZDXP2Phg8/FQVuQFkl7ew1Q3+rNYdTQzVsapkQRlLEJjjJmh6YP930LJ/5igN3TBR/j
	 Z64BdCXPNoGup3ajy0C9smmLbxH2hgOd9MGhJxqGjbsVaZu40yh0pW2lHnFamJD8J4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434056;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gRm4wJ77s37ql8DcdJ9oJZ+DQFL67ZY9gWFv6emuHNU=;
	b=TZGk9+LvzpU9WUgJ0QvCr6ZB4YB4oK/MJF3jjsENqRVXrFyIdKcuBI/tKYD77SE5wnRF
	 fIqYG5PJxrxTN9sopx8Y2+S54aCUdLA7+234n0Bpb7CBird61pQMFelLUi7n5NJWTo/DS
	 fcMw99JmUt6UGrbwzH8/3j90KndpbIlGbLH61AxDIPsaFLkxO3xPF89flbAxESdCK/VqT
	 CUJueeOfGhBj6Ks955z1oXcurTMDkQWsgDa8CfxppIbc8XsMd3iG5nbsqDbQ2ZvyHKvjX
	 QPeetyEKgv6vbOB63ms+fqeYplNTJctu5R9DW5q/xknHl3cW+NiYfDqWvod3LNAVt6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zd/Anm/N";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2E60A2609;
	Wed, 11 Nov 2026 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zd/Anm/N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21771F00A0D;
	Wed, 11 Nov 2026 21:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434056;
	bh=gRm4wJ77s37ql8DcdJ9oJZ+DQFL67ZY9gWFv6emuHNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zd/Anm/NV0naNbwAevJoww8BJTbhtj+u9x7c453bbU4DVC70b84q62zAWY3vdMr/8
	 Hr/R0tpaQKjMjbXZAc1TDi7DBrPOgaJr9EWPa5jZiOtj+laUohoyucq9Z0tWA7F2sU
	 dCjWIuDhzukV1Prgo9M7rMCdMtFNHb2CTZ7egTOXIwZR6pJoTyRqpjOphEkd82RlKn
	 zMPYjqm8dFTm/HAqDJaTy7CV/vadGaRetvzqhGQiS55oYNQOPYGt1PJ3/onWensziK
	 vqSu9xNR7vNpG9NO9pL3kaTRhQYOY7KzwxQUlK7tRLi6FoDuo44ultkQA4SEEyUyJh
	 sOUm87mBrHMFA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Gary R Hook <gary.hook@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Philipp Stanner <pstanner@redhat.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/10] dmaengine: ae4dma: Unregister DMA engine in ae4_pci_remove()
Date: Wed, 11 Nov 2026 21:52:40 +0000
Message-ID: <20261111215349.1983909-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215349.1983909-1-lee@kernel.org>
References: <20261111215349.1983909-1-lee@kernel.org>
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

ae4_core_init() registers the DMA device and creates the descriptor slab
cache via pt_dmaengine_register(), but ae4_pci_remove() never calls
pt_dmaengine_unregister(), leaking the descriptor cache and leaving a
dangling DMA device registered after device removal.

Export pt_dmaengine_unregister() and call it from ae4_pci_remove().

Fixes: 98f5a4432622 ("dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register")
Closes: https://sashiko.dev/#/bug/linux-10d41112-e133-4bc5-8e53-b3e96592c70d
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/dma/amd/ae4dma/ae4dma-pci.c     | 1 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
index 2c63907db228..8712f4f65e28 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
@@ -132,6 +132,7 @@ static void ae4_pci_remove(struct pci_dev *pdev)
 {
 	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
 
+	pt_dmaengine_unregister(&ae4->pt);
 	ae4_destroy_work(ae4);
 	ae4_deinit(ae4);
 }
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 628c49ce5de9..22e7b3ae26a1 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -657,3 +657,4 @@ void pt_dmaengine_unregister(struct pt_device *pt)
 
 	kmem_cache_destroy(pt->dma_desc_cache);
 }
+EXPORT_SYMBOL_GPL(pt_dmaengine_unregister);
-- 
2.56.0.567.gdb80ae8cd5-goog

