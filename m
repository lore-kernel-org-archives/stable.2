Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07EB2C158A
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159250; cv=none; b=WFOg78T+eeSNmWW1cpbO3uwAjtqJh/bA2pZ35RKotLscNkCx0TpZ6jTNLLu/Z8GV2qhVlLEGcj1YiSy6ZJc9Y4SRxZdwrjLd4ISCM9oPL9kw5+ZVjjMiGCIOZMrSo6IFOjIinm8IIt9pY2Pc6F0UM0+Gh8dQ4m4ESOX7hRXwvVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159250; c=relaxed/simple;
	bh=9MzAu6VGPU5/TdzrRuOHJyFKVPBPcLQut/Gm1CfKMBs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ufPuS9BZHAwmxY4GRnegqv4Vf6YB2ATsXVzKr9Wcd0AdWFsCX/7RwQiV4cbZfzhsBMNWB7Xj6GvMwJfsiiI4l+5/gplw+aQRaohlnhZSPYHkgSpEy5MzrVZuTtdX1L9b8J8SK7eNfsh0nnFhVT+flWzfqkirH8VVfXByMpisEiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wlne6d/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wlne6d/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4970D1F00A3A;
	Mon, 27 Jul 2026 13:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785159248;
	bh=8KVKYJ4F9Hiy2ly7nJckg3f6fzVKi6hiqat6O7ClQ+I=;
	h=Subject:To:Cc:From:Date;
	b=Wlne6d/Z23Aw413FZSIaZX+iR06t+PJpb/V5pEJXjumVTL2HXnB3dDoRjrNL36KiG
	 /fFMFfgEsl1wzrMVf8suxLmVI7aUYpA2HBEDUy2x8hWTcPAGPisSr/RymAmJwrd2cO
	 4MYvNZNtZ9zXvE06hfDTTyx5sCddKBFm56D0K0i4=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Correct teardown ordering in ucsi_init()" failed to apply to 6.6-stable tree
To: akuchynski@chromium.org,chaitanya.kumar.borah@intel.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Jul 2026 15:33:33 +0200
Message-ID: <2026072733-rigor-skier-ea97@gregkh>
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
git cherry-pick -x fb0bf289f5d529336ef490c8273e88a8a8b29f69
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072733-rigor-skier-ea97@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

