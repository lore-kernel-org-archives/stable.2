Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB73B6362
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575448; cv=none; b=YYZCf1UVd0BdJWhz8B5otNaLZNR0gP55VRkNMAaVMYG3U5hGgyVzQ+8o+lhA4VR55EjigY81pumpx6x9ZBdcMvJvm7PG8G1L7sLvGr7yyhPUbH3/GtyYq4awAST2moxBCvz0E4DwmZNNghGMpM+8vEVu6gBHIZKGManc5/Nf1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575448; c=relaxed/simple;
	bh=EOHDKgUOEsqkst+zh8RpH4jZgEEfZ6AdI8ILpwuetHo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ggt4qhAGJEEEiEqhM9KBYl8tELH7XXWO2HKj2BQpCzTmQmBzah6Bk695yewkRXuuLHZ8tMx5XcbT8MFEVY3zSq4X/M5lCX6G0MtQLUukeaAolFghvYK21vF+Px+zhZKPFTnM8zpeWnBxDW7rIK02M1e1FqSd630+bdYswAAjEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CC3aq8DW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CC3aq8DW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795981F000FF;
	Wed, 16 Sep 2026 16:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789575447;
	bh=K6RxdpiJ+zWMdu9af/VWgNJFsePCZIAByGUuBnbJ0QE=;
	h=Subject:To:Cc:From:Date;
	b=CC3aq8DWOMpOxj+WdrZmFZE8WUbC2pnkwGwfVb1n1v1FugsgcX9CyiWHsU80cubUN
	 C4LSgpKQAbLyLyAnQAC0zY0dbCJNSPDmMmO62z7ayUsM66lvrGkiJ0QAucejMtd1iS
	 zHR7XaV6CBdw6y8JB/VP2noBtbs1IqOTTrSij6os=
Subject: FAILED: patch "[PATCH] media: v4l2-ctrls: validate HEVC tile counts" failed to apply to 5.10-stable tree
To: michael.bommarito@gmail.com,benjamin.gaignard@collabora.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:12:45 +0100
Message-ID: <2026091645-habitat-untoasted-f76f@gregkh>
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
git cherry-pick -x dc694a9929f7cb9c88ef91e45eb982b7bbe5a477
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091645-habitat-untoasted-f76f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc694a9929f7cb9c88ef91e45eb982b7bbe5a477 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 16 Jun 2026 22:18:58 -0400
Subject: [PATCH] media: v4l2-ctrls: validate HEVC tile counts

The stateless HEVC decoders read num_tile_columns_minus1 + 1 entries from
column_width_minus1[] and num_tile_rows_minus1 + 1 from row_height_minus1[]
and use them as tile-loop bounds, but std_validate_compound() does not
bound these u8 counts. Reject a V4L2_CTRL_TYPE_HEVC_PPS with tiling
enabled whose tile counts exceed the uAPI array capacity, mirroring the
existing compound-control range checks.

Fixes: 256fa3920874 ("media: v4l: Add definitions for HEVC stateless decoding")
Assisted-by: Claude:claude-opus-4-8
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 5b8a594fb9e2..9b6121a3a2d2 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -1253,6 +1253,18 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 
 			p_hevc_pps->flags &=
 				~V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED;
+		} else {
+			/*
+			 * These count the entries the stateless HEVC drivers
+			 * read from column_width_minus1[] / row_height_minus1[]
+			 * and use as tile-loop bounds.
+			 */
+			if (p_hevc_pps->num_tile_columns_minus1 >=
+			    ARRAY_SIZE(p_hevc_pps->column_width_minus1))
+				return -EINVAL;
+			if (p_hevc_pps->num_tile_rows_minus1 >=
+			    ARRAY_SIZE(p_hevc_pps->row_height_minus1))
+				return -EINVAL;
 		}
 
 		if (p_hevc_pps->flags &

