Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694413B8130;
	Mon, 22 Jun 2026 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782137443; cv=none; b=P8neE0xOr9NakfyHHnOW7ICB1RyogFWpO+B6vSQRSkvvatJoy/IAtgbV5DTlML9rztoq7oQATnsY5mm4l3/JpihRmNZuzx2KuDxR5XwMfXuo1/mOTz+4l/uFumO+ru0ZnZotXhPwLv4kaRCWzXgYkKNrtnlMLi+F9KPR96wZGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782137443; c=relaxed/simple;
	bh=ASc03vv1Eh36xeJlK+ZfY6FYf9/rtydiu49McFLCPvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqEQKsBTXLu8uGaDQjvBIBS1i6M62TxADCp8vHcRwDqHtSszuMMaAUmEFCjGTXiID7BjAo/IwokLkWHxQp6mrJUyr1xSYTEm7wLnUGaeVDZOVK8H+ohOhdsGflMSR852z/p+RJl8ZvG3foyZg2Aluzp0UDNaf0s4DZMZ0YYUsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHa0UaAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHa0UaAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666101F00A3A;
	Mon, 22 Jun 2026 14:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782137442;
	bh=GYfS+/BMt2alhv0ov5ohTbg1BBH0UkT3aXDJtkvAQwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RHa0UaAVPETqYGAj1f2w9QCVcoQ0v3iwH8D7S44GHnF2xZzYLokpnnGdE7u6HbC4u
	 ASd2gfW2bVw2bQz19NKhIyZaMXoRVY0rE60pmarGHG97qkNfw+l58B6KaJm4Qg4d01
	 kGN8DTxgm+y6FOEkBW+r36X9oKyNo7I0Bp4Men2vD1s3T5hBIA7FHicepRpHEKWlLn
	 gaPB0T6fCi4a9vfB5F2onDPJfvg7kFGrFvRaZX4IB7c8YfPNfqONlKmUHLaqBZ/dCo
	 FooHO1Ob0de/jvzGr/49NyJy15U6ieMa7onZ4Fuf3yNtQQM46HWSnJkmsZtaL+cHzz
	 6q/pg89fzn3PQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 1/2] mm/damon/core: handle zero intervals in damon_max_nr_accesses()
Date: Mon, 22 Jun 2026 07:10:24 -0700
Message-ID: <20260622141027.29145-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622141027.29145-1-sj@kernel.org>
References: <20260622141027.29145-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_max_nr_accesses() causes a divide-by-zero if the sampling interval
is set to zero by the user.  If the aggregation interval is set to zero,
the function returns zero.  It is wrong, since the real maximum
nr_acceses in the setup should be one.  Worse yet, it can cause another
divide-by-zero from its caller, damon_hot_score(), since it uses
damon_max_nr_accesses() return value as a denominator.

Fix the problem by setting the denominator in the function as 1 when the
sampling interval is zero.  Also ensure the return value is always 1 or
greater.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org

Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 64d75c78f4df4..02ac34537df9a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1066,9 +1066,13 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 
 static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
 {
-	/* {aggr,sample}_interval are unsigned long, hence could overflow */
-	return min(attrs->aggr_interval / attrs->sample_interval,
+	unsigned long sample_interval;
+	unsigned long max_nr_accesses;
+
+	sample_interval = attrs->sample_interval ? : 1;
+	max_nr_accesses = min(attrs->aggr_interval / sample_interval,
 			(unsigned long)UINT_MAX);
+	return max_nr_accesses ? : 1;
 }
 
 
-- 
2.47.3
