Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C24071D2
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550915; cv=none; b=WRaLxqg+ftNxl1gxIarxIB2raFJRoYh5cn1KfLxberwJWhGX+qhLlBZSOynCap1AgWF4QkXSrceNsSsN/Z0S6oCCkmEx/ft8hozcptAb94R/OVDMlSqAJWcHSsQc1OuPiaznrteKPtnVTZ0+biSZAKeU1ZH6dCL0C/nFfe/b8Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550915; c=relaxed/simple;
	bh=qY29MAsCcvBSrEWQkVWen4e38RQzULSgqBem34CsD14=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gQowONYg+gxKYV89o9cqzMsHzsSv51O0oKVdAO+9VRSF78bBJYiTPonY/+mRDTtzzY7BjlDaE8g8j5H3oZCbviyZWYV6i6x2Nl8YIjnFL2w2ImkDdNeT9ExPTfOJTr1n3VI1Tz9eyzpBtxPFgefgLF/3gqRpIIWypeEKQ47Ad2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FVtQT/GU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FVtQT/GU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D3C1F000E9;
	Mon, 20 Jul 2026 12:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550914;
	bh=A0ox5YGVjlOMNxD85+aSI9QyuDjnR1K4uiA8Ly1F6GI=;
	h=Subject:To:Cc:From:Date;
	b=FVtQT/GUQl+zCE7TVt0yhvlWzIthcksVpGxIPVwsBawvxhMXoIf5bteQ+yGz//EPj
	 QMIS5uSiYD1By3RxVcpjlDSEOkB62x6wVJwi7kXSa4KDbhDMx454h/5uOG+8Hg4eQs
	 MyQJAZN2lYP8fZV534bDWfOJEy7fjlqveYI9B8f0=
Subject: FAILED: patch "[PATCH] ASoC: SOF: ipc3-control: Fix heap overflow in bytes_ext" failed to apply to 6.1-stable tree
To: peter.ujfalusi@linux.intel.com,broonie@kernel.org,liam.r.girdwood@intel.com,yung-chuan.liao@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:32:02 +0200
Message-ID: <2026072001-unvocal-backtrack-aa11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fd46668d538993218eea19c6925c868ac0f2630c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072001-unvocal-backtrack-aa11@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd46668d538993218eea19c6925c868ac0f2630c Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Tue, 9 Jun 2026 11:34:58 +0300
Subject: [PATCH] ASoC: SOF: ipc3-control: Fix heap overflow in bytes_ext
 put/get

The ipc_control_data buffer is allocated as kzalloc(max_size), where
max_size covers the entire struct sof_ipc_ctrl_data including its
flexible array payload. However, the bounds checks in bytes_ext_put
and _bytes_ext_get compared user data lengths against max_size
directly, ignoring that cdata->data sits at an offset of
sizeof(struct sof_ipc_ctrl_data) bytes into the allocation.

This allowed writing up to sizeof(struct sof_ipc_ctrl_data) bytes past
the end of the heap buffer from unprivileged userspace via the ALSA TLV
kcontrol interface, and similarly allowed over-reading adjacent heap
data on the get path.

Fix all bounds checks to subtract sizeof(*cdata) from max_size so they
reflect the actual space available at the cdata->data offset. Also fix
the error-path restore in bytes_ext_put which wrote to cdata->data
instead of cdata, causing the same overflow.

Fixes: 67ec2a091630 ("ASoC: SOF: Add bytes_ext control IPC ops for IPC3")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20260609083458.31193-7-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/sof/ipc3-control.c b/sound/soc/sof/ipc3-control.c
index 1f5538bbc50f..d1697401b1da 100644
--- a/sound/soc/sof/ipc3-control.c
+++ b/sound/soc/sof/ipc3-control.c
@@ -398,9 +398,17 @@ static int sof_ipc3_bytes_ext_put(struct snd_sof_control *scontrol,
 	}
 
 	/* be->max is coming from topology */
-	if (header.length > scontrol->max_size) {
-		dev_err_ratelimited(scomp->dev, "Bytes data size %d exceeds max %zu\n",
-				    header.length, scontrol->max_size);
+	if (header.length > scontrol->max_size - sizeof(*cdata)) {
+		dev_err_ratelimited(scomp->dev, "Bytes data size %u exceeds max %zu\n",
+				    header.length, scontrol->max_size - sizeof(*cdata));
+		return -EINVAL;
+	}
+
+	/* Ensure the data is large enough to contain the ABI header */
+	if (header.length < sizeof(struct sof_abi_hdr)) {
+		dev_err_ratelimited(scomp->dev,
+				    "Bytes data size %u less than ABI header %zu\n",
+				    header.length, sizeof(struct sof_abi_hdr));
 		return -EINVAL;
 	}
 
@@ -436,7 +444,7 @@ static int sof_ipc3_bytes_ext_put(struct snd_sof_control *scontrol,
 	}
 
 	/* be->max has been verified to be >= sizeof(struct sof_abi_hdr) */
-	if (cdata->data->size > scontrol->max_size - sizeof(struct sof_abi_hdr)) {
+	if (cdata->data->size > scontrol->max_size - sizeof(*cdata) - sizeof(struct sof_abi_hdr)) {
 		dev_err_ratelimited(scomp->dev, "Mismatch in ABI data size (truncated?)\n");
 		goto err_restore;
 	}
@@ -452,7 +460,7 @@ static int sof_ipc3_bytes_ext_put(struct snd_sof_control *scontrol,
 err_restore:
 	/* If we have an issue, we restore the old, valid bytes control data */
 	if (scontrol->old_ipc_control_data) {
-		memcpy(cdata->data, scontrol->old_ipc_control_data, scontrol->max_size);
+		memcpy(cdata, scontrol->old_ipc_control_data, scontrol->max_size);
 		kfree(scontrol->old_ipc_control_data);
 		scontrol->old_ipc_control_data = NULL;
 	}
@@ -491,10 +499,13 @@ static int _sof_ipc3_bytes_ext_get(struct snd_sof_control *scontrol,
 	}
 
 	/* check data size doesn't exceed max coming from topology */
-	if (cdata->data->size > scontrol->max_size - sizeof(struct sof_abi_hdr)) {
-		dev_err_ratelimited(scomp->dev, "User data size %d exceeds max size %zu\n",
+	if (cdata->data->size > scontrol->max_size - sizeof(*cdata) -
+				sizeof(struct sof_abi_hdr)) {
+		dev_err_ratelimited(scomp->dev,
+				    "User data size %u exceeds max size %zu\n",
 				    cdata->data->size,
-				    scontrol->max_size - sizeof(struct sof_abi_hdr));
+				    scontrol->max_size - sizeof(*cdata) -
+				    sizeof(struct sof_abi_hdr));
 		return -EINVAL;
 	}
 

