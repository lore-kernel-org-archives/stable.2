Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32923BBA0D;
	Sun, 28 Jun 2026 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684090; cv=none; b=H2A2+n1Zi+Kc4tDLafYQErBbiRPIh63wGujF2NGy8O8GV9t1Dgr7vMZGxqPqn9WSGQRpdMXKmsssJYvz8cXybtu/usMfDR24yLZU9+W3k029+/BgiFsgUZnVoU5XFjEYof8nqVMSQyHp34txzfFSSvJ29euzzKnd0IIbEivtJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684090; c=relaxed/simple;
	bh=sNEKbjhqCfsKkTy6T8V9VU8DI87pDLMkitRMt2AtMRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmGlAw/94sOActwanTnMi2dAinQ5ipnbxG43rn2ES/GBLJrrxxh7qE87y9fd/6EP8J5fqrCLpFj5t3Eak1WdJ2PfRDUyJz5AoManB35+9ATHaNVkKxE+m52et4OX6bfQDtgwiZQuZe2QGD5IebIpElaQOqQJMIbtepSUzB16fVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHH0LRSL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHH0LRSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8981F00A3F;
	Sun, 28 Jun 2026 22:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782684088;
	bh=yM5zo/CZPKVrarzYTBC5EA96PqDEgGYSVEKgph4Q9eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IHH0LRSLcIQn0D4V9+fdvYi9AvAbxtJflJx8rFZFuuCGRovVMG6GZnvMk2LtGeSUu
	 m2hFV0MHLisuUr3GoLz5AisoZjOcg0piidbvHU1Kd9Hgu0EindFq/ab/2f8zFnve2W
	 0q8rDWbUtz8FRsv8/B6T5WlxVMLEPZaGml4zvj9ulC433P12wCGwJEkKSDyRoHqn1r
	 kRzEQP+2MZju/eegtFjlcE6cvwAJmUEKEvvtXf8iM/v5YnGfBUkG48ZvhDyYe1L242
	 MSwnxlH9foLvpnwPx+HzJkfGy4LGWMBEqLIvhOC0uQ8MUp9pimzQHbpXe5NCszWGqV
	 EaNG9KNddd6iw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/11] mm/damon/sysfs-schemes: kobject_del() scheme action destination dirs
Date: Sun, 28 Jun 2026 15:01:16 -0700
Message-ID: <20260628220121.97360-8-sj@kernel.org>
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
those issues for scheme action destination directories by adding
kobject_del() calls.

Fixes: 2cd0bf85a203 ("mm/damon/sysfs-schemes: implement DAMOS action destinations directory")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 58051185713cf..e2c8716be6c9c 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2143,8 +2143,10 @@ static void damos_sysfs_dests_rm_dirs(
 	struct damos_sysfs_dest **dests_arr = dests->dests_arr;
 	int i;
 
-	for (i = 0; i < dests->nr; i++)
+	for (i = 0; i < dests->nr; i++) {
+		kobject_del(&dests_arr[i]->kobj);
 		kobject_put(&dests_arr[i]->kobj);
+	}
 	dests->nr = 0;
 	kfree(dests_arr);
 	dests->dests_arr = NULL;
-- 
2.47.3
