Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161587;
	b=nTGGj7x/CHfd9ajTG7Z8nCPzjCn/C0neN2p4EMpc9xgV29/VyhM8vKQ9Yc7yBfyB/SRV
	 j3qLMdu78LGIMmB5qZN8vB6i7lmPqmlxZe3z9fEddyZaUtW2lpCkubsZQeZvN2ok6El7Z
	 Vi6hRi6g+aNiRvsDOJfaiXiONYh9LvsEoad75sZO+qnF8ms70jx8dKnCGAmWjj7/gQXZS
	 gxNIYmtAi1X60hr2g5cUKQa/uQJrjhuv8eQYv6wFJVF9Ynl7IOUL385Q+Y3iUbEVQDhuT
	 CpnR7AI8uyUBW2QgpT08vg+rYuiYRY52wsHgyYb7ghChmwqLqCuI4mem7yBWDobM0+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161587;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Aj6NKlEI/katth2wIESymczEJETsapNVp1gfTJSIOI4=;
	b=OP7PVntIhVgQ3venotdtQfsSlT6U19OHEQEgc7Uugxe0ER8/J5IGlEf43ZUjrPlIfr1X
	 3oJK1ke+YrU4gqRPg/dxfSrt6BGMcW7wcYOcgLzeyUXzKLh9PzFC9P6jsNBLmqkYfv3Xn
	 0a6QelnMrr1tigZBh5MnRcHEfwYegTAf0vWvaiX8dnNxEY48QkwvgQcMj0JlGrOkuNLp1
	 vTx8aEN2XNWwSlp2oCN/Y0TWBU1J8q+/WVW/mCzUHsWrtbt4VRKZujsaIor0+HwnrwvX1
	 ENDcKCxt0cDt0cLL1mIYnmXEQB8+N/GgYMwQdPJhBzoRGWPeV8/Auwq7orlyXfitoTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgXk7PPo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD99606A320;
	Wed, 28 Oct 2026 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgXk7PPo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABE91F01828;
	Wed, 28 Oct 2026 04:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793161586;
	bh=Aj6NKlEI/katth2wIESymczEJETsapNVp1gfTJSIOI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NgXk7PPolNc+ddHxBHO/mgGAh/tBkeEgp7YT5J9iFXmFKrlhUo5ziqe/cumMyS4UU
	 h30NzbZc4IPcrQtD7B8w55ovJ+z3txhs0Jc+JGEakv8zX/UTYUA6/Awk3Bl9n0N1x8
	 0jg00kzDIlKlUlZnIi7uAYmONdjHRoEOwEqYIjA34rMGSTXMXCXBycFAUV7FPhc/9w
	 mLxjE+NIK1JW0iEa6hGEAfBlwVi8VM/TtUm4YYhVcx3z4k6FdVu1tmORu0d6530YUv
	 bulZbgwlSTAsX6ZbY5y54DaaBrejmA7iBOilYF+ujZOQin1o9iK6+6ni5Q0pPSuvbE
	 z8oMaSrSmcHUQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.12.y 1/2] mm/damon/sysfs: put target pids for damon_start() failure
Date: Tue, 27 Oct 2026 21:26:14 -0700
Message-ID: <20261028042617.165657-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028042617.165657-1-sj@kernel.org>
References: <20261028042617.165657-1-sj@kernel.org>
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

damon_sysfs_turn_damon_on() allocates and sets up damon_ctx to start.
If it is for virtual address space monitoring, the setup increases the
reference counts of the target pids.  After the setup, the function
invokes damon_start().  If damon_start() fails, it deallocates the
damon_ctx object without decreasing the reference counts of target pids.
As a result, pids can be leaked.

Fix the leak by putting pids using damon_sysfs_destroy_targets() before
deallocating the damon_ctx object.

Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 5aa23c6545cb8..107a28557afe2 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1519,6 +1519,7 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 		return PTR_ERR(ctx);
 	err = damon_start(&ctx, 1, false);
 	if (err) {
+		damon_sysfs_destroy_targets(ctx);
 		damon_destroy_ctx(ctx);
 		return err;
 	}
-- 
2.47.3
