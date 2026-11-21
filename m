Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795229804;
	b=IIv6GybDdw1FkvucXyZeiC4KixlfD1G1iCmcGwwWhPTDp9CfyvzXHLPdBNmYnyATwbKL
	 Eh95F522PuWH7HR7V/vW8PJ6wz37E9AG/escjDLmIXrPgIlVDwy2q2+Fbw9Xeg8jkn45R
	 MFqgi4k3129+01lE/2ewjbWloragM8+Wwsoc8dfFEUVrU0ofEUAg/ngszP/eKUCxo7HHn
	 3cET6cAa/1hHGDySphYHJb+2xtHugKSbeggzWLaxpPx7uIoeYHVC9bDiGcbX+AVeRLPKo
	 TJFFTdI7W+9dxvMseJtIq1QMMhDdoHFudp10dque9FjV+gtIHL5ncTd6I9sE1aXM3xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795229804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sQ0URJXLHPyhV0pqjQJeFam3yZqKvnQul1dVgNuKRU4=;
	b=GbfpFw/aJWk+HkZkX1303jEZY29YnBae3bTdiUmQWHT5hTnemMbQ1sldu6BX5CXciIq+
	 Oq6lye2AtRa1MpPNpZNaMxUYWz9EscPwhaCrP0DZhSBsvg/9Bc78MoyeK1Mdsw6NxalF1
	 1vnKqrEl99da2RM7fbhp1LtHa62ekn9b5Zzwnu94tQekTrPz2BYpjZMx2gqomFFji9Xgq
	 mjKgkXZYaDiV5OfItrEUkaZAB8O3sAZB5rjDMMvnslMbs74AujAL89oAjRgR+tbuB012q
	 GjWHh3aBBMl4mNUhqgjRfapUA9XOKel/M9aDgAEuWZ0tsvj9PbwMV0l6Nx0m8mqfIeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g9Bi0j63;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F747606A6BD
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 02:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F747606A6BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g9Bi0j63
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-385d8a00598so1842742eec.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795229802; x=1795834602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQ0URJXLHPyhV0pqjQJeFam3yZqKvnQul1dVgNuKRU4=;
        b=g9Bi0j638butKQqrJh7k3KCV/lIMMA+ErsuPa1dWZlOUuaBred/EkLCNPnCIcLvuZ3
         gKYp+t4eSAhv3PBOKvKNjoFr6XldgWtmyhPbpcnf0PVdCgrBqBWvDCMTFDaN8OMRgygM
         DenAySF+lbxJ/EVfFwP3SO2YyyivEWAcX1RANpsvtHozHj8U2cxosOrNmZDKO7o4KJAH
         7Yv66Cjie6HXrTscNPQG+ZA3GObk4+gGCH52582Mgf7jFfGRQ5iEyDFBl4FN8OBPa78s
         hz2JpkqSOlrsSkLPi7Zn1P2aj5/JZzZ8Ybs9WpzgZMa69ggJl//2Z+uxjj1Bu9V15jiT
         u2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795229802; x=1795834602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQ0URJXLHPyhV0pqjQJeFam3yZqKvnQul1dVgNuKRU4=;
        b=yD7Q719GgFiRorXHBpPYX0V834TZtlTkcCxuhsmyErISpngc8D21FURe4QyR2BN8gb
         Z4YXLgPOlc0Z99OH3wvfVqb7ffOQiDyPocgxPcZCjk1Fba8I1Uhn/XGnNiDv/oUIw4JF
         wK5VkJJlSOz7t0Hkt/N8Ug+5QZwHery+EQ4w5yDCrKx/cVCt7e+Xzj4lyz7EhL4l3w5l
         4lHuI1r6JWaIHKmNqiJQIyq++Vp3i1PgUfvp1ro+3x1vrsAgOQ//qQWK1GarLdx+y3JX
         cg3zpnsnY0kRNDBTGMbr3nvdGwc6wl7wApOG7s6d8eTPqUNeRJMCpZN4adkjVUntBuNp
         FZQA==
X-Forwarded-Encrypted: i=1; AL+hErGyop+UIhUMiDduB+YsRLjvwAM7FvaQtQ1uJSmy0T2/lAyaxX4Bifuj7t7YO7xLwUBP/Csfbuk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UAOO0FJSWQFJWct733ggOnpWIb/CEnxiAvogKWKqiJ84C08Ol
	0dD0nxJJhvhqlDiBdhKmUlfbO/llzKg8R2IakxyZPkfvE6ORuAW1q3rA
X-Gm-Gg: AZFdTZfE9vRoVt2Ij6/wr7NJY6JCzCGI0VrRykNPVSyt9ZmJpAZslNwXiopfR+nGkhI
	27enADBFb2YiKfjWMXbw0VfqomZnmFmnmK/HMJ+x0cGt9idQc60Fc1A17Zn0Vsd2lyprN9uYDtQ
	Sy2QSikBMFhU2jW7pj5NhqqrBzyHcUG7yCQVcTBHJHlehEzIj+NipEA1VG/TEUuhQQ+qnsYO4Ps
	ZJ114DZmDyjgz8EAkqOIthX0ZkXJlWvtBtAHq7gHcHG/DxtpA3aJ6gfY6VMsylIis3QWPXzy0Qy
	mpGSRYvm+QOsyb+Nxzkf18Mj0iGqIVhq5hB5AhFMlOuh1qtVOtIv4JVtvtQccizTxVMSab0xZtB
	Uy7dkitxTeYEResW7pvOsPI/Lp0JD4e0u7HwyGl9hcp5qxIdBL305DDM6P4xcyrjNMLIqDs2HS3
	EgmPBgQqi6AQn+ccffcG+ImOgmapMcyznbLxyh2CQdQ2E1OP50UmbPnOcBtWtPuJfRjoVGdENhi
	Q8qMyjqWQmgfgLWpf7A2N92u87dvhRkljK/Yp1SA/2PENCwWPR0WmzNO7lJd8xOB/UipLKW7wz0
	OG6jTGsJp6YV0q6JQJiBwRV4inxjbEit5oTiupZZeM0qy7R9JtV1tKjMMUILE+XWD/O3k531/hP
	Rx6CABqtv9P/+F2+Hss+tHNqaPDgXlQ4MkChOjy4n/LfdBCiaUAoS3OrG0XcACo6BqJuEASvIov
	i9/Q==
X-Received: by 2002:a05:693c:8641:20b0:383:50b7:1d78 with SMTP id 5a478bee46e88-38571223ee7mr5312730eec.40.1795229801565;
        Fri, 20 Nov 2026 18:56:41 -0800 (PST)
Received: from localhost.localdomain (206.135.124.34.bc.googleusercontent.com. [34.124.135.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385667decc2sm12071967eec.9.2026.11.20.18.56.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 18:56:41 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yifan Feng <evanfengff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: fix damos_walk() hang with zero watermarks interval
Date: Fri, 20 Nov 2026 18:56:26 -0800
Message-Id: <20261121025626.75981-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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

kdamond_wait_activation() cancels damos_walk() requests while all
schemes are deactivated by their watermarks.  But it returns without
waiting when the watermarks check interval of a deactivated scheme is
zero, which is the default of the DAMON sysfs interface.  The kdamond
main loop then runs with all schemes deactivated.

In that state, kdamond_apply_schemes() finds no scheme to apply and
returns before it calls damos_walk_complete().  The walk request is
neither completed nor cancelled, so damos_walk() waits until the
watermarks activate a scheme again, possibly forever.

For example, with a scheme that has the free_mem_rate metric, zero
interval_us and a high watermark below the current free memory rate,
writing update_schemes_tried_regions to the kdamond state file never
returns and cannot be killed.  The writer holds damon_sysfs_lock, so all
other DAMON sysfs writes including "off" fail with -EBUSY meanwhile.

Cancel the walk request in kdamond_apply_schemes() when no scheme is
activated, as kdamond_wait_activation() does for a non-zero interval.

Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Cc: <stable@vger.kernel.org> # 6.14.x
Suggested-by: SJ Park <sj@kernel.org>
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
---
v2: cancel the walk when no scheme is activated, and leave has_schemes_to_apply as it is (SJ Park).
v1: https://lore.kernel.org/r/20261118235012.14859-1-evanfengff@gmail.com
QEMU: -ECANCELED instead of the hang, 20/20 walks of an activated scheme pass; kunit and 13 selftests pass (2 need drgn).
Found and written with the help of an AI coding assistant.

 mm/damon/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b8678a53b0a9..2748f9199924 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3492,9 +3492,13 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 	struct damon_target *t;
 	struct damos *s;
 	bool has_schemes_to_apply = false;
+	bool has_activated_schemes = false;
 	unsigned long max_region_sz;
 
 	damon_for_each_scheme(s, c) {
+		if (s->wmarks.activated)
+			has_activated_schemes = true;
+
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 
@@ -3506,8 +3510,12 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 		damos_adjust_quota(c, s);
 	}
 
-	if (!has_schemes_to_apply)
+	if (!has_schemes_to_apply) {
+		/* The walk cannot be completed while no scheme is activated */
+		if (!has_activated_schemes)
+			damos_walk_cancel(c);
 		return;
+	}
 
 	max_region_sz = damon_region_sz_limit(c);
 	mutex_lock(&c->walk_control_lock);

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.39.3 (Apple Git-146)

