Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528038A734
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560770; cv=none; b=hm+iPBAFTPGwiEJHorFbnbG5Z3IK85m9eoUkVHSXrSyOa+F59Qik0biehuuYtCIRY7p4MkxUCMKK0uS6I2a8kG6J5f0ka5VqucHrkwPy0CxoUtu9/ZdOb0f5P1XAnJh3wfIiBvHYQImtuJ8yoVbx/lTZ0Drd7hb8FxL8UWsKPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560770; c=relaxed/simple;
	bh=zHaNH3RQpSuK9vKF2hgFrl70K/eEm+QFFAV61/+fTVM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sc7V6HfSp/45AcE1KW/htkwPipGIdeEotvIXBkWLqGmETjGEkP4U9fSJP2k2buzpsTBnZ7uZR9JrmZpKG/m+OlULYt8j62ojSsBchT09fUkk7IzUn268PmGRroA/J07XfvLUkNq6MZC5S13r+1+D1AiNrItgzDiHY/iVWqE/ooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mz4VVKG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mz4VVKG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B0C1F00893;
	Thu,  4 Jun 2026 08:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780560769;
	bh=//pQTaPEvWRR91QztzReCiHDQ4uFD5nCp9FybJYbyHU=;
	h=Subject:To:Cc:From:Date;
	b=mz4VVKG0sLyaW72l3tQgrDqbE3f7dvwWfrD6wX+gWwQP41IlNPs3zwpb7+ZrjVHBM
	 F53jvZ/LU/43F8oYRJiVqqP2x6IreI7lpjxpB8GmhUtcGIYnJFYD9cIQDJBzvKe45e
	 x/9d9WipugLCZpm3qgdF4Bq/CZF/3SNSpLFf82Aw=
Subject: FAILED: patch "[PATCH] USB: serial: cypress_m8: fix memory corruption with small" failed to apply to 5.15-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:11:38 +0200
Message-ID: <2026060438-armband-reissue-05b9@gregkh>
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
git cherry-pick -x e1a9d791fd66ab2431b9e6f6f835823809869047
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060438-armband-reissue-05b9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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

