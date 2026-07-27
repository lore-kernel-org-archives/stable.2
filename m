Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919EA3CB918
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181862; cv=none; b=VsOQvjRooRHtCfihbxPCMIdMQ9zg8fE4eqevlaNXANmXRfWnTd8VtzCeT68TW02fIUhta6bnWfwCgfb8jx4rG8afivetP0S30Lqz0ZBSqcR5aXF8rN5iXkMnnQk6A+6BwVzTLwoa5y0tgXgr+pZCr/4LOTJvf5rW/OP9f3F1Pgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181862; c=relaxed/simple;
	bh=oBhqkanPinfUGH4t6TxsuYoZFqcn8tQTcr8RyFsZeII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcht5tdMPC8Tz48Z1b1h+EGyOG4mUeLtV7pqc+FBDESO4yj9X5tQdIMneTHVsIUr4hnoz9VqF0FI0WqNn8GGZsG48NahKmIg0eZJ+1GY5s1N3DuJZzRHyLuG+bbaE7uZmoTcUjrYzZ6JFUcgpXr7Fbrzc+VI/gumUhfsmH0wEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUjWOAoX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUjWOAoX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF08D1F000E9;
	Mon, 27 Jul 2026 19:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181861;
	bh=DE5uabCF49oVuDLNfPCPZFNpxYeZjcp/NhIjyw5c8E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oUjWOAoX5qa65eVLMO75H8ujlpYw8BeTcVk294C6H1w+KdWXWcabu92QlZIaEOlB5
	 +uzS10cBh5Y6+i/plA+Zv/ix2LpA5xmFWFhrUmDlrKuHe8MtgM1N6qaMVYRNkS5Gnd
	 sLiygC71yOfF2USjqNi6vRiuqDa7V8pcKqvM0QEB3lSXfzsI71wVpSorHQJoEh5QO0
	 EvNc5f7NHoyXzl8b4kSqvu/fnbOV6sbTOC9/y9GMzacwrhM6Pg+8csLcZWRUbPE4lR
	 Pwnc2+okVe5ksYA44mUZwoBMD80MFFDC4BJq9zrWmFNhlZGxYkZGkFkje2b8KcmaIH
	 6NhiTSxGB2whQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Doruk Tan Ozturk <doruk@0sec.ai>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] accel/amdxdna: reject command submission on devices without a submit op
Date: Mon, 27 Jul 2026 15:50:59 -0400
Message-ID: <20260727195059.1774971-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072030-chastity-composed-e7c9@gregkh>
References: <2026072030-chastity-composed-e7c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Doruk Tan Ozturk <doruk@0sec.ai>

[ Upstream commit 38953513d7313992676d4136cd425cdb70c6278e ]

amdxdna_cmd_submit() calls xdna->dev_info->ops->cmd_submit()
unconditionally, but only aie2_dev_ops defines that callback.
aie4_vf_ops (the AIE4 SR-IOV virtual function) does not, so a user
AMDXDNA_EXEC_CMD ioctl on an AIE4 device reaches a NULL function-pointer
call and oopses the kernel. AIE4 submits work through a mapped user queue
and doorbell, not this ioctl path.

Reject the submission early with -EOPNOTSUPP when the device provides no
cmd_submit op, so the shared EXEC ioctl is a clean no-op on such devices.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260713173030.87541-3-doruk@0sec.ai
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index cfee89681ff3cf..3f7e53b1b6ee4a 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -405,6 +405,10 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 	int ret, idx;
 
 	XDNA_DBG(xdna, "Command BO hdl %d, Arg BO count %d", cmd_bo_hdl, arg_bo_cnt);
+
+	if (!xdna->dev_info->ops->cmd_submit)
+		return -EOPNOTSUPP;
+
 	job = kzalloc(struct_size(job, bos, arg_bo_cnt), GFP_KERNEL);
 	if (!job)
 		return -ENOMEM;
-- 
2.53.0

