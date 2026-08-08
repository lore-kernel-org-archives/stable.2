Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC73A8743
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786188333; cv=none; b=X96jWc3qsL+2x37JSQBjuMahY+ec+YZ2r34kLiovAjNCyrcjDh2yRR9vFZmCr+zQPVyhaBsrGvXFO/rRLxSZsyMMsyyQWjjs5mP7qzLae8Pd1oWyU9WVRqIik/NDf/ud4sqMDigXiUAuV8otGBYJXDHov3F1Of0aj+IdTqJ5430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786188333; c=relaxed/simple;
	bh=CA6uN8OrZ5Jbp8tiB8Tw1OCPDnXRGxI93B2D6EhBnzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVl+aSB7YxiHIxHukPqqlbHkavGiPCIAzGJk/6E5RIJs83keWkBUdZx9sW1iNd/PM6VeSJbfRFk1m+LWzIy+tXE5siBymkrEKwgtWh1XgTIs7Ej/HjoQi30/9s5WANvHVHQKO1PPO1gyXYbDB1Rnjm4HycuvstCRJVRF9IU6id8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjg1Ni4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjg1Ni4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5EF1F00A3A;
	Sat,  8 Aug 2026 11:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786188332;
	bh=/ws5oHDYDUkU+41pwiihsVwINrMe7IZPX/B3+u0Ba8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wjg1Ni4BFxUPRSI35XLa48gVkUhI+yGpj/rONZfJ2L28qLxHQwrC8XwkJk1ftISU+
	 we2eCwso6UNjZPCZ7TsH4iwfskk1SXQOETHSB29l/9cL/7oaTilrJ5L0yfl3YPfkdU
	 Nm2PEHnb5IbI05td8GJOeTNm4IoTXJzgZZpcfEiUeYVUJz9VM4mfCQPXSEcrvkbLLi
	 qXNr0Vq+bYihBw/0v8ppe2q4I2zd36Nr4JSe73OKgCgVwkzOFca1cO0HanyVAJARfx
	 qsqpvUtFd4zpTDIcD81e3BATK0v3iR2Z/kQebo4UC8tC6reM2sLpW0dOsX+CeOCihL
	 DkjnVh86IO78w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] libceph: bound pg_{temp,upmap,upmap_items} length to CEPH_PG_MAX_SIZE
Date: Sat,  8 Aug 2026 07:25:28 -0400
Message-ID: <20260808112528.101249-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808112528.101249-1-sashal@kernel.org>
References: <2026072929-ritzy-confirm-991b@gregkh>
 <20260808112528.101249-1-sashal@kernel.org>
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
index 763f22a06f05e..5f03bbe78a5a2 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1422,7 +1422,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(void **p, void *end,
 	ceph_decode_32_safe(p, end, len, e_inval);
 	if (len == 0 && incremental)
 		return NULL;	/* new_pg_temp: [] to remove */
-	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
+	if (len > CEPH_PG_MAX_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, len * sizeof(u32), e_inval);
@@ -1605,7 +1605,7 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
 	u32 len, i;
 
 	ceph_decode_32_safe(p, end, len, e_inval);
-	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
+	if (len > CEPH_PG_MAX_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
-- 
2.53.0

