Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E763BD246;
	Sun,  2 Aug 2026 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685914; cv=none; b=MwX2elBORMJfRaqkXgefcCZJAnmDHUo4DqAwOotrBGVfH4iwp9dm/lmygV3bWlVr05ND71NHe2Esl5RgizPiMz7jaOaN1U+/xuPtfjV2hnUQ8bUCgRV3UGdycfcmTR98YpgRH/OAZcLoVlDladZ3B7a6UX1dY2/hsMVWL/blAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685914; c=relaxed/simple;
	bh=96mlfMUaIDgRh0Y8+8e2rqme1oeFIIMr4fN0Dk5+hRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KV5dSGrueGEEUcxcTpm4nB6oB+mXxydyU771StSxk9Un6R1ygcLmbF4mzMqd4rMgCXoTtbmHF7IjwYi0HNEGBgYnCvjvKamskMq+ryOa77vucHI72uqpq9OaVlPxeL+JEicOsx7RYPJsKDsGEQhXivWHlojex1CIGbIrjWC3l98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGrZEyBu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGrZEyBu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA685C2BCFD;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785685914;
	bh=96mlfMUaIDgRh0Y8+8e2rqme1oeFIIMr4fN0Dk5+hRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IGrZEyBu5ZVT81FcE3gE99cThUtlb2qi+9YwS2LJuCLDZ3VPzmCWibGMGbrThwrm0
	 1GFKPR1k9gKZ/CryGovWbMNs2tTbKANCsUHZ67qBtb+DvYNnROPvO3CSJQfnt+CiII
	 wIyoggr5ZOEErgtDB1/JVqmmk4EVX8Hbom2lKb9tVCbz9ty5HuBSZhAio/yrkuCnEY
	 LPBpgwhIrxnsgvo9Hocs83mIkii1l6gk1F41uWzivjpWTDVCJFNh5cyboNRnoYJgZa
	 CHHJkpk0HtueQ6QzsrAtyQO4JVG2gvXuoCz8mGSSYPZamRS0indF/Wt7LVAz9/V1Za
	 cV5F7A9Re4XaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFA2C55180;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sun, 02 Aug 2026 23:51:41 +0800
Subject: [PATCH 3/6] powerpc/spufs: bound NPC against local store size
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-fixes-v1-3-7368423440f4@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=zn0rin21Vmi2aZsnEd8aIQAuyKtzsUFBfqpkfQqnfiw=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrPz06QKOEseezU055Jt+YN7t0MAV9xRPVU8XrJ79l
 bnPia2Ft66jlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJiJpxMjwJSQhxPQeT+qa
 PmbB6w9T6zI+rX7FWf/mhWuTqt3DpYa/GBlmNs5n5JmYLSKaY2Iy48Gc5OVfS57f8ZVbUK/Pf/7
 utBR2AOnlSKw=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

spu_process_callback() masks the low bits of the NPC register and uses
the result as an offset into the SPU local store: `ls_pointer = in_be32(ls
+ npc)`. The following guard validates ls_pointer against LS_SIZE, but npc
itself is never bounds-checked.

Fix by rejecting npc greater than LS_SIZE - sizeof(ls_pointer) before the
read, mirroring the adjacent ls_pointer guard and returning the same
-EFAULT.

Fixes: 2dd14934c913 ("[PATCH] spufs: allow SPU code to do syscalls")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/run.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/cell/spufs/run.c b/arch/powerpc/platforms/cell/spufs/run.c
index ce52b87496d2..87497316d128 100644
--- a/arch/powerpc/platforms/cell/spufs/run.c
+++ b/arch/powerpc/platforms/cell/spufs/run.c
@@ -317,6 +317,8 @@ static int spu_process_callback(struct spu_context *ctx)
 	/* get syscall block from local store */
 	npc = ctx->ops->npc_read(ctx) & ~3;
 	ls = (void __iomem *)ctx->ops->get_ls(ctx);
+	if (npc > (LS_SIZE - sizeof(ls_pointer)))
+		return -EFAULT;
 	ls_pointer = in_be32(ls + npc);
 	if (ls_pointer > (LS_SIZE - sizeof(s)))
 		return -EFAULT;

-- 
2.51.2


