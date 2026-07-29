Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD7486B86
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332873; cv=none; b=eZDDkWfbcNlV0igXlTX4fMTm/adpEpVDCtTvWJWJ9jU1XJhihCifKmXPy8rhuz9R1WO4MOcbvCsQGQ/YY0VTSuZAGRZm9VS4sSSuD/Yx4novtBVFw2/HT+A6+pEJ6DexhpJW1xrZ/av7ZI8DnAAVrnletwfNAFQ+NMWp1HxTna8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332873; c=relaxed/simple;
	bh=I9pznMt8tU1TvgkAea/WbxmfPGv9jzA70/x6s+0gDRU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z2sdNHI/d0HLFno8AXM8FbkkoFDxP/Nj3DmRwYYZ7LvNQ8GqSy82V/B1uQsMAxSxONC4yYMfiIlCFDsPu1a3seMHqQJb2A9lzPJNn2rRuiBUgVVA2F8nJY+59LGfRIrh6xHdL9M5sNdvAxKHLh/Nzvw83a1F4RA/GoSLW3JDW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JOnpC3kU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JOnpC3kU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AEB1F000E9;
	Wed, 29 Jul 2026 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332872;
	bh=JMwyF3N7t5FNRrDLi+sWcJ+EGs2XEdZOrCugGeU36vE=;
	h=Subject:To:Cc:From:Date;
	b=JOnpC3kU9E8B8hPjC8OOv+0xeW2vIYXo1bmGfTC7eansRjHULeU7WzoOJhAB2bwDd
	 Cc9AJ+QLRg5475LsFszfk68beMHxVuHI2/zMDmZYFCn4fFTl46ys7HmRxuSFiUAVGo
	 hfJfzT6RyO8vb1n96yxx1rlqQmsmsqOVTOrcpHSo=
Subject: FAILED: patch "[PATCH] libceph: bound pg_{temp,upmap,upmap_items} length to" failed to apply to 6.18-stable tree
To: xmei5@asu.edu,amarkuze@redhat.com,bestswngs@gmail.com,idryomov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:47:27 +0200
Message-ID: <2026072927-cloud-mustang-1d03@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9f00f9cf2be293efe899db67dc5272e3a9c62717
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072927-cloud-mustang-1d03@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f00f9cf2be293efe899db67dc5272e3a9c62717 Mon Sep 17 00:00:00 2001
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 8 Jun 2026 21:40:09 -0700
Subject: [PATCH] libceph: bound pg_{temp,upmap,upmap_items} length to
 CEPH_PG_MAX_SIZE

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

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 04036c047b8c..a4b0dd8672ec 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1438,7 +1438,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(void **p, void *end,
 	ceph_decode_32_safe(p, end, len, e_inval);
 	if (len == 0 && incremental)
 		return NULL;	/* new_pg_temp: [] to remove */
-	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
+	if (len > CEPH_PG_MAX_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, len * sizeof(u32), e_inval);
@@ -1619,7 +1619,7 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
 	u32 len, i;
 
 	ceph_decode_32_safe(p, end, len, e_inval);
-	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
+	if (len > CEPH_PG_MAX_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);

