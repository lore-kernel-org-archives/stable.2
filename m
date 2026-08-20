Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDCB4189D6
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224096; cv=none; b=LkIcWEnz6toRU+cFJuciSKuvg/tW/lCKjGiL2npPnlZlJ6CaY7oCeHBQSh3gNV3y8BzgflXKu6U9eUcKVLbDC8UM7BiodBYlhwax8FtGWwptcNnvhGNHmaGEFNw225oTNdw+YzBxHr1wMsqEl5XgU+0hJMTWO+4ZFP08bX87OCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224096; c=relaxed/simple;
	bh=sSvy4TU33OFDwwNS05zpBK2KywxARX2wWoanJF48qJs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ku65fFIh3X/W7S+khCw1RAGZqzyguriOkwF9POksnGnaR9wNr6aQ1VQzRYJqgd+A9qDLqZKk7c6Nrstlynk3hThVzr4oz+M9xKoHQ19wkHAumFdagMVO/ty/H8XQrv6SqA8T6mseXX7M5VmK6v8Pn5V4xK66i1sRespbFbf5Vfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ISeF03RH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ISeF03RH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563AD1F00A3A;
	Thu, 20 Aug 2026 11:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224079;
	bh=CkfrPwrKp0T7So97ddSHulG0YK76ECeOx6NTPXyrwBA=;
	h=Subject:To:Cc:From:Date;
	b=ISeF03RHrkA/STJDTCWZAkszDmy0RY9e5hkcqcr1pJolELYbv+QwsVe6pEG1Nhzmy
	 unATH7YII80oZCMlw2lvfLV4LRQvjeVHz/pI/k3EslXAw6fE3XUiv+YWqYdzjdbvaG
	 UK8Uf1l/w/JN3uFcUz+4rF//S9KMUNV1p0BDfdyQ=
Subject: FAILED: patch "[PATCH] Input: byd - synchronize timer deletion before freeing" failed to apply to 6.12-stable tree
To: lilinmao@kylinos.cn,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:07:44 +0200
Message-ID: <2026082044-recopy-rectified-0081@gregkh>
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
git cherry-pick -x c83e79c0842ed29860648bcce5022ef0ba5001c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082044-recopy-rectified-0081@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

