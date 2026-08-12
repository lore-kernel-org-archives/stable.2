Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16F9482D4;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513697; cv=none; b=PGwo3+bDaPVkQN0W9dyH8dKni7pxr7uBxZjVk5l/K9u5+sCwMh8cq2nnQmTh25LHZt4Vtrb3xRjqahUfylZ0zyW5zYwfeg4JoKHrF21jxPEwpys1cAlM5yTeug1vzbBPrzDFABs4DPv8eaBleiSIfcQwEWKzUGFevA0FshRAU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513697; c=relaxed/simple;
	bh=0Zo7Rbv+zcD+9wkog421wT1HYw9FSZDE+BW1aRtXh1o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cpGA7bYE+7+zqNZy5ITJGl2V4gG4w1E0BkLwGpWxtn1uBp9qQQL2uVLck4MUeEYT76kkeSKSlmSX+ZBm9tMAcVLD0jN5asMM2eX2QpUo85PzlXx3skakOdgfdD++PFjbnZd1GT2GeauUO9qSFEN2OkSQd6TTYmeQvm0O/3zox5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otpnH+Z2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otpnH+Z2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EA43C2BCB9;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786513696;
	bh=0Zo7Rbv+zcD+9wkog421wT1HYw9FSZDE+BW1aRtXh1o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=otpnH+Z2B4gaP84TTqLX83SaFosEn7R/2P1CEjDwioA9LCYEEb8kRkPkYYF9ZVezK
	 6AGbsPtkQ/r275HWOwXiOa1WaNZ2l/dPMQ/92YbANBuHLlcJkooaEDKK7O4XGsUu+9
	 Tg4yge8rCIKi3Ib8/3He7kY/CazH0rzYDtz3fICrXHSNMEbbB2/pmscqk9ezVqOD+C
	 EWF/NzxNkiSQQu9lXhs2v6AV+xDCsF4YmZL0tfOV2fnXjcBJJ2gNP11knWyrrKFG6l
	 G2fTu0a4dq7g9CTxfPUFj0CNilw1zV4ubTWLmVQyePlFVya0rIYsvPMXYs4C6IYJuI
	 AF12IQhpULc0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F7C5B56A;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH 0/5] powerpc/spufs: fix a leak, an OOB read and three
 context lifetime/locking bugs
Date: Wed, 12 Aug 2026 13:48:06 +0800
Message-Id: <20260812-spufs-fixes-v1-0-449e201d9f64@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABYJfGoC/x3LTQqAIBBA4avErBP8AbOuEi3ExpqNiUMRiHdPW
 n48XgXGQsiwDBUKPsR0pQ41DhBOnw4UtHeDltpKp7TgfEcWkV5kEfyEyjhrlJuhH7ngH/qwbq1
 944gqs10AAAA=
X-Change-ID: 20260812-spufs-fixes-ca7e13863189
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Paul Mackerras <paulus@ozlabs.org>, 
 Luke Browning <lukebr@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3114;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=0Zo7Rbv+zcD+9wkog421wT1HYw9FSZDE+BW1aRtXh1o=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBpOWdkFERvEYwJmvRSO3btAjG3R6dgMLstH69ZwK
 qs0fG/R/9ZRysIgxsUgK6bIcrzg0jcL3y26W3y2JMPMYWUCGcLAxSkAEzkpyMjw06uz4DDPme39
 V1dKnnuo3ux4/pNRl0zvpdR/FrlLNlXPYWTY80/ekcMqdvE0VQ4ZgUbDGanupqeu/dtasY3nmnm
 e4H8OAAfuRww=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

This series fixes five independent bugs in spufs.

The first two are simple and directly reachable by an unprivileged user:

 - Patch 1 frees the struct spufs_fs_context allocated by
   ->init_fs_context(). Nothing ever released it, so every spufs
   fs_context leaks it, and fsopen() reaches ->init_fs_context() before
   sget_fc() rejects the mount for the lack of FS_USERNS_MOUNT.

 - Patch 2 removes a double sizeof(u32) scaling in
   spufs_wbox_info_read(). The value handed to
   simple_read_from_buffer() as the length of available data reaches 64
   for a 16-byte on-stack buffer, so a read past offset 16 copies up to
   48 bytes of adjacent kernel stack to userspace. The mailbox
   occupancy that gates this is set by writing the context's own wbox
   file, and wbox_info is mode 0444.

The remaining three are concurrency bugs in the context scheduler and
the fault path - one object lifetime race, and two around
ctx->state_mutex:

 - Patch 3 takes a reference on contexts returned by
   grab_runnable_context(). The runqueue holds no reference of its own,
   and once the context is unlinked the owner's spu_del_from_rq()
   becomes a no-op, so it can close and free the context while the
   scheduler still holds the pointer - a use-after-free window spanning
   a full context save. The BUG_ON(!list_empty(&ctx->rq)) in
   destroy_spu_context() cannot catch it, because list_del_init() has
   already emptied ctx->rq.

 - Patch 4 retests ctx->state after spu_deactivate() in
   spu_acquire_saved(). __spu_deactivate() drops state_mutex
   internally, so the earlier test is stale on return; a second reader
   can consume the single SPU_SCHED_WAS_ACTIVE bit and rebind the
   context, leaving the first acquirer reading a save image the SPU is
   still writing and then hitting the BUG_ON() in spu_release_saved()
   with state_mutex held.

 - Patch 5 releases state_mutex before re-taking mmap_lock in
   spufs_ps_fault(). Every other spufs fault path takes the two locks
   in the opposite order, and three threads sharing an mm can close the
   cycle; because spusched_tick() takes the same state_mutex, one
   wedged context also stalls SPU scheduling for the whole node.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (5):
      powerpc/spufs: fix memory leak of spufs_fs_context in spufs_free_fc()
      powerpc/spufs: fix out-of-bounds read in spufs_wbox_info_read()
      powerpc/spufs: take a reference on contexts pulled off the runqueue
      powerpc/spufs: fix context state race in spu_acquire_saved()
      powerpc/spufs: fix mmap_lock/state_mutex lock inversion

 arch/powerpc/platforms/cell/spufs/context.c | 4 ++--
 arch/powerpc/platforms/cell/spufs/file.c    | 6 ++++--
 arch/powerpc/platforms/cell/spufs/inode.c   | 1 +
 arch/powerpc/platforms/cell/spufs/sched.c   | 9 ++++++++-
 4 files changed, 15 insertions(+), 5 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260812-spufs-fixes-ca7e13863189

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


