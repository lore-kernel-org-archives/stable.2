Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434063;
	b=efwrTfcUqe3RmRMmdU3u2emCROBghsW6QtUtqQ8ogGLQlwv4McpgNW9FcFYbH9zp6Zrj
	 pJgZmIkTW7ku/GuSqdDibE9MJNvkEi2IUp2YuLrkBc1Xy/7XxrMD8ZyMAuG4lghrL0nHd
	 oUmYo5ehp7z1SklS0FIiHa1Lymg4DgWH+1ICSOSPrcrnALnjf+97OOvm5afIJiSSE+3FX
	 xCA+mro/olTSEBl04iKBVxAmLQRTapHYRINHQp4xuj65jqrbdwHHawtH/D/qLLE3BVVfu
	 PGyViEB2FmLdZ2KBNDYAaDn1RxcBK+hp2XEBgYUtddv3zrEuPaDVLPw7knQCm8cazfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434063;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ddmwTTE4OrnrhabR1xw8Jv7Wv16fLWDKLghb2wkDmiM=;
	b=WKgdyVfWg9/DXz6YvlYgB/0is876ja2GS6v8FdGod7Sd3o6WQ0z5qIhAyrVpcZiUVVsh
	 G2gvl2JIPa25/hDGD2J94YaFnFi4FH/ItHElqZoeTwMR76Ivy1ZXfyXZiHAsIDtl/ErLz
	 bbKEF4h6VHI/e9QAFKUcbwszYCYOx5OFvWVHpbOkPpG+p0rRtemjuaVDR+tcNXbAROVX9
	 2W/DKVIqKkNL+sHzU8xq6HJQKv43nhR8gSHMqRkXwV+U+z3Ti70+EMtCUrdd+M0P8glx3
	 WnVvE9il+psIhF4jtAGyLxlQBCzJKan0FNUsFKEtNVdmLgZT1bartJR5jzzL1w14IQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTlG7oHo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78B606A332;
	Wed, 11 Nov 2026 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTlG7oHo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA87E1F00ACC;
	Wed, 11 Nov 2026 21:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434063;
	bh=ddmwTTE4OrnrhabR1xw8Jv7Wv16fLWDKLghb2wkDmiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YTlG7oHoXHKdOz+rtjvkx5K6EqiBq6f+zu8H6ytM0ieezyYwzEg504QkpCWzigi1+
	 dT2vl+rMbGEMWIMAO+LcOSxfra4Bemf1L8LpeIfX3NBnLAJm4DtdJKgd+8SLqBFNcW
	 JjSE16zMoYqlv/KU9XN3GNaEv+z4DCnBlB2LxfIcrIPYjXC9zndvpJdXZYB+UqTWX+
	 MMnqn/pqWR1s+/cUkDqQgUtegR93i0CUg+HzQ/+13cML8RO0/H6+AgFI36KOSdLddC
	 0RLpgQiSwzGTwiY0eWuXO5T3MJF9gvBHcGWp2XGOgoZBvpnPjjSQa7/xXIGfuwqN/5
	 wxpbV/ge17hKA==
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
Subject: [PATCH 03/10] dmaengine: ptdma: Unmap descriptor in pt_do_cleanup()
Date: Wed, 11 Nov 2026 21:52:41 +0000
Message-ID: <20261111215349.1983909-4-lee@kernel.org>
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
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 22e7b3ae26a1..405d3d3b7f8a 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -91,6 +91,7 @@ static void pt_do_cleanup(struct virt_dma_desc *vd)
 	struct pt_dma_desc *desc = to_pt_desc(vd);
 	struct pt_device *pt = desc->pt;
 
+	dma_descriptor_unmap(&vd->tx);
 	kmem_cache_free(pt->dma_desc_cache, desc);
 }
 
-- 
2.56.0.567.gdb80ae8cd5-goog

