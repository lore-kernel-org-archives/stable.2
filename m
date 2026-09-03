Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F84AA59F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443211; cv=none; b=BFRTsmGmvdw8gdW8Ygc+dnb2yE81iob1dIJlk6JtpTSZnxJwt5AM1wNHOAx/odU5ziSodBcDSRZE5+wpKEyXUX9uY5WcQt+QGCz9K12fb4VJRNXJntVbSWe9OX8VAPOzdYMgyPJncZDDCyXv0rrf4fnlW505uqIB9oA4Ql0mTao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443211; c=relaxed/simple;
	bh=kbmgv9xiUlxAfEgPN981qYeDU/4wfc3QGjr5IS5d0ag=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hufUJ173Qwol3KS+V98G9HuIu+js1pnjCwiMjN+ZIHmz9caidFiuYr442nyfAdaFYvck3Mb/KApRpKZpc6pqKLEV1GS5hxyIEc+OBr88Jms3DxWttQvHHMWhyU0zpitaHxXa8VtLBcUW/TQZ/d6ZHAuXZAYgJe3VjWpsm5NhcNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SgKE0JAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SgKE0JAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDF11F00AC4;
	Thu,  3 Sep 2026 13:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443197;
	bh=n/5qSEK7FlzV3zS+gnob9cudut5ZQnDFI3EX1r5+HAM=;
	h=Subject:To:Cc:From:Date;
	b=SgKE0JAl5EkTRx9lvocAzFpnKpAImPa2Ca+hSH2cXSue5E6JlYry6ABz/PYjRPLLO
	 5lzwobWQ0YF3bojX6d0WKoMQfbMF4+2wVPPFjVAH6F6IDmfq8gBQl4allXJRoNtULM
	 bxx2t9zGwlIFaqZPx8vwsRfPoT2wGZik3UF9w73c=
Subject: FAILED: patch "[PATCH] ceph: bound num_export_targets array for mds info v2/v3" failed to apply to 5.10-stable tree
To: michael.bommarito@gmail.com,idryomov@gmail.com,slava@dubeyko.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:22:36 +0200
Message-ID: <2026090336-mashing-extended-23ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a3eb169ee297aa99670ba927c659990bd1e453f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090336-mashing-extended-23ed@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a3eb169ee297aa99670ba927c659990bd1e453f3 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 7 Jul 2026 14:05:59 -0400
Subject: [PATCH] ceph: bound num_export_targets array for mds info v2/v3

ceph_mdsmap_decode() in fs/ceph/mdsmap.c reads num_export_targets from
each per-mds info record and advances the decode cursor by
num_export_targets * sizeof(u32) without first checking that many bytes
remain. The only upper-bound check that catches a runaway cursor
(*p > info_end) is gated on info_v >= 4, because info_end is left NULL
for info_v 2 and 3. When the monitor sends an MDS map whose per-mds
info version is 2 or 3 with an oversized num_export_targets, the cursor
moves past the message front buffer and the later export-targets loop
calls the unchecked ceph_decode_32() on out-of-bounds memory.

A kernel client processes CEPH_MSG_MDS_MAP from its monitor session
(net/ceph/mon_client.c dispatches it; fs/ceph/super.c routes it to
ceph_mdsc_handle_mdsmap(), which sets end to the front buffer bound and
calls ceph_mdsmap_decode()). A malicious or compromised monitor, or an
on-path attacker on an unsigned/unencrypted messenger session, can
therefore drive an out-of-bounds read in the client kernel; on x86_64
with KASAN it is reported as a slab-out-of-bounds read in
ceph_mdsmap_decode(). The decoded values land in the internal
info->export_targets[] array, so the consequence is a kernel
out-of-bounds read, not an information leak to the attacker.

Impact: a malicious or compromised Ceph monitor sending an MDS map with
a per-mds info version of 2 or 3 and an oversized num_export_targets
field triggers an out-of-bounds read in the CephFS client kernel.

Add a ceph_decode_need() for the export-targets array before advancing
the cursor, so the bound is enforced for every info_v >= 2, not only
info_v >= 4. This mirrors the count-then-need idiom already used for
m_data_pg_pools later in the same function.

Compute the export-targets byte count with size_mul() and reuse that
checked length when advancing the cursor, so the attacker-controlled
num_export_targets multiplication fails closed on overflow rather than
relying on the later kcalloc() guard.

Cc: stable@vger.kernel.org
Fixes: d463a43d69f4 ("ceph: CEPH_FEATURE_MDSENC support")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 450a4dc9662e..4f0626753429 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -3,6 +3,7 @@
 
 #include <linux/bug.h>
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -126,6 +127,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 	u8 mdsmap_v;
 	u16 mdsmap_ev;
 	u32 target;
+	size_t export_targets_len;
 
 	m = kzalloc_obj(*m, GFP_NOFS);
 	if (!m)
@@ -224,8 +226,11 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 		*p += namelen;
 		if (info_v >= 2) {
 			ceph_decode_32_safe(p, end, num_export_targets, bad);
+			export_targets_len = size_mul(num_export_targets,
+						      sizeof(u32));
+			ceph_decode_need(p, end, export_targets_len, bad);
 			pexport_targets = *p;
-			*p += num_export_targets * sizeof(u32);
+			*p += export_targets_len;
 		} else {
 			num_export_targets = 0;
 		}

