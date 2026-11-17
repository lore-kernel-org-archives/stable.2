Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933526;
	b=UKcoNn9VMgCZGYctW4gd/E8224oOUfuH4+wXU4bUfsgs2g5mqzioI7mAM+6UoBt6fxyp
	 On0PmyYgpG2pdhoOJJcSA8azsEtF0AeTaP2ogknNc2nCRaymmJI1JBma/VQhqZYWEoFFF
	 1MqP4ngx5xXcxvsImKnBfIcc7ugCYZ/EwAgo2dOOZt78KUryXAAWNaDArhs/G25WmSult
	 zPaR35oaQTfrKCpqrfQWzUSMtWbdiPAI6KiNZ0Sbg7PTPkkny8aj4UbpBspQ9T/R6Zl5H
	 hM71U471ExolzOFS+O+xz3K68cv7arvKT6NX6fisRYEtd8LyM/7FGfdOIDV+Pe59SIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933526;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NzPxsBiUlx4ac3WdKqYIo2gXzgvnHQkMHiAeNTlWLiA=;
	b=IERv/hE5cOVqB8tPFRadocNL5ZZIn3kfaJcmXeTu3KbUE5x10P0iolOkJqXqEO89zGSU
	 w4b72TGf4ltRKz0o97PwvwjKb5XI4xvy2I8To5j3UQRePj7CCJFSVY0xmB8z5FvO4Iefb
	 kTM/fOQBAGZazPj8EMG71+TOpd8VgkFifgJ4s/634yKFAbLB0XosRi9pUz0bJ118np4x0
	 dSRqu+SGEJ1IjOSgu6LpdGGNkWMBUjrvN1iAw/24OUZFm7a7jNPi1h6nb1qoPemwvfuhJ
	 3qpYZebAwiES1GcHyWLPZM25oejLIiuggGmpDOahgafChcOoWGF38FeiGwZeXefzk5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpDndhD3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E13606A33B;
	Tue, 17 Nov 2026 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpDndhD3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDC41F000C6;
	Tue, 17 Nov 2026 16:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794933526;
	bh=NzPxsBiUlx4ac3WdKqYIo2gXzgvnHQkMHiAeNTlWLiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bpDndhD3ufSxri6eR7tDZbqKLPEMzqMScFMeHvurn6lI5AlpgvlKvJr0mJJtII9to
	 4g3YqqFrxmmB1sjJ0LxtStZYXwecoUQb1d7mo6C+yVfmoUGkE4Rq9TdCaLGu/4klDP
	 1LGMX4zmkX9AFw45d6doeMDpGNrrly802uxGp124jsFJMXYjXYBArqFuWRk4Ci3qKp
	 +e8Q1iaqoTYfiMDu0AhFrRcUUsxP6h5tIBTzJu+ZiRaGoRcT+jOcY/s38vJNCbeI2W
	 1yYWUS8gX7UVVqadNYWA+yedIPoGIG67QfceBR7PyCDCmNAJ7VXxFsbp2N5fFIEru2
	 KdfZR68Mm07zg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Gary R Hook <gary.hook@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 04/11] dmaengine: ptdma: Unmap descriptor in pt_do_cleanup()
Date: Tue, 17 Nov 2026 16:37:05 +0000
Message-ID: <20261117163809.622249-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261117163809.622249-1-lee@kernel.org>
References: <20261117163809.622249-1-lee@kernel.org>
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

When descriptors are freed on abort via vchan_dma_desc_free_list(),
pt_do_cleanup() frees the descriptor without calling
dma_descriptor_unmap(), leaking any attached dmaengine_unmap_data and
DMA mappings.

Call dma_descriptor_unmap(&vd->tx) in pt_do_cleanup() before freeing the
descriptor.

Fixes: b0b4a6b10577 ("dmaengine: ptdma: register PTDMA controller as a DMA resource")
Closes: https://sashiko.dev/#/bug/linux-58b8113b-167a-4398-9be2-c2f3cbf73358
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: No changes

 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 628c49ce5de9..a0a1c7ec2ae5 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -91,6 +91,7 @@ static void pt_do_cleanup(struct virt_dma_desc *vd)
 	struct pt_dma_desc *desc = to_pt_desc(vd);
 	struct pt_device *pt = desc->pt;
 
+	dma_descriptor_unmap(&vd->tx);
 	kmem_cache_free(pt->dma_desc_cache, desc);
 }
 
-- 
2.56.0.679.gc527c65306-goog

