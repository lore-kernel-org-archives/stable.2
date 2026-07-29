Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A448381F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329372; cv=none; b=h1oKrda9RYXJU3GPE4Wd24zTth+QBKBdPG4ZKTh9zRv4sGLVNV7R/xnJfw7urtC6ZFKlsmbBc0P5YeuYJtBmoa+owuxyyuvH2zDpzDEQWt9Zn1RMuxc88Ua4kr/IVpSsKTiVoDrWpw3JdBwFu2PX5MjXOg1BDs+dlRwywqK/udY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329372; c=relaxed/simple;
	bh=XnIJv2S451jB0hetwG26QJ1QlpOZ/vtwm6VxzSgrcYs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uIztBEtwRBQWiZyZVACdNILCNM3tb71VlOYwqHZEOhHmfEUeHca4SmW4LG3SH5/WEr6tb2+gK2tJ199L8E87Y1Jl5tskz2JbCmohTCvtP4qKH+gqEyLC6MAxf7f+e2SLBfsDycjDUKvi+g4kYMcfqvbOBh5ujiDiIvsVB5re0+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZN7cYLbn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZN7cYLbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE191F00A3A;
	Wed, 29 Jul 2026 12:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329369;
	bh=SqBObt2xPCm6ARN2zJDZrr9A9K0P/qb8w6MvBjR5pxI=;
	h=Subject:To:Cc:From:Date;
	b=ZN7cYLbn5Dbsh48OPTMgE6QM+b2FS2kkNlnc+mZ7ddBXtQHnDIaINNcrEzlI+qfKO
	 4xNpPVHoYG4ZGcdyyVA7AnqMArLojRjSiVjNcH8HLgLrmjowimlWgK+vETFgemlvE1
	 D5vg5qUIy0Xh4ZC1GoF746KcGqvIT4sOxNsP9oEY=
Subject: FAILED: patch "[PATCH] drm/vc4: Shut down BO cache timer before teardown" failed to apply to 5.10-stable tree
To: lilinmao@kylinos.cn,mcanal@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:49:03 +0200
Message-ID: <2026072903-limpness-utopia-a541@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6273dd3ffb54ec581855b82ae77331b66028249c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072903-limpness-utopia-a541@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6273dd3ffb54ec581855b82ae77331b66028249c Mon Sep 17 00:00:00 2001
From: Linmao Li <lilinmao@kylinos.cn>
Date: Mon, 20 Jul 2026 16:44:26 +0800
Subject: [PATCH] drm/vc4: Shut down BO cache timer before teardown
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The BO cache timer callback schedules time_work, and time_work can rearm
the timer through vc4_bo_cache_free_old().

vc4_bo_cache_destroy() deletes the timer and then cancels the work, which
does not break that cycle: the work being cancelled can rearm the timer,
and the timer then queues work again after teardown.

Use timer_shutdown_sync() instead, so the timer cannot be rearmed and the
cycle ends with cancel_work_sync().

Fixes: c826a6e10644 ("drm/vc4: Add a BO cache.")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
Link: https://patch.msgid.link/20260720084426.1632508-1-lilinmao@kylinos.cn
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 5e7c46dd7823..49ea2ed0996b 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -1048,7 +1048,7 @@ static void vc4_bo_cache_destroy(struct drm_device *dev, void *unused)
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	int i;
 
-	timer_delete(&vc4->bo_cache.time_timer);
+	timer_shutdown_sync(&vc4->bo_cache.time_timer);
 	cancel_work_sync(&vc4->bo_cache.time_work);
 
 	vc4_bo_cache_purge(dev);

