Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E8F3BA24F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029217; cv=none; b=qvI543uBk0C0apaGoFkDPBag3n81WY0we5ddB/07dCGGAS6eLjJWyeZfZVQAFzeZQJ0cNoB5akeYvyTvBcEHJcnA87b7UUpzgYoRVaeonYr5Sp9ELxFTI1xc7Q9/bED9gcO+8FrXPIHhXhh4m739p7hzfcVdk82limb8vDE5MyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029217; c=relaxed/simple;
	bh=P/YNUBHnDwhYnfFgrwq4qMj3YUiusx1D46dydg5ZQYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7FZ3Gvnp1hT25mUwSCFICiDdNkOUbw4IVxXwOw5wnFbUdRVejFo32Qco/CTJCgm6mpBhl5ViEnUwDvN7ZEfTPPlbqSNYjT6UXS1F12lD7XEI8SrCicvZslAhzGgDf7nvqwjcDZKP4Fw3O6O5NAJv7ep8whQaZW2/MYGFd5urhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeZ0wi05; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeZ0wi05"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4adso1673572a12.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789029214; x=1789634014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pxTKy00LI83HyYkQsjV8PxYjVMG6Lme6WBarRkbM+gw=;
        b=ZeZ0wi05baN5hjKhD4nkoO00Ez5oiBJJ4OMxaxmt9kpRYRyCX16ArHx74Rx1d4MuN2
         he7t9hHe6gLwK0O58IX48XZJl5tDeBmDN8AjRLtH/RahWgVV19VjmoUB/9pQAXoGpqMc
         K+CvuXDDlCXRHujX++C3iRUoBYjSgMtM/1v2xqXO4P9hKhJlB1aGog7TWwGSOIZEkpJj
         q6duQDVV7On3fs/eZuRAvdDI9WukbUlQ7yKxdvke381sptINisLBtxgOifytUtL5Yruu
         Tr4tVAeawkQetDlJVss03Dqvo8erTEgyWhtPPdDS8gSHVzeRfzK4h7JG+zCy2+Wi6Q/4
         VCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789029214; x=1789634014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxTKy00LI83HyYkQsjV8PxYjVMG6Lme6WBarRkbM+gw=;
        b=sJoFG56uGhafUpAj81HdFPd+7TGd3Bk1ZwikraTEPjleDYV9Epxl1vBXotbOIMswlR
         eFQ5Ama+e/hHnoIfvwFXGwZIMJ/biQ5TNoVN8Y/ljzRO5f6N0xpBV3HsHYuWFFl7FiT2
         49wh5hdpPZaN/Hv4EeeA0s4nXUa7+sZSeJpq4y9jBucKpJYaHYHuE/CB6m5oUltLFDEM
         2xFaG46IbbcdAnnavOHFz3SBM7w8UNUNVCVqhZZdKbro3mUlAszbEQd/U8+13n8gVrVu
         dow/MoGova2hypYzFSDzBjJ/+jUrOMLXyl09Jl3cFcbplNTWx8cT7zs8wuOA6/GVfR6J
         hAGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKVqiVb/72RpG9QHUUVe1Ko1iKIsKrLHOJ6mCGbtK2Ie27XrTC5ZDzBHCKD0lK5VhYixOvmVQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ma8UvIeODUGDgrTZbOhTTHe/PkCphOVgxZnzRavMl6htG6sQb1
	4oIpqUabJcO3mpSDC/GsgXT18vcwX66KFXDO9O6awLoxl2af3sJjOarP9Ta4hQ==
X-Gm-Gg: AYBFou3c9wBuhthG1X8Phw4j7zpK0TN0uGZElTmrmnRRH6+WYkSRkAwYkzGrWOGdHNF
	0dJo1XcLq1bFm5ygVdcHr1jj2aw6loLMtHs991HJ8VGKApvZagUbAfxVygRL8o31VrtQYoa+Y/L
	zMZ6gKAKWS46liC8uSCN8K2+kUNIfQibU8IBvFwNiMd2pbLRWcN0+a31TxtxEwA6m17PJVMIbU5
	P69ZUxMUXTkHwp6KIe7SMFetWyoXyUY20H8FZNU6jDVYSXkI0JNW4uN/ycK7uWjrlIbsWD8IgPo
	3Y68e/AYxjQ2ezHjG7Et3vzy/sFZNDlVDYLVZ5LiC+IFyTFiiyKtF5uzetIax1UTwiFbPkM/Yj0
	z6SO0SUi6VyhsAH3hu1ngNym1IDwpT7FZM2CEAGAnrXQPG8cI1QMqTjexCS4eE8vDJOreMO6nYJ
	rIM9YSwLNcJVpjTOCiZjCdLrZX7ogzBtEAJcwLr3Kem7Szr45GwNy7HMekIokJnLfpy5VeBeE7H
	ULk0dM7R9GxplYOi/j3IvNaCZrCDse43AGL
X-Received: by 2002:a17:90b:4c42:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-39bac1d7de5mr16175322a91.10.1789029213933;
        Thu, 10 Sep 2026 01:33:33 -0700 (PDT)
Received: from localhost.localdomain ([117.88.121.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e840f3asm3869217a91.12.2026.09.10.01.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 01:33:33 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfilter: nft_flow_offload: drop flowtable reference on init error path
Date: Thu, 10 Sep 2026 16:33:26 +0800
Message-ID: <20260910083326.2697336-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

nft_flow_offload_init() bumps the flowtable use count with
nft_use_inc() before calling nf_ct_netns_get().  When the latter
fails, the error is returned as-is and the reference is leaked.

The upper layers do not balance it either: nf_tables_newexpr()
clears expr->ops when the expression init callback fails, so the
nft_expr_more() iteration in nft_rule_expr_deactivate() and
nf_tables_rule_destroy() stops right before the failed expression
and its ->destroy callback, which would drop the reference, never
runs.

Each failed rule addition therefore leaks one flowtable reference
and the flowtable can no longer be removed: NFT_MSG_DELFLOWTABLE
keeps reporting -EBUSY even though no rule references it.

Save the nf_ct_netns_get() return value and undo the nft_use_inc()
when it fails, restoring the inc/dec pairing within
nft_flow_offload_init() itself.

Fixes: a3c90f7a2323 ("netfilter: nf_tables: flow offload expression")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 net/netfilter/nft_flow_offload.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 32b4281038dd..d3c5651dd699 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -160,6 +160,7 @@ static int nft_flow_offload_init(const struct nft_ctx *ctx,
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 	u8 genmask = nft_genmask_next(ctx->net);
 	struct nft_flowtable *flowtable;
+	int err;
 
 	if (!tb[NFTA_FLOW_TABLE_NAME])
 		return -EINVAL;
@@ -174,7 +175,11 @@ static int nft_flow_offload_init(const struct nft_ctx *ctx,
 
 	priv->flowtable = flowtable;
 
-	return nf_ct_netns_get(ctx->net, ctx->family);
+	err = nf_ct_netns_get(ctx->net, ctx->family);
+	if (err < 0)
+		nft_use_dec(&flowtable->use);
+
+	return err;
 }
 
 static void nft_flow_offload_deactivate(const struct nft_ctx *ctx,
-- 
2.43.7

