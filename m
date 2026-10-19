Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F0582786;
	Mon, 19 Oct 2026 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420642; cv=none; b=h0bf3c+43hSBC05sEyzfx5QZ7S5WBSvofa7pLSuwhYCavYdodOKVNLbrILalfCurMjZslDgmOz8EsE/EUpT0CCFl+TyUHyIGUZxj+g0XH6rki/lLT0CB3cXPPRGcWhixpfACoUy111wJi19GI4RLnNrktuXwwffEQhjTLRzwrFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420642; c=relaxed/simple;
	bh=JFmI1SBHRcxfApXkuvNRk973kers9bQhwnFxlSmQ/m8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hvBzpQx7IrREcFGivOuqIWHHUNOvBWZchV1tTsRMrl6FNxIdyF5dVeYb8sIh11HlWOYYH6K/yKNobfZP/aeSdxtnt2fUgTdEKCkXuz3pofnToZeiNG1IOMLylwBP2+EOt77TJredPiklxY2IgkrwNmgoZHTuJIUwhStRpzN/+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCCFjJ4m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCCFjJ4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9734B1F000C4;
	Mon, 19 Oct 2026 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420640;
	bh=TzeUsHBgfXPKsjgzoOJjZ/KqkTpciOqCZplZVywH5gw=;
	h=From:To:Cc:Subject:Date;
	b=eCCFjJ4myRysM70jqHB5+xC6TSc+ICnmeZSx22kHDNs7zQrWNfZNIOZzdLJbZEEkL
	 CK/WsOIJ3oF8UUhX+JBSvcYiED/f8QsVo7/qfzBG3mIo27fL2NwSpQ//eVqCJTGmm7
	 vkzGWzZO94a3uRDM8ofv4j2dElI2vPlhGFdYt6/70uC2YUFr6Muezo8/CDIeI9OpQI
	 zqzQyr4ydLMTTuNOliHnz8+PDdutxtxb20jDTmcmTugK39k7sCROq/IJA4pT1A1IQs
	 Z4lpEe1Y5vLb33MMnBAT2eG8nqZEggI3vPJOZX2X64kWHKtdTqGSJt8qDNNGAAKU/a
	 JqKKnDBLlZhfQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/core: remove unreachable damos charge_{target,addr}_from
Date: Mon, 19 Oct 2026 07:37:11 -0700
Message-ID: <20261019143713.98610-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
Cc: <stable@vger.kernel.org> # 5.19.x
Closes: https://sashiko.dev/#/bug/linux-cd0c55fc-0cc8-45d8-9637-3334811c49b8
Signed-off-by: SJ Park <sj@kernel.org>
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

base-commit: 46165457cd36362f10fb784de8ce4925d6dde119
-- 
2.47.3
