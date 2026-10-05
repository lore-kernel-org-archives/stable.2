Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B047CC8E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791198691; cv=none; b=NdEr2R6THvyc9nrE/J8lr+8Uk3fn71IqzpTD/laOnsljGL5owHxLMTf5QcTxOOboCgsZY1FsVHpg0cWet7eqSxpjCnQgMA9iVr3SVIaXu/LVejr7N+Py0Bs9pNolWkBxuzoqbCfKuzungZuU8mXDC+RQrEXHdVzVvGuNeqY5L7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791198691; c=relaxed/simple;
	bh=yk/Cc2UXGQJHNPGD+r0qn3N86ApXOo+zkdin0WsYYT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqfNiO6Wa1V4A0kfsYQoiXhofMJLWTsxp15ErwiuYIrrA7FeiufOJ/w0pOIS7CGO5l+kFNwmB9SLxgD9bIOGH6R4RYU7KKtgVMPpWN5c2+mdGxY3+UXXYhOVirb9YwDlTfQjvBd+JfiKLcVY95ROL3W8RDrSeW2/oIuc4PoO/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSBeUUdb; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSBeUUdb"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b6f8b8113so527435eec.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791198687; x=1791803487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YmAdUzfHpXWCcsCDGufdmZ0OVPyw9FksvaDdRfTvduQ=;
        b=aSBeUUdbKfOhbNSAVl/NFNL6GVuMxPfEJUNG4ajeYLYIIiLLmGwCS4TdQMTJ5THbX1
         v+ur9qD5pT6kh1AUqK+v4SagSu+1MmLIEpzJRxDx4C3s/twGP8MP/RV2kNY31S1NZ1UV
         BBGSCq+Ll3+WMQ3hiP4hOHaXleZ6OH+F/Vnmvvxp6IMsafsMCTsDBquIZK8B2m60ApKV
         1Cp7e41+1B3fwM5y6qGL+lcMXz1bKRs/fRU+VwJnMI9a7OgI6Lh+/ElPnwivZznWITtJ
         raL5bIKzvwvRNLes1j7aMlSWIZTdKNh5+Fl5xwXD2gSWPS2jViSElL4lvarsqvtAzO8a
         iIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791198687; x=1791803487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YmAdUzfHpXWCcsCDGufdmZ0OVPyw9FksvaDdRfTvduQ=;
        b=KSBaqbDpQdQuYMaHegRjRh0VdU4bKqcqaHlr7mJlL0WvROs3SomRxQ0zXANb8YLS7b
         n05MZfI6w/rk8E6AKDZW+eblyNOIsVy6WmheAU5dZEfeN/EB3zGbovHVD8Z3lCULqKxA
         O1HCk6TRk3nP3LUmgLd3vC7hV+1N2EncIyQLQiUUqhwOkH+dFUadrZG56uCEvmGKObon
         iyby/QjfBmGKa2jFg+kcacbx/uxDZJd4j3VCM5sAiQzHuHNDryMv0VPILLwetIYybg7B
         7QMc/3k5aajXY0kAVsR72c9bSGDrwcdKCOBb/PURyk+R1W/ECDoglF+tyZ/vZdODMc8x
         mOlA==
X-Gm-Message-State: AFq9FYLDd1ONvpCRZCFzWmGFb6kAarT9zB6KJXgPW5xdNdUJuNjI4eFs
	GUxf0eTdR3OMN0GudUdfeZcC6Ke8RxbodrC+/p6RExIblvfg9IrXtXM3kbpsYA==
X-Gm-Gg: AYBFou2oWt6SE2WCU9TY/6p0XWxmOrUyf6gHnUbyZY2GuM7IY9Zexe16JVpVJkiERLw
	dt8FVBvTcbVeBeRq3UxNN7TWllJBC+VcSzKo0bL5LuUmGQTsCn7R4+GxilvVGziqXaMJHF3Od5S
	V3ksnP0/FxY3C98BtoWgBmVkXd92u/QUcm39Ka0K3OPpFF3C/Qw9Fr6koYWR9YrL//GTLNMANQv
	Zi36LHYdgQI7xKa+mSujgO4OOcXSXMavhhD/p/KqT1bB2JJtgm1wWU7xW2fDAtotFjoa66lautD
	okhVchzxpukY8K3mE89aEzESh8GkRR2duYcJxPWdJ97nhXG+yfbxlSO755rawkeegcAR6Ru97qb
	KHTsrZfsqF+Kca/e1eFjl5naAZB0kBhqZaQmD8i4Q1Dfcd+QYuu5T3dmnKYkISzQPWhiPdFoNnZ
	fgvnjS0ofJ2jnViQ6dgsCo9ua3a8XyRwG7s4MIDzh+zEPyoCAhqqEf+GKpIgVGDY3BckMQjT2UD
	EC+jR4=
X-Received: by 2002:a05:7300:7fa6:b0:347:a3d9:dfa3 with SMTP id 5a478bee46e88-34f150df43bmr18332085eec.7.1791198686387;
        Mon, 05 Oct 2026 04:11:26 -0700 (PDT)
Received: from JMD.localdomain ([112.133.220.139])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127021d1esm14169686eec.4.2026.10.05.04.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 04:11:26 -0700 (PDT)
From: Atul Akella <atul.akella@gmail.com>
To: atul.akella@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] remoteproc: mtk_scp: Fix bounds check in mt8183_scp_da_to_va()
Date: Mon,  5 Oct 2026 11:10:54 +0000
Message-ID: <2e32034b79ea7cad99b7ea9edfb8b2ad64f5096b.1791198233.git.atul.akella@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791198233.git.atul.akella@gmail.com>
References: <cover.1791198233.git.atul.akella@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt8183_scp_da_to_va() translates a device address to a pointer into
SCP SRAM or DRAM. Its bounds check is wrong in two ways:

- offset is an int but is assigned from a u64. For the DRAM window,
  da = dma_addr + 0x100000010 is truncated to offset 0x10 and passes
  the check. There is also no da >= dma_addr check, so a da below
  dma_addr wraps in the u64 subtraction and can truncate to a small
  positive offset.

- (offset + len) is computed in size_t and wraps for a large len.
  With offset = 0x100 and len = (size_t)-0x80, the sum is 0x80 and
  the check passes.

da and len come from the firmware's ELF program headers
(p_paddr/p_memsz) via rproc_da_to_va(), and the returned pointer is
then written to by the ELF loader, so a malformed firmware image can
make the loader write outside the intended region.

Use a u64 offset, check da >= dma_addr before subtracting, and
compare len against the remaining window size instead of adding it
to offset.

Fixes: 63c13d61eafe ("remoteproc/mediatek: add SCP support for mt8183")
Cc: stable@vger.kernel.org
Signed-off-by: Atul Akella <atul.akella@gmail.com>
---
 drivers/remoteproc/mtk_scp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 9751acc2bf83..d18ae676260a 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -754,17 +754,19 @@ static int scp_start(struct rproc *rproc)
 
 static void *mt8183_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
 {
-	int offset;
+	u64 offset;
 	const struct mtk_scp_sizes_data *scp_sizes;
 
 	scp_sizes = scp->data->scp_sizes;
 	if (da < scp->sram_size) {
 		offset = da;
-		if (offset >= 0 && (offset + len) <= scp->sram_size)
+		if (len <= scp->sram_size - offset)
 			return (void __force *)scp->sram_base + offset;
 	} else if (scp_sizes->max_dram_size) {
 		offset = da - scp->dma_addr;
-		if (offset >= 0 && (offset + len) <= scp_sizes->max_dram_size)
+		if (da >= scp->dma_addr &&
+		    offset <= scp_sizes->max_dram_size &&
+		    len <= scp_sizes->max_dram_size - offset)
 			return scp->cpu_addr + offset;
 	}
 
-- 
2.43.0

