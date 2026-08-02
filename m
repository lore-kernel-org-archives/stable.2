Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0323BF694;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685914; cv=none; b=vAShoVsR9ViwhFsUdnyXx9cWuOUuK9eYzrN38rbiMB+BkrextTeanwZLj3NLjDdGzg/eG2AgilI8Cw9hrUmr92wkLwJW/ikVHfj0n3TTW0IPq6n8BD/6DgyxMZEmlfQwNb0h4vgCyMTg/arxuojc9N8+AvecCSOCSNx3LDMSou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685914; c=relaxed/simple;
	bh=D3ZdLkxeKQ+GTih21pSwwkDXOkOvUZicqpK0qWxiBCY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mjE0vF+H1eCT0idb0qT1shOBROnkNwDWaff+nnI9ZLJeNXR9DPQZuSsRLBoBY4StpPSkX9pt3PTBKv3h+8zmUXtRVyvfpkHzXqwpMjyz1AkuPAWNPoMDZSx47BcXatlX9wdcnxs6x9d5fWq1SENdw7WUvyn88A0JnO7NoN//cqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6hi3wN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6hi3wN+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB265C19425;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785685913;
	bh=D3ZdLkxeKQ+GTih21pSwwkDXOkOvUZicqpK0qWxiBCY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=l6hi3wN+YBvMo85IRRDgokeengpqq9mDBexOg49poSywFuR+3bKEAZq4jQfoXwoGo
	 k7vGBvUyIWXBoHPXFZE2HQ4qfKjFkcn2NRVmkwbmihHJ/e5OPaMEtpJ5eoF+IMZ10J
	 s82WMSZMhJv5p8lkpX9f521T8t9h5awKNC/0aPwmAH2RVV2ky0tSNuMhQGJ8mVR9mn
	 D8E4Ry7zEru4vyTjG9ArestSxK5soR/YFbKm3NFDz4cpeLxJfFww/9WD95EufKrSHl
	 Ue0ABGVh+wk/Kg9GAnklJS/f9MsHoWqoE2waP1fAxD9kTLYxbAqAshfT/H0z3mQIzt
	 6ZBAjsaW5RcFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62C4C55171;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH 0/6] powerpc/spufs: assorted fixes
Date: Sun, 02 Aug 2026 23:51:38 +0800
Message-Id: <20260802-fixes-v1-0-7368423440f4@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIpnb2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwMj3bTMitRi3TRjY2Mzw2TDJKPEVCWg2oKiVLAEUGl0bG0tABNQmaV
 XAAAA
X-Change-ID: 20260802-fixes-f33361c1b2ae
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Mackerras <paulus@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=D3ZdLkxeKQ+GTih21pSwwkDXOkOvUZicqpK0qWxiBCY=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrPz0aWk8f0qquGarOzbMrX/o+01iK+91zkc2ndpez
 HErJv65tLCjlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJiLEyfA/TGeRYOUegUNz
 fpgLbjgR/WxWfG6LgGWTS62dxFRPBbsMhv+5q+ydUxz/LE8/Znav8sDslIxt274FHZo19YvO6qX
 XhabyAADeT0oh
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

Six independent fixes for spufs. There is no dependency between them,
so they can be applied or dropped individually.

  1/6  spufs_coredump_extra_notes_write() never drops the reference taken
       by coredump_next_context(), so every SPE context written into a
       core dump leaks a spu_context. The matching ..._size() path gets
       this right.

  2/6  do_spu_run() copies out an uninitialized 'status' on the paths
       where spufs_run_spu() returns before assigning it, leaking four
       bytes of kernel stack to userspace.

  3/6  spu_process_callback() only aligns the NPC value, never bounds it,
       before using it as an offset into the local store. The register is
       userspace-controlled, so the following in_be32() can be driven far
       past the 256K mapping.

  4/6  spufs_setattr() calls setattr_copy() without setattr_prepare().
       notify_change() leaves that check to the filesystem, so mode and
       ownership of a context's files can be changed without the usual
       authorization.

  5/6  spufs_create_gang() calls unuse_gang() with the parent directory's
       i_rwsem held for write, and the resulting simple_recursive_removal()
       takes it again as I_MUTEX_CHILD. The task deadlocks against itself
       and leaves the spufs directory write-locked.

  6/6  The mailbox read/write handlers hold ctx->state_mutex across
       put_user()/get_user(), so a userfaultfd region or FUSE-backed user
       buffer can stall the context lock for an arbitrary time.

Patches 1-5 are tagged for stable. 6/6 is deliberately not: it changes the
atomicity of multi-element mailbox transfers rather than just adding a
check, so it seems better to let it soak in mainline first.

Build-tested only. I have no Cell or PS3 hardware, so none of this has
been exercised at runtime.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (6):
      powerpc/spufs: fix spu_context leak in coredump
      powerpc/spufs: don't leak kernel stack via spu_run
      powerpc/spufs: bound NPC against local store size
      powerpc/spufs: check permissions in spufs_setattr()
      powerpc/spufs: fix deadlock on gang creation failure
      powerpc/spufs: don't hold state_mutex during user access

 arch/powerpc/platforms/cell/spufs/coredump.c |  6 +++-
 arch/powerpc/platforms/cell/spufs/file.c     | 52 ++++++++++++++++------------
 arch/powerpc/platforms/cell/spufs/inode.c    | 21 +++++++----
 arch/powerpc/platforms/cell/spufs/run.c      |  2 ++
 arch/powerpc/platforms/cell/spufs/syscalls.c |  2 +-
 5 files changed, 52 insertions(+), 31 deletions(-)
---
base-commit: 02dc699f83d04069fdabc996fc22d47cda47a4a9
change-id: 20260802-fixes-f33361c1b2ae

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


