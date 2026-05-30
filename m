Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836B3451A6;
	Sat, 30 May 2026 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173942; cv=none; b=DxMxdtRvE+X9TlgCTVTXzI2mA0/BGSySvzDWtjqjvvwcN5+1zCIatJSCoT75M7tcv3oCbzT640bCoHQEkEyPCJDNofzfvUrJmnMb+ATjWubopB22Qgaj6SgfXIiakrRsXlqQSX+TlD1PUUxRLTme+3PYt2+R/BhUTus4EwpTt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173942; c=relaxed/simple;
	bh=T6E0jSicr1UGCksvCjqzw/G3xzl+VX4dTjLHR0fz7N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEdpiYhSDuXTpzoCswvscRe627Wd+Xm/XqJYxSgvIJextJI7ToUtasTCPK+kXuRAWJfx4w0Tf4YPG7rZZUetdytHrUl9iOc2f+QbmeZbW7sURMVeeC+xG5+vIzHmeaX1T482nOZDW130yVfC2FZUcFyeQwKsuzqLfkpYSUH7m+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0a9960J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0a9960J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1A51F00899;
	Sat, 30 May 2026 20:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173941;
	bh=vTvTohLs8KGq8goqLX/0Zg7ELoFsdnFFA2WgJSQgHmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V0a9960JEmNR1E2hCrl2h8EjjQ2cExwFbmEZhMpKtcy1kutTYeCevDI+Xfu0qTpMj
	 EK/R/FI7/nWtCq4MXuvuzq09poC2qI+Y5+43u7mlsEpECU3PIKKN3Y6Mjr7I7tD8FG
	 vx7ny/bYEhsg2Rq9A0fSE6a/cutbOGz83LZE6qr5gcxX+b28t0kn2F61guSvG3FbAj
	 wmGrR3NAG9k37ZIuLqDZ/e3oFi576ZUqTAlFDPaOUxfksQC3Swx8K3RRV/GB+Rt7gy
	 okdT/IPyLOxvoH2yMAnyWlaapthtFTq49grCkauN3P/4+YURVWtxS3d5mXVdzfqxkz
	 zlQKkqS5exUuQ==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Junrui Luo <moonafterrain@outlook.com>,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 2/4] misc: fastrpc: fix DMA address corruption due to find_vma misuse
Date: Sat, 30 May 2026 21:45:26 +0100
Message-ID: <20260530204528.116920-3-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530204528.116920-1-srini@kernel.org>
References: <20260530204528.116920-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junrui Luo <moonafterrain@outlook.com>

fastrpc_get_args() uses find_vma() to look up the VMA for a user-provided
pointer and compute a DMA address offset. When the address falls in a gap
before the returned VMA, (ptr & PAGE_MASK) - vma->vm_start underflows,
corrupting the DMA address sent to the DSP.

Replace find_vma() with vma_lookup(), which returns NULL when the address
is not contained within any VMA.

Cc: stable@vger.kernel.org
Fixes: 80f3afd72bd4 ("misc: fastrpc: consider address offset before sending to DSP")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 48f8262af539..cca7489605c5 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1090,7 +1090,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			pages[i].addr = ctx->maps[i]->dma_addr;
 
 			mmap_read_lock(current->mm);
-			vma = find_vma(current->mm, ctx->args[i].ptr);
+			vma = vma_lookup(current->mm, ctx->args[i].ptr);
 			if (vma)
 				pages[i].addr += (ctx->args[i].ptr & PAGE_MASK) -
 						 vma->vm_start;
-- 
2.53.0

