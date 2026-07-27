Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A232C158A
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159247; cv=none; b=Gs3nWTs7zA4j8bWEmqXXvoU/HumYCgeKX/VV1t8aEgf5dcCUs0r9MWCCvgjgjGQ+i3MoJk1fHGYV9ntJLgljwV/xEpBlpdHCKppIDfZQJ8gxlp4hSp+6Pxolzm7UP5oc3qyCIRZedFqAZi6S8jlcZAPw6nXThs/Q/W0UE8sbhAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159247; c=relaxed/simple;
	bh=Frd4Yg5yVzmJvJEnBUa19zGwArnUqqjdhF6ANWO9iF8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ReVPKC97AmY5cRwOA35jYX9nxxP5w2xRqILVjdlmfxB6+0edETNWZrMdAe2e0XCPxHVpEc9VUETMzEcFmOMdv4zA3Fkzn8JQB5/YyYxr1XFeVL9hq6I2xiPbyROuhDnwdr/KgmMt9A7WIewP0+jVwLe9Qta5D9vDYnc4ITu76dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xL2vVpDX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xL2vVpDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874331F000E9;
	Mon, 27 Jul 2026 13:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785159246;
	bh=1zcojBrafiyZG+3+Ov4M4oO+FR9zaXb4pfi+Hjah5GU=;
	h=Subject:To:Cc:From:Date;
	b=xL2vVpDXeYOt2PVz9Ffzu/5M1yGhqNrX/JS3RoXU/ymKMvbXtm5uP8BJtn4QuGOe9
	 mYpINj1EtuRwTA7kBeQori5Wfm5cCmbBxPJF9vTpGRsDk7sxIGG/+X+C1rnPWzcSOL
	 GfU9u24+6oaUayfDaHMHA3PQGP11FH+51BjKabI0=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Correct teardown ordering in ucsi_init()" failed to apply to 6.1-stable tree
To: akuchynski@chromium.org,chaitanya.kumar.borah@intel.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Jul 2026 15:33:33 +0200
Message-ID: <2026072733-attention-baritone-0a90@gregkh>
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
git cherry-pick -x fb0bf289f5d529336ef490c8273e88a8a8b29f69
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072733-attention-baritone-0a90@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fb0bf289f5d529336ef490c8273e88a8a8b29f69 Mon Sep 17 00:00:00 2001
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Fri, 17 Jul 2026 10:46:14 +0000
Subject: [PATCH] usb: typec: ucsi: Correct teardown ordering in ucsi_init()
 error path

The commit 7aa7d4bf9d3f ("usb: typec: ucsi: Fix race condition and
ordering in port unregistration") consolidated port teardown into the
ucsi_unregister_port() helper. However, it introduced an ordering problem
in the ucsi_init() error path.

Fix this by ensuring ucsi_unregister_port() is called before we unregister
their corresponding lockdep keys.

Cc: stable@vger.kernel.org
Fixes: 7aa7d4bf9d3f ("usb: typec: ucsi: Fix race condition and ordering in port unregistration")
Reported-by: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Closes: https://lore.kernel.org/all/22064276-6c56-411a-9f20-6917ceeb865f@intel.com/
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
Tested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260717104614.325250-1-akuchynski@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 1ae4224d2dfc..49f1c53721bb 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -2142,11 +2142,11 @@ static int ucsi_init(struct ucsi *ucsi)
 	return 0;
 
 err_unregister:
+	for (con = connector; con->port; con++)
+		ucsi_unregister_port(con);
 	for (i = 0; i < ucsi->cap.num_connectors; i++)
 		lockdep_unregister_key(&connector[i].lock_key);
 
-	for (con = connector; con->port; con++)
-		ucsi_unregister_port(con);
 	kfree(connector);
 err_reset:
 	memset(&ucsi->cap, 0, sizeof(ucsi->cap));

