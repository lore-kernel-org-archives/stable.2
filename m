Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165750;
	b=E2S/DE6H3vJ8wgQCYAN5ZSc2PlEFbpK4wsTBsmmWQH9GjbSvk2tdLaY4i58iU4rngVBp
	 9hKJN/4BDde6bmVXOfHkLnU7HvcLgRnd53GDOIYW6MJ0vqjMbI/A/FLrceyiCB1K7hmvt
	 hbBP8NKl06tqG39+MKAooJvXLt3F4CYBgDtSv6p/SI9Rq8MPolWaGHbWxwaGBtjiK/bBu
	 n4vUUTQckL2Auym5YqMmTQLebYWTz/V/Rwa5BGw3nY2TY8pPrEeAhC56vSep3mxWQ4Deo
	 OSIIyCMPi3n5E0Tc7K+t0miHR9KeW5hCLcK3urXct0JeS96JFLMRWU1L9A7Cb7Mbu4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165750;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1FTxpkWekBlYDp/UoERMc8KBJg6cu9CB4RQQpW9Xqac=;
	b=jC4eD+wUC2vtCW91KR0D6mIjQzI0WkCTmlXX8mKbChsrRYgJFKrPqunveHieZtekcXV8
	 9eIH07oLF6A58MpCJKzWUD80Jt36jxg6NXq8NF9extgdyrhBJynXCWw9M+jWwPFT8rfhO
	 BIcGL1EqJSHww1Yxt4L3XsOZsZQRmMH3WVp595+cLeIDmB8+Atc0mC7e+jT2gNs4ofFD+
	 U1JUGbV2MZfLmlytbCqFK0miQKhy5A9ypA83+9nWgmvOy/9cryndeyDx4ZXATqnITL7sQ
	 xI7Z8k8k9MpYYsvUdeugDNo6BAcVPTFajH1t7Z+Au+wv5zr4EKCIGfFFbtR0B6kcv5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNez8Gvo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D316606A33B;
	Sun,  8 Nov 2026 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNez8Gvo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314B51F0089F;
	Sun,  8 Nov 2026 19:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165750;
	bh=1FTxpkWekBlYDp/UoERMc8KBJg6cu9CB4RQQpW9Xqac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MNez8Gvoa9710lsf3vMIGzAL/7zD0HV16k/FSX2nXE1SreDCo+GiB/+sIFyPldqpx
	 ynWPwdiwqVk9Em327TYzFcdBswx7bmGCsQnonb2FzKJmI1/XvsTAUfwmfXV+NQwzgD
	 40LINNcEADzBPC+Sn80241b41xnoOcf0kndU+6r3RcK3FQzP+MRvHFaNL61/rOrJXT
	 sd3K/9VcEuh4Sz09IEmvreNArzscQOY8elOD9yy8kMED/sL0KWnWEgU7n/c738eo6E
	 gbee9x+GNbUf1XuEJHj/OfLG4iV6epfLu6Pmawb5c5azkfyL0aUa2GKaqB5m1W0dyW
	 Tm7I+g/KYqGWg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.18.y 3/5] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
Date: Sun,  8 Nov 2026 11:22:18 -0800
Message-ID: <20261108192221.114362-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108192221.114362-1-sj@kernel.org>
References: <20261108192221.114362-1-sj@kernel.org>
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

DAMON sysfs interface reads the user-provided size range arguments for
hugepage_size type DAMOS filter twice.  Once for validation, and once
again for assignments to the variable that will be passed to the core
layer.  If the user updates the arguments in parallel, an invalid size
range could be passed to the core layer.  Avoid it by doing the
assignments first, and then validating the assigned variables before
passing those to the core layer.

User impact of the bug should be trivial.  From the core layer's
perspective, the invalid size range is not really invalid.  It just works
as having a weird size range.  No critical issues such as a crash or a
leak could happen.  And sane users ain't do such parallel arguments update
anyway.  If they do, such racy behavior is arguably somewhat expected and
deserved.  That said, there is no reason to keep such races.

Link: https://lore.kernel.org/20260914142327.92510-3-sj@kernel.org
Fixes: ea1f204ba29a ("mm/damon/sysfs-schemes: add files for setting damos_filter->sz_range")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
(cherry picked from commit af19aff38d6faea35b10f26cca32d0e54f8aea5e)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 37e0a8bef4b1f..0f945ef043709 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2493,12 +2493,11 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
-			if (sysfs_filter->sz_range.min >
-					sysfs_filter->sz_range.max) {
+			filter->sz_range = sysfs_filter->sz_range;
+			if (filter->sz_range.min > filter->sz_range.max) {
 				damos_destroy_filter(filter);
 				return -EINVAL;
 			}
-			filter->sz_range = sysfs_filter->sz_range;
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.47.3
