Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045876;
	b=Tp4OJ8JAelkN6HaeVw7CYi8b5G/yr+l9BIA8YGBZ70FMfKYWNu7onA9JGLF39qTtJDb1
	 /O6B5W46mjmY6fhd1OtNTf/R9EG0uHoIRp8HcTo+quKUz1cazjAvldzBlreh/Y0Vq2HPr
	 ZpvTyZ++DZqOb86HcmTz4coAotQGkYIFoHliepVVFDTjwoU7UOTF4pj0QB/Jn+TXnzA6/
	 LpMeMnN0cG9d6B4R3erZWy1FhRGk1ZANJ88Fdv/mZFYwZ1yClwJxgcwfIdVGUOZxXeVKB
	 Ne7jEe1AO1YafP6gHTefRULjtm764jDsgACv5krEwbVH3MfUnPqh0vRD+AUa7kYv7xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045876;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ds0jWPFJ9AH2/HGQtdzK+NtJoi1G8jQL9LQXpGnnWcU=;
	b=erM0vySniN2jmk4tCc3/x+rDgDVCBziiqeY8sro/U+uoDlzbiq9KVlZ951FyvOYCHwPp
	 eQQJiXH/L+I2nTEhstI9YjqmVmq6jWroiAUzt+WOjEaOLDHKbsDTRXbEMu8KagCv9NzO1
	 Hy4tKBKfe3GT7Wqunrp70kr69dtJjPnjnNkI15Q5k2XKNEJususej1ReWkVDRVkAEGe+B
	 SljY0svE0bEccEuBImcV3xxntsR+ZcA4WAnfiZ1F+WyVmPpeTIuKi11cwb3xWIcKuCLQm
	 m3+SA7bRTWVRmxBDZnZNtxuvieCyhcB5IrWzeBJZ4iUelKQL3XhdWEKgy87Y73Mp3yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YhJcS+DI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YhJcS+DI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835B01F008A2;
	Sat,  7 Nov 2026 10:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045876;
	bh=ds0jWPFJ9AH2/HGQtdzK+NtJoi1G8jQL9LQXpGnnWcU=;
	h=From:To:Cc:Subject:Date;
	b=YhJcS+DIAF/64XcxnsTJStmNfC9TjRWHrUL2SNT7vc8Ti0sBLKrKmO6GnEU9hQpkO
	 IEkC6c8VIbEzsfRftj2D+PbkGrTxREQP3Q/ccztqjqaVxMwtpLZZSGp1fuGtLMWM5D
	 KsbdzFUg5TiBU60H6613WLuf8MfoQrxhg990QudxBOBZOdSrwTcKr7jgTiqmopAqY7
	 UMiD/QgtHhB/bLTHzRDkHOqcFjpn1dFPW4zbl9fcRfbHCY36u516oay5VBc8TU/UQ3
	 U//b5rPzPad3LER77vHxNRYsWcoqrJEZMgYEk2p+ExFif942OPmzECh9EU+6dTukVb
	 sU+uyh0O5xOkQ==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:34 -0500
Message-ID: <20261107050434-failed-7.3-af19aff38d6f@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x af19aff38d6faea35b10f26cca32d0e54f8aea5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050434-failed-7.3-af19aff38d6f@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From af19aff38d6faea35b10f26cca32d0e54f8aea5e Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 14 Sep 2026 07:23:19 -0700
Subject: [PATCH] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once

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
---
 mm/damon/sysfs-schemes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3c1c1cb387fec..8c8ab82c8facc 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2840,13 +2840,12 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
-			if (sysfs_filter->range_min >
-					sysfs_filter->range_max) {
+			filter->sz_range.min = sysfs_filter->range_min;
+			filter->sz_range.max = sysfs_filter->range_max;
+			if (filter->range_min > filter->range_max) {
 				damos_destroy_filter(filter);
 				return -EINVAL;
 			}
-			filter->sz_range.min = sysfs_filter->range_min;
-			filter->sz_range.max = sysfs_filter->range_max;
 		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
-- 
2.53.0




