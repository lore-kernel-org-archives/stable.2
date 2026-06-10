Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428F235BE2;
	Wed, 10 Jun 2026 01:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054071; cv=none; b=rSDNYAsseEqqxGYtCkOov0qNzeuVX+zGt9+d2XFzw2fFVqlIgG59DYl+HMbCpDMC4YTnyagdYzfkNZn216OiTo6H8zgkNx18sRVr/yNWsM+HrnUCLkthptZyEk9E7NJE9Ok20yapLLOtCWQ82F64ooQ7tsLO2M2P4wE6gluVoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054071; c=relaxed/simple;
	bh=enbigSKfZhHs55sFswY1ofWl2WsfR5xtqPL9/la+0Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7ctsfTB5qN1BQw/0tZzhRF/Aw5QPF12bofDShOPQpbEvo+O3hhY7hYjKlRwL8et+NCBNMJwXDNFTwNXfqBx3Ad1BJ+0TSBI6UiVACDu6wvRuTlw8MUgRIUPeaFqEtoHMT9hZU1G61Ys1NzH5PmR6D4f6o9IIH8i8iPJEa2Gw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO6bucwx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO6bucwx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE111F00898;
	Wed, 10 Jun 2026 01:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781054070;
	bh=wvTmgzWVeo+cgK/5Fasuy9LNL6Vq1lM40f7iFKommVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OO6bucwx7vW5YEMf9brXc184EBcBckfFxzpfLJAKindDpNCCAwVjQ5kCkNUKTngNT
	 NYxpjaSP1wymrtUvspJt+VwOlKLkkwDHT/plNs6NdxModjlMUBqYw2oLgNmWI2wN/i
	 /9xxWMxiTCvyFRyco5xuNRQdpEpcWCPLvyIBbOO7KwEEE9OJbMcT/slewHi3pW3gzp
	 x9PiEr42PNnPLaQDesMQGjajOY4DkPEYqGwp4lOk+aFqdZhLVI1kZePVCwIAoRhQR3
	 qeLMcTkcOQCN2BulCCYNgKxweIxiDiwqjzzTMtEM9+IynkbPMr7BPLsiezp/SDapfY
	 9LqourOYK8NdQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 4/4] samples/damon/mtier: handle damon_stop() failure
Date: Tue,  9 Jun 2026 18:14:17 -0700
Message-ID: <20260610011420.3018-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610011420.3018-1-sj@kernel.org>
References: <20260610011420.3018-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sample_mtier_stop() assumes its damon_stop() call will always
successfully stops the two DAMON contexts.  Hence it deallocates the two
DAMON contexts after the damon_stop() call.  However, if a given context
is already stopped, damon_stop() fails and returns an error while
letting the DAMON contexts that have not yet stopped keep running.  This
kind of unexpected early DAMON context stops could happen due to memory
allocation failures in kdamond_fn().  Because damon_sample_mtier_stop()
just deallocates all DAMON contexts with damon_target and damon_region
objects that are linked to the contexts, the execution of the unstopped
DAMON context (kdamond) ends up using the memory that freed
(use-after-free).  Fix the issue by separating the damon_stop() to be
invoked per context.

Note that DAMON_SYSFS also allows multiple DAMON contexts execution.
But, it calls damon_stop() for each context one by one.  Hence this
issue is only in mtier.

For the long term, it would be better to refactor damon_stop() to always
ensure stopping all contexts regardless of the failures in the middle.
Make this fix in the current way, though, to keep it simple and easy to
backport.  I will do the refactoring later.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260609014219.3013-1-sj@kernel.org

Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/mtier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 66b591f2180fa..faaaaa12e6206 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -199,7 +199,8 @@ static int damon_sample_mtier_start(void)
 
 static void damon_sample_mtier_stop(void)
 {
-	damon_stop(ctxs, 2);
+	damon_stop(ctxs, 1);
+	damon_stop(&ctxs[1], 1);
 	damon_destroy_ctx(ctxs[0]);
 	damon_destroy_ctx(ctxs[1]);
 }
-- 
2.47.3
