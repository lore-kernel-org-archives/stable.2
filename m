Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434107;
	b=UdhtPhz390JwJBCAJ9X+EQpVkRs/ky3JHPHfaU3LP79TVrKwXsw5yUW4SNmqqMsOMYAC
	 tF7om2YoeTxV0mBTmaOzGHSbdMTMCfVG+GJITrSY/SqgIeV8eEuG5liDlr8n8n1BS0DaD
	 3uk97dzSvqafGi4QyQ2h0qvoT5loR9GEErGheWhmUqyfQQANRtFTck/yts+/+IcEJtd1u
	 8+llxJNgQDdC9fqS3/q+VEITJ5cY0SqBiboDCNxRVKW+XT6+GVhAqRjRjkR+WYYiq0V4C
	 3Qtt1jHbvspe+0LTm0NiokGrJgxxyKQAdcXbkgfmrL2t8e407u0W+tUu8RRO5hBstkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434107;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zF9oubV0Jz/J6ZKNGy23up8DmkWa0Io4zaM5l+k/zvI=;
	b=I1oeoKa294JuHBwgeFWVG9EnKKl8boB6YykEs6+iz7xVo68u6mPJ3fD77/TZcNwGXs7c
	 WpaWnq5LvhuikPo5qKJ7vt1EeAPA43ziJMFafLzTlz8I7cXE0DkkBPjdP7v1Yi7LsywGO
	 IjUMJDj1ZD6lPsPurQZX5NWFg+VFzV468KSTcxHWMeiZRHQjbLL+PTT+hyLge0oaxuQ0V
	 7iPjG8NrL0DWWlN3ifkwGN7HgiqwOHyMZyOc0iUM1/r7sjOBqLBo+/u7coZwYdPBtFmVc
	 SOuvhJgs1jZ2uJ/iMOmanGuyI2GOXWjtcXTIE2MSO1MpzcxCV38pXUOrbHZyoobsLwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFRo9d+0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C160A2637;
	Wed, 11 Nov 2026 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFRo9d+0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BF61F00A11;
	Wed, 11 Nov 2026 21:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434106;
	bh=zF9oubV0Jz/J6ZKNGy23up8DmkWa0Io4zaM5l+k/zvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hFRo9d+0qGSj9Qj5KGuhFp/5/yxDwVgiwew7zeF1kOBU+rHwR6u78AWruoszIPTQ5
	 j9ijTyp+uL7aBku4UBARF4yJVcK9ciVYisHcMgn6oEJVMdLBQFNVTeaOkeiUJNyqfQ
	 g4mamFn3Sf417ik+Mkq9r1u4hmsw1TgX+kvaRXBYPAD+LlfBYdN7BCHleg4bZVy3Fb
	 NMiRP/CV2AooyaDMuk4Mvtlpf+QvgOa49ef6cIlwjh6531eLxRirY8JuJ1ps/W6KTL
	 QLF4Ho7Rmu+FqRU8sGWdc6AUn6hrh4EmOlqqttF//qjHFDCXvBeZSwk8Hu/xYOIbrW
	 tLRSPAEGTB2FA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Paul Cercueil <paul@crapouillou.net>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Alex Smith <alex@alex-smith.me.uk>,
	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
	linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/10] dmaengine: jz4780: Fix descriptor cleanup on hwdesc setup failure
Date: Wed, 11 Nov 2026 21:52:47 +0000
Message-ID: <20261111215349.1983909-10-lee@kernel.org>
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

When jz4780_dma_setup_hwdesc() fails in jz4780_dma_prep_slave_sg() or
jz4780_dma_prep_dma_cyclic(), the error paths pass &jzchan->desc->vdesc
to jz4780_dma_desc_free() instead of the newly allocated &desc->vdesc.
This leaks the newly allocated descriptor and either dereferences NULL
when jzchan->desc is NULL or frees the currently active descriptor while
it is still in flight.  Furthermore, jz4780_dma_desc_free() derives
jzchan from vdesc->tx.chan, which is not yet initialised before
vchan_tx_prep() is called.

Initialise desc->vdesc.tx.chan in jz4780_dma_desc_alloc() and pass
&desc->vdesc to jz4780_dma_desc_free() in the preparation error paths.

Fixes: d894fc6046fe ("dmaengine: jz4780: add driver for the Ingenic JZ4780 DMA controller")
Closes: https://sashiko.dev/#/bug/linux-b39121ef-5ffb-401a-9d04-0afccd467bde
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/dma/dma-jz4780.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index ac2094e65ecf..c3974c825ba7 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -248,6 +248,7 @@ jz4780_dma_desc_alloc(struct jz4780_dma_chan *jzchan, unsigned int count,
 		return NULL;
 	}
 
+	desc->vdesc.tx.chan = &jzchan->vchan.chan;
 	desc->count = count;
 	desc->type = type;
 
@@ -379,7 +380,7 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_slave_sg(
 					      sg_dma_len(&sgl[i]),
 					      direction);
 		if (err < 0) {
-			jz4780_dma_desc_free(&jzchan->desc->vdesc);
+			jz4780_dma_desc_free(&desc->vdesc);
 			return NULL;
 		}
 
@@ -426,7 +427,7 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_dma_cyclic(
 		err = jz4780_dma_setup_hwdesc(jzchan, &desc->desc[i], buf_addr,
 					      period_len, direction);
 		if (err < 0) {
-			jz4780_dma_desc_free(&jzchan->desc->vdesc);
+			jz4780_dma_desc_free(&desc->vdesc);
 			return NULL;
 		}
 
-- 
2.56.0.567.gdb80ae8cd5-goog

