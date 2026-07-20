Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DEF3B811F
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557390; cv=none; b=J2R9Z2uYt3YUUzgA65aaYXduAg1n5HekFbBkf5dh9WGFlRpzbzERw0Pdv/zj6rYvPOEai5md8tf4AUvkuQmW1kDb+3kF6aaHSdTdikInpSivPnqdiNMAM12VMD62ND1Z5874VdKHHUxzao/eN1YdW2haT7fdJmt9Qwavxu1s9b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557390; c=relaxed/simple;
	bh=m5DucAfRn4OTGrvlwC0i62PVkP7gurKENWRbDT3cyjI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e6PwrJuyoXRszAzALj/k4arzXeg/L8aMYb5mw7N2MPb+SCEFTnOxvOAXQS49kguOJlWhsXNjMXKDO20ZlQUDEsqzzwHysblmvmw+z39ZG2lmzHO7EfA5/eGZkQv6b0ar2buZz+sEu7C66+TwsuW6zT4wgj1QhqaaiVSX7MVJXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BVAtrvxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BVAtrvxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A8D1F000E9;
	Mon, 20 Jul 2026 14:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557388;
	bh=eWcYcUcWc5Z0OidblDXr4bLZkkvOMfHfb+nDG1tBNcY=;
	h=Subject:To:Cc:From:Date;
	b=BVAtrvxNscIIq9RU8pWG0yIWiUpz5JSInr2fQMBebSqTl9+IFB6VcPL8jNHnkw5bl
	 cpWWqacvGmpSb40xxe6nqK1fMikE0zby3LAq4lOVN3zxBVrO2r18mvoE5hA5fDqA4/
	 eRDzOqxMGizDqeerGFOZD+QMro1XW1a+ayQ/qEA4=
Subject: FAILED: patch "[PATCH] mm/damon/core: make charge_addr_from aware of end-address" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:22:59 +0200
Message-ID: <2026072059-refocus-lizard-6528@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5a2d162e22bf33eb89d53e802d0fc1ec422e19b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072059-refocus-lizard-6528@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a2d162e22bf33eb89d53e802d0fc1ec422e19b6 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Mon, 27 Apr 2026 21:29:40 -0700
Subject: [PATCH] mm/damon/core: make charge_addr_from aware of end-address
 exclusivity

DAMON region end address is exclusive one, but charge_addr_from is
assigned assuming the end address is inclusive.  As a result, DAMOS action
to next up to min_region_sz memory can be skipped.  This is quite
negligible user impact.  But, the bug is a bug that can be very simply
fixed.  Fix the wrong assignment to respect the exclusiveness of the
address.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260428042942.118230-1-sj@kernel.org
Link: https://lore.kernel.org/20260428032324.115663-1-sj@kernel.org [1]
Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3dbbbfdeff71..901ffdaefb7f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2106,7 +2106,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		if (damos_quota_is_set(quota) &&
 				quota->charged_sz >= quota->esz) {
 			quota->charge_target_from = t;
-			quota->charge_addr_from = r->ar.end + 1;
+			quota->charge_addr_from = r->ar.end;
 		}
 	}
 	if (s->action != DAMOS_STAT)

