Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776257;
	b=ceDaf3VbH59+NMSY0XMs7mAboU39gIiFsbZJMZqapajtDPecAumlgsQm6WHDR83QvvV4
	 y4oBRHH4a6RtfNzgqKJyVLQ1XPa23lVKcqV6b6OTbk61uI1Wpmy/vl4ucF0tM76chc5P+
	 wasrSIKPadxP1FLCvndQUvvabWT+zAnNxqyZqjZK+g7YDjddabZZ6430+U48VO35lodjx
	 I3rTiJ2tV3KquuTS+LUXDoXYPbx7sqmWjYcR6OPaUaBYI0aGEAsvScriSjoUL0UmjZ1yG
	 yAGEZvZf33DJb2FYt5FNlUkea1H2zTI15hkRw3XHwRZ69cbbpt2LAZSCFoj9lDfleHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776257;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=y9kB8sA31+iIGUqWKOS1rLRnO1G5GJqSLO3ew8XeAMc=;
	b=hkr2aULekwheFqmdHG00qepltIKmnyuBgbUV+Fl57GctZRh4V2Aj+K89kiBr6GiUW6lk
	 pN2/qIj58t2zl3R4/CoZhG0OxxQrM5/euaGgI7fv62Lprb55TZkDQgs2mnBFnX7w61kri
	 Sz+dudi4bEFPaFRFEmcrAhwCvJOfv/IVZgaG0M7pk58lxdge456HBnfXN3quoSwnYtU/N
	 /9Rgdqjh6oHVeser6nsBPzYit20LhHL/jJHYhDf59J3VrQxTTJNfi3kD5hat15Oe27D5B
	 vQ55rHFnnVa/8oma47LDsFzVrD3OnaOTlgl1z1EvLfyyWiEcNGPzdM4L8Y7VZx1JTqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQGD8OIv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7A606A33E;
	Fri, 27 Nov 2026 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQGD8OIv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4B41F00897;
	Fri, 27 Nov 2026 10:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795776257;
	bh=y9kB8sA31+iIGUqWKOS1rLRnO1G5GJqSLO3ew8XeAMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SQGD8OIvuzB7cE9yPgNCYHwEnSeZ9R8Xi8pHd1Mq4ThubDT5++LJE4MweX/+FhYMm
	 sd0bZDJIOm5Z90mCJgiVLRz7H/yyxs21SmNEO1Q86rqRxI3PxmM6Y8iku+wCT9MprK
	 Pv7px5wlFoeQzP4xMTM6yRocrZbOnjM2tKatl0ic2P4VN7X8SlBbD6tSWeUIsbLg2U
	 ye+Mdt3ATjlErGOVYUw3BaxTRO5sy9C/4G4OKJz2oqbkkWQBdW7PsLJc6VHg+ptRAd
	 /XzfsCSb8Ae19/w24wlMpgSVu1RQidQxZ/p2ip/7p6Ny1kWDPfPEkmMDxRClKDD98n
	 2UPheILfwCiXA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Anandu Krishnan E <anandu.e@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 3/6] misc: fastrpc: remove dead context drain in fastrpc_user_free()
Date: Fri, 27 Nov 2026 10:43:51 +0000
Message-ID: <20261127104354.8452-4-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127104354.8452-1-srini@kernel.org>
References: <20261127104354.8452-1-srini@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>

fastrpc_context_alloc() takes a reference on fl via fastrpc_user_get()
for the lifetime of every context, and fastrpc_context_free() always
unlinks the context from fl->pending before releasing that reference
with fastrpc_user_put(). This means fl->refcount cannot reach zero -
and fastrpc_user_free() cannot run - while any context is still linked
on fl->pending: whichever context's release happens to be the one that
drops the last reference has, by construction, already removed itself
from the list a few lines earlier in the very same call.

The list_for_each_entry_safe() loop over fl->pending in
fastrpc_user_free() can therefore never find anything to iterate. It
has been unreachable since fl's own lifetime was switched from
file-close-synchronous teardown to kref-counted teardown; it was never
updated to reflect that the list it walks is now guaranteed empty by
the time this callback can run. Remove it.

Fixes: e85eb5feca8e2 ("misc: fastrpc: fix use-after-free of fastrpc_user in workqueue context")
Cc: stable@vger.kernel.org
Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 70b5642f5fbc..60c9d1d0834b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -559,17 +559,11 @@ static void fastrpc_context_put(struct fastrpc_invoke_ctx *ctx);
 static void fastrpc_user_free(struct kref *ref)
 {
 	struct fastrpc_user *fl = container_of(ref, struct fastrpc_user, refcount);
-	struct fastrpc_invoke_ctx *ctx, *n;
 	struct fastrpc_map *map, *m;
 	struct fastrpc_buf *buf, *b;
 
 	fastrpc_buf_free(fl->init_mem);
 
-	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
-		list_del(&ctx->node);
-		fastrpc_context_put(ctx);
-	}
-
 	list_for_each_entry_safe(map, m, &fl->maps, node)
 		fastrpc_map_put(map);
 
-- 
2.53.0

