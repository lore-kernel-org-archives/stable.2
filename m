Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9A43E483;
	Tue,  4 Aug 2026 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833455; cv=none; b=Pd0QUQPIsd4vFI82g/8v3Y4IKsNmMmapRl8y+3cKijLV1u5wCwHuJL3N7GgCyZdCg9zc2BqT9G7xUGIw3cSyTddNIGHHDhPiXVLEwCBDwla3JQbNchodADrOoXkFra3Zm0kG+kkNLtt7vs7j7qs/U91xkgNQFHfuS6yUGzGZM4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833455; c=relaxed/simple;
	bh=ouoOtFQsDph48bmUIg1nnMKtB6spdEtljACvUOhmbI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QcAdFndA/JJbPLuE994dtZeXhY/VW1SpxqqRYBiVOopf311fnsqAcFW9IG1is/x0aSmIC3OYwURGYuMKQJxLuOVEWuDAdxdqjqURVe7oQ8d8woZLjsboyBhSYB0YyOXatfNzq+ks8f/PhEPjqanHWijdWPdaaljEV+T8vsVwNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gguxmrpl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gguxmrpl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1F8AC2BCFB;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785833454;
	bh=ouoOtFQsDph48bmUIg1nnMKtB6spdEtljACvUOhmbI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gguxmrplHdHMu6GDamNp9kq6vmj2XLV+qreDsyqBBjorxNEEJeHDt6IF3DxgrQ1B2
	 VXEDqWcHu5yc1KWKn/ymtIlS81CVNqHsbbBeCFLaPEOfJXlvZoup7endt3l634HvxU
	 Bmf83urhBrHpq8A+Ls3wrniDsTC8xWDqIihCfkXSs6n8PEyQ5OFeTIHuOk7R4LC5Jb
	 YnmqOgIhT764/v/D15tstznlIOtmcAMaHz4s86mVGT3/1QUnnFL52QjVy6rFIjWtdC
	 8X8n7dNhgyd0sf0NmwqjQcBCrhTpDnXCrCagKSlYfEtwbksCFxh219MhouQ0ky+8dv
	 2fulpVgekhrpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A6FC55172;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 04 Aug 2026 16:50:39 +0800
Subject: [PATCH v2 2/5] powerpc/spufs: don't leak kernel stack via spu_run
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-fixes-v2-2-5bfd827297f9@outlook.com>
References: <20260804-fixes-v2-0-5bfd827297f9@outlook.com>
In-Reply-To: <20260804-fixes-v2-0-5bfd827297f9@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@ozlabs.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=/mYJIr4Rrbt5tK8GuImhcqAYaBw3DdGgKByxedyucEU=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMLlb76tSgqwj18YnOrQtpRllZ+6sNpx9hVr2ztMT
 858m3mM+UhHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATERHieF/mvPSy7E9malK
 PlmZPR+Wzz/ROOVmBp/wilU6jdlqLCuUGBnmLxSLLDwzZcfSuzcrt6xU2XNXM03EWid2SpTa7Hm
 F8pN5AWe+SRo=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

do_spu_run() hands the address of an uninitialized local to
spufs_run_spu() and then copies it out unconditionally:

	u32 npc, status;
	...
	ret = spufs_run_spu(i->i_ctx, &npc, &status);
	...
	if (ustatus && put_user(status, ustatus))
		ret = -EFAULT;

spufs_run_spu() writes through that pointer at exactly one place, the
"out:" label, and two of its exits never reach it: the interruptible
acquisition of ctx->run_mutex returns -ERESTARTSYS directly, and a
failed spu_acquire() jumps to "out_unlock", which sits just after the
assignment.

Initialize status to 0, which is what userspace would have observed had
the assignment been reached anyway: spufs_run_spu() resets
ctx->event_return to 0 on entry, and 0 is the "no events pending" value
for this word.

Fixes: 67207b9664a8 ("[PATCH] spufs: The SPU file system, base")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/syscalls.c b/arch/powerpc/platforms/cell/spufs/syscalls.c
index ea4ba1b6ce6a..549fcfbbc140 100644
--- a/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ b/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -37,7 +37,7 @@ static long do_spu_run(struct file *filp,
 {
 	long ret;
 	struct spufs_inode_info *i;
-	u32 npc, status;
+	u32 npc, status = 0;
 
 	ret = -EFAULT;
 	if (get_user(npc, unpc))

-- 
2.51.2


