Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D32F1FDF;
	Wed, 17 Jun 2026 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707721; cv=none; b=eA5Ai3Kzsf1ItIQWfujL7UZYIq7kKBiei2PU6CStSb+eLyYLOvmtK+0JZaZJcn1V0oNAgOKzVCzQcywI2szsm4pOSvSRzJhz4AqZP7MxMxt3aMzP6N7HzHYD2St1PsTz/OTGGZWmY1HNpvor/xHqkDrkyjY4oIjWBiCkgOn6xxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707721; c=relaxed/simple;
	bh=EgtPrbPPj4evdAKWXpQqc5q3fphFHpFUB+kARdSSrq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrHqnvx2os2klYSEkUGXNjnRZffyYaJD8gsCnEHRGhPosLcEXeDh5N9Jav2UW15HbTyCcygZwqxISIIMbpblHpg2QdzlWY858zV+EoBzbsiUk4mYNrjOBXq0ODtolZylt3FYIdicxPMnayAwMjdiBHhAR7vHD8Z8aicXKHiPU4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC0czx2A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC0czx2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03C81F00A3A;
	Wed, 17 Jun 2026 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707720;
	bh=5tsHNLiRHrT2fupCfklpoPqgBkd/OIiPYVnZdcCqxSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aC0czx2A3MwkvRVQ7VpYXqVxqoI8ifrDMm+sVwCpSzdvI2FdtYshbvNU1RwPKccuF
	 /EE3964iMLCQ8ssThuyN2kAQB4fDSNd5Yf5GfIAqiDRpZKMo8vekE2Ld0ObhoE7yNM
	 5ZHEA85xNdoaqTuHhCz1q0vfpSZuYPihSwF6DcGJZdzya9C/x5S56XnrKpenW4SmSY
	 R9+eBv2TFDhBKZEVzzqsqa0ozWpxBR/BUO04hlBluxDRAJIuLRFiIzDNrlm3FXcKtn
	 gP2S42GBO3Ba/RUiG69k16UOfmUuQXJZpfroQcSGYw45ol9fyF02IwOYBIhBiC5913
	 qpYh2OaTWzwiw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 3 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 05/11] mm/damon/sysfs-schemes: kobject_del() scheme filter dirs
Date: Wed, 17 Jun 2026 07:47:59 -0700
Message-ID: <20260617144807.91441-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617144807.91441-1-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
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
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 604b77a47a463..db6226c05b023 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -914,8 +914,10 @@ static void damon_sysfs_scheme_filters_rm_dirs(
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
