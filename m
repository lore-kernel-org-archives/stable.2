Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3D41DDC07
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329518; cv=none; b=fCJy1u1wovmxjnWy4N/DCswM9xDJ9wo3FERrqvJPiARzTq83XzwAPfGcVlmbZd4tv1Kq3hDOBzFVX/NJPEfzmTz4RrWrw6ziNoVt1qm12wuZwsH6K1SPpEp1oL8e2lXgrsdeP4hn9TKTtu7SNmYLTfapWHKQbPb+74EzhhHL5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329518; c=relaxed/simple;
	bh=IoQcijWDdKURbDIxan1DfPzyfMUxdkIOQSrvJKfwiLY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U9a9z4OVt2HSWzO5cz8dzJGjAMi4Dj/f3Zm/JAh8z4qhb+smhg74DgiN249MVEpnBjs4KC2dPUL8WQaLTRp9XoFrdyqtgiHm/MNUkORKEQlcA0TJS4D2sG7v+h6s7G3fB9L1FARu3AWAwug7b3DU7VuAtLjVNp/q3HAIKaSb0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V+Jodf1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V+Jodf1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDCE1F000E9;
	Wed, 29 Jul 2026 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329517;
	bh=Mfx5HzhY5/UeoD4Du0krID1i+9HlQd/BI1OAVj0sCl0=;
	h=Subject:To:Cc:From:Date;
	b=V+Jodf1ZKddT+lwSpRD16QUUGZnNYVzZkxST96bW6wNrnxeSOvDyFwMX/667IRy6i
	 u03eNQcEweXej2Q9v61ypfjqFH23ApuHlcdvJrPZGdkpZdpliD43v4e9KyWOh1DjOm
	 twiBhDIblQwNtdMWa5UR4/MFyuf3gO2zhVrhNx2A=
Subject: FAILED: patch "[PATCH] media: aspeed: fix missing of_reserved_mem_device_release()" failed to apply to 5.10-stable tree
To: devnexen@gmail.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:51:35 +0200
Message-ID: <2026072935-extenuate-bonsai-d478@gregkh>
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
git cherry-pick -x 253c8ef7d57da0c74db251f385324faaa5ae2257
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072935-extenuate-bonsai-d478@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 253c8ef7d57da0c74db251f385324faaa5ae2257 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sat, 28 Mar 2026 11:23:30 +0000
Subject: [PATCH] media: aspeed: fix missing of_reserved_mem_device_release()
 on probe failure

aspeed_video_init() calls of_reserved_mem_device_init() to associate
reserved memory regions with the device. When aspeed_video_setup_video()
subsequently fails in aspeed_video_probe(), the error path frees the
JPEG buffer and unprepares the clocks but does not release the reserved
memory association, leaking the rmem_assigned_device entry on the global
list.

The normal remove path already calls of_reserved_mem_device_release()
correctly; only the probe error path was missing it.

Add the missing of_reserved_mem_device_release() call to the
aspeed_video_setup_video() failure cleanup.

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index 41cb96f60110..a292275f6b7b 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -2343,6 +2343,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
 	rc = aspeed_video_setup_video(video);
 	if (rc) {
 		aspeed_video_free_buf(video, &video->jpeg);
+		of_reserved_mem_device_release(&pdev->dev);
 		clk_unprepare(video->vclk);
 		clk_unprepare(video->eclk);
 		return rc;

