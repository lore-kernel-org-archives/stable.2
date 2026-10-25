Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792951248;
	b=IwJsW5d5emmkoeuIrQLkJejoibnBQHhVDXLHKm1mmOjW/GGLGLeKBiH1NrWtj2HzEGbG
	 f/qLW0YUNOKexWVWF8C+poIYG+x1XJWLgmO89a3OTAyQzpjLtNtq984Wa1rSwab5HrI83
	 zcuZqfzTDl0uZi/s1s0fUJnpjeyfuYg3bTObPTM4jNKhj2PVDqYAlADyJhlxVROZaIOXR
	 eYcWRgMiJmpRrexpsPk8DQQBDmVv05RKSN41awO/d3GrM9aX8V7dsYBcpgoK+SemsuirB
	 EpHw3yCE7gcd1farHcQ9N5SUHoaqWkdtKcur3Kj1q5Wf4gx9wL0je37Z4kCSiQTOf+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951248;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GyEh0TwwqVHVC+Uz5uZPmfD33kzhIpkmMSy/zdUq/EM=;
	b=oxbmEGehtvbh/oaZgxakXAp9dcgscj0PMTs0ANdkTtHnpRatKZmNtKRmmvKbqjSGjRbR
	 GDQ44Ky3Y2O1DgFDpwbSFNxryjjq4ZsyNkm2D+Lfl+NrZjW9qCsGeVRRXXg3u5FeawnvD
	 4Ki7q8505+R2msewKjvpQHOupxZHV6Edij3CKKOeihSkNTur9WSFKR6ciD6YecCw101yV
	 rpKGLxG66+RbopKtZtfzUyHZDkeOE3YACCdSSCjXSckski0xVo4H98aiJ3S4flIS8TE1Z
	 l5Q7wSfzllmEki/IkL0wXQwrNbUePQ9pTWFve3PZESVqp5LUH8rXtH0QoBEOQoal+lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgxJsRH4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E939606A31A;
	Sun, 25 Oct 2026 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgxJsRH4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC131F01825;
	Sun, 25 Oct 2026 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792951247;
	bh=GyEh0TwwqVHVC+Uz5uZPmfD33kzhIpkmMSy/zdUq/EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CgxJsRH4LVNHNvLuMniPe8HrqsbqZOFUEbY3ndhUtA66fh5KLi7N9j4BphI4DMxb4
	 7sP9+KC2SnhaQzgwFiyfQWb7KB8p+FP7oouf8BjqjAfW4d0Q0GEIfE6q5Hx+4EisO1
	 +giZqa9aDVYR6afju772f1PlmpuRv73uskpc4XouggkTuDuhKcfpN45MyWNeciJgay
	 2BR97j+l3RXtQXEBlUbcxbG50hC8jsZv+kGgraQymmbfZ56eFP7CKZHBo4RoOTB38V
	 XmKYlmoEGwCANU2RoD8fvppClQ79wEWfEpj7ZNuAQlCalUI/IyWcMkkvWZXc//WE9L
	 xdMPeXIb3509w==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH 7.2.y] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Sun, 25 Oct 2026 11:00:39 -0700
Message-ID: <20261025180040.170037-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025174647.165255-1-sj@kernel.org>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 25 Oct 2026 10:46:46 -0700 SJ Park <sj@kernel.org> wrote:

> On Sun, 25 Oct 2026 10:24:33 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Patch series "mm/damon: move zero damos quota target_value handling to the
> > core layer".
> > 
> > Having zero DAMOS quota target value can cause division by zero.  DAMON
> > API callers are checking the target value parameters to avoid that.  It is
> > easy to make mistakes in some of the multiple API callers.  Move that to
> > the core layer.
> > 
> > Patch 1 adds the corner case handling into the core layer DAMON parameters
> > validation logic.  Patches 2 and 3 remove no more needed DAMON API callers
> > side handling of the corner case in DAMON_LRU_SORT and DMON_SAMPLIE_MTIER,
> > respectively.
> > 
> > This patch (of 3):
> > 
> > If a DAMOS scheme has a damos_quota_goal of zero target_value,
> > damos_quota_goal() could trigger division-by-zero error.  Hence each DAMON
> > API callers should do the zero target_value validation.  It is easy to
> > make mistakes.  Actually such bugs in DAMON_LRU_SORT and
> > DAMON_SAMPLE_MTIER were found and fixed [1].
> > 
> > It is better to handle the corner case only once in the core layer,
> > instead of multiple places in all DAMON API callers.  One straightforward
> > option is using an alternative denominator for the corner case in the
> > damos_quota_goal().  However, the zero target_value is meaningless.  In
> > this case, the quota goal is always evaluated as achieved or
> > over-achieved.  The quota will only keep being reduced.
> > 
> > Simply avoid using zero target_value by adding a check in the core layer
> > DAMOS quota goal parameters validation/commit path,
> > damos_commit_quota_goal().  Update it to return an error in the case.
> > Also update its caller to propagate the error.
> > 
> > Notes for stable kernel porting.  The upstream commit doesn't have
> > Fixes: and therefore not ported to stable kernels.  It turned out it
> > fixes commit 8b549a4fd3c5 ("mm/damon/sysfs-schemes: commit damos quota
> > goals user input to DAMOS") which was merged into v6.8.  The user impact
> > is a race condition that can result in divide-by-zero.  Hence backport.
> > Reproducing the issue requires sysfs write permission, certain DAMON ABI
> > usages that are supposed to be uncommon, and a rare race timing, though.
> > The issue was discovered [2] by Sashiko as a part [3] of its bug report.
> > 
> > [2] https://sashiko.dev/#/bug/linux-7f814c9a-986f-4103-a55a-ef9537dcf62b
> > [3] https://lore.kernel.org/20261021005234.94107-1-sj@kernel.org
> 
> On v7.2, DAMON sysfs interface calls damon_commit_ctx() for validation purpose,
> for parameters commit but initial DAMON start.  Hence this patch fixes the
> issue in parmeters commit but initial DAMON start.  I will post a new version
> to cover the start case.

For minimum change, the next version will add one more validation in DAMON
start path, like below.

'''
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2226,6 +2226,20 @@ static int damon_sysfs_repeat_call_fn(void *data)
        return 0;
 }

+static bool damon_sysfs_valid_start_ctx(struct damon_ctx *ctx)
+{
+       struct damos *s;
+       struct damos_quota_goal *g;
+
+       damon_for_each_scheme(s, ctx) {
+               damos_for_each_quota_goal(g, &s->quota) {
+                       if (!g->targe_value)
+                               return false;
+               }
+       }
+       return true;
+}
+
 static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 {
        struct damon_ctx *ctx;
@@ -2251,6 +2265,8 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
                kfree(repeat_call_control);
                return PTR_ERR(ctx);
        }
+       if (!damon_sysfs_valid_start_ctx(ctx))
+               return -EINVAL;
        err = damon_start(&ctx, 1, false);
        if (err) {
                kfree(repeat_call_control);
'''


Thanks,
SJ

[...]
