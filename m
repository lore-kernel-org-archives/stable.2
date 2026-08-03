Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C53435ED7;
	Mon,  3 Aug 2026 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764815; cv=none; b=NpXQkLBH8sChuCimHfkH9XDQnapRA1ebc8e3iD308pWrx1Qzb2AULrMKFy7z4v2QFnmIppCVOKEifv1h+6kLVxXyjp8pdMJ8gw2GKBojc2tSkg4zvK6k1lwj2QQsqB5L6ulDYwENS5AB2v4oN7AxtnKjKBn+z1UHfp93GD9z6+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764815; c=relaxed/simple;
	bh=7kchgOt0aA7MxTKa0Tj69FFDy3D3f9dhvNB5JTY3Pq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vn2RQddKgsseeTd31MIz1UbDwm+LZZuVyEPTDm3/JI6M2W3Y4IlpYUZ9NK5i6Me+WesDHvpPa5WcKZKH4YXh7VqD3MVqPOaYTw+gJA6koMAKH2QCI/VBK0/QZ+3MSU0dXYftVFMooz42SmWAxXQYwbJiyBLoY+uidtDcfKnNeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeG3cNcH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeG3cNcH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DC11F000E9;
	Mon,  3 Aug 2026 13:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785764814;
	bh=ew/a4uW6pk7X4wPVJ5ylrhLZPDJztc2+7Q2+2wvo0Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TeG3cNcHOjyt6NbpX4mE3HPN+FD+an3SSYMhvuOsNiMqZPW4KK7yoPI0W4OQ+eC7N
	 5XCwzOi/7y+ajoEAImKnYlIpWADWhvifrq5NDBrrgI+jandWKDWDc3AOI1A3yY4a65
	 quZkudi1QMxxttmiJ1uUyJQEGkvLBxv2jJXmwX2iZdJTSSGIrklPsS2ZqYw+uFiadQ
	 u/oPjDZjlA47hYKBlwrjf5bzV6buhhWTmYdztde3pW6QG8Gm3Pg/ctuF1oEBQ79p99
	 dVAzP556DHp8BxRubKsEjRXgjRjgQZU2pWbgOwaW4xD+L67udYgXne7MeaWPR3aFRN
	 oNAa82ZsQLang==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon/reclaim: skip damon_call() if ctx has not started
Date: Mon,  3 Aug 2026 06:46:44 -0700
Message-ID: <20260803134646.16640-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803134646.16640-1-sj@kernel.org>
References: <20260803134646.16640-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM calls damon_call() for commit_inputs parameter user input
if the DAMON context is initialized.  The context could be initialized,
but not yet successfully started.  In the case, damon_call() could
indefinitely hang.  Read the comment on damon_call() for more detail.
Fix the problem by memorizing if the DAMON context has ever successfully
started, and skip damon_call() if it has not.

This issue can easily be reproduced by writing Y to commit_inputs on a
system that DAMON_RECLAIM was not turned on before.

Fixes: de3c60e1c831 ("mm/damon: add synchronous commit for commit_inputs")
Cc: <stable@vger.kernel.org> # 7.2.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 09e941d75f67d..45d5557cc575a 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -271,6 +271,8 @@ static int damon_reclaim_commit_inputs_fn(void *arg)
 	return damon_reclaim_apply_parameters();
 }
 
+static bool damon_reclaim_damon_has_started;
+
 static int damon_reclaim_commit_inputs_store(const char *val,
 					     const struct kernel_param *kp)
 {
@@ -291,11 +293,8 @@ static int damon_reclaim_commit_inputs_store(const char *val,
 	if (!commit_inputs_request)
 		return 0;
 
-	/*
-	 * Skip damon_call() if ctx is not initialized to avoid
-	 * NULL pointer dereference.
-	 */
-	if (!ctx)
+	/* Skip damon_call() if ctx has not successfully started. */
+	if (!damon_reclaim_damon_has_started)
 		return -EINVAL;
 
 	err = damon_call(ctx, &control);
@@ -344,6 +343,8 @@ static int damon_reclaim_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
+	if (!damon_reclaim_damon_has_started)
+		damon_reclaim_damon_has_started = true;
 	return damon_call(ctx, &call_control);
 }
 
-- 
2.47.3
