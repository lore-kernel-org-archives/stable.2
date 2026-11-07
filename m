Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794072333;
	b=DexkW7qOGhfB3SKlhOjZtHbJGOImE/ybkuRo4BNYubR3pPsRlcZ9V1+prQkV0DhH4BZX
	 u9mnU/GnLJUTOxmVXM2rwCpy7IInekxW4MIw+lePq29PD4mGGERNXqbfGXQusmt+lMpEc
	 2OUV3NgDcWZFaOH3h8VLNZm/N4F18/A54Ok+TqD/ZMzo8f0rLimxsjpUW5HdjnCQuaEWb
	 OoqEUj414AgZsHD0zJCkZAoqXVW7WAOaN5j3beiIIPBxwRy9opCle4UVrtMSgR8wfVLpx
	 fW3BZ2cTrJ74HPrKdE8ftjXA4dRuTAuO7ijM+8Huo+cnVX7Fjk4cdemutr/oVa8Jt1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794072333;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GdNqUYJ/pamJl/A6pJ+FkUakABRRqEdgRFgal2+P0I4=;
	b=Q4bvkY1A0+kHcPGVkUEy0iNPVEmtcBrpO15ZwoqNaop83EG4CsXO0XVlZAYral1syXeY
	 pt8tja5jDav2f0PaT0yRG6EseFcXPw3/GpzpNMFRo9HW5dbdLMCoKWxo1q/BCTqh7Ykgu
	 rt7ZdkaYiVQIvcFvgGm1DBXSvvgrexJS59ejuJKhIk7Td2VjSGFr7kk3LfNdXW8tP8rC6
	 ezdsUvrd0zGHnNTf4E4holW2L0/r39P8r7zNJGhKybCXg+OyI/UVfByKji1IL7nJwWEbp
	 exScVh62lSANGJbWjn0JzC5WXTtXVBBtPioEJ2AF9VZQUP1mHQe+745huToQTSRGTBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfvTmLN6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F918606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfvTmLN6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119D51F0089F;
	Sat,  7 Nov 2026 17:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794072333;
	bh=GdNqUYJ/pamJl/A6pJ+FkUakABRRqEdgRFgal2+P0I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NfvTmLN6zUvqtGpWMPdIv1XJd6S3Ta5hjxihJQ2WUI3ZQjQwMlUwKK2cDcziG4I/9
	 5i98IF/ilh6ECG9kd56TuAmRhW3VJVmzfh5iriXS6uknpkHKk3XvafLeXwFGrtIyx3
	 udkXbOFFfQcwvsrR3XRpKJITaOdSAfe+NpAJ8JhC2M5R+/KDUyl7VwIEj8IuOJzJLv
	 0ioq7GMtidC6AtJod6ISf2D1s738LrvSgSd4yZhh4hA2gyAwS8JfsFq3zwNznBebPE
	 hVEJJmK5K1b/eweGLCslmk8DqPXE8sQh483xLzyPDoT1VMOzlBqhmGAfOrSCPvKVYr
	 3SXcMSeCqfD6A==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.3.y] mm/damon/core: remove unreachable damos charge_{target,addr}_from
Date: Sat,  7 Nov 2026 09:25:23 -0800
Message-ID: <20261107172523.109273-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107050537-failed-7.3-5695abc4e742@kernel.org>
References: <20261107050537-failed-7.3-5695abc4e742@kernel.org>
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
(cherry picked from commit 5695abc4e742b947f586bfb6a080a80ad9957e5d)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 74d22a596fc13..1d84e668f8e46 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3149,6 +3149,26 @@ static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
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
@@ -3184,6 +3204,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 			damos_trace_esz(c, s, quota);
 	}
 
+	damos_fix_stale_charge_pointers(c, s);
+
 	if (!c->ops.get_scheme_score)
 		return;
 
-- 
2.47.3

