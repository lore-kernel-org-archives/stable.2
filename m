Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AEC3A5E99
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560774; cv=none; b=QUapoBOzrPREYnIy1OvmyfQsNJjY+bppZ6ZAdZiBqLD1VsWTmzFRgxPKt5uV9n9xZARxhhRnTdfzsVEvKhTBr+IrbUmBm0fdFCMm7VZlKadbFY90qCDf9kRKIgNfRTACeD4ViTmDleBhHTqG9plkiu05fEKzP2LlqlEn2a9xsBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560774; c=relaxed/simple;
	bh=DNBzfG/yabgazCPoxN9XauPy5CY2ECwXC009o1O6Qm0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FPI86gGzZMsctlHK9dEJ2C66UxpxBPEWtGG+Mmgf26qSL36rb15Z2P4HXW/myPhVhOqRPCfcUtCbXbE9kXJEtVkyF1NyiAnpcM6jfkeo2X6L4suLSu/5LaeVc/ok0TbOZDPHD81YltHYQd7K6BAH2fO6Zahu73U7RrFJIClvGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NZF+TDsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NZF+TDsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C661F00893;
	Thu,  4 Jun 2026 08:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780560773;
	bh=IrrPVKGpF1rTSizArlIf4btoV9TYWBaJ7eOP3Vi2fYM=;
	h=Subject:To:Cc:From:Date;
	b=NZF+TDsWQ/M2bZb1O8pRFf7WE1t7oadtgHGw1OzSigx+LbNG3eg+rbjpHQ9FprkRA
	 BMEV9q1ofNbz2zJexYXqDZozkj2UOnTxh2azReMzuzFYuJTvsRZi26a3DocncSwMR4
	 C4Mu444zR6kCgXXuLzpZUCXXzwTWeq+zymn8Q+N0=
Subject: FAILED: patch "[PATCH] USB: serial: cypress_m8: fix memory corruption with small" failed to apply to 6.1-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:11:38 +0200
Message-ID: <2026060438-hatless-purr-e73e@gregkh>
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
git cherry-pick -x e1a9d791fd66ab2431b9e6f6f835823809869047
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060438-hatless-purr-e73e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e1a9d791fd66ab2431b9e6f6f835823809869047 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 22 May 2026 12:16:21 +0200
Subject: [PATCH] USB: serial: cypress_m8: fix memory corruption with small
 endpoint

Make sure that the interrupt-out endpoint max packet size is at least
eight bytes to avoid user-controlled slab corruption or NULL-pointer
dereference should a malicious device report a smaller size.

Fixes: 3416eaa1f8f8 ("USB: cypress_m8: Packet format is separate from characteristic size")
Cc: stable@vger.kernel.org	# 2.6.26
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index afff1a0f4298..0b8a4e9d7bc5 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -445,6 +445,14 @@ static int cypress_generic_port_probe(struct usb_serial_port *port)
 		return -ENODEV;
 	}
 
+	/*
+	 * The buffer must be large enough for the one or two-byte header (and
+	 * following data), but assume anything smaller than eight bytes is
+	 * broken.
+	 */
+	if (port->interrupt_out_size < 8)
+		return -EINVAL;
+
 	priv = kzalloc_obj(struct cypress_private);
 	if (!priv)
 		return -ENOMEM;

