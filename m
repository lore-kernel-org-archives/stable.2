Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1358F483BD5
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329510; cv=none; b=uK/LFvl35DfH0W1mw8EveB8u9MVuGc6G+6rJy1cWRtOf/1P4+uwDW9ieUrpgnAE9J1ya2B9TXTxKdP5BpgOf7UkjfKd3RnhFY47OP7xtppcHYdB60Yg6XE3cxaPJYBJjNG3dFF+zuIvNLV9bT8htOHnj8ywUyzxUw4z6td2ZX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329510; c=relaxed/simple;
	bh=MEFgIL1hqE6OBBI1+jUYsjoCOmy/VX8S0PVm6iVu/4I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UoiPZNnlL66+GGwq/EGcDKKqHHFkHn54m2wBLEAqCfRVFJCv8LP1NDnWuP2RtlZ68aDcMvi1I7vY+UzHvllvvyd76kzpSmah5DQFRVxMUONKBWtQi+5ugOp1JB+4pdetUDmy+ziu047/lyI4aX8vJEEavJsVEVDU5UWU3KE+Q2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kExtYnlc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kExtYnlc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C391F00A3A;
	Wed, 29 Jul 2026 12:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329508;
	bh=aKYHvtsYoLwAF2oOJeEmn43YLzZLi6pm0AAT8wkWy9Y=;
	h=Subject:To:Cc:From:Date;
	b=kExtYnlcD8cUCsnr2XZdx0FJYFPiJpZ3qPk39m3DwNzBsTFo6gEMuiADYKPFMQi3u
	 Q/35N4pG4qGsTHKKsTv9fh0AMfVytYoF8iSq5EeIv7/igFpYWQcagqzs93evz9Ptuw
	 SvpS6wPQxVzQoDonzCZqISCFFfSJnX8EEm3IWHws=
Subject: FAILED: patch "[PATCH] media: aspeed: fix missing of_reserved_mem_device_release()" failed to apply to 5.15-stable tree
To: devnexen@gmail.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:51:35 +0200
Message-ID: <2026072935-kinfolk-unsightly-e510@gregkh>
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
git cherry-pick -x 253c8ef7d57da0c74db251f385324faaa5ae2257
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072935-kinfolk-unsightly-e510@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

