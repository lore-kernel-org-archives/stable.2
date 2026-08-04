Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C94570C7;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833455; cv=none; b=knC4PWN3wlGQ4Svs5BuAKm8cC86bY0WJCMqxds4/mBJasH7/YWLWmbkXLj1SGOc+S2bsG/wsK9KJgofyxOKbp5UZShrGZukyn0pY8eOhsFHHltvaF4vAfH126DKGP8VnADW/WZR/F0z51px7DsFWCyv+Vq18wt0tcEvb7DvZUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833455; c=relaxed/simple;
	bh=Wg4a5GYB2+hy3rEJTPDy6EHTyRLohXwG7vmwER8t2Ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lipP7ygJW96ZcbHM8OSbLT1C/2+6K3WME4hfW0oWfIw7etz0x/7Y/Ke3zEBN6LLKHLlEjEIO0C3hmzGxURrvfsrAK6dILhaRuwuQN8GjTmZWp01112xcA8zaSp+6JShZ3LAlJSby+w6ofE5Y+JkPR8aVKuZ4Q2KZ8FrIduNyrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7oii5zk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7oii5zk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B9DDC2BCF7;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785833454;
	bh=Wg4a5GYB2+hy3rEJTPDy6EHTyRLohXwG7vmwER8t2Ps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f7oii5zktCjjdWcUS97nDJCz3QoJlcSOSLdMHx7F8kFdlcDx1MzzBAKKCpsbSdD5d
	 tHZvvGLDnf9NNMlz+KVnFuwMs185XmgGbwDmTzOyaAKzQVXa3LHvzoccDbFP1jjgAR
	 Z0YOFHXMYpvqCaa3TNT0jc2LRNvCoMwJzJxQTrxnTiGTji41xGgy+yI5GgJgA6EnnC
	 Csh8I/TF8uxE3ddyvpv7pFtPJpHhrquC+yEY7xHz3Lt+BtwBT4VqaYjp1dxAdfawE3
	 2WlMKRLh8j6JkZOx52K5SQIxMDGI9WPTWcHwOhY4wK4/+SfhtCdWr80VEqSjwI6Bi6
	 BwrBuM4MwZBbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79615C5518F;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 04 Aug 2026 16:50:38 +0800
Subject: [PATCH v2 1/5] powerpc/spufs: fix spu_context leak in coredump
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-fixes-v2-1-5bfd827297f9@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=XdWocYlkrxGjIsGC8gAbyPABgvp/vlZdqZWZhKwsHTk=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMLlr7OeK/LPnp5999fChz+TfA179+0qld6/7q/xO
 ieVZTIeoYYdpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMJHTKxgZ9q9epFt57ONa
 FmvF/w99a1zkVzS0n30q9Dba+YW1/SzFJQz/Y8tOfZ3JdntNbvtHp2MM8ZbuX1+pzb4/40pz171
 sc7nLHADYSE9b
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
Assisted-by: Claude:claude-opus-5
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


