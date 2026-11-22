Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387264;
	b=s3DyzkyJR5U8He5EUq4UcLS6OqCSNM2mdCxzZO9Yf5D1VnTzxZu7kfCO264cp/16VxFi
	 A3/+FyjCrh+8P3fZD2k7o8IlwnCJrULA9twp0hoTywHcHN+LZemlUNiGdIB+mGJEz8k9R
	 vtrvdZmayjOelh1lg7NWmYY3N2REKGxc00l/3fOPQcISu8/zqT7NX3KJYOAu4lvSr09kB
	 NnNZKpWaWMjQ6ZDWXpZO1wzRMNgS+2YkYV7GZiB/MclTpzEvBQvJ7sGq2Djer6x8fOrlO
	 PvtSJh/u0i1PRrlwM1P1KYt3OKNX/pYwIW12Na667Rew0pGzrPrx3el2U+YrB7ceu7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387264;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sJFKXYBlyKsjrymChPkVlwTwAE7JP3i6GsdhQ8/eAqU=;
	b=J38Jr3V2TR2xFS/cPwiopMYH5ZAgnwqE4Xt+RiUIMBcCMa6bLGVA/lUfe0pU+AnD9zPS
	 NAhpmu6HX0+9d0zjvKdQ2iZhBHTtznZLU7RrzbgJMFliHblgqffxjJlkXctcaOreWvBxf
	 gH0HqP5217UZmzEkxH8jFq19yOnHjL4ywGZ5T/KfuK9MIvIp19BFbeYFhhNJ0txz8l+2t
	 ZOXGWlr0+gwLAsaX2pNhtIInw+E7/eezEYHce3ge40/1kBkioXvE/RpMltUYQ7R2ShXfw
	 AZM2Y9VI5OoSoV4Uu1+/p/RiI4bWRpJeMPetDzA3p7kYUXlWbX/irYzTor1ni3x3ARg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OS8TcZci;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F2606A31A;
	Sun, 22 Nov 2026 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OS8TcZci
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3B31F000C0;
	Sun, 22 Nov 2026 22:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795387263;
	bh=sJFKXYBlyKsjrymChPkVlwTwAE7JP3i6GsdhQ8/eAqU=;
	h=From:To:Cc:Subject:Date;
	b=OS8TcZcihfSP+khLyNygpchK1BCLDPefv4GAZhdMrw/JnZVxFTB5QxsMq7x4VD0IO
	 pPJDmxdONZVsBOw2JZUD5cwr9xfx5VPu1fEsZ3EqcYn6cM4s9+X46gp2wGRoWaKed0
	 Nl+hLfwGIXmi21TSu4VAR53a/fRH1b43E8Qow90EqjP5CPUCkLvxdiM5VYAo8XecWl
	 RnA/BTHEtexTTmUhfcgPcNs3wZ/GnbXVP4X7FayxyIPCM8GjDW1j/O2D9nztkmtfxr
	 f8Hd5M9hA+1LfntvHkn/CLoc573hHYJQts+tPQIZv4RhH/z1ooGe+hLindixxoqndS
	 2AGCt6hhFskgA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH mm-hotfixes-unstable] mm/damon/core: cleanup damos->walk_completed in damos_walk_cancel()
Date: Sun, 22 Nov 2026 14:40:53 -0800
Message-ID: <20261122224054.79767-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

DAMOS walk could be unexpectedly only partially performed.  It can
happen when there are multiple schemes and the walk is requested after
the previous walk is canceled.

The expectation of DAMOS walk for a setup that has multiple schemes is
that it will walk for one snapshot for all schemes.  To know if the walk
for the one snapshot of a given scheme is done, each damos struct has
the walk_completed field.  It is set when the walk for the given scheme
is completed.  The walk skips schemes having the field set.  It is reset
for all schemes when all the schemes get it set.

damos_walk_cancel() cancels all existing walks.  But it does not reset
the walk_completed field.  damos_walk_cancel() can be called at any
kdamond loop iteration.  For example, due to DAMON context pause or
DAMOS watermarks-caused deactivation.  It means that the function can be
called while only some of the schemes completed their walks.  And users
could request another walk after the canceled walk.  In the case,
because some of the schemes still have walk_completed fields set, the
walk for them is skipped.  As a result, DAMOS walk based user operations
such as update_schemes_tried_bytes kdamond command could show incomplete
output.

Fix by unsetting the fields of all schemes in damos_walk_cancel().

The user impact is not critical.  No crash or leak happens.  Only DAMOS
based monitoring results retrieval could work unexpectedly, under the
certain setup and the race.  Given the best effort nature of DAMON, such
occasional monitoring quality degradation would be not critical.

The issue has found from the Sashiko bug database.

Closes: https://sashiko.dev/#/bug/linux-228a4c52-0545-4c1f-90ce-41114d8272e9
Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b8678a53b0a98..ec7f20b7856de 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2699,6 +2699,7 @@ static void damos_walk_complete(struct damon_ctx *ctx, struct damos *s)
 static void damos_walk_cancel(struct damon_ctx *ctx)
 {
 	struct damos_walk_control *control;
+	struct damos *s;
 
 	mutex_lock(&ctx->walk_control_lock);
 	control = ctx->walk_control;
@@ -2706,6 +2707,9 @@ static void damos_walk_cancel(struct damon_ctx *ctx)
 
 	if (!control)
 		return;
+
+	damon_for_each_scheme(s, ctx)
+		s->walk_completed = false;
 	control->canceled = true;
 	complete(&control->completion);
 	mutex_lock(&ctx->walk_control_lock);

base-commit: bcafbab5174a89c3f689e458b5114641a0f68032
-- 
2.47.3
