Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CCD31077A
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723361; cv=none; b=hsdzdM+u5ckOCaYzgCftbk4+idl5mgCFmSG0G8Ov3T4MXrgc8KAvsYawtSx5ahuMQPxWrqK1l5taDeC9xGjR9d9KDcCI1j4aipIxLcEQsFnxaq87Qs9oPI0yaS47Sg9DFcHtwIA1Ffdo6vvjSFPfHoNeECWAssMFsExEOYINn1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723361; c=relaxed/simple;
	bh=p4EJ3pbvuYEboC+OEG3ZvlJcdBJ2tQdAYhMhrOBcx7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhArTRYAjxMIOwp8Pb7cChxuHDXgWEP36VHRoXQUbLjZ29bqWKkXWMjbYSwdhwEdryZ968mpBh7oppamI/wIkkO0zqxLgW1cbVA33M1zrmFRSkcpyNJquz+VvNLkSg2k9TAbODK5p//DlSvBhVM08qwYj7hwVFRfoBJthehnAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRWvyfHc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRWvyfHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7A41F00A3A;
	Wed, 17 Jun 2026 19:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781723360;
	bh=2gxMNGcYepSZoYCwzx+UGSRMFEev7f76dt3yhsrSBVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gRWvyfHcfmaXevZPq9eHLoWfJNsaalcwleZIgAJWtdwk7yXt2L1edC5Ojcpk9tH+v
	 xr7QTHFiPehi2byZO6cSBK48ZT3XnhglIRIqrdulL6Mp38qqEo4ctYwCmqQExHbDvi
	 VBIQZmk5BCCU5Sr9JG5+Z4HuhtuQ2WAs66g8M8HamLucQ3zXaKl4SrtfDEsPNU0hdb
	 D2m6qI43EvF8we4QQf5KobrshzW9KZMm1YMDTAcTmIqHYQfk86uucVwRdTzrOYz6AA
	 G+TrGCsxOn0PhZV0kY3yVQwjBP+V+NssTVpqH6JUj1dEM0TNdjGRlmoEb/QeRpi8HT
	 UfvRcGOVCmETw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] misc: fastrpc: fix DMA address corruption due to find_vma misuse
Date: Wed, 17 Jun 2026 15:09:17 -0400
Message-ID: <20260617190917.292166-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061542-daybreak-anemic-ed9c@gregkh>
References: <2026061542-daybreak-anemic-ed9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junrui Luo <moonafterrain@outlook.com>

[ Upstream commit 464c6ad2aa16e1e1df9d559289199356493d1e00 ]

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
Link: https://patch.msgid.link/20260530204528.116920-3-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted `vma_lookup(mm, ptr)` to `find_vma(mm, ptr)` plus a `ptr >= vma->vm_start` guard since `vma_lookup()` does not exist in 5.10 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index af8412dd590ef6..f6c0259b29a663 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -825,7 +825,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 
 			mmap_read_lock(current->mm);
 			vma = find_vma(current->mm, ctx->args[i].ptr);
-			if (vma)
+			if (vma && ctx->args[i].ptr >= vma->vm_start)
 				pages[i].addr += (ctx->args[i].ptr & PAGE_MASK) -
 						 vma->vm_start;
 			mmap_read_unlock(current->mm);
-- 
2.53.0

