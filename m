Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047188;
	b=THxPHPwozt0CtjVFadgEnfcfupNouURtw9XDxw6uoOiaE16dMOj1npef6L8saZuqm3lw
	 eF65JGM+rHeVPEivWmslmJBcfgnSO6PFirevsosmnjClHKsqWqPsOC7C7q9W/yrNSzgFZ
	 9tnujMmnfVDHd/sy1xzGZW1ACFwCqISVtscfVpI+QQlJjBbCBWIthP/jVGuQbYij8WaTc
	 mEKJJSCsPEd/kP2nbx9SZv9dEq2aAt4I5vFqFlTdV2RkkHVDdmsP6h+gUwEQvq07kk5x4
	 2cqEVlinPvJ6YwKKxGcpGKMzZSnK6Hl/qAy1t3uT3NJDobXtLDJfgb3KyLtLR4ShgbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047188;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BH57Ycfej9zaXX/hcWN2ww556KK76gvyH5HN8Ibtl28=;
	b=ZGf+J+9LI9iuS54ZxOJWIZIw48daq53bJxYkVDWgya78tYkC3P78WrdrSvT+vK1RFRyB
	 xjXUlXu/iI09waDDiFHjZ9ywwp00zHKHvz2DY2NiHWYLhQ3U8JasS2wt/lI5HSwPIgd5k
	 Ri6se4SeJQhADlGLsJSRgvzb+ZoPQqtTE/B5ki1vxyhyfBSwIDemPb0AeJIINZIgRltV7
	 p543N6hflDs8jGLWkOjj4ONv0WeDxRM/nEeZtbuXZ0IHdPHUUiVf7PKE5XulmgHjKlIiG
	 JkGHD4kBT23JkhIOIrDmSpg4ROL0X8qwwzT/Fjtb7ajuuZYuudhKJRZGvC2p/bIC7ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlnyVU8r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A339606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlnyVU8r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA761F0089F;
	Sat,  7 Nov 2026 10:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047188;
	bh=BH57Ycfej9zaXX/hcWN2ww556KK76gvyH5HN8Ibtl28=;
	h=From:To:Cc:Subject:Date;
	b=KlnyVU8rgRY74Zz+Mz7JOK+oRoqgTf/WiZuONVnqjNDtjlWarf7fM3118tNsRy58v
	 LhsscZij524oYJ47DuZQyaigc39BODN9ZU052Z7unufjsn7cFeNB41r8721WKZFJty
	 HQg8t4JkBUlFIW2g0ROj2etOfXvff42V9gr39avFjO3/yG+dedyH4lSFHBfdPsSnQW
	 CyYBFK2yflkFYaY8pBt7i+mBCqbin+yCSS2f9kVJ0jmIFI7HRZgZ+P4VFmcwQYbE1H
	 f796h9/4JFZgNlhn3sot8HoS13ZmZKcDUMaQRHxbM8/4kbJjuTyjMCxQNvSPC6xrpy
	 fLslVnjQkgilQ==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: remove unreachable damos charge_{target,addr}_from" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:26 -0500
Message-ID: <20261107052626-failed-6.12-5695abc4e742@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5695abc4e742b947f586bfb6a080a80ad9957e5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052626-failed-6.12-5695abc4e742@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5695abc4e742b947f586bfb6a080a80ad9957e5d Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 19 Oct 2026 19:39:56 -0700
Subject: [PATCH] mm/damon/core: remove unreachable damos
 charge_{target,addr}_from

damos_quota->charge_{target,addr}_from saves the target and region the
scheme's quota limit is reached.  damos_skip_charged_region() skips the
target and regions before the point.  The target that was assigned to
charge_target_from could be dynamically removed from the context by the
runtime parameters update (aka commit) feature.  In this case,
damos_skip_charged_region() cannot find if the point is passed or not,
so the scheme is effectively disabled.

Similarly, the user could also remove all the regions of the target
using the runtime parameters update feature.  It would be uncommon to do
that, but it is a supported feature.  Because the skip pointer detection
logic (damos_skip_charged_region()) works for each region of targets,
this result in the logic is entirely skipped and the scheme is
effectively disabled again.

The user impact is that the DAMOS scheme could suddenly stop working
under certain uses of the runtime parameters update feature.  It could
surprise users. No crash or leak happens though.  Users could also
simply work around by re-installing the scheme.

Catch the corner cases in damos_adjust_quota() and reset the pointers.

Link: https://lore.kernel.org/20261020023958.108276-1-sj@kernel.org
Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Closes: https://sashiko.dev/#/bug/linux-cd0c55fc-0cc8-45d8-9637-3334811c49b8
Cc: <stable@vger.kernel.org> # 5.19.x
---
 mm/damon/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 479169dc9ac75..eb1fcdabc0075 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3383,6 +3383,26 @@ static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
 	trace_damos_esz(cidx, sidx, quota->esz);
 }
 
+static void damos_fix_stale_charge_pointers(struct damon_ctx *c,
+		struct damos *s)
+{
+	struct damos_quota *quota;
+	struct damon_target *t;
+
+	quota = &s->quota;
+	if (!quota->charge_target_from)
+		return;
+	damon_for_each_target(t, c) {
+		if (t == quota->charge_target_from) {
+			if (damon_nr_regions(t) > 0)
+				return;
+			break;
+		}
+	}
+	quota->charge_target_from = NULL;
+	quota->charge_addr_from = 0;
+}
+
 static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 {
 	struct damos_quota *quota = &s->quota;
@@ -3418,6 +3438,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 			damos_trace_esz(c, s, quota);
 	}
 
+	damos_fix_stale_charge_pointers(c, s);
+
 	if (damos_quota_is_full(quota, c->min_region_sz))
 		return;
 	if (!c->ops.get_scheme_score)
-- 
2.53.0




