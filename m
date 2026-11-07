Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048301;
	b=IJoEFyHibcjZRUhsd+O/0M25AQR+5qbFxiBKeYBSZfabaOVPrOiKDE2FO2Qh0FUUhv+v
	 fCHKzf8abFjpZqHIe0R8OOa03Vx5a3q8M0yWlBHMzMRjZye/5+ubASX0mZLAewb6RljZC
	 aAhQX+DllhJO21dnqglzXA4eqNzF4RKHSg++xQjmFBJ3MegffAhxK30UtO/BiYVpPHBNr
	 DphCJSxYp+Jelm4RHWYGVtRsv7VTbUAhqXLfYjzPiSWzreNUt7yZPdHKioDhzJxJUlEr+
	 ajHHLj+BnOYhTOvINXHAe+Cxcp60inKMS2A2XyMpK8ZnhtwmzNymoiUcf3VzMvuUdqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048301;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IwYLYWK+gM5RG/evg9s0cddJh3pSUBLMWWBkCQjjBpI=;
	b=dWtiHHX9UN/Ttx23yBYRtxS9vtoPHNFXPgnfwvgZsHGv5ngvoNe2uOLdEbhgZLEkVtIz
	 8BePCUE+k1hzbOE3+cgbG/kOIw8DoHqE8BFzevSVPz/7jb1w56sFRRWvOfVwS47Z6+pNJ
	 emGKEnWI9zqqcNe1S0wPlQ9aMxeW/oZocl5CeyArhOBDdPJDjRer5WDF30IjCDjey6Z6d
	 Cr8IQ7cvUGBG1eCR/I3fjC1sOjr86iq3fkp8P7Ju3fqYm0zuot4BBAFFzhZnM4Q9P3X4t
	 4uTl+Unll9DK4Hwx48b19otKwR1eELa/8t9vA7okZxHkfc4+zKWIrCU8H7tHN7xlvFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lq0b2HYC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4341606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lq0b2HYC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2927D1F0089F;
	Sat,  7 Nov 2026 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048300;
	bh=IwYLYWK+gM5RG/evg9s0cddJh3pSUBLMWWBkCQjjBpI=;
	h=From:To:Cc:Subject:Date;
	b=Lq0b2HYCmupLLPZzSKZtRKzQ3SK61V0rRO4da58h1ecMyzVqSi+qxZgkwJUweE7Pl
	 DRyHMtVuOXx0c5sS8O+JMcD7J6spnX8mrnp5an756ususCSHghzcQ4jGJs/InHQfaf
	 6MREUOtNnL0UHWgyLMfjIXUbtw7qtbCaig1mZ2IMnRK35NfZqrErP5msTEsu4z54xL
	 i3wbkTybG8w8qyfXcO0Pud7Ytz8luGPnPcP0tJACIzEXQSOyZiEltSxWYzHvHlYy8B
	 hTgWde28Ii6DM5a9Mfy4g0HtOe815YGL9jR7ltZVabWlrqswdTvlp3XUom5ZtyDzRy
	 p7SWjZN8CIZww==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: skip applying scheme if region split for quota fails" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:44:58 -0500
Message-ID: <20261107054458-failed-6.1-90c2fa6adfed@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 90c2fa6adfed7abe0935506a43cdff3a05c1fff0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054458-failed-6.1-90c2fa6adfed@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 90c2fa6adfed7abe0935506a43cdff3a05c1fff0 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Tue, 1 Sep 2026 06:18:42 -0700
Subject: [PATCH] mm/damon/core: skip applying scheme if region split for quota
 fails

Patch series "mm/damon: fix DAMOS bugs in core, paddr and vaddr".

Fix misc bugs of DAMOS.  Patch 1 makes DAMOS less stress memory allocator
under extreme situation.  Patches 2 and 3 fix wrong folios walking in
DAMON_PADDR.  Patches 4 and 5 fix wrong folios walking in DAMON_VADDR.
Patches 6-8 handle extreme and unlikely memory situations that can cause
divide by zero and underflow.

All bugs are discovered by Sashiko.


This patch (of 8):

damos_apply_scheme() splits a region and apply the action to the subregion
if it is needed for not violating the quota.  The split operation
(damon_split_region_at()) could fail for allocation failure.  In the case,
the quota could be violated.  From the user's perspective, DAMOS becomes
more aggressive than expected under the extreme situation.  Handle the
failure.

The user impact is not critical.  The failure of damon_split_region_at()
is unlikely since it is arguably too small to fail.  Also DAMOS being
aggressive is limited to the single region.  Users can set min_nr_regions
to set the maximum size of each region.  If it is reasonably set, the
transient overhead shouldn't be critical.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]
Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org> # 5.16.x
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d63d4c6fd3ffd..53952d16ebd88 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2607,7 +2607,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 					c->min_region_sz);
 			if (!sz)
 				goto update_stat;
-			damon_split_region_at(t, r, sz);
+			if (damon_split_region_at(t, r, sz))
+				goto update_stat;
 		}
 		if (damos_core_filter_out(c, t, r, s))
 			return;
-- 
2.53.0




