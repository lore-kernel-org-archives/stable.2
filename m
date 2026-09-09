Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3354A0902
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951652; cv=none; b=pLv8SkbM0TNB7eWw1tKFKPT9PClMQ2zAolbSUuaGlIG+3qTv+Q1C4wZ9CliV9DJ8qgoft+6GFuQy/bUGzHE84/UiGi+zhosyf4kOPWAprYga0deg+MvOgiEa1i91b/vgITLzwjZbBeKNm6nj5hYE8fOAfmatQPg1rSQLf6L3uCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951652; c=relaxed/simple;
	bh=Pw0l7s5H1hh7h6Z7jGa7Fl5cZ/p98eU3EuqoExXrAic=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UkAb3jpi2McB9SgrJY/AsWNW2b1W6yyWfn/18cSV5YF7omSyBxcWQJanZvgrxXBkHmr8fb7JAAJlbz25oXy7fWatfqRBVFIxXpG6K62LzaSBnKmmIpYp/BoBN+bxf90Lc1CtPplyKWmHdvjK7c1N1grbOztrynjmumNSqYvvQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e22qdCa7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e22qdCa7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3611F00A3E;
	Wed,  9 Sep 2026 11:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951648;
	bh=joBsbsth789rUlikHfCz9JfCJ4eYEe1GkL58PU+p5Xw=;
	h=Subject:To:Cc:From:Date;
	b=e22qdCa7BhpyfYVYU+QCo25DcKbpXQLWOHNQqVvubymJLGe56t73crSCXHlEksjEn
	 XG47ti+qCfDfmvAIIt5Z4L4TTBQWdwTxDeRmQLaYRQ6hd6ipSy60wtb4gcTDZxW2H/
	 VIqLCy9MJt5IDUZTStyPsp33elzEnVVaw5rPBawk=
Subject: FAILED: patch "[PATCH] media: zoran: Avoid freeing a registered video_device twice" failed to apply to 5.10-stable tree
To: ruoyuw560@gmail.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:52:20 +0200
Message-ID: <2026090920-computing-favored-d2a1@gregkh>
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
git cherry-pick -x 0735e0b5a96761a9ce277a238e834008ad92a0a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090920-computing-favored-d2a1@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0735e0b5a96761a9ce277a238e834008ad92a0a5 Mon Sep 17 00:00:00 2001
From: Ruoyu Wang <ruoyuw560@gmail.com>
Date: Wed, 8 Jul 2026 22:33:49 +0800
Subject: [PATCH] media: zoran: Avoid freeing a registered video_device twice

zoran_init_video_device() installs zoran_vdev_release() as the
video_device release callback through zoran_template. After
video_register_device() succeeds, video_unregister_device() drops the
registered video_device reference and the V4L2 core eventually invokes
that release callback, which kfree()s the video_device.

zoran_exit_video_devices() called video_unregister_device() and then
kfree(zr->video_dev), so device teardown could free the same
video_device twice.

Remove the direct kfree() and clear the cached pointer after
unregistering. The pre-registration failure path keeps its manual free
because the video_device was not registered there.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 82e3a496eb56 ("media: staging: media: zoran: move videodev alloc")
Cc: stable@vger.kernel.org
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/pci/zoran/zoran_card.c b/drivers/media/pci/zoran/zoran_card.c
index 8bcf355a5418..e5ff407318df 100644
--- a/drivers/media/pci/zoran/zoran_card.c
+++ b/drivers/media/pci/zoran/zoran_card.c
@@ -886,7 +886,7 @@ static int zoran_init_video_device(struct zoran *zr, struct video_device *video_
 static void zoran_exit_video_devices(struct zoran *zr)
 {
 	video_unregister_device(zr->video_dev);
-	kfree(zr->video_dev);
+	zr->video_dev = NULL;
 }
 
 static int zoran_init_video_devices(struct zoran *zr)

