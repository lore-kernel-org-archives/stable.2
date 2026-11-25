Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567068;
	b=A3dqjKu7WmNJmkY/Mh5LmUFE87S5fypnQGNQDRLx9IVT2GHS2XKILZVKVFiIy54FYOB3
	 MxC5sscdSxMWVRt8bZdVT8xVzQ6rv0gWsxe++2f2yAhjlTUEnqyNqscgMQzmgwfG1j77k
	 iiFufVKMk8aXbpPiqbiNRtISBVJB9rKFaxWDJrHd3uyJKE//gGIAECC02rkttD6gH3M+Q
	 8NwfwVRQeYMaRdGe6XpgrCVOzCmym/ulU9rbI9MSNA/U0rvg/Z29D1k9VkHyD3xefN+G3
	 9/znxIhsf7ze4Uely0LcAkVs0XNqV5uLosDs98Kqst1bP+gIzPEBovGyUMd/JCUG9TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567068;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bo3lCC5V/nyWJ201e089zcZ3P+nMdJPFjMVt5IoTp08=;
	b=w0OkGnrJG7Boh9oEE8+GkHOq/dhbGYjEr3d0HwDE8iYg1mUy5mcleYlGT91d5O/MDlwj
	 UFJ8fa7uYoZBA7jyDMuHEcSYudpkPqZNBMS8LVcva+j7mYlZY5DoooVmO1Nf22zMK7Aie
	 bRP75uhyNR61OtMaQ81A/uDKd5VOnVQm88Ulh5+bE5MmC2aXbmfMWrlfmJvyN8EuHiz7y
	 6uUYZA1v+RRgSRlB4MzMo8LMlJD+IhYzsizA6SEj2jNqD9HDSxcm8Sszb8PSd99GYpf8z
	 ktfwFQr9MrV3FlQY+wo6bq4HrOvuteQzrNLraBmQkqioeZz2+fDiiz7cGBPWmcRJneA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gythByQW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8736606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gythByQW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7281F000C0;
	Wed, 25 Nov 2026 00:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795567068;
	bh=bo3lCC5V/nyWJ201e089zcZ3P+nMdJPFjMVt5IoTp08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gythByQWbvBAETPOxA5Rbs6Xfkyznf7Yrm0cv3H2bUhjsoxzNzmKEu2H6dbmqwZz3
	 e+iuviJRqMuQaq7mcWwLHcl+/Xyo2nr3MB6HrOTbe79oiTULEKqve7gu9WPnxwJwOV
	 +IvnycubuE6HsrTiHqgYU6WhmMm8QG6749cDFD1/vYX+fqae8nh/TrcE2HMimeKEoW
	 UFucx5G5NRpw2OyWUwVrAJWfoPzVcN2AVGZEVQW1zLv8fvgxR00YqoCZYufzzkJLTE
	 7aC+3kiE67MGJJLBdIZ9z+lQGu/tkVUa+IrriNcC5DMVTdX25Q8G9jR6/aQIsvZWil
	 QhGvkRBBoe0Tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/page_alloc: retry allocations that raced with a zonelist rebuild
Date: Tue, 24 Nov 2026 19:37:45 -0500
Message-ID: <20261125003341.3448163-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112441-trio-lethargic-5ff6@gregkh>
References: <2026112441-trio-lethargic-5ff6@gregkh>
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

From: "Gregory Price (Meta)" <gourry@gourry.net>

[ Upstream commit bcfc8286f0cd5a74c827d502f9f1ad408d7eff30 ]

Onlining the first block of a zone rebuilds every zonelist in place,
shifting the slots after the new zone.  The iterator approves a slot,
then the allocator loads the zone from it, so a GFP_KERNEL request can
land in ZONE_MOVABLE and a nodemask request on a node outside its mask:

  CPU 0                             CPU 1
  prepare_alloc_pages()
    first_zones_zonelist(nodemask {1})
      slot 0 (NORMAL1) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [NORMAL1, NORMAL2, ...]
                                        -> [MOVABLE1, NORMAL1, ...]
  get_page_from_freelist()
    zone = zonelist_zone(slot 0)    /* MOVABLE1 */
    allocates from MOVABLE1

zonelist_update_seq detects the rebuild, but only the slowpath's failure
exits check it.

Check it whenever an allocation succeeds too, and if it changed, free
the page and retry, as the memcg charge failure path does.  Eligible
pages are dropped as well: zonelists only change when memory comes or
goes, and a retry is simpler than rechecking the page.

Freeing the page does not undo a block the allocation claimed.  A
GFP_KERNEL request that lands in a fresh ZONE_MOVABLE converts a free
block to MIGRATE_UNMOVABLE, which stays until the zone's movable free
list runs out and a movable allocation takes it back.

The fast and bulk paths read the seqlock's raw seqcount without waiting:
an ALLOC_NOLOCK caller can be an NMI that interrupted the writer, and on
PREEMPT_RT the seqlock accessor takes the spinlock.  A sample taken
mid-write costs a retry, or NULL under ALLOC_NOLOCK.
check_retry_zonelist() returns 0 when compiled out, so a backport
without the hot-add change stays harmless.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Link: https://patch.msgid.link/20261101021340.2251928-9-gourry@gourry.net
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
[ sashal: Dropped the bulk-allocator and ALLOC_NOLOCK/FPI_NOLOCK parts, applied the fix in __alloc_pages_nodemask(), and used __free_pages() in place of __free_frozen_pages(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cb0614988479a..9b928a4f11782 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4346,12 +4346,25 @@ static unsigned int zonelist_iter_begin(void)
 	return 0;
 }
 
+/*
+ * Never wait for the writer, which an ALLOC_NOLOCK caller in NMI may have
+ * interrupted. Read the raw seqcount: on PREEMPT_RT the seqlock accessor takes
+ * the spinlock while a write is in progress.
+ */
+static unsigned int zonelist_iter_sample(void)
+{
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		return raw_seqcount_begin(&zonelist_update_seq.seqcount.seqcount);
+
+	return 0;
+}
+
 static unsigned int check_retry_zonelist(unsigned int seq)
 {
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
 
-	return seq;
+	return 0;
 }
 
 /* Perform direct synchronous page reclaim */
@@ -4952,6 +4965,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
+	/* A rebuild during the walk may have handed out an ineligible zone. */
+	if (page && check_retry_zonelist(zonelist_iter_cookie)) {
+		__free_pages(page, order);
+		page = NULL;
+		goto restart;
+	}
 	return page;
 }
 
@@ -5012,6 +5031,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
 	gfp_t alloc_mask; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
+	unsigned int zonelist_iter_cookie;
 
 	/*
 	 * There are several places where we assume that the order value is sane
@@ -5024,6 +5044,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 
 	gfp_mask &= gfp_allowed_mask;
 	alloc_mask = gfp_mask;
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
 		return NULL;
 
@@ -5035,6 +5056,10 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 
 	/* First allocation attempt */
 	page = get_page_from_freelist(alloc_mask, order, alloc_flags, &ac);
+	if (likely(page) && unlikely(check_retry_zonelist(zonelist_iter_cookie))) {
+		__free_pages(page, order);
+		page = NULL;
+	}
 	if (likely(page))
 		goto out;
 
-- 
2.53.0

