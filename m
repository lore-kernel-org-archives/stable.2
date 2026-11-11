Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434070;
	b=1XQiYdxgjACmV4dVG5/fdo1gdR4KqGolPjGVOU2VL/nfpmm0bwdROBNDXGHHdjoOFsRd
	 VRs3lVzjR0SZKj0OUcq5OPeFdyVYiku974zw0qZbhxj0KRNUd0U/6GXf+iiU2wBRO9iv6
	 Z2jx4rx8XdBCi3NXnb6MItZF88E0KFZV36XUoYXWoanhxG9JT3de1X0AIZwQoI3QVAk9p
	 XC94NQBsS4XUYGYRtl592CdHYz4Vu2/SaSVtp1y9RVrXczMeVCeCb0x2QnJllAOlWBiM8
	 Kjjt+ysTzAzWRNRJ2dgRpOyUKGXnTNKmYJ94qUSXj062uVy1qXgeTEdu6jpygZ3B0Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434070;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qbbVSSZ18QduMW9a7kRjl8YW+ZLWyejC/m6DNHJKzrY=;
	b=MkGLVR8J1F63/xLl9EGdWLNNsAQNPYHDewxIOEvkyDa0ztA/oxV68U53w+V+GbM7Ucfh
	 jmFKDQPQNxz9A0aXyn4gF0gW4BxkSLkztzJTmVAqgJqllJAXyiv75lRPJQGb9mNWDTv6L
	 eiaJm09bTadlJyild5v9U3H0JGYQOV2g2FA5e6gGL8gT/MLFB/iUppEbrGXZD7ExzFoGl
	 v0eZIFlxb8b1aUBjvMEc6vhpzBbPBAHZtxPI8REcF4yFYBqzSZjhYBBD2yWcFLLsoSmXN
	 f48pLIaGe42Qr30ACo00pJh3lVOxaoM4shnCMSzcCitL72QwZfeozHERggEfiJHaClg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuJcArqt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4F606A336;
	Wed, 11 Nov 2026 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuJcArqt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7F91F00A05;
	Wed, 11 Nov 2026 21:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434069;
	bh=qbbVSSZ18QduMW9a7kRjl8YW+ZLWyejC/m6DNHJKzrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GuJcArqtRWgpcW3/iiNc0Myd06Ci+MUICC96sK64lkdyUs/ATY/M60kvgm21m3Z1C
	 rcVEdnQBmeUuIrO4YIQwQErfvoCz88lCNyKNXqEIdMTWMCpGGwEzPJEygHNVzIQB2k
	 XlA8nAd4cUPjqGk1RTDHckLBunDgmVu1CQQ5R9fZjWgQ5ym8AzP7StMpBe5o3qFiDx
	 1PTorrHv8kwH1e9W7Wg26zc3L6u3WU0pZf1+PEda2/wu9rSEsH3v4itaWMv+/Bc8bN
	 fDOySJoruvvQmwmlprIgUs2wN3NRHc9yThLO5Pw22QUuBKa+C//HFMSBX/xLactVYu
	 76fL4uqTlCqBA==
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
Subject: [PATCH 04/10] dmaengine: ptdma: Remove completed descriptor under vc.lock in pt_cmd_callback_work()
Date: Wed, 11 Nov 2026 21:52:42 +0000
Message-ID: <20261111215349.1983909-5-lee@kernel.org>
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

pt_cmd_callback_work() drops chan->vc.lock before calling
list_del(&desc->vd.node), racing with concurrent virt-dma list
operations such as pt_terminate_all().

Move list_del(&desc->vd.node) inside the chan->vc.lock critical section,
matching pt_handle_active_desc().

Fixes: 656543989457 ("dmaengine: ptdma: Utilize the AE4DMA engine's multi-queue functionality")
Closes: https://sashiko.dev/#/bug/linux-55f1563b-5563-492a-a291-1a5b772ffd42
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 405d3d3b7f8a..da50c7d15348 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -365,6 +365,7 @@ static void pt_cmd_callback_work(void *data, int err)
 
 		dma_cookie_complete(tx_desc);
 		dma_descriptor_unmap(tx_desc);
+		list_del(&desc->vd.node);
 	} else {
 		tx_desc = NULL;
 	}
@@ -373,7 +374,6 @@ static void pt_cmd_callback_work(void *data, int err)
 	if (tx_desc) {
 		dmaengine_desc_get_callback_invoke(tx_desc, NULL);
 		dma_run_dependencies(tx_desc);
-		list_del(&desc->vd.node);
 		vchan_vdesc_fini(vd);
 	}
 }
-- 
2.56.0.567.gdb80ae8cd5-goog

