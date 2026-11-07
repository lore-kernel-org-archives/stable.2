Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082211;
	b=2Hl6d/EElLesIQVXaKSCSoQ9ldpwgdVzMzluxr+F0r9hDJ/rlY+H2qVpy7JQSxEG6olK
	 GVhMWNsuO29bgitIc4DoOgxGcUpZ0vbkJxnzPl0kkYb6YeVPCx1GSOKqYOo97wX9JR9Qy
	 Y72D5RMmhoMC4M0wNhyuioJoZPpERPA7al0ssH5ISpOGB+jvM2vamxEpbA/cE/hGckjE1
	 rM3oDzXlj2cki3HJqCSCuORTQ1BQ1dKMS/3JVZW6D6C8J/WQedyykcbAT5MRz2zYniudX
	 A4hymdETnCsXvG0OXuwP5f1/Hih/CoUa7SrkieFavweVkM0hRg+pOt7x5rw6KTRscQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082211;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1FTxpkWekBlYDp/UoERMc8KBJg6cu9CB4RQQpW9Xqac=;
	b=MmhqjqsiUcblXakzQDTRQbb1r7MJQPv44Gm6Q8o+HA2jE753D7EqO/xAclwxkXnU7aJ4
	 pWQb1Xs2H53YHZ+REcE9m/3IoVzF++k4wgdBvL3+m3AWr4Pm44XviLMqroRFGDnFkqk7T
	 CW7akHJRY0DJU6RZRSvYvXr4r1aMeyUd94HEMBD1n3IPzoExGhJhIYzcJlOu8X2QtW7d7
	 t3KpgSngg85cvtfn7t/kgVp2F/9K7qyM+wgmWWgIOZzWHcIG7a0MAClG9U7+Hv/mGU5UG
	 OZra6w6SVhPi+EtEZhF04kblxiDvv1H0NG12Xxf7WYk0DCiMLj+ZL/5kktdtAE9h6UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/Jxmopc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B0606D813;
	Sat,  7 Nov 2026 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/Jxmopc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C27D1F008A1;
	Sat,  7 Nov 2026 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082210;
	bh=1FTxpkWekBlYDp/UoERMc8KBJg6cu9CB4RQQpW9Xqac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/JxmopcOvg0rAmmnZebR2qYHC5gTkH3JI07UamM8CjbLw04fADnRq11h1rY4xY6Q
	 BNMigWOw48azYVCplHgJjv4y4MmMLuWkSlJ7iiBQrPlCboUd+Qpf9J6cABkggGXPth
	 ih10HLkwsfv/KljYgYI+HJm/+V0b06QRaoKm52Su4l6g4S8mTYBo6AA1vniPFozkXV
	 /CcbQr8OazMRCOmvVK5b1GxJiOswamMEjhBBMQt1aW5IndlzWV+ZgMOgqfTJhZzgZ8
	 qNhp6OzBwyk/fabJNMtb/Tq2eFxKbUvsUQmsNcWxwx2CsEy12gVC7xsrynS9t6Kxbg
	 tRe4Mlyf1Us4w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.18.y 3/5] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
Date: Sat,  7 Nov 2026 12:09:59 -0800
Message-ID: <20261107201001.206120-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107201001.206120-1-sj@kernel.org>
References: <20261107201001.206120-1-sj@kernel.org>
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
