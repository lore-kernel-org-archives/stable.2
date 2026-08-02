Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DEC3BBA05;
	Sun,  2 Aug 2026 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685914; cv=none; b=kJZhxXXLeLgY4hd+gx/rXGSzdyxJ66KX7bXLv1RCay1hjILy3voEJCIL+O//He9SIpsnMk+O0x3/M9hG2yLHh0pVVyUlYGk650qYHTMhlIDfwvHLUcETEeUF+3p6zNXMVRjoCsog1KEHoXDdj5pcX7ex87ryk9qROdMSc084gMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685914; c=relaxed/simple;
	bh=kssaiTpuWaSTBvemdKDrGWLjRwD6PJPPxprkYN1MRtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIkeNsmVCds79/8gYmgd1hgauTz+hy3AvBDZYXi5/y1Tn8MSe907xFloyjY7KpSTQKT5N5rJwAq4IF2/QKkI8bgQY7VQ4NKpNFAhY5mA7NcQen+oS1kDLAbe8z3krlUA1O+2rXuKYPFPNYvEpCK3pF2il57iLIA6+TDq1Porw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3FP+wgI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3FP+wgI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3279C2BCF7;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785685913;
	bh=kssaiTpuWaSTBvemdKDrGWLjRwD6PJPPxprkYN1MRtQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I3FP+wgIF7O6kvY2cQLAWY1vQX/aS660tYVZ9XIsgRrHbNaoHvkQsit1ZLS7iw6L2
	 3GaEY1kqklhoisrGHuuXPADe6GbmD8cXdhodUjbw2WTBAE5GZRWTkqzMBtHm7SZ2xP
	 e580fnyKEQ6kLCM7lehSpBXd4kkJIRystME7R5EIYnDlw4MP/YOjHo7y2ty4cKTMYK
	 9gehlOONxWKOq0MWgE6mCWAiUMWAW7dwtazXm6Krv3+c48kAuvMk+Rn24uw12fXymx
	 UHjlij87sTa0Mg285RNE1swXzW3nOVMRAGP4VHPc6azd+0Ym6D3T7Gy19w37f1wh2k
	 GRYf6/ye5H/LA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AB8C55162;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sun, 02 Aug 2026 23:51:39 +0800
Subject: [PATCH 1/6] powerpc/spufs: fix spu_context leak in coredump
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-fixes-v1-1-7368423440f4@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
In-Reply-To: <20260802-fixes-v1-0-7368423440f4@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Mackerras <paulus@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1723;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=4NyNHOiKkA4MH4J7oCGRtB6kCVTq8tsAtxRO2bfYk0g=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrPz0aQ/f7o50yDxiLOf7RMF8+oaGq+FhITvXLakqa
 71w6LqkQXtHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATGTeEUaGj6cyeValXTCt
 FQgxjG+NvjRv1+qIe0sdvrpwhDsuOve0gZFh4tb5rZyLDGb4ub3v2xMi7n3OzdKlwUjA08iycoJ
 F23dOAPdZSaI=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

coredump_next_context() returns a spu_context with a reference taken by
get_spu_context(), which the caller must drop.
spufs_coredump_extra_notes_size() does so on all of its exits, but
spufs_coredump_extra_notes_write() never calls put_spu_context(), so
every context dumped through elf_coredump_extra_notes_write() leaks a
reference, including on the success path.

Fix by dropping the reference on each of the three exits of the loop,
mirroring ..._size().

Fixes: 38b407be172d ("powerpc/spufs: Rework fcheck() usage")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/coredump.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 301ee7d8b7df..f5964c9ebb3e 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -162,13 +162,16 @@ int spufs_coredump_extra_notes_write(struct coredump_params *cprm)
 	fd = 0;
 	while ((ctx = coredump_next_context(&fd)) != NULL) {
 		rc = spu_acquire_saved(ctx);
-		if (rc)
+		if (rc) {
+			put_spu_context(ctx);
 			return rc;
+		}
 
 		for (j = 0; spufs_coredump_read[j].name != NULL; j++) {
 			rc = spufs_arch_write_note(ctx, j, cprm, fd);
 			if (rc) {
 				spu_release_saved(ctx);
+				put_spu_context(ctx);
 				return rc;
 			}
 		}
@@ -177,6 +180,7 @@ int spufs_coredump_extra_notes_write(struct coredump_params *cprm)
 
 		/* start searching the next fd next time */
 		fd++;
+		put_spu_context(ctx);
 	}
 
 	return 0;

-- 
2.51.2


