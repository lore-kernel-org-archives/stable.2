Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039CB42EECE;
	Tue, 16 Jun 2026 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622543; cv=none; b=SkzYNZmQzr9N8h0INtHEiNJbyL7kuhUZuu6+sxsvbfrKkpYd9E/NpM+yHSUJA3j+9l5tedWRV14/NFuqBv7yby5GRXL0iEM2wPP5pSnsQq0XXM1JC8FgIG/6i7W1KUem1OQNBfsEpyfx6DOlk2b9MsfgZISc2DAwNpeGwDzOA80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622543; c=relaxed/simple;
	bh=5NNrZD3y08MLHccCEPac0nOSr3gSQb4NVGbK076rvGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRjTO+kTxQ96PxstTWgPJBS7d6rwkGjC7TBuaMFhnY0hoM53yqQ2nOaEil6cicItK2TIjfnrmCIPvksiWpSr5px6xrUUJRPwqAaNieXuK38SXLXpmJa2DMm6QxAWC7fcn4+/XgNvs17FY+dNvNHjXPyDQehomHLQRzHNaNrTKTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPkfFt4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPkfFt4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAD51F00A3D;
	Tue, 16 Jun 2026 15:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622541;
	bh=iKJW527X2a4DyTxX/3xqnHNqlZ5qhWrmVwqPolgxgiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OPkfFt4KgmzgN4DhuMQCVJn5o7UhWA9RfTeQqzO99cG3zORFg54DXQsFptf6d3gAd
	 JX/tXvvmsSI42Yk5UiWjM2bfzN7kneCYXt2s29WQhXv+sQLvZHlO2YQ1yqUifQZKJ1
	 rAcgOwT42JNSdacCUKE/9zmMLIvTUHjDLw3MdP8msrnSZObqfETfhWfvWXRDi8W3Ff
	 MMFJIhbDs8X55QdPbfZBhVcbOcHowNYHBVIQ6SAMa0pTXcaSDFX3MQ5kAqdCCsm6FP
	 D/WO+G3QBG/imlxXTMP5FqVqO8CespQrCVJg6ryEOUfwSHDOsgY4Xiap6cOPLUN1IV
	 KJR9311dEvrGA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 2 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/9] mm/damon/sysfs-schemes: kobject_del() scheme region dirs
Date: Tue, 16 Jun 2026 08:08:38 -0700
Message-ID: <20260616150844.88305-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616150844.88305-1-sj@kernel.org>
References: <20260616150844.88305-1-sj@kernel.org>
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
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 37cf6edb54f17..bf08e6e1f1635 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -334,6 +334,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
 	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
 		damos_sysfs_region_rm_dirs(r);
 		list_del(&r->list);
+		kobject_del(&r->kobj);
 		kobject_put(&r->kobj);
 		regions->nr_regions--;
 	}
-- 
2.47.3
