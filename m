Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169689;
	b=S71XR5UDPjZjzMgiwS4zzDn2kaHJ0E+/gz1htmX4hO841yqLIk4ZHTdfo4g6QuiYfAQl
	 6L1FcTncAS0ZGK/o19PulU4IOpzAJLQBBi+qv8Bwwh3Ifo0fMPzOeJj5FtmRv6FPY5ifH
	 CxRHNyVhggqT0CUdoZ/qwac1KM3+U1O9jbaVrW0tuziCxLVz3dK1OywkpuJmb130GyXCX
	 Jw4NDgalTvNvYIskHKkkeTvCuqg7+JMO5enpM4jgihw3LzrYNkAZK9rcE2J3eGdL9i2dl
	 2L+mXfkDtFQuXkyG8e0NGTiso/FYcEuvfFMQ3KYnVQinOCWOWYyHY+0DzMJo8TKpI3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169689;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z5j7HhXnzELbkFkJqEZQNTDWxIhKaeKvJLsv/O41RlA=;
	b=VG/a9G+Js/3yDE4aUjwle8Gq27feebscLz7q0pCMuwxnN2C9wiDHAwC7OV11nzyAH5JA
	 +wFmspT1ddtO6wy58j4bmCs10A942Y28G0c+Dywr+ZXO+b36GL+0U81twjbbG2kmH55em
	 gnHYW+JPjhoBEjuUqxT7lIOSZI/w/+7DctpoAeFQg+3D9sc/WTeKVKk2oUpTuiMPEZ0Lx
	 PNK4eZKpkkkYewBRh4kQWaPo0AYjAlvgT1n5Q20Xv+gUHoGcYIy6ilWET8g26tAPiijzF
	 4lFZgwhaj3pqbMC6JbdnNYYEnn5Ob2Twl6xxRg7tbdBq581bwMW7Urmb7MT5T2u1viA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfNPdoBK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0C606A339;
	Sun,  8 Nov 2026 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfNPdoBK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F7B1F008BD;
	Sun,  8 Nov 2026 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169688;
	bh=Z5j7HhXnzELbkFkJqEZQNTDWxIhKaeKvJLsv/O41RlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gfNPdoBKXcAtf6hRjx3oBKNvxuctMSQpp/iU/H5+S3lFaJwT4pILePYk9ynCAGLLH
	 ZQJ8bqirTCcBOaXloqpNaEz2VKMDfqtY8wq4tMkfj7Ehg8JKLyIxP6QwEiN/8RBgm3
	 zXrTuKZvl5Vrr23sVgTtroZLOxmzLMKXtdCYkWpY2T7PclwpuiIUqThyvEPj8VvwKm
	 DKqLyBO6KsoAsvY50IdhNuQicPCA+ngvurlEjB2UN3IXpMRho/hJneE4TnKedvnJhC
	 ehL1nyF63OVVy5QiPeDpZl6kbiEl0Xs2vCWKJueP591ZB0wWAHb9+2Eqsz54sXK6pX
	 7YEr5HJQOZm6w==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.1.y 2/2] mm/damon/core: remove unreachable damos charge_{target,addr}_from
Date: Sun,  8 Nov 2026 12:27:58 -0800
Message-ID: <20261108202759.117377-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108202759.117377-1-sj@kernel.org>
References: <20261108202759.117377-1-sj@kernel.org>
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
index 9206737d05ae7..01f93146b92fe 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -860,6 +860,26 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 	quota->esz = esz;
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
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
@@ -890,6 +910,8 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 			damos_set_effective_quota(quota);
 		}
 
+		damos_fix_stale_charge_pointers(c, s);
+
 		if (!c->ops.get_scheme_score)
 			continue;
 
-- 
2.47.3
