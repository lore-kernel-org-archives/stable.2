Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430639;
	b=p9FRZF2VYVPRHYgawxPpVuRL+5p1z7JZ+h/TSWcU+ZSLiuE1HY73t9nKUSBU8t+mSFKM
	 Lu2InZ9U08kC1X/Jhy/bHSu8cK4B2DgXHDsQzXutFqKJMFYDiKIBpOX4sxnCb60Ptu7Hd
	 tRYHTKwwD6EW3yXp3zrBzLljDiB7P+XgJ8bmjf5mRs5xtBv1dqIjVRt+H8p7SxnHqBFYh
	 m7XNFrCIA55lWeLCvfsi9tXMXD7XELl4AS/m4QptKnSXHT1FcIHndH9OLVtkmx3EVAH37
	 ccwcYMH5cAgo5MXi6/3DzcGW7BZHrgK14dBU15TAEIzbAUFb6x0Yx0DPs8i7htKC49w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cayAcl4iw+jItAg5iPx/bsdxEdOf5W6Rz7FTZGlHvQ4=;
	b=bNpLfv3QJ48lCVr5Cb0LGlLggKxRiqIcq8dB6iKSCd/XCrHc0wS553QNt7R8W1+PqXNW
	 kT2aN9Yrh4Wi4rpLow8irDHtPNY4OabQopBYmojcE1ToAvIfhFD9Na/C52mpcOso5qysE
	 lfCMj+JNdq8a9Su0HLvCu5IaT06+p+CZDyVXCi4C0pu4tLWzsnRWbNGB3H/hhgxJzQ/Cl
	 XTlBv6pJb0INeZW6dxtsQLxbJwJj1JGYPhs5XenuuA0rzqkjAvfnT9iHakFkf17aRmXOJ
	 qsBO9cqGbOS3F0mn+rpyYZBc3z5IXlw7vvCqCFLMayd6m+eTAfVmFgazgj2gehdT37w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EKPwfQd9;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA86606A32F
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FA86606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EKPwfQd9
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-530e75d1ba1so21923121cf.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792430638; x=1793035438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cayAcl4iw+jItAg5iPx/bsdxEdOf5W6Rz7FTZGlHvQ4=;
        b=EKPwfQd9pAhY7OObaKd/t/kqhBeCzJPYyo5VhltFiKZEWE1qwvj3Syny3KlfLejZpy
         MQtvBVKKv44Xj4qlYKXUUo6BJB8fR2XnzurPWj2VA5i3j2Y/lKopFNoVESi+bmVNGbR6
         zoctzZSSXKrn2GOFCfWPyyXAFGMT5IBAhutYVUGwRwqc7+q2Lz2e/FvqXzMIc0sRFYQ9
         hHbtmBA7Z/sM8C23LsRN4D+ScsbW/rUEG8gTqvtJv0tk15sSnis5b4rFlpAH4yu9BAmi
         mRPWrmIw4iG9o4UDwt6HpIEOMjs368mjoJzW9aK6n/2v7m8bNqlJdy4Qjjwdk6sr9iYd
         51Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792430638; x=1793035438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cayAcl4iw+jItAg5iPx/bsdxEdOf5W6Rz7FTZGlHvQ4=;
        b=yEd4KjtqyHRGQotfiZSZONK76VegdNXXDdmNXxxvmP0ruVAPsNdRJIuG7n1zzlhlxx
         r3Y3lOqryckZasWoZimqqkfExhgm3aLPwha6m4WDQ9udcqpDTcNwTsnwxzSlY0v8D/sC
         yORZh2u1k8GCn0qssL/q/aD7Xv8vF4c0auDZoCLYx+6DVyqufU28mzBpc9FYt10FcDa7
         fl1NZEnoyNvbP+whfSGS4J0iMCPpSonONZo0c0MxZ3InvrDw5vHRIyLEUcK6Mz2aBoh6
         5jPHlXee4X/AHX8bV9U1ZBqZ249ouMNZQSBy5tHZnrYRFkJjrm7SuHgcPS2iuu/2Gu73
         OH7w==
X-Forwarded-Encrypted: i=1; AKwUvBxPrw4j674Y6mIclXiSrZ0LNmwhuzxbZshdgaEC9u6tb5EfOxvF9OElC5UzisOm0YUOQ8uKxso=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEPKERjJVaCVBLPm7/+PdoZL6B8whCIc81ITRBL9DJ0eeETCpr
	ptrPtI5h8/duOmqfaj9dPdzf4Zak8jFu12jFeVFa78p0IyuX1BjzahYhkH2NAy+hTms=
X-Gm-Gg: AYBFou3rPL8wxI22qqRwpe1K8jfi5h84nL8RSx5d/ZaAlhR9Lny7I/RoZp4b09bfLG/
	XrpwUtuQ/ESgcWpz7F4XmpenE3Ron3WxTvYuitDKRJkjhGo6UKaiHIaNxkrGULx/DOziBUqp7eI
	DrGkrCo7FH7tHmZlOpByfMdHy9jl/XmIERehJF51hvXMgzEUtw88UQe9nUnGqOPBl0bFKvC+Im1
	2qRSzZUA0957hH3pXS+3S7wSUc65ErPILiiQ8jpqt43y+74hFOqUTmtz/8m6mqh/W+K1ssvbQLm
	axJc9sL6QxKDUwsbIydql1TJ6dSBQ1u0NTRM/8AuejKlqMJLELoj+YEgBVDhWrh3709U1D+BuRZ
	OhJJOf4F+SChecto1DCfhNISyfQHdTrBzU2stO9f8BJqfldyBXo4hOJoB555jaa9wGjFInyWCFJ
	tNkWciYqX63F/L9dw24jnVWxL6YTk4TB/DM8p06NJP+11llJ5PVc4rgw3WG/qxDJUPpzFCwxrg8
	Prp8gyzaw8bzHZMuU8KKxwiNSAv+ioZqb4IkWDNHWZHUFJvaDZ/7oFLB14L
X-Received: by 2002:a05:620a:3710:b0:93f:43a4:a479 with SMTP id af79cd13be357-93f43a4a615mr343361385a.66.1792430638159;
        Mon, 19 Oct 2026 10:23:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4adb28c2sm14615385a.0.2026.10.19.10.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:23:57 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	mgorman@techsingularity.net,
	jiang.liu@huawei.com,
	Bessel.Wang@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v2 5/5] mm/mmzone: read each zoneref slot once when filtering by nodemask
Date: Mon, 19 Oct 2026 13:23:45 -0400
Message-ID: <20261019172346.3344005-6-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019172346.3344005-1-gourry@gourry.net>
References: <20261019172346.3344005-1-gourry@gourry.net>
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

__next_zones_zonelist() tests a slot's zone for NULL, then reads the slot
again to look up the zone's node. Offlining a zone's last block rebuilds
the zonelists in place, so the second read can return the terminator:

  CPU 0                             CPU 1
  __next_zones_zonelist(nodemask)
    zonelist_zone(slot 1) = NORMAL
                                    offline_pages()
                                      build_all_zonelists()
                                        [MOVABLE, NORMAL, NULL]
                                        -> [NORMAL, NULL]
    zref_in_nodemask(slot 1)
      zone_to_nid(NULL)

Current GCC and clang merge the two reads, but nothing requires it. With
mm/mmzone.o built with -fno-inline -fno-ipa-sra, holding a nodemask
allocation between the reads while the node's last movable block goes
offline oopses every time:

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:zone_to_nid+0x0/0x10
  Call Trace:
   zref_in_nodemask+0x9/0x20
   __next_zones_zonelist+0x23/0x70
   prepare_alloc_pages.constprop.0+0x16c/0x190
   __alloc_frozen_pages_noprof+0xaf/0x330

Read the slot once and test that zone. A NULL zone still ends the walk.

Fixes: 11cd8638c37f6 ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mmzone.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/mmzone.c b/mm/mmzone.c
index 9cc9ef588580d..009f1dd75dde8 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -43,13 +43,14 @@ struct zone *next_zone(struct zone *zone)
 	return zone;
 }
 
-static inline int zref_in_nodemask(struct zoneref *zref,
-				   const nodemask_t *nodes)
+/* A NULL zone terminates the zonelist, so it ends the search. */
+static inline bool zone_in_nodemask(const struct zone *zone,
+				    const nodemask_t *nodes)
 {
 #ifdef CONFIG_NUMA
-	return node_isset(zonelist_node_idx(zref), *nodes);
+	return !zone || node_isset(zone_to_nid(zone), *nodes);
 #else
-	return 1;
+	return true;
 #endif /* CONFIG_NUMA */
 }
 
@@ -67,7 +68,7 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
 			z++;
 	else
 		while (zonelist_zone_idx(z) > highest_zoneidx ||
-				(zonelist_zone(z) && !zref_in_nodemask(z, nodes)))
+		       !zone_in_nodemask(READ_ONCE(z->zone), nodes))
 			z++;
 
 	return z;
-- 
2.53.0-Meta

