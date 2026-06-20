Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A10233932;
	Sat, 20 Jun 2026 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975670; cv=none; b=pi/KqUQfN8osbVoXz4dR+KfS/0NYqQcRfI5CVTxlASZ3oq0IQmlvT9um2Min9QK0o0UyZb3WMcQIsPfa/vncOVhK/40E0ipllI1YaB/Ng17ROpvLTsXhhLPugajb5S9y1VD0MV48+TTPD9gBI1yWufI2Fl0LAdjbuwM8khx+WkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975670; c=relaxed/simple;
	bh=DkVmf9s8+C20fkMT6Fl/M3tchkl0qQA5hzUeAGZ//rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQn/nnvtsO6AiCNRk7zm3WmAe3ro24Yv7vYF2VvhvzlQ5fCyvgJXC1MS/JckvGI4wQZVHSLgEZGPAU+TRTL4ECG91uMKdVve6fzkGzxHYIWkhcmzE7+YBs7WjTXxoFVG1fvZK4eBVcyOq/wofykt8uL/E1njy0YSLnq55WlE6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klcEEeG5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klcEEeG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B1B1F000E9;
	Sat, 20 Jun 2026 17:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975668;
	bh=a6OOm5mIlaO4OHi3hOERfzN/vc5dfThAoOyHWEebZLc=;
	h=From:To:Cc:Subject:Date;
	b=klcEEeG5r26a752OnGHWbItqLU1kKKo46ac8VLwBGsFHh4YmfAP4a9hs3sNU1/D0W
	 6mrdpuhP7/fsUJRbDiyLfUw7Nd0McK5X6oSG92ohLLEwJQW0KvJE7nNA2RPxZPKKto
	 hBXzW7FlMVEnDmZyJatR5w1zD7cuecdayNSZ+yByNCElJFzudbZq2AuUIr1DluRMFn
	 pAdn5vGiJ1rZzu2G3WU/rT717w9D5dn4qaUYA1QVDS7R8ilTM7RhKw1K+iZrcCNDJy
	 6XGsDDxcvGusUf6ecl1W7tI6H4wnxf7NtAkDScQDOb9x3g5o88/TelXd3b+qt09XvQ
	 GTDiBkfHgY/Yg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1] mm/damon/core: handle zero intervals in damon_max_nr_accesses()
Date: Sat, 20 Jun 2026 10:14:12 -0700
Message-ID: <20260620171413.89555-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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
nr_acceses in the setup should be one.  Worse yet, it can causes another
divide-by-zero from its caller, damon_hot_score(), since it uses
damon_max_nr_accesses() return value as a denominator.

Fix the problem by setting the denominator in the function as 1 when the
sampling interval is zero.  Also ensure the return value is always 1 or
greater.

The issue was dicovered [1] by Sashiko.

[1] https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org

Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC v1
- rfc v1: https://lore.kernel.org/20260619205144.150664-1-sj@kernel.org
- Handle zero aggr_interval case.

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
 
 

base-commit: 7a58ae62cdf3c006a53b805bbb12079ab2621a07
-- 
2.47.3
