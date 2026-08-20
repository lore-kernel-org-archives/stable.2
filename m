Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0641A76D
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224093; cv=none; b=E3zPUgShTQKU69CnolWLHGja//CaiE/WHYCPMPxfokmZGXstYptMVF2AyWfGuHUvYpWB6WZ/kVJuaRGEm5+0lekRgkQ8ApOUhWrsnp02G4bxTlNs2ZBhLROA5P8+J1R4pb4IcXgyLNEk2iRU2nilyUgVYqiVv6ddbr+7r6I0fwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224093; c=relaxed/simple;
	bh=F1tR5spZBQE6mGAdIlo6CsyWhsd5HjLHhdgr0gdpLUg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l3YodgCBZbI6190dchlIBx6BLSWxHtcDSDDVz5q3XmLG3rHlV9Ml/wBGHkuz+uKoIf8UUUEirkEosWOqDeGkuqNtoVzuXTBjs63dIagixSU6fkc3YfculcsAjsn8mQbOJC7kXyA+/U+dSW/Z+IYObRy32XVrWFpCnwqJMPeIDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0LqdMewQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0LqdMewQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD361F000E9;
	Thu, 20 Aug 2026 11:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224083;
	bh=vzy9eV9Xtg7e2CbQYb30sGsO42spQSPMRSCu7r8c+Tw=;
	h=Subject:To:Cc:From:Date;
	b=0LqdMewQMu6nOD1bPF5k3UKM8rBWMlAV1X6vOs87AgRGzVNmEcb9ZhXT1dT6EeGwg
	 J06PxftW/nyEU1ey5ufRxZ686NQeRDQWv/jOs71oIVpu0zWkcy26zoGyYVqR6u0/tH
	 6DnUs0L5+KJFV6dQoJCj8mTMNqgeLzlDvrdHhlFM=
Subject: FAILED: patch "[PATCH] Input: byd - synchronize timer deletion before freeing" failed to apply to 6.1-stable tree
To: lilinmao@kylinos.cn,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:07:45 +0200
Message-ID: <2026082045-whoopee-batboy-8ace@gregkh>
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
git cherry-pick -x c83e79c0842ed29860648bcce5022ef0ba5001c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082045-whoopee-batboy-8ace@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

