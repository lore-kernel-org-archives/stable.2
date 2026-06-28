Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857AE3BB101;
	Sun, 28 Jun 2026 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684089; cv=none; b=WGLeZd31kFCwPy9eHUTx7rxlF4oZomQ14Go8zIaAmXYvsX06zX5mxNIOqI8vxJJhPMORgSgi8pGrbBWyTSlLdO+CZr6kLRN+uU/+iBKol09jod3vW+zg6BoWY9KwTA86FO3hinhBdahSS3p8unVij8Sy9B9eGSWfeKLBaT7lJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684089; c=relaxed/simple;
	bh=upBJyS39RUWr55j3xKjAXP/03ORkazJllrduqbcwjw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSpHQhHdlyCVf3kxzYHFcVb6Mw26OTHaGhczsL0qTMTtWwzs5Q3yXN3qhhx1IYfAUnEIMKqyE6ddSKA2/cC7m/VyzpFrzOIWWpAbjx7lKC45Y+wWHYA2dSgJh3McrMSxReDApQLoASJ6xhSHf+G+NXPvK0rstmCRNknl8Ej/las=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw+6fece; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw+6fece"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066BB1F00AC4;
	Sun, 28 Jun 2026 22:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782684087;
	bh=W+pjXniz5l+DZFZ2966T8l+kNK7vBr6GhD9WdjD8DN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jw+6fecewll4uo6ixbSS6RkYQ9bZBwzVt/+bYC6XImXkbcSEoB3JL4YSSMj2ZAtYp
	 bvL0UMqy+Xcy+SBSMuILBkba++Ki129enoePrcGAxAvcZkPiV3xkWUmlBd2S6Pyrql
	 2ZFjaVePg4+YUOQoOc7kLyyY/PtgMRgjbFVxmo/ksMaysMcHJjAqGW9yjEvWnSIC13
	 aUFpUvbiKlcFthRYpI4prcQ3vCnO1JELTsulfXnbBRnEzcqXgGU223a935i2WqKE5b
	 qa08dROb9GhH+Gw4fioo13klEc9sXJxB/H4onGjDcUNTQDHiNtApYVITufgXZGXDvp
	 zb78odzYuF2cA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 3 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/11] mm/damon/sysfs-schemes: kobject_del() scheme filter dirs
Date: Sun, 28 Jun 2026 15:01:14 -0700
Message-ID: <20260628220121.97360-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628220121.97360-1-sj@kernel.org>
References: <20260628220121.97360-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme filter directories by adding kobject_del()
calls.

Fixes: 472e2b70eda6 ("mm/damon/sysfs-schemes: connect filter directory and filters directory")
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 9eb28fe77b5b0..e955fb916a7e2 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -912,8 +912,10 @@ static void damon_sysfs_scheme_filters_rm_dirs(
 	struct damon_sysfs_scheme_filter **filters_arr = filters->filters_arr;
 	int i;
 
-	for (i = 0; i < filters->nr; i++)
+	for (i = 0; i < filters->nr; i++) {
+		kobject_del(&filters_arr[i]->kobj);
 		kobject_put(&filters_arr[i]->kobj);
+	}
 	filters->nr = 0;
 	kfree(filters_arr);
 	filters->filters_arr = NULL;
-- 
2.47.3
