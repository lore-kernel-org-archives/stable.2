Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196879;
	b=42bnvFr+87l81eZkQmw0Kr0yGNgi7lXgexNtGcgRNiqjYIRGH+T8IITDPNokbt4MUXLp
	 hcrTTlgjkPd8M1UXT54UOBKo/uGZmQSx1Gs9YGYOLsPO8TmlVDJNRATtUYCSnZ2hWyI+W
	 h+nSwiOfbSOWkwNs+hY6uEp3k6AKF9zn8zf+PPwPVPGyr2EE+SoN4dI964PYkY8K7LOCc
	 TkXYKRdEXwZUYvMIHnELVTkVyqNQ60PJIi0/jc+DT04Zf3KslUcjbFAGYKh1kixPoIMaa
	 XNAQxQYAbMcrbrIlahEJTINovPJ1bDxg0nar4aT8s+6vCa+O/YuX5nSUs4wzlRTrvcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196879;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cnCdwdKLIRu22zpmh++d3j4s9fK6gxqvvFFUcjcNhTE=;
	b=DnyaeogI/CUFhAsEcHTBat1s30aYRXJsSXC+Km4KbctFHpVO1ykbvNeHXorI4yBNz+9r
	 9kDaycebuaiupimkKZXAobFn0RSB3xbpHVDFS1M3rKEA5VjZaK6vz8yQ7nLvO2IUKTPIv
	 M7Zxt1tbRrGYAw1z4a4TxYemiDZbf8v4lucHn5q6WDm0hWp0cuq3UTHbIriWUeywhxlKC
	 LuRiOtNis0fhmZPq8dushF7MKBNpq/ihSpY/gIv7OIkWqqxGiIMexk35TcRG1GdAB8Vkn
	 J1mmFuiXpBdti3qrUA06ro8Zce60zlSagE3hed9LMjFOpBqaV1FDmndUu7P3+0LpBAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KosHCLT5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED9606A324;
	Wed, 28 Oct 2026 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KosHCLT5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932B51F01829;
	Wed, 28 Oct 2026 14:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196878;
	bh=cnCdwdKLIRu22zpmh++d3j4s9fK6gxqvvFFUcjcNhTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KosHCLT5ErruhKe9FgBcT2mZujTeztnBTMNCB4vnxJIjLTsYHk8+JPnZiaqT8/cSf
	 9DySpe1g1xW4cGc9NhHvflNowtkA0HOExbqWV0bpUZI3s+HWCFsHbnFaX7weUtGy8k
	 dve+RBKTVpjWkwYqA4aPjfYfF/0Zcjkp5Nwo40xN7cO3a8P6v1MbqbckdCNYD1Jm66
	 ZZgOhU0/P00hwbxR6D1pnxghjYjBWvDjmluZQlj/GMrfD8/PbOLN57vX1zeIJhpTzw
	 ArLeOD+R57Pth+QWnwIFqwCRzEDEIiVn77tWjria5tRl8ZeGfIvULj3sQ98yopmquh
	 T2iDSA6YJ97EQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.6.y 2/2] mm/damon/sysfs: put target pids for apply_inputs() failure
Date: Wed, 28 Oct 2026 07:14:29 -0700
Message-ID: <20261028141430.161175-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028141430.161175-1-sj@kernel.org>
References: <20261028141430.161175-1-sj@kernel.org>
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

damon_sysfs_build_ctx() invokes damon_sysfs_apply_inputs() for setting
damon_ctx object with user inputs.  If it is configured for virtual
address spaces monitoring, the setup also increases reference counts of
monitoring target pids.  If the setup is failed, damon_sysfs_build_ctx()
deallocates the damon_ctx object without decreasing the reference counts
of the pids.  If the failure happened after increasing reference counts
of pids, the pids can be leaked.

Fix the leaks by decreasing the pid reference counts before deallocating
the damon_ctx object.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260730040740.140836-1-sj@kernel.org

Fixes: 74bd8b7d2f8e ("mm/damon/sysfs: move targets setup code to a separated function")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index d95fda1054a00..f830b873d05fc 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1433,6 +1433,7 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 
 	err = damon_sysfs_apply_inputs(ctx, sys_ctx);
 	if (err) {
+		damon_sysfs_destroy_targets(ctx);
 		damon_destroy_ctx(ctx);
 		return ERR_PTR(err);
 	}
-- 
2.47.3
