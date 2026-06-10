Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44CD408017;
	Wed, 10 Jun 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099757; cv=none; b=Xi94UZID/b8xZL297L+ni/fZA5gzFSQsBtZ1VZ27j/phAYCMZUVGete5iKkq3UB3KRivbuBIM/8BmW8L0aJgp1qOVnb2k5Hjt6FOMOWMpTFdu7aRe4l0LytxMYaUlm8r63FkFTpaE2IVVCp1OiOuYi8KzPjsNIIxxVyNrRZxqxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099757; c=relaxed/simple;
	bh=+DWarB0QpQ9bFNyB+0gAPgMonXqPezkYcU0OEhN0pL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IP9pr/orMM9CiTony2MrXpcG4DOJPxbVAHa0Lt/1K0ZeSa+l59cQ4W59YTPNOVnh3OXELCjlhrcvus/LPqyjJHkQLVKnwrNKHF/FOVt+psQsUS6iAvwYcyViDVmP7t3mePUbBna711YZ7uAKRw95t/ZOkIpbKTwLT001vUNm2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+zDJeAX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+zDJeAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7182D1F00898;
	Wed, 10 Jun 2026 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099756;
	bh=4hjcTwQxd/8erExTfvC7SkLcmq65ZXVC4ot5zMsJvgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+zDJeAX16PIJTzegEmKXOzPV+ZU+53OT9UdbEUPBfJ/BEL9l9BGSEzKUTIYKqhI4
	 Z+QoOF8JepWNqz14VvgNcYqD6dFBFP7WZ4ytnVw27KVou5HvGVrav+KDqJ5XpX5PbG
	 jWLOZlFrf84pQ28rza4TgcxHWDsEGIdBW6HM3aqpYiocn4L8oAFqzGyYV9AUx06eWh
	 9zXfZ2TIZGiQjMB78wLIrPtrFMjyLHt1+p1wtabKoeneEN2F2Kz3zAMiQ2P28bKjuK
	 Flmf3ub2XiNKPhZZHeGzEEK8r81oI6WICJa7qw21OREgOYttMRsLDoip+zsYjKWHvE
	 PZ2+eX8ZHXrRQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 2/6] samples/damon/prcl: handle damon_start() failure
Date: Wed, 10 Jun 2026 06:55:40 -0700
Message-ID: <20260610135546.64943-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610135546.64943-1-sj@kernel.org>
References: <20260610135546.64943-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sample_prcl_start() callers assume it will clean up resources when
it fails.  And the function does the cleanup for context buildup
failures.  However, it is not doing the cleanup for damon_start()
failure.  As a result, when damon_start() fails, it leaks the memory for
DAMON context.  Free the context in case of the failure to fix the
issues.

Note that the issue can reliably be reproduced because the module calls
damon_start() in the exclusive mode.  For example,

    $ sudo damo start
    $ echo $$ | sudo tee /sys/module/damon_sample_prcl/parameters/target_pid
    $ echo Y | sudo tee /sys/module/damon_sample_prcl/parameters/enabled
    $ sudo cat /proc/allocinfo | grep damon_new_ctx

Because the first command is running another DAMON instance, the third
command fails the damon_start() call because the new DAMON instance
cannot exclusively run.  And without this fix, by repeating the third
and the fourth commands above, we can show the memory consumption is
only increasing due to the leaks.  It requires the sudo permission
though.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260609145814.70163-1-sj@kernel.org

Fixes: 2aca254620a8 ("samples/damon: introduce a skeleton of a smaple DAMON module for proactive reclamation")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/prcl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index b7c50f2656ce7..0db2598946911 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -106,8 +106,10 @@ static int damon_sample_prcl_start(void)
 	damon_set_schemes(ctx, &scheme, 1);
 
 	err = damon_start(&ctx, 1, true);
-	if (err)
+	if (err) {
+		damon_destroy_ctx(ctx);
 		return err;
+	}
 
 	repeat_call_control.data = ctx;
 	return damon_call(ctx, &repeat_call_control);
-- 
2.47.3
