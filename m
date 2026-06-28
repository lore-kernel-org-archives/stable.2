Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E643B8BC1;
	Sun, 28 Jun 2026 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683694; cv=none; b=H8H94G0y50v2T4Z30CZSzbBoMQ4YZAmR5HqokQoKRQQgxrNIE2hpUejQSERf3be/fsuwOHFJJt4SeVHs9pvFu+J263bVLB+FBvGngiYb9qdAgR1ALerp/1oxDPCrCdMnVyBzDGWERSmDCir+qGoO4SC0smK+QaOsr+P3e3zsvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683694; c=relaxed/simple;
	bh=7fVm9icn6sKU/rKHJWCkZo6ETFPuyGhj+szQjYMHi24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVG0pYrs3bPF9VOfvkW3dTNBNbRx/VOnDqzGzv1rdMLR9k3jGcukmqM5URzg7iGNq8dG/Lw8e9pIV1r2aJ6vf3wat6qffz8NFpyw7Z2qfq2VxqZRVwrgdWxDBptnHW8388GuV9OkEyRs541XNPkFrfosibdK7ZF+rRKIF1BeBf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKTtMy9Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKTtMy9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BCD1F00A3D;
	Sun, 28 Jun 2026 21:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782683693;
	bh=6LhATUSGD9m/hcobL+nNhDihLIC7y6gv8GROPInzLpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZKTtMy9YQwzoIIXw6bWxoHKkXepftHvlvWAIKn640TsyYsJnqSFrUaNega3+rheZh
	 limtahpHqTOS5bSRny8jkRsw6FRXXEaF0+3ARkqAQp68Yt9xSAfbQkx7Ur1f0vwHJ8
	 kIyp8fJvw1lwqp4LUuLQwT71qZFS0DtIIzZwmQlI9Rpoalvj0zdSsEaWN3gnACFGwV
	 0g4cNSE24Sgw59JlmeMKrfdpOzrcJeVEIVYsmNkBNMy6nEpsXDX4v1Vpd74PPynpDf
	 rFL1e0++Il5f8P8CiCZPV1SiXr3RSwnOFSkxS3xeEZLC5Jy8cnQCILeXQv4m5WqsNP
	 2zOUYL4N4PG1w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH 1/6] samples/damon/wsse: handle damon_start() failure
Date: Sun, 28 Jun 2026 14:54:40 -0700
Message-ID: <20260628215447.96166-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628215447.96166-1-sj@kernel.org>
References: <20260628215447.96166-1-sj@kernel.org>
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
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Signed-off-by: SJ Park <sj@kernel.org>
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
