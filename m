Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795811986;
	b=xmGDPeCRBzT8K/eYTBP2VMElIR4kJgDo7qTMuA37GIVDMdceW5xvkAcnhhDqos9K6esj
	 WiXoARnLH0A7nfxf6AJBmDTcXHZfijQL9LnlV4LrXFMuxDEJ6mbUv6GdjBwNa8tLzRY11
	 j+HAT/nSGTzoS1Z0OIfk1iAFPeKPwyV4eP4bj5fKYRpll8VhR3QK2rCsHajyWZIXZdMli
	 ChOB93QQ5+45way8HfuveSwlTQw5lXZS+D0oL+Dyrc0sLyq8OJDa/h5+FsCqy/kgwj1fn
	 GizdaxXC6hJBFsG9VSZ591Zd28iCH0VH8x+sPwISHW56pckR3zKmD2PfNj3Ghz9eD6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811986;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vmt/h+98quVGznsKJZsY/ImK2ypo6iML2/iEdcnVAoo=;
	b=ecFDJvYJWVhJR50Vt0SHBDVo0d3tRLa3SxYWMrgfm/sda28ZKTFfmmTlOi0VRFQES9Wu
	 Q+YPBiHv8vHcdYJt9Ge0rjFK+nUQlx9vxdllbiotZGQAzGIdZDLKYrpBt/QgmW9wzE9a1
	 VgrirRvNDuDIjddv8GurTAtfkHElr9kiyK20ty+byL5VF3OWRvZ4AnggJulS+dr2+I71n
	 ziNJT4hti5Jzplme5/CFyo10h4eAxn62tvpAxr55E5KjFkqZRO9Bx8Bdn8Rni4BmSWnM9
	 oe63BDdUKLWQvO3Uq/dXm3Vp7RGSUpSZCRlPJtzA2EP5aYzLGcTcvum7DJKEKSrujkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7H03EBC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB12606A31C;
	Fri, 27 Nov 2026 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7H03EBC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB391F000C1;
	Fri, 27 Nov 2026 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795811985;
	bh=vmt/h+98quVGznsKJZsY/ImK2ypo6iML2/iEdcnVAoo=;
	h=From:To:Cc:Subject:Date;
	b=R7H03EBChbVbrwQSrjrNCNuD0itWNBGvyWIwRLe9eT+DnCDFEY66kmlzxqkdjtSj+
	 PojwkufUvwEy/87dRB+S+r8W1vu1vu1DshpmMhsI30PVaFWFd+pFdJUpxn8nITVj8k
	 ZoSP12+W1hjKk0IcRhuFZn4jEPP/WsW9J374RCTuLf8d/YgjzP3du7rcp5fzk5dEPu
	 j4YOEoLqXyBgLHIZmBnDtwHKmTDcTcVzztV/cKd2xA2peEH+rivsdZtgVUdm9GW2B4
	 FILvjCStLES3qEmtjUTAXr2E1nx+pN3WK14IZXvnKuf8T/Q4uZIPtkU0qSrDRhoeJV
	 Orm1VsZvAYJlg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH mm-hotfixes-unstable] mm/damon/core: do not update stat for core filter rejecting region
Date: Fri, 27 Nov 2026 12:39:37 -0800
Message-ID: <20261127203938.94339-1-sj@kernel.org>
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

damos_apply_scheme() update stats for regions that were unable to apply
the scheme due to the quota.  Those are counted as tried and failed.  It
doesn't update stats for regions that were rejected by DAMOS core
filters.  Those are counted as not tried at all.

However, the DAMOS quota-driven failure is handled before DAMOS core
filters.  Regions that would be rejected by the core filter can, hence,
be accounted as tried and failed.  As a result, users could show
confusing stat changes.

Fix by handling core filters before quotas.

The user impact is not critical.  No crash or leak happens.  Only the
DAMOS stat could occasionally move in an unexpected way.

Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos filter")
Cc: <stable@vger.kernel.org> # 6.6.x
closes: https://sashiko.dev/#/bug/linux-9c51890e-a25c-4534-afab-ef33f22a9557
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0e6b361f97ea..e0ea93de100d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2785,6 +2785,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	}
 
 	if (c->ops.apply_scheme) {
+		if (damos_core_filter_out(c, t, r, s))
+			return;
 		if (damos_quota_is_set(quota) &&
 				quota->charged_sz + sz > quota->esz) {
 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
@@ -2794,8 +2796,6 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 			if (damon_split_region_at(t, r, sz))
 				goto update_stat;
 		}
-		if (damos_core_filter_out(c, t, r, s))
-			return;
 		sz = damon_sz_region(r);
 		ktime_get_coarse_ts64(&begin);
 		trace_damos_before_apply(cidx, sidx, tidx, r, nr_accesses,

base-commit: daba53bdc1a54c453c2f4ced54a1cd52416c3f87
-- 
2.47.3
