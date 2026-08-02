Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F0D3BD629;
	Sun,  2 Aug 2026 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685914; cv=none; b=RbfnZfMX0R7CfFtyME4KrV3USXZXqX51jF4QP/P/LEfc2cVDWFiov2dQHc5bJww/R0qOM/c6YjqHLHU5y5wt3rcTlQpAvC4cED3mkLWrFBz7Nwwf3AwAoQHgqWYw21Wa2T9tQeFWSBjwXuGo1YsEbngXyiBIO8iIhg/TrlxZpGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685914; c=relaxed/simple;
	bh=m9qYyZFPWHD8u5pzGA5bglHhVct9JFkiPueOzfG68c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jRvbg2HMfPNKBqCkXk2RzADmye7b8ArtD2Z9QisPLcOBOzKb410DXXIWz94GYQhET+pJ2qW5sNxDq/LXI2JOGVGk/5bTfdHs6/4Bpjznh0k4PIk3/HUbjQiZSk69P/4rEb/aQQbFHReMNTmsP/7oEwdL/c1TiqGCNE947EcgZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT1TEx3L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT1TEx3L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF71EC2BCFC;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785685914;
	bh=m9qYyZFPWHD8u5pzGA5bglHhVct9JFkiPueOzfG68c4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HT1TEx3LzVMlFIPHrO539PJgrk6KZ2iqRWj6o78PyzST2LisTa+5MdZrZ4CaH8/Qr
	 BEXWXreFll8DwFqO7bapdJeEYpmyJI8huupkDo+iCGa3sz4F1cIdtIsZSMeqK0vZqB
	 YDVIAkN43twkbVDaJbOf44M3vQA6FnkHhfdUjciBQfdhD015mth6VheKo7/5sYz6M+
	 /sAQlT5LbOT6w75FVlq8yp7nOZTSqepPf6Y16Fm5/zNvK4zfCXCHNXSti9BwojEE2E
	 yrIYFINnpkBZTYyGWtvEwXFVdNCwUJGZNb6ItLs3pGGrJfrlqSH4p8cx4ZYdq9kF0v
	 MAciI8dZ1NQwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D0BC55175;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sun, 02 Aug 2026 23:51:40 +0800
Subject: [PATCH 2/6] powerpc/spufs: don't leak kernel stack via spu_run
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-fixes-v1-2-7368423440f4@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1557;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=JbhPcONN9PAPqWDS7IAW9bNoVq7Tog3058VmeC72cKQ=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrPz06RI7tzly3IkWCtuj8vPhkaZmvtV/ug8FBss8e
 HNfaFNiXWVHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATOTyLob/QRPi7m7dHi72
 8PEzY7EU9eWi4novRY2vZ71cqXig1bj0EcN/f/XvderGXuX/vnytr1yyYlbW5zsPbLaw9t5d5K7
 5e20hOwBtQk9E
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


