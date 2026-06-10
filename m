Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628E8233934;
	Wed, 10 Jun 2026 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054070; cv=none; b=RWsOFWjSXcLRxStSWnp+5dXCqccbODRxzQOEHF2CK7SFiTzJbJ/6e4aYAM2tE+5AoarNLOr6q4UpR828bCyr9eUN2UmsVY5uDEAJwZxkCCHnFooFIcO86zZRY0Dhyz2RWWNui/1Cbvhg7vG0ftkoEjux8+pJUpXQDEqUFOqqZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054070; c=relaxed/simple;
	bh=MUhLH4KjnWf280jQwEAPII5VPYmn2Z+FNONeKmftcSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzW/iqN0UxI2j7D8HyqpuEqCY6SK+n31RcifBZZLmQ2A/9mftJZUqRDL8o5i7PZ8hYJBrot7lu8+iGnkf5vNfcSxyNrXpbCAUJBh5YbXycC6DNHFeOJH256ElnYc4/1OeZfubYPh8ah0NiyafIsVoqGMiZXjTcuAD1MzzAXxli8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlHD8R2t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlHD8R2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4101F00899;
	Wed, 10 Jun 2026 01:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781054069;
	bh=Pb0n/eJX1vGIeSAU0z6olfpVOoRIiAMjbL+eNzYDAJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RlHD8R2tmPn4c+ph6TQwiYaWFXdVRwLlvgGWj9DDOSP38PEXQP4YCZ85EF+s9T0fc
	 kxU1mYxcmac/7lxca5ZVA92AiS8souEpHcb712bJVI6f+5/nqJaz8hSWt9rwsbOcRz
	 xUfOlrMOaV5V8wOjJz7+hmaoHNP4gmAB3DMZGgaAsfqhSPCdbqL5x1JHEOXRhdQqvQ
	 E3iy0LwpVWW8L5pa+YPy5yBFjW6FlhDh04HTskfayNOuRwGcFhUCvqd2k6bsgoE6rQ
	 Bqd577ewXcupCac58o/T5bSVr1sh/pyNl3khldS7tKGQx/BZzYXvs272lgyHWPbA/P
	 3HqYRVid37o2A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 1/4] samples/damon/wsse: handle damon_start() failure
Date: Tue,  9 Jun 2026 18:14:14 -0700
Message-ID: <20260610011420.3018-2-sj@kernel.org>
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

damon_sample_wsse_start() callers assume it will clean up resources when
it fails.  And the function does the cleanup for context buildup
failures.  However, it is not doing the cleanup for damon_start()
failure.  As a result, when damon_start() fails, it leaks the memory for
DAMON context.  Free the context in case of the failure to fix the
issues.

Note that the issue can reliably be reproduced because the module calls
damon_start() in the exclusive mode.  For example,

    $ sudo damo start
    $ echo $$ | sudo tee /sys/module/damon_sample_wsse/parameters/target_pid
    $ echo Y | sudo tee /sys/module/damon_sample_wsse/parameters/enabled
    $ sudo cat /proc/allocinfo | grep damon_new_ctx

Because the first command is running another DAMON instance, the third
command fails the damon_start() call because the new DAMON instance
cannot exclusively run.  And without this fix, by repeating the third
and the fourth commands above, we can show the memory consumption is
only increasing due to the leaks.  It requires the sudo permission
though.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260609145814.70163-1-sj@kernel.org

Fixes: b757c6cfc696 ("samples/damon/wsse: start and stop DAMON as the user requests")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/wsse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 799ad44439434..bbd9392ab5b36 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -87,8 +87,10 @@ static int damon_sample_wsse_start(void)
 	target->pid = target_pidp;
 
 	err = damon_start(&ctx, 1, true);
-	if (err)
+	if (err) {
+		damon_destroy_ctx(ctx);
 		return err;
+	}
 	repeat_call_control.data = ctx;
 	return damon_call(ctx, &repeat_call_control);
 }
-- 
2.47.3
