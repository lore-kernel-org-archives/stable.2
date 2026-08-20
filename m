Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290AD41A4F5
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224097; cv=none; b=b5TWesAsmEKlOH5u3xixzce/jIyuy6lJJqlFLuV4zTu74ZEBZE1auaw8YnR1kMF6Zr+tA3suIYizShicZ8mghkI3CtJtj0JQO/6UtqSuoz5wy5gbFdAQM5u04J8jRBJ944kePPjBsiYiMZMiyWoDjvrJCCFqkIfK9KnuZAzQ4mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224097; c=relaxed/simple;
	bh=9YQH7TxHwwBuv5P6tclurBxVLYCzrJhcMfAHRXAhbpo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SoEkhT+yGcQbaEUwZ3t3X1dKIL3AhtY7MqA3TxQMIdZCYGUKUSxKBM7jSoC8x+PqaLjib1T81qcdACIVZM1bHT8VpQSpKIwqnXuoiXDbsCoG0UvbIEj1CW0uiP2nx4nIL63RLuV8lEb1P+dtRXe3Lsxzg3kHZwgqZLWMoqLc6Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YUcsUq8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YUcsUq8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAFF1F00A3E;
	Thu, 20 Aug 2026 11:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224090;
	bh=sTEj2iOVZFV+AqBvOnJ+fqP5u53+DAJeM4MogTSR19k=;
	h=Subject:To:Cc:From:Date;
	b=YUcsUq8M+/vyjWc8XXEEjm29wOeCEX1xkFYrQSVCSpWPAaiai9Binwp3fa4Z5thF0
	 06uXKz9A6JBUh//jK3sa6kKZzwTuna5ikR7f++TPeBdWG7rrWUAsxFKkQc7lztnAum
	 HkOkJhogJBxs433W9J4x574/F7zYKo4RDusvMlxQ=
Subject: FAILED: patch "[PATCH] Input: byd - synchronize timer deletion before freeing" failed to apply to 6.6-stable tree
To: lilinmao@kylinos.cn,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:07:45 +0200
Message-ID: <2026082045-around-contort-ce2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c83e79c0842ed29860648bcce5022ef0ba5001c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082045-around-contort-ce2c@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

