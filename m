Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794091694;
	b=UmT1qNp7fml8858S+M3OI/SDeaBuRGd5dd50GT472QmFTXpw3JmA/Bp0J24vbVqdqCnD
	 YAC3jsi6+duyKHEI4aDrEyJiEmQzIszXZspl+3hY4VgS19zZ3PSXGEOmBjqlijQBFZafX
	 HZmwij64BijgvS10xbxfRB0DVn46adEertLpvtoBo7ntN8TmK18dvBUZzRqNb0N6leOIp
	 pFaulfrq/A+y/oB/dKDirWobau+8QkGdRTRmFWpoNNd/nrEg8tdAnE/9f5ZL+em12fBHi
	 UaE7xReiNdGRYlnCIlGCJ+zd/kYr0oYNEFwCDJPM5+RBC7SOpMUZNCfSbY9Lw0GN51A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794091694;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z5j7HhXnzELbkFkJqEZQNTDWxIhKaeKvJLsv/O41RlA=;
	b=ZOLLSnWX6gBwhC8pzCJoRvxkRaBBQwD6uVJsmf9mbcnjqnUbjzsQvi653g74WED+09hZ
	 mCyjWGUsy172hdPGdlxtAgvH29mzDitVveXr5GPQE60Xz6Memq00lDY881lmw3ZH6UYXx
	 gnEJiIhPBE73Xa2BmFttPT17vQnbhHyLzTEyOolBeEYXenTQinQuyu07+Tfz00nCXjolO
	 vVWEIIyYCbMg4oDOglvJf15zr01rTRF16d3twN4BFEwS+h8/6z80uTLQCYztTx3S3Z5IZ
	 oBwtguUPkk2jv7VunQ9sDWvqGvvAhTC1tfl4Lw/gFUun2uCgmHSX9AwBBdH1q0rxRAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2DnN9FQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B644606A330;
	Sat,  7 Nov 2026 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2DnN9FQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97591F008A1;
	Sat,  7 Nov 2026 22:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794091694;
	bh=Z5j7HhXnzELbkFkJqEZQNTDWxIhKaeKvJLsv/O41RlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z2DnN9FQ/pONrpfmYqdsyadnC5aGPtVXxJDblg/cLi22vodpsA39uT285qpPCtkEf
	 t8z1UcPayk6eXHiM30oSoskX1Wpmec2l6JudAx+tFqrot2gNRvnMqZ6aXY1wT0q+4z
	 LUbGrWu4KcRkeFtbUXgLrHgIxFLhe0onBex8+Ov5cRNg3Wb7nm2R1h5yzObEfKyjWJ
	 ye/UmpNJFnsa3Cms1EGXt+cCMS6N5AYo6GRDh70btIaRB6fpummEYhWZ34nldZoeFQ
	 mV1QaeZvuSCI6u0ftfK17OigkxV+zy8trlgG2CIMbi/6LKgrKdDOcHSdmcbgCOM3yS
	 Z/S7v5GANMagQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.1.y 2/2] mm/damon/core: remove unreachable damos charge_{target,addr}_from
Date: Sat,  7 Nov 2026 14:47:59 -0800
Message-ID: <20261107224800.340250-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107224800.340250-1-sj@kernel.org>
References: <20261107224800.340250-1-sj@kernel.org>
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
