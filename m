Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F0415F0A
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159242; cv=none; b=Q/bMSNC8wjgpxOGnRO7HlQZ6N5kt+bSrjBYScjDJ4IjDmvyCH8KGhFyOAXUUot/Ba4WxdvduXNohfespwLsE99K2sYD8TBCjtOeojK7Ywsor6k9EHiglzcVho+yT+mDnWmPANL3i4+SlmIH5PBcph2YMwsW8or6rIKGNfsiwv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159242; c=relaxed/simple;
	bh=zXnb+lrgZjH8eOxhm6igLqu4yj12POTTx/suWfVFCP0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KnN5/MCH7m01OI9c30h5ZMDEOM+d64h1QH2iXl0io/LC0RRmuKJHM6331QqA3BhZbX56RtRxbD4Z3ZNMyrYzwbQUxZ1PFLiBN7UHSEprFxAfUqpaN4pd0UT5KS9MQSM3/iwhqVc5dATz7ZthGtFPz0toZSwtcmE/hm0QHFzL6oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zsj4Wcg0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zsj4Wcg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B86F1F000E9;
	Mon, 27 Jul 2026 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785159240;
	bh=C5W/XyMzPS/hhVJc0ebovlBEKY/vmARResLJW4RMwRc=;
	h=Subject:To:Cc:From:Date;
	b=zsj4Wcg0bHxxDwrRTt/7LLoCc+nec1qY+7wYn0jrDhtFIL+Zxf3e1duIG+AVZMg9l
	 8nfHQYOlQgdPvVC0bDnAKOHCZXPVZEIdBr3AvnLe/msNnFPZ2VU4OIW13nUbKauV73
	 Wkce6/6ybYAsAYU+aUQ1OQkP0Et/Iq9kmq1fDDVA=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Correct teardown ordering in ucsi_init()" failed to apply to 6.18-stable tree
To: akuchynski@chromium.org,chaitanya.kumar.borah@intel.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Jul 2026 15:33:32 +0200
Message-ID: <2026072732-retiree-rubble-f67e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x fb0bf289f5d529336ef490c8273e88a8a8b29f69
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072732-retiree-rubble-f67e@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

