Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94F41A57D
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224101; cv=none; b=uMeCgzGaUQ86tZgQLLtM78QxNAupDIFnH7xZCBA4NkCUmUWcobqnrT7kFpPQU0NT/l9dBZwYLa52W34+E2yXfPCQE5yxs15nxC3ljvx8ypDedzwoLLe2OJqmGnlDDIxovHlOyVQtZ71IPn2JHQiAs0PfKBKGWVdIJjZiM9IBudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224101; c=relaxed/simple;
	bh=dgFhAJYtixx1Rtu/W4nSe5vVhXq50VuB1iyQGKMGg+M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dO1tweVXyV+hUkEl1Y7zAU4e0Mjvq54JdiFA/ZRD4DcBBU7OZZVhdptzcSn2guysp9hHSzUW7kuoNT3YLW2NBai3Y8HM2mRBDG+74EmVQpH6sGsd1W8GdVTxT5qqDDe7F3HDVuiTcCuAKRGk/HkEfZe7lZyzqMDX7nt7ELpj86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tILtN9Qf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tILtN9Qf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEE41F00A3D;
	Thu, 20 Aug 2026 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224086;
	bh=gNvhp/9sv85UjECL9DBvN8nzNkRoFP9O++4cCQZTwAw=;
	h=Subject:To:Cc:From:Date;
	b=tILtN9Qf3o1RCvsZGL/CVuJ6SGJTVrXBGH7XZXr6znYUZmvDPjxrna9j9W1feiaR0
	 FmBYjPPKjtBjJVNNG+Iww5ym8M8yIzjTBHqfcISrbw+xlw8gkxQEnwzvZASg/iHXVf
	 Hav8QY3zWhblxq5PWL1U74QcEKp8rQ2Bt+mXE+M8=
Subject: FAILED: patch "[PATCH] Input: byd - synchronize timer deletion before freeing" failed to apply to 5.15-stable tree
To: lilinmao@kylinos.cn,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:07:45 +0200
Message-ID: <2026082045-earthly-vengeful-03d1@gregkh>
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
git cherry-pick -x c83e79c0842ed29860648bcce5022ef0ba5001c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082045-earthly-vengeful-03d1@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c83e79c0842ed29860648bcce5022ef0ba5001c6 Mon Sep 17 00:00:00 2001
From: Linmao Li <lilinmao@kylinos.cn>
Date: Mon, 20 Jul 2026 14:12:59 +0800
Subject: [PATCH] Input: byd - synchronize timer deletion before freeing
 private data

byd_disconnect() uses timer_delete() before freeing the driver's private
data.  This does not wait for a running byd_clear_touch() callback, which
dereferences the private data and its psmouse pointer.  A callback racing
with disconnect can therefore access the private data after it has been
freed.  The timer can also still be re-armed by byd_process_byte() while
the disconnect is in progress.

Use timer_shutdown_sync() before freeing the private data: it waits for
a running callback and turns any later re-arm attempt into a no-op.

Fixes: 2d5f5611dd0d ("Input: byd - enable absolute mode")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
Link: https://patch.msgid.link/20260720061259.1601281-1-lilinmao@kylinos.cn
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index f5770a3af2f1..5fc3c629590a 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -423,7 +423,7 @@ static void byd_disconnect(struct psmouse *psmouse)
 	struct byd_data *priv = psmouse->private;
 
 	if (priv) {
-		timer_delete(&priv->timer);
+		timer_shutdown_sync(&priv->timer);
 		kfree(psmouse->private);
 		psmouse->private = NULL;
 	}

