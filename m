Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2813B9D8D;
	Sun, 28 Jun 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684088; cv=none; b=jx5ijCGTlbp1Y37lqnlMOvNlER/j5CoFhefwxED/lWv4Y7cXpWq/mstpA1S7HeHF6WnGRDnPlGh/BRQNQILqGxVEOq1LqDTUoYWGhekRAPdlQD1VH6WCTrx4lrIAeMSOzz3ensWSwahpFixlwJML5LTizPfZv5Bt1UUezw2Oiyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684088; c=relaxed/simple;
	bh=ZnXqNwQn4NOhICKXiLGzWbtrTA7bM+VcKALZyUJC9K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rew8w0+nxLr1v0fvzS5IGW6bWFlhDCgJs/dCADJo0fC6iZ6DglHDW56j1TVePqcKit2fn5DKJyxJei9/om0wgCl8bzQLQlzwmbSALv3nYZWi/7rNEgxE+J0Px9bRoyZ0CjAHt5QGWAL0p3HYTckamXSNFO8T+PIbBuFvePGP1As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8fNx9yh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8fNx9yh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F791F00ACA;
	Sun, 28 Jun 2026 22:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782684086;
	bh=OLnT+m7jG25ig3bUBCku5CL8OxagQ/I+mp73IyUAGbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k8fNx9yh4m8RKU4k+e7B4NxvXXng6Q4+c/r0GzRqXQOlDmd2tVJKsG/wnkV1tnYrX
	 Tj4EQ2QqE2MX8/iTZcKoaMwq7xVT+YEejajrWHdbqGchHdOoAOW1XXQxtY9x9cRydY
	 jGYtB/CmiCgkstBQUiV0o19rEacJPUqrZdEBk792caHhu+GlrYSNxkBmmDZfdlgXKq
	 7YFOhaMToUe07EZOXnyqlThz7fToCed3wSW0cvqxqJm7/5JUkFtwVlZEDaTePz0rir
	 SNitKVgXeJixCodp2JlRDEvpkAeEbdl1EDLO1LEKfwQhQhcIBznf6IxdQlOr673+Kw
	 JnobUstpcbTqg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 2 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/11] mm/damon/sysfs-schemes: kobject_del() scheme region dirs
Date: Sun, 28 Jun 2026 15:01:13 -0700
Message-ID: <20260628220121.97360-5-sj@kernel.org>
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
those issues for scheme region directories by adding kobject_del()
calls.

This issue was discovered [1] by Sashiko, though its analysis was
partially incorrect.

[1] https://lore.kernel.org/20260517205828.6204-1-sj@kernel.org

Fixes: 9277d0367ba1 ("mm/damon/sysfs-schemes: implement scheme region directory")
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index db496d2e493a4..9eb28fe77b5b0 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -332,6 +332,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
 	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
 		damos_sysfs_region_rm_dirs(r);
 		list_del(&r->list);
+		kobject_del(&r->kobj);
 		kobject_put(&r->kobj);
 		regions->nr_regions--;
 	}
-- 
2.47.3
