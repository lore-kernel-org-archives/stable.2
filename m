Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FBD395AF4
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321371; cv=none; b=ml+vQ1yHlh6MW5FVVvtgzAJOQzU0Dc3iDaccZ16KWGSBk2tSZbmkYddc92M1D6PECpapESSRbov/2tA+pBSS/55PvkHCsjr746LCWv9/QGb8LRuXCLWwKIWGZ+yq0UcIxVXPeQWGGux1FQN/jwdwBqPQSnvS8ZNo2u/Owq8zEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321371; c=relaxed/simple;
	bh=uXLHeRXp3Fx0FyIquyHmKeEVWfe29NXBoFrz+vJfmRs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pj3kbQ3cKwDaC6bpWr45Jc8SdeihbH8q4/1zww/G22H+gf/gKVW/rJO46YtDkJbP9uuVzP1l0oje04Yy7s6RMd3dEg/kp0OFyoE02pm6E05M0gVwjO08/his/Aw77dsnBDuNNToLyy7v5vgBLJ0h9+SnhtP7p+LwCcCvbrIPf/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vf5Ax49I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vf5Ax49I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836221F00A3F;
	Wed, 29 Jul 2026 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785321370;
	bh=kIZSYSGvzEwHeuyRNW9dB4K7+vC9sSQwZsh3E5KShIA=;
	h=Subject:To:Cc:From:Date;
	b=Vf5Ax49IMoaZqtdDHGf15czr8Yy6PwqPgSN01Dn5A4Gc8C1dx+o5XElHJ8xZFPiKq
	 5UxhZvPDRAp1qUm1tWgSwoKeqJ/vhwp4OCjkakjdWRkk+EQCZ14k1Kgkgagh62CVx2
	 q7jDbFWglyT3tKa8Gr4wFJd5ueuOg1M9jMi873iE=
Subject: FAILED: patch "[PATCH] drm/dp/mst: fix OOB reads on 2-byte fields in sideband reply" failed to apply to 5.15-stable tree
To: ashutoshdesai993@gmail.com,lyude@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:35:56 +0200
Message-ID: <2026072956-send-spouse-819c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6b89ba3dba2f583626fb693e47e951ffb8bf591f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072956-send-spouse-819c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b89ba3dba2f583626fb693e47e951ffb8bf591f Mon Sep 17 00:00:00 2001
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
Date: Sun, 10 May 2026 20:31:28 +0000
Subject: [PATCH] drm/dp/mst: fix OOB reads on 2-byte fields in sideband reply
 parsers

Three sideband reply parsers read 16-bit fields as:

  val = (raw->msg[idx] << 8) | (raw->msg[idx+1]);

and check bounds only after the fact. When idx == raw->curlen,
raw->msg[idx+1] reads one byte past the received message data into
the following struct fields (curchunk_len, curchunk_idx, curlen).

Affected functions:
 - drm_dp_sideband_parse_enum_path_resources_ack()
   full_payload_bw_number and avail_payload_bw_number fields
 - drm_dp_sideband_parse_allocate_payload_ack()
   allocated_pbn field
 - drm_dp_sideband_parse_query_payload_ack()
   allocated_pbn field

Fix by using a single combined check (idx + 2 > curlen) before each
2-byte read. Since the check is strictly tighter than idx > curlen,
no separate step is needed.

Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper (v0.6)")
Cc: <stable@vger.kernel.org> # v3.17+
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
[added fixes tag]
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patch.msgid.link/20260510203128.2884846-1-ashutoshdesai993@gmail.com

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 2ca1f2e9712c..4de36fda0544 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -934,16 +934,13 @@ static bool drm_dp_sideband_parse_enum_path_resources_ack(struct drm_dp_sideband
 	repmsg->u.path_resources.port_number = (raw->msg[idx] >> 4) & 0xf;
 	repmsg->u.path_resources.fec_capable = raw->msg[idx] & 0x1;
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.path_resources.full_payload_bw_number = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
 	idx += 2;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.path_resources.avail_payload_bw_number = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("enum resource parse length fail %d %d\n", idx, raw->curlen);
@@ -961,12 +958,9 @@ static bool drm_dp_sideband_parse_allocate_payload_ack(struct drm_dp_sideband_ms
 		goto fail_len;
 	repmsg->u.allocate_payload.vcpi = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.allocate_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("allocate payload parse length fail %d %d\n", idx, raw->curlen);
@@ -980,12 +974,9 @@ static bool drm_dp_sideband_parse_query_payload_ack(struct drm_dp_sideband_msg_r
 
 	repmsg->u.query_payload.port_number = (raw->msg[idx] >> 4) & 0xf;
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.query_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx + 1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("query payload parse length fail %d %d\n", idx, raw->curlen);

