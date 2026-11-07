Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048897;
	b=JIk1VXCgjug+IFVffo0X3SV2dYqjQp9MUSwpNMAje0NHYgPhaOMI0OhPLzkD7SZMIsbh
	 2JCWM6kFE6jJd7cbI/TdJ6D+HROJ/HGUYkOjQ50V2Waeo85q8ZfVpAVCnZaUCXtTIbEk8
	 HAJr/yKIOCkpT1iWjmxCbHnvcCsexxy7XaRfcf2Hn6kbxZ66VUvtHo7lK9AWhsNNMCvCw
	 ZBrmQ1h5DQ1T9dHNG54jf5/5XHYD709jfUNvhG4eOfWOd17J1FcSdvpLxQVJObZ4bYYzK
	 vEUxtZFi3xBl0VHtkpxDavKX7cDgiaLAtA2K3otv0lwwHMLTTiPqToeKejGCCuxY2QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048897;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0ZHnFJ4tBJIVeFWREOhHpHLfnNg5gXAgbn7xo6jUcWY=;
	b=4Oxs8DK5qtmmTbsAGcIhpFqK+NJha8RosrZ49utMe+I5osvuL5Vdb5BrWDExPSUjzH/M
	 WJINUKWuwupeJ5OfY2A7muuUpMzlQ0jM2qtICoJidEFY2LJdeElMBaoNqkx1NXiD9H3UW
	 ZoHVrtXur5TwTEo01GvgiY0q1UzZoZwPsyfLq4Yo3QHNoS7wmniiIOxP8FYDXXw4Acrxs
	 gkJhJzWp67ovX1utM5gxn3DKWSqpAnD2Mag2YlQ2u7ci9TYECZkzg/z6+NFwJyVsrn4JZ
	 ZC7X9n2kiyHyw/mHPYjiNU4+2rZiPk4vQztHSlSE5LIpIFhOHr4WJgn6zGc6gA7uOsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2+WQEO9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2+WQEO9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5891F0089F;
	Sat,  7 Nov 2026 10:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048896;
	bh=0ZHnFJ4tBJIVeFWREOhHpHLfnNg5gXAgbn7xo6jUcWY=;
	h=From:To:Cc:Subject:Date;
	b=i2+WQEO93tjFTngLUJHPNhmDaByGbXWPE8zB04B3wuCocO1+KylmGl9HCqXCZGv2z
	 ACgnRc34+e/H6oWG9om8xv6abilz3dXf8cTbmCR88YZBUEKTqm/MslQ0pQIFFHrnv4
	 YsrMzBagqC4Oa5p6CrlLHYR0NIlWHrsZ8kpdYM4lfMHFg64rdjNLsXchtlFgWqpuiT
	 QkaKxi5zpeaSM/tMbjN+Bb387zdhJ8XX5Drn5FxlpD41cPYWlyGZvCxyZ1v5Qg9fIS
	 M7RlJh2GNQatZR4tR4WoVQoANHizOJxwfLyBQvvBNcTK6HiIydt1uKi7suqZ5GFgBS
	 +SwXQB4wz+i1g==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: remove unreachable damos charge_{target,addr}_from" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:54:54 -0500
Message-ID: <20261107055454-failed-6.1-5695abc4e742@kernel.org>
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
git cherry-pick -x 5695abc4e742b947f586bfb6a080a80ad9957e5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055454-failed-6.1-5695abc4e742@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




