Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7103C5525
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321287; cv=none; b=pvwGxh11btQpZnySStuH8xPQDrVdhfYiTkEve40/UX4DvvVeVhCuwbVl4VZC1lKtejM6pd1/ywJJQCO/h50Zq2xuymx04iylG26x7RRw8SntDqkThm6N+Svb35uTkUC7bMJGw0Bm9T3y5jFwtN+jI/sEMRHau1x6MOGszAw2/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321287; c=relaxed/simple;
	bh=pRJrBUIFX7RfiE9cb3mLitPDQrfrfM1Asl9oTK8kYFs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lvifXJNCpebWrpHermw6rJ+BJpRB9jnMdGqriQjOF2vxXoBwgijqIKCLzrsZWS6rPbeq4H85zYbiIgrRReHcakAeMP5iDydUbam1wM38G2SmyAWvFJ9mHxyEXVZW9dgHOexgDwSwhu7mg/n1tSF1S7H47yXtx2vAvXMcQKxDAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sobE7Pkb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sobE7Pkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E181F000E9;
	Wed, 29 Jul 2026 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785321285;
	bh=p+YgIjyZDxARqmpK3iHlbGvzH5rUF7j1rwsgqunLl5E=;
	h=Subject:To:Cc:From:Date;
	b=sobE7PkbMSvxC65tu1oL+woZMMkagntulAvSrZyp6Z+/DfAOscGsXvULZlI3DJ14b
	 Tv2Kjfp6LsY8uth+FdPUFGg5IiOYj3vb1aUz83Ck7Es7mX+ymUuM6cPXm6VRhqk6/J
	 B+Dcyhyz2rEpmUSVXsUXoaw7Ge8XMbppZ5bZ0M48=
Subject: FAILED: patch "[PATCH] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply" failed to apply to 5.10-stable tree
To: ashutoshdesai993@gmail.com,lyude@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:34:24 +0200
Message-ID: <2026072924-dexterous-hypnotic-2767@gregkh>
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
git cherry-pick -x 1a8f537f5a1eeac941f262fe73078d6b08ba83c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072924-dexterous-hypnotic-2767@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1a8f537f5a1eeac941f262fe73078d6b08ba83c0 Mon Sep 17 00:00:00 2001
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
Date: Sun, 10 May 2026 20:17:33 +0000
Subject: [PATCH] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply
 parsers

drm_dp_sideband_parse_remote_dpcd_read() reads num_bytes from the raw
message and then unconditionally does:

  memcpy(bytes, &raw->msg[idx], num_bytes);

without checking that idx + num_bytes <= raw->curlen. raw->msg[] is
256 bytes; if a malicious or misbehaving MST hub sets num_bytes larger
than the remaining payload, the memcpy reads past the received data
into whatever follows in raw->msg[].

drm_dp_sideband_parse_remote_i2c_read_ack() has the same flaw (noted
with a /* TODO check */ comment since the code was introduced).

Fix both functions by using a single combined check
(idx + num_bytes > curlen) before each memcpy. Since num_bytes is u8,
it is always >= 0, so this strictly subsumes the simpler idx > curlen
form and no separate step is needed.

Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper (v0.6)")
Cc: <stable@vger.kernel.org> # v3.17+
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
[added missing fixes tag]
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patch.msgid.link/20260510201733.2882224-1-ashutoshdesai993@gmail.com

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index fe72245fb9ca..2ca1f2e9712c 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -880,7 +880,7 @@ static bool drm_dp_sideband_parse_remote_dpcd_read(struct drm_dp_sideband_msg_rx
 		goto fail_len;
 	repmsg->u.remote_dpcd_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + repmsg->u.remote_dpcd_read_ack.num_bytes > raw->curlen)
 		goto fail_len;
 
 	memcpy(repmsg->u.remote_dpcd_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_dpcd_read_ack.num_bytes);
@@ -916,7 +916,9 @@ static bool drm_dp_sideband_parse_remote_i2c_read_ack(struct drm_dp_sideband_msg
 		goto fail_len;
 	repmsg->u.remote_i2c_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	/* TODO check */
+	if (idx + repmsg->u.remote_i2c_read_ack.num_bytes > raw->curlen)
+		goto fail_len;
+
 	memcpy(repmsg->u.remote_i2c_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_i2c_read_ack.num_bytes);
 	return true;
 fail_len:

