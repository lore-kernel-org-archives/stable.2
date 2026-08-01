Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA61E3290AF;
	Sat,  1 Aug 2026 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785618804; cv=none; b=FAfP9n8OQl8Q9R8na6ssokhTHU7WKEAVFpnFAD2owbODISLiIjlcGPUaqDaS3d5+whtCSBQ1Ar0umw+MMFD0/5m3VrkQRyWgTk0F6iJDK6zqxSGK3I77U8i1mWHNy8GsVMuj2k24GEJBbtxCV/Y/V+CZyx6n+ptyDWhd6rF4uEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785618804; c=relaxed/simple;
	bh=DNOiz/DgEDdKA7ysxts/Yldz2JYVUrbH5dTvy9JOXOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxBde6G7F1o+aEiAGegF1aFnS0ljy4EIhwljVrzETtXb7ePYDIqHuLDxvft7CDVb9w8x/DgorfzmF05Eb9kmDd5Zd6J6LlGJiNcbvFXXOnT2Zpf2A/iZJtW3Gf7N6u8kjQhWVM+Gu1LIqxEJd0nrxOUCcfrwNw9SAG0TWHuOYxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2qQ8ZkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2qQ8ZkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBE41F00AC4;
	Sat,  1 Aug 2026 21:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785618803;
	bh=Zgds1KWwyKC+2cnQi37FJX/dPPIH+eZIO9DX1EvW4BM=;
	h=From:To:Cc:Subject:Date;
	b=N2qQ8ZkNxXx6ISsQ8TaGZ+cCD8ZUA+9+/V6FRYXNsce37R+Ou2N1Hc4PGW6x92v3g
	 f7/7wRdJGMfo2OCn1ybsZRz8kmVQFG06S/Kl5mg4lPjTqgRA5Pkd5/Z1tgy6Qiy37/
	 2bieEOWzmlCkYJ0BqAeneOlpXHUmevhGsBIN5rb44Za0nXxaWFxS0M0LFuJGMQwcAD
	 UW30BTR4MWsZTTtbLyU7IXRZNookNIeem5reab0R4yl9IScvMVjU/2l6SwHc8dVFY1
	 lxqxOju361z63bWP5lTOGYZYQzuioxr505pI7a6L3YG0XVcggq2HL+EEdvQ3g9CUm+
	 a36M0RbtXg+aw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] samples/damon/mtier: error out for zero quota goal target values
Date: Sat,  1 Aug 2026 14:13:14 -0700
Message-ID: <20260801211315.2456-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

base-commit: 51b0df5cb9a4175af0e3c9e471cd70e91ff8eb4b
-- 
2.47.3
