Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32139023A;
	Sun, 28 Jun 2026 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683695; cv=none; b=oZ3A8aeItGUIsRQqryL7Zzp4HOiUn+ySHS4tI/r6Zf3O8eqdZYxNr9xRSjywkam5tEKwcnGoBY7SnAjsovbJKqmIc3MpRH7b6sww6xnyBILAP/atGIQV1IbGA88I6ICc+dBgiSn7hjsV16NIdC880BK8lIP3/No/3Vgy7dLkJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683695; c=relaxed/simple;
	bh=xAVYRplGu1gtvrDRKFrta0V6Pz5BBo7sK7WZMFvNYsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1yx08TRXvqdEhxha7xH9NbX+6aebmBOkLtqoSpY59yvRt7a80x4YDZeyl9M1LT4I4PW8R+KqBAc8eUwei7Nq63TTq5JCxud3vKhcX9R1brQHmTUPd6ezeYDR/XZGpsuEdaZfYwsDWYZbDbqtbOCOS8+U3v+5MUSGR3PalrsItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbd6cSN8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbd6cSN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A711F00A3E;
	Sun, 28 Jun 2026 21:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782683693;
	bh=Byrg2i188f412iRZE4Bba2jB83L3ezRqbLbUNLGyb8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kbd6cSN8YdZjPzpL51S+hGL4yt/obQJp5BgKsrEj4CdnuShWpJZ5bWg/SFyRLmevt
	 o1TfDpPMqXJ0YbcHOnn4oBLAkQzrtH+pOnGXlKQNEzNhc+na/5bRNrB14fm9zaJcFR
	 AcsqJlogqySFwXN05PTfKLmn9FlpxfUIG5roVkAAxE9qjn3NR1AR6vbtwAcloHjtwf
	 Re0qsnnwAOwTkKo7SjN/AdRZz06DbUkMD30r7VotIA1zedEO2JA5oRkPHb6vbquUOd
	 4Yv0p8qFpYxG4U/YhLb3ITTbh2RGkfWelyKco8PAEbCisokq5xfWum2u1M2JjhAFmN
	 pKxLt/+T8X41A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH 2/6] samples/damon/prcl: handle damon_start() failure
Date: Sun, 28 Jun 2026 14:54:41 -0700
Message-ID: <20260628215447.96166-3-sj@kernel.org>
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
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Signed-off-by: SJ Park <sj@kernel.org>
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
