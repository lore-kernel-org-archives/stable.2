Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E79577E28;
	Tue,  8 Sep 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882866; cv=none; b=odtJYoM761ibUVnDGRvvMl4+vvelqvSZBMILJsGCEcS8Ye/9OM14aDqYFNGoQpZCics/gmZXKvKCkBzAZNtNrctSJ3xE5EQ0txMkMClMs58m9om+9F4j9Wo0GTG788Mfhfv4tuS9G2WXyENsDakxv7h18zAC8M/JjGT6XEzg9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882866; c=relaxed/simple;
	bh=cxPKCV//uGbcvndnKx8KC2CJa5aIAbyz+N0Tg1uQDDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBmosYDNeg4kxMNGaD9ktqxxwz7EobSuqNRlarsi+bohliJxPIImNxc/5skUCUzpZknqCLEZOMqXDisE4J6vvUEr2joZg++cJIRlUvG4/BYstmrtr+FFVTsMIXWbZmRVMpXbB1WuPQmLEsTA6toFww8gEZUYm0QjZaaR2nDL6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=CxbfyXl0; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=cQWXl1Lg; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="CxbfyXl0";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="cQWXl1Lg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882859; bh=cxPKCV//uGbcvndnKx8KC2CJa5aIAbyz+N0Tg1uQDDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxbfyXl0635taGq7qgN5oQJ669TeooDjDexMllkQXRsPP6eDf/O8MjDxPxT3r5Q53
	 21JLjHOrl60I1I9wONyDtTwEDy/crFG/4ZL8zcSLHl0Vg8uvDrO3BswpKXWrHMxlCm
	 5IW5quwosiQY1PML65us+QUKKFQwGVAh8OCNUDMKk04wSetci4voySuJtqP0UHv0Jf
	 fJ+vpe1KO36rc53BE26mUCMNZ1yk3zwBT1N9Agu5hSh3dlBMfFPsVYV0bzisb5HxEg
	 MYoUfIuli+1zUuBpDo1b8ho7lOUPRoLTOalY6c0VKOuYiCB9cO26P9MJ1/c6sZll+5
	 XCJlMbvUU0ubw==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 09B5D41464; Tue, 08 Sep 2026 16:54:19 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882858; bh=cxPKCV//uGbcvndnKx8KC2CJa5aIAbyz+N0Tg1uQDDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQWXl1Lgx5WryT3s//N9oZXwuYKQBj7QyYUv3sssrerHNldEsJKf1InB32A3WVZzJ
	 O2aoZJEHDKdVp2Er7m+Ogm1L74+fRPak2N+7ekm4YGETwoJ0yDu6fRpw/dj4JWnv4h
	 JMlREf5e36ZLNpKtHDTKMqK9bMS9LVEsScsE8janPQxAoUmAopTEnZjSNx5cyhVdL1
	 gfCWCYfTjEkBCaQF3eejqGD4XlrdtSJtz2OXr82G6nllgKZ6lgnUrSerkSYxVq7o8W
	 isjhsNVQdG4vPPxdxXFUtHSjfYZeo1CHkvogwCnbPHf0Fbdx54yuasK5YgOGb3axyp
	 s/jA8aBo0UUhg==
Received: from maru.home (host86-150-50-53.range86-150.btcentralplus.com [86.150.50.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 59D8141477;
	Tue, 08 Sep 2026 16:54:18 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/19] media: ir_toy: Validate the maximum tx carrier
Date: Tue,  8 Sep 2026 16:52:06 +0100
Message-ID: <b4fa892842f279847464e2d4548fe51ed2a0676e.1788882189.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788882189.git.sean@mess.org>
References: <cover.1788882189.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject any carrier the hardware cannot generate. This also fixes
a divide by zero if a carrier of U32_MAX/16 is set.

Fixes: 8bff1386d62d ("media: ir_toy: allow tx carrier to be set")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/ir_toy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/ir_toy.c b/drivers/media/rc/ir_toy.c
index 286c8543aa5a..58b23d08a897 100644
--- a/drivers/media/rc/ir_toy.c
+++ b/drivers/media/rc/ir_toy.c
@@ -372,7 +372,7 @@ static int irtoy_tx_carrier(struct rc_dev *rc, uint32_t carrier)
 	u8 buf[3];
 	int err;
 
-	if (carrier < 11800)
+	if (carrier < 11800 || carrier > 3000000)
 		return -EINVAL;
 
 	buf[0] = 0x06;
-- 
2.55.0

