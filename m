Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190C3FFFB2
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671784; cv=none; b=MfKq+JagtTSw3xj9/BHs52qqxA7wPYHInAtKn47329JHDBcvCz31O/RhvNLuwHy5zTufRHBO9wNKzqtSjnNmXMEW4rtFPtM363lAQTGS3o+Sx0F/VNb8c0AveRsXC0cdWZ1N7JUDuKRp0rKqUGLex9SZTzNewkl7XyjRLzl/zV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671784; c=relaxed/simple;
	bh=paGKTJr8Ui2L6EZ9Ah0haB1EOFV36yAapiOZHgZ57mM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S3fasvRl4gthgcEG75/p84p6uZ0/lQzCRWwTvtZADkUsUVGALN0ThKq4F/O0Djr7Jrb0KxrY1UOZU2MFyLBlEHMhtXcqbz6ktn3MDBuCv+wZRW7Vt3ORNVlfwU3QPeK/OYRZqhN0nXg/uTdPthacI2i/P/UOf9v4HlxN+3StRC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XVlSEmfa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XVlSEmfa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467141F00893;
	Fri,  5 Jun 2026 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780671782;
	bh=9NFAAe4k8XWzhx+hEBK4Jw6Pii6c3GfQ0Dt22QbQuUE=;
	h=Subject:To:Cc:From:Date;
	b=XVlSEmfaYX+yM++qdGMYG72YvTVdfjqcoBtPA7y4oV7bDOiklwLOVRbuPFzbIkvSn
	 +djBtovuYKGr2p3nDYonDK+bxk5O3MFKQWuhZrja3k0WNZ10iYkKuvc8uVO/5u4AQc
	 /aOfTlcisLirVkLWIEe+em6CLmE9tnETYSKbI74A=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Don't update power_supply on power role" failed to apply to 5.15-stable tree
To: myrrhperiwinkle@qtmlabs.xyz,gregkh@linuxfoundation.org,senozhatsky@chromium.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Jun 2026 08:02:58 +0200
Message-ID: <2026060558-friend-nutty-d6c6@gregkh>
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
git cherry-pick -x d98d413ca65d0790a8f3695d0a5845538958ab84
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060558-friend-nutty-d6c6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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

