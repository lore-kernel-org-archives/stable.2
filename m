Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97CE199FB0
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671777; cv=none; b=IP7czc1l4nExf/ko3ItQX5DppmSAompR77y8tX0o852kVtbwYtwli1mMVrOI8xjRIExRvybR+KBv6acIGmfwbCqgGicHWiyWbK+7vvq7nDjnpFNxheFxRRKSj+zwrt4zAYj2J74XhsODHCyG84gFNX2baBQAQW34OjmSWxZdZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671777; c=relaxed/simple;
	bh=tyoMc7tSjP1kVjLBdu9c/4OtaFZe7SFqRD+aQ31fHds=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZsUSzu3VABK7IyKe38iKXbE2pQsQPpjZb6oZFds56CihsbnGn4elm9dikGHR57EJMYYFE2cA0M0YMduPEnpZvZvzoey9hEkol5RMcKzTw6o98k7i4ekvg8mfy/3d+ls7o9k7F0/iT2NvmK64MA3YKYRD5F8ftlvjTFnaK7jPsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=REil58Ld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="REil58Ld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E20D1F00898;
	Fri,  5 Jun 2026 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780671776;
	bh=tv7/OcJfK23KgGkXixicYrp3nppzXQaptVEDYicq1Gk=;
	h=Subject:To:Cc:From:Date;
	b=REil58LdG5WCE+gu0EW0grDUYs0keASnxk5a/gbscQdzqgQkvh55xqdFBq/8fmRE1
	 9Tz16karL7qv3qUg92osyExCoSbdR39eE/95kIq8P33kYKgJ0g4DO23URPV0xzx4kw
	 d6WlrEAxQX6EvqDPlPsrPUebu2ohJvD/ZciVNjn0=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Don't update power_supply on power role" failed to apply to 6.1-stable tree
To: myrrhperiwinkle@qtmlabs.xyz,gregkh@linuxfoundation.org,senozhatsky@chromium.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Jun 2026 08:02:57 +0200
Message-ID: <2026060557-finishing-leverage-ebc0@gregkh>
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
git cherry-pick -x d98d413ca65d0790a8f3695d0a5845538958ab84
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060557-finishing-leverage-ebc0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d98d413ca65d0790a8f3695d0a5845538958ab84 Mon Sep 17 00:00:00 2001
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Date: Tue, 19 May 2026 18:41:40 +0700
Subject: [PATCH] usb: typec: ucsi: Don't update power_supply on power role
 change if not connected

We only need to update the power_supply on power role change if the port
is connected, because otherwise the online status should be the same for
both cases.

Cc: stable <stable@kernel.org>
Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role change")
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Link: https://patch.msgid.link/20260519-ucsi-fix-2-v1-2-6f1239535187@qtmlabs.xyz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 53c101bd48e2..61cb24ed820f 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1308,7 +1308,12 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	if ((change & UCSI_CONSTAT_POWER_DIR_CHANGE) && role != prev_role) {
 		typec_set_pwr_role(con->port, role);
-		ucsi_port_psy_changed(con);
+
+		/* Some power_supply properties vary depending on the power direction when
+		 * connected
+		 */
+		if (UCSI_CONSTAT(con, CONNECTED))
+			ucsi_port_psy_changed(con);
 
 		/* Complete pending power role swap */
 		if (!completion_done(&con->complete))

