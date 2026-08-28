Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080B33D4E5
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787945482; cv=none; b=hHRXRTUtlXAk+W7yole8LbKSkTmm0etthSGRDv/1Bk3wwRApAedpFbzuISG+LUgioeZkWaY0c7pyW1yn1WnZiuxZ1KrJ5c/gyks5klzBWj3MuQPcyPPQGcxJc7+M5xnxwVoZ5nfFawX5e57vDUEYcUzEHdREY80QOmTKHcsrcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787945482; c=relaxed/simple;
	bh=zvhMgF3sBGyWoxcliuQzMGlGAhHyjr7oIgNIMxF3u74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sxkez0oW8miIxHRVC1BI12BBQruXVPtAArA30mfagiCyoUbOXDtc3TOPhhyoq7bMVyXiUhFazMnTryJ0cWE6E98lLpS600eJvaH1laRGffrbXO/bGO4iR4L1Wu9VuHt4soR/WkT4RDjLHQhW03qrhTS++m/TU/T1wh3yeT2vOdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TMiV08qB; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TMiV08qB"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c0c45c580so9395531cf.0
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 12:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787945479; x=1788550279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nMnYqxHda9Omu8fyzZqn9y6ZJM5HBD/zXzNZf075neA=;
        b=TMiV08qBXEgA+TZEA0oLOp1AJv8mYu7aG9y9jdfTjBhRbed2c1CE2TLsOzrryFprQD
         IXKR5k2ZpfWXtNMhMRS1jXMOiL8RafI2ZX0R6ET6eInVJWbCYCcvXI0sDBY3fsfUh5CD
         23b+iRMYWZC6piajOPBzEpMiyZ3I1n+DGD0tTCF0i04Wi7pF95Uvj0BkaONegFArgFZV
         Iqo7AB7GEyYcgMTOAIcPX+DL95IYQhGNjiqZP3aQdmW+jhEjKYcE8ir+BqdL2QDXI6Ek
         k9hoRMEM+oySQShLQHFgYn17AaLbtPCo2L7vj5msat8VW4EIk4gZUYbdkYZCCAmHmQVc
         u3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787945479; x=1788550279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nMnYqxHda9Omu8fyzZqn9y6ZJM5HBD/zXzNZf075neA=;
        b=bR7pV2MoNJ5G9xz7oeDQbR5oNO2mVhTYhWf/xwJw4Taa5tnUbhPDoGB+vwSOE+7MD1
         1CLRFVLs1p/HG9s4Fh/odgGz0bl+7vpF7lz+e7GOOBU7WUShrxY+ltc4H4vblFPS7M0l
         Hy5Wq42XEZVLQ4nPYR8NWXjenhT3pGoISGSu4ajcKiyBT3Z7sN+X23lInK2wEmCPUIV+
         M6qZ+d5YkM9fQ5R93p8KWhb+RszRQliuJZJjOJ6ilOGdFtjwM/sVCS+dPj5uthi97HqA
         JQynscHMhS8TrkGBBxNeNpdzGCzybY2ZE09jxMYvb3GqlA0O8WUZi0fmouubpPUH3Lkv
         mI0g==
X-Forwarded-Encrypted: i=1; AHgh+RrcLtaoajEN5Hw+ZJcQ39AGX50l1vU4cJWwX+tYZGYneoXxN4np2hsdfEU8AsUJgiurEwVfbag=@vger.kernel.org
X-Gm-Message-State: AFuF++nNyB/QgU2lCPdQWKcEd/QCaKTkr/zCWbDlgnIfb/NF5bYKYpPN
	8EvDAe3UW9pSeYFpOX5S0ixApotK/lkDrCdISG4oQFaSf3pdnfjo3d2hebKp7cVElEI=
X-Gm-Gg: AR+sD10oDVnSV0KFp+iDTO5ifCpmcAPmDjDRN498rA9Jr21P8NyrWX5deKn30oel7cQ
	J6MecExGij3vyRknsHBZciRHlw+og+3kqPkN4BJdvmtKfkQCBMf+tu/nBXcvLA6jWfardXAZGvZ
	up4H6vCdPXalxnXFhdK94+5x+nzCit8db2huNFxJsAMC2tkEGbzDyL7+vqieABu4pcHrEdEYj3Q
	SLj7A4EnMl3VRzyGdWyjyB7voqoY4Mp0EaY4C/RJlY4PuQ2x6ZwvhN3baAuRnH66drDrrhAB3Bv
	hQGOxjyOW8oFgtontPn8sArwxBhUfpeEncF3ElSkziUniUJzQFrjn3Oj/YZMM7MZn+oIZWgCTRG
	t7eTZACaHzL+3tn6kdvLdPKU7uRSbvRFKrG6kATj2rYB5wYXRBdJpOKSFIA5VtW4oGK+M3babx7
	skKU7vgAxi26sjUa3SUkMdaEobDsEE2h6jY6L5ldZCIKhJ6Frpio3QEyZYli7cN1/6w/Pgxhz1L
	z0eX9Q43Hqo2K/fDgW8NLlIZI1COFcP0h3FNJDNZAeMfx9XCA==
X-Received: by 2002:a05:622a:394:b0:52d:8854:3e61 with SMTP id d75a77b69052e-52fb94b8f4fmr119108521cf.22.1787945479239;
        Fri, 28 Aug 2026 12:31:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fbe5824f3sm19048831cf.10.2026.08.28.12.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 12:31:18 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	urezki@gmail.com,
	chenwandun@huawei.com,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/mempolicy: take a cpuset cookie for the interleave node count
Date: Fri, 28 Aug 2026 15:31:11 -0400
Message-ID: <20260828193111.1023497-1-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_pages_bulk_interleave() counts pol->nodes without a cpuset cookie:

	nodes = nodes_weight(pol->nodes);
	nr_pages_per_node = nr_pages / nodes;

nodemask_t spans several words once MAX_NUMNODES exceeds BITS_PER_LONG, so
a concurrent cpuset rebind can tear that read and yield an empty mask even
though neither version of it was empty.  The call then allocates nothing
and returns 0.

Some compilers will hoist the loop entry test above the division,
because nr_pages_per_node is dead when the loop does not run.

	682e:	call	...		<- nodes_weight()
	6838:	test	%eax,%eax
	683a:	jle	692d		<- nodes <= 0 skips the loop
	684a:	div	%rcx

So in most deployments, this div/0 is unreachable - but nothing in the
source guarantees that, it's just not easily exercised.

Take the cookie around the count and bail if the mask really is empty.
Only the count needs it, interleave_nodes() takes the cookie itself so
so a torn read there is already retried.

A rebind landing mid-loop can still leave the count disagreeing with the
mask, so the loop may revisit a node or skip one - but a rebind where
nodes change causes migration, so a handful of misplaced pages isn't
catastrophic in any sense.

Measured on a 72 node VM (NODES_SHIFT=10) with a cgroup v2 cpuset flipping
cpuset.mems between a word 0 and a word 1 node set, and the two word read
artificially widened: 330 zero counts in 130414 calls without the cookie,
and 401 retries with it.

Reported-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Link: https://lore.kernel.org/all/20250907160829.91628-1-chelsyratnawat2001@gmail.com/
Fixes: c00b6b961099 ("mm/vmalloc: introduce alloc_pages_bulk_array_mempolicy to accelerate memory allocation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 79053ece02cd..060a0eb26917 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2592,6 +2592,7 @@ static unsigned long alloc_pages_bulk_interleave(gfp_t gfp,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
 {
+	unsigned int cpuset_mems_cookie;
 	int nodes;
 	unsigned long nr_pages_per_node;
 	int delta;
@@ -2599,7 +2600,16 @@ static unsigned long alloc_pages_bulk_interleave(gfp_t gfp,
 	unsigned long nr_allocated;
 	unsigned long total_allocated = 0;
 
-	nodes = nodes_weight(pol->nodes);
+	/* count the nodes, retry if a rebind happened during the read */
+	do {
+		cpuset_mems_cookie = read_mems_allowed_begin();
+		nodes = nodes_weight(pol->nodes);
+	} while (read_mems_allowed_retry(cpuset_mems_cookie));
+
+	/* if the nodemask has become invalid, we cannot do anything */
+	if (!nodes)
+		return 0;
+
 	nr_pages_per_node = nr_pages / nodes;
 	delta = nr_pages - nodes * nr_pages_per_node;
 
-- 
2.55.0

