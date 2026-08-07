Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F836456E19
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140604; cv=none; b=l/WHU/6HYU6LqntYDcNdaA8J4cJCjygdIWTi2VcHRTEtKiU+u2cUxt2iSkZ52kBZaPBwHrVZFRua/49r2/FKlBmUBYbaeDzt/Y7Bf+jfflKOWNpskrxcDvbOFzosTOQEbljCSihSy+PCICAe8yZu2lfbD3lgBFEvFbsBB6VhNiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140604; c=relaxed/simple;
	bh=Ng5mgxrp6z0RsLnfS/sFjxzYUHHAj1ruvkr+jG9fj5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MabAtbIG5aROq5M0tyTQ1AJMC2DDx8XiUgGLOKL4LUQKa/lSWfAYLlxgwqZICGl/ZZTmukgMwpkSbvqMgEZElfMZvgGSewO0qKWCGVe3KYd1ymw46lmw9e4+lF4slXbt5ouSMXNi08FnQjXIqICvNMioyziyGo9/x1k/l20S9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcupvtSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcupvtSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825E71F00A3A;
	Fri,  7 Aug 2026 22:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140602;
	bh=GgW9UjzJFRHoAVZ23eP8oyaRj0nXLdMW+susY0Atbh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OcupvtSthqlaTX88oq2YsEwQ93D+FZAzihsYEV24em5BlSg5Nce5MpLEq/9tatLjw
	 Zkdm/FHegtEtD6Bih4kUezVwDLs5SG23UJ8bgA4eOHSVVrQCRN/Oh2W7mzfhDriWVk
	 xDix2C39wtN81V00EacaGDBUe4uxoWsFouMi34WBaYxWK38zTMUu5x0lrv7UhgZoFL
	 l4E+oTTNoMFHfJZKTWGql3cMA1Uwmr8uvWBChr6v+QGApklgmbwYGby5L89Ny7hBYn
	 m5oW43UmUmk7VnTPeAhr39hsfN3ONSS2AUpSwxGb72RXOM5O3pyfgiQaZ+jvP1gTQw
	 /AbZ+aUl2sgiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] libceph: bound pg_{temp,upmap,upmap_items} length to CEPH_PG_MAX_SIZE
Date: Fri,  7 Aug 2026 18:09:57 -0400
Message-ID: <20260807220957.3784015-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807220957.3784015-1-sashal@kernel.org>
References: <2026072927-cloud-mustang-1d03@gregkh>
 <20260807220957.3784015-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang Mei <xmei5@asu.edu>

[ Upstream commit 9f00f9cf2be293efe899db67dc5272e3a9c62717 ]

__decode_pg_temp() decodes an user-controlled length but only rejects
values large enough to overflow the allocation; it does not bound it to
CEPH_PG_MAX_SIZE. The helper backs both pg_temp and pg_upmap decoding, and
apply_upmap()/get_temp_osds() later copy the decoded list into the fixed-size
on-stack array struct ceph_osds.osds[CEPH_PG_MAX_SIZE]. A monitor that sends
an OSDMap with a pg_temp/pg_upmap entry longer than 32 thus causes a stack
out-of-bounds write.

An OSD set for a single PG can never exceed CEPH_PG_MAX_SIZE, so reject longer
entries at decode time. The bound is well below the old overflow threshold, so
it also covers the allocation-size overflow the previous check guarded against.

  BUG: KASAN: stack-out-of-bounds in ceph_pg_to_up_acting_osds
  Write of size 4 ... by task exploit
   kasan_report (mm/kasan/report.c:595)
   ceph_pg_to_up_acting_osds (net/ceph/osdmap.c:2617 net/ceph/osdmap.c:2833)
   calc_target (net/ceph/osd_client.c:1638)
   __submit_request (net/ceph/osd_client.c:2394)
   ceph_osdc_start_request (net/ceph/osd_client.c:2490)
   ceph_osdc_call (net/ceph/osd_client.c:5164)
   rbd_dev_image_probe (drivers/block/rbd.c:6899)
   do_rbd_add (drivers/block/rbd.c:7138)
   ...
  kernel BUG at net/ceph/osdmap.c:2670!

[ idryomov: do the same in __decode_pg_upmap_items() ]

Cc: stable@vger.kernel.org
Fixes: a303bb0e5834 ("libceph: introduce and switch to decode_pg_mapping()")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/osdmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index d8dd8c1cf362e..9ec8bbb625384 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1440,7 +1440,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(void **p, void *end,
 	ceph_decode_32_safe(p, end, len, e_inval);
 	if (len == 0 && incremental)
 		return NULL;	/* new_pg_temp: [] to remove */
-	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
+	if (len > CEPH_PG_MAX_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, len * sizeof(u32), e_inval);
@@ -1621,7 +1621,7 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
 	u32 len, i;
 
 	ceph_decode_32_safe(p, end, len, e_inval);
-	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
+	if (len > CEPH_PG_MAX_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
-- 
2.53.0

