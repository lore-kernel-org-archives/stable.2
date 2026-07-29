Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C41488D96
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331082; cv=none; b=eynkvY4vTckavxbly8o/uarvlVBpP5rzof/CUrbF8XHMcmKn6N2h8sacLs+yFyY6+wuWv6Xc4iO4LJI5xBkvCsKlpkFgk0k1EPrLNyJgsO5g+oB7qcxQ2XOSCmgl/LO9RyIhn/61uxcxoNWWDVZo6DXZr7bf6Xw08RRefy5tAsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331082; c=relaxed/simple;
	bh=5AMUDKZPE04PC9QOkNqH7On4vfpI9zV6aJuw57EVUcQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VmEfM/CcfFbFZgOFRz6bxfLHIL1Sm5pEKnAdQFXMiydsYkMcbVytSm+O1WWM9fKbMCRE11ZdoEAZ80Vw3tBjX3oyTg88TRXM1yT/q8Z9zdRQyVId5ApY2+tVmY0itD6YYTw7e8EGcus8tJz1JjMHZjIfchChSlo/jcslX8ZbfPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2cnPdgqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2cnPdgqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156F91F000E9;
	Wed, 29 Jul 2026 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331080;
	bh=AS+gRVkK5WiuRp2RF9Pt1nby/3shZAK5MwYKBR43+5M=;
	h=Subject:To:Cc:From:Date;
	b=2cnPdgqJg+8un0/5bsFCLmSJ9/YCYjh9F/oMTW/vBAY6+V1rnV7Kg9FV/EGOoQQYN
	 4yjZcNKLFFwUuNOYsS+7zAvrnk+D110Z55VjsYlsnR5nxDnLNcDPCzAmT4YpBVTJMD
	 2/AaCVspcqEESz6OC8q2W22jgm2EtAzB0g8KR60k=
Subject: FAILED: patch "[PATCH] media: stm32-dcmipp: Return queued buffers on" failed to apply to 6.12-stable tree
To: vebohr@gmail.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:13:54 +0200
Message-ID: <2026072954-reversal-deviancy-9862@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ffc8eec06378a340d708c889184ab3e14b57d540
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072954-reversal-deviancy-9862@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ffc8eec06378a340d708c889184ab3e14b57d540 Mon Sep 17 00:00:00 2001
From: Valery Borovsky <vebohr@gmail.com>
Date: Mon, 11 May 2026 20:12:10 +0300
Subject: [PATCH] media: stm32-dcmipp: Return queued buffers on
 start_streaming() failure

The vb2 framework hands buffers to the driver via buf_queue() before
calling start_streaming().  If start_streaming() returns an error
without first returning those buffers via vb2_buffer_done(),
vb2_start_streaming() fires WARN_ON(owned_by_drv_count) and the queued
buffers leak.

dcmipp_bytecap_start_streaming() returned -EINVAL when the source
subdevice could not be resolved from the media graph, before
pm_runtime_resume_and_get() and media_pipeline_start() had been called.
The remaining error paths already converge on the err_buffer_done
label, which calls dcmipp_bytecap_all_buffers_done(...,
VB2_BUF_STATE_QUEUED).  Jump to that label directly: the intermediate
err_pm_put / err_media_pipeline_stop labels are skipped, which is
correct because nothing they would undo has happened yet.

This mirrors the uvcvideo fix in commit 4cf3b6fd54eb ("media: uvcvideo:
Return queued buffers on start_streaming() failure").

Fixes: 28e0f3772296 ("media: stm32-dcmipp: STM32 DCMIPP camera interface driver")
Cc: stable@vger.kernel.org
Signed-off-by: Valery Borovsky <vebohr@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
index a42f43d19f9e..f0e809458489 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
@@ -401,8 +401,10 @@ static int dcmipp_bytecap_start_streaming(struct vb2_queue *vq,
 	 */
 	if (!vcap->s_subdev) {
 		pad = media_pad_remote_pad_first(&vcap->vdev.entity.pads[0]);
-		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
-			return -EINVAL;
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity)) {
+			ret = -EINVAL;
+			goto err_buffer_done;
+		}
 		vcap->s_subdev = media_entity_to_v4l2_subdev(pad->entity);
 		vcap->s_subdev_pad_nb = pad->index;
 	}

