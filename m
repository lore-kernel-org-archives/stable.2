Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5873CF69F
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178907; cv=none; b=bCcOqfnR2ZyuNx9rcXf25EroaEmajnFEqniuU335YwejPjcNlSC1JEjUN62A/Xv4+ehXHRFSTr90JHiCv6VLajUrfSVjn3C6c5sMo8kQGRjf72lGZI80xIPvj1wvhx1O1iaAz7WIPKnK2y1YlTQLDgTRXNWHGSuSNc7NJjok/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178907; c=relaxed/simple;
	bh=R3tiitEgDHozyrEht0hDzkaLdZOqMVoamwaggfdPWAs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OVNVM4wvKWpW1HSRA+qn2WAKU+VFPS44gUpXqop6gH9MV4Hg65w2MktNno80rnixgA5Pg7joy5m82rfmUc6WtEEvWDtJ8p/w0C6MO5o19RMEbsdgU9IiCluu4DsNIeKaYZz07v8kqYGM+Op3bRdKYdHxEj16dZ1XvCRnNs15Aws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Idv1ciXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Idv1ciXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CA41F00A3F;
	Mon, 31 Aug 2026 12:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788178905;
	bh=TJIM3TLni7S3HEhTVOnUxDFnA1PIiYlVOi8C8SjzvPw=;
	h=Subject:To:Cc:From:Date;
	b=Idv1ciXpt8i3zCQJJIJi7N6239FjPbC8zIEhee2iJxugEf+DSXTN+n5NA0QVCRgbN
	 XBbSlXaRWny9mGLrrfqD4/98ILcLaKG13CkST+UqFsx7RHsORAXc8jMbrntGPGNSxd
	 sZoi95Bx6M4Y0aenF6+4R2WjE+/q1ZCrTEpXhByQ=
Subject: FAILED: patch "[PATCH] xhci: dbgtty: Fix unregister on tty_register_driver() failure" failed to apply to 5.10-stable tree
To: ldemarchi@nvidia.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:21:42 +0200
Message-ID: <2026083142-everyday-fifteen-2ae3@gregkh>
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
git cherry-pick -x a916fa66a43e10f63198b6ce978badffc678821a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083142-everyday-fifteen-2ae3@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a916fa66a43e10f63198b6ce978badffc678821a Mon Sep 17 00:00:00 2001
From: Lucas De Marchi <ldemarchi@nvidia.com>
Date: Thu, 6 Aug 2026 17:21:03 +0300
Subject: [PATCH] xhci: dbgtty: Fix unregister on tty_register_driver() failure

If tty_register_driver() fails, it drops the reference, but fails to set
the global dbc_tty_driver to NULL, causing the unregister to be called
again when module exits.

On module unload dbc_tty_exit() only gates its cleanup on the driver
pointer being non-NULL, so it operates on the already-freed driver:

    module_init(xhci_hcd_init)
      xhci_hcd_init()
        xhci_dbc_init()                       [return value ignored]
          dbc_tty_init()
            tty_register_driver() fails
              tty_driver_kref_put()           -> driver freed
              (dbc_tty_driver left dangling)
    ...
    module_exit(xhci_hcd_fini)
      xhci_hcd_fini()
        xhci_dbc_exit()
          dbc_tty_exit()
            if (dbc_tty_driver)               -> true (dangling)
              tty_unregister_driver()         -> use-after-free

Fixes: 4521f1613940 ("xhci: dbctty: split dbc tty driver registration and unregistration functions.")
Cc: stable@vger.kernel.org # v5.10
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lucas De Marchi <ldemarchi@nvidia.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20260806142113.2436238-8-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 2e7384c6b6ec..01decd46f313 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -651,6 +651,7 @@ int dbc_tty_init(void)
 		pr_err("Can't register dbc tty driver\n");
 		tty_driver_kref_put(dbc_tty_driver);
 		idr_destroy(&dbc_tty_minors);
+		dbc_tty_driver = NULL;
 	}
 
 	return ret;

