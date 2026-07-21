Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29F3CA493;
	Tue, 21 Jul 2026 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628548; cv=none; b=PKxqP/+4c6GgeY1JjHY6pv4PwhD3lYGo3YxEwo3vMTJUGracEx+iFDV2OhNB6+PvDhY8es5nKquC11vB4po+E/+JbVLZDDnmQ4g49GCCCfbzU/NlRNuLAulu3T1wPqCtLZ4X/+vGDu1xbAzcigzY0d7FBqXj7klGA9xAZgxCf8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628548; c=relaxed/simple;
	bh=BfGVnvLylOR1ukv19F3xDAtbizuM3JaHDvahSFlKH8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U23Z8cBf+ARx2Y/sN9J3RjpPBozvCn8Qx9HCeZjLzFKa6V1XSpKFS7sZpTMW0xo2AhwylbugtwnTtLsORibbFlfYORAs3OQJ/xka9ovZkW5bpUtQ2SdKQPb1MrRYIbHsnX887IS+Ji9KhI4tXZ1GVNuoeCejju7AlMpEXoLs6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfFcQbR1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfFcQbR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0F71F00A3D;
	Tue, 21 Jul 2026 10:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628546;
	bh=HhgiFT7gO89ZbsoBF977sX4zSyifCWX/9pr2xPYrWr8=;
	h=From:To:Cc:Subject:Date;
	b=dfFcQbR1u/TdFv+tY8MlY9H7YDBQJaV5W8E4oIz4qNkMOVVKJiXONvo87Dvecag0S
	 QCsF6+gLgGAATS2Vka9Y8U13kG39TPBfME96ic7LHtwSkkuv/FpyDakq0ssUqyzYfO
	 kzKcxru4YGETZLSYs/J958X6/iaX0rhNEJwga0n4PJFnFT/YrF9sRp1YP+7X9hOwni
	 40l5VC+n82c+sRlZo2NHFf/GnRrGoDfy5oVXf5YhTIvqs4CVGDvV9qsMD8iBYeUVi3
	 sb/2cZBspZi50pxT4vUIM79ZdphD/yLwYLspdQLWWY4F780fwDnP9zu3asvuDNNNxN
	 74k8nqmqY7giA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH] exec: fix unsigned loop counter wrap in transfer_args_to_stack()
Date: Tue, 21 Jul 2026 12:08:49 +0200
Message-ID: <20260721-hochachtung-staumauer-pigmente-15d71f7d7d04@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2999; i=brauner@kernel.org; h=from:subject:message-id; bh=BfGVnvLylOR1ukv19F3xDAtbizuM3JaHDvahSFlKH8w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFu5pnM/w/kBcX9SbY+PubiPnV+7x8rr7S7cpb43nM8 Mthj9O+HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5/JGR4Wrvu9/sk82/vp/6 beWPXXytMjv9P9pcPXTY5GmenYpM/iFGhu0iQveOWRmUfdJQOWl9v6Hf4q/N9OLMdU+UTu74ya/ 1lh8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The stop value is derived from bprm->p >> PAGE_SHIFT. The index variable
is an unsigned long. If bprm->p drops below PAGE_SIZE and stop becomes
zero the loop condition index >= stop is always true.

After the index == 0 iteration the decrement wraps to ULONG_MAX and
bprm->page[ULONG_MAX] reads sizeof(void *) bytes in front of the array.
The pointer has wrapped to -1. That garbage pointer is then passed to
kmap_local_page() and PAGE_SIZE bytes are copied from wherever that
lands into the stack of the process being created. And the loop doesn't
terminate either...

Getting there only requires bprm->p < PAGE_SIZE. On !MMU
bprm_set_stack_limit() and bprm_hit_stack_limit() are empty. So the only
constraint on how far bprm->p is pushed down is valid_arg_len(), i.e.
that each individual string still fits in what is left.

bprm->p starts at PAGE_SIZE * MAX_ARG_PAGES - sizeof(void *) so a
single argument or environment string of a little over 31 pages leaves
it in the first page:

  Oops - load access fault [#1]
  CPU: 0 UID: 0 PID: 1 Comm: victim Not tainted 7.2.0-rc4 #1
  epc : __memcpy+0xd4/0xf8
   ra : transfer_args_to_stack+0xaa/0xae
   s4 : ffffffffffffffff   s2 : 0000000000000000
   a1 : ffffffdc98000000   a2 : 0000000000001000
  status: 0000000a00001880 badaddr: ffffffdc98000000 cause: 0000000000000005
  [<801a5324>] __memcpy+0xd4/0xf8
  [<800d5f6a>] load_flat_binary+0x43a/0x65e
  [<800a2de4>] bprm_execve+0x1d4/0x316
  [<800a351a>] do_execveat_common+0x12e/0x138
  [<800a3d44>] __riscv_sys_execve+0x38/0x4e
  Kernel panic - not syncing: Fatal exception in interrupt

This is an arcane bug but we should still fix it.

Count down from MAX_ARG_PAGES so the loop ends when index reaches stop,
stop == 0 included. The iterations performed are unchanged for every
other value of stop.

Only CONFIG_MMU=n builds are affected, transfer_args_to_stack() is used
by binfmt_flat and binfmt_elf_fdpic on nommu only.

The loop predates git history. commit 7e7ec6a93434
("elf_fdpic_transfer_args_to_stack(): make it generic") only moved it
from binfmt_elf_fdpic.c into fs/exec.c and narrowed the copy to the used
part of the first page. The condition and the decrement are unchanged
from 2.6.12-rc2.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index d5993cedc829..c7b8f2d6366c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -740,7 +740,7 @@ int transfer_args_to_stack(struct linux_binprm *bprm,
 	stop = bprm->p >> PAGE_SHIFT;
 	sp = *sp_location;
 
-	for (index = MAX_ARG_PAGES - 1; index >= stop; index--) {
+	for (index = MAX_ARG_PAGES; index-- > stop; ) {
 		unsigned int offset = index == stop ? bprm->p & ~PAGE_MASK : 0;
 		char *src = kmap_local_page(bprm->page[index]) + offset;
 		sp -= PAGE_SIZE - offset;
-- 
2.53.0

