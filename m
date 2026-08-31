Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F05F3B2FF8
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178921; cv=none; b=FE+9ZrcEXY81lBmIkTSQz28Pqf7CPgnody5Z2AJ5Nb7xFAY7i1VUQajeo6SdzX1HzBBelDXugYyPbvGDpfNHuXSrZtWqNS5yf+A7Is4NvFi0V1SMCn2HdZ/uD3QIB9E5dPVm+jdihKeRNxX/3Qd1N3mAgIQ19T7L9K45v0aVe+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178921; c=relaxed/simple;
	bh=eGYe7YzTLYTwWCExyGicASIN5RD4KCps2/ByjSa6C2o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Zsfq9/86PlkeLIWhv/a6ihSo2dkK5fVovJqmYfwrUC6W5sNPzxvr2UPo6wLQUbRGti23dZlq/s4wOjAS2eUkoR5FhsS2KcKmW7lu0u2Sbegx4G4WwH4SInPd2PjvEvm+YXPl01slwj8dFpNcX52WjDSh/Azz/br5KTjlGSttUN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ro4hI256; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ro4hI256"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3E51F000E9;
	Mon, 31 Aug 2026 12:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788178920;
	bh=dpoGvsurWeP0UYV6s8r0MffvqoiiC4MC1B+PTrGL3ag=;
	h=Subject:To:Cc:From:Date;
	b=ro4hI256zs4z9T/tQV9ZOGZYrMMH5TT2uhWGwELIz3rSBL40RfPRUS4UZD4iYKG1H
	 hNj8h85eCC+vvqAVs4OGBITyMqS+dTUCOfjkfw6P8AAFVaM8RqIxghWnfrOzdtym5F
	 ML74nhgrbtw+IZsSnmWyhkNUDdzbXaJEkam3BDjA=
Subject: FAILED: patch "[PATCH] xhci: dbgtty: Fix unregister on tty_alloc_driver() failure" failed to apply to 5.10-stable tree
To: ldemarchi@nvidia.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:21:56 +0200
Message-ID: <2026083156-mortally-bountiful-0375@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 25b8dfc13495a6c1cf4abacc8ef20196c7f20e5c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083156-mortally-bountiful-0375@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 25b8dfc13495a6c1cf4abacc8ef20196c7f20e5c Mon Sep 17 00:00:00 2001
From: Lucas De Marchi <ldemarchi@nvidia.com>
Date: Thu, 6 Aug 2026 17:21:04 +0300
Subject: [PATCH] xhci: dbgtty: Fix unregister on tty_alloc_driver() failure

Make sure to set dbc_tty_driver to NULL to match the check in
dbc_tty_exit(). For that, make detached error handling path common to the
other branch in the same function.

Fixes: 4521f1613940 ("xhci: dbctty: split dbc tty driver registration and unregistration functions.")
Cc: stable@vger.kernel.org # v5.10
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lucas De Marchi <ldemarchi@nvidia.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20260806142113.2436238-9-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 01decd46f313..7e44e62d6ea9 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -628,8 +628,8 @@ int dbc_tty_init(void)
 	dbc_tty_driver = tty_alloc_driver(64, TTY_DRIVER_REAL_RAW |
 					  TTY_DRIVER_DYNAMIC_DEV);
 	if (IS_ERR(dbc_tty_driver)) {
-		idr_destroy(&dbc_tty_minors);
-		return PTR_ERR(dbc_tty_driver);
+		ret = PTR_ERR(dbc_tty_driver);
+		goto fail;
 	}
 
 	dbc_tty_driver->driver_name = "dbc_serial";
@@ -649,11 +649,17 @@ int dbc_tty_init(void)
 	ret = tty_register_driver(dbc_tty_driver);
 	if (ret) {
 		pr_err("Can't register dbc tty driver\n");
-		tty_driver_kref_put(dbc_tty_driver);
-		idr_destroy(&dbc_tty_minors);
-		dbc_tty_driver = NULL;
+		goto fail_put;
 	}
 
+	return ret;
+
+fail_put:
+	tty_driver_kref_put(dbc_tty_driver);
+fail:
+	idr_destroy(&dbc_tty_minors);
+	dbc_tty_driver = NULL;
+
 	return ret;
 }
 

