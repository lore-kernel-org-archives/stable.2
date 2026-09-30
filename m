Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F636B907
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735654; cv=none; b=M+OZvn80uj3QqDE9CgC7hhrYgsxTXRo73fqjPW7AiSUrBRFyJnmGmk8wYcmBu7V2MUYp4V2jP6MkGqYEjJTxe0C80LX5VBCkcS/iDqAs+pAzSDte5FbhQkdxtj1K7urbubz9wBNQkfOLedksb5z7FevLQdPATRIzRUo9/D6srfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735654; c=relaxed/simple;
	bh=hnEWRSsLdcpq4m8sG+035UD7ndNNV9iD2HF1NAA0hvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vh+op6HVEHpxNBB0xHoRF/78BKyTAGnP+VHsYGCdQaK3fce1u7meY355OmFHCB0cw/J/aYmDY2EHN+MA53ZhV7IArne9Y8FYJ5S7bcn0M7G3qxJ6ITXunJfWgpZxXomQSUTKKbufdNz2w09cNGSa53qtBFVr6KwGEdPF3LpojVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpK82lh6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpK82lh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8391F000FF;
	Wed, 30 Sep 2026 02:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735643;
	bh=FGOq4QJFG7oyMy7trGDTF4BgDJRquHhsZZt2nCxVVhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DpK82lh6YW3erSeEv310AQaZf+oDZENIeC9pMjQTrLYysStxwPMSDifzZDtQZNPzl
	 hDzA6gRNAIoeC5xXCPvtAocO7PsU/VTwuRAC8sypQ1dyB5/MwrNXusvIAU4WFWVtH4
	 WQRdMRKcl5EUwmHzk7lSxjXDPI27hELMupgC271ThdnZ7gRrhd41JzNOgg3wRooi6r
	 7OVBuEhC6zqaMagdRziXlMJMNRoJzerMWETXQsVD5Ykw6oBVNT+okDbJAiF0Vepj+r
	 K3sYgQmXQm9YAVNscVChxjLlTRoXsj4BZF5udYx4Iz8dwfCGTzuueejkbVTEdZ52Zi
	 EA3Z5Y0JPvkkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Enze Li <lienze@kylinos.cn>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] mm/damon/core: fix wasteful CPU calls by skipping non-existent targets
Date: Tue, 29 Sep 2026 22:33:59 -0400
Message-ID: <20260930023401.3420697-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092948-agency-overhand-3fd1@gregkh>
References: <2026092948-agency-overhand-3fd1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Enze Li <lienze@kylinos.cn>

[ Upstream commit 6e4930e33329eec80dd245f28b52202271f5fb28 ]

Currently, DAMON does not proactively clean up invalid monitoring targets
during its runtime.  When some monitored processes exit, DAMON continues
to make the following unnecessary function calls,

  --damon_for_each_target--
  --damon_for_each_region--
      damon_do_apply_schemes
        damos_apply_scheme
          damon_va_apply_scheme
            damos_madvise
              damon_get_mm

it is only in the damon_get_mm() function that it may finally discover the
target no longer exists, which wastes CPU resources.  A simple idea is to
check for the existence of monitoring targets within the
kdamond_need_stop() function and promptly clean up non-existent targets.

However, SJ pointed out that this approach is problematic because the
online commit logic incorrectly uses list indices to update the monitoring
state.  This can lead to data loss if the target list is changed
concurrently.  Meanwhile, SJ suggests checking for target existence at the
damon_for_each_target level, and if a target does not exist, simply skip
it and proceed to the next one.

Link: https://lkml.kernel.org/r/20251210052508.264433-1-lienze@kylinos.cn
Signed-off-by: Enze Li <lienze@kylinos.cn>
Suggested-by: SeongJae Park <sj@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: b3723b596b54 ("mm/damon/core: fix unconditionally skip last region")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 32737cc5f877b..b3a28a857d075 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1749,6 +1749,9 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		return;
 
 	damon_for_each_target(t, c) {
+		if (c->ops.target_valid && c->ops.target_valid(t) == false)
+			continue;
+
 		damon_for_each_region_safe(r, next_r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
-- 
2.53.0

