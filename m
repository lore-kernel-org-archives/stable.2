Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4CA41B354
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224106; cv=none; b=RL23Dtb+awZUg0LS4zBg+cTo/D4HeVqINrdymYDZklTMRf3GMdWZPzDE4n+CFwZMnwdvYe6lZabQgTywra74K0RAzlcrdzh1K/W/BQ/oigdMWiYac8/PF782EC+JcaTukWKKSfwcEu2kNBgmvqBa1y2TqckQ0CPA+tJfzNNDcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224106; c=relaxed/simple;
	bh=N88Ti81MSfSZm9jAhBWin+WdFgD8h12UcUUZJXRXo6o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UqwPQ9m0WGnR0i+G3NFT8IvY5LOqEiQnZviuZQsPuPD3TIOJZHP+BiNSgVwEFXdCBS7LK264CgTWIxJzfcMLRRKOHQ+4JcuEp6jNc8W5IEPw7W7qx4m8FWwTbENHdJJt0oEP9ITL1lLOYd7S66f8PICX+aROsXV4VhUNT9+UZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l0xwid3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l0xwid3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0E11F00A3F;
	Thu, 20 Aug 2026 11:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224094;
	bh=cNbah2WaZgIdcTQiehWtmNv4Z/TB7yjfgTXjkxdKbnY=;
	h=Subject:To:Cc:From:Date;
	b=l0xwid3dKbuEIOl6+Ty68pZxXB7qI9Th7IKxe8b59QYCOa4yjcC7BVB3vj6kcnrKR
	 3UyHll4MsouIQKoZRZoGxYJtqAzas2zg97NbCQIrcoO7pECUc9SuuVKITdHtCTJcjp
	 CLloCKhJEGgVlNn02lMGPwiheDpAqdfdwohzAwyw=
Subject: FAILED: patch "[PATCH] Input: byd - synchronize timer deletion before freeing" failed to apply to 5.10-stable tree
To: lilinmao@kylinos.cn,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:07:46 +0200
Message-ID: <2026082046-impound-leverage-8771@gregkh>
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
git cherry-pick -x c83e79c0842ed29860648bcce5022ef0ba5001c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082046-impound-leverage-8771@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

