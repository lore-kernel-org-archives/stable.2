Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446070;
	b=5eA6dS2xrJG1w5bRs6c7IPOJBti0JN3ds497vV4p7pe0PmLkvBNn3uSy/MqOZQrWq3Oh
	 uIWgB1BfVYY4PvFNJnDtMqHkUiZAJk1VvqCvGB7W7DvWaR36idgYiLdbCqvCsFBt77ngd
	 aE5kRFJnQc1xpYJSX8dOncL3NWdVGUvmOkHkPJYfWggpzlBBHksIjjnM9/sj7VprWA65U
	 0udsuX1w3/WnOfu4CK2HrtpxPVYYPdUC71mnoJmqdtFSU5bMSXcKldocM7PFxhnb71oGk
	 eA9mwykN+Qjq+zu4Xw6CGOQu6vkqB/ijyKk3oX0KItZ1EoXMBTfRM2xwtDurNCJlBVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446070;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ta1APtJZ3SbnBo9Poepvc+VpghMZSCLjVAvUkbF7mMs=;
	b=SpQKmtErQsnRsYdeEoWC6+STeYcbypwuB2X+zhpdgGhAVN2/+b/hg1qWMM14NZYJk4on
	 8Ct6wqmda1heoYwV1eF4+zms0IW9oQCztW77TrQVLLQYvj50GXm9rWF9LrQCVu7FP2DmS
	 ChJFK8r+M87pwmgc2HSvbjvT6x8z+3skXQkKXtKrEXfcrLNSU5vIKHDZjndJ9+QFvlUWh
	 x+KbjgIdCDpbaVCEan+4VQYmbMN1aW+THscv9RJzUFetIAbTh93uZRgmn7j9u5WhLP9sB
	 JrZVLupZJT4IGK8HyqduZOm3tn5L9ThUi1ihMtnpwyfZh/nXVu/edPfIb5nWuEm+NCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CN4+/0Gn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D90606A331;
	Mon, 23 Nov 2026 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CN4+/0Gn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F491F000C6;
	Mon, 23 Nov 2026 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446069;
	bh=ta1APtJZ3SbnBo9Poepvc+VpghMZSCLjVAvUkbF7mMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CN4+/0Gn8La1gLwsgprHfMz/omHDvSNFjCxQwHPhimmlwEacFqD8PGsYCOyFDiVyk
	 ze+P4xBPSBNDIzhdfquMAInfch8/HX9gdFdCOnlrbU3aDg95jvFDCC4g22pUUMrhqc
	 j5suvJ7voB+XjPYD68SY1B+Ig+LGY1DEDWUToNaM9C00vjBZ6dfN6O7Ch3p3CHpv+Y
	 eS/c6SY4084KamWuNC+dCwuQQMKSyPXpVqXVyFEMIUE37iaWrJ7RH8alfiT840gElF
	 SkRKIxLJqOZ6bT/52loQEAsbEb6xkpW4leeTSqHjWjBPadZC6miIPJHh9uz+7DpDQE
	 /uGaDvm2SIynw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yifan Feng <evanfengff@gmail.com>,
	stable@vger.kernel.org,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH mm-hotfixes-unstable 3/3] mm/damon/core: do not overwrite wmarks.activated in damos_commit()
Date: Mon, 23 Nov 2026 07:00:48 -0800
Message-ID: <20261123150049.81317-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123150049.81317-1-sj@kernel.org>
References: <20261123150049.81317-1-sj@kernel.org>
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

From: Yifan Feng <evanfengff@gmail.com>

damos_commit() copies the whole wmarks struct from the source scheme,
including the private 'activated' field.  The source scheme is a new
one, so the field is always true there.

As a result, a commit turns on a scheme that the watermarks turned off.
If the metric is between mid and high at that time, the scheme keeps
running, though it should stay off until the metric goes below mid.
DAMON_RECLAIM and DAMON_LRU_SORT use the same path for commit_inputs.

Save 'activated' before the copy and restore it after.  Do not restore
it for DAMOS_WMARK_NONE, because nothing sets it again in that case and
the scheme would stay off.

Fixes: 9cb3d0b9dfce ("mm/damon/core: implement DAMON context commit function")
Cc: <stable@vger.kernel.org> # 6.11.x
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261122002930.98401-1-evanfengff@gmail.com
- Collect R-b: from SJ.

 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2748f91999240..0e6b361f97ea6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1567,6 +1567,7 @@ static struct damos *damon_nth_scheme(int n, struct damon_ctx *ctx)
 
 static int damos_commit(struct damos *dst, struct damos *src)
 {
+	bool activated = dst->wmarks.activated;
 	int err;
 
 	dst->pattern = src->pattern;
@@ -1578,6 +1579,8 @@ static int damos_commit(struct damos *dst, struct damos *src)
 		return err;
 
 	dst->wmarks = src->wmarks;
+	if (dst->wmarks.metric != DAMOS_WMARK_NONE)
+		dst->wmarks.activated = activated;
 	dst->target_nid = src->target_nid;
 
 	err = damos_commit_dests(&dst->migrate_dests, &src->migrate_dests);
-- 
2.47.3
