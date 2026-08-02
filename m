Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2FD38F624;
	Sun,  2 Aug 2026 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785687657; cv=none; b=YUdd0NjQuQHZg9oDkomH0F39gGcNav3VCQACihR85Ym2/X8tNLZ7Hb2L0g/LTDF2suAURCwmbRrD4/QY9krQCkM38n0qXkShyCZGoz+Mbr2oXFVv0jCL32H1JesuBU7XiJNaF77XyzbUF0jBeGCGanJhaHQk44YWao1sF7X2suc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785687657; c=relaxed/simple;
	bh=pT+muvkgd8dj3wxs8gC3+KsYxNu/Gu3J6uacElnJezY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXKBUpifl6e5eCWrLuQA0o7fXF6rf/71Q0fqXweDpI/MIo6E8Z4k4mp3ZUi7zF0T+lIDu0O1fJFmANNiWh+VvnI3TnTv+EwLs7t7/Hqk4jq1RWsVaJnRVFp0x0zGoHg69dpipYOy8KbRtHhxfYJY414i7+FR0nRhPwRBi3kYrEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSq0UYct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSq0UYct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533861F00A3D;
	Sun,  2 Aug 2026 16:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785687656;
	bh=jjY62t0IWaBhzTuKFbAdxLlz/gg8XTsDxaNCLSSWaXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TSq0UYct4CsaLWaMcHePVWRxZ9TID5ACYmfWlfMlJRaKzXP6iN+dtu3Ddk8ksPpgF
	 591qY0pyf6QPHkLh08YiqZb2g9xJMsp199h7NLKnFqIG3nF1z92suMOM39BDiiHqlI
	 5sok9cvQifjsOQ1QW4EB2MV19BgAjTZlRSBXBDYWuZeChcdTDtWGwm8C5piKuTPs7Q
	 v9vQEymECJvEOs5vCs+mru1znHuFQEZuoGC5RqIVjYrP90EKe1lhXyfRcAdbuDNzXP
	 Wgbh/kRB31e6ECaEL5ckR+pcqgpq+8I4qpEqThvdEjvHV5iPjSPerXuj/wt00X3/ga
	 qj+FLomyNI8pQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 1/2] samples/damon/mtier: error out for zero quota goal target values
Date: Sun,  2 Aug 2026 09:20:48 -0700
Message-ID: <20260802162050.89477-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802162050.89477-1-sj@kernel.org>
References: <20260802162050.89477-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_quota_score() can trigger division by zero if the target_value is
zero.  DAMON_SAMPLE_MTIER lets users set the target_value via
node0_mem_{used,free}_bp parameters.  It doesn't guard zero value case,
though.  As a result, users can trigger division by zero.  Fix the issue
by returning an error when the user tries to start DAMON with zero
node0_mem_{used,free}_bp parameter values.

DAMON_SAMPLE_MTIER is just a sample module, but the consequence is quite
bad.  Also the zero node0_mem_free_bp parameter might look like a
reasonable setup to some users.  Hence, the issue might really happen in
the real world.

One reliable way to reproduce the issue is like below:

    # cd /sys/module/damon_sample_mtier/parameters
    # echo 4096 > node0_start_addr
    # echo 8192 > node0_end_addr
    # echo 8192 > node1_start_addr
    # echo 81920 > node1_end_addr
    # echo 0 > node0_mem_free_bp
    # echo Y > enabled
    # dmesg -w
    [...]
    [18792.235916] Oops: divide error: 0000 [#1] SMP NOPTI
    [...]
    [18792.242787] RIP: 0010:damos_quota_score+0x6f/0x480
    [...]

This issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260801202657.117135-1-sj@kernel.org

Fixes: c5e67d40a102 ("samples/damon/mtier: add parameters for node0 memory usage")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/mtier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index ac9c24b92ead8..d1123ebbfab90 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -156,6 +156,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	if (!scheme)
 		goto free_out;
 	damon_set_schemes(ctx, &scheme, 1);
+	/* zero target value causes division by zero in damos_quota_store() */
+	if (!node0_mem_used_bp || !node0_mem_free_bp)
+		goto free_out;
 	quota_goal = damos_new_quota_goal(
 			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
 			DAMOS_QUOTA_NODE_MEM_FREE_BP,
-- 
2.47.3
